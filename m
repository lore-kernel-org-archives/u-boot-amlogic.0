Received: by mail-wr1-f67.google.com with SMTP id g3so33151278wrx.9
        for <u-boot-amlogic@groups.io>; Wed, 17 Apr 2019 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JgF3JY07Cum/JNf9dS16FQBBTYC+LyYKixfbB4y6wQQ=;
        b=vAgektiDAxwh65kmAHoHdZjFybB8kBuczCSmXvGaciVeD0x40+hIeIQpLqGEPT5YGP
         31WINxo8nGn5hSlqag33B9kd0QJpM9CMzTaFUCU4pDXt7Jy2qsbYycKiNzj8gs1PYOqB
         lBaKv+6kXzSNiiIKIjzuablOsiNa9gM8GYzlltpU7VtODp8HJ5FQAIN2qw0OGPNzMCqk
         lbSMnqJKrlst6Tc9cac5VVZvVwxcluBOnGM1e8hD4zsy89yMZSWKx9gy2LBhW4yA1Tgn
         YyN/Am6U7tl8Bn9Js3JSO2rupEh/UZm0m+IXyXwBtMHjh2c4da825Yo2WlXVKR3TlvWv
         T9Uw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2] regmap: fix regmap_read_poll_timeout warning about sandbox_timer_add_offset
Date: Wed, 17 Apr 2019 20:17:14 +0200
Message-Id: <20190417181714.1281-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

When fixing sandbox test for regmap_read_poll_timeout(), the
sandbox_timer_add_offset was introduced but only defined in sandbox code
thus generating warnings when used out of sandbox :

include/regmap.h:289:2: note: in expansion of macro 'regmap_read_poll_timeout_test'
regmap_read_poll_timeout_test(map, addr, val, cond, sleep_us, \
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/spi/meson_spifc.c:169:8: note: in expansion of macro 'regmap_read_poll_timeout'
ret = regmap_read_poll_timeout(spifc->regmap, REG_SLAVE, data,
        ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/spi/meson_spifc.c: In function 'meson_spifc_txrx':
include/regmap.h:277:4: warning: implicit declaration of function 'sandbox_timer_add_offset' [-Wimplicit-function-declaration]

This fix renames the sandbox_timer_add_offset() to a generic timer_test_add_offset()
function defined in time.h and renames the implementation and test usages.

Cc: Simon Glass <sjg@chromium.org>
Reported-by: Tom Rini <trini@konsulko.com>
Fixes: df9cf1cc08 ("test: dm: regmap: Fix the long test delay")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/sandbox/include/asm/test.h | 8 --------
 board/sandbox/sandbox.c         | 2 +-
 drivers/net/sandbox.c           | 2 +-
 drivers/timer/sandbox_timer.c   | 2 +-
 include/regmap.h                | 2 +-
 include/time.h                  | 8 ++++++++
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index fc52f47f82..e956a05262 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -59,14 +59,6 @@ void sandbox_i2c_eeprom_set_test_mode(struct udevice *dev,
 
 void sandbox_i2c_eeprom_set_offset_len(struct udevice *dev, int offset_len);
 
-/*
- * sandbox_timer_add_offset()
- *
- * Allow tests to add to the time reported through lib/time.c functions
- * offset: number of milliseconds to advance the system time
- */
-void sandbox_timer_add_offset(unsigned long offset);
-
 /**
  * sandbox_i2c_rtc_set_offset() - set the time offset from system/base time
  *
diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index 397e7561d4..9ca1eca027 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -31,7 +31,7 @@ void flush_cache(unsigned long start, unsigned long size)
 /* system timer offset in ms */
 static unsigned long sandbox_timer_offset;
 
-void sandbox_timer_add_offset(unsigned long offset)
+void timer_test_add_offset(unsigned long offset)
 {
 	sandbox_timer_offset += offset;
 }
diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
index decce2fa59..c136392350 100644
--- a/drivers/net/sandbox.c
+++ b/drivers/net/sandbox.c
@@ -350,7 +350,7 @@ static int sb_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	struct eth_sandbox_priv *priv = dev_get_priv(dev);
 
 	if (skip_timeout) {
-		sandbox_timer_add_offset(11000UL);
+		timer_test_add_offset(11000UL);
 		skip_timeout = false;
 	}
 
diff --git a/drivers/timer/sandbox_timer.c b/drivers/timer/sandbox_timer.c
index 6d2b045fe8..5228486082 100644
--- a/drivers/timer/sandbox_timer.c
+++ b/drivers/timer/sandbox_timer.c
@@ -14,7 +14,7 @@
 /* system timer offset in ms */
 static unsigned long sandbox_timer_offset;
 
-void sandbox_timer_add_offset(unsigned long offset)
+void timer_test_add_offset(unsigned long offset)
 {
 	sandbox_timer_offset += offset;
 }
diff --git a/include/regmap.h b/include/regmap.h
index 8359c511d2..3cd7a66cea 100644
--- a/include/regmap.h
+++ b/include/regmap.h
@@ -274,7 +274,7 @@ int regmap_raw_read_range(struct regmap *map, uint range_num, uint offset,
 		if (cond) \
 			break; \
 		if (IS_ENABLED(CONFIG_SANDBOX) && test_add_time) \
-			sandbox_timer_add_offset(test_add_time); \
+			timer_test_add_offset(test_add_time); \
 		if ((timeout_ms) && get_timer(__start) > (timeout_ms)) { \
 			__ret = regmap_read((map), (addr), &(val)); \
 			break; \
diff --git a/include/time.h b/include/time.h
index 825991e222..9fd0d73fb4 100644
--- a/include/time.h
+++ b/include/time.h
@@ -13,6 +13,14 @@ unsigned long get_timer(unsigned long base);
  */
 unsigned long timer_get_us(void);
 
+/*
+ * timer_test_add_offset()
+ *
+ * Allow tests to add to the time reported through lib/time.c functions
+ * offset: number of milliseconds to advance the system time
+ */
+void timer_test_add_offset(unsigned long offset);
+
 /*
  *	These inlines deal with timer wrapping correctly. You are
  *	strongly encouraged to use them
-- 
2.21.0

