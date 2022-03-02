Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.5583.1646214150609039009
 for <u-boot-amlogic@groups.io>;
 Wed, 02 Mar 2022 01:42:31 -0800
Received: by mail-wm1-f49.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so2341603wmj.2
        for <u-boot-amlogic@groups.io>; Wed, 02 Mar 2022 01:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TLxfJaqu/WBFsg2tr8XS2aE3YtlthphacIy5+FpdnW8=;
        b=PrExzWDO9Qjes4Eg51fVu2t/gAiIqf1BZerIDNWIpLdOGxnsAkB9SKOrrCSITExGil
         RGomn/z1+5v6Kyy7n0sCdoOGdHS889v1m/Aj9ZcuCEnfo596RlviLSbbA5et6cTVkIEW
         cqa4+nnHSE7+ReEIKvzuDOmszFW0CEcDDa7+GSnkayEjzhYOS4uKuq7rhJoMFKSiXD8q
         D22Wi8Eay2HJ/ZW71agZcG2mWG5dSUcLbk9Q2vprvRV/s3TW3TQ2gvgFx/rl5bzs3jp8
         Qs0PFTkarVYzfweEaQJAtmMaUFtOMV+x4nHYFabbH731udyoz0qzze+4r74Xs3BX9rIs
         iQHw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/2] doc: boards: amlogic: Add documentation on pre-generated FIP files
Date: Wed,  2 Mar 2022 10:42:22 +0100
Message-Id: <20220302094222.566314-2-narmstrong@baylibre.com>
In-Reply-To: <20220302094222.566314-1-narmstrong@baylibre.com>
References: <20220302094222.566314-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: christianshewitt@gmail.com, adeep@lexina.in, b.galvani@gmail.com, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

It add documentation on licencing & provides links to the amlogic-boot-fip
pre-built files collections.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 doc/board/amlogic/beelink-gtking.rst    |  2 +
 doc/board/amlogic/beelink-gtkingpro.rst |  2 +
 doc/board/amlogic/index.rst             |  8 +++
 doc/board/amlogic/jethub-j100.rst       |  2 +
 doc/board/amlogic/jethub-j80.rst        |  2 +
 doc/board/amlogic/khadas-vim.rst        |  2 +
 doc/board/amlogic/khadas-vim2.rst       |  2 +
 doc/board/amlogic/khadas-vim3.rst       |  2 +
 doc/board/amlogic/khadas-vim3l.rst      |  2 +
 doc/board/amlogic/libretech-ac.rst      |  2 +
 doc/board/amlogic/libretech-cc.rst      |  2 +
 doc/board/amlogic/nanopi-k2.rst         |  2 +
 doc/board/amlogic/odroid-c2.rst         |  2 +
 doc/board/amlogic/odroid-c4.rst         |  2 +
 doc/board/amlogic/odroid-n2.rst         |  2 +
 doc/board/amlogic/p200.rst              |  2 +
 doc/board/amlogic/p201.rst              |  2 +
 doc/board/amlogic/p212.rst              |  2 +
 doc/board/amlogic/pre-generated-fip.rst | 93 +++++++++++++++++++++++++
 doc/board/amlogic/radxa-zero.rst        |  2 +
 doc/board/amlogic/s400.rst              |  2 +
 doc/board/amlogic/sei510.rst            |  2 +
 doc/board/amlogic/sei610.rst            |  2 +
 doc/board/amlogic/u200.rst              |  2 +
 doc/board/amlogic/wetek-core2.rst       |  2 +
 25 files changed, 147 insertions(+)
 create mode 100644 doc/board/amlogic/pre-generated-fip.rst

diff --git a/doc/board/amlogic/beelink-gtking.rst b/doc/board/amlogic/beelink-gtking.rst
index 56ce2cb273..2fb50c5f7b 100644
--- a/doc/board/amlogic/beelink-gtking.rst
+++ b/doc/board/amlogic/beelink-gtking.rst
@@ -44,6 +44,8 @@ https://github.com/LibreELEC/amlogic-boot-fip/tree/master/beelink-s922x
 NB: Beelink use a common board config for GT-King, GT-King Pro and the
 GS-King-X model, hence the "beelink-s922x" name.
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `beelink-s922x`
+
 .. code-block:: bash
 
     $ wget https://github.com/LibreELEC/amlogic-boot-fip/archive/master.zip
