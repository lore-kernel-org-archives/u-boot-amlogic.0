Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by mx.groups.io with SMTP id smtpd.web08.21100.1606494543620117812
 for <u-boot-amlogic@groups.io>;
 Fri, 27 Nov 2020 08:29:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1606494540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYlRYBYmkQb47yX+O3NLFV+1BITUpp3Dj9WC6ty4jUQ=;
	b=gtl518ssd5rWnHfv9aW8P0cfDcbvlemwVb1FGfu76EnfOyQAGytYp6XL3UEHjZ8ugIsmnU
	5KJc/KiB1Ayj1kmxOH91F6Pz6R6Dr8xFZ5NR1Qh3+XtZauWyFvWIw3bAnY/aG3JfoLXyJv
	qDgMjM7DiEq+VRc9t6Mruwn70M4QtZ8=
From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/2] meson: Add soc_rev to environment
Date: Fri, 27 Nov 2020 17:28:21 +0100
Message-Id: <ff19d6f90e3f827664f8460e98d86a692342506d.1606492351.git.stefan@agner.ch>
In-Reply-To: <537d604eeb14149783c1bb398af9f4c9a82374d0.1606492351.git.stefan@agner.ch>
References: <537d604eeb14149783c1bb398af9f4c9a82374d0.1606492351.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com, u-boot@lists.denx.de
Cc: Pascal Vizeli <pvizeli@syshack.ch>, Stefan Agner <stefan@agner.ch>
List-ID: <u-boot-amlogic@groups.io>

From: Pascal Vizeli <pvizeli@syshack.ch>

Add SoC revision to environment. This can be useful to select the
correct device tree at runtime (N2/N2+).

Signed-off-by: Pascal Vizeli <pvizeli@syshack.ch>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---

 arch/arm/include/asm/arch-meson/boot.h |  4 ++++
 arch/arm/mach-meson/board-info.c       | 12 ++++++++++++
 board/amlogic/odroid-n2/odroid-n2.c    |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/include/asm/arch-meson/boot.h b/arch/arm/include/as=
m/arch-meson/boot.h
index a90fe55081..c67d12d06c 100644
--- a/arch/arm/include/asm/arch-meson/boot.h
+++ b/arch/arm/include/asm/arch-meson/boot.h
@@ -7,6 +7,8 @@
 #ifndef __MESON_BOOT_H__
 #define __MESON_BOOT_H__
=20
+#include <linux/types.h>
+
 /* Boot device */
 #define BOOT_DEVICE_RESERVED    0
 #define BOOT_DEVICE_EMMC        1
@@ -17,4 +19,6 @@
=20
 int meson_get_boot_device(void);
=20
+int meson_get_soc_rev(char *buff, size_t buff_len);
+
 #endif /* __MESON_BOOT_H__ */
diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board=
-info.c
index a0bcf38f29..90e7dfaa3c 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -187,3 +187,15 @@ int show_board_info(void)
=20
 	return 0;
 }
+
+int meson_get_soc_rev(char *buff, size_t buff_len)
+{
+	unsigned int socinfo;
+
+	socinfo =3D get_socinfo();
+	if (!socinfo)
+		return -1;
+
+	/* Write SoC info */
+	return snprintf(buff, buff_len, "%x", socinfo_to_minor(socinfo));
+}
diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n=
2/odroid-n2.c
index caf7fd6810..dc0d933a39 100644
--- a/board/amlogic/odroid-n2/odroid-n2.c
+++ b/board/amlogic/odroid-n2/odroid-n2.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <asm/arch/sm.h>
 #include <asm/arch/eth.h>
+#include <asm/arch/boot.h>
=20
 #define EFUSE_MAC_OFFSET	20
 #define EFUSE_MAC_SIZE		12
@@ -23,6 +24,10 @@ int misc_init_r(void)
 	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
 	ssize_t len;
=20
+	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG) &&
+	    meson_get_soc_rev(tmp, sizeof(tmp)) > 0)
+		env_set("soc_rev", tmp);
+
 	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
=20
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
--=20
2.29.2

