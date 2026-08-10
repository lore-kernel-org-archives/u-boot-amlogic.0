Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A483CC5AD55
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 14:12:31 +0000 (UTC)
Received: from mta1.migadu.com (mta1.migadu.com [95.215.58.200])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30468.1786371144647703740
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Aug 2026 07:12:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=dD0+3ilc;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.200, mailfrom: funderscore@postmarketos.org)
X-Envelope-To: u-boot-amlogic@groups.io
DKIM-Signature: a=rsa-sha256; bh=7XbLZCsAOIqbZRXXdB9CkgHo93wmzQs8ym75tD9swfc=;
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786371142; v=1; x=1786975942;
 b=dD0+3ilcXSNmlLe4LORy9XjWPfpiN0lBHWTy7qWw3ReyoRH2hwHad4XIgf44R6bt4XgZ8E3c
 eadLRZtoqB+bnsQn4LuB9XJcjtc3BuVQG3o7jAITd992pUrftzUa7jhsLk+2RxuKKzG4fch8eh3
 FFGKu6uMkidRBCW1h3L9TAcqiOY4T0P/CbxqRvzxCfShhsavuLduyUpUy/RW+Q2ZXoDc6+dZ7el
 Z4w27msc6UrY1j8JFJuIactKCfmduTCY6gxfIKLUYB5W5ZhPFHAECm38vYMZp9T3j1rIvs90Tt4
 M2losQSnrBFzDdLDdnlw5UIjegp17uC3akOrqCiG/FDVg==
X-Envelope-To: u-boot-amlogic@groups.io
Received: from meli-email.org (160.90.43.132)
	by mta10.migadu.com with ESMTPS id 2c368b0935c02e49;
	Mon, 10 Aug 2026 14:12:12 +0000
X-Migadu-Scanner: mta10.migadu.com
Authentication-Results: mta10.migadu.com;
	none
Date: Mon, 10 Aug 2026 14:01:52 +0000
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, tanure@linux.com, u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org, funderscore@postmasteros.org, u-boot-amlogic@groups.io, Lucas Tanure <tanure@linux.com>
Subject: Re: [PATCH 1/4] serial: meson: add Amlogic S4 UART support
User-Agent: meli/0.8.13
References: <20260806101809.72526-1-tanure@linux.com> <20260806101809.72526-2-tanure@linux.com>
In-Reply-To: <20260806101809.72526-2-tanure@linux.com>
Message-ID: <tjk4ry.249pxi1g19ygb@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 10 Aug 2026 14:12:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3020

On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io" <tanure=linux.com@groups.io> wrote:
>The S4-generation UART (S4, T7, ...) derives its baud rate from the
>24 MHz crystal divided by 2, selected via the XTAL_DIV2 bit in the
>baud rate register, while older SoCs divide the crystal by 3. Add the
>"amlogic,meson-s4-uart" compatible with driver data selecting the
>div-by-2 scheme, matching the Linux driver (meson_s4_uart_data) and
>the configuration the vendor BL2 programs on T7 hardware.
>
>Older SoCs keep the existing div-by-3 behaviour: Linux also uses
>div-by-2 on G12A, but both modes work there and switching would risk
>regressing boards that have shipped with div-by-3 for years.
>
>Also drain the transmitter before changing the baud rate so in-flight
>characters are not garbled, as the Linux driver does.
>
>Assisted-by: Claude:claude-fable-5

As I understand it, LLM-assisted patches are not welcome in U-Boot right
now: https://lore.kernel.org/u-boot/20260515220758.GM1858239@bill-the-cat/

AFAIK there isn't an official AI policy yet, but it seems the concensus
on that matter is currently "please don't". Sorry.

