Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.44650.1671713860777138260
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Dec 2022 04:57:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1671713859;
	bh=RHD3izU5D+OGt26TNuX/pacvAnHCjQ9AnmxjGGgb3g8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=kV14XaaqJXtm34c+P1wwcwhxxW5rwc9FZOnLUipy/Jhcn6Rw/Nuc3peUt//7kPkp5
	 Ry5BDC+C+Ao4axCwKmEvAYWTZC+WtnFvNtGweh2PyZvkMAPOtzfX3yQWkZipqBHKPK
	 Kl4v0qjsFcKyTeMZ+9xCdC4SFWPdJBgHMkvtmn0Rj8pY9cgfT3sOCvNZe0UZ8lgp3z
	 y3t8bj101L8PivWAXlZEpF8aatF8MhF2+wr4QjvRDPsZw+LUj0qflJ/WgtIAGB5QNh
	 D5ImEhAKQbnT7bKqYbgupkXUQiibOCUnbwHXS54RHRT5GfQmihcnBOqr5I2yZyrxYh
	 gZ4hBlmCqiwIQ==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v3 1/5] asm/arch-meson: add missing meson_sm_write_efuse signature
Date: Thu, 22 Dec 2022 15:57:23 +0300
Message-ID: <20221222125727.47893-2-avromanov@sberdevices.ru>
In-Reply-To: <20221222125727.47893-1-avromanov@sberdevices.ru>
References: <20221222125727.47893-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

This function can be used by other modules. Also add comments.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 arch/arm/include/asm/arch-meson/sm.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/ar=
ch-meson/sm.h
index f3ae46a6d6b..53b75176493 100644
--- a/arch/arm/include/asm/arch-meson/sm.h
+++ b/arch/arm/include/asm/arch-meson/sm.h
@@ -6,10 +6,35 @@
 #ifndef __MESON_SM_H__
 #define __MESON_SM_H__
=20
+/**
+ * meson_sm_read_efuse - read efuse memory into buffer
+ *
+ * @offset: offset from the start efuse memory
+ * @buffer: pointer to buffer
+ * @size: number of bytes to read
+ * @return: number of bytes read
+ */
 ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size);
=20
+/**
+ * meson_sm_write_efuse - write into efuse memory from buffer
+ *
+ * @offset: offset from the start efuse memory
+ * @buffer: pointer to buffer
+ * @size: number of bytes to write
+ * @return: number of bytes written
+ */
+ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size);
+
 #define SM_SERIAL_SIZE	12
=20
+/**
+ * meson_sm_get_serial - read chip unique id into buffer
+ *
+ * @buffer: pointer to buffer
+ * @size: buffer size.
+ * @return: zero on success or -errno on failure
+ */
 int meson_sm_get_serial(void *buffer, size_t size);
=20
 enum {
@@ -28,6 +53,9 @@ enum {
 	REBOOT_REASON_WATCHDOG_REBOOT =3D 13,
 };
=20
+/**
+ * meson_sm_get_reboot_reason - get reboot reason
+ */
 int meson_sm_get_reboot_reason(void);
=20
 #endif /* __MESON_SM_H__ */
--=20
2.25.1

