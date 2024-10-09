Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E65DCF2590
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:01:02 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.16302.1728480534033574923
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Oct 2024 06:28:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=cjwrxRHp;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6E011120017;
	Wed,  9 Oct 2024 16:28:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6E011120017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728480532;
	bh=ohoNXEXDTuqDaDxlOCNVP6pJtovyeJJhq+tDLVIb9aU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=cjwrxRHpQHHEQTE2DHLv5DGxltG5WiFXT2ENDRpp7wNKuJqJ2Iz5VTASkHkHP5v+p
	 cBpe4vquNSGOCsMJ7cnmhAmqQafj2AA1zBob0F7HUiLxY+8G+JN2K3xyAkDw2MD/xj
	 0xig2UgAKByAl/1pxaGjdI1F8sF37MUwz9a3wqz8vnbtIk0kZR5wUfm4bwKrnx/J4p
	 KMvFCAj0E8TKx/du0TamQ8h1iMtaER4cLs3HZ2St+FTUXqqCmXqFpLEnkRVbawfp3R
	 qu/mFtYbpgKvWIn7Lo7AQFoVbB6IxU0bwddvee5kRFy1W3NzO5GuV+iUbV0Wv2NGNa
	 5AcgTrQ9a0bwA==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  9 Oct 2024 16:28:52 +0300 (MSK)
Date: Wed, 9 Oct 2024 16:28:51 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek
	<mkorpershoek@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
	<mario.six@gdsys.cc>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, <rockosov@gmail.com>,
	<kernel@salutedevices.com>
Subject: Re: [PATCH v3 0/6] android_ab: introduce bcb ab_dump command and provide several bcb fixes
Message-ID: <20241009132851.qnqln2jla4u3jwig@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.28.226.150]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188331 [Oct 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;github.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/09 12:25:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/09 12:25:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/09 10:10:00 #26721802
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:01:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2477

On Tue, Oct 08, 2024 at 11:18:03PM +0300, Dmitry Rokosov wrote:
> The patch series include changes:
>     - move ab_select_slot() documentation to @ notation
>     - move ab_select command to bcb subcommands
>     - introduce the ab_dump command to print the content of the BCB
>       block; it's useful for debugging A/B logic on supported boards
>     - fix the slot suffix format in the ABC block to align with official
>       Android BCB specifications
>     - add a test for the ab_dump command to verify the accuracy of each
>       field within the ABC data displayed, it's also useful for testing
>       slot_suffix problem code paths
> 
> Changes v3 since v2 at [2]:
>     - return "Legend" block for bcb command
>     - additionally, verify the CONFIG_ANDROID_AB configuration alongside
>       CONFIG_CMD_BCB to ensure that the A/B scheme is used for the
>       designated board.
> 
> Changes v2 since v1 at [1]:
>     - move ab_select_slot() documentation to @ notation
>     - move ab_select command to bcb subcommands per Simon and Mattijs
>       suggestions
>     - redesign ab_dump as bcb subcommand
>     - use spaces instead of tabs in the ab_dump command output
>     - print hex values in the lowercase
>     - add RvB tags
> 
> Links:
>     [1] https://lore.kernel.org/all/20240725194716.32232-1-ddrokosov@salutedevices.com/
>     [2] https://lore.kernel.org/all/20240911214945.15873-1-ddrokosov@salutedevices.com/
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
> Dmitry Rokosov (6):
>       include/android_ab: move ab_select_slot() documentation to @ notation
>       treewide: bcb: move ab_select command to bcb subcommands
>       cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
>       cmd: bcb: introduce 'ab_dump' command to print BCB block content
>       common: android_ab: fix slot suffix for abc block
>       test/py: introduce test for ab_dump command
> 
>  MAINTAINERS                               |   1 -
>  boot/android_ab.c                         | 116 ++++++++++++++++++++++++------
>  cmd/Kconfig                               |  15 +---
>  cmd/Makefile                              |   1 -
>  cmd/ab_select.c                           |  66 -----------------
>  cmd/bcb.c                                 |  98 +++++++++++++++++++++++++
>  configs/am57xx_hs_evm_usb_defconfig       |   1 -
>  configs/khadas-vim3_android_ab_defconfig  |   1 -
>  configs/khadas-vim3l_android_ab_defconfig |   1 -
>  configs/sandbox64_defconfig               |   4 +-
>  configs/sandbox_defconfig                 |   4 +-
>  doc/android/ab.rst                        |  12 ++--
>  include/android_ab.h                      |  17 ++++-
>  include/configs/khadas-vim3_android.h     |   2 +-
>  include/configs/khadas-vim3l_android.h    |   2 +-
>  include/configs/meson64_android.h         |   4 +-
>  include/configs/ti_omap5_common.h         |   4 +-
>  test/py/tests/test_android/test_ab.py     |  31 ++++++--
>  18 files changed, 252 insertions(+), 128 deletions(-)
> ---
> base-commit: fbe16bc28014dc1ed957f5fee7e53d6eee781aa9
> change-id: 20241008-android_ab_master-d86d71c839ae
> 
> Best regards,
> -- 
> Dmitry Rokosov <ddrokosov@salutedevices.com>
> 

SUCCESSFUL TEST RESULTS FROM CI/CD:

https://github.com/u-boot/u-boot/pull/625/checks

-- 
Thank you,
Dmitry

