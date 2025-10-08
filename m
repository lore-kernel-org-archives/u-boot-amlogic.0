Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F828CCD189
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 10:01:04 +0000 (UTC)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
 by mx.groups.io with SMTP id smtpd.web11.12046.1759917662993750175
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Oct 2025 03:01:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=FB3q2b0g;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.188, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1759917661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yJny4tvlIG5T7FzlmsIkwvxqVddMcEo3dOwIbStIwY=;
	b=FB3q2b0g2aLKxOjKL76Lqi+GsODGfpwaYDShiQ5aSzYbzUcOairMp1TSbsCdSaaMUnEhVZ
	CIolqim7bwWddNUxKQjLpcUCB91rffXDBmzLkUiv+b95DNBk4nWzNklWHMp539fbfHKX4F
	69bVSr4wI1PBrUeoYGSoZdTeMJc1GvOfPKfF6ytdb/vP6Yrsgg57O7r1FoACOCIqHjcBsO
	I4NJgwKHDV+muG4oUu6+SvCOG/KknSpN5KbrcdyzXKQ6ajDoB/9SekU/qOjBiS7lNYc+Vy
	iWRxeQF7xD9dKcQuY0CaXwSYvRMeLaH1YVEyxpABy5vu2GrKijg6TO3bxucVlQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Oct 2025 10:00:42 +0000
Subject: [PATCH RFC v3 6/8] arm: dts: meson-gx-u-boot: add binman
 configuration for U-Boot SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20251008-spl-gx-v3-6-5999637df4b9@postmarketos.org>
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
In-Reply-To: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3974;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=v8Gr4ZhPWSVTDlE8SX6DRPQu4fzbDLctblwM0JGaAa8=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo5jZU7Itv7COGkMFYpECNJY0Y6Id0/hmem+yC+
 blWrdfRccSJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaOY2VAAKCRCEr8vQ14ma
 AwWAD/9HzL9m1un8nvlB/56XrB7NnIxNoVGerfGvffrjgoS8OyTq94yNB6A7+qWP4Bb4dSvrmwm
 dA9GAvHfMEI6bQJEkCUxdN3HXfBhs5s13SPXAsZbV0Hj55fIzLPVyo93cOWwvBH7uwCatl2N47G
 WVbpm9n6fdysSH9suf3ZxYDrFFihME0NS8GiPafD46QFrCvpEGnijmdQi8sQ+lEBstBxBKT7nHX
 ihsAjvK9a/o/+BWUE5qANFMb7A0I1I7eKfGihdCOmyDeCdZO1Q/f4JdYOlhFQnN0vSLXkDmql4l
 2kn/ym1WBR6jleukfcYc89p1Xd1xFwSY7vZc49HFjKgeoSPcGUT9+BbN86HD/ZkPY48iCkxiAtj
 yTvwSoysIdJhdka6WcNj1kilZEm6n7ZfcqqCo7KPweTJVZKgWo1TdStcM1Csh6e2tRd6tWNYDdP
 r7/BYwaziU2vxrSg4eidfHdV3vGDaJHhyUvN3mkIWDKdBU4vXDAqGXOEQHWixHv7QLoLMOzze6g
 HQVDsH7Nmi0BqvSorl9U+OUWjYUDCSQjK2+qIdTY1bmbspZ0yVoU3JJCLsJRtUAaaU07HaginTf
 KHGYaeENLLmdFGUedXagxdVO/fh07k9lF5YvJvQijRP3LO06lLTByLcE2zcT0tLLIHnRn1a5NSU
 RtPdREbrlDyEt9g==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Oct 2025 10:01:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2795

Add binman configuration to meson-gx-u-boot.dtsi to automate building
bootable images using amlimage.

Signed-off-by: Ferass El=C2=A0Hafidi <funderscore@postmarketos.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/dts/meson-gx-u-boot.dtsi | 142 ++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 142 insertions(+)

diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-=
boot.dtsi
index 9e0620f395e81048273690af4cee4b196ee7b0a7..d05f869c06ebefa08f5480327=
e4a72bbaa9a5e94 100644
--- a/arch/arm/dts/meson-gx-u-boot.dtsi
+++ b/arch/arm/dts/meson-gx-u-boot.dtsi
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2019 BayLibre, SAS.
  * Author: Maxime Jourdan <mjourdan@baylibre.com>