>Signed-off-by: Lucas Tanure <tanure@linux.com>
>---
> drivers/serial/serial_meson.c | 51 ++++++++++++++++++++++++++---------
> 1 file changed, 38 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
>index cc71381f87e..d909fedcfc4 100644
>--- a/drivers/serial/serial_meson.c
>+++ b/drivers/serial/serial_meson.c
>@@ -62,26 +62,49 @@ struct meson_serial_plat {
> #define AML_UART_REG5_USE_NEW_BAUD	BIT(23) /* default 1 (use new baud rate register) */
> #define AML_UART_REG5_BAUD_MASK		0x7fffff
> 
>+/* Driver data flags */
>+#define MESON_UART_XTAL_DIV2	BIT(0)
>+
> #if CONFIG_IS_ENABLED(DM_SERIAL)
>-static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
>+static u32 meson_uart_xtal_div(struct udevice *dev)
>+{
>+	/*
>+	 * S4-generation UARTs (S4, T7, ...) derive the baud rate from the
>+	 * crystal divided by 2, older ones divide by 3.
>+	 */
>+	return (dev_get_driver_data(dev) & MESON_UART_XTAL_DIV2) ? 2 : 3;
>+}
>+
>+static u32 meson_calc_baud_divisor(struct udevice *dev, ulong src_rate, u32 baud)
> {
> 	/*
> 	 * Usually src_rate is 24 MHz (from crystal) as clock source for serial
>-	 * device. Since 8 Mb/s is the maximum supported baud rate, use div by 3
>-	 * to derive baud rate. This choice is used also in meson_serial_setbrg.
>+	 * device. Since 8 Mb/s is the maximum supported baud rate, use a
>+	 * divided crystal to derive the baud rate. This choice is used also in
>+	 * meson_serial_setbrg.
> 	 */
>-	return DIV_ROUND_CLOSEST(src_rate / 3, baud) - 1;
>+	return DIV_ROUND_CLOSEST(src_rate / meson_uart_xtal_div(dev), baud) - 1;
> }
> 
>-static void meson_serial_set_baud(struct meson_uart *uart, ulong src_rate, u32 baud)
>+static void meson_serial_set_baud(struct udevice *dev, struct meson_uart *uart,
>+				  ulong src_rate, u32 baud)
> {
> 	/*
>-	 * Set crystal divided by 3 (regardless of device tree clock property)
>+	 * Set the divided crystal (regardless of device tree clock property)
> 	 * as clock source and the corresponding divisor to approximate baud
> 	 */
>-	u32 divisor = meson_calc_baud_divisor(src_rate, baud);
>+	u32 divisor = meson_calc_baud_divisor(dev, src_rate, baud);
> 	u32 val = AML_UART_REG5_USE_XTAL_CLK | AML_UART_REG5_USE_NEW_BAUD |
> 		(divisor & AML_UART_REG5_BAUD_MASK);
>+
>+	if (meson_uart_xtal_div(dev) == 2)
>+		val |= AML_UART_REG5_XTAL_DIV2;
>+
>+	/* Drain the transmitter before changing the baud rate */
>+	while ((readl(&uart->status) & (AML_UART_TX_EMPTY | AML_UART_XMIT_BUSY))
>+	       != AML_UART_TX_EMPTY)
>+		;
>+
> 	writel(val, &uart->reg5);
> }
> 
>@@ -109,7 +132,7 @@ static int meson_serial_probe(struct udevice *dev)
> 		return ret;
> 	ulong rate = clk_get_rate(&per_clk);
> 
>-	meson_serial_set_baud(uart, rate, CONFIG_BAUDRATE);
>+	meson_serial_set_baud(dev, uart, rate, CONFIG_BAUDRATE);
> 	meson_serial_init(uart);
> 
> 	return 0;
>@@ -165,8 +188,9 @@ static int meson_serial_setbrg(struct udevice *dev, const int baud)
> {
> 	/*
> 	 * Change device baud rate if baud is reasonable (considering a 23 bit
>-	 * counter with an 8 MHz clock input) and the actual baud
>-	 * rate is within 2% of the requested value (2% is arbitrary).
>+	 * counter with an 8 MHz, or 12 MHz for XTAL_DIV2 devices, clock input)
>+	 * and the actual baud rate is within 2% of the requested value (2% is
>+	 * arbitrary).
> 	 */
> 	if (baud < 1 || baud > 8000000)
> 		return -EINVAL;
>@@ -179,14 +203,14 @@ static int meson_serial_setbrg(struct udevice *dev, const int baud)
> 	if (ret)
> 		return ret;
> 	ulong rate = clk_get_rate(&per_clk);
>-	u32 divisor = meson_calc_baud_divisor(rate, baud);
>-	u32 calc_baud = (rate / 3) / (divisor + 1);
>+	u32 divisor = meson_calc_baud_divisor(dev, rate, baud);
>+	u32 calc_baud = (rate / meson_uart_xtal_div(dev)) / (divisor + 1);
> 	u32 calc_err = baud > calc_baud ? baud - calc_baud : calc_baud - baud;
> 
> 	if (((calc_err * 100) / baud) > 2)
> 		return -EINVAL;
> 
>-	meson_serial_set_baud(uart, rate, baud);
>+	meson_serial_set_baud(dev, uart, rate, baud);
> 
> 	return 0;
> }
>@@ -244,6 +268,7 @@ static const struct udevice_id meson_serial_ids[] = {
> 	{ .compatible = "amlogic,meson-uart" },
> 	{ .compatible = "amlogic,meson-gx-uart" },
> 	{ .compatible = "amlogic,meson-a1-uart" },
>+	{ .compatible = "amlogic,meson-s4-uart", .data = MESON_UART_XTAL_DIV2 },
> 	{ }
> };
> 
>-- 
>2.55.0

Best regards,
Ferass

