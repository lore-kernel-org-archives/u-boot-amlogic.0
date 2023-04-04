Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by mx.groups.io with SMTP id smtpd.web11.102769.1680617541900117332
 for <u-boot-amlogic@groups.io>;
 Tue, 04 Apr 2023 07:12:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1680617540;
	bh=kPhTYKIm1YSNOK324tt/AGZEXFvuvZw+GD0kh93u7F4=;
	h=From:To:Cc:Subject:Date:From;
	b=guEgck5SayhEU+r1sT+6+kAA1rZNToN37vIZeadZEKnGI7Jyat1usP59obB9uWtly
	 K8mp936rfiW2sfJ3H4uFtwmtj+Nc1MXv4HSfKK9CxYzfF1khhlJNxcVIjTWCL/UtR6
	 3EOCjJHovSzep2bSuxTLfOeFtR1EjJjBlbXtTcpfbiFDbG6/QkoPsy9OhFfV0QVM6l
	 ygwSX1nxfXcKp7Nr6utPOnlyw66oyWLJB6B8GnvPdgPMqd+9/J90X2PhM+NZXmLgdo
	 HQxEfQHq3oWgcBfUSbjoCFlD8MtpZyCSU0g6qk7ivOUyPvFdTOPKbH5t8WT7zbgmP3
	 uhomJBE9yuK0w==
From: Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v4 1/5] ARM: dts: rockchip: rk3588-rock-5b-u-boot: add USB 2.0 host
Date: Tue,  4 Apr 2023 17:11:51 +0300
Message-Id: <20230404141155.283987-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, kever.yang@rock-chips.com, neil.armstrong@linaro.org, jagan@edgeble.ai, jonas@kwiboo.se, xdrudis@tinet.cat, anarsoul@gmail.com, Eugen Hristev <eugen.hristev@collabora.com>, William Wu <william.wu@rock-chips.com>
List-ID: <u-boot-amlogic@groups.io>

Add USB 2.0 host nodes and PHYs.

Co-developed-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
Changes in v4:
- removed u-boot,dm-spl on regulator which was useless
- moved usb nodes to rk3588s-u-boot-dtsi

Changes in v2,v3:
- none

 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 82 +++++++++++++++++++++++
 arch/arm/dts/rk3588s-u-boot.dtsi        | 86 +++++++++++++++++++++++++
 2 files changed, 168 insertions(+)

diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk358=
8-rock-5b-u-boot.dtsi
index bee4c32e8965..93942b105c3d 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -4,6 +4,9 @@
  */
