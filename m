Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web12.4175.1657100215815429699
 for <u-boot-amlogic@groups.io>;
 Wed, 06 Jul 2022 02:36:56 -0700
Received: by mail-wr1-f54.google.com with SMTP id b26so21213041wrc.2
        for <u-boot-amlogic@groups.io>; Wed, 06 Jul 2022 02:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmw234IfydZX9XgmwfxRQuWV7mCgdOnNIM8qtLjwTJE=;
        b=K8oLMFoFLbWe5piX+qUG/E+8sfcyXqTNtompWFAKY69dUMuTaxa4qpr6fl5PyFvXt8
         uXwFlQzpdPktiP617frAxzOIVhZ1BYWKSjsjhiLmUQJM+28id8/k1mt8HWaJPmS3kk5e
         yfk1jqYULjJA91uzz77Cme4g1Iu7wWCHb0ajg+k8w9lENq+o51p9VPSNC372Et0+V655
         6FCBf7u0a9MYE8U15hbMHd78GQnl4evj9PngLePjSQZmmJgfwDYYqqbQvuEDKN7q1HPS
         BdavZsMiFXn+fn0SqRja4K5+6JoNPDRFA3/VOsg2YwGNLbn5XSsoGXdqyS5wB+DRUs+0
         xohg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2] doc: board: amlogic: add documentation on boot flow
Date: Wed,  6 Jul 2022 11:36:49 +0200
Message-Id: <20220706093649.3261229-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8169; h=from:subject; bh=NQGmEKrxuQ62rnywUn4IrBeqzomemMuR3z5rvrGAyXs=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBixVelgLZd5o0iAVIaYcba8E4usTgodKvj7KtVqJ27 +1d/aXuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYsVXpQAKCRB33NvayMhJ0cgpEA CQEs6ZMpIGrk6bA8C7baTuSMwNVmMyGSW1dHGA32nTVWNC7wZZ2MflFBLH1sT++JJdv0P1UiTBkqGP UWO5aI6T36+Z0qXBvXG37VAzqQze9b+ROP+u1A/mvoIkXIqbEpVEVFb4SmJoFFuHOS6FPObHncUzda /kzfsEArYERdA2CHu+l44yOdkNC9pBCmJm/ol2BXFCAxFxTXBmfSmZmbte4ilzjjLanRP8heKNEtBg 1vDsFzwCG+hkyIlnG4kWOydqYpl049n9xFrFJXmnNTHnqnv1Z2v4jfME1vEp2xtFdUnmLas5voHHVW Ob8+sS2f1haLFbn5PtNj9Fovnmok4EhL/4ibwRqb9oSXvv2VwOAliAkvHBebww4gMavQZnMgeqsPTj 8QSel6zIBuDvhsbzUemsHff5IXLNYFLhDBZs0xzF2aePGEvc3v8C5WdFIuCXoD7oef/6xgry9p7G3D POW3S7qwfedb+Ce2/7NOAE0qnrwTo8x0F05S2Q6m1vTCdjrMIyW+lQzdo4D9Hut5sI5mIWVhk/GASw KuutRSCptUoIupgV3c1fKKWrQK/xFGA8Z4WN4OrgfFKu9CWwoaTRtPVWIFeSyey/112oKzPLEoG0Dy qCPDdMjxqH4r9Dut9jZwS0ZIlNWDD4ZSyNiG6J9EKFg1oe1xKJvBGz+tr6kA==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>
List-ID: <u-boot-amlogic@groups.io>

This is a preliminary documentation introducing different
boot sequences, and notably the recovery mode.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since v1:
- Christian Hewitt did an overall grammar correction of the text, meaning
  of the text hasn't changed, thus I kept the Reviewed-by tags

 doc/board/amlogic/boot-flow.rst | 134 ++++++++++++++++++++++++++++++++
 doc/board/amlogic/index.rst     |   1 +
 2 files changed, 135 insertions(+)
 create mode 100644 doc/board/amlogic/boot-flow.rst

