Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web09.5692.1659624127732045283
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Aug 2022 07:42:08 -0700
Received: by mail-wr1-f47.google.com with SMTP id j15so17432364wrr.2
        for <u-boot-amlogic@groups.io>; Thu, 04 Aug 2022 07:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lJq4MgsHDRHYamBJyXAKllSC+HzQpkj6rtYbyRwxHHQ=;
        b=Sro8SBvaW/6f/ypwy1fD4nDzC3e6WpIK32hjI4zurMHKmUUyrdQ0FAkqfJPeLsxfbd
         BW9f4VgG4Ff1J7KUZPNidJyDOCqazuBkj8YLS1rmNfPgKUoEdz5w+dDRM0AnJmqt9OTI
         QxTQLQCvwFVq0ZbqppsCxzsN2vCjC2QJZwehxOjitaNeQg9Y/GmFZ+eVLblHmeRleWZY
         7hMZZnpspXPt9YrnRM4AsL3jNsPSOstQnxCyyoTcn8uzw/rAdTHMS+h+1TA75PNWb+Yn
         f32gXfmWQQdvU6xR6bmvkZdJ0VH62ARocB6CUG2DuE03IkD+9jvHEDYp4na4CkDp/WMU
         7zvw==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] ARM: meson: fixup error on efuse commands return
Date: Thu,  4 Aug 2022 16:41:38 +0200
Message-Id: <20220804144138.33809-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

All `sm efuseread/efusewrite` commands exit with an error, even if the fuse
have actually been dealt with correctly.

This is because the smc call return the size it actually processed but this
result is checked against 0.

Return failure in do_efuse_read/write if the return value of
meson_sm_read/write_efuse() is not the requested size.

Fixes: 52195ba5f579 ("ARM: amlogic: add sm efuse write support and cmd for read/write efuse")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/mach-meson/sm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index 6c28c0f5e445..d6eb910689f4 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -82,10 +82,7 @@ ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size)
 
 	smc_call(&regs);
 
-	if (regs.regs[0] == 0)
-		return -1;
-
-	return 0;
+	return regs.regs[0];
 }
 
 #define SM_CHIP_ID_LENGTH	119
@@ -222,7 +219,7 @@ static int do_efuse_read(struct cmd_tbl *cmdtp, int flag, int argc,
         address = simple_strtoul(argv[3], NULL, 0);
 
 	ret = meson_sm_read_efuse(offset, (void *)address, size);
-	if (ret)
+	if (ret != size)
 		return CMD_RET_FAILURE;
 
 	return CMD_RET_SUCCESS;
@@ -243,7 +240,7 @@ static int do_efuse_write(struct cmd_tbl *cmdtp, int flag, int argc,
         address = simple_strtoul(argv[3], NULL, 0);
 
 	ret = meson_sm_write_efuse(offset, (void *)address, size);
-	if (ret)
+	if (ret != size)
 		return CMD_RET_FAILURE;
 
 	return CMD_RET_SUCCESS;
-- 
2.36.1

