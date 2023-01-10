Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web11.101218.1673348223020590724
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Jan 2023 02:57:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1673348221;
	bh=fMlm1dvt/NcZCPvYMaIVXJIgjuwR1TvaSNUNgf3eF4I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Dh1ramaK7C/iazz3YGndNlvkcjNUoZKfc4heNbw+JW6+8kQJuWhBt+e6OJM6Yi1cp
	 s8j7d6lVepHNSW2pQ2x6xy49ha5ur/rnNfEBz3Qn4dVrb7qSdE+DYAQBS/Sjm6TENo
	 NUhxkDBi2ZYL9u6shkK6UGKDq2tmhMbv9UPJTg9DBkIhJ1Oz+RdgUAUuK80jPsEjdO
	 XxSHWhCvjI/m98gpIZO20uUyrKHXvFTE8vu870adHiYTgSMz9FVqzk1YH0ILBLiZm6
	 tG0T5xBzDVlJ9NEUxi/IR7xzTLBoyzUUpL9CRreZBsaQSE4T5fJbb/ME0kxfZSSfBm
	 XjVcMrQjl29qg==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v4 1/5] asm/arch-meson: add missing meson_sm_write_efuse signature
Date: Tue, 10 Jan 2023 13:56:46 +0300
Message-ID: <20230110105650.54580-2-avromanov@sberdevices.ru>
In-Reply-To: <20230110105650.54580-1-avromanov@sberdevices.ru>
References: <20230110105650.54580-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

This function can be used by other modules. Also add comments.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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

