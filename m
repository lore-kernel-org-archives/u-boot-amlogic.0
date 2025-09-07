Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82873CA101F
	for <webhook@archiver.kernel.org>; Sun,  7 Sep 2025 14:36:49 +0000 (UTC)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
 by mx.groups.io with SMTP id smtpd.web10.19828.1757255801190788060
 for <u-boot-amlogic@groups.io>;
 Sun, 07 Sep 2025 07:36:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=Sv4UlMqy;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.185, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757255799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3urdn0i2y0rveWx9927eteeRDQUocDp7ZIVvXuPHIEI=;
	b=Sv4UlMqyKEu1i4XV9mznVwgTUq2st3szCGTX/kXMWPGyyFuKRkvAcJP2bggkwVVTHPhhvd
	uLgLHWNk7oALdj9dVAk9cHzplKip97tpvQcLe9AWEZVqEiCv4UUOuNlUea07An9btLL0WR
	DwF4oYM4yw5t2FFzGvsHiIVOS+6saVWlvAfzyTmuH+txj72giT1Ki6IeOoz/nj7auJJLrH
	AY7aF96A1afm4PAXaRWn8mFXW7av2n8AfxpJ3NPr3zIFPF7boH+uMa7o/opj2jBPUB97Cb
	VjQZf/vAduk5mJvnv+dn+iqjFO7nip0vnSaGMg/+5gdoGAirJT8PbEZRkR02Tg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Sun, 07 Sep 2025 14:36:15 +0000
Subject: [PATCH RFC 9/9] doc: board: amlogic: add u-boot-spl documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-spl-gx-v1-9-37395d9ff5af@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
In-Reply-To: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4698;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=yY8w0blQvMKQVxrsjqwk6dRs1Q0iqFA8ar5K2LLKvNU=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBovZhsbHw9Hartj3qQIpOqVEyLRROjT8Id+1558
 eG6PCfI6TWJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaL2YbAAKCRCEr8vQ14ma
 A9BWD/40RZoq3/1gAQi+PGTeQxS4JBuRzTPMvIJbrcbhU4ozOYXHlvXU152K8yVlHZ7bVzMmPae
 BXwolQevuB0B2O24VHV/owJ386D0k9Al+aXXocc4/+0xiTnVn6oav2H3mMxPl/dGXU9sVqlJh1e
 Wr7QAC73hBfAQm8AocAlCb75fE6cEzFz3ckhcPl549Awg1mmPZEy7NQWHI3dsbSNiY1WBzlMlNE
 MDLNwkx5WgEhbXAPpZUoHeypgf3HbnKSv/aMpILvHRGxaNlpM4OWfrRWM5AiC9lTZVZt6SgoEqJ
 Wpp2k6QNopofFL1MM8n0ZSB55G8FLUWu1d1zkTWoSAgJRFqX6JN9ASttZbhEMJEciZZeMw5L9AJ
 WYJFpYVDaNAa0vG8YQlKfVLs121KdKV0hU+LUgWQlcntDvl7KD5I29xJ3K5O7EvpJlsdFp6yMXl
 HYmA3Bi+lL1SVAy/TWEqtF22M3QQPH4fuWkn4OlV2xVuF+YAwjFSOYS4lnT/PZ+OwtG6UTiOS1H
 vRBFwbQ5rG+sbXrdv07p5CXm7jH9w03x3/sNMcbNIULvl4CHd6o1eT+gZEf3JPHJlqpCzNHIXly
 zs4J3ADuYnsGKBQHlGVgLGt+FCVrfJULziau3LuksrOVXCpFyVAd4rUFuQ2rCDsGs+Lq0Yrpicn
 eLkm9e/VlXdyiKw==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 07 Sep 2025 14:36:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2752

Add building and usage instructions for SPL.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 doc/board/amlogic/index.rst             |  1 +
 doc/board/amlogic/pre-generated-fip.rst |  9 ++++
 doc/board/amlogic/spl.rst               | 77 +++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index dcd935224ac0280a77455e3475a610fd81cfb80d..23380ac33f2b06efff7d4741ce2967d75671ca13 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -78,6 +78,7 @@ Boot Documentation
 
    boot-flow
    pre-generated-fip
+   spl
 
 Board Documentation
 -------------------
