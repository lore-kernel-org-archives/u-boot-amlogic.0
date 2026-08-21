Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3945DC61DB4
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:45 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3491.1787302425559182325
 for <u-boot-amlogic@groups.io>;
 Fri, 21 Aug 2026 01:53:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: tanurelinux@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b457a0b4e5so795755e87.1
        for <u-boot-amlogic@groups.io>; Fri, 21 Aug 2026 01:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302423; x=1787907223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bn4LLlOyWovEIEPS509pZhNY38vgNUfs3BgGv8h3/5o=;
        b=D8InY9mNceNh+lRaUHcNyxQrxlQEP6vQpFNTII6GOXqkXCQ4+GFztaDAN+QFFj1rlx
         Ukub2FHjdHWd+j54qtrVgyWvfcdFcGgINLrsHi8fqMLSwxSbaAZ8O85Gqk3t9ln+bFCu
         CTgrN1hFSafI8Ka33YITVIXtvrp0dpHU101aF9wGAdqnvq7SEphugBkqm98OGPVbHy4I
         SeoyjEDUUtOaTKoy/gSvCewTaM8PN3P+LJO7SLBiwCW3W+inpS1GxHrPiAiNsmWA1SWy
         qoa9CXiyp2ygxjqLGkJyZ31JAtgTn1nrxMiZ/zTRDmKe5To9af0FlgVg1tFHbgH+ssfM
         Whow==
X-Forwarded-Encrypted: i=1; AHgh+RplwP+bKiD2yNp+rdkCY6MbBU82tK0QldI/nj9aiVjVoqW88PAjDlpVj2RLHb1j1pxB/zrcQbT24swUVBqNmQ==@groups.io
X-Gm-Message-State: AFuF++mJg41xQyP1Yz8+WIejcwBSY9BEILQDW8iVHAecLdMiLzn1kPOA
	/ILbUSINE9/HHVaR2uGAZsEBuiA7RU/kieDeUcIbr1Nkq/LJPurOBMif0XhRRQ==
X-Gm-Gg: AR+sD11T2+/VeCuKbiXWVBYrsZpIKmd1u9ZLsMsd0rTX2z53CLJvRAhzyAzTBGAuEK8
	Z7axYD4vxpfywxcA9AzayLV8RfI5E1CUZqY7G/W5fNFc+GEhkC5xfYiZ3jQ6Yfvd2wRt2GbLnlD
	IAIN58vc+bI11P3Z/B8amQtb/UDl+BJAD0b14tq92wE79WteuYiNL2aPL88lfGZtSXNc2Q9lIVO
	ukSpcx8+DGDquSy4SvkPGB8Q6+C4Hn8AFomO3wYbgYahu0RltLcVwFXU4kgBA7tnxRvFJ8eCvnz
	FPc/6tda4pUqiKvSVm6XwZK7oWhif3w40OOpoyKffmFjKiotgZRwpfn5OK4p9/dhF4vM6d4b7v/
	pjZ4oXVMWnRx4E9JSeDLg0nx0oG3T+OmZ2+jZTMynxSkqeDwsrEIDGml5XRn5UUcRZYAo9Iym9B
	L/i7KVqhakcEM3FNmS9ZUE28Z/F4/SS38o9+xHrrqWhBCnjDovXSW/fA7BgPMeEQ0tCJq/UaRCl
	7WYJ71y9P32qtBe6L2Bg1xm+v8f
X-Received: by 2002:a05:600c:1387:b0:499:7a4f:d13d with SMTP id 5b1f17b1804b1-499b8313ad3mr55694775e9.4.1787301970941;
        Fri, 21 Aug 2026 01:46:10 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90e747esm22978115e9.4.2026.08.21.01.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:46:10 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org,
	trini@konsulko.com,
	ilias.apalodimas@linaro.org,
	funderscore@postmasteros.org,
	u-boot-amlogic@groups.io
Subject: [PATCH v2 4/4] doc: board: amlogic: add Khadas VIM4 documentation
Date: Fri, 21 Aug 2026 09:46:03 +0100
Message-ID: <20260821084603.25974-5-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084603.25974-1-tanure@linux.com>
References: <20260821084603.25974-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3043

Document building U-Boot for the Khadas VIM4, chainloading it from the
vendor U-Boot for development, and packaging the boot image with the
vendor tooling, and add the A311D2 to the support matrix.

Notably, the SD card image layout differs from older Amlogic SoCs:
sector 0 is a checksummed BootROM header (a partition table may
coexist in its MBR slots), so when writing the bootloader the first
sector must be written along with it.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 board/amlogic/vim4/MAINTAINERS    |   1 +
 doc/board/amlogic/index.rst       | 119 ++++++++++++++---------------
 doc/board/amlogic/khadas-vim4.rst | 122 ++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+), 59 deletions(-)
 create mode 100644 doc/board/amlogic/khadas-vim4.rst

diff --git a/board/amlogic/vim4/MAINTAINERS b/board/amlogic/vim4/MAINTAINERS
index 5e1ec98b571..b2e5717e846 100644
--- a/board/amlogic/vim4/MAINTAINERS
+++ b/board/amlogic/vim4/MAINTAINERS
@@ -5,3 +5,4 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/vim4/
 F:	configs/khadas-vim4_defconfig
 F:	arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
