Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C108CAC587
	for <webhook@archiver.kernel.org>; Sun,  7 Sep 2025 14:36:39 +0000 (UTC)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
 by mx.groups.io with SMTP id smtpd.web11.19692.1757255795747565665
 for <u-boot-amlogic@groups.io>;
 Sun, 07 Sep 2025 07:36:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=HJTWPJGZ;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.170, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757255794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f81ZLJi7i1kCx4xWEENFQLjXrex7GbFROvXUx08+Vcs=;
	b=HJTWPJGZMAYDqznRMSlW0k20hG9chEq4vBIpnQ6HuXMjh0dO28mldi7aUqRCQeJvQYrz4j
	cN4/98nHEYTVrVcIl0z5HcW1VGE+xKW5thM4Tkhta10shOXVb2gm7GhQoWGotvb6UM/nbw
	9Z9GEzO1JdGFVCfHvL/Hg6uEfyY7y4DBJx4Icu4PYrXP5JRL6HvcNzmMqODc9mFxh0TTNH
	eSzraFCCnivHaiq8IiyZOE8T8RTyvwuH/+kBHu7Kr+AQeis3ordFOoou9a9g+BI2oqI+wI
	XFQrJHgPf4W1q4Y9vJ+E20jYAvoDlS459+v+0yrZ9/uOHQycuhQ8tML/k6r4Nw==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Sun, 07 Sep 2025 14:36:10 +0000
Subject: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
In-Reply-To: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4575;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=lCG06xwd7da4TnQcxwY7b3+K7rzJHltdsD/vBcbkDR4=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBovZhrjOvSgnZfL9kLhMuuvzz8q7svqzbzanDEx
 5AUuoTj0tCJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaL2YawAKCRCEr8vQ14ma
 A85aEACAUhwvgnylPm8l+xwWVNUF+gRdKn1tawZnYZ0L0qL92s6YWXKGgMt/q9WcudHC3Hc6xvE
 Z/43jwA9gjeqnrN/HNqHFzRiwTOA9bPXeCGch3ee7LeVHlqrTMxmmmvq+8Rq1ZQzSETl5ScokHS
 8kfa0jIBVrdJK7Taao3K/Fy52lERsjehpW2LO1m6jXN7Z14k2msxEh4HxWUlak/FmP9/EwWvofC
 NDRVntbu/8izClQNJDYyXsNGCJuOatRtwd/+qK1Yx3wtZLkb4vduE4XN9/lfua5RtA1LMqiwy1m
 ITyaDOma3VBN1cLLyZhb/jU9oTaIBBnfYvdQ40FXyYjjLyRmI+sePWsl3xtAjo3PupCLVJdOIOC
 l1twqOGWr7Kg4ZcSYoRUOL0m/FMJHb9xFAU4jLZ2FrvJ7oqPtzYDulIhOjp8dS8Z8UtBKoYX4kg
 AbBEPjhyzTORpY1CY4cYhchqKBW+glWizVpl/msIq6kk+o/4WDtw7lMEoyWlMoSgy8PtAfjCePw
 dkhuyWCmJidHUNmHR82kwtPUGvOadGFh4fgBc+lCPYJ0JA2WytKgfN/iWb2uI1pw/5BqLp2MUjQ
 HE5nbv8HgoA4J5VNUkC82IimOAhPI11yBE49AWX1CsK564WGL/risHDnh7wvCJay+dwA3Oeu3IU
 XKOQ3kyRoP8+Dag==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 07 Sep 2025 14:36:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2747

It is very limited and minimal, only implements putc/puts.
This minimal driver is intended to be used in SPL, and other
size-constrained situations.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 drivers/serial/serial.c       |   2 +
 drivers/serial/serial_meson.c | 112 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial.c b/drivers/serial/serial.c
index e10ca6eef768502ea32bf39a41ae2e3ccd168c66..c0b1eb3056181b95e1861f1ce08fcd82ff81eb71 100644
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
index bb79b9729579a661084425d6b3c5357da31dc3c0..981ea5e159062b7d13885325e17b833145281158 100644
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
@@ -51,6 +53,7 @@ struct meson_serial_plat {
 #define AML_UART_REG5_USE_NEW_BAUD	BIT(23) /* default 1 (use new baud rate register) */
 #define AML_UART_REG5_BAUD_MASK		0x7fffff
 
+#if CONFIG_IS_ENABLED(DM_SERIAL)
 static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
 {
 	/*
@@ -245,6 +248,113 @@ U_BOOT_DRIVER(serial_meson) = {
 	.plat_auto	= sizeof(struct meson_serial_plat),
 };
 
+DM_DRIVER_ALIAS(serial_meson, amlogic_meson_gx_uart);
+
+#else
+
+static int meson_serial_init(void)
+{
+	struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
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
+	struct meson_uart *uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
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
+	struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
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
+	struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
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
2.51.0


