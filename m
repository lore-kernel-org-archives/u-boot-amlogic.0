Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A372D2F7D4
	for <webhook@archiver.kernel.org>; Thu, 17 Oct 2024 16:11:02 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.1859.1729181452171431698
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Oct 2024 09:10:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=SaYnDxno;
 spf=pass (domain: baylibre.com, ip: 209.85.221.46, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so834417f8f.1
        for <u-boot-amlogic@groups.io>; Thu, 17 Oct 2024 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729181450; x=1729786250; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDZM1Pv5T6/IhgN27Z0nSeoonqug1/Cq0DYl8pPIl/U=;
        b=SaYnDxnomkys9dk8vdjFkGVnVoQVWLjLRlu9QgQ5wiIDgYibY0MUMG56PIwojPhhLg
         gH1SKVESD/PH/LVbDC1Mzm6xyHXISbSVz2+UpLGFu7jb+GlgMqjPCCfIcPZtAEQcAmMV
         VzXoyf6Lpf/Z8wEg/lklubYUML5bwFsRS8ZSMZsaZQOXaj5nOLPubklwI/+QYScKSpZm
         AE95sinQefyQf6uZ+X+PLwcsQL1hEb2wIeEslMSSQ//9DPkKGq5FWgSsPdiZ/Umi4wjH
         z7MqNwDKrBtnjBoUQjplJZ9amRHOuTad1shGt/EmMVoMP7e2cVyelVQD6RHNXMXyQCfx
         LhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181450; x=1729786250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDZM1Pv5T6/IhgN27Z0nSeoonqug1/Cq0DYl8pPIl/U=;
        b=JrnT2yH5CnlhXr+vBrIjvkHzvOUJiwbPLrDeYy4XeIZNOnNC0ywzQchqM9Bq0QDnwG
         Wea+pYPqwQbHAAf1I0b9urVU7d5svi/Ud36wEAaJ0NDtmvOA6X0vN3akRs/4zhpj1bQB
         aEmdF1EGY2gTNp6jVXepbUdwjkSSAUclEmyvQhFQuNN/giTR1pRQtvKBWSPxX76qZpr2
         AiULiYsWAM0d+1hq5WbndnqWmu8n5tGofPkVapQdtt1RkV23Xy8asRYPLi5kA1MqJjPz
         WDwb/xqWGBTl6JZmZuh1UErTJtpGPAYzgStzgbhRgbUuPadsL7N4FfZrkim+bQPSGmsH
         KTtA==
X-Forwarded-Encrypted: i=1; AJvYcCWLBzSmj8szhNtboPifH3WKEEonJzg8UqO/PVwDcLKVVZJNRRoGrTCXPE4HloWkz7kFUFidnjFSyexHYIHZrw==@groups.io
X-Gm-Message-State: AOJu0YyvttsEbHVCkDBwMaMdEdLiBb0MU1BhlASXR2cZB0ZFYBIzsUnk
	cDD9fXfKDlpcKqOusp9ry2129q1pTaxtirWvLIwa0LTFPFXIi7dk7MUw1cMc9tA=
X-Google-Smtp-Source: AGHT+IFzcyxeYhrn4FwOfAjok3mJ3kzah77jFmHfk2zqtxczwkv/uiX7StOLbFp6MfSyCIuMA+mAwg==
X-Received: by 2002:adf:e54e:0:b0:37d:45f0:b33 with SMTP id ffacd0b85a97d-37d55184ae1mr14913828f8f.9.1729181450468;
        Thu, 17 Oct 2024 09:10:50 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:4754:2b9f:eb4f:125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc42160sm7653993f8f.112.2024.10.17.09.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:10:49 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 17 Oct 2024 18:10:30 +0200
Subject: [PATCH 6/6] bootstd: Add test for Android boot image v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-adnroidv2-v1-6-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
In-Reply-To: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com, 
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 17 Oct 2024 16:11:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2508

Rename actual android bootmethod test to specify it's for boot image
version 4.
Add a unit test for testing the Android bootmethod with boot image
version 2.

This requires another mmc image (mmc8) to contain the following
partitions:
- misc: contains the Bootloader Control Block (BCB)
- boot_a: contains a fake generic kernel image

we can test this with:

$ ./test/py/test.py --bd sandbox --build -k test_ut # build the mmc8.img
$ ./test/py/test.py --bd sandbox --build -k bootflow_android

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/sandbox/dts/test.dts | 10 +++++++++-
 test/boot/bootflow.c      | 29 +++++++++++++++++++++++++---
 test/py/tests/test_ut.py  | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 9bf44ae3b0bc..108633a727f9 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -44,6 +44,7 @@
 		mmc5 = "/mmc5";
 		mmc6 = "/mmc6";
 		mmc7 = "/mmc7";
+		mmc8 = "/mmc8";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -1135,13 +1136,20 @@
 		filename = "mmc6.img";
 	};
 
