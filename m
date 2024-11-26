Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1687CD5A6F6
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 08:07:11 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.40858.1732608422040940944
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2024 00:07:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=k3q4hrlt;
 spf=pass (domain: baylibre.com, ip: 209.85.221.48, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-382442b7d9aso4028202f8f.1
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 00:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732608420; x=1733213220; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YG0n9iqjEGSOZGNbSF7tdn5zq9rY9uCABPaJK+FiNE=;
        b=k3q4hrltPITf4IpeuDIDl8tun331njVt6iDV4KhKGUEuy3d6HshQynXnlcd95FNjsX
         Ms+KxWbe7GhS9LQ0V8/CHWq9K0B92x5+jLN/Aig4mbI3Ce6OXdEnzwpkKVsKjA5cJLkN
         M8XTKvYHnLJdS2xDRyDboN+g3cLSguCpScc6f5pTxw7QWCoOgh+jQnyVjH2FVjod5HB/
         33z91nRERw90KhM4B6uGfT3QAbbxN3px3lXzzqSTxCHzfPvBe5qMODhhD7eVyZjuP3J0
         sFZSUbvhepvBTBmLax6r4e9C+CGkl6aVVyedeiZePVJMKzxMR/msyBnfFKNWE/aJwNIQ
         t67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608420; x=1733213220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YG0n9iqjEGSOZGNbSF7tdn5zq9rY9uCABPaJK+FiNE=;
        b=rvD8s16WCSSdj0kpgbGDMm+9eOwNlpL5VfTtAJrXO8mjud7FdVAkIIPOc23tWJRIr+
         yUut3rof+NH2Xv0P6BKVVwcyrcAH73JTysLPkQKShB22SfCag5mfH/m9gZOS4V6RZo28
         +vv3b2CwZA+UrBGOQHZS2WtOsix0MuBT7XUdcaOhVapJ9eQ4tWU+wNBmu+x9rLADptNl
         PHZKILVqFcUDOXRroZNjQ0tBaoH8JE6YSeqk/kwaF4UQ4R1cFwZc7pnb0vkbqipNRRAR
         tUV6UPFmZSH3BIqgCe7Fsrsek+riMCoxqaXlPNqlXedAQot4JyA+qx8wEQhIyaLvqgIM
         jDng==
X-Forwarded-Encrypted: i=1; AJvYcCXJEAEUgTLoioGBX6aa8oGdAtA+sa0WyImRc8To2XizDWpIe5AC1ZszIJMhwIwThz0ZUyEeUi1xDgXbcNs4lw==@groups.io
X-Gm-Message-State: AOJu0YwGBNshaO/qw4df4d6jNqnOZ/+P3DJXdH9cYux1R9IZ+YAYlBbe
	F4e0qlQ7nnss1AyIsCKZtkVZoao2fH2LiyjCwKlsRQ0oyzPKAef/vFG/kgQU664=
X-Gm-Gg: ASbGncuD6yVSOeZA9Z5Dm8qc55x1A3un6ktCzXebvN77fqnSDQipI1XjDbHY+EwJEz/
	iCRIrlg4m0u78Zbh6DkIR7IxyFQk/gJkfCaF38vMoqhXXpvcPSZZ7LW1r+40hi8ZHil3Xtdfn53
	fmJdtU0H4u0M30ra71Zf99lZZLhLclNSTnL0fiSAr4n/F4W0BaDtLus709jxRI6wxexPHIx5Bwq
	Jma9Wl/VNm8oDXpQPUmqT2Pbx2y0gVO+cJ+OlfFxmyuIT8FpxgTtw==
X-Google-Smtp-Source: AGHT+IEJf8xT4KHKBlYGByUDFoKIBpHxbHZfCda3FlCjXKn+pWgnlOY0BftfNDiRlPB5dk3mZg0BKw==
X-Received: by 2002:a5d:6c69:0:b0:382:31ca:4dca with SMTP id ffacd0b85a97d-38260b4d679mr13157115f8f.7.1732608420443;
        Tue, 26 Nov 2024 00:07:00 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:86be:4d54:1784:8cf7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb36612sm12513102f8f.59.2024.11.26.00.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 00:06:59 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 26 Nov 2024 09:06:13 +0100
Subject: [PATCH v4 5/5] bootstd: Add test for Android boot image v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-adnroidv2-v4-5-11636106dc69@baylibre.com>
References: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
In-Reply-To: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 08:07:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2588

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
index da713d8ed72b..e33b08aa8cda 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1199,8 +1199,8 @@ static int bootflow_cros(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_cros, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
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
-BOOTSTD_TEST(bootflow_android, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_android_image_v4, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
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
+BOOTSTD_TEST(bootflow_android_image_v2, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
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


