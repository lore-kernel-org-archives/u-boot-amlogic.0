Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC48B10F997D
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 20:30:28 +0000 (UTC)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.116162.1775680223813223042
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Apr 2026 13:30:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=nED19c5K;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.170, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1775680221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cvI77Jtmc07Wi/iBfIiDoIBTZ32VY0s5UDTrqS7POa0=;
	b=nED19c5KAPmsAQlZhFd3RtmLrGX98p9hVfVB+b0ZkYQouUB7Oa0FqnBIhw0p2WMQNhab0l
	KB/xpCmsA8Y9Jsv0qsp1/GyzN2lC9umWvBvTa0x9cjFZXKXpDoHiIGH2KNNI2eciTiURWs
	Y1SupSchTXMRNEcmg6GWMLIvoY2k5ud3saVvsRsh0FoEdUG27zdNm8pPyCyuWzDcX/f4aL
	GK1FE3jjpW8QwMg4OVE3UjNw3lGQwrlHlVP8hLDfebk2gzmu07p4TEAzyG9XEddHtfYJ9+
	3dR4mxel9kx8mB9NEj5m7D8i2KPqzuXM8vcY2PxhsWK1bmOxNnAC8TpYOnyqjA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH 0/4] Enable EFI Capsule on Disk on Libre Computer LePotato
 & LaFrite
Date: Wed, 08 Apr 2026 20:30:11 +0000
Message-Id: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANO61mkC/x3MTQqDMBAG0KvIrB1IQyrWqxQXMX6xA/6R0VIR7
 27o8m3eSYokUGqKkxK+orLMGY+yoPDx8wCWPpussZVxpubOsZ/GZZDAemiCYuPgV91HKNfx+ap
 sj+hjR7lYE6L8/v27va4bft6QqW4AAAA=
X-Change-ID: 20260408-b4-amlogic-sysreset-capsules-8f5962defafb
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3079;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=YPRvrUbBAZvg/htrnQIcPIxxCeAa4eOK5QeINVJhtLs=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp1rrX51OPSYcM5tICtsR6Eq2NAENdeZr7DtrZz
 joB4aQru6eJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCada61wAKCRCEr8vQ14ma
 A7k1D/9eIoeDwi4uNNT5T1/vnn80RvwEj1AGI5DWi8dwWqUP1tHLgHlfwOMCJZ68jDL4Hb5XTKq
 BAtqd1ITFs5ziuL/nF/oTLhkPTC4ksFKbQhu4MxqyN76O7pP3DlNHRmnDVxRCksw/i3+8LKrg1R
 vChLEXwrCFqYtyiteUBRYcl57sRFc8QxuxjNNPHjnyvK4OlerqnCoyI2Vn4HgeIP2QUsupA6+7P
 I3rJYz+mhb0ZP4fK9/BmHcmKwbfKz/Fo3vscJeU/C2elbRjdSPQN8CkCejZllQfKhsBSSCTBaQl
 21UxgpKjdk1Xk/p/8mrOsidboOWD57d/V5QBDou7MQc10GjUrE1mE3aH/Z7byymG1jXn8HoOb9P
 kaOe7wfxsMT3OI2FH9eQDG0YFRu6dsM1OCf5sJDfx1+12ErdzGhFMssA9Z0LgqU+BGvAXqU6cKB
 I1p1rXVjS08RvtMRIwv9WcXxIR+hA+O5GFnvINbqxO3laOKJTKkBfJ1f1OrAZnu5lsfOOc/QQbI
 2Mi1rrNhUT7/OmRoUGm6vsKqF8PusLphd4siS4eYL1VWxRHp4rWc3095WBbUZXRqY7Cdl7y808D
 3CL/e7Ca9p1o0zUZLqjT7pxpWWBHcPG7Sk4CuQIQ7rQ4CwHqMD7RVCezl4EDV7/y8zyKGqvm4Wg
 /6V3L0Fz31vJJ8g==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Apr 2026 20:30:28 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2952

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
Ferass El Hafidi (4):
      arm: mach-meson: move reset_cpu to spl only
      arm: meson: enable SYSRESET_PSCI
      configs: libretech-ac_defconfig: enable EFI Capsule on Disk
      configs: libretech-cc_defconfig: enable EFI Capsule on Disk

 arch/arm/mach-meson/Kconfig        |  2 ++
 arch/arm/mach-meson/board-common.c | 14 --------------
 arch/arm/mach-meson/spl.c          | 10 ++++++++++
 configs/libretech-ac_defconfig     |  1 +
 configs/libretech-cc_defconfig     |  4 ++++
 5 files changed, 17 insertions(+), 14 deletions(-)
---
base-commit: 4dc4080805fac1b1ed7606ce3bc8fb44a6d59d5e
change-id: 20260408-b4-amlogic-sysreset-capsules-8f5962defafb

Best regards,
-- 
Ferass El Hafidi <funderscore@postmarketos.org>


