Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6873.1795661960091795380
 for <u-boot-amlogic@groups.io>;
 Wed, 25 Nov 2026 18:59:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20260515 header.b=RGktH2DO;
 spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: devnull+iav.iav.lv@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B4AFC42E48;
	Thu, 26 Nov 2026 02:53:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795661621;
	b=hggsrLqz4GrFKP0HTlhYmLceb8389VnpdRJJIFhpyYmbSEb60WJMPeTC0E1CSi2+HZ1W
	 BS0R7VIDAFw3/xd2bWpd4t6KYgQc1PA9pQ1aGFBrRVg4I/VIvLn/3NRwIhuRpqD7vwmpu
	 p4Dufu0+Qfc+FsUCuMu19aelj+7QoK6ED8EskrtxoOZAV6g2TbwHvpvM0OC9+AccnweIU
	 KWYOxWjTkWkDGv9DsaF9B8bzsMXZ1GGMTdCYcwKC8b1z4JwQg/Zr/sIviigrsKGhkREVF
	 ThhOQtcLUzAYNC2HewRAnkxhEWY2pjNAJT1kVz0t5k64jQ+Cz7ff+BnDJxmEq+XrtfA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795661621;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=ObVT+MYh8bc16ikcW11T6hYQmRAMUhuPZWVzYbs2lFc=;
	b=fAse9CSacWevy6XrX11sp5yM3lHubXXNb2dA++hdZcNv66WJ4i9X5ABRWes6+7vb/Ssu
	 4e72VD/vmeJF73aRFimEdFwITzmBUD5/qY5hWWsmqGqf1mPUIjBwogCWllOM3dnBtsn2e
	 Waa2uoYnzQcW4zNfy+WIlzg6MGehRMbcKMyZFdjvNkuqyNH5jeya35Y3bKJpx2amf/WSH
	 w77esdJmPJXPEHeDj9eYyzV29OVqDBASzc06p9RQYZGWKhZ8QbgARcUfLK2tFWQGpqZiP
	 Hl7z8po9se/3HT3S1Yhq8aFkrn769oEmli38GmR0CWIIvyANgxu7aUO2YxbYkE4C8bg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 041C51F000C6;
	Thu, 26 Nov 2026 02:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795661621;
	bh=ObVT+MYh8bc16ikcW11T6hYQmRAMUhuPZWVzYbs2lFc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=RGktH2DOGFxq6WgVSpXRnerNFfQff65OnQBEjKgenn5//JliLSfRXT8weddh9Mh1V
	 0NwFvA7Hk35AyM+WjCYfB/MeeaUJFJUbGccMHtUjo3kxpvuaa6sBw2r6GlrDYnR2Hc
	 onb1yxzgfziSGyYfpge3dSNpYVE4EKrSR5CLCVea5NypolrXRuqfHxUJ+mnPjyVZQX
	 XPX1JTCpRVqPHja4gKQmG8HUTjTPeDGF32kWITUKtKJ0Jsm4xJwGxx2xj6SSqwnz/e
	 PwFehL+zxeULITRi54vP187VULa0OfWka2ieAAV3L/muZ4HXtcr+FlpPzXXRHfNKUe
	 jZBTOK0Em+O6A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8DE4F4D1A8;
	Thu, 26 Nov 2026 02:53:37 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Thu, 26 Nov 2026 04:53:36 +0200
Subject: [PATCH] configs: odroid-n2: enable the SPI NOR flash
MIME-Version: 1.0
Message-Id: <20261126-b4-n2-spi-nor-v1-1-4fd806d0fa00@iav.lv>
X-B4-Tracking: v=1; b=H4sIAC+fB2sC/x3MPQqAMAxA4atIZgNtsf5dRRy0ppqlSgIiFO9uc
 fyG9zIoCZPCWGUQuln5TAW2riAcS9oJeSsGZ1xrrWtxbTA51IsxnYLRDKsP3tLW9VCaSyjy8/+
 m+X0/Ts29e18AAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4536; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=VYaPFTtVFfxBx3u0j2uhGXyauX6iBflpyXSxLToNX+E=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNns8w34ti3u1mlxNw29/ukN2+/+M0ZSczgnm/o5fazrs
 fm5yoa/o5SFQYyLQVZMkWXCIY1bGUuu/vX3MH8AM4eVCWQIAxenAEyk8yUjw4871sLGN5V/uCUv
 m3vAVzNTe3GpboLAv6oqWY4TPMy3ORgZTknXXdnl+bug7frN6edrk/elP/ixgnHWx3nx/v7tm/4
 +ZwEA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Fri, 27 Nov 2026 16:52:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3159

