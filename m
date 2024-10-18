Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F84FCF5365
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 12:18:51 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.21173.1729255280806931393
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Oct 2024 05:41:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=NbY+7mGT;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A9583100002;
	Fri, 18 Oct 2024 15:41:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A9583100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1729255275;
	bh=uZJs1eG9L5VywkrvoKYmiFLXp2NFacB75RxLzHHD9N0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=NbY+7mGT/gtPuMROYlrzxons4WKEl8XtSExDp//lCZuaWOYL0vHnJV0z/IthtHuc7
	 ptT35Ugcvn9GllKX6bMe8k2nCDN+UYdzZhtHFfZvtNhcDZwsNxOS1t8jVHuiiSuZIV
	 g2dMzP160qYcMOSWNecGje/8BO0xZ+0J99N46SkTAHPQvxcz3izbsfIKDNCM2NrXx8
	 0RCZ+ImoAuuNkObAHbGf0G5jkSTdxCd14gF4jMWk8E+2y8QE9v86/qPPbtWr9I5TfD
	 ewW9hoZk9cvW0aMX1Y4tdhvNvL0ZDX6jMnZ1ELPMDNXS8hvhQwj3Ueq0aFIlW6JNJr
	 axP6zRShJjh5g==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 18 Oct 2024 15:41:15 +0300 (MSK)
Date: Fri, 18 Oct 2024 15:41:14 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek
	<mkorpershoek@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
	<mario.six@gdsys.cc>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, <rockosov@gmail.com>,
	<kernel@salutedevices.com>, Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: [PATCH v5 0/6] android_ab: introduce bcb ab_dump command and provide several bcb fixes
Message-ID: <20241018124114.53zwgww442h2dyo4@CAB-WSD-L081021>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.28.129.94]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188532 [Oct 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 40 0.3.40 cefee68357d12c80cb9cf2bdcf92256b1d238d22, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;github.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/18 12:04:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/18 12:05:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/18 11:16:00 #26771667
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 23 Oct 2024 12:18:51 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2529

On Thu, Oct 17, 2024 at 05:12:05PM +0300, Dmitry Rokosov wrote:
> The patch series include changes:
>     - move ab_select_slot() documentation to @ notation
>     - redesign 'bcb' command to U_BOOT_LONGHELP approach
>     - move ab_select command to bcb subcommands
>     - introduce the ab_dump command to print the content of the BCB
>       block; it's useful for debugging A/B logic on supported boards
>     - fix the slot suffix format in the ABC block to align with official
>       Android BCB specifications
>     - add a test for the ab_dump command to verify the accuracy of each
>       field within the ABC data displayed, it's also useful for testing
>       slot_suffix problem code paths
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
> Changes in v5:
> - rework direct #ifdefs to IS_ENABLED() macro
> - redesign 'bcb' command to U_BOOT_LONGHELP approach
> - check argc directly in the ab_select and ab_dump subcommands handlers
> - Link to v4: https://lore.kernel.org/r/20241015-android_ab_master-v4-0-a91cca9513c4@salutedevices.com
> 
> Changes in v4:
> - add #ifdefs for CONFIG_ANDROID_AB in cmd/bcb.c to allow the usage of
>   the bcb command without A/B enabled
> - run the savedefconfig command for all defconfigs that include the
>   CMD_BCB configuration
> - resolve merge conflicts with latest master
> - provide additional trailers from the previous version (excluding
>   changed patches)
> - Link to v3: https://lore.kernel.org/r/20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com
> 
> Changes in v3:
> - return "Legend" block for bcb command
> - additionally, verify the CONFIG_ANDROID_AB configuration alongside
>   CONFIG_CMD_BCB to ensure that the A/B scheme is used for the
>   designated board.
> - Link to v2: https://lore.kernel.org/all/20240911214945.15873-1-ddrokosov@salutedevices.com/
> 
> Changes in v2:
> - move ab_select_slot() documentation to @ notation
> - move ab_select command to bcb subcommands per Simon and Mattijs
>   suggestions
> - redesign ab_dump as bcb subcommand
> - use spaces instead of tabs in the ab_dump command output
> - print hex values in the lowercase
> - add RvB tags
> - Link to v1: https://lore.kernel.org/all/20240725194716.32232-1-ddrokosov@salutedevices.com/
> 
> ---
> Dmitry Rokosov (6):
>       include/android_ab: move ab_select_slot() documentation to @ notation
>       cmd: bcb: rework the command to U_BOOT_LONGHELP approach
>       treewide: bcb: move ab_select command to bcb subcommands
>       cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
>       cmd: bcb: introduce 'ab_dump' command to print BCB block content
>       common: android_ab: fix slot suffix for abc block
> 
>  MAINTAINERS                               |   1 -
>  boot/android_ab.c                         | 116 +++++++++++++---
>  cmd/Kconfig                               |  14 --
>  cmd/Makefile                              |   1 -
>  cmd/ab_select.c                           |  66 ---------
>  cmd/bcb.c                                 | 221 +++++++++++++++++-------------
>  configs/am57xx_evm_defconfig              |   1 -
>  configs/am57xx_hs_evm_defconfig           |   1 -
>  configs/am57xx_hs_evm_usb_defconfig       |   1 -
>  configs/khadas-vim3_android_ab_defconfig  |   1 -
>  configs/khadas-vim3l_android_ab_defconfig |   1 -
>  configs/sandbox64_defconfig               |   2 +
>  configs/sandbox_defconfig                 |   1 -
>  doc/android/ab.rst                        |  12 +-
>  include/android_ab.h                      |  17 ++-
>  include/configs/khadas-vim3_android.h     |   2 +-
>  include/configs/khadas-vim3l_android.h    |   2 +-
>  include/configs/meson64_android.h         |   4 +-
>  include/configs/ti_omap5_common.h         |   4 +-
>  test/py/tests/test_android/test_ab.py     |  31 ++++-
>  20 files changed, 275 insertions(+), 224 deletions(-)
> ---
> base-commit: 98a36deb9ab7aaea70b0b0db47718100e08cf3e8
> change-id: 20241008-android_ab_master-d86d71c839ae
> 
> Best regards,
> -- 
> Dmitry Rokosov <ddrokosov@salutedevices.com>
> 

CI/CD tests have been successfully completed.

Please see more details:
https://github.com/u-boot/u-boot/pull/625/checks

-- 
Thank you,
Dmitry