+ * Copyright (c) 2023 Ferass El Hafidi <funderscore@postmarketos.org>
  */
=20
 / {
@@ -15,6 +16,16 @@
 	soc {
 		bootph-all;
 	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+#if defined(CONFIG_BINMAN)
+	binman: binman {
+		multiple-images;
+	};
+#endif
 };
=20
 &vpu {
@@ -30,3 +41,134 @@
 	      <0x0 0xc883c000 0x0 0x1000>;
 	reg-names =3D "hdmitx", "hhi";
 };
+
+#if defined(CONFIG_MESON_GX) && defined(CONFIG_BINMAN)
+/* binman configuration on GXBB and GXL */
+
+#if defined(CONFIG_MESON_GXBB)
+#define BL31_ADDR 0x10100000
+#else /* GXL */
+#define BL31_ADDR 0x05100000
+#endif
+
+/*
+ * On GXBB the base address of the SCP firmware doesn't matter as SPL wi=
ll
+ * send the firmware to the SCP anyway, and can get the base address fro=
m the
+ * FIT. On GXL it matters, as BL31 is supposed to send the firmware, so =
set the
+ * base address to what GXL BL2 would load the binary to.
+ */
+#define  SCP_ADDR 0x13c0000
+
+&binman {
+	u-boot-amlogic {
+		filename =3D "u-boot-meson-with-spl.bin";
+		pad-byte =3D <0xff>;
+
+		mkimage {
+			filename =3D "spl/u-boot-spl-signed.bin";
+#if defined(CONFIG_MESON_GXBB)
+			args =3D "-n", "gxbb", "-T", "amlimage";
+#elif defined(CONFIG_MESON_GXL)
+			args =3D "-n", "gxl", "-T", "amlimage";
+#endif
+
+			blob {
+				size =3D <0xb000>; /* The BootROM loads 48K max (header is 4K) */
+				filename =3D "spl/u-boot-spl.bin";
+			};
+		};
+
+		fit: fit {
+			description =3D "ATF and U-Boot images";
+			#address-cells =3D <1>;
+			fit,fdt-list =3D "of-list";
+			fit,external-offset =3D <CONFIG_FIT_EXTERNAL_OFFSET>;
+			fit,align =3D <512>;
+			offset =3D <CONFIG_SPL_PAD_TO>;
+
+			images {
+				u-boot {
+					description =3D "U-Boot";
+					type =3D "standalone";
+					os =3D "u-boot";
+					arch =3D "arm64";
+					compression =3D "none";
+					load =3D <CONFIG_TEXT_BASE>;
+					entry =3D <CONFIG_TEXT_BASE>;
+
+					u-boot-nodtb {
+					};
+				};
+
+				atf {
+					description =3D "ARM Trusted Firmware";
+					type =3D "firmware";
+					os =3D "arm-trusted-firmware";
+					arch =3D "arm64";
+					compression =3D "none";
+					load =3D <BL31_ADDR>;
+					entry =3D <BL31_ADDR>;
+
+					atf-bl31 {
+						filename =3D "bl31.bin";
+					};
+					hash {
+						algo =3D "sha256";
+					};
+				};
+
+				scp {
+					description =3D "SCP firmware";
+					type =3D "scp";
+					arch =3D "arm"; /* The Cortex-M core is used as SCP */
+					compression =3D "none";
+					load =3D <SCP_ADDR>;
+
+					scp {
+						filename =3D "scp.bin";
+					};
+					hash {
+						/*
+						 * The hash is used by the SCP and passed to it
+						 * by U-Boot SPL.
+						 */
+						algo =3D "sha256";
+					};
+				};
+
+				@fdt-SEQ {
+					description =3D "NAME";
+					type =3D "flat_dt";
+					compression =3D "none";
+				};
+
+			};
+			configurations {
+				default =3D "@config-DEFAULT-SEQ";
+				@config-SEQ {
+					description =3D "NAME.dtb";
+					fdt =3D "fdt-SEQ";
+					firmware =3D "atf";
+					loadables =3D "scp", "u-boot";
+				};
+			};
+		};
+	};
+};
+
+&vpu {
+	/delete-property/ bootph-all;
+};
+
+&apb {
+	bootph-all;
+};
+
+&sd_emmc_b {
+	bootph-all;
+};
+
+&sd_emmc_c {
+	bootph-all;
+};
+#endif

--=20
2.51.0


