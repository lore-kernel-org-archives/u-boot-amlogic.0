Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7356CD16272
	for <webhook@archiver.kernel.org>; Wed, 16 Oct 2024 07:57:55 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.2909.1728939991723617563
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Oct 2024 14:06:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=ErNKvg+t;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1788E10000A;
	Tue, 15 Oct 2024 00:06:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1788E10000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728939989;
	bh=aDfg3I4ACE5005k+hd+okDWxQvCtOeH6HEMOMUaWb3U=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:From;
	b=ErNKvg+tDOFcpVOiD5FRYIMTMfngGa2yrHXDCjOtBWFDx5U4/mZa78cgOyfqWpIZp
	 Ggj9o3+k8RyxjCwfYbSAd0fu7OLi+P+bhI7AT2X/DIlVm5jlINyvSvfPUUEUtCRQ1J
	 bNgPaM2iUs+PDY4PaXgNSFxlMS9+3V2WM8E/UuLfZLKr89EZ2benJTPVecwIAYI2Q8
	 5VOlIUm2W8VXUx14a7fxlGIW2kzDwkHxSpq7doeATeTJUBsO8isIVQj0gd65ZoTeKy
	 XWRWO2ZP3eABrOsXsYaE9olWLaJ70sGRKR+7+ZeQToVnd+NnMsOfLgh5xlU2SeXBfh
	 q7bZXKkJokEAw==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 00:06:28 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v4 0/5] android_ab: introduce bcb ab_dump command and provide several bcb fixes
Date: Tue, 15 Oct 2024 00:06:12 +0300
Message-ID: <20241015-android_ab_master-v4-0-a91cca9513c4@salutedevices.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMSHDWcC/32OUQ6CMBBEr0L225rSVgW/vIchZG0X2USo6SLRE
 O5u5QB+vknmzSwglJgEzsUCiWYWjmMGtyvA9zjeSXHIDEYbV2pdKRxDihxavLUDykRJheoYTqW
 vbI0EufdM1PF7c16bzD3LFNNnm5jtL/1nm63SqjO18e6A1pK7CD5eE4V8zpPsfRygWdf1C7E6R
 om6AAAA
X-Change-ID: 20241008-android_ab_master-d86d71c839ae
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek
	<mkorpershoek@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
	<mario.six@gdsys.cc>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, <rockosov@gmail.com>,
	<kernel@salutedevices.com>, Dmitry Rokosov <ddrokosov@salutedevices.com>,
	Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728939988; l=3615;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=0B7+C3ExTSZsloaUzotNBQKBj26Vd+43bDvQOFPjeNQ=;
 b=6TnLFYtZ+rz5057l7FlbyL09EKONfzAVHoHkqSsAe4mWLAQg5AmEmGXPJL9eYyn8SX0pxRng/
 oiHfnmplpNPBO11bLdxjZbOxyCIsmsy98wAmnkFs/pweEUz4754qpEo
X-Developer-Key: i=ddrokosov@salutedevices.com; a=ed25519;
 pk=J6t8z4aofCVwzR1Xs7royc+IGyQcL0cTby92cz3i8B4=
X-Originating-IP: [172.28.129.94]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188429 [Oct 14 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/14 18:42:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/14 18:42:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/14 19:21:00 #26753819
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 16 Oct 2024 07:57:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2493

The patch series include changes:
    - move ab_select_slot() documentation to @ notation
    - move ab_select command to bcb subcommands
    - introduce the ab_dump command to print the content of the BCB
      block; it's useful for debugging A/B logic on supported boards
    - fix the slot suffix format in the ABC block to align with official
      Android BCB specifications
    - add a test for the ab_dump command to verify the accuracy of each
      field within the ABC data displayed, it's also useful for testing
      slot_suffix problem code paths

Changes v3 since v2 at [2]:
    - return "Legend" block for bcb command
    - additionally, verify the CONFIG_ANDROID_AB configuration alongside
      CONFIG_CMD_BCB to ensure that the A/B scheme is used for the
      designated board.

Changes v2 since v1 at [1]:
    - move ab_select_slot() documentation to @ notation
    - move ab_select command to bcb subcommands per Simon and Mattijs
      suggestions
    - redesign ab_dump as bcb subcommand
    - use spaces instead of tabs in the ab_dump command output
    - print hex values in the lowercase
    - add RvB tags

Links:
    [1] https://lore.kernel.org/all/20240725194716.32232-1-ddrokosov@salutedevices.com/
    [2] https://lore.kernel.org/all/20240911214945.15873-1-ddrokosov@salutedevices.com/

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
Changes in v4:
- add #ifdefs for CONFIG_ANDROID_AB in cmd/bcb.c to allow the usage of
  the bcb command without A/B enabled
- run the savedefconfig command for all defconfigs that include the
  CMD_BCB configuration
- resolve merge conflicts with latest master
- provide additional trailers from the previous version (excluding
  changed patches)
- Link to v3: https://lore.kernel.org/r/20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com

---
Dmitry Rokosov (5):
      include/android_ab: move ab_select_slot() documentation to @ notation
      treewide: bcb: move ab_select command to bcb subcommands
      cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
      cmd: bcb: introduce 'ab_dump' command to print BCB block content
      common: android_ab: fix slot suffix for abc block

 MAINTAINERS                               |   1 -
 boot/android_ab.c                         | 116 ++++++++++++++++++++++++------
 cmd/Kconfig                               |  14 ----
 cmd/Makefile                              |   1 -
 cmd/ab_select.c                           |  66 -----------------
 cmd/bcb.c                                 | 110 ++++++++++++++++++++++++++++
 configs/am57xx_evm_defconfig              |   1 -
 configs/am57xx_hs_evm_defconfig           |   1 -
 configs/am57xx_hs_evm_usb_defconfig       |   1 -
 configs/khadas-vim3_android_ab_defconfig  |   1 -
 configs/khadas-vim3l_android_ab_defconfig |   1 -
 configs/sandbox64_defconfig               |   2 +
 configs/sandbox_defconfig                 |   1 -
 doc/android/ab.rst                        |  12 ++--
 include/android_ab.h                      |  17 ++++-
 include/configs/khadas-vim3_android.h     |   2 +-
 include/configs/khadas-vim3l_android.h    |   2 +-
 include/configs/meson64_android.h         |   4 +-
 include/configs/ti_omap5_common.h         |   4 +-
 test/py/tests/test_android/test_ab.py     |  31 ++++++--
 20 files changed, 260 insertions(+), 128 deletions(-)
---
base-commit: 5d899fc58c44fe5623e31524da2205d8597a53d1
change-id: 20241008-android_ab_master-d86d71c839ae

Best regards,
-- 
Dmitry Rokosov <ddrokosov@salutedevices.com>


