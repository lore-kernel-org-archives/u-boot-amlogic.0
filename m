Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web11.82031.1670956301535282928
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Dec 2022 10:31:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1670956298;
	bh=KBtZAELvV9+Ga+tuteFVuDCarqA1JMBic0UefTWHUhQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=FJqtkqn/No6J25ToIcNWdOXC/rrkibem75xnS5PKxn5jjXuE5jj+RUMr0/kWX00Jr
	 FOtKw+C6+SEi0i6Qoa9FlLxlekwDe8SLsA0OM/m3ctuMDYbWI5lfg0Ymuw/w+LHoYm
	 8EajGAVMjizUtpW765qLC12ZRNbSGhYWmNoBsFg4cZy8Nvqv64YGHKHbPRMwuJrizu
	 bh59x61zhoUnM3XoEMQ8iVRb39c545dn33rZ9667o5C0S+QuNddnrF3WUzH4VhemA2
	 bgfyf3EEduqlTo4Ewz/VrfEipBs8+SrwoHc6EsQkC6yYnSHAT2WVXyz1tvWRDtgPX3
	 FQPu4NLx1CS+w==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v2 1/3] asm/arch-meson: add missing meson_sm_write_efuse signature
Date: Tue, 13 Dec 2022 21:31:27 +0300
Message-ID: <20221213183129.75915-2-avromanov@sberdevices.ru>
In-Reply-To: <20221213183129.75915-1-avromanov@sberdevices.ru>
References: <20221213183129.75915-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

This function can be used by other modules.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 arch/arm/include/asm/arch-meson/sm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/ar=
ch-meson/sm.h
index f3ae46a6d6b..b68edf842e4 100644
--- a/arch/arm/include/asm/arch-meson/sm.h
+++ b/arch/arm/include/asm/arch-meson/sm.h
@@ -8,6 +8,8 @@
=20
 ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size);
=20
+ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size);
+
 #define SM_SERIAL_SIZE	12
=20
 int meson_sm_get_serial(void *buffer, size_t size);
--=20
2.25.1