diff --git a/doc/board/amlogic/beelink-gtkingpro.rst b/doc/board/amlogic/beelink-gtkingpro.rst
index d750351361..07bb04bb36 100644
--- a/doc/board/amlogic/beelink-gtkingpro.rst
+++ b/doc/board/amlogic/beelink-gtkingpro.rst
@@ -45,6 +45,8 @@ https://github.com/LibreELEC/amlogic-boot-fip/tree/master/beelink-s922x
 NB: Beelink use a common board config for GT-King, GT-King Pro and the
 GS-King-X model, hence the "beelink-s922x" name.
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `beelink-s922x`
+
 .. code-block:: bash
 
     $ wget https://github.com/LibreELEC/amlogic-boot-fip/archive/master.zip
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 189b1efe2b..9ef1440433 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -74,6 +74,14 @@ This matrix concerns the actual source code version.
 | PCIe (+NVMe)                  | *N/A*     | *N/A*           | *N/A*        | **Yes**     | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+
 
+Boot Documentation
+------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   pre-generated-fip
+
 Board Documentation
 -------------------
 
diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub-j100.rst
index 58602787d3..d54519aaef 100644
--- a/doc/board/amlogic/jethub-j100.rst
+++ b/doc/board/amlogic/jethub-j100.rst
@@ -37,6 +37,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `jethub-j100`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain binaries
 from the git tree published by the board vendor:
diff --git a/doc/board/amlogic/jethub-j80.rst b/doc/board/amlogic/jethub-j80.rst
index 6b7bdc78b1..f669a0118d 100644
--- a/doc/board/amlogic/jethub-j80.rst
+++ b/doc/board/amlogic/jethub-j80.rst
@@ -33,6 +33,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `jethub-j80`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain binaries
 from the git tree published by the board vendor:
diff --git a/doc/board/amlogic/khadas-vim.rst b/doc/board/amlogic/khadas-vim.rst
index bbb61c29ef..04025d737c 100644
--- a/doc/board/amlogic/khadas-vim.rst
+++ b/doc/board/amlogic/khadas-vim.rst
@@ -30,6 +30,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `khadas-vim`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/khadas-vim2.rst b/doc/board/amlogic/khadas-vim2.rst
index c57d96d8b0..7ac3bdcbaf 100644
--- a/doc/board/amlogic/khadas-vim2.rst
+++ b/doc/board/amlogic/khadas-vim2.rst
@@ -31,6 +31,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `khadas-vim2`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/khadas-vim3.rst b/doc/board/amlogic/khadas-vim3.rst
index 8b7196d988..73dc32b79b 100644
--- a/doc/board/amlogic/khadas-vim3.rst
+++ b/doc/board/amlogic/khadas-vim3.rst
@@ -57,6 +57,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `khadas-vim3`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/khadas-vim3l.rst b/doc/board/amlogic/khadas-vim3l.rst
index aed8955391..692ab3d21d 100644
--- a/doc/board/amlogic/khadas-vim3l.rst
+++ b/doc/board/amlogic/khadas-vim3l.rst
@@ -57,6 +57,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `khadas-vim3l`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/libretech-ac.rst b/doc/board/amlogic/libretech-ac.rst
index 39bae86d32..7a915f9f26 100644
--- a/doc/board/amlogic/libretech-ac.rst
+++ b/doc/board/amlogic/libretech-ac.rst
@@ -30,6 +30,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `lafrite`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/libretech-cc.rst b/doc/board/amlogic/libretech-cc.rst
index 94c74c5a8b..596ce45dc4 100644
--- a/doc/board/amlogic/libretech-cc.rst
+++ b/doc/board/amlogic/libretech-cc.rst
@@ -54,6 +54,8 @@ These binaries and the tools required below have been collected and prebuilt
 for convenience at <https://github.com/BayLibre/u-boot/releases/>. These
 apply to both v1 and v2.
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `lepotato`
+
 Download and extract the libretech-cc release from there, and set FIPDIR to
 point to the `fip` subdirectory.
 
