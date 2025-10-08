Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95046CCA470
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 10:01:14 +0000 (UTC)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
 by mx.groups.io with SMTP id smtpd.web11.12047.1759917665025522054
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Oct 2025 03:01:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=FFTgKBFM;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.182, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1759917663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsIc3vYswbYAcn40r/t3zeQIKeu/Q4PsOSYgJi6f4cc=;
	b=FFTgKBFMLwP5OU7Y2zkx/1lZWJslYjVgXb5bsNTH5v0Ng8WR9ljw1S6vZwh7VbUQPhh9hy
	OH9Ey1RWpkUG76vXjqFvOplewsClEoZV8ejk+JG2NP4g4Q/Shro4y0HQrlOXlMzPOdjuXa
	nToQ3lBEbRO/+0eASaoL3o6g/JtDTnZJuE5uyEcX91IzyyajSWFNimr7PTVo2g8/b7v940
	lSfq3qqa1ioqthJl140cq+rC0ZDKgYBCCrnM5T+eQDPD76S7jF07zW0HS1bChMSQFanP4j
	CDXCHB3ohicXXmkKIlazrHeUeUHw5ivMExijdL43E/c5Sn69K+qFV/xrX1K2Tg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Oct 2025 10:00:44 +0000
Subject: [PATCH RFC v3 8/8] doc: board: amlogic: add u-boot-spl
 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-spl-gx-v3-8-5999637df4b9@postmarketos.org>
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
In-Reply-To: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4759;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=2f3do0qs3D/Bmkgh73IjFCHNBpM2kVWOUmVDteNWems=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo5jZVYREwAR57OHGofEsU6QAkb33Q5yMLAhRpk
 sBxe1lT3y6JAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaOY2VQAKCRCEr8vQ14ma
 A1iAD/9PFsvvTnVXxsYrk5mN1ZjQXWUBnh9IN0+gMXMQNCOv9LLwKc+qn2gIcRgeyhlpyqGtQVj
 wtQv1TJ5BC9Y/bNwwhqWl7aHPmjOYmPmSfROHSnjdZBuD37QbBF/+lY9UxWrKKDDAH8vLP0KRdF
 KZJiUQd7Z9jcIB8pI6Oi0Jvj9jsfohKj/DgiF2gXnxSUP8Ggwc8EcoiQGgBuCywxjIJzyio+uAU
 fYwOZlUcW6b288XnRUXgPSCYZ2+to3ZExLHkb5kDaLMSvsQSZsh+s2ckC2d7229C2K35dtixXLE
 D41iu49JIdLPz9+JBTKbUkXqeCkVV00PbNk4c/5nRVNc1veAhFHsp6gJvLmL7pfzAWtX3AKJ3A7
 QxPB7tgMDGdB63nzzHQwkTDg2jF+TJvy5fD4t2wqTKwaJNfWUon0EhXcMQr3RF22GaU+lU47yQ0
 f/CtE+qLlWzmjRSlTR2UdIT6V0eCWbSpxVoAtvxTfcm0HvWshvqGlQVo71WNolg8uZouZWx3YXs
 JXrnRaU6hbVolPh8iZP1W/jL3kAilH07cfQjT55LUFcSQLIPqauo2wprUTl5YR9/7zG2jYW+qd5
 lQ3hdcUnyhwqBcYaeqMULXvSBT9yQs5LUwB7T2IFkGN+NomXY9/daefT6H2iiTXIidYF/nliAAf
 /EWvW9JE5On9rrA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Oct 2025 10:01:14 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2797

Add building and usage instructions for SPL.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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
index 0000000000000000000000000000000000000000..d4223090fe9d119ecf854b32ecde0f872de429b9
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
+are known to work to an extent.
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


