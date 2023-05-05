Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web11.26161.1683291416802926571
 for <u-boot-amlogic@groups.io>;
 Fri, 05 May 2023 05:56:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1683291414;
	bh=vsBWb5vGV2sW75GQFQjKZbwiuGRFS2LTcR6bnycDVkE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=np2anlO1/0xkZLUvYKUfIq6xg5fDCknMLjX0ifjkFNxv3MbEm8zFn8gtqT6qYJwUA
	 wuSbbTZocJpdFQ/c5AdpFZa1w60LTsyNlo/SEZlViJ75OEB6oqq2D8HnIOdEFGHWao
	 ye4hJGCWqkmpLjBR67kyXqcT2l5HDNhJG0e2YrP/vr6uWCTRULAOxKP9c40GH05iSQ
	 uYsV7YwROeiT8OhXEJquFVIK1eek7R0DbLLU7+SG2n9XrSTV64EB/l4CNBVoFIR5S3
	 MRwegxBc43ZU4Vxb5FKCejpgTpbQZvdLYeaYnpuvw6OsiZGPAdxD97WbiqCHtrxYFO
	 hDlai9YK3KAAg==
From: Igor Prusov <ivprusov@sberdevices.ru>
Subject: [RFC PATCH v2 2/5] ARM: dts: sync meson-a1-ad401 from Linux 6.3-rc7
Date: Fri, 5 May 2023 15:56:36 +0300
Message-ID: <20230505125639.3605-3-ivprusov@sberdevices.ru>
In-Reply-To: <20230505125639.3605-1-ivprusov@sberdevices.ru>
References: <20230505125639.3605-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, Igor Prusov <ivprusov@sberdevices.ru>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Add meson-a1-ad401.dts file from Linux 6.3-rc7

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/dts/Makefile           |  1 +
 arch/arm/dts/meson-a1-ad401.dts | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 arch/arm/dts/meson-a1-ad401.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 935b2f1517..85bd26d55e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -185,6 +185,7 @@ dtb-$(CONFIG_ARCH_S5P4418) +=3D \
 	s5p4418-nanopi2.dtb
=20
 dtb-$(CONFIG_ARCH_MESON) +=3D \
+	meson-a1-ad401.dtb \
 	meson-axg-s400.dtb \
 	meson-axg-jethome-jethub-j100.dtb \
 	meson-gxbb-nanopi-k2.dtb \
diff --git a/arch/arm/dts/meson-a1-ad401.dts b/arch/arm/dts/meson-a1-ad401.=
dts
new file mode 100644
index 0000000000..69c25c68c3
--- /dev/null
+++ b/arch/arm/dts/meson-a1-ad401.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "meson-a1.dtsi"
+
+/ {
+	compatible =3D "amlogic,ad401", "amlogic,a1";
+	model =3D "Amlogic Meson A1 AD401 Development Board";
+
+	aliases {
+		serial0 =3D &uart_AO_B;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type =3D "memory";
+		reg =3D <0x0 0x0 0x0 0x8000000>;
+	};
+};
+
+&uart_AO_B {
+	status =3D "okay";
+};
--=20
2.34.1