+F:	doc/board/amlogic/khadas-vim4.rst
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 23380ac33f2..0785d495d38 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -10,65 +10,65 @@ An up-do-date matrix is also available on: http://linux-meson.com
 
 This matrix concerns the actual source code version.
 
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| SoCs              | S905      | S805X    | S912     | A113X    | S905X2   | S922X    | S905X3   |
-|                   |           | S905X    | S905D    |          | S905D2   | A311D    | S905D3   |
-|                   |           | S905W    |          |          | S905Y2   |          |          |
-+===================+===========+==========+==========+==========+==========+==========+==========+
-| UART              | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Pinctrl/GPIO      | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Clock Control     | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| PWM               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Reset Control     | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Infrared Decoder  | No        | No       | No       | No       | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Ethernet          | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Multi-core        | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Fuse access       | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| SPI (FC)          | **Yes**   | **Yes**  | **Yes**  | **Yes**  |**Yes**   | **Yes**  | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| SPI (CC)          | No        | No       | No       | No       | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| I2C               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| USB               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| USB OTG           | No        | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| eMMC              | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| SDCard            | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| NAND              | No        | No       | No       | No       | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| ADC               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| CVBS Output       | **Yes**   | **Yes**  | **Yes**  | *N/A*    | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| HDMI Output       | **Yes**   | **Yes**  | **Yes**  | *N/A*    | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| CEC               | No        | No       | No       | *N/A*    | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Thermal Sensor    | No        | No       | No       | No       | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| LCD/LVDS Output   | No        | *N/A*    | No       | No       | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| MIPI DSI Output   | *N/A*     | *N/A*    | *N/A*    | No       | No       | No       | No       |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| SoC Rev/Info      | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| PCIe (+NVMe)      | *N/A*     | *N/A*    | *N/A*    | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
-| Watchdog          | *N/A*     | **Yes**  | *N/A*    | *N/A*    | *N/A*    | *N/A*    | *N/A*    |
-+-------------------+-----------+----------+----------+----------+----------+----------+----------+
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| SoCs              | S905      | S805X    | S912     | A113X    | S905X2   | S922X    | S905X3   | A311D2   |
+|                   |           | S905X    | S905D    |          | S905D2   | A311D    | S905D3   |          |
+|                   |           | S905W    |          |          | S905Y2   |          |          |          |
++===================+===========+==========+==========+==========+==========+==========+==========+==========+
+| UART              | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Pinctrl/GPIO      | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Clock Control     | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| PWM               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Reset Control     | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Infrared Decoder  | No        | No       | No       | No       | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Ethernet          | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Multi-core        | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Fuse access       | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| SPI (FC)          | **Yes**   | **Yes**  | **Yes**  | **Yes**  |**Yes**   | **Yes**  | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| SPI (CC)          | No        | No       | No       | No       | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| I2C               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| USB               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| USB OTG           | No        | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| eMMC              | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| SDCard            | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| NAND              | No        | No       | No       | No       | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| ADC               | **Yes**   | **Yes**  | **Yes**  | **Yes**  | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| CVBS Output       | **Yes**   | **Yes**  | **Yes**  | *N/A*    | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| HDMI Output       | **Yes**   | **Yes**  | **Yes**  | *N/A*    | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| CEC               | No        | No       | No       | *N/A*    | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Thermal Sensor    | No        | No       | No       | No       | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| LCD/LVDS Output   | No        | *N/A*    | No       | No       | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| MIPI DSI Output   | *N/A*     | *N/A*    | *N/A*    | No       | No       | No       | No       | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| SoC Rev/Info      | **Yes**   | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| PCIe (+NVMe)      | *N/A*     | *N/A*    | *N/A*    | **Yes**  | **Yes**  | **Yes**  | **Yes**  | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
+| Watchdog          | *N/A*     | **Yes**  | *N/A*    | *N/A*    | *N/A*    | *N/A*    | *N/A*    | No       |
++-------------------+-----------+----------+----------+----------+----------+----------+----------+----------+
 
 Boot Documentation
 ------------------
@@ -102,6 +102,7 @@ Board Documentation
    khadas-vim2
    khadas-vim3
    khadas-vim3l
+   khadas-vim4
    libretech-ac
    libretech-cc
    nanopi-k2
