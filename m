Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web08.15570.1650788536363796603
 for <u-boot-amlogic@groups.io>;
 Sun, 24 Apr 2022 01:22:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650788530; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=wSL+KQbIibmn4+AX8eTgD0llF+CxA4RZtYNA53J/qus=;
	b=i262aVEM7ZI2l1VeX12ZEWiDw4cZqQvKHHAjz7XJCIt6p+7KDwfCwHKdz3BzXntOd3JhZo
	3eMtw946WxdTnnBs9YsuSYQ7PDWW3CYAF9TiCN7gv6no7ait1f7SmrBlPKJaS6RtlY8isc
	XUHnbsgO70vPImMhXHJqkeSKDzBYmN1i4YjorsMgktZx6G+l3jhFVkosMbReQK2bE6YwG+
	hFiJkvTulLzdaQFWrAiBkpxZK1zuTpkGRxyFNImGzJLwgSUZ/XG5V60l+SpdvQE479qNYF
	ppSLqAoELjCUpG0RShGaHrYvIXG3Rp6q7qURJrWGiRBd00Qsw4kbEMcpPLcUYg==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v3 5/6] board: amlogic: jethub j100: enable saradc in dts
Date: Sun, 24 Apr 2022 11:21:58 +0300
Message-Id: <20220424082159.757622-6-adeep@lexina.in>
In-Reply-To: <20220424082159.757622-1-adeep@lexina.in>
References: <20220424082159.757622-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Prepare to use ADC channel 1 to check the hardware revision of the board:
- add u-boot dts include with saradc node

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 arch/arm/dts/meson-axg-jethome-jethub-j100-u-boot.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 arch/arm/dts/meson-axg-jethome-jethub-j100-u-boot.dts=
i

diff --git a/arch/arm/dts/meson-axg-jethome-jethub-j100-u-boot.dtsi b/arc=
h/arm/dts/meson-axg-jethome-jethub-j100-u-boot.dtsi
new file mode 100644
index 0000000000..3ecb233f8e
--- /dev/null
+++ b/arch/arm/dts/meson-axg-jethome-jethub-j100-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Vyacheslav Bocharov <adeep@lexina.in>
+ * Author: Vyacheslav Bocharov <adeep@lexina.in>
+ */
+
+&saradc {
+	status =3D "okay";
+	vref-supply =3D <&vddio_ao18>;
+};
--=20
2.30.2

