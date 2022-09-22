Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web09.1313.1663865500348267299
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Sep 2022 09:51:50 -0700
Received: by mail-wr1-f53.google.com with SMTP id n15so9585516wrq.5
        for <u-boot-amlogic@groups.io>; Thu, 22 Sep 2022 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=swLG15CrXyRjB9OJeowvCsVacmogvkbO8sDPhJHnhns=;
        b=Jw3dAlpr9QVLN6qOTpvm+hyZHxLAvUUuSa2oAfCvC34FmyEl9x20NXWWzzQCAW+puH
         5yIyRKhUZppjDofYPDQR39JK7r/qklVOxaAAZurPPLWSwjLAHIqFCxs/2vDxlhy0oRoV
         K3xCpW1n6XbkxbiAXAAUOEnL2r2C2/kt0bwm9M0lb5Q0Lb2R5fBFt5cbV0a4ju9AZJuR
         EXHPmCxzeFlXHV4Z2ewWHF3QBdhQjQE9Y8y8jaKEEDOu+xFDEajGlMlV1akonlI8kaWT
         H3ahZ9BHqkMM0A6jesRsOeEs8RhmYknsgz1qofIszwNU4V3PHGjEg6xvkYPHdyfKn4RM
         b4IA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <e9c204ce-bdbb-89da-70b6-3ee721fe3cd7@linaro.org>
Date: Thu, 22 Sep 2022 18:51:47 +0200
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm: amlogic: add setbrg op to serial device
References: <20220918161701.572814-1-e.tomell@gmail.com>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20220918161701.572814-1-e.tomell@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, e.tomell@gmail.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

Sorry for the delay...