diff --git a/doc/board/amlogic/nanopi-k2.rst b/doc/board/amlogic/nanopi-k2.rst
index 1222ee4e85..76ff874434 100644
--- a/doc/board/amlogic/nanopi-k2.rst
+++ b/doc/board/amlogic/nanopi-k2.rst
@@ -30,6 +30,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `nanopi-k2`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/odroid-c2.rst b/doc/board/amlogic/odroid-c2.rst
index 966c18b36e..8a1be4bf55 100644
--- a/doc/board/amlogic/odroid-c2.rst
+++ b/doc/board/amlogic/odroid-c2.rst
@@ -30,6 +30,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `odroid-c2`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/odroid-c4.rst b/doc/board/amlogic/odroid-c4.rst
index f66d60a54d..b512c6a3d8 100644
--- a/doc/board/amlogic/odroid-c4.rst
+++ b/doc/board/amlogic/odroid-c4.rst
@@ -34,6 +34,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `odroid-c4` or `odroid-hc4`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/odroid-n2.rst b/doc/board/amlogic/odroid-n2.rst
index fe63113230..7aad36e003 100644
--- a/doc/board/amlogic/odroid-n2.rst
+++ b/doc/board/amlogic/odroid-n2.rst
@@ -29,6 +29,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `odroid-n2` or `odroid-n2-plus`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/p200.rst b/doc/board/amlogic/p200.rst
index 1c84f1c9d0..5e7c6b0276 100644
--- a/doc/board/amlogic/p200.rst
+++ b/doc/board/amlogic/p200.rst
@@ -31,6 +31,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `p200`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/p201.rst b/doc/board/amlogic/p201.rst
index a3d451c6e6..2cd236582a 100644
--- a/doc/board/amlogic/p201.rst
+++ b/doc/board/amlogic/p201.rst
@@ -31,6 +31,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `p201`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/p212.rst b/doc/board/amlogic/p212.rst
index e2f3fe313b..c1b73e83b1 100644
--- a/doc/board/amlogic/p212.rst
+++ b/doc/board/amlogic/p212.rst
@@ -31,6 +31,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `p212`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/pre-generated-fip.rst b/doc/board/amlogic/pre-generated-fip.rst
new file mode 100644
index 0000000000..c63ea616b8
--- /dev/null
+++ b/doc/board/amlogic/pre-generated-fip.rst
@@ -0,0 +1,93 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Pre-Generated FIP file set
+==========================
+
+The Amlogic ARMv8 based SoCs uses a vendor variant of the Trusted Firmware-A
+boot architecture.
+
+You can find documentation on the Trusted Firmware-A architecture on: https://www.trustedfirmware.org/projects/tf-a/
+
+The Trusted Firmware-A uses the following boot elements (simplified):
+
+- BL1: First boot step, implemented in ROM on Amlogic SoCs
+- BL2: Second boot step, used to initialize the SoC main clocks & DDR interface. The BL21 and ACS board-specific binaries are "inserted" in the BL32 binary before signing/packaging in order to be flashed on the platform.
+- BL30: Amlogic Secure Co-Processor (SCP) firmware used to handle all the system management operations (DVFS, suspend/resume, ...)
+- BL301: Amlogic Secure Co-Processor (SCP) board-specific firmware "plug-in" to handle custom DVFS & suspend-resume parameters
+- BL31: Initializes the interrupt controller and the system management interface (PSCI)
+- BL32 (Optional): Is the Trusted Environment Execution (TEE) Operating System to run secure Trusted Apps, e.g. OP-TEE
+- BL33: Is the last non-secure step, usually U-Boot which loads Linux
+
+Amlogic provides in binary form:
+
+- bl2.bin
+- bl30.bin
+- bl30.bin
+- bl31.img
+- bl32.bin
+
+And for lastest SoCs, Amlogic also provides the DDR drivers used by the BL2 binary.
+
+The licence of these files wasn't clear until recently, the currently Amlogic distribution licence
+is the following:
+
+.. code-block:: C
+
+    // Copyright (C) 2018 Amlogic, Inc. All rights reserved.
+    //
+    // All information contained herein is Amlogic confidential.
+    //
+    // This software is provided to you pursuant to Software License
+    // Agreement (SLA) with Amlogic Inc ("Amlogic"). This software may be
+    // used only in accordance with the terms of this agreement.
+    //
+    // Redistribution and use in source and binary forms, with or without
+    // modification is strictly prohibited without prior written permission
+    // from Amlogic.
+    //
+    // THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+    // "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+    // LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+    // A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+    // OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+    // SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+    // LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+    // DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+    // THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+    // (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+    // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+The following files are generated from the Amlogic U-Boot fork:
+
+- acs.bin: contains the PLL & DDR parameters for the board
+- bl301.bin: contains the DVFS & suspend-resume handling code for the board
+- bl33.bin: U-boot binary image
+
+The acs.bin & bl301.bin uses the U-Boot GPL-2.0+ headers & build systems, thus those
+are considered issued from GPL-2.0+ source code.
+
+The tools used to sign & package those binary files are delivered in binary format
+for Intel x86-64 and Python 2.x only.
+
+A collection of pre-built with the corresponding Amlogic binaries for the common
+commercially available boards were collected in the https://github.com/LibreELEC/amlogic-boot-fip
+repository.
+
+Using this collection for a commercially available board is very easy.
+
+Here considering the Libre Computer AML-S905X-CC, which codename is `lepotato`:
+
+.. code-block:: bash
+
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh lepotato /path/to/u-boot/u-boot.bin my-output-dir
+
+and then write the image to SD with:
+
+.. code-block:: bash
+
+    $ DEV=/dev/your_sd_device
+    $ dd if=my-output-dir/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=my-output-dir/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
diff --git a/doc/board/amlogic/radxa-zero.rst b/doc/board/amlogic/radxa-zero.rst
index 423403f3c7..f5611f52ec 100644
--- a/doc/board/amlogic/radxa-zero.rst
+++ b/doc/board/amlogic/radxa-zero.rst
@@ -34,6 +34,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `radxa-zero`
+
 Amlogic does not provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 git trees published by the board vendor:
