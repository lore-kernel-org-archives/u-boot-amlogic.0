Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web08.865.1607971729047631330
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 10:48:49 -0800
Received: by mail-wr1-f66.google.com with SMTP id a12so17470126wrv.8
        for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 10:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dx502HDgLzmESahp46hynNDArHx8ujowYLyxbglAUaA=;
        b=007ygvUJNjjX6hOmgLvs6FLxpPNHnXi67frvwEjTOqzMJEoJjY/WsrHTVUocF+dr0i
         WovX1TJEOY5fFnr8DrW9/1JdoXThIW2pqLzpc91cd3vlo0HesR8RkQZrP7mH76i414om
         pZBzhCpXB0EPQi5xE4j2Szr+hjQg/0wf6fkqXFXTgsyNcO+1tjmfVcqkf2khEsxlfC7W
         gmnl7jwqZDWDYTFV9soBn0s/R+ZQxSf/ObPThPGFyBtAy+MAldHJb7EloLM6KeQbyaxt
         FjnYpsZGAwBW0cMIzx8L6MvGhMR61oKZj0wFj5QL3rAfJya0GvBAsvOJ2cKaptjiGxpl
         YilA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] pinctrl: meson: fix bit manipulation of pin bias configuration
Date: Mon, 14 Dec 2020 19:48:41 +0100
Message-Id: <20201214184841.237356-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Anton Arapov <arapov@gmail.com>, Otto Meier <gf435@gmx.net>
List-ID: <u-boot-amlogic@groups.io>

This fixes the wrong usage of clrsetbits_le32(), badly setting the set argument.

Fixes: c4c726c26b ("pinctrl: meson: add pinconf support")
Reported-by: Anton Arapov <arapov@gmail.com>
Reported-by: Otto Meier <gf435@gmx.net>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Hi Anton, Otto,

This should fix eMMC booting on Odroid-C2, could you have a quick try to confirm ?

Thanks,
Neil

 drivers/pinctrl/meson/pinctrl-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index d4539b02d8..5065b62436 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -216,13 +216,13 @@ static int meson_pinconf_bias_set(struct udevice *dev, unsigned int pin,
 	}
 
 	/* othewise, enable the bias and select level */
-	clrsetbits_le32(priv->reg_pullen + reg, BIT(bit), 1);
+	clrsetbits_le32(priv->reg_pullen + reg, BIT(bit), BIT(bit));
 	ret = meson_gpio_calc_reg_and_bit(dev, offset, REG_PULL, &reg, &bit);
 	if (ret)
 		return ret;
 
 	clrsetbits_le32(priv->reg_pull + reg, BIT(bit),
-			param == PIN_CONFIG_BIAS_PULL_UP);
+			(param == PIN_CONFIG_BIAS_PULL_UP ? BIT(bit) : 0));
 
 	return 0;
 }
-- 
2.25.1

