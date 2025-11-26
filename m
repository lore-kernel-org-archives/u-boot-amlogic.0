Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D14ED10F2B
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 12:17:45 +0000 (UTC)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11788.1764159456685692535
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Nov 2025 04:17:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=S89S+q8z;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.189, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1764159454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAD7QP/4I5IdkuVeN3KvcpRpNsVk/n4EAUkXu7L9gyY=;
	b=S89S+q8zEk2PYKFmy3qLuNLqWJ14E5p2nbf/Z+wJzzmD1BzcdKZxpLbw0iArOwWzdzfS5d
	7BWiRU5RAVmjW9Ix/d0PV/U8IJNGSOaJlKO/eHkEjrIP1YhiJ6t3rMWs7Cs561rteYDotM
	l5JiSBHNM+kxf5j1L8Who3x6/CKZDRtIWOStCZg1Lo/PiljEgA8vIAXTbG70YMjXRxwMfh
	L049UZhUTTI6d66SUByvDk6ZOkfAER5JHKtck1MCPLoye9xKIeIws2kZtqBy0emjUhxo/B
	NKNTKp7CUapVb6UK/LNz/5o0PFyAxFDx39gJRFoaEkkYjjDTJib3kMUYaqmgsQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 26 Nov 2025 12:17:05 +0000
Subject: [PATCH v5 03/10] serial: serial_meson: add minimal non-DM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-spl-gx-v5-3-6cbffb2451ca@postmarketos.org>
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
In-Reply-To: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4802;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=xkk9Q5RIo13bzB5He5lBndoT9V0UyuHWbyNMo5H0T0c=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpJu/XlIRhKHuWw+BDfSrSqGeYai1mECLNIURFs
 2meuiKKlqKJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaSbv1wAKCRCEr8vQ14ma
 A2foD/4wWkWTM7yGF+MdEI4W5ikhlceTwldN1AK4Fnj1mNhmqsI/N02b2R6cPoF9K8nQlO8AOni
 mMDd7HWxZTJggmMeWIkIbTGgDRk+C83/QMhgiA8opNl7EJHrhGtYzJhlb65H33eN44x+9WzpVCX
 6vOStD68obn7z7FYfshZA6/01cksPlO2PWA/sTp8mcrni+KmYwmnHniEsH1zaMdP1Drl6KwaYSX
 EiODj3kDBE3FVaz3xN0pz0s6yV3vm839NIOxtWWHP0DewKoJPgMmn8KHJSc3bIlNdL5CHaWIm/u
 H/xfoI+11c/Y2Xis3NA3EySa4jk6ohoWwpXbF35sDIU11i1Tg7L3rVch9CMDQ6+Fq0zLMaNjmpw
 aaj/6du1fEtH1Wijf0Db8nhybi9YK7OYw4IqDW19OPlTy0gXUELb8Je2rUSVZsnSziks8Cw6v2K
 Nah3qC8X9NnvtsLKobvjCVg6zhyIflW9zphCFas0Vwqnzx4jSsYJ7RsmKQOKuHLPvfufU6LSLtf
 wNCu9iVeKT8c/zHBa0AvrFwsi5gKDCsEAVDcCUshnDFmpPWVhQsgYnq6XaLd4+//kwoXE9rrwFK
 lpE82BEfga4zZ1hcGh0k3IBXcHPHRk/GyJ59L0+p5U31iV4zLVA/ec9JCmpQMfvE5rbsxLXFwCd
 O9gLXYONnsBBpqg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Nov 2025 12:17:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2854

It is very limited and minimal, only implements putc/puts.
This minimal driver is intended to be used in SPL, and other
size-constrained situations.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 drivers/serial/serial.c       |   2 +
 drivers/serial/serial_meson.c | 119 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial.c b/drivers/serial/serial.c
index e10ca6eef76..c0b1eb30561 100644
--- a/drivers/serial/serial.c
+++ b/drivers/serial/serial.c
@@ -129,6 +129,7 @@ serial_initfunc(pxa_serial_initialize);
 serial_initfunc(smh_serial_initialize);
 serial_initfunc(sh_serial_initialize);
 serial_initfunc(mtk_serial_initialize);
+serial_initfunc(meson_serial_initialize);
 
 /**
  * serial_register() - Register serial driver with serial driver core
@@ -167,6 +168,7 @@ int serial_initialize(void)
 	smh_serial_initialize();
 	sh_serial_initialize();
 	mtk_serial_initialize();
+	meson_serial_initialize();
 
 	serial_assign(default_serial_console()->name);
 
diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
index bb79b972957..cc71381f87e 100644
--- a/drivers/serial/serial_meson.c
+++ b/drivers/serial/serial_meson.c
@@ -3,9 +3,11 @@
  * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
  */
 
