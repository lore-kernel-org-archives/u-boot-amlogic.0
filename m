Received: by mail-wm1-f68.google.com with SMTP id c6so11468196wml.0
        for <u-boot-amlogic@groups.io>; Tue, 04 Jun 2019 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8HOwsjOJOuPm77Ygs8DcsnVrqS87Y80QHL/jbnXOMPM=;
        b=ITLWhWclwkzy6biveg7kiCaBW95iCT3skqwm6sdUR0TwDr0WwcO7e4QSc6UNBaYFvG
         3qnf+pQKmoh2fN8vxCgwZ/k98X8SRFLOysb4XJTu+ffdIH2d53h0CZA1x1qrRXUgcOyO
         npPeKOS7VnjgkRHklc8K9bK51rxg+trE9PL8NkfN9pAoYlNfaZNP6gh1ybl+ee/dPLma
         tHmG54FP9zxJTesqJCCyhVZX8C8jlBhgOxlwTP9EWV9k+wQCLM2tFW0ibrs7svQVmcxd
         mz1caZZuv6jtuFuQS7PaV+biPriEC4DX/vyaUSq2Lx5KXjZO+bKsLJH7UiTw4E2vtmF1
         2q2A==
Return-Path: <glaroque@baylibre.com>
From: "Guillaume La Roque" <glaroque@baylibre.com>
Subject: [PATCH 1/3] dm: pinctrl: Add driver-strength-microamp property
Date: Tue,  4 Jun 2019 13:53:06 +0200
Message-Id: <20190604115308.26510-2-glaroque@baylibre.com>
In-Reply-To: <20190604115308.26510-1-glaroque@baylibre.com>
References: <20190604115308.26510-1-glaroque@baylibre.com>
To: narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Add drive-strength-microamp property support to allow drive strength in uA

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 include/dm/pinctrl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dm/pinctrl.h b/include/dm/pinctrl.h
index e7b8ad9078..3eca34fbf7 100644
--- a/include/dm/pinctrl.h
+++ b/include/dm/pinctrl.h
@@ -225,6 +225,8 @@ struct pinctrl_ops {
  *	push-pull mode, the argument is ignored.
  * @PIN_CONFIG_DRIVE_STRENGTH: the pin will sink or source at most the current
  *	passed as argument. The argument is in mA.
+ * @PIN_CONFIG_DRIVE_STRENGTH_UA: the pin will sink or source at most the current
+ *	passed as argument. The argument is in uA.
  * @PIN_CONFIG_INPUT_DEBOUNCE: this will configure the pin to debounce mode,
  *	which means it will wait for signals to settle when reading inputs. The
  *	argument gives the debounce time in usecs. Setting the
@@ -281,6 +283,7 @@ enum pin_config_param {
 	PIN_CONFIG_DRIVE_OPEN_SOURCE,
 	PIN_CONFIG_DRIVE_PUSH_PULL,
 	PIN_CONFIG_DRIVE_STRENGTH,
+	PIN_CONFIG_DRIVE_STRENGTH_UA,
 	PIN_CONFIG_INPUT_DEBOUNCE,
 	PIN_CONFIG_INPUT_ENABLE,
 	PIN_CONFIG_INPUT_SCHMITT,
-- 
2.17.1

