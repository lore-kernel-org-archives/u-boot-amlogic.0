Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web12.140.1610687897467745663
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Jan 2021 21:18:17 -0800
Received: by mail-pl1-f171.google.com with SMTP id x12so4097222plr.10
        for <u-boot-amlogic@groups.io>; Thu, 14 Jan 2021 21:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iPuiZBehTmHHwXUwvNEDdudVqHvYbiPvSiePkJ1MJ+4=;
        b=bR9YDdI5O6ldceCmLlmJWszVw1X03642extv9fKpsgaW5DWBQ/ansKA+n4E8o4lNZd
         IRHo3ba3ZHKFZFLzahaRQNydf/f8srvEYrn9ua1FApGc57mEdcYZVzNll8TQSel9WpTQ
         FUEfZKFq1UTAoatwQEABNSDXxu8rg1oK36ykUWWQRDH7RTb8cU2KTj6SrVa16V2bB0mA
         B7CxJW5zUgL5E/evLgJqS4hSEuhCR7/EkHZrs4Hr/EWIgeAH9gTJKqy0yJSwPZ1Ezm4n
         rw8vUVp4/Mt7LTN5xht9mQn5vcBUKpr1Ty35Y9e5iR4oknJ3Sn6ZwABmPCBa9JzSj2l4
         1vYQ==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH 1/2] gpio: gpio-uclass: add OPEN_DRAIN flag parsing
Date: Fri, 15 Jan 2021 13:15:57 +0800
Message-Id: <20210115051558.469734-2-art@khadas.com>
In-Reply-To: <20210115051558.469734-1-art@khadas.com>
References: <20210115051558.469734-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: narmstrong@baylibre.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, m.szyprowski@samsung.com, jh80.chung@samsung.com, hs@denx.de, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

add GPIOD_OPEN_DRAIN flag which cant parsed properly

Problem: for example cant power video system for sm1 g12a socs
because OPEN_DRAIN flag cant parsed

DTS examples:

```
$ grep GPIO_OPEN_DRAIN\>  arch/arm/dts/meson-*.dt*
arch/arm/dts/meson-g12a-sei510.dts:		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
arch/arm/dts/meson-g12a-u200.dts:		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
arch/arm/dts/meson-gx-libretech-pc.dtsi:	gpio = <&gpio GPIOH_3 GPIO_OPEN_DRAIN>;
arch/arm/dts/meson-khadas-vim3.dtsi:		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
arch/arm/dts/meson-sm1-sei610.dts:		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
```

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 drivers/gpio/gpio-uclass.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index bad6b71e0c..6225f32457 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -574,6 +574,15 @@ int dm_gpio_set_value(const struct gpio_desc *desc, int value)
 	if (ret)
 		return ret;
 
+	if (desc->flags & GPIOD_OPEN_DRAIN) {
+		if (value)
+			gpio_get_ops(desc->dev)->direction_input(desc->dev, desc->offset);
+		else
+			gpio_get_ops(desc->dev)->direction_output(desc->dev, desc->offset, 0);
+
+		return 0;
+	}
+
 	if (desc->flags & GPIOD_ACTIVE_LOW)
 		value = !value;
 
-- 
2.25.1