=20
 #include "rk3588-u-boot.dtsi"
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
=20
 / {
 	aliases {
@@ -13,6 +16,18 @@
 	chosen {
 		u-boot,spl-boot-order =3D &sdmmc;
 	};
+
+	vcc5v0_host: vcc5v0-host-regulator {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "vcc5v0_host";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+		enable-active-high;
+		gpio =3D <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&vcc5v0_host_en>;
+		vin-supply =3D <&vcc5v0_sys>;
+	};
 };
=20
 &sdmmc {
@@ -20,3 +35,70 @@
 	bootph-pre-ram;
 	status =3D "okay";
 };
+
+&pinctrl {
+	usb {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins =3D <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&usb_host0_ehci {
+	companion =3D <&usb_host0_ohci>;
+	phys =3D <&u2phy2_host>;
+	phy-names =3D "usb2-phy";
+	status =3D "okay";
+};
+
+&usb_host0_ohci {
+	phys =3D <&u2phy2_host>;
+	phy-names =3D "usb2-phy";
+	status =3D "okay";
+};
+
+&usb2phy2_grf {
+	status =3D "okay";
+};
+
+&u2phy2 {
+	resets =3D <&cru SRST_OTGPHY_U2_0>, <&cru SRST_P_USB2PHY_U2_0_GRF0>;
+	reset-names =3D "phy", "apb";
+	clock-output-names =3D "usb480m_phy2";
+	status =3D "okay";
+};
+
+&u2phy2_host {
+	phy-supply =3D <&vcc5v0_host>;
+	status =3D "okay";
+};
+
+&usb_host1_ehci {
+	companion =3D <&usb_host1_ohci>;
+	phys =3D <&u2phy3_host>;
+	phy-names =3D "usb2-phy";
+	status =3D "okay";
+};
+
+&usb_host1_ohci {
+	phys =3D <&u2phy3_host>;
+	phy-names =3D "usb2-phy";
+	status =3D "okay";
+};
+
+&usb2phy3_grf {
+	status =3D "okay";
+};
+
+&u2phy3 {
+	resets =3D <&cru SRST_OTGPHY_U2_1>, <&cru SRST_P_USB2PHY_U2_1_GRF0>;
+	reset-names =3D "phy", "apb";
+	clock-output-names =3D "usb480m_phy3";
+	status =3D "okay";
+};
+
+&u2phy3_host {
+	phy-supply =3D <&vcc5v0_host>;
+	status =3D "okay";
+};
+
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-bo=
ot.dtsi
index 1e225d71efc2..fb1b802fd273 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -12,12 +12,98 @@
 		status =3D "okay";
 	};
=20
+	usb_host0_ehci: usb@fc800000 {
+		compatible =3D "generic-ehci";
+		reg =3D <0x0 0xfc800000 0x0 0x40000>;
+		interrupts =3D <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks =3D <&cru HCLK_HOST0>, <&cru HCLK_HOST_ARB0>;
+		clock-names =3D "usbhost", "arbiter";
+		power-domains =3D <&power RK3588_PD_USB>;
+		status =3D "disabled";
+	};
+
+	usb_host0_ohci: usb@fc840000 {
+		compatible =3D "generic-ohci";
+		reg =3D <0x0 0xfc840000 0x0 0x40000>;
+		interrupts =3D <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks =3D <&cru HCLK_HOST0>, <&cru HCLK_HOST_ARB0>;
+		clock-names =3D "usbhost", "arbiter";
+		power-domains =3D <&power RK3588_PD_USB>;
+		status =3D "disabled";
+	};
+
+	usb_host1_ehci: usb@fc880000 {
+		compatible =3D "generic-ehci";
+		reg =3D <0x0 0xfc880000 0x0 0x40000>;
+		interrupts =3D <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks =3D <&cru HCLK_HOST1>, <&cru HCLK_HOST_ARB1>;
+		clock-names =3D "usbhost", "arbiter";
+		power-domains =3D <&power RK3588_PD_USB>;
+		status =3D "disabled";
+	};
+
+	usb_host1_ohci: usb@fc8c0000 {
+		compatible =3D "generic-ohci";
+		reg =3D <0x0 0xfc8c0000 0x0 0x40000>;
+		interrupts =3D <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks =3D <&cru HCLK_HOST1>, <&cru HCLK_HOST_ARB1>;
+		clock-names =3D "usbhost", "arbiter";
+		power-domains =3D <&power RK3588_PD_USB>;
+		status =3D "disabled";
+	};
+
 	pmu1_grf: syscon@fd58a000 {
 		bootph-all;
 		compatible =3D "rockchip,rk3588-pmu1-grf", "syscon";
 		reg =3D <0x0 0xfd58a000 0x0 0x2000>;
 	};
=20
+	usb2phy2_grf: syscon@fd5d8000 {
+		compatible =3D "rockchip,rk3588-usb2phy-grf", "syscon",
+			     "simple-mfd";
+		reg =3D <0x0 0xfd5d8000 0x0 0x4000>;
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+
+		u2phy2: usb2-phy@8000 {
+			compatible =3D "rockchip,rk3588-usb2phy";
+			reg =3D <0x8000 0x10>;
+			interrupts =3D <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks =3D <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
+			clock-names =3D "phyclk";
+			#clock-cells =3D <0>;
+			status =3D "disabled";
+
+			u2phy2_host: host-port {
+				#phy-cells =3D <0>;
+				status =3D "disabled";
+			};
+		};
+	};
+
+	usb2phy3_grf: syscon@fd5dc000 {
+		compatible =3D "rockchip,rk3588-usb2phy-grf", "syscon",
+			     "simple-mfd";
+		reg =3D <0x0 0xfd5dc000 0x0 0x4000>;
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+
+		u2phy3: usb2-phy@c000 {
+			compatible =3D "rockchip,rk3588-usb2phy";
+			reg =3D <0xc000 0x10>;
+			interrupts =3D <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks =3D <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
+			clock-names =3D "phyclk";
+			#clock-cells =3D <0>;
+			status =3D "disabled";
+
+			u2phy3_host: host-port {
+				#phy-cells =3D <0>;
+				status =3D "disabled";
+			};
+		};
+	};
+
 	sdmmc: mmc@fe2c0000 {
 		compatible =3D "rockchip,rk3588-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg =3D <0x0 0xfe2c0000 0x0 0x4000>;
--=20
2.34.1

