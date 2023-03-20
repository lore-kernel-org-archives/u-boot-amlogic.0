Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.11614.1679312778988081767
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 04:46:19 -0700
Received: by mail-wr1-f44.google.com with SMTP id t15so10034696wrz.7
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 04:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtLZz3+pquEcU8HzOf+k36RUHv2uWugpdgCBCali/z8=;
        b=TdYNIQY65NwCkccTwR/6PQbHYtoBny7zsJjU8rkn/98eqEW7+s5nptS8uR4t+9OZD8
         YWB6hacVStLjykFDMxWj1uuQ03zV158F5ubtYFm6P3yjaPrLQiuTQdjc1NecAM60oL3Z
         DVeE/D6/DuV5g/bNmGCClScVF+EhYZ22QOc2AbxAa1EL4ktRjzTWRNO9gKvKisLyCFgg
         ovhaNBn3dUZrE22FfFy/fxUM13k/LmWy/6OsyFsTSh40djh0OP24Na+jK5HFtrYTyqXQ
         NF1lYXw2FRcXaywj6BN/Y9XNAofp2kPbKVDp+64Z0QeXZy+y4k59GDHibHD9GvjC9aas
         juEw==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 03/33] doc: boards: amlogic: update documentation for pre-generated-fip's
Date: Mon, 20 Mar 2023 11:45:39 +0000
Message-Id: <20230320114609.930145-4-christianshewitt@gmail.com>
In-Reply-To: <20230320114609.930145-1-christianshewitt@gmail.com>
References: <20230320114609.930145-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Improve documentation.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 doc/board/amlogic/pre-generated-fip.rst | 138 +++++++++++++++---------
 1 file changed, 88 insertions(+), 50 deletions(-)

diff --git a/doc/board/amlogic/pre-generated-fip.rst b/doc/board/amlogic/pre-generated-fip.rst
index c63ea616b8..6a43d776d4 100644
--- a/doc/board/amlogic/pre-generated-fip.rst
+++ b/doc/board/amlogic/pre-generated-fip.rst
@@ -1,24 +1,57 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-Pre-Generated FIP file set
-==========================
+Pre-Generated FIP File Repo
+===========================
 
-The Amlogic ARMv8 based SoCs uses a vendor variant of the Trusted Firmware-A
-boot architecture.
+Pre-built Flattened Image Package (FIP) sources and Amlogic signing binaries for many
+commercially available boards and some Android STB devices are collected for use with
+distro build-systems here: https://github.com/LibreELEC/amlogic-boot-fip
 
-You can find documentation on the Trusted Firmware-A architecture on: https://www.trustedfirmware.org/projects/tf-a/
+Using the pre-built FIP sources to sign U-Boot is simple, e.g. for LePotato:
 
-The Trusted Firmware-A uses the following boot elements (simplified):
+.. code-block:: bash
+
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh lepotato /path/to/u-boot/u-boot.bin my-output-dir
+
+Then write U-Boot to SD or eMMC with:
+
+.. code-block:: bash
+
+    $ DEV=/dev/boot_device
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
+
+Files Included
+--------------
+
+Amlogic ARMv8 SoCs use a vendor modified variant of the ARM Trusted Firmware-A boot
+architecture. See documentation here: https://www.trustedfirmware.org/projects/tf-a/
+
+Trusted Firmware-A uses the following boot elements (simplified):
+
+- BL1: First boot step implemented in ROM on Amlogic SoCs
+
+- BL2: Second boot step used to initialize the SoC main clocks & DDR interface. BL21
+  and ACS board-specific binaries must be "inserted" into the BL2 binary before signing
+  and packaging in order to be flashed on the platform
+
+- BL30: Amlogic Secure Co-Processor (SCP) firmware used to handle all system management
+  operations (DVFS, suspend/resume, ..)
+
+- BL301: Amlogic Secure Co-Processor (SCP) board-specific firmware "plug-in" to handle
+  custom DVFS & suspend-resume parameters
 
