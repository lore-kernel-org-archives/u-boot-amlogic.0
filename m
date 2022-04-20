Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web10.10920.1650477318271028015
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Apr 2022 10:55:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650477312; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=T+JPQUl18J2MLEDZj2fmotScxq6Oi+HgMC9DWngqrn8=;
	b=vgXWG8bMtRnxb4ALifPwC8Wv5W/8t8hURicZV4PmoWIrueXWfXCXxG9RYqfa8uKw5A7jf+
	A57hZg0bofuP78speH7JDci/ihlvIR2vgzezWhtuPddH3Xk4qIhi8bvGbag8JM2GaPqe86
	Xl6GH1Ly4/cKO+YzXv6HxAWKSKfijwONgN6iF3TcHWI7gEk4JHNHm2Hq4DY1WSn9Q0uZVC
	kcuODqrDZ9u3QmJozgRRYx3+g/EhwspVEhyNS3YuCPEC/V7KHZduZCBEz8KTx/BMoq0fbO
	zQDp9RDpQDCF3tYXmF74vL+8OFHUON32RrkBysKfOQL9Y/8z975SNANbVoI7cg==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH 5/5] board: amlogic: jethub j100: enable saradc in config
Date: Wed, 20 Apr 2022 20:55:02 +0300
Message-Id: <20220420175502.2449249-6-adeep@lexina.in>
In-Reply-To: <20220420175502.2449249-1-adeep@lexina.in>
References: <20220420175502.2449249-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Enable ADC in board config file

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 configs/jethub_j100_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfi=
g
index 1c6db9f6a0..a30940bf1c 100644
--- a/configs/jethub_j100_defconfig
+++ b/configs/jethub_j100_defconfig
@@ -17,6 +17,7 @@ CONFIG_REMAKE_ELF=3Dy
 CONFIG_OF_BOARD_SETUP=3Dy
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=3Dy
+CONFIG_CMD_ADC=3Dy
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_EEPROM=3Dy
@@ -34,6 +35,10 @@ CONFIG_OF_CONTROL=3Dy
 CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
 CONFIG_DM_I2C=3Dy
 CONFIG_SYS_I2C_MESON=3Dy
+CONFIG_ADC=3Dy
+CONFIG_SARADC_MESON=3Dy
+CONFIG_CLK=3Dy
+CONFIG_CLK_MESON_AXG=3Dy
 CONFIG_MMC_MESON_GX=3Dy
 CONFIG_MTD_UBI=3Dy
 CONFIG_PHY_REALTEK=3Dy
--=20
2.30.2