On 18/09/2022 18:17, Edoardo Tomelleri wrote:
> Implement setbrg in amlogic/meson serial device with driver model
> similar to how the meson_uart.c driver does it in Linux. Also
> configure (probe) the serial device with the new reg5 register.
> 
> Signed-off-by: Edoardo Tomelleri <e.tomell@gmail.com>
> ---
> 
>   drivers/serial/serial_meson.c | 70 +++++++++++++++++++++++++++++++++++
>   include/configs/meson64.h     |  7 ++++
>   2 files changed, 77 insertions(+)
> 
> diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
> index d69ec221..90c370cf 100644
> --- a/drivers/serial/serial_meson.c
> +++ b/drivers/serial/serial_meson.c
> @@ -7,9 +7,11 @@
>   #include <dm.h>
>   #include <errno.h>
>   #include <fdtdec.h>
> +#include <linux/kernel.h>
>   #include <linux/bitops.h>
>   #include <linux/compiler.h>
>   #include <serial.h>
> +#include <clk.h>
>   
>   struct meson_uart {
>   	u32 wfifo;
> @@ -17,6 +19,7 @@ struct meson_uart {
>   	u32 control;
>   	u32 status;
>   	u32 misc;
> +	u32 reg5; /* New baud control register */
>   };
>   
>   struct meson_serial_plat {
> @@ -42,6 +45,35 @@ struct meson_serial_plat {
>   #define AML_UART_RX_RST			BIT(23)
>   #define AML_UART_CLR_ERR		BIT(24)
>   
> +/* AML_UART_REG5 bits */
> +#define AML_UART_REG5_XTAL_DIV2		BIT(27)
> +#define AML_UART_REG5_XTAL_CLK_SEL	BIT(26) /* default 0 (div by 3), 1 for no div */
> +#define AML_UART_REG5_USE_XTAL_CLK	BIT(24) /* default 1 (use crystal as clock source) */
> +#define AML_UART_REG5_USE_NEW_BAUD	BIT(23) /* default 1 (use new baud rate register) */
> +#define AML_UART_REG5_BAUD_MASK		0x7fffff
> +
> +static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
> +{
> +	/*
> +	 * Usually src_rate is 24 MHz (from crystal) as clock source for serial
> +	 * device. Since 8 Mb/s is the maximum supported baud rate, use div by 3
> +	 * to derive baud rate. This choice is used also in meson_serial_setbrg.
> +	 */
> +	return DIV_ROUND_CLOSEST(src_rate / 3, baud) - 1;
> +}
> +
> +static void meson_serial_set_baud(struct meson_uart *uart, ulong src_rate, u32 baud)
> +{
> +	/*
> +	 * Set crystal divided by 3 (regardless of device tree clock property)
> +	 * as clock source and the corresponding divisor to approximate baud
> +	 */
> +	u32 divisor = meson_calc_baud_divisor(src_rate, baud);
> +	u32 val = AML_UART_REG5_USE_XTAL_CLK | AML_UART_REG5_USE_NEW_BAUD |
> +		(divisor & AML_UART_REG5_BAUD_MASK);
> +	writel(val, &uart->reg5);
> +}
> +
>   static void meson_serial_init(struct meson_uart *uart)
>   {
>   	u32 val;
> @@ -59,7 +91,14 @@ static int meson_serial_probe(struct udevice *dev)
>   {
>   	struct meson_serial_plat *plat = dev_get_plat(dev);
>   	struct meson_uart *const uart = plat->reg;
> +	struct clk per_clk;
> +	int ret = clk_get_by_name(dev, "baud", &per_clk);
> +
> +	if (ret)
> +		return ret;
> +	ulong rate = clk_get_rate(&per_clk);
>   
> +	meson_serial_set_baud(uart, rate, CONFIG_BAUDRATE);
>   	meson_serial_init(uart);
>   
>   	return 0;
> @@ -111,6 +150,36 @@ static int meson_serial_putc(struct udevice *dev, const char ch)
>   	return 0;
>   }
>   
> +static int meson_serial_setbrg(struct udevice *dev, const int baud)
> +{
> +	/*
> +	 * Change device baud rate if baud is reasonable (considering a 23 bit
> +	 * counter with an 8 MHz clock input) and the actual baud
> +	 * rate is within 2% of the requested value (2% is arbitrary).
> +	 */
> +	if (baud < 1 || baud > 8000000)
> +		return -EINVAL;
> +
> +	struct meson_serial_plat *const plat = dev_get_plat(dev);
> +	struct meson_uart *const uart = plat->reg;
> +	struct clk per_clk;
> +	int ret = clk_get_by_name(dev, "baud", &per_clk);
> +
> +	if (ret)
> +		return ret;
> +	ulong rate = clk_get_rate(&per_clk);
> +	u32 divisor = meson_calc_baud_divisor(rate, baud);
> +	u32 calc_baud = (rate / 3) / (divisor + 1);
> +	u32 calc_err = baud > calc_baud ? baud - calc_baud : calc_baud - baud;
> +
> +	if (((calc_err * 100) / baud) > 2)
> +		return -EINVAL;
> +
> +	meson_serial_set_baud(uart, rate, baud);
> +
> +	return 0;
> +}
> +
>   static int meson_serial_pending(struct udevice *dev, bool input)
>   {
>   	struct meson_serial_plat *plat = dev_get_plat(dev);
> @@ -154,6 +223,7 @@ static const struct dm_serial_ops meson_serial_ops = {
>   	.putc = meson_serial_putc,
>   	.pending = meson_serial_pending,
>   	.getc = meson_serial_getc,
> +	.setbrg = meson_serial_setbrg,
>   };
>   
>   static const struct udevice_id meson_serial_ids[] = {
> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index 196e58ed..01413a02 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -16,6 +16,13 @@
>   #define GICC_BASE			0xc4302000
>   #endif
>   
> +/* Serial drivers */
> +/* The following table includes the supported baudrates */
> +#define CONFIG_SYS_BAUDRATE_TABLE  \
> +	{300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200, \
> +		230400, 250000, 460800, 500000, 1000000, 2000000, 4000000, \
> +		8000000 }
> +
>   /* For splashscreen */
>   #ifdef CONFIG_DM_VIDEO
>   #define STDOUT_CFG "vidconsole,serial"

Looks good !

If someone can test it ? otherwise I'll take it for next release.

Neil
