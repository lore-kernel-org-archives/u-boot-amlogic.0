Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F077D6A239
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 21:30:07 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.5657.1731619800119073899
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Nov 2024 13:30:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=Y0aS+s8D;
 spf=pass (domain: baylibre.com, ip: 209.85.221.44, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso794670f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 14 Nov 2024 13:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731619798; x=1732224598; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4O3GTenKUlyWrp+qjGfSSiFiItxp1kvtFpPiHlclp8=;
        b=Y0aS+s8DBtZ6t6SVK1XUJBHLXGwK7slLo3nN5Dv/2Q5f6Bq8Zn5Pw7UMX1zS8GtFBc
         AgYfxthnWFKDnc7m0uWAq0HeoKFLH6vwRhCnq1AQ91zW8fOAMTxJng4bZ32cFzniv5z3
         WWIE4mZT8XcUbx41JwGfkNTAgQiOJNl1SSW3Pv0hrfjOPT0g0g00OWG++fU/pum6p8dt
         ztwxCIuO5bfFgy6qk2Ez+OuZj2Hh1XLSR0UvKe0l8ReNds/L9A5xTAjb+RnCntbgKFl0
         kdwh7zt2xmUB19Ma9YA47imhTCQQXtUTE1VpCBkXPyJJOlrIu/oyMj5eyk8aSqG0i+7z
         LHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731619798; x=1732224598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4O3GTenKUlyWrp+qjGfSSiFiItxp1kvtFpPiHlclp8=;
        b=udR0+MRdBfp+8EY31W/a40AwF6bcLjtqTU3UKV+fLlNDehcsV5Md9wLs5ha/sKKyfX
         ffRBjmr/pV5evxGseFeL4BFMrZYFymYC1Agufr9HoMJB8g3RNEmyyyIJ/xNq8TLDe4k7
         txW+RS+6XTpjHGQu5RHBDq76tISqZc7+gVStGeh34VpzLmgAVCbxdyKsA9X8PMsPDkuG
         GerDdfCxX+B6j5Yvq22Yv3YnpKPp1vX1coGlkfcnMdDnOmrolPe9CLbQsZqNydoYwvbZ
         a50jlHDaG07jAPfr4B86P8SXm5KbQG+gK0AaGDdRzURAJkKjzFNFv+IEPKFmdrmcalIg
         SNVw==
X-Forwarded-Encrypted: i=1; AJvYcCVf48OVSaQGfG+nwZsIF52TccHheh4VGGnJ8wJTXgyXCCZqKpsWamMJ6WFhwIDnk2/h0VPZC5/4FBvtrb+yJQ==@groups.io
X-Gm-Message-State: AOJu0YyrEJyGhl2hfZFiqv5EnPCvqza9VBDJNfYbTFIU6/jGO54PV1D0
	WJe5HUQOg9Ihk9SoGrAILnFtXM8KocIE72bTYZeCUwXseQGYQpxaIZSVT3s/GnMnHi2Gk7VdwJn
	Zgi0=
X-Google-Smtp-Source: AGHT+IGkVtSafmHVJr6qQVmiRxqc8HQ07YneD3H3sSdtjSfJR8b+UJW2DbP4DiAhQusF7e7ZFc9olQ==
X-Received: by 2002:a5d:47a6:0:b0:37c:cfba:d16b with SMTP id ffacd0b85a97d-38225aa82famr238763f8f.44.1731619798255;
        Thu, 14 Nov 2024 13:29:58 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:89e8:c8e2:1fe:645])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3febsm2459782f8f.19.2024.11.14.13.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:29:57 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 14 Nov 2024 22:29:48 +0100
Subject: [PATCH v2 5/5] bootstd: Add test for Android boot image v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-adnroidv2-v2-5-015bffb1373a@baylibre.com>
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
In-Reply-To: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 14 Nov 2024 21:30:07 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2556

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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/sandbox/dts/test.dts | 10 +++++++++-
 test/boot/bootflow.c      | 29 +++++++++++++++++++++++++---
 test/py/tests/test_ut.py  | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index dee280184b1b..36cfbf213e4c 100644
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
@@ -1138,13 +1139,20 @@
 		filename = "mmc6.img";
 	};
 
-	/* This is used for Android tests */
+	/* This is used for Android boot image v4 tests */
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
index 9397328609d0..60649886402c 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1199,8 +1199,8 @@ static int bootflow_cros(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_cros, UTF_CONSOLE);
 
-/* Test Android bootmeth  */
-static int bootflow_android(struct unit_test_state *uts)
+/* Test Android bootmeth  with boot image version 4 */
+static int bootflow_android_image_v4(struct unit_test_state *uts)
 {
 	if (!IS_ENABLED(CONFIG_BOOTMETH_ANDROID))
 		return -EAGAIN;
@@ -1220,7 +1220,30 @@ static int bootflow_android(struct unit_test_state *uts)
 
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
 
 /* Test EFI bootmeth */
 static int bootflow_efi(struct unit_test_state *uts)
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 6d44191976bb..7a0bde4da256 100644
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