From: Igor Velkov <iav@iav.lv>

The SPI NOR of the ODROID-N2/N2+ shares the SoC pins BOOT_3..BOOT_7
with the eMMC data lines D3..D7, so the device tree has spifc disabled
and the defconfig has no SPI support. Enable both, and describe how to
write the flash in the board documentation.

Normal boot does not touch the flash: there is no SF boot target or
bootdev, and the environment is not in SPI. The first probe of the SPI
controller ("sf probe") muxes BOOT_4..BOOT_6 and the chip select
(BOOT_14) to the flash, while the eMMC stays set up for eight lines, so
the eMMC must not be accessed after that until reset. On an N2+, an
eMMC access after "sf probe" also made the boot ROM fail to read the
SPI NOR after the reset.

The 4-bit eMMC setup used on the VIM3 does not help: pin 7 of the
flash (RESET# on the MX25U6435F) is on eMMC D3, and on an N2+ eMMC reads
in 4-bit mode broke writes to the flash under Linux.

An OS booted through EFI without its own device tree gets this one,
where spifc and the 8-bit eMMC claim the same pins.

Tested on an ODROID-N2+ (MX25U6435F; spi-max-frequency 104 MHz, about
83 MHz after the controller divider): the eMMC comes up with the same
bus width with and without this patch; sf update of 1 MiB reads back
equal; the board boots from the SPI NOR after reset. Boards with an XTX
flash were not tested.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi |  9 +++++++++
 configs/odroid-n2_defconfig                   |  9 +++++++++
 doc/board/amlogic/odroid-n2.rst               | 21 +++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi b/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
index a92f9e9ff13..1dfb521e65f 100644
--- a/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
+++ b/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
@@ -11,3 +11,12 @@
 	status = "okay";
 	vref-supply = <&vddao_1v8>;
 };
+
+/*
+ * The SPI NOR shares BOOT_3..BOOT_7 with eMMC D3..D7. Probing spifc
+ * ("sf probe") muxes BOOT_4..BOOT_6 to it; do not access the eMMC after
+ * that until reset.
+ */
+&spifc {
+	status = "okay";
+};
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index 73a1a08afde..1f237d928ba 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -30,6 +30,7 @@ CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
+CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
@@ -40,6 +41,11 @@ CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
 CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_XTX=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_MDIO_MUX=y
 CONFIG_ETH_DESIGNWARE_MESON8B=y
@@ -55,6 +61,9 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MESON_SPIFC=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
diff --git a/doc/board/amlogic/odroid-n2.rst b/doc/board/amlogic/odroid-n2.rst
index 5222a21c808..194edde081b 100644
--- a/doc/board/amlogic/odroid-n2.rst
+++ b/doc/board/amlogic/odroid-n2.rst
@@ -130,3 +130,24 @@ Then write U-Boot to SD or eMMC with:
     $ DEV=/dev/boot_device
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
     $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
+
+Writing U-Boot to the SPI NOR
+-----------------------------
+
+The SPI NOR shares the SoC pins BOOT_3..BOOT_7 with the eMMC data lines
+D3..D7. The boot ROM reads it when the boot switch is set to SPI at power-on.
+
+U-Boot uses the eMMC with all eight data lines. The first probe of the SPI
+controller, for instance by "sf probe", muxes BOOT_4..BOOT_6 to the flash,
+and the eMMC must not be accessed after that until reset. Load the image
+first, from the eMMC or any other device, then write it:
+
+.. code-block:: none
+
+    => load mmc 1:1 ${loadaddr} u-boot.bin
+    => sf probe
+    => sf update ${loadaddr} 0 ${filesize}
+    => reset
+
+Here u-boot.bin is the signed image from the steps above (fip/u-boot.bin, or
+u-boot.bin in the build-fip.sh output directory), not u-boot.bin.sd.bin.

---
base-commit: 9d67454e920b3908529c9fc642a8c911db040896
change-id: 20261126-b4-n2-spi-nor-f09b5c51ed78

Best regards,
-- 
Igor Velkov <iav@iav.lv>