diff --git a/doc/board/amlogic/khadas-vim4.rst b/doc/board/amlogic/khadas-vim4.rst
new file mode 100644
index 00000000000..a42a5610877
--- /dev/null
+++ b/doc/board/amlogic/khadas-vim4.rst
@@ -0,0 +1,122 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for Khadas VIM4 (A311D2)
+===============================
+
+Khadas VIM4 is a Single Board Computer manufactured by Shenzhen Wesion
+Technology Co. Ltd with the following specifications:
+
+ - Amlogic A311D2 (T7 family) Arm Cortex-A53 quad-core + Cortex-A73 quad-core SoC
+ - 8GB LPDDR4X SDRAM
+ - Gigabit Ethernet
+ - HDMI 2.1 display output, HDMI input
+ - 40-pin GPIO header
+ - 1 x USB 3.0 Host, 1 x USB 2.0 Host/OTG
+ - 32GB eMMC, microSD
+ - M.2 socket
+ - 32MB SPI-NOR flash with the OOWOW recovery system
+ - Infrared receiver
+
+Schematics are available on the manufacturer website.
+
+Current U-Boot support covers the UART console, DRAM and PSCI reset,
+booting either chainloaded from the vendor U-Boot or as BL33 from
+power-on, packaged into the vendor boot image. Storage, network and
+USB are not supported yet.
+
+The serial console runs at 921600 baud, the Khadas convention for this
+board (this is also the rate the vendor firmware configures).
+
+U-Boot Compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-linux-gnu-
+    $ make khadas-vim4_defconfig
+    $ make
+
+Chainloading from the vendor U-Boot
+-----------------------------------
+
+The resulting u-boot.bin is position independent and can be run directly
+from the vendor U-Boot prompt, for example over TFTP:
+
+.. code-block:: none
+
+    kvim4# dhcp
+    kvim4# setenv serverip <tftp server address>
+    kvim4# tftpboot 0x01080000 u-boot.bin
+    kvim4# go 0x01080000
+
+Note: use load addresses in the vendor kernel load area, like 0x01080000
+above. Other areas, e.g. 0x08000000, are not mapped by the vendor U-Boot
+and loading there makes it crash.
+
+Boot image packaging
+--------------------
+
+There is no open-source tool yet that can assemble a bootable image for
+the T7 family: the BootROM and BL2 only accept an image signed by the
+Amlogic tooling shipped in the vendor U-Boot tree, with u-boot.bin
+taking the BL33 slot. The vendor tree and its packaging flow are
+available from https://github.com/khadas/u-boot (branch
+khadas-vims-v2019.01, see fip/mk_script.sh) or through the Khadas Fenix
+build system, https://github.com/khadas/fenix.
+
+To generate an SD card image, first build the vendor package once (for
+example with Fenix: select VIM4 and U-Boot 2019.01, then "make uboot");
+this compiles the vendor tree and leaves all the signed stages and
+tools in <vendor tree>/fip/_tmp. Then replace the BL33 payload with the
+mainline u-boot.bin and rebuild the device FIP:
+
+.. code-block:: bash
+
+    $ VENDOR=/path/to/khadas-u-boot
+    $ T7=$VENDOR/fip/t7
+    $ TMP=$VENDOR/fip/_tmp
+
+    # wrap and LZ4-compress u-boot.bin as the BL33 payload (1.5 MiB slot)
+    $ $T7/aml_encrypt_t7 --bl3sig --input u-boot.bin --output bl33.lz4 \
+          --compress lz4 --level v3 --type bl33
+    $ dd if=bl33.lz4 of=bl33.body bs=1 skip=1824
+    $ dd if=/dev/zero of=bl33-payload.bin bs=1572864 count=1
+    $ dd if=bl33.body of=bl33-payload.bin conv=notrunc
+
+    # rebuild the device FIP with the new BL33
+    $ $T7/binary-tool/acpu-imagetool create-device-fip \
+          --infile-template-chipset-fip-header=$TMP/device-fip-header.bin \
+          --infile-bl30-payload=$TMP/bl30-payload.bin \
+          --infile-bl33-payload=bl33-payload.bin \
+          --infile-blob-bl40=$TMP/blob-bl40.bin.signed \
+          --infile-blob-bl31=$TMP/blob-bl31.bin.signed \
+          --infile-blob-bl32=$TMP/blob-bl32.bin.signed \
+          --outfile-device-fip=device-fip.bin.signed
+
+    # all payload slots are fixed-size: patch the new device FIP into
+    # the vendor SD image at its fixed offset
+    $ cp $TMP/u-boot.bin.sd.bin.signed .
+    $ dd if=device-fip.bin.signed of=u-boot.bin.sd.bin.signed \
+          bs=512 seek=1313 conv=notrunc
+
+The resulting image for SD cards is u-boot.bin.sd.bin.signed.
+
+Unlike older Amlogic SoCs, sector 0 of the T7 SD image is a checksummed
+BootROM header, not only a partition table: the image must be written
+from sector 0 so the header is written too. A partition table may
+coexist in the MBR slots of the same sector, as the vendor SD images
+do:
+
+.. code-block:: bash
+
+    $ dd if=u-boot.bin.sd.bin.signed of=/dev/<sd card> bs=512 conv=fsync
+
+The BootROM tries SD before eMMC, so a valid SD card image always takes
+precedence. If no valid boot image is found, the board falls back to the
+OOWOW recovery system in SPI-NOR flash.
+
+Note that the BootROM only considers the SD card on cold boots: after a
+warm reset (e.g. the U-Boot "reset" command) it goes straight to eMMC
+and then SPI-NOR. Power-cycle the board to boot from SD again, or write
+the eMMC variant of the image (u-boot.bin.signed) to the eMMC boot area
+to make it the default for both boot paths.
-- 
2.55.0


