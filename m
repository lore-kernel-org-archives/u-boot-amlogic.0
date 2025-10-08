Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B7CCD186
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 10:01:04 +0000 (UTC)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
 by mx.groups.io with SMTP id smtpd.web11.12041.1759917659478735449
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Oct 2025 03:00:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=Fm8WOIQ8;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.170, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1759917657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XNZk+gqVCpX+0OEHULwL+ruegHnupNFCVM6oMUyAZfw=;
	b=Fm8WOIQ8r+RXquALf0xyYFcRV+4X43ETxO4c0wKsHovOdYDdHO0YkwvB4X3OmusDigh+p5
	t+VyaAwRN9+q2m9PS6bZuH4Y+wG03hAU2e9XeObbr8l2ar/CoGaSJeuNljmGsUjzNizk0l
	inYgXs3rzSk7aXOGapEKOp44BKLbXFdyG4ytxGbLZmNdIBqtL8cyT7KFbOwm64rdO5ipcU
	QeQS/A705ww3Cp0b1+GGf35DLewcUyjOPj4yD6t1Et53YBvUuCexI4jfWhbuOtgqFCljNN
	6ygASb3u43slyx9np6vKIzKohmakWnpRMj2WG+pXZ1uGIxOX21UTdlFeZ56VDA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Oct 2025 10:00:39 +0000
Subject: [PATCH RFC v3 3/8] serial: serial_meson: add minimal non-DM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-spl-gx-v3-3-5999637df4b9@postmarketos.org>
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
In-Reply-To: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4861;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=XF20V45WQmwjAJB6TnWBXXcWat9R+MUkrpX/lvBdfpE=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo5jZTFCD53tpibH5nGqj1s4aGKWIlX6z40PiX2
 5YD1XOrPvmJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaOY2UwAKCRCEr8vQ14ma
 AwMMEACTCKVtml8PjYT4PNpS2YJB9EFc5nSXVybF1WWCG+p7kfTwaFETud1+LlqiSWVl7/E4KJ/
 fp2/OI9qxUMymuhKMS0U8cZ1egxJAA9h5NJCxKtIBbYnEQUXWsAOaxMP+6cxx7IcGRjl1dyW7do
 EHG2qnZiu9dEsm2o4q5LzJWz+mGo2TR+cUqSpLSXwBDkj5qFBAft1HUdt3L0ABeh3E9DEebh6Ux
 Gxc0OmtMmnWDToLWApSuXZUNEVNg5g7Hm3RL7abHC3OJVTONLQA+d1lwhpZ8hMSFXwyBKyijWR7
 4WHAFbNZRfB646K2qZP9h+KhMAHVsKcPdEiTdgpRgr+cPt/g2BYDlyeCf5fdNYmZGs0R+6el+V2
 Tlm56E4B7g5uxg2GIfxCMTuHM5xwBcI7GOT4WD0aRGfYs/KnJTd6TGlAB74flVzFtOlfso+42fE
 UglwGG+A4C4a5SBL6KBmAst/AUHjC22y1eqEgCyp+zQG8e7OF5Ggo9hFXVdOgYERFxgVdViggYg
 m1Q1q1OJI6cWw/dkOA/7UVHykCKzCBRSZKCzAF1X0iAG5nN5smIHqbwQpGZ/akr6CzqOhYfLxmi
 3G0UrUuAMHe0SMTETKX3iPuaQmKDwgS9GEfbWC62NMhnZY6t8eyI3PPldUVjQ7aFZ0VdqP6rfwU
 XX3mvn8CkaF2mGA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Oct 2025 10:01:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2792

It is very limited and minimal, only implements putc/puts.
This minimal driver is intended to be used in SPL, and other
size-constrained situations.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 drivers/serial/serial.c       |   2 +
 drivers/serial/serial_meson.c | 119 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 1 deletion(-)

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
index bb79b9729579a661084425d6b3c5357da31dc3c0..cc71381f87e1e2d192e5f4450f881c2a69511ca3 100644
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
2.51.0