-- BL1: First boot step, implemented in ROM on Amlogic SoCs
-- BL2: Second boot step, used to initialize the SoC main clocks & DDR interface. The BL21 and ACS board-specific binaries are "inserted" in the BL32 binary before signing/packaging in order to be flashed on the platform.
-- BL30: Amlogic Secure Co-Processor (SCP) firmware used to handle all the system management operations (DVFS, suspend/resume, ...)
-- BL301: Amlogic Secure Co-Processor (SCP) board-specific firmware "plug-in" to handle custom DVFS & suspend-resume parameters
 - BL31: Initializes the interrupt controller and the system management interface (PSCI)
-- BL32 (Optional): Is the Trusted Environment Execution (TEE) Operating System to run secure Trusted Apps, e.g. OP-TEE
+
+- BL32 (Optional): Is the Trusted Environment Execution (TEE) Operating System used to
+  run secure Trusted Apps, e.g. OP-TEE
+
 - BL33: Is the last non-secure step, usually U-Boot which loads Linux
 
-Amlogic provides in binary form:
+Amlogic sources provide the following binaries:
 
 - bl2.bin
 - bl30.bin
@@ -26,10 +59,50 @@ Amlogic provides in binary form:
 - bl31.img
 - bl32.bin
 
-And for lastest SoCs, Amlogic also provides the DDR drivers used by the BL2 binary.
+For G12A/B and SM1 Amlogic also provides DDR drivers used by the BL2 binary:
+
+- ddr4_1d.fw
+- ddr4_2d.fw
+- ddr3_1d.fw
+- piei.fw
+- lpddr4_1d.fw
+- lpddr4_2d.fw
+- diag_lpddr4.fw
+- aml_ddr.fw
+
+The following files are generated from the Amlogic U-Boot fork:
+
+- acs.bin: Contains the PLL & DDR parameters for the board
+- bl301.bin: Contains the DVFS & suspend-resume handling code for the board
+- bl33.bin: U-boot binary image
+
+The acs.bin and bl301.bin files use U-Boot GPL-2.0+ headers and U-Boot build system and
+are thus considered to be issued from GPL-2.0+ source code.
+
+Amlogic alo provides pre-compiled x86_64 and Python2 binaries:
 
-The licence of these files wasn't clear until recently, the currently Amlogic distribution licence
-is the following:
+- aml_encrypt_gxb
+- aml_encrypt_gxl
+- aml_encrypt_g12a
+- aml_encrypt_g12b
+- acs_tool.pyc
+
+The repo replaces the pre-compiled acs_tool.pyc with a Python3 acs_tool.py that can be
+used with modern build hosts.
+
+The repo also provides the following files used with GXBB boards:
+
+- bl1.bin.hardkernel
+- aml_chksum
+
+The repo also supports the open-source 'gxlimg' signing tool that can be used to sign
+U-Boot binaries for GXL/GXM/G12A/G12B/SM1 boards: https://github.com/repk/gxlimg
+
+Licensing
+---------
+
+The licence of Amlogic provided binaries was not historically clear but has now been
+clarified. The current Amlogic distribution licence is below:
 
 .. code-block:: C
 
@@ -56,38 +129,3 @@ is the following:
     // THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
     // (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
     // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-
-The following files are generated from the Amlogic U-Boot fork:
-
-- acs.bin: contains the PLL & DDR parameters for the board
-- bl301.bin: contains the DVFS & suspend-resume handling code for the board
-- bl33.bin: U-boot binary image
-
-The acs.bin & bl301.bin uses the U-Boot GPL-2.0+ headers & build systems, thus those
-are considered issued from GPL-2.0+ source code.
-
-The tools used to sign & package those binary files are delivered in binary format
-for Intel x86-64 and Python 2.x only.
-
-A collection of pre-built with the corresponding Amlogic binaries for the common
-commercially available boards were collected in the https://github.com/LibreELEC/amlogic-boot-fip
-repository.
-
-Using this collection for a commercially available board is very easy.
-
-Here considering the Libre Computer AML-S905X-CC, which codename is `lepotato`:
-
-.. code-block:: bash
-
-    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
-    $ cd amlogic-boot-fip
-    $ mkdir my-output-dir
-    $ ./build-fip.sh lepotato /path/to/u-boot/u-boot.bin my-output-dir
-
-and then write the image to SD with:
-
-.. code-block:: bash
-
-    $ DEV=/dev/your_sd_device
-    $ dd if=my-output-dir/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
-    $ dd if=my-output-dir/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
-- 
2.34.1