-	/* This is used for Android tests */
+	/* This is used for Android tests image v4 tests */
 	mmc7 {
 		status = "disabled";
 		compatible = "sandbox,mmc";
 		filename = "mmc7.img";
 	};
 
+	/* This is used for Android boot image v2 tests. */
+	mmc8 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc8.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 154dea70a59c..febe85ca2fd6 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1191,8 +1191,8 @@ static int bootflow_cros(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_cros, UTF_CONSOLE);
 
-/* Test Android bootmeth  */
-static int bootflow_android(struct unit_test_state *uts)
+/* Test Android bootmeth  with boot image version 4 */
+static int bootflow_android_image_v4(struct unit_test_state *uts)
 {
 	if (!IS_ENABLED(CONFIG_BOOTMETH_ANDROID))
 		return -EAGAIN;
@@ -1212,4 +1212,27 @@ static int bootflow_android(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_android, UTF_CONSOLE);
+BOOTSTD_TEST(bootflow_android_image_v4, UTF_CONSOLE);
+
+/* Test Android bootmeth with boot image version 2 */
+static int bootflow_android_image_v2(struct unit_test_state *uts)
+{
+	if (!IS_ENABLED(CONFIG_BOOTMETH_ANDROID))
+		return -EAGAIN;
+
+	ut_assertok(scan_mmc_android_bootdev(uts, "mmc8"));
+	ut_assertok(run_command("bootflow list", 0));
+
+	ut_assert_nextlinen("Showing all");
+	ut_assert_nextlinen("Seq");
+	ut_assert_nextlinen("---");
+	ut_assert_nextlinen("  0  extlinux");
+	ut_assert_nextlinen("  1  android      ready   mmc          0  mmc8.bootdev.whole        ");
+	ut_assert_nextlinen("---");
+	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_android_image_v2, UTF_CONSOLE);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 39aa1035e34d..6d2420798e80 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -501,6 +501,55 @@ def setup_android_image(cons):
 
     print(f'wrote to {fname}')
 
+    mmc_dev = 8
+    fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
+    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
+    u_boot_utils.run_and_log(cons, f'cgpt create {fname}')
+
+    ptr = 40
+
+    # Number of sectors in 1MB
+    sect_size = 512
+    sect_1mb = (1 << 20) // sect_size
+
+    required_parts = [
+        {'num': 1, 'label':'misc', 'size': '1M'},
+        {'num': 2, 'label':'boot_a', 'size': '4M'},
+        {'num': 3, 'label':'boot_b', 'size': '4M'},
+    ]
+
+    for part in required_parts:
+        size_str = part['size']
+        if 'M' in size_str:
+            size = int(size_str[:-1]) * sect_1mb
+        else:
+            size = int(size_str)
+        u_boot_utils.run_and_log(
+            cons,
+            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
+        ptr += size
+
+    u_boot_utils.run_and_log(cons, f'cgpt boot -p {fname}')
+    out = u_boot_utils.run_and_log(cons, f'cgpt show -q {fname}')
+
+    # Create a dict (indexed by partition number) containing the above info
+    for line in out.splitlines():
+        start, size, num, name = line.split(maxsplit=3)
+        parts[int(num)] = Partition(int(start), int(size), name)
+
+    with open(fname, 'rb') as inf:
+        disk_data = inf.read()
+
+    test_abootimg.AbootimgTestDiskImage(cons, 'boot.img', test_abootimg.img_hex)
+    boot_img = os.path.join(cons.config.result_dir, 'boot.img')
+    with open(boot_img, 'rb') as inf:
+        set_part_data(2, inf.read())
+
+    with open(fname, 'wb') as outf:
+        outf.write(disk_data)
+
+    print(f'wrote to {fname}')
+
     return fname
 
 def setup_cedit_file(cons):

-- 
2.34.1


