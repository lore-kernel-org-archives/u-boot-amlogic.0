Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45394C54E5F
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 08:49:58 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web11.9347.1708594651189191027
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Feb 2024 01:37:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=zP1Wd8Wk;
 spf=pass (domain: linaro.org, ip: 209.85.167.177, mailfrom: sumit.garg@linaro.org)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbbc6e51d0so4675242b6e.3
        for <u-boot-amlogic@groups.io>; Thu, 22 Feb 2024 01:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708594650; x=1709199450; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zGClqGnWRD3X05DcIpdzYhmz0AMEjrk6nndbaf+6tc=;
        b=zP1Wd8Wk/KEwq84KCj1o5Y4w3nLO0NA1wF+dP1u16G7hW4NnRHur+hqmSOh9WzI6Im
         fDg5F2IP1xA19RewZupuMWhn5YCKX/ImCsrO6Y2rNrQo3HKy4jKkMNKrss58nbmY7mjp
         DqisIX3IUbNzGdE2G36BTUzhRIM7eT/C91mdP3xJknYWxb94eUoEkIF9Xnbqg90AJfRY
         mlQMJAnwbMWI9Pdbzj19zuQnb7YzJ9luOKVPjCeNL+nr8WwnJNa5kY+q5JnGGQqrvxhd
         9FevpNiZAfTl52kV/kivQxWdffMokIN21PVCVM68cgRGeDw57pmaf0RM1QF8LDl5WXBa
         md7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594650; x=1709199450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zGClqGnWRD3X05DcIpdzYhmz0AMEjrk6nndbaf+6tc=;
        b=EKK8m4sRCoWwas+0qAMNtIIAmnUCikUE2DdJE2bfFDTStAAKvGFSa5Rfz+4Mbatw2L
         /D++yEwSfTHeiN+hWWvB7YxaDtc1wRWEzjgsWF2PDKTn7pljIoahQ+ogF9IdNsjYnPo1
         hUnBgVjAP4pC6NGDzPvfLKrna2om2DQt4Pa26eKw8UrEe+gVWNYJeirlNiiV0i+h8Okf
         ufURzUdG/4gQrAUGlQ9pivA0LwOY5vPE1aLs9yoc4isB7LMkLJae4ZU2JAhIojfX4nAi
         01EFOs4EmnS+6CywyKiheNWdOB48DbvgB648yaqIqr3Ryr8DTWxnGhDlGY6IhvLVrzh4
         nFkg==
X-Forwarded-Encrypted: i=1; AJvYcCUDhx/MSmsZ6H1K9osgVgczzytybWyDeuvXfrTJIEhayoThluCRwKoTdUILMy1Slk7rmGTlTUHnx5PYxXOsMET4+YtN2UX0XsQ=
X-Gm-Message-State: AOJu0YxHp6peucXkmjTKa8a9g6UR7I78RElbWiB+ttLStYkTJTHaOYii
	K+LeWyHuuhp8ryE+GtXU0YJ5iGY1tZkoSE0I4GDUh0qhdPoS7wIm8Tsez6jA6xg=
X-Google-Smtp-Source: AGHT+IGW5cyksFUVdefuGyJChQbeQJcM+kpLbEGN3ulFT+N8oDpJ128TbhHEPvMhDHTSQTh5x2npZw==
X-Received: by 2002:a05:6358:2607:b0:17b:5d21:e86e with SMTP id l7-20020a056358260700b0017b5d21e86emr4709873rwc.3.1708594650446;
        Thu, 22 Feb 2024 01:37:30 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115])
        by smtp.gmail.com with ESMTPSA id u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:37:30 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com,
	sjg@chromium.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	neil.armstrong@linaro.org,
	caleb.connolly@linaro.org,
	ff@shokubai.tech,
	daniel.thompson@linaro.org,
	dgilmore@fedoraproject.org,
	pbrobinson@gmail.com,
	ilias.apalodimas@linaro.org,
	b.galvani@gmail.com,
	xypron.glpk@gmx.de,
	michal.simek@amd.com,
	seanga2@gmail.com,
	rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com,
	jh80.chung@samsung.com,
	rfried.dev@gmail.com,
	marex@denx.de,
	mibodhi@gmail.com,
	bb@ti.com,
	mark.kettenis@xs4all.nl,
	festevam@gmail.com,
	nm@ti.com,
	andre.przywara@arm.com,
	ijc@hellion.org.uk,
	paul.barker.ct@bp.renesas.com,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 07/11] doc: devicetree: Align documentation to use Kconfig options
Date: Thu, 22 Feb 2024 15:06:03 +0530
Message-Id: <20240222093607.3085545-8-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 26 Feb 2024 08:49:58 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2138

Since U-Boot switched away from manual CONFIG_* defines to Kconfig
options, align devicetree documentation accordingly.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v6:
- None

Changes in v5:
- Fixed inappropriate documentation update.

Changes in v4:
- Separate patch to align documentation to use Kconfig symbols instead.

 doc/develop/devicetree/control.rst | 48 ++++++++++++++----------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 11c92d440f4d..9a0cb90336df 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -29,7 +29,7 @@ a number of similar boards with different peripherals, you can describe
 the features of each board in the devicetree file, and have a single
 generic source base.
 