diff --git a/doc/board/amlogic/pre-generated-fip.rst b/doc/board/amlogic/pre-generated-fip.rst
index 6a43d776d43f35cbffc7ba9e72bf05dd719f6387..d820bd09115952d4fca2b9e7d7b5a9e30bd11430 100644
--- a/doc/board/amlogic/pre-generated-fip.rst
+++ b/doc/board/amlogic/pre-generated-fip.rst
@@ -98,6 +98,13 @@ The repo also provides the following files used with GXBB boards:
 The repo also supports the open-source 'gxlimg' signing tool that can be used to sign
 U-Boot binaries for GXL/GXM/G12A/G12B/SM1 boards: https://github.com/repk/gxlimg
 
+The following binaries can be replaced with open-source implementations:
+
+- bl2.bin (GXBB and GXL only)
+- bl31.img (GXBB, GXL, AXG and G12A only)
+
+Refer to `Experimental U-Boot SPL Support`_ if you wish to replace them.
+
 Licensing
 ---------
 
@@ -129,3 +136,5 @@ clarified. The current Amlogic distribution licence is below:
     // THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
     // (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
     // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+.. _`Experimental U-Boot SPL Support`: spl.rst
diff --git a/doc/board/amlogic/spl.rst b/doc/board/amlogic/spl.rst
new file mode 100644
index 0000000000000000000000000000000000000000..39d50e3da87d71f62cec1903c441c334bf7020e8
--- /dev/null
+++ b/doc/board/amlogic/spl.rst
@@ -0,0 +1,77 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Experimental U-Boot SPL Support
+===============================
+
+There's some experimental support for some Amlogic SoCs, in U-Boot SPL.  It
+replaces the proprietary bl2.bin blob used for DRAM init.  Currently Meson GX
+SoCs (GXBB, GXL) are supported.
+
+A subset of Amlogic boards have SPL enabled.  These boards have been tested and
+known to work to an extent.
+
+
+Building Arm Trusted Firmware (TF-A)
+------------------------------------
+
+This U-Boot SPL port requires the BL31 stage of mainline Arm Trusted
+Firmware-A firmware. It provides an open source implementation of secure
+software for Armv8-A. Build it with:
+
+.. code-block:: bash
+
+    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
+    $ cd trusted-firmware-a
+    $ make CROSS_COMPILE=aarch64-linux-gnu- PLAT=your_soc DEBUG=1
+
+Replace ``your_soc`` with the SoC target you wish to build for. For GXBB it's
+``gxbb`` and for GXL it's ``gxl``.
+
+
+Building a bl30_new.bin binary
+------------------------------
+
+``bl30_new.bin`` has both ``bl30.bin`` and ``bl301.bin`` binary blobs
+bundled. The former is the proper system control processor firmware and the
+latter is a "plug-in" for board-specific DVFS/suspend-resume parameters. For
+more info you may wish to read this page: `Pre-Generated FIP File Repo`_.
+
+To build using the FIP file repo, simply issue the following commands:
+
+.. code-block:: bash
+
+    $ cd amlogic-boot-fip/your_board
+    $ make bl30_new.bin
+
+
+.. _`Pre-Generated FIP File Repo`: pre-generated-fip.rst
+
+
+U-Boot compilation
+------------------
+
+U-Boot SPL is not enabled by default, instead there are config fragments that
+can be used to enable it, with per-board configuration:
+
+- ``spl-libretech-cc-1gb.config``: 1 GB LePotato board
+- ``spl-libretech-cc-2gb.config``: 2 GB LePotato board
+- ``spl-odroid-c2.config``: ODROID-C2
+- ``spl-videostrong-kii-pro.config``: Videostrong KII Pro
+
+Pick one of them then:
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-linux-gnu-
+    $ export BL31=path/to/tf-a/bl31.bin                 # Upstream TF-A BL31 binary
+    $ export SCP=path/to/bl30_new.bin                   # bl30_new.bin binary
+    $ make <yourboardname>_defconfig spl-<yourboardname>.config
+    $ make
+
+Write to SD:
+
+.. code-block:: bash
+
+    $ DEV=/dev/boot_device
+    $ dd if=u-boot-meson-with-spl.bin of=$DEV conv=fsync,notrunc bs=512 seek=1
+

-- 
2.51.0


