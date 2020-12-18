Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web09.8188.1608288256360347324
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 02:44:17 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201218104359euoutp0201ba7cd55a29eee3764b211f6edce949~RyaHhOHcj2728627286euoutp020
	for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 10:43:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201218104359euoutp0201ba7cd55a29eee3764b211f6edce949~RyaHhOHcj2728627286euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608288239;
	bh=9KezMUUVULx7n4oqVRKifY3dS7bgG4kBi31CM6pwfpE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=PwRDL4j6CGU4FFigNfrjpGFCajMoz20vEqLqSCSU4QPDg1CcVNNJsB9saLewudImB
	 2dvNVonncu2gX+DQMp14fIWH3U/G2ddFymgRfLLdioDUhyjA4dOW72CTDSlShi1UNq
	 cLobUkv+cPuRpRvn4/4uqZU62CAR4b4gcWjxO99c=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] ARM: dts: meson: switch TFLASH_VDD_EN pin to open drain on Odroid-C4
Date: Fri, 18 Dec 2020 11:43:45 +0100
Message-Id: <20201218104345.18370-1-m.szyprowski@samsung.com>
References: <CGME20201218104353eucas1p266e5210f6272fc60b316881e3fb3c210@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

For the proper reboot Odroid-C4 board requires to switch TFLASH_VDD_EN
pin to the high impedance mode, otherwise the board is stuck in the
middle of loading early stages of the bootloader from SD card.

This can be achieved by using the OPEN_DRAIN flag instead if the
ACTIVE_HIGH, what will leave the pin in input to achieve high state (pin
has the pull-up) and solve the issue.

Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This is a result of the discussion in the "[PATCH/RFC] board: amlogic:
Fix Odroid-C4 SD card reboot issue" thread:
https://lists.denx.de/pipermail/u-boot/2020-December/435295.html

Patch for the upstream Linux DTS has been already submitted:
https://lore.kernel.org/linux-amlogic/20201218102228.16211-1-m.szyprowski@samsung.com/
---
 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
index c431988075..fbcc8287c5 100644
--- a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
+++ b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
@@ -11,3 +11,7 @@
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
 };
+
+&tflash_vdd {
+	gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
+};
-- 
2.17.1