diff --git a/doc/board/amlogic/boot-flow.rst b/doc/board/amlogic/boot-flow.rst
new file mode 100644
index 0000000000..1ca81f3c89
--- /dev/null
+++ b/doc/board/amlogic/boot-flow.rst
@@ -0,0 +1,134 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Amlogic SoC Boot Flow
+=====================
+
+The Amlogic SoCs have a pre-defined boot sequence in the SoC ROM code. Here are
+the possible boot sources of different SoC families supported by U-Boot:
+
+GX* & AXG family
+----------------
+
++----------+--------------------+-------+-------+---------------+---------------+
+|          |   1                | 2     | 3     |    4          |     5         |
++==========+====================+=======+=======+===============+===============+
+| S905     | POC=0: SPI NOR     | eMMC  | NAND  | SD Card       | USB Device    |
+| S905X    |                    |       |       |               |               |
+| S905L    |                    |       |       |               |               |
+| S905W    |                    |       |       |               |               |
+| S912     |                    |       |       |               |               |
++----------+--------------------+-------+-------+---------------+---------------+
+| S805X    | POC=0: SPI NOR     | eMMC  | NAND  | USB Device    | -             |
+| A113D    |                    |       |       |               |               |
+| A113X    |                    |       |       |               |               |
++----------+--------------------+-------+-------+---------------+---------------+
+
+POC pin: `NAND_CLE`
+
+Some boards provide a button to force USB BOOT which disables the eMMC clock signal
+to bypass the eMMC stage. Others have removable eMMC modules; removing the eMMC and
+SDCard will allow boot from USB.
+
+An exception is the lafrite board (aml-s805x-xx) which has no SDCard slot and boots
+from SPI. The only ways to boot the lafrite board from USB are:
+
+ - Erase the first sectors of SPI NOR flash
+ - Insert an HDMI boot plug forcing boot over USB
+
+The VIM1 and initial VIM2 boards provide a test point on the eMMC signals to block
+the storage from answering and continue to the next boot step.
+
+The USB Device boot uses the first USB interface. On some boards this port is only
+available on an USB-A type connector and needs an special Type-A to Type-A cable to
+communicate with the BootROM.
+
+G12* & SM1 family
+-----------------
+
++-------+-------+-------+---------------+---------------+---------------+---------------+
+| POC0  | POC1  | POC2  | 1             | 2             | 3             | 4             |
++=======+=======+=======+===============+===============+===============+===============+
+| 0     | 0     | 0     | USB Device    | SPI NOR       | NAND/eMMC     | SDCard        |
++-------+-------+-------+---------------+---------------+---------------+---------------+
+| 0     | 0     | 1     | USB Device    | NAND/eMMC     | SDCard        | -             |
++-------+-------+-------+---------------+---------------+---------------+---------------+
+| 0     | 1     | 0     | SPI NOR       | NAND/eMMC     | SDCard        | USB Device    |
++-------+-------+-------+---------------+---------------+---------------+---------------+
+| 0     | 1     | 1     | SPI NAND      | NAND/eMMC     | USB Device    | -             |
++-------+-------+-------+---------------+---------------+---------------+---------------+
+| 1     | 0     | 0     | USB Device    | SPI NOR       | NAND/eMMC     | SDCard        |
++-------+-------+-------+---------------+---------------+---------------+---------------+
+| 1     | 0     | 1     | USB Device    | NAND/eMMC     | SDCard        | -             |
++-------+-------+-------+---------------+---------------+---------------+---------------+
+| 1     | 1     | 0     | SPI NOR       | NAND/eMMC     | SDCard        | USB Device    |
++-------+-------+-------+---------------+---------------+---------------+---------------+
+| 1     | 1     | 1     | NAND/eMMC     | SDCard        | USB Device    | -             |
++-------+-------+-------+---------------+---------------+---------------+---------------+
+
+The last option (1/1/1) is the normal default seen on production devices.
+
+ * POC0 pin: `BOOT_4` (0 and all other 1 means SPI NAND boot first)
+ * POC1 pin: `BOOT_5` (0 and all other 1 means USB Device boot first
+ * POC2 pin: `BOOT_6` (0 and all other 1 means SPI NOR boot first)
+
+Most boards provide a button to force USB BOOT which lowers `BOOT_5` to 0. Some boards
+provide a test point on the eMMC or SPI NOR clock signals to block the storage from
+answering and continue to the next boot step.
+
+The Khadas VIM3/3L boards embed a microcontroller which sets POC signals according
+to its configuration or a specific key press sequence to either boot from SPI NOR
+or eMMC then SDCard, or boot as an USB Device.
+
+The Odroid N2/N2+ has a hardware switch to select between SPI NOR or eMMC boot.
+
+Boot Modes
+----------
+
+ * SDCard
+
+The BootROM fetches the first SDCard sectors in one sequence, then checks the content
+of the data. The BootROM expects to find the FIP binary in sector 1, 512 bytes offset
+from the start.
+
+ * eMMC
+
+The BootROM fetches the first sectors in one sequence, first on the main partition,
+and then on the Boot0 followed by Boot1 HW partitions. After each read, the BootROM
+checks the data and looks to the next partition if it fails. The BootROM expects to
+find the FIP binary in sector 1, 512 bytes offset from the start.
+
+ * SPI NOR
+
+The BootROM fetches the first SPI NOR sectors in one sequence, then checks the content
+of the data. The BootROM expects to find the FIP binary in sector 1, 512 bytes offset
+from the start.
+
+ * NAND & SPI NAND
+
+These modes are rarely used in open platforms and no details are available.
+
+ * USB Device
+
+The BootROM sets the USB Gadget interface to serve a custom USB protocol with the
+USB ID 1b8e:c003. The Amlogic `update` utility is designed to use this protocol. It
+is also implemented in the Amlogic Vendor U-Boot.
+
+The open-source `pyamlboot` utility https://github.com/superna9999/pyamlboot also
+implements this protocol and can load U-Boot in memory in order to start the SoC
+without any attached storage or to recover from a failed/incorrect image flash.
+
+HDMI Recovery
+-------------
+
+The BootROM also briefly reads 8 bytes at address I2C 0x52 offset 0xf8 (248) on the
+HDMI DDC bus. If the content is `boot@USB` it will force USB boot mode. If the content
+is `boot@SDC` it will force SDCard boot mode.
+
+If USB Device doesn't enumerate or SD Card boot step doesn't work, the BootROM will
+continue with the normal boot sequence.
+
+Special boot dongles can be built by connecting a 256bytes EEPROM set to answer on
+address 0x52, and program `boot@USB` or `boot@SDC` at offset 0xf8 (248).
+
+Note: If the SoC is booted with USB Device forced at first step, it will keep the boot
+order on warm reboot. Only cold reboot (power removed) will reset the boot order.
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 9c7fadf2c0..8b9f1e2e1d 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -81,6 +81,7 @@ Boot Documentation
    :maxdepth: 1
 
    pre-generated-fip
+   boot-flow
 
 Board Documentation
 -------------------
-- 
2.25.1

