Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web08.7683.1637809747416007947
 for <u-boot-amlogic@groups.io>;
 Wed, 24 Nov 2021 19:09:07 -0800
Received: by mail-pj1-f50.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso4517289pjb.2
        for <u-boot-amlogic@groups.io>; Wed, 24 Nov 2021 19:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gty+fyacM/AGt5HD1oDWWLpUuczab02jCSI0bTm7XP0=;
        b=NdLLokK4UE/lrv/kkSeQD418sLkJ+qL+wS0Mrl2/JhscHTOm7VH0Z6iYUt4eJxdPQt
         G1QDQLxwenx0mIa9x5RbPQQInAxqivS3Wxnyx2OxcbKxwUyjMC9F9PNDSD3aM4h+p2oB
         RDYhkR2Bpl2en5SD1WiysKu6yW7qLm5Of11FhZCQP0dl6FPkwKGawZgi0Wlq5WLJTUOS
         1mXjzjyZlpRKOYV0dv/UsXG71r2T20KiQC9o+IvGt7gzblND+ICX2qgQfIXV3Ab14275
         873eUkTUtiFh/5R+039pL7lHROxsbaOtdfhkrisYH65Xkir3LBONQ4gHfzqdUAa9LVhB
         HEfw==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH v2] image-board: fix wrong implementation ram disk address setup from cmdline
Date: Thu, 25 Nov 2021 11:08:59 +0800
Message-Id: <20211125030859.2896352-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: sjg@chromium.org
Cc: trini@konsulko.com, narmstrong@baylibre.com, twarren@nvidia.com, andre.przywara@arm.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, christianshewitt@gmail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Problem

Wrong implementation logic: ramdisk cmdline image address always ignored!
Next block { rd_addr = hextoul(select, NULL) } unusable for raw initrd.

We have unbootable raw initrd images because, select_ramdisk for raw
initrd images ignore submited select addr and setup rd_datap value to 0

Signed-off-by: Artem Lapkin <art@khadas.com>
---
V2 changes
_ rebase to master
_ from https://patchwork.ozlabs.org/project/uboot/patch/20211016051915.4157293-1-art@khadas.com/
---
 boot/image-board.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index bf8817165c..87a8f07432 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -334,7 +334,7 @@ static int select_ramdisk(bootm_headers_t *images, const char *select, u8 arch,
 
 	if (select) {
 		ulong default_addr;
-		bool done = true;
+		bool done = false;
 
 		if (CONFIG_IS_ENABLED(FIT)) {
 			/*
@@ -352,13 +352,13 @@ static int select_ramdisk(bootm_headers_t *images, const char *select, u8 arch,
 					   &fit_uname_config)) {
 				debug("*  ramdisk: config '%s' from image at 0x%08lx\n",
 				      fit_uname_config, rd_addr);
+				done = true;
 			} else if (fit_parse_subimage(select, default_addr,
 						      &rd_addr,
 						      &fit_uname_ramdisk)) {
 				debug("*  ramdisk: subimage '%s' from image at 0x%08lx\n",
 				      fit_uname_ramdisk, rd_addr);
-			} else {
-				done = false;
+				done = true;
 			}
 		}
 		if (!done) {
-- 
2.25.1

