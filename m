Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B781DC47DBE
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.8916.1704883025535262174
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 02:37:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=fxsJyKyz;
 spf=pass (domain: linaro.org, ip: 209.85.214.178, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d54b765414so19246625ad.0
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 02:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704883025; x=1705487825; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIS9yp2pj60f8mlkj+VU7D14bpVqhCzj3gRXqDuXK9s=;
        b=fxsJyKyzokGk4X5K5tNW4cK+HqEigm8X6ggK4REGiNIJE5bS5qhqLEk92YW+rw/lK9
         xM6dJzTq0iku/nU25Zh3Q9SrsbFVuhQ+IY5RktqP+6lfF9UdPEsU6UYq73s/BkeLHCsf
         NDR/aWLMIHvlJA2K/CrEHIeHdBEtRoXLuUNAuEIWvfmp5uFH/4KbSiaz+7rFEjXj1AIH
         b+oLuIGwsSojJSaW6KEomw4K5kFB3vK8+e2H4+a6kZgi7oR9UbHmjp5t9JwztnFOAwQB
         gmivSxp7C0PIlDAw44N4+57+ZARxtHGCaKJCZHLmDJ1pJKJrkPj6pIMp5i1fBNAjLraz
         iHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883025; x=1705487825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIS9yp2pj60f8mlkj+VU7D14bpVqhCzj3gRXqDuXK9s=;
        b=q4+IEOuL63ZAaFRFYVGIy4NiQztaGTHi3GguA5tDmP5ktRkP0tXgR2UESf0LBi8/Uc
         eaA8aBeXLny7z4sYkEbBVjBCRvzhcyZvz+QcvKFzBnGsOFK3ZY+5sBe1syvvt+O6Yupo
         Peeiyp+rN5AXfEBFwcFYFrqxQMZXO8XBTg/xGYGM6NZSvzpTtqia8LUNAjxpW1NHLj/J
         DYGYDZBK06fJgkf+d0s6kfPD0X9vDOEW8gSU2NlxKpC1AErcFxCVZBknsjVeNIswLUED
         5IMtuQyXWDgqpmF222YQE9R0tTrM+mbaFoFqcfiK/ym3CIkF5JDX/Emn3y7rBWhqOidi
         w4iA==
X-Gm-Message-State: AOJu0Yyqajcv1659T1XDQ0WatDadhbez4hsdh4zs0j+r5Pjgs9dpb+Rr
	sQ+BvIKxHMNonTab1RBMYEdaSpuC6cPjeQ==
X-Google-Smtp-Source: AGHT+IFqHQEqj+SBvOZqozq76B6pjGjn99A62JPbbjSeoon1QvBVLxmgowUraMmkirr8aS4Dknmjqw==
X-Received: by 2002:a17:903:247:b0:1d5:4c37:714f with SMTP id j7-20020a170903024700b001d54c37714fmr1019149plh.22.1704883024631;
        Wed, 10 Jan 2024 02:37:04 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:37:04 -0800 (PST)
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
	maxim.uvarov@linaro.org,
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
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 07/11] doc: devicetree: Align documentation to use Kconfig options
Date: Wed, 10 Jan 2024 16:05:43 +0530
Message-Id: <20240110103547.719757-8-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2064

Since U-Boot switched away from manual CONFIG_* defines to Kconfig
options, align devicetree documentation accordingly.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Separate patch to align documentation to use Kconfig symbols instead.

 doc/develop/devicetree/control.rst | 50 ++++++++++++++----------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 11c92d440f4..75d5e02aaec 100644
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
@@ -247,16 +243,16 @@ architectures.
 
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
 -------
 
-U-Boot configuration was previous done using CONFIG options in the board
+U-Boot configuration was previous done using Kconfig options in the board
 config file. This eventually got out of hand with nearly 10,000 options.
 
 U-Boot adopted devicetrees around the same time as Linux and early boards
-- 
2.34.1


