Received: from mx.msync.work (mx.msync.work [95.217.35.189])
 by mx.groups.io with SMTP id smtpd.web10.24076.1633432386581933193
 for <u-boot-amlogic@groups.io>;
 Tue, 05 Oct 2021 04:13:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1633432383; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=CJHkHLVw11N9S5vloUNxbykbz528HKiVidVEnWatWWQ=;
	b=SaNk8e74wL+1VnfC+j4f7Q9dTtpjXu7Wm2dAmp54SROMX+wVQyXevURu2fjMGL8/cOdSv8
	2ZgmCHZZ5d3I/BKYzRXfSgcEP4pY6e8oDbffv8X3vzuAozavSWHWyXqjPLDKHf3nM4Enbv
	cvr2VyNRH/ch+pSD8Q6+ffiqQtg7Seb79lVEKYoz79tLMCXNsAFcDaNEqi2+a7JtlKNtQb
	XaxN4enoIK/XVLHqHlUlObZE1vn5s/rzOGn8L21Dn7a+V0VKRcQE6rDrOHg8LvQu8aRDeU
	c3rWeU2DAf7FP7VRexSfV9HkwRtBgJ8Q7qS99fqSG6/JpFKIaR2OIHV2qKJU8Q==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH] ARM: amlogic: add SYS_LOAD_ADDR to JetHub D1/H1 configs
Date: Tue,  5 Oct 2021 14:12:21 +0300
Message-Id: <20211005111221.1035730-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Late fix for 49c8ef0e45a91ec894ef15e7d043dafe8f1c5efd commit by Tom Rini.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 configs/jethub_j100_defconfig | 1 +
 configs/jethub_j80_defconfig  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfi=
g
index 290ce4db850..25aee5a1471 100644
--- a/configs/jethub_j100_defconfig
+++ b/configs/jethub_j100_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=3Dy
 CONFIG_SYS_CONFIG_NAME=3D"jethub"
 CONFIG_ARCH_MESON=3Dy
 CONFIG_SYS_TEXT_BASE=3D0x01000000
+CONFIG_SYS_LOAD_ADDR=3D0x01000000
 CONFIG_NR_DRAM_BANKS=3D1
 CONFIG_ENV_SIZE=3D0x2000
 CONFIG_DM_GPIO=3Dy
diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
index 7db05af3b0d..524d4cc9b7b 100644
--- a/configs/jethub_j80_defconfig
+++ b/configs/jethub_j80_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYS_BOARD=3D"jethub-j80"
 CONFIG_SYS_CONFIG_NAME=3D"jethub"
 CONFIG_ARCH_MESON=3Dy
 CONFIG_SYS_TEXT_BASE=3D0x01000000
+CONFIG_SYS_LOAD_ADDR=3D0x01000000
 CONFIG_NR_DRAM_BANKS=3D1
 CONFIG_ENV_SIZE=3D0x2000
 CONFIG_DM_GPIO=3Dy
--=20
2.30.2

