Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE989D44150
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 11:37:59 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.18866.1732016273649716770
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Nov 2024 03:37:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=zvyd7HHF;
 spf=pass (domain: baylibre.com, ip: 209.85.221.42, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38231e9d518so2484487f8f.0
        for <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 03:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732016272; x=1732621072; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4O3GTenKUlyWrp+qjGfSSiFiItxp1kvtFpPiHlclp8=;
        b=zvyd7HHFGrQDHX7mvxsxoc16Zuc7cH5wt2/m0ViTB0jjPuUvCj/WdK8pWSBLyebbUX
         LmMhhX6JbBlsP3wqTURcG4HhN5agplHZz4mLaCGkPenJBgvv8KBmIWaG7F4nKU7Z+VXm
         iS+Ra0XKt3aqyu+XjqiYx+MJhIiBKooxtx45LgTg76iueFJ2Cmu4dU0TTCCYPdWRMaUv
         lG/tFHYfTgCnIL9XFIGiJqqWCqcWzUvooFTs4VyRUgwQ/TkHzcvOIEgD2SNB9dN3uulC
         mZ+fpacyXn+sviwRzHNmErAC3mxObT+KhafPfBUefbjDEp4cbRauEC40ttvaYas5GdUH
         WRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016272; x=1732621072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4O3GTenKUlyWrp+qjGfSSiFiItxp1kvtFpPiHlclp8=;
        b=t+rEnPevyJXGSA5jzoCTTehxaUKN1e9ofDdBM6pqKUCX55i/6bUOKgG+kMi8bh4tGu
         DjGEWTl8j4bFlwZgj4IvJUMpPZGrrDkL0iJUhw1EQmbzXT3aLAaSGGo4Q86paEY0mSLA
         ajpc9MOuPYxVRuwqB9aXnMOzW+b/fs7ig1GpQwrjsEI1p9i6h+0h1tVB1kYxXcfyd2So
         othlduQn7M1s7A+QjmLUcI1IpMRG0O+IxFCqTBMIRBJpD5h+8rZh3oVWKLi/O35yOE20
         vXoPnGqyyZUesrTXSK5AjWPSVt2z46rUFGzV6pYyBUBzujAKT9pDlwUB1UkphX9XEne6
         fl3g==
X-Forwarded-Encrypted: i=1; AJvYcCXc1M+sLlbbU9XmW0Qrc+UpcGZm56htvXJMuDO91pRvf6UVmhwEj380wOGUxx/uN6V8mRY8QAj8mbsqMefOjg==@groups.io
X-Gm-Message-State: AOJu0YyB4TKJL7NfozssGbubCmcNWdBjBq8zqve889EQm/hzIDFV62xE
	rd723TpWP/c+tD+oLJ7PUm/MKcva9+8tfWb95TX2ZRQ2mr3Zhd+mqsMJ9pe1vEU=
X-Google-Smtp-Source: AGHT+IHr75XkdEI2m/yaROrtADow7vJlTdM6P/tjKFyb8vz0XSocyzuwADtz5wWXA9ytvXGZWxyIgw==
X-Received: by 2002:a05:6000:1fa3:b0:37c:cbd4:ec9 with SMTP id ffacd0b85a97d-382259023f1mr13125360f8f.5.1732016272059;
        Tue, 19 Nov 2024 03:37:52 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:cc39:27ba:4c6c:3c84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824259dda3sm7580388f8f.77.2024.11.19.03.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:37:51 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 19 Nov 2024 12:37:42 +0100
Subject: [PATCH v3 5/5] bootstd: Add test for Android boot image v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-adnroidv2-v3-5-45baa486fb31@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
In-Reply-To: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 11:37:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2572

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