-To enable this feature, add CONFIG_OF_CONTROL to your board config file.
+To enable this feature, select `OF_CONTROL` via Kconfig.
 
 
 What is a Flattened Devicetree?
@@ -81,12 +81,8 @@ Failing that, you could write one from scratch yourself!
 Configuration
 -------------
 
-Use::
-
-   #define CONFIG_DEFAULT_DEVICE_TREE	"<name>"
-
-to set the filename of the devicetree source. Then put your devicetree
-file into::
+Set up "<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig. Then put
+your devicetree file into::
 
    arch/<arch>/dts/<name>.dts
 
@@ -94,24 +90,24 @@ This should include your CPU or SOC's devicetree file, placed in
 `arch/<arch>/dts`, and then make any adjustments required using a u-boot-dtsi
 file for your board.
 
-If CONFIG_OF_EMBED is defined, then it will be picked up and built into
+If `OF_EMBED` is selected by Kconfig, then it will be picked up and built into
 the U-Boot image (including u-boot.bin). This is suitable for debugging
 and development only and is not recommended for production devices.
 
-If CONFIG_OF_SEPARATE is defined, then it will be built and placed in
+If `OF_SEPARATE` is selected by Kconfig, then it will be built and placed in
 a u-boot.dtb file alongside u-boot-nodtb.bin with the combined result placed
-in u-boot.bin so you can still just flash u-boot.bin onto your board. If you are
-using CONFIG_SPL_FRAMEWORK, then u-boot.img will be built to include the device
-tree binary.
+in u-boot.bin so you can still just flash u-boot.bin onto your board. If Kconfig
+option `SPL_FRAMEWORK` is enabled, then u-boot.img will be built to include the
+device tree binary.
 
-If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
+If `OF_BOARD` is selected by Kconfig, a board-specific routine will provide the
 devicetree at runtime, for example if an earlier bootloader stage creates
 it and passes it to U-Boot.
 
-If CONFIG_BLOBLIST is defined, the devicetree may come from a bloblist passed
-from a previous stage, if present.
+If `BLOBLIST` is selected by Kconfig, the devicetree may come from a bloblist
+passed from a previous stage, if present.
 
-If CONFIG_SANDBOX is defined, then it will be read from a file on
+If `SANDBOX` is selected by Kconfig, then it will be read from a file on
 startup. Use the -d flag to U-Boot to specify the file to read, -D for the
 default and -T for the test devicetree, used to run sandbox unit tests.
 
@@ -145,7 +141,7 @@ Build:
 After the board configuration is done, fdt supported u-boot can be built in two
 ways:
 
-#  build the default dts which is defined from CONFIG_DEFAULT_DEVICE_TREE::
+#  build the default dts which is selected by DEFAULT_DEVICE_TREE Kconfig::
 
     $ make
 
@@ -198,8 +194,8 @@ As mentioned above, the U-Boot build system automatically includes a
 `*-u-boot.dtsi` file, if found, containing U-Boot specific
 quirks. However, some data, such as the mentioned public keys, are not
 appropriate for upstream U-Boot but are better kept and maintained
-outside the U-Boot repository. You can use CONFIG_DEVICE_TREE_INCLUDES
-to specify a list of .dtsi files that will also be included when
+outside the U-Boot repository. You can use `DEVICE_TREE_INCLUDES` Kconfig
+option to specify a list of .dtsi files that will also be included when
 building .dtb files.
 
 
@@ -213,14 +209,14 @@ The full devicetree is available to U-Boot proper, but normally only a subset
 'SPL Support' in doc/driver-model/design.rst for more details.
 
 
-Using several DTBs in the SPL (CONFIG_SPL_MULTI_DTB)
-----------------------------------------------------
+Using several DTBs in the SPL (SPL_MULTI_DTB_FIT Kconfig option)
+----------------------------------------------------------------
 In some rare cases it is desirable to let SPL be able to select one DTB among
 many. This usually not very useful as the DTB for the SPL is small and usually
 fits several platforms. However the DTB sometimes include information that do
 work on several platforms (like IO tuning parameters).
-In this case it is possible to use CONFIG_SPL_MULTI_DTB. This option appends to
-the SPL a FIT image containing several DTBs listed in SPL_OF_LIST.
+In this case it is possible to use SPL_MULTI_DTB_FIT Kconfig option. This option
+appends to the SPL a FIT image containing several DTBs listed in SPL_OF_LIST.
 board_fit_config_name_match() is called to select the right DTB.
 
 If board_fit_config_name_match() relies on DM (DM driver to access an EEPROM
@@ -247,10 +243,10 @@ architectures.
 
 It is important to understand that the fdt only selects options
 available in the platform / drivers. It cannot add new drivers (yet). So
-you must still have the CONFIG option to enable the driver. For example,
-you need to define CONFIG_SYS_NS16550 to bring in the NS16550 driver,
+you must still have the Kconfig option to enable the driver. For example,
+you need to enable SYS_NS16550 Kconfig option to bring in the NS16550 driver,
 but can use the fdt to specific the UART clock, peripheral address, etc.
-In very broad terms, the CONFIG options in general control *what* driver
+In very broad terms, the Kconfig options in general control *what* driver
 files are pulled in, and the fdt controls *how* those files work.
 
 History
-- 
2.34.1


