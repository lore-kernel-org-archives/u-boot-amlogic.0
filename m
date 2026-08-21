Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FD8C61DC2
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:45 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3454.1787302329159273721
 for <u-boot-amlogic@groups.io>;
 Fri, 21 Aug 2026 01:52:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: tanurelinux@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b29599b81cso916901e87.1
        for <u-boot-amlogic@groups.io>; Fri, 21 Aug 2026 01:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302327; x=1787907127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HrPgnIHeq4cFyK/AEvCe99MeH0e/iWUMnbxmzeRgrQg=;
        b=hMKB7kypsNRTVHAc6MDuNrag4rqS2MfBmVCSbitJCXtXZr5cJDS6u+1ICRPvzwfNK2
         AC4dj2+4MeiEYpDkliw9T9BS4B/c7w/RVmsb9zKHv8OSPLOb5iKz4xL/HDA25NtsdFoI
         8HaR9bHuoYW8WGZ7BjFk7WBFNaK1KdcOGkmR1do66tUFB04n65mbAjnI1oLD7Rdjuua/
         zA0KTxABVM3nPqRLREJ6zany2r9R9a90Z6UJNN5jEBs/zgQz9JOT1zyZu3IlGFuvTgW5
         Obkh2ZOiXiRGvRSAfHKlm5tD2+LrhD1LVrcSw2T1FmDAPjvSp2NE10pt39l+YqaempCo
         U3xA==
X-Forwarded-Encrypted: i=1; AHgh+RoX0f3yhmolHAlzOILovpPkUbGj1um0EuI2W3Ugwvsvhl5XbMkILkb0KISC6urC0HdRcqNRi4+O9fjlhvqQ3Q==@groups.io
X-Gm-Message-State: AFuF++lNnMIxwG8n8e+tolS1v3X7MJy75gFQF9vPxupm+Hv3NCr9VbiG
	Ts397nutkZIc0f3d26LGch7o+dI43nBQeUdH3eLtjxLFaONy+Plx+VLLo0CrPA==
X-Gm-Gg: AR+sD12juVEzzIHZUIIMPA/icSstKaL6crTiBGupZY3abJCGWtiSR88Hmc0G4VlUzoE
	DsSHzrm2Ck5mcdiEnQkDGvMBepz+Ckg862Bpvk2hFGKkg77KqV7WMY/R4fmafjBWbcYiadDLnHJ
	w0hFIfCL5xCeRRWsfMTQ//GIq4hxPJ3Shb0bbInPnGT9dERabzngQT9if83rPEwi9+HVGployLz
	+EjtRu7ohQ/b6Wl54Q2scqwtqQrc8LXYNquuLXV7OqSurL7TjQqL4TM6IuDcpiBtxlWcfUSvvgy
	I454WKIpJcmFnuOW2cRN/3M+jM1XS+GLWYpZJlZuinNnfVKrjTnesvCLdgbZKZ5h+heLsMAlvWY
	9penQt1p0tr8iN/0qpU75bklx9pr9eL9lKcACg/i4l90hCRFA7UnNXKxJVES7QtS0RmG/PGcFJJ
	j5NPot0RnmGlEMQ/gZ79Aw8P/v4p8nqt4D2Sc/oPrUcO+tB8spPnz7iiuCJCCJ689GzqeV6HjHW
	iyS12XnkJcYgHmbcG688MCaT4Bf8MIxm+59gQ==
X-Received: by 2002:a05:600c:6211:b0:499:621a:2ec2 with SMTP id 5b1f17b1804b1-499b82e8e9dmr74210185e9.3.1787301968300;
        Fri, 21 Aug 2026 01:46:08 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90e747esm22978115e9.4.2026.08.21.01.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:46:07 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org,
	trini@konsulko.com,
	ilias.apalodimas@linaro.org,
	funderscore@postmasteros.org,
	u-boot-amlogic@groups.io
Subject: [PATCH v2 1/4] serial: meson: add Amlogic S4 UART support
Date: Fri, 21 Aug 2026 09:46:00 +0100
Message-ID: <20260821084603.25974-2-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084603.25974-1-tanure@linux.com>
References: <20260821084603.25974-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3049

The S4-generation UART (S4, T7, ...) derives its baud rate from the
24 MHz crystal divided by 2, selected via the XTAL_DIV2 bit in the
baud rate register, while older SoCs divide the crystal by 3. Add the
"amlogic,meson-s4-uart" compatible with driver data selecting the
div-by-2 scheme, matching the Linux driver (meson_s4_uart_data) and
the configuration the vendor BL2 programs on T7 hardware.

Older SoCs keep the existing div-by-3 behaviour: Linux also uses
div-by-2 on G12A, but both modes work there and switching would risk
regressing boards that have shipped with div-by-3 for years.