+#if CONFIG_IS_ENABLED(DM_SERIAL)
 #include <dm.h>
-#include <errno.h>
 #include <fdtdec.h>
+#endif
+#include <errno.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
@@ -25,6 +27,15 @@ struct meson_serial_plat {
 	struct meson_uart *reg;
 };
 
+#if !CONFIG_IS_ENABLED(DM_SERIAL)
+/* UART base address */
+#if defined(CONFIG_MESON_GX)
+#define AML_UART_BASE	0xc81004c0
+#else /* G12A, AXG, ... */
+#define AML_UART_BASE	0xff803000
+#endif
+#endif
+
 /* AML_UART_STATUS bits */
 #define AML_UART_PARITY_ERR		BIT(16)
 #define AML_UART_FRAME_ERR		BIT(17)
@@ -51,6 +62,7 @@ struct meson_serial_plat {
 #define AML_UART_REG5_USE_NEW_BAUD	BIT(23) /* default 1 (use new baud rate register) */
 #define AML_UART_REG5_BAUD_MASK		0x7fffff
 
+#if CONFIG_IS_ENABLED(DM_SERIAL)
 static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
 {
 	/*
@@ -245,6 +257,111 @@ U_BOOT_DRIVER(serial_meson) = {
 	.plat_auto	= sizeof(struct meson_serial_plat),
 };
 
+#else
+
+static int meson_serial_init(void)
+{
+	struct meson_uart *const uart = (struct meson_uart *)AML_UART_BASE;
+	u32 val;
+
+	val = readl(&uart->control);
+	val |= (AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
+	writel(val, &uart->control);
+	val &= ~(AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
+	writel(val, &uart->control);
+	val |= (AML_UART_RX_EN | AML_UART_TX_EN);
+	writel(val, &uart->control);
+
+	return 0;
+}
+
+static int meson_serial_stop(void)
+{
+	return 0;
+}
+
+static void meson_serial_setbrg(void)
+{
+}
+
+static void meson_serial_putc(const char ch)
+{
+	struct meson_uart *uart = (struct meson_uart *)AML_UART_BASE;
+
+	/* On '\n' also do '\r' */
+	if (ch == '\n')
+		meson_serial_putc('\r');
+
+	while (readl(&uart->status) & AML_UART_TX_FULL)
+		;
+
+	writel(ch, &uart->wfifo);
+}
+
+static void meson_serial_puts(const char *s)
+{
+	while (*s)
+		meson_serial_putc(*s++);
+}
+
+static int meson_serial_getc(void)
+{
+	struct meson_uart *const uart = (struct meson_uart *)AML_UART_BASE;
+	uint32_t status = readl(&uart->status);
+
+	if (status & AML_UART_RX_EMPTY)
+		return -EAGAIN;
+
+	if (status & AML_UART_ERR) {
+		u32 val = readl(&uart->control);
+
+		/* Clear error */
+		val |= AML_UART_CLR_ERR;
+		writel(val, &uart->control);
+		val &= ~AML_UART_CLR_ERR;
+		writel(val, &uart->control);
+
+		/* Remove spurious byte from fifo */
+		readl(&uart->rfifo);
+		return -EIO;
+	}
+
+	return readl(&uart->rfifo) & 0xff;
+}
+
+static int meson_serial_tstc(void)
+{
+	struct meson_uart *const uart = (struct meson_uart *)AML_UART_BASE;
+	uint32_t status = readl(&uart->status);
+
+	if (status & AML_UART_RX_EMPTY)
+		return 0;
+	return 1;
+}
+
+struct serial_device meson_serial_device = {
+	.name	= "meson_serial",
+	.start	= meson_serial_init,
+	.stop	= meson_serial_stop,
+	.setbrg	= meson_serial_setbrg,
+	.getc	= meson_serial_getc,
+	.tstc	= meson_serial_tstc,
+	.putc	= meson_serial_putc,
+	.puts	= meson_serial_puts,
+};
+
+void meson_serial_initialize(void)
+{
+	serial_register(&meson_serial_device);
+}
+
+__weak struct serial_device *default_serial_console(void)
+{
+	return &meson_serial_device;
+}
+
+#endif
+
 #ifdef CONFIG_DEBUG_UART_MESON
 
 #include <debug_uart.h>

-- 
2.51.2