diff --git a/doc/board/amlogic/s400.rst b/doc/board/amlogic/s400.rst
index 52c7b27332..c92817b421 100644
--- a/doc/board/amlogic/s400.rst
+++ b/doc/board/amlogic/s400.rst
@@ -31,6 +31,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `s400`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/sei510.rst b/doc/board/amlogic/sei510.rst
index 2d296b1c3c..c55e778494 100644
--- a/doc/board/amlogic/sei510.rst
+++ b/doc/board/amlogic/sei510.rst
@@ -27,6 +27,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `sei510`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/sei610.rst b/doc/board/amlogic/sei610.rst
index 9434e6f023..2d754497cc 100644
--- a/doc/board/amlogic/sei610.rst
+++ b/doc/board/amlogic/sei610.rst
@@ -29,6 +29,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `sei610`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/u200.rst b/doc/board/amlogic/u200.rst
index 5aa3936c28..53213fdb68 100644
--- a/doc/board/amlogic/u200.rst
+++ b/doc/board/amlogic/u200.rst
@@ -32,6 +32,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `u200`
+
 Amlogic doesn't provide sources for the firmware and for tools needed
 to create the bootloader image, so it is necessary to obtain them from
 the git tree published by the board vendor:
diff --git a/doc/board/amlogic/wetek-core2.rst b/doc/board/amlogic/wetek-core2.rst
index 1012079ded..0147d5fbe2 100644
--- a/doc/board/amlogic/wetek-core2.rst
+++ b/doc/board/amlogic/wetek-core2.rst
@@ -29,6 +29,8 @@ U-Boot compilation
 Image creation
 --------------
 
+For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `wetek-core2`
+
 Amlogic does not provide sources for the firmware or the tools needed
 to create the bootloader image, and WeTek has not publicly shared the
 precompiled FIP binaries. However the public Khadas VIM2 sources also
-- 
2.25.1

