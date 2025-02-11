Return-Path: <adeep@lexina.in>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DE6C021A0
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 07:32:58 +0000 (UTC)
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web11.6883.1739259171410930461
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Feb 2025 23:32:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@lexina.in header.s=dkim header.b=J/N+feFH;
 spf=pass (domain: lexina.in, ip: 185.250.0.168, mailfrom: adeep@lexina.in)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0C6314E236;
	Tue, 11 Feb 2025 10:32:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1739259169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ikX4PIUJ2IObhjNcN0/JX2GmzxBu5O0Fsk1cbbhn1Ec=;
	b=J/N+feFHLdIYLhbhaNql+61xl/4Jn4GlFXEIHinNV6OfAWw9usjaTD8peJK7a2wrOhziIp
	30/MOL8CrmH7WMjN6O+ynYpe14YAAke+UYEdStGNonCy6F6Bm9uFtPVXMm/yxNzn1QF1j4
	QbMNOnT0PV8ERc4d7ET0+gUo45Sj2RZJV7CC3CRH8JJ8H49BcCaNRNA4nxQjYyyi8DWMtg
	Go/rS74jggMRa5VZiBKhBCyisC0Oy2gDh+Iv3B44uH+obZ7gvw5U+gYrzKj76fr09FATLV
	emJrhcG3/oOF7IGa0MHIC0pKJ2rheDfjP8YdhOpHI1SeskY/UJc0Ifc6ugJ0YA==
Message-ID: <34b3d266-af14-49fd-a45f-139db67d916b@lexina.in>
Date: Tue, 11 Feb 2025 10:32:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm: meson: extend sm calls to support Amlogic
 chip_id v1, v2
To: Evgeny Bachinin <EABachinin@salutedevices.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kernel@salutedevices.com, evgen89bachinin@gmail.com,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250210-meson_chip_id_all_vers-v1-0-b98f8b6880b8@salutedevices.com>
Content-Language: ru
From: Viacheslav <adeep@lexina.in>
Autocrypt: addr=adeep@lexina.in; keydata=
 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
In-Reply-To: <20250210-meson_chip_id_all_vers-v1-0-b98f8b6880b8@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 11 Feb 2025 07:32:58 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2619

Hi!

10/02/2025 20.50, Evgeny Bachinin wrote:
> The Amlogic Meson SoC secure monitor (TF-A) handles a call (0x82000044)
> to retrieve a chip_id from eFuse OTP data [1].
> 
> Previously, this sm call (0x82000044) was used to retrieve just unique
> SoC number [2] (a.k.a. SoC "serial" [3]), identifying particular die.
> This SoC serial, stored in the eFuse, is always 12 bytes long.
> 
> However, this smc provides more info and the patch series generalizes
> the API to provide SoC serial and support of chip_id.
> 
> Chip_id in eFuse OTP storage exists in two flavors [1]: v1 (12 bytes)
> and v2 (16 bytes). The vendor U-Boot handles this difference before
> returning the chip_id value to the client and generalizes versions to
> look like the following (always 16 bytes in size):
> 
>      4 bytes      12 bytes
>      +-------+-------------------+
>      |       |                   |
>      | CPUID | SOC SERIAL NUMBER |
>      |       |                   |
>      +-------+-------------------+
>      0                          15
> 
> The original chip_id value is utilized in several algorithms (for
> example, in the Amlogic boot protocols), making it crucial to have the
> ability to read the original chip_id value as intended by the vendor [3]
> 
> Links:
> [1] https://github.com/TrustedFirmware-A/trusted-firmware-a/blob/03a7a43e18927c876ef5f554e54fa11d252d4f7e/plat/amlogic/common/aml_sip_svc.c#L21
> [2] https://lore.kernel.org/u-boot/20190612094908.24858-2-narmstrong@baylibre.com/
> [3] https://lore.kernel.org/linux-arm-kernel/202311242104.RjBPI3uI-lkp@intel.com/T/#m630fbeea6a6e7d531290b5c0af205af4fb979757
> 
> Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> ---
> Patch is based on:
> - v5 of Linux patch series
>    https://lore.kernel.org/linux-amlogic/20240610084032.3096614-1-adeep@lexina.in/
> 
> Tested:
> * on A1, AXG.

+ gxl (S905W)

Tested-by: Viacheslav Bocharov <adeep@lexina.in>


> * U-boot CI: https://github.com/u-boot/u-boot/pull/740/checks
> 
> ---
> Evgeny Bachinin (3):
>        arm: meson: unify type being used for socinfo
>        arm: meson: sm: get rid of SM_CHIP_ID_SIZE
>        arch: arm: meson: support Amlogic chip_id v1 and v2
> 
>   arch/arm/include/asm/arch-meson/boot.h |  14 ++++
>   arch/arm/include/asm/arch-meson/sm.h   |  48 ++++++++++++-
>   arch/arm/mach-meson/board-info.c       |  13 ++--
>   arch/arm/mach-meson/sm.c               | 120 ++++++++++++++++++++++++++++++---
>   4 files changed, 179 insertions(+), 16 deletions(-)
> ---
> base-commit: 6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72
> change-id: 20250208-meson_chip_id_all_vers-8ed402afae36
> 
> Best regards,


