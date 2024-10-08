Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AC9CFC503
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:01:02 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.5757.1728418707944254679
 for <u-boot-amlogic@groups.io>;
 Tue, 08 Oct 2024 13:18:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=k1Z4iKlI;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BF6F912000A;
	Tue,  8 Oct 2024 23:18:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BF6F912000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728418704;
	bh=FSFhvq7nQ5wRU19/K6W1Fb8znpd2FkTfI2qC37sJ4A4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:From;
	b=k1Z4iKlIbQ/IWJgtEJ4kqE3x8H5svpWr5QtzS4KPe0LAnuqA81w0SYPP3/G8D6y5S
	 vzTWNm1iF/jU9y1Qk0u2bLrRBtAnENDpvScrHQ6qLNTfjz40cu3GXTxetvyRX11onw
	 HcD5YuWq71SPm5amK4I1rQB+dIycnfKHe0+05TfTM2EyXhTNDfTNzOU+ha/9COYGgX
	 SodblygrN/QQC25Da/eeP9bDKk3cEfzv0R+0tX+Uq+6C8fHE9ckjGPuw+Zdit+zRkK
	 hDE+zUy57YjO/rMVJF21/2nJtI/b8nsL5h4IJ76He9epoHfNfF9Op1t+qZ5QYBYBr9
	 FrtXjt6xRHllg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  8 Oct 2024 23:18:24 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v3 0/6] android_ab: introduce bcb ab_dump command and provide several bcb fixes
Date: Tue, 8 Oct 2024 23:18:03 +0300
Message-ID: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHuTBWcC/x3M3QpAQBBA4VfRXNtaP7G8iqRhBnNhaVZS8u42l
 9/FOQ8EVuEAbfKA8iVBdh9RpAlMK/qFjVA05DYvM2udQU+6Cw04DhuGk9WQq6jOJlc0yBC7Q3m
 W+392/ft+Vk1DGGMAAAA=
X-Change-ID: 20241008-android_ab_master-d86d71c839ae
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek
	<mkorpershoek@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
	<mario.six@gdsys.cc>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, <rockosov@gmail.com>,
	<kernel@salutedevices.com>, Dmitry Rokosov <ddrokosov@salutedevices.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728418703; l=3095;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=oDSyNWEinR2XNWMtAB5HW5VA6AcRuYgvPbLPHGlteQc=;
 b=JPxfd3j2mqy0sG3rreLZ1jtuQEqaceh67nkZ6e/RQyRtp7a0jOK1Ia+CagIMWTz/C/ab6Alvz
 Wgv4AHTT+s1BNRlcBofyXz9HGbRFc0Cz/ksotBIjs7ERdqHHTmcGgBL
X-Developer-Key: i=ddrokosov@salutedevices.com; a=ed25519;
 pk=J6t8z4aofCVwzR1Xs7royc+IGyQcL0cTby92cz3i8B4=
X-Originating-IP: [172.28.129.94]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188309 [Oct 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/08 14:31:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/08 14:31:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/08 14:43:00 #26717371
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:01:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2466

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
Dmitry Rokosov (6):
      include/android_ab: move ab_select_slot() documentation to @ notation
      treewide: bcb: move ab_select command to bcb subcommands
      cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
      cmd: bcb: introduce 'ab_dump' command to print BCB block content
      common: android_ab: fix slot suffix for abc block
      test/py: introduce test for ab_dump command

 MAINTAINERS                               |   1 -
 boot/android_ab.c                         | 116 ++++++++++++++++++++++++------
 cmd/Kconfig                               |  15 +---
 cmd/Makefile                              |   1 -
 cmd/ab_select.c                           |  66 -----------------
 cmd/bcb.c                                 |  98 +++++++++++++++++++++++++
 configs/am57xx_hs_evm_usb_defconfig       |   1 -
 configs/khadas-vim3_android_ab_defconfig  |   1 -
 configs/khadas-vim3l_android_ab_defconfig |   1 -
 configs/sandbox64_defconfig               |   4 +-
 configs/sandbox_defconfig                 |   4 +-
 doc/android/ab.rst                        |  12 ++--
 include/android_ab.h                      |  17 ++++-
 include/configs/khadas-vim3_android.h     |   2 +-
 include/configs/khadas-vim3l_android.h    |   2 +-
 include/configs/meson64_android.h         |   4 +-
 include/configs/ti_omap5_common.h         |   4 +-
 test/py/tests/test_android/test_ab.py     |  31 ++++++--
 18 files changed, 252 insertions(+), 128 deletions(-)
---
base-commit: fbe16bc28014dc1ed957f5fee7e53d6eee781aa9
change-id: 20241008-android_ab_master-d86d71c839ae

Best regards,
-- 
Dmitry Rokosov <ddrokosov@salutedevices.com>


