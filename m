Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172A3CDDE7E
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 12:18:31 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.49567.1729174339151227660
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Oct 2024 07:12:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=fZxiNudE;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id CC044100015;
	Thu, 17 Oct 2024 17:12:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CC044100015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1729174335;
	bh=0RT1hwnJoEoCCLqLYk5eduvjRZBhos+bsHJiwL3+nKg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:From;
	b=fZxiNudE7NjRZ4YsJuevCg2OB5CJ+XcXMTaA45cVkUGXzevG8dJS+06eeFA0Xdbvm
	 3VGbWbBqButbVpALwxeFiX2751koUjh2nHhuFxYx5aFhk+rChWW4xBGaa++DjFAb9D
	 395hCpEnvTn5na/+KMsKdwcMB4C/wxT90S4uSscKU1XKDoKBxl4xj2ww4a3oSrLRRM
	 T/o22L2TN9fPjfmyXCYtaS8amHn/R7eWk4RnP5OUv4juNF/0VMA01dnb1IcmQB0ao8
	 20OFDMlo68ZlYoYjxI1TXLLLjOd+0LnBknA/z++nX5CSl9HHpjqJNGzsILAqC1JQXj
	 9bKSMZzSw1BRA==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 17 Oct 2024 17:12:15 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v5 0/6] android_ab: introduce bcb ab_dump command and provide several bcb fixes
Date: Thu, 17 Oct 2024 17:12:05 +0300
Message-ID: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADUbEWcC/33OSwrCMBCA4auUrI3kqY0r7yFSxmRqA7aRpAal9
 O6mXbkoLv+B+WYmkjB6TORUTSRi9smHoYTeVcR2MNyReleaCCYUZ6ymMLgYvGvg1vSQRozU1Qd
 35LaWBpCUvWfE1r9X83It3fk0hvhZT2S5TP9pWVJGW2GEVRqkRHVO8HiN6MpzFtPehp4salY/E
 tdbkioSGG4tGM2l3ZTmef4CtITg7wQBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729174334; l=3936;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=MnC909R4L/nIdriJx+WBV8cqTpJ8si6YoHe590toZg4=;
 b=dRdNKvAJ+roDs0W2bnvg2QfEF29XsIHgkiSLHTVQ3g9I9Cc4znbj160GfuSRbApXt3J287QoE
 sHbw4ILkfulDy7Q5LjGZQqKzk56pAUHxOc9BLhlC7kcMGCl56O9vp9f
X-Developer-Key: i=ddrokosov@salutedevices.com; a=ed25519;
 pk=J6t8z4aofCVwzR1Xs7royc+IGyQcL0cTby92cz3i8B4=
X-Originating-IP: [172.28.226.150]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188512 [Oct 17 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 40 0.3.40 cefee68357d12c80cb9cf2bdcf92256b1d238d22, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;lore.kernel.org:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/17 12:43:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/17 13:42:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/17 12:16:00 #26766523
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 23 Oct 2024 12:18:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2523

The patch series include changes:
    - move ab_select_slot() documentation to @ notation
    - redesign 'bcb' command to U_BOOT_LONGHELP approach
    - move ab_select command to bcb subcommands
    - introduce the ab_dump command to print the content of the BCB
      block; it's useful for debugging A/B logic on supported boards
    - fix the slot suffix format in the ABC block to align with official
      Android BCB specifications
    - add a test for the ab_dump command to verify the accuracy of each
      field within the ABC data displayed, it's also useful for testing
      slot_suffix problem code paths

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
Changes in v5:
- rework direct #ifdefs to IS_ENABLED() macro
- redesign 'bcb' command to U_BOOT_LONGHELP approach
- check argc directly in the ab_select and ab_dump subcommands handlers
- Link to v4: https://lore.kernel.org/r/20241015-android_ab_master-v4-0-a91cca9513c4@salutedevices.com

Changes in v4:
- add #ifdefs for CONFIG_ANDROID_AB in cmd/bcb.c to allow the usage of
  the bcb command without A/B enabled
- run the savedefconfig command for all defconfigs that include the
  CMD_BCB configuration
- resolve merge conflicts with latest master
- provide additional trailers from the previous version (excluding
  changed patches)
- Link to v3: https://lore.kernel.org/r/20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com

Changes in v3:
- return "Legend" block for bcb command
- additionally, verify the CONFIG_ANDROID_AB configuration alongside
  CONFIG_CMD_BCB to ensure that the A/B scheme is used for the
  designated board.
- Link to v2: https://lore.kernel.org/all/20240911214945.15873-1-ddrokosov@salutedevices.com/

Changes in v2:
- move ab_select_slot() documentation to @ notation
- move ab_select command to bcb subcommands per Simon and Mattijs
  suggestions
- redesign ab_dump as bcb subcommand
- use spaces instead of tabs in the ab_dump command output
- print hex values in the lowercase
- add RvB tags
- Link to v1: https://lore.kernel.org/all/20240725194716.32232-1-ddrokosov@salutedevices.com/

---
Dmitry Rokosov (6):
      include/android_ab: move ab_select_slot() documentation to @ notation
      cmd: bcb: rework the command to U_BOOT_LONGHELP approach
      treewide: bcb: move ab_select command to bcb subcommands
      cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
      cmd: bcb: introduce 'ab_dump' command to print BCB block content
      common: android_ab: fix slot suffix for abc block

 MAINTAINERS                               |   1 -
 boot/android_ab.c                         | 116 +++++++++++++---
 cmd/Kconfig                               |  14 --
 cmd/Makefile                              |   1 -
 cmd/ab_select.c                           |  66 ---------
 cmd/bcb.c                                 | 221 +++++++++++++++++-------------
 configs/am57xx_evm_defconfig              |   1 -
 configs/am57xx_hs_evm_defconfig           |   1 -
 configs/am57xx_hs_evm_usb_defconfig       |   1 -
 configs/khadas-vim3_android_ab_defconfig  |   1 -
 configs/khadas-vim3l_android_ab_defconfig |   1 -
 configs/sandbox64_defconfig               |   2 +
 configs/sandbox_defconfig                 |   1 -
 doc/android/ab.rst                        |  12 +-
 include/android_ab.h                      |  17 ++-
 include/configs/khadas-vim3_android.h     |   2 +-
 include/configs/khadas-vim3l_android.h    |   2 +-
 include/configs/meson64_android.h         |   4 +-
 include/configs/ti_omap5_common.h         |   4 +-
 test/py/tests/test_android/test_ab.py     |  31 ++++-
 20 files changed, 275 insertions(+), 224 deletions(-)
---
base-commit: 98a36deb9ab7aaea70b0b0db47718100e08cf3e8
change-id: 20241008-android_ab_master-d86d71c839ae

Best regards,
-- 
Dmitry Rokosov <ddrokosov@salutedevices.com>