Also drain the transmitter before changing the baud rate so in-flight
characters are not garbled, as the Linux driver does.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/serial/serial_meson.c | 51 ++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
index cc71381f87e..d909fedcfc4 100644
--- a/drivers/serial/serial_meson.c
+++ b/drivers/serial/serial_meson.c
@@ -62,26 +62,49 @@ struct meson_serial_plat {
 #define AML_UART_REG5_USE_NEW_BAUD	BIT(23) /* default 1 (use new baud rate register) */
 #define AML_UART_REG5_BAUD_MASK		0x7fffff
 
+/* Driver data flags */
+#define MESON_UART_XTAL_DIV2	BIT(0)
+
 #if CONFIG_IS_ENABLED(DM_SERIAL)
-static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
+static u32 meson_uart_xtal_div(struct udevice *dev)
+{
+	/*
+	 * S4-generation UARTs (S4, T7, ...) derive the baud rate from the
+	 * crystal divided by 2, older ones divide by 3.
+	 */
+	return (dev_get_driver_data(dev) & MESON_UART_XTAL_DIV2) ? 2 : 3;
+}
+
+static u32 meson_calc_baud_divisor(struct udevice *dev, ulong src_rate, u32 baud)
 {
 	/*
 	 * Usually src_rate is 24 MHz (from crystal) as clock source for serial
-	 * device. Since 8 Mb/s is the maximum supported baud rate, use div by 3
-	 * to derive baud rate. This choice is used also in meson_serial_setbrg.
+	 * device. Since 8 Mb/s is the maximum supported baud rate, use a
+	 * divided crystal to derive the baud rate. This choice is used also in
+	 * meson_serial_setbrg.
 	 */
-	return DIV_ROUND_CLOSEST(src_rate / 3, baud) - 1;
+	return DIV_ROUND_CLOSEST(src_rate / meson_uart_xtal_div(dev), baud) - 1;
 }
 
-static void meson_serial_set_baud(struct meson_uart *uart, ulong src_rate, u32 baud)
+static void meson_serial_set_baud(struct udevice *dev, struct meson_uart *uart,
+				  ulong src_rate, u32 baud)
 {
 	/*
-	 * Set crystal divided by 3 (regardless of device tree clock property)
+	 * Set the divided crystal (regardless of device tree clock property)
 	 * as clock source and the corresponding divisor to approximate baud
 	 */
-	u32 divisor = meson_calc_baud_divisor(src_rate, baud);
+	u32 divisor = meson_calc_baud_divisor(dev, src_rate, baud);
 	u32 val = AML_UART_REG5_USE_XTAL_CLK | AML_UART_REG5_USE_NEW_BAUD |
 		(divisor & AML_UART_REG5_BAUD_MASK);
+
+	if (meson_uart_xtal_div(dev) == 2)
+		val |= AML_UART_REG5_XTAL_DIV2;
+
+	/* Drain the transmitter before changing the baud rate */
+	while ((readl(&uart->status) & (AML_UART_TX_EMPTY | AML_UART_XMIT_BUSY))
+	       != AML_UART_TX_EMPTY)
+		;
+
 	writel(val, &uart->reg5);
 }
 
@@ -109,7 +132,7 @@ static int meson_serial_probe(struct udevice *dev)
 		return ret;
 	ulong rate = clk_get_rate(&per_clk);
 
-	meson_serial_set_baud(uart, rate, CONFIG_BAUDRATE);
+	meson_serial_set_baud(dev, uart, rate, CONFIG_BAUDRATE);
 	meson_serial_init(uart);
 
 	return 0;
@@ -165,8 +188,9 @@ static int meson_serial_setbrg(struct udevice *dev, const int baud)
 {
 	/*
 	 * Change device baud rate if baud is reasonable (considering a 23 bit
-	 * counter with an 8 MHz clock input) and the actual baud
-	 * rate is within 2% of the requested value (2% is arbitrary).
+	 * counter with an 8 MHz, or 12 MHz for XTAL_DIV2 devices, clock input)
+	 * and the actual baud rate is within 2% of the requested value (2% is
+	 * arbitrary).
 	 */
 	if (baud < 1 || baud > 8000000)
 		return -EINVAL;
@@ -179,14 +203,14 @@ static int meson_serial_setbrg(struct udevice *dev, const int baud)
 	if (ret)
 		return ret;
 	ulong rate = clk_get_rate(&per_clk);
-	u32 divisor = meson_calc_baud_divisor(rate, baud);
-	u32 calc_baud = (rate / 3) / (divisor + 1);
+	u32 divisor = meson_calc_baud_divisor(dev, rate, baud);
+	u32 calc_baud = (rate / meson_uart_xtal_div(dev)) / (divisor + 1);
 	u32 calc_err = baud > calc_baud ? baud - calc_baud : calc_baud - baud;
 
 	if (((calc_err * 100) / baud) > 2)
 		return -EINVAL;
 
-	meson_serial_set_baud(uart, rate, baud);
+	meson_serial_set_baud(dev, uart, rate, baud);
 
 	return 0;
 }
@@ -244,6 +268,7 @@ static const struct udevice_id meson_serial_ids[] = {
 	{ .compatible = "amlogic,meson-uart" },
 	{ .compatible = "amlogic,meson-gx-uart" },
 	{ .compatible = "amlogic,meson-a1-uart" },
+	{ .compatible = "amlogic,meson-s4-uart", .data = MESON_UART_XTAL_DIV2 },
 	{ }
 };
 
-- 
2.55.0


