Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42E1FA1FC9
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 15:43:43 +0000 (UTC)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.85774.1776872618802038933
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 08:43:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=gTsQxXWW;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.186, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1776872616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EE5Mz6faPdqmKhXq9ad7HUmtt7j5D3zJBBZq3KTHE3w=;
	b=gTsQxXWWImJumjGOOu/qrwAOU25lC3gyph1w8GcQkPekG1h9Z+AImjrHf9cpB6XsaqST3G
	yvl4jmaZTeTo+mgO241T6T7dSODvU+POL4UQ+8mr65fF/0sEM4IX96aKW5EXKxuuGU3Chr
	7tbIj91vymJov8CSZdm1+VFKSFomk/64Q/yg4oGVcQbCmlxs5odPIEv8x2x2cozbP24B0h
	InNs59zDfm+wa/W20PlfZwWR22TjcmhZfXhUSBny3HjaQeko0ZcEPKkANDumra9quCwXdN
	+1Xw39Ok5QWriUXLicdV/2mArWG5+rat/el6x04MrwysHh9s/32UtPSGw2om2g==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH v3 0/4] Enable EFI Capsule on Disk on Libre Computer
 LePotato & LaFrite
Date: Wed, 22 Apr 2026 15:43:22 +0000
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJvs6GkC/43NsQ6DIBSF4VcxzKVBRCKd+h5NB9SLkqoYLiU1x
 ncvOnVo0o7/Gb6zEgRvAcklW4mHaNG6KUVxykjT66kDatvUhDMumWAVrQXV4+A621Bc0ANCoI2
 e8TkA0sqUSvIWjDY1ScTswdjXwd/uqXuLwfnleIv5vv4Jx5wyKk1RVBLqMufiOjsMo/YPCA7Pz
 ndk9yP/MDn/YfJkAhMgGgVSGfXF3LbtDWNvL6EjAQAA
X-Change-ID: 20260408-b4-amlogic-sysreset-capsules-8f5962defafb
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3528;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=EhZ5OWIcBbeynF+1/IpuIzgo8xo8GZ5sF7ZdN+mBaSk=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp6OyihUqxFSFa9nxteL6jzUwad0cQJSqhhOdsu
 Yba7B78sIGJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaejsogAKCRCEr8vQ14ma
 Axl6D/9WEVcwJPfG478o40lm01clK1TG1wc1lGb1qLH6WpRa5bEvBsROR7tL8M05hum/gIhrAV7
 H+sjdwg6drnnMJy3/Fx6XWbf+bKugnmvwuLMWwUZTuLiC4ZyEmavq7EPpH8oCF8hinRoX5UHpz1
 SqvMuGqfl2tJ3a4t/nh5LCbKNvEVLG00BKsxt62CCkCyHTFNifQLGCpzI1/NqJnDvoJftabbrBU
 kHaRn3zwzfuICbsvg1UWRc43UnvKf+JeaXrvwIiUxQ6+ciQNH3HN/MsM6uV51jWiGoOTy8b1poW
 FWjHAx4Hq0/Bhj9V4XP4wtZQVRTRLetCESueLyKTflWjHoZKEHP5dFFCbPYFpvt0YeSNY1ugUW2
 wg5AXJahJCIAoL257i3mzC+6r/NhlOb8RMqLEK7XID3wUJiulaTRsk5Hf7nbES1NIk1i6t3+JDa
 b+VFK3DSWMM7yxuA+N/IYE1jwEtRuf/KkL08XzkXBFOk88FetDEL+Bwwb3JBunm8q3aKa0r00ki
 ITkM87zuh0v2QwfP12gMPjNnm4a1zHhhgPVhKB1qNNuKpEqkRu2htbw+JrhkBAhglQ16BjfP7Ax
 2oHdnFUs4m2Iv5a+DsvEu1OEvFmwozwQoTiha1YKEnj6XN9Gn0Uhdl75cmDwcoK5l7DZLuP4Vmh
 bl0dSVhQtrOzh3w==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 15:43:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2973

Mostly everything is already in place to enable EFI capsules and in particular
EFI capsule on disk.

First, switch all Amlogic boards to use SYSRESET. EFI Capsule on Disk
functionality expects sysreset to be present. As the current reset_cpu()
function in board-common.c is basically only doing PSCI reset on U-Boot
proper, we can replace it with sysreset's PSCI support, which works just
fine for that purpose provided BL31 is running (SPL stays on an
SoC-specific reset_cpu() which does for(;;);, as the overhead for
sysreset is too high and we don't have PSCI yet at that point).

Then we can enable capsule on disk. LaFrite has Capsule updates enabled
already, so it is simply a matter of enabling CoD. LePotato does not
have Capsule updates enabled by default, however it can be easily enabled
and setup to update u-boot on eMMC/SD.

With Capsule on Disk setup, it becomes possible to update U-Boot directly
from Linux, without having to worry about manually using `flashprog`
(for SPI flash) or `dd` (for eMMC/SD). Instead, thanks to CoD, updates
can be handled by `fwupd` and applied upon next EFI boot.

To test:

 * build U-Boot as usual

 * in that running U-Boot, run: `efidebug capsule esrt` to get the GUID
   -OR-
   run the following in your tree:
	tools/mkeficapsule guidgen path_to_devicetree_here U_BOOT_MESON_MMC
	                                   (or U_BOOT_MESON_SPI on LaFrite)

 * proceed with the following guide to create a capsule file:
   https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#enabling-uefi-capsule-update-feature

 * generate a .cab file suitable for fwupd using `mkcab`:
   https://gitlab.postmarketos.org/tauchgang/tauchgang-ci/-/tree/main/mkcab
	mkcab u-boot-libretech-cc.capsule GUID-GOES-HERE libretech-cc "LePotato" 2026.04
   (as of writing, the README.md suggests this is for Qualcomm only. It
    actually does nothing that is Qualcomm-specific, and works on any
    board that supports Capsule on Disk and fwupd)

 * on the board itself, boot to Linux via EFI, install fwupd, copy the resulting
   .cab file, and run as root:
	fwupdtool --force install u-boot-libretech-cc.cab

 * reboot, make sure you boot over EFI, else the capsule update will not
   start

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
Changes in v3:
 - (Neil, I removed your R-b on the second patch since it changed
    significantly to fix the build failure you reported)
 - Link to v2 (bogus): https://lore.kernel.org/r/20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org
 - Keep reset_cpu in board-common.c, but guarded
 - Only imply SYSRESET_PSCI, for boards to be able to disable it if
   needed
 - Link to v1: https://lore.kernel.org/r/20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org

---
Ferass El Hafidi (4):
      arm: mach-meson: provide reset_cpu only when SYSRESET is disabled
      arm: meson: enable SYSRESET_PSCI
      configs: libretech-ac_defconfig: enable EFI Capsule on Disk
      configs: libretech-cc_defconfig: enable EFI Capsule on Disk

 arch/arm/mach-meson/Kconfig        | 2 ++
 arch/arm/mach-meson/board-common.c | 6 ++----
 configs/libretech-ac_defconfig     | 1 +
 configs/libretech-cc_defconfig     | 4 ++++
 4 files changed, 9 insertions(+), 4 deletions(-)
---
base-commit: f0000b4a57e9edf8ff8454b9056d767466dff57f
change-id: 20260408-b4-amlogic-sysreset-capsules-8f5962defafb

Best regards,
-- 
--
Best regards,
Ferass


