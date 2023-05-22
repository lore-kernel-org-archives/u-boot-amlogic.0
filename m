Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.20312.1684757396229863138
 for <u-boot-amlogic@groups.io>;
 Mon, 22 May 2023 05:09:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1684757393;
	bh=1vmDi+cytacZsuzxDvBCHo3Z/dhHiZa6Q3hJlqNlC64=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=hhLSKAWejRjvGjJYE+HvHV8DHzHFjwW+txBiURceoYIr0s1iFOFggRFEm/v28A7L/
	 YNs/oh5gL8WApOBrB4h/vyJ8A5XE4rdKnxzbCp0tDRVoNhbE1P3efzCjq//eZ0xc94
	 C1F0Gn3zMGr5i+H19eHybsKgZ0b6ojH6yjyrokE7VVLQEJKp7glwyIHQrDFDWaR0Jo
	 PIbIlBRd6qN/Y/VU1yubGyfIYlv4eAtapmsYYGT6TCm0aokIby1aNJ+fnSPwaaMS70
	 2u0ryVoHwt9/8NDipDmPSGSROEod4MbyY5nb19jKXPjFz2dOHb9imz5CvjvzbPfBRG
	 YdYWsJVZ4Oa+w==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 1/3] arch/arm: meson: sm: introduce power domain functions
Date: Mon, 22 May 2023 15:09:39 +0300
Message-ID: <20230522120941.63962-2-avromanov@sberdevices.ru>
In-Reply-To: <20230522120941.63962-1-avromanov@sberdevices.ru>
References: <20230522120941.63962-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, jh80.chung@samsung.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

This commit adds functions to manage secure power domain for
Amlogic SoC's using smc functionality.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 arch/arm/include/asm/arch-meson/sm.h | 30 ++++++++++++++++++++++++++++
 arch/arm/mach-meson/sm.c             | 14 +++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/ar=
ch-meson/sm.h
index 53b75176493..4b1d564bc48 100644
--- a/arch/arm/include/asm/arch-meson/sm.h
+++ b/arch/arm/include/asm/arch-meson/sm.h
@@ -58,4 +58,34 @@ enum {
  */
 int meson_sm_get_reboot_reason(void);
=20
+#define PWRDM_OFF 0
+#define PWRDM_ON 1
+
+/**
+ * meson_sm_pwrdm_set - do command at specified power domain.
+ *
+ * @index: power domain index.
+ * @cmd: command index.
+ * @return: zero on success or error code on failure.
+ */
+int meson_sm_pwrdm_set(size_t index, int cmd);
+
+/**
+ * meson_sm_pwrdm_off - disable specified power domain.
+ *
+ * @index: power domain index.
+ * @return: zero on success or error code on failure.
+ */
+#define meson_sm_pwrdm_off(index) \
+	meson_sm_pwrdm_set(index, PWRDM_OFF)
+
+/**
+ * meson_sm_pwrdm_on - enable specified power domain.
+ *
+ * @index: power domain index.
+ * @return: zero on success or error code on failure.
+ */
+#define meson_sm_pwrdm_on(index) \
+	meson_sm_pwrdm_set(index, PWRDM_ON)
+
 #endif /* __MESON_SM_H__ */
diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index f2ca7e76932..d600c64d0be 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -24,6 +24,7 @@
 #define FN_EFUSE_READ			0x82000030
 #define FN_EFUSE_WRITE			0x82000031
 #define FN_CHIP_ID			0x82000044
+#define FN_PWRDM_SET			0x82000093
=20
 static void *shmem_input;
 static void *shmem_output;
@@ -137,3 +138,16 @@ int meson_sm_get_reboot_reason(void)
 	/* The SMC call is not used, we directly use AO_SEC_SD_CFG15 */
 	return FIELD_GET(REBOOT_REASON_MASK, reason);
 }
+
+int meson_sm_pwrdm_set(size_t index, int cmd)
+{
+	struct pt_regs regs;
+
+	regs.regs[0] =3D FN_PWRDM_SET;
+	regs.regs[1] =3D index;
+	regs.regs[2] =3D cmd;
+
+	smc_call(&regs);
+
+	return regs.regs[0];
+}
--=20
2.38.1

