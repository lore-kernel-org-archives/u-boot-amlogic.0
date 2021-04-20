Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.7699.1618908151060139487
 for <u-boot-amlogic@groups.io>;
 Tue, 20 Apr 2021 01:42:31 -0700
Received: by mail-wr1-f43.google.com with SMTP id m9so23962032wrx.3
        for <u-boot-amlogic@groups.io>; Tue, 20 Apr 2021 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C6oUf7PH+EmQ3ijUIbGsEc2XUbOVSlE2ziIFpUqpLcM=;
        b=PlqUPyTc/J8sj18rMMmI9Dtz+2VXu6Z671byp/j4o18pQtWmWKHq+fLRZ/ebnXWVGJ
         hndlgM5dvCbli3wilLhNS6etFMjoHx084/3360YFVxfju5D6P+kc/pKSFq2JwXCqy5lR
         zsEc545tV/F0EjA3+ggxEr9VwSa5nA2+xT7ioq7wmuv6FTwJAUSAi7n8KPG/aezshwUp
         FV8Fsdss2hQaFzdtRmBCoW0DzrIgBrYkwDZQ0q9RdrqxqkzjCOPYA426YwYdQczUS6PS
         3PGPMhhaB6SSHB3Pt8rL62dfN7s3+2a6mniaIS5wd7nPQdnhPFa9tXL9P4K3KQLaFi47
         YcAA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/2] test: reset: Extend base reset test to catch error
Date: Tue, 20 Apr 2021 10:42:25 +0200
Message-Id: <20210420084226.2996654-2-narmstrong@baylibre.com>
In-Reply-To: <20210420084226.2996654-1-narmstrong@baylibre.com>
References: <20210420084226.2996654-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: sjg@chromium.org
Cc: jagan@amarulasolutions.com, u-boot@lists.denx.de, trini@konsulko.com, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

With this extended test, we get the following failure :

=> ut dm reset_base
Test: dm_test_reset_base: reset.c
test/dm/reset.c:52, dm_test_reset_base(): reset_method3.id == reset_method3_1.id: Expected 0x14 (20), got 0x2 (2)
Test: dm_test_reset_base: reset.c (flat tree)
test/dm/reset.c:52, dm_test_reset_base(): reset_method3.id == reset_method3_1.id: Expected 0x14 (20), got 0x2 (2)
Failures: 2

A fix is needed in reset_get_by_index_nodev() when introduced in [1].

[1] ea9dc35aab ("reset: Get the RESET by index without device")

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/sandbox/dts/test.dts |  4 ++--
 test/dm/reset.c           | 39 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 48240aa26f..4fde923e9a 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -997,8 +997,8 @@
 
 	reset-ctl-test {
 		compatible = "sandbox,reset-ctl-test";
-		resets = <&resetc 100>, <&resetc 2>;
-		reset-names = "other", "test";
+		resets = <&resetc 100>, <&resetc 2>, <&resetc 20>, <&resetc 40>;
+		reset-names = "other", "test", "test2", "test3";
 	};
 
 	rng {
diff --git a/test/dm/reset.c b/test/dm/reset.c
index fc8e9250b0..9c00452336 100644
--- a/test/dm/reset.c
+++ b/test/dm/reset.c
@@ -24,18 +24,47 @@
 static int dm_test_reset_base(struct unit_test_state *uts)
 {
 	struct udevice *dev;
-	struct reset_ctl reset_method1;
-	struct reset_ctl reset_method2;
+	struct reset_ctl reset_method1, reset_method1_1;
+	struct reset_ctl reset_method2, reset_method2_1;
+	struct reset_ctl reset_method3, reset_method3_1;
+	struct reset_ctl reset_method4, reset_method4_1;
 
 	/* Get the device using the reset device */
 	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "reset-ctl-test",
 					      &dev));
 
 	/* Get the same reset port in 2 different ways and compare */
-	ut_assertok(reset_get_by_index(dev, 1, &reset_method1));
+	ut_assertok(reset_get_by_index(dev, 0, &reset_method1));
+	ut_assertok(reset_get_by_index_nodev(dev_ofnode(dev), 0,
+					     &reset_method1_1));
+	ut_assertok(reset_get_by_index(dev, 1, &reset_method2));
 	ut_assertok(reset_get_by_index_nodev(dev_ofnode(dev), 1,
-					     &reset_method2));
-	ut_asserteq(reset_method1.id, reset_method2.id);
+					     &reset_method2_1));
+	ut_assertok(reset_get_by_index(dev, 2, &reset_method3));
+	ut_assertok(reset_get_by_index_nodev(dev_ofnode(dev), 2,
+					     &reset_method3_1));
+	ut_assertok(reset_get_by_index(dev, 3, &reset_method4));
+	ut_assertok(reset_get_by_index_nodev(dev_ofnode(dev), 3,
+					     &reset_method4_1));
+
+	ut_asserteq(reset_method1.id, reset_method1_1.id);
+	ut_asserteq(reset_method2.id, reset_method2_1.id);
+	ut_asserteq(reset_method3.id, reset_method3_1.id);
+	ut_asserteq(reset_method4.id, reset_method4_1.id);
+
+	ut_asserteq(true, reset_method1.id != reset_method2.id);
+	ut_asserteq(true, reset_method1.id != reset_method3.id);
+	ut_asserteq(true, reset_method1.id != reset_method4.id);
+	ut_asserteq(true, reset_method2.id != reset_method3.id);
+	ut_asserteq(true, reset_method2.id != reset_method4.id);
+	ut_asserteq(true, reset_method3.id != reset_method4.id);
+
+	ut_asserteq(true, reset_method1_1.id != reset_method2_1.id);
+	ut_asserteq(true, reset_method1_1.id != reset_method3_1.id);
+	ut_asserteq(true, reset_method1_1.id != reset_method4_1.id);
+	ut_asserteq(true, reset_method2_1.id != reset_method3_1.id);
+	ut_asserteq(true, reset_method2_1.id != reset_method4_1.id);
+	ut_asserteq(true, reset_method3_1.id != reset_method4_1.id);
 
 	return 0;
 }
-- 
2.25.1

