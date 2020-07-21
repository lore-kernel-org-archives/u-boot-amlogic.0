Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web12.17056.1595331679197003161
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Jul 2020 04:41:20 -0700
Received: by mail-wm1-f66.google.com with SMTP id c80so2509953wme.0
        for <u-boot-amlogic@groups.io>; Tue, 21 Jul 2020 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ds5cOcEu9FvkN7eYM43ZfNSzVULz4hzxjrPNlzEDaTM=;
        b=fwjPPuHzgJC2wbZCwhkMJLiN3riTzfwvYZDKIaGJqkk21iv+3f1vXfBr1Oq1KOKb2w
         9PjDl+UlRgcXDdnqhprgnLFdTxLevNoCzIdYtIjuyuciPjsZDMq9V1sBau17uhdm3JSx
         xfa1MAOEaB+hwPfYlwTj8GxftZocOmtOKgIZpf54UKY8IjBBu6rwkksafXcLV2biEx6Z
         j24hXy3a7UqH/fKcFGSpLEGhgaBM6q3f6lWishWEiwhz/jzouORWXNVUNOdbO01/Auoc
         Ma5kORzVYyb5u0VHTAhgIGfcErJLFyCN4nRjyuO7CE2zmspykHmoH1RnRD9lwtPI4lj6
         Tt3Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] serial: meson: handle RX errors
Date: Tue, 21 Jul 2020 13:41:14 +0200
Message-Id: <20200721114114.1931-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

This checks and handles RX errors on the Amlogic UART controller
after experiencing errors on the Khadas VIM3 & VIM3L when UART AO A
lines are not connected.

When the RX line is not connected, the first byte is erroneous and breaks
the U-Boot autoboot, breaking automatic boot.

This checks and drops any erroneous RX byte on pending and getc callbacks
to avoid returning true to pending when an error byte is in the FIFO.

Fixes: bfcef28ae4 ("arm: add initial support for Amlogic Meson and ODROID-C2")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/serial/serial_meson.c | 43 +++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
index 439057b1b9..1b1725f6aa 100644
--- a/drivers/serial/serial_meson.c
+++ b/drivers/serial/serial_meson.c
@@ -65,14 +65,36 @@ static int meson_serial_probe(struct udevice *dev)
 	return 0;
 }
 
+static void meson_serial_rx_error(struct udevice *dev)
+{
+	struct meson_serial_platdata *plat = dev->platdata;
+	struct meson_uart *const uart = plat->reg;
+	u32 val = readl(&uart->control);
+
+	/* Clear error */
+	val |= AML_UART_CLR_ERR;
+	writel(val, &uart->control);
+	val &= ~AML_UART_CLR_ERR;
+	writel(val, &uart->control);
+
+	/* Remove spurious byte from fifo */
+	readl(&uart->rfifo);
+}
+
 static int meson_serial_getc(struct udevice *dev)
 {
 	struct meson_serial_platdata *plat = dev->platdata;
 	struct meson_uart *const uart = plat->reg;
+	uint32_t status = readl(&uart->status);
 
-	if (readl(&uart->status) & AML_UART_RX_EMPTY)
+	if (status & AML_UART_RX_EMPTY)
 		return -EAGAIN;
 
+	if (status & AML_UART_ERR) {
+		meson_serial_rx_error(dev);
+		return -EIO;
+	}
+
 	return readl(&uart->rfifo) & 0xff;
 }
 
@@ -95,10 +117,23 @@ static int meson_serial_pending(struct udevice *dev, bool input)
 	struct meson_uart *const uart = plat->reg;
 	uint32_t status = readl(&uart->status);
 
-	if (input)
-		return !(status & AML_UART_RX_EMPTY);
-	else
+	if (input) {
+		if (status & AML_UART_RX_EMPTY)
+			return false;
+
+		/*
+		 * Handle and drop any RX error here to avoid
+		 * returning true here when an error byte is in the FIFO
+		 */
+		if (status & AML_UART_ERR) {
+			meson_serial_rx_error(dev);
+			return false;
+		}
+
+		return true;
+	} else {
 		return !(status & AML_UART_TX_FULL);
+	}
 }
 
 static int meson_serial_ofdata_to_platdata(struct udevice *dev)
-- 
2.22.0

