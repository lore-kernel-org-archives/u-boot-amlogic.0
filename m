Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by mx.groups.io with SMTP id smtpd.web11.3832.1583284668310742454
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Mar 2020 17:17:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1583284664;
	bh=X/KniNbsDMNbWxlJGXpo6BrBw8qqx36zULiEJB1L++g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NFQAoOmM4YkErR4QdkamQEVb1sJT2r2q3Z9bdK2b3LoH9h6+lQRZGr0KVeQGtY46A
	 pxOs3ko11pj4aP4CGlK86ayB416U4sjubJLyKxwQUCt4HeVYwvTJ9sdnAvO8iTQWnT
	 6lfae5LGrmYfq/XjEHDgOs3WcfMRpcFig4PXwWc0=
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/2] drivers/rng: simplify Kconfig
Date: Wed,  4 Mar 2020 02:17:37 +0100
Message-Id: <20200304011738.33763-2-xypron.glpk@gmx.de>
In-Reply-To: <20200304011738.33763-1-xypron.glpk@gmx.de>
References: <20200304011738.33763-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, u-boot-amlogic@groups.io, u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
List-ID: <u-boot-amlogic@groups.io>

For all sandbox systems with DM_RNG we enable RNG_SANDBOX. So we can simpl=
y
set the default to yes.

All rng drivers depend on DM_RNG. Use a single 'if' instead of individual
dependencies. Now 'make menuconfig' shows the individual drivers neatly
indented under the DM_RNG entry.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 configs/sandbox64_defconfig | 1 -
 configs/sandbox_defconfig   | 1 -
 drivers/rng/Kconfig         | 9 +++++++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index d1c94b65a1..71a4d7fccb 100644
=2D-- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -169,7 +169,6 @@ CONFIG_REMOTEPROC_SANDBOX=3Dy
 CONFIG_DM_RESET=3Dy
 CONFIG_SANDBOX_RESET=3Dy
 CONFIG_DM_RNG=3Dy
-CONFIG_RNG_SANDBOX=3Dy
 CONFIG_DM_RTC=3Dy
 CONFIG_RTC_RV8803=3Dy
 CONFIG_SANDBOX_SERIAL=3Dy
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 45b5475b79..f96891ecae 100644
=2D-- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -189,7 +189,6 @@ CONFIG_REMOTEPROC_SANDBOX=3Dy
 CONFIG_DM_RESET=3Dy
 CONFIG_SANDBOX_RESET=3Dy
 CONFIG_DM_RNG=3Dy
-CONFIG_RNG_SANDBOX=3Dy
 CONFIG_DM_RTC=3Dy
 CONFIG_RTC_RV8803=3Dy
 CONFIG_DEBUG_UART_SANDBOX=3Dy
diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index 893b89d49b..c1aa43b823 100644
=2D-- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -6,16 +6,21 @@ config DM_RNG
 	  This interface is used to initialise the rng device and to
 	  read the random seed from the device.

+if DM_RNG
+
 config RNG_SANDBOX
 	bool "Sandbox random number generator"
-	depends on SANDBOX && DM_RNG
+	depends on SANDBOX
+	default y
 	help
 	  Enable random number generator for sandbox. This is an
 	  emulation of a rng device.

 config RNG_STM32MP1
 	bool "Enable random number generator for STM32MP1"
-	depends on ARCH_STM32MP && DM_RNG
+	depends on ARCH_STM32MP
 	default n
 	help
 	  Enable STM32MP1 rng driver.
+
+endif
=2D-
2.25.1

