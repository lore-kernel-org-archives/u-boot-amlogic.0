Return-Path: <adeep@lexina.in>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B5ECA1009
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 11:07:41 +0000 (UTC)
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web10.9728.1756897659357038454
 for <u-boot-amlogic@groups.io>;
 Wed, 03 Sep 2025 04:07:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@lexina.in header.s=dkim header.b=n9/Q0ZaD;
 spf=pass (domain: lexina.in, ip: 185.250.0.168, mailfrom: adeep@lexina.in)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80E063D544;
	Wed,  3 Sep 2025 14:07:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1756897655; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding; bh=l7s4W5m3lmVYyDCj3zm8/dyheyvmSEsiEDjJoMWjXl0=;
	b=n9/Q0ZaD/QUkdX3DyCfIvfl5CFFAOMTiNIuWij6h2v3LaKIi9VXbLOGqyQMozUUx1z55LT
	oZnOfyOOV/DxZf+Q6JLHmUKfyV/CnFRG0GVzeO+XZTvsHAYlvoVgC6g0erCJaXdrHeQO1q
	kNnTlZDURy0yhC8grggGxdbfyw+Okv7T0Tqg8PP1dmn4YPeIfng+MBNlrKWChe2nmFLF7h
	JWF+Ta2yT+Jnpkc32NEgeAAl5/jqe/PaAOrKvmUT1zUN6SudFmAcQ2zkb/Aa1Mw363lIzW
	oRnrEZcYbobWz/Pw+sfQmQwFrS2pjmzQ6mytLGx8sVr/amo2zANNvRIReyPyQA==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH v1] ARM: amlogic: fix JetHub D1 eth mac fallback generation
Date: Wed,  3 Sep 2025 14:06:03 +0300
Message-ID: <20250903110726.546083-1-adeep@lexina.in>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 03 Sep 2025 11:07:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2736

JetHome has allocated a special range for MAC fallback on JetHub D1/D1+
devices.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>

---=20
Viacheslav Bocharov
Shenzhen JetHome Technology Co., Ltd.

---
 board/amlogic/jethub-j100/jethub-j100.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/jeth=
ub-j100/jethub-j100.c
index 9e87fb9f9d7..79732864d03 100644
--- a/board/amlogic/jethub-j100/jethub-j100.c
+++ b/board/amlogic/jethub-j100/jethub-j100.c
@@ -19,21 +19,17 @@ int misc_init_r(void)
 {
 	u8 mac_addr[ARP_HLEN + 1];
 	char serial[SM_SERIAL_SIZE];
-	u32 sid;
+	u16 sid;
=20
 	if (!meson_sm_get_serial(serial, SM_SERIAL_SIZE)) {
-		sid =3D crc32(0, (unsigned char *)serial, SM_SERIAL_SIZE);
-		/* Ensure the NIC specific bytes of the mac are not all 0 */
-		if ((sid & 0xffff) =3D=3D 0)
-			sid |=3D 0x800000;
-
-		/* OUI registered MAC address */
-		mac_addr[0] =3D 0x10;
-		mac_addr[1] =3D 0x27;
-		mac_addr[2] =3D 0xBE;
-		mac_addr[3] =3D (sid >> 16) & 0xff;
-		mac_addr[4] =3D (sid >>  8) & 0xff;
-		mac_addr[5] =3D (sid >>  0) & 0xff;
+		sid =3D crc32(0, (unsigned char *)serial, SM_SERIAL_SIZE) & 0xFFFF;
+		/* OUI registered fallback MAC address */
+		mac_addr[0] =3D 0xF0;
+		mac_addr[1] =3D 0x57;
+		mac_addr[2] =3D 0x8D;
+		mac_addr[3] =3D 0x00;
+		mac_addr[4] =3D (sid >>  8) & 0xFF;
+		mac_addr[5] =3D sid & 0xFF;
 		mac_addr[ARP_HLEN] =3D '\0';
=20
 		eth_env_set_enetaddr("ethaddr", mac_addr);
--=20
2.51.0


