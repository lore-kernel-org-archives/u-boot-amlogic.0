Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.2406.1588147604189258857
 for <u-boot-amlogic@groups.io>;
 Wed, 29 Apr 2020 01:06:45 -0700
Received: by mail-wr1-f68.google.com with SMTP id t14so1296141wrw.12
        for <u-boot-amlogic@groups.io>; Wed, 29 Apr 2020 01:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ycP8DMFeRohxih1xBQHFPuhM6lz5P7eCVYkycIYce0U=;
        b=vouARiS7pJdBUStI07D0hqZUmCUy1F9dxvMp5AwJZxzZuMMN54UNlcQb9a2ORM4pWY
         1YzVuoR9g48JXuFckww4ucm1qDVYoTJk7ZB4u269VOE3x0j1HVg0vp95dnrDVw4AF3Wu
         abSYEnePQ0LZ0v/ZKYTMBNOcJEYVGNpLXhMy1A4SiSfKWIbr8jjGLITuTJW3ixEALRcO
         LfqZ8fTXTXokvtQdRRNGTioh5PXAwZemWGCXDkvQi6GTKkJd7Ghg8KnX30DQ6oEIslSs
         PBJK4wJIgkzvSM++XI63LZw5EpbJV2xWy28vT9G83lzrCZFCByf5pAec/jWf1+5nZ25P
         oWXw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] gpio: emulate open drain & open source in dm_gpio_set_value()
Date: Wed, 29 Apr 2020 10:06:34 +0200
Message-Id: <20200429080634.355-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: sjg@chromium.org, patrick.delaunay@st.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Handle the GPIOD_OPEN_DRAIN & GPIOD_OPEN_SOURCE flags to emulate open drain
and open source by setting the GPIO line as input depending on the
requested value.

The behaviour is taken from the Linux gpiolib.

It notably permits enabling a GPIO regulator used as Open Drain on the
Amlogic G12A/g12B/SM1 platforms for HDMI output feature.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpio/gpio-uclass.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 757ab7106e..6b82d02a4d 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -524,8 +524,21 @@ int dm_gpio_set_value(const struct gpio_desc *desc, int value)
 	if (ret)
 		return ret;
 
+	/*
+	 * Emulate open drain by not actively driving the line high or
+	 * Emulate open source by not actively driving the line low
+	 */
+	if ((desc->flags & GPIOD_OPEN_DRAIN && value) ||
+	    (desc->flags & GPIOD_OPEN_SOURCE && !value))
+		return gpio_get_ops(desc->dev)->direction_input(desc->dev,
+								desc->offset);
+	else if ((desc->flags & (GPIOD_OPEN_DRAIN | GPIOD_OPEN_SOURCE))
+		goto set_output_value;
+
 	if (desc->flags & GPIOD_ACTIVE_LOW)
 		value = !value;
+
+set_output_value:
 	gpio_get_ops(desc->dev)->set_value(desc->dev, desc->offset, value);
 	return 0;
 }
-- 
2.22.0

