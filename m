Received: by mail-wr1-f65.google.com with SMTP id r4so7825765wrq.8
        for <u-boot-amlogic@groups.io>; Thu, 11 Apr 2019 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xk3Div5qkqWhdDX4xPC36rpIV5g89+DUNHYKepe5uEQ=;
        b=UnCUl6X6Xzrg4JxguLeP+LqzDMsC/Lhb9wK4J+asNwYMYOcVIsM2p4mDb9mIv1k8zb
         DFKt8eQfoYStyH3/jVki4RXGvbOzif7WROzW1r5vM/VZ2WQhsek1ZFWXjveiSkM9Do7H
         JeTMTCSg7m8nZ4XFhFaBX9mgKR/zAJvrM3XGsIjUxCr9uW5ZxABuyxdelXvRhB0D6/Q5
         Xa0U3Hs8610o9Oh6Le4QAkrpTR6GiD44eiIG3Tn09rlCk44zKZqQCpMBoyacsVMR8qcK
         ZwRiGUKl/ao1qGpkzf5U/y2AOZvLxN1XfNfFplvdvG3Va+59DrOECRvuGSB4VDsTaoW9
         FDGg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] regmap: fix regmap_read_poll_timeout warning about sandbox_timer_add_offset
Date: Thu, 11 Apr 2019 17:12:04 +0200
Message-Id: <20190411151204.27316-1-narmstrong@baylibre.com>
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

This simply adds an empty static inline sandbox_timer_add_offset()
implementation that will be dropped by the compiler optimization routines.

Cc: Simon Glass <sjg@chromium.org>
Reported-by: Tom Rini <trini@konsulko.com>
Fixes: df9cf1cc08 ("test: dm: regmap: Fix the long test delay")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/regmap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/regmap.h b/include/regmap.h
index 8359c511d2..144cffbcc0 100644
--- a/include/regmap.h
+++ b/include/regmap.h
@@ -239,6 +239,10 @@ int regmap_raw_read_range(struct regmap *map, uint range_num, uint offset,
 #define regmap_get(map, type, member, valp) \
 	regmap_range_get(map, 0, type, member, valp)
 
+#ifndef CONFIG_SANDBOX
+static inline void sandbox_timer_add_offset(unsigned long offset) { }
+#endif
+
 /**
  * regmap_read_poll_timeout - Poll until a condition is met or a timeout occurs
  *
-- 
2.21.0

