Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
 by mx.groups.io with SMTP id smtpd.web12.19866.1577360049479533599
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Dec 2019 03:34:09 -0800
Received: by mail-pf1-f195.google.com with SMTP id x185so13085359pfc.5
        for <u-boot-amlogic@groups.io>; Thu, 26 Dec 2019 03:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bsTDIbGcCXeEbFB4nqEu6CLPkD6gEGSn0U4AyKc+2sA=;
        b=TBioQyuvnEmmn1Mq43qGWTUp+PlH4Nnc+uPfIfLyaGFXkTh0n82DgTqRSYiTburhvk
         06VsJB1mcN0YoOqBMoL1AuHi4qsxBngHNDE6C/2LFFiYKQAyyOAfeACGAP9STgNjj9oq
         o2F45NlMFXSy7uVed+CYq38gHW29JmYyRvcRddhua4UroJKmjpRFbFjnG1E42TRthk8t
         WenGdLJqBHBrpp88h4YvjUS/Rb1crJV1dCZ9BenJc+wS7929+b9mTL++7PtdFG9Bt5hn
         VgQrF5+JipIqcfW6QA4a3qXM8gFJCl0AyO9NARJNeqNVHcryC1LDXxSNWtyC7CxKCofz
         OMUw==
Return-Path: <linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv3 3/3] board: amlogic: select PWRSEQ for all amlogic platform
Date: Thu, 26 Dec 2019 11:33:53 +0000
Message-Id: <20191226113353.1757-4-linux.amoon@gmail.com>
In-Reply-To: <20191226113353.1757-1-linux.amoon@gmail.com>
References: <20191226113353.1757-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

commit a10388dc6982 ("mmc: meson-gx: add support for mmc-pwrseq-emmc")
introduce CONFIG_PWESEQ for power sequence for eMMC module on
amlogic platform, so enable this to all amlogic boards.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index e29e4c0acc..513a33dae2 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -8,6 +8,7 @@ config MESON64_COMMON
 	select DM_SERIAL
 	select SYSCON
 	select REGMAP
+	select PWRSEQ
 	select BOARD_LATE_INIT
 	imply CMD_DM
 
-- 
2.24.1

