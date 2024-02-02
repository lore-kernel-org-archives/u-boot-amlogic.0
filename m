Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A4BC4829D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 08:45:54 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.22171.1706879220723172138
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Feb 2024 05:07:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=UXrnes+m;
 spf=pass (domain: linaro.org, ip: 209.85.214.174, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d953fa3286so12637615ad.2
        for <u-boot-amlogic@groups.io>; Fri, 02 Feb 2024 05:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706879220; x=1707484020; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xD1luGAP2JCOy74S0Dvk++4XEGenbMM27aVFBieuLJA=;
        b=UXrnes+mutQNVft5ObxpPtCr8rbu0vYnyziE4cxrJH2qSgSnR8RSKA2nD7bywYcf4v
         zg5p5aX1miDfmGDRy/qENLeBNq2yx8xvPFIypz5PWDIQc88bD+eKvs/wPYaks38crOpr
         yTilmuJtBgTCSimENUPYrxgWGG6il+WK1eJj9SyYlnyAwMfRpxMJdQmzjYSxgOYhrift
         xNvdPVoGmyfupzoZa3E1eIiDr7xyIReEuEYrVBuGSxXtZAT8IlbtnnVJ6o4q1rX7B4SP
         tLK0QTWVGclCKISuQ2xMSBdZIoUli3Qa+1owl097mkEo/xPDai4YEzvnuGf4FGqpsrBv
         OZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879220; x=1707484020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xD1luGAP2JCOy74S0Dvk++4XEGenbMM27aVFBieuLJA=;
        b=tyKizU4jkfl8DNnG/jopKhQfps/R1gCQyvXt18YW3y1J7SySPIp26wIRe7OL5wSwhd
         N8v9tYclpls/n6cVSy8r5QDU8MN/fvSXMpa4SFBgeGOMeOq0+vbr8ESogsHVRw4GAYSf
         erBtqDo/DXWYrATqxRhFQCEERjWrMT/2yckRop0IXftcPoWx6RvU7KQDps3ldJTwnR3t
         m7XHVP3bBZH5iy+PQsmR2GvM9coaF+di8RDnX2V0EXGWVIucV/yZZSFslkOOWykH9I52
         Sgg0hiN1nicLvtnWfsEag1kblTc+KpLhLhIYD1hi6e3SP0cJsWlGZVsxyibXEmnJbAwv
         VX8Q==
X-Gm-Message-State: AOJu0Yw+7OVFRq/l1JVwea0646OMU23nZn7i0yPiZUZW2M74s0c8O5Pd
	Ln1WiPDcDhdsHHwT83eP9erlxT9LJuXgIBj4ejoIp0WSRVxngAXWL6u6ZK7wjL0=
X-Google-Smtp-Source: AGHT+IE0j7/2Pxu9Osh+UzeHQH/A3iPov633x7R0SbLNm7WsN6hXQN2IU5chUSAqyOEsWp3AY3zixQ==
X-Received: by 2002:a17:902:eac6:b0:1d9:4834:e1b8 with SMTP id p6-20020a170902eac600b001d94834e1b8mr4840345pld.33.1706879220138;
        Fri, 02 Feb 2024 05:07:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXTEyYtgLa9bgrvREoGfi4WDLkto38OjMK0aMxBfQGKUZlbI9gj6a9P3nuvJGrDXXl/5g9BGUsqoU7v3LUWuISPAt94MTuh7d5wIvbcsIF847aZcbcI0Duu86EJIYJJVclRAZDkmw6oL0xvR+PckRpRbGBwskkwkaU3MCTKKSRZ+NIW45Ik1+xoKBB/adEsR/qILKwBTTAgK49ae8Lbgx+MwOITiQIoZcWnLqc8OXoRzioKrIQADK2i5F/aEAty5L6EqpH6X0Ijj8rEY0nTayKaAj9KUyQhFPMDyAVMQh1jRhDkeQBdQeVncOSR1qx+nCnbruXlzLVNaBmY/rvE9zzYnO5fyvrmRduEJMc4SGNky5G43lyhVQpIb9VgtMInFl5OTFLiVb4CGGeKFkjG+3GMfTe+U/4ZofJyQo1v5heGuyAce/RaE/vWmEyEAhrT5syfGx8gKSybY/VN1W13ksurTViXwBKp3kTfMeceJSouah7+JlQ4pDSIdd58+6yCt2MW0rGRlYkaT398cfTD/MX+tNEW1HXq1pF23Mw06Mo+MH5UME1x0tNU73x91Wp9gNnIu4Iy/1CMUOfQD6DHZK7vX+X4T8HnHu+PHlvLQ0zdCpWkhpkHe0NTvqzt2lXNWXB+jXC97VW8WJrcPSWuALlL58aAne9cEWBQbnKMVYouj05EK6sRAZdTW2mHFGWoWCqeyzgIstVQcuQkGg0K+Mtdpo5YmkzLu+uKh3By7PgAhqxMDOpGc4TA2xxfSJtOBXY3sJP8ZxSx+cqdNX3mPFiIqu0bnsjgNHfzaQafFq0FqnNAdoJ7RvRaMQVpG+dGDmrcH5xbEqalaXybyYviGMmLidkgXt2QH3ARo4aR0vyE7hOBLOjon/kd7cknPCDltb9ZgmrOE2x5jt3yvyz1o2l1gfvS5tVXiaiQ
Received: from sumit-X1.. ([223.178.213.44])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:06:59 -0800 (PST)
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
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 07/11] doc: devicetree: Align documentation to use Kconfig options
Date: Fri,  2 Feb 2024 18:35:30 +0530
Message-Id: <20240202130534.1051438-8-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 05 Feb 2024 08:45:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2106

Since U-Boot switched away from manual CONFIG_* defines to Kconfig
options, align devicetree documentation accordingly.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

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


