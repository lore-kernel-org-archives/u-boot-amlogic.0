Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B5ECC6B2A
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 09:20:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4056.1791914436115251283
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Oct 2026 11:00:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=lGeZyYtt;
 spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: devnull+iav.iav.lv@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 76B2640C52;
	Tue, 13 Oct 2026 17:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58B41C2BCFA;
	Tue, 13 Oct 2026 17:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791914016;
	bh=GjuW0xVjuChdhF8eXw8FxorM4tcTp3XzAHW7nNVgc2s=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=lGeZyYtt5pOCqGF2sFfA4neKLLdrjeXZ9Q/aL7dOR41vN2zl1vghbSqFZZX/OLtAD
	 fOHof8oYzh18Bifqhofx8xAW5i6f7v0556ew/UHA0tyrBcjJ0FxmACNnKt0Bu/jX1y
	 rb8SQHxRhxW51DkwUjD8W2XGdECJ0XJ3UX9OHyQbGiFjHziUyzN/eM9ziXI3eHhjZX
	 a2U1/p7o7A7R96S3v2kA0FCQeFfX3F7RlBASv6A9UMJvw8ZfYFriFm7PXN36g35E8B
	 ZTdlejOKqXpaJ5Og3XF0TCnKPDftTe6Ek2G1nw2duNajpmSp64V/RN4JjX3Rbg5MNL
	 pMIkCGKrfDbEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44386CC6B12;
	Tue, 13 Oct 2026 17:53:36 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Tue, 13 Oct 2026 20:53:34 +0300
Subject: [PATCH] arm: dts: meson-sm1-odroid-hc4: power-cycle the SD card at init
MIME-Version: 1.0
Message-Id: <20261013-b4-hc4-sd-power-cycle-v1-1-cde760a256a5@iav.lv>
X-B4-Tracking: v=1; b=H4sIAB1wzmoC/x3MTQqAIBBA4avErBtIM6GuEi1SxxyICoV+kO6et
 PwW72VIFJkSDFWGSCcn3rcCUVdgw7wthOyKQTZSi0a0aBQGqzA5PPaLItrHroTeSKV170zbd1D
 aI5Ln+/+O0/t+ToIaRWcAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=tR/RFYgAqbY87MOye/X3GfkLr/MIhX3x0TK79SL/+gg=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFnnCuTebzBRkLR1C+N5XVVhc/bU4ePe07ObuXzd3DYfD
 hEXkFvTUcrCIMbFICumyDLhkMatjCVX//p7mD+AmcPKBDKEgYtTACbyfB0jw96599raVr42938l
 /P38ued23S8717Ov2G1X7tM7XyKnaCPDP7WE9T/32Rj0sXgUvgkozkn1C6q3y+M9t+zDFY02/6v
 7mAE=
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 14 Oct 2026 09:20:26 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3131

From: Igor Velkov <iav@iav.lv>

mmc_get_op_cond() power-cycles the card, but both SD supplies,
TFLASH_VDD and TF_IO, are regulator-always-on in the Linux device tree,
so regulator_set_enable_if_allowed() leaves them on. After a watchdog
reset a UHS card is still at 1.8 V signalling and U-Boot fails with
"No partition table - mmc 0".

Drop regulator-always-on from both supplies for U-Boot, and keep
TFLASH_VDD off for 100 ms before it is turned back on. Linux has to
keep regulator-always-on: the boot ROM does not turn the supply back on,
see Linux commit dc7f2cb218b5 ("arm64: dts: amlogic: odroid-n2: keep SD
card regulator always on") for the same supply on ODROID-N2. TF_IO
keeps regulator-boot-on: after a reset a pull-up on the board enables
it at 3.3 V before U-Boot runs.

Tested on ODROID-HC4 with a UHS-I SDXC card and U-Boot in SPI flash:
after a watchdog reset 3/3 boots from SD (v2026.07 without this change:
0/3); cold boot, reboot and suspend to RAM unaffected.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
The card holds a btrfs root, so the main build under test also had
FS_BTRFS, CMD_BTRFS and ZSTD enabled; odroid-hc4_defconfig has none of
them.
---
 arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi b/arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi
index 963bf96b256..5f09ecc8f60 100644
--- a/arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi
+++ b/arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi
@@ -18,6 +18,16 @@
 	vref-supply = <&vddao_1v8>;
 };
 
+/*
+ * Let the MMC core power-cycle the SD card: after a watchdog reset a UHS card
+ * is still powered and at 1.8 V signalling, and U-Boot cannot read it.
+ */
 &tflash_vdd {
 	gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
+	/delete-property/ regulator-always-on;
+	u-boot,off-on-delay-us = <100000>;
+};
+
+&tf_io {
+	/delete-property/ regulator-always-on;
 };

---
base-commit: b871f72273c183ab557e29f9bc52d9065e0aacf3
change-id: 20261013-b4-hc4-sd-power-cycle-fb24669db395

Best regards,
-- 
Igor Velkov <iav@iav.lv>



