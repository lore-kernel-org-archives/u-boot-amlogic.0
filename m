Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEA3C021A4
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 12:30:20 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.58489.1739209839770144714
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Feb 2025 09:50:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=PdP3kDgs;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: eabachinin@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 006BF100009;
	Mon, 10 Feb 2025 20:50:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 006BF100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1739209837;
	bh=ZwKx3qrW0D97VXlYSODXWge36bsoWe9uaB72LWBLlfA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:From;
	b=PdP3kDgsW+xlS5S/QvPiUaMQDj4BEPfBOZH4DbomQnWMORtczTJFqLCIzNZz+4jX7
	 FrgXhiqqoi7Wqgwun5ojL2dStHenrJKLbJHOetvAbGLvq/YBYZjLkPHRHZgUE8JSVH
	 U5flsNr2laHRA5OrGhbkGBm6f2qs55hv/NYLcsk1V3inY+EfC3z1AQmxHQ2HO0Ji5T
	 Kw+PbkTjqU669gvLgWb4f5yaYhk2hY98hugBBC4xRbaeJdg5CmI1BTqD14+UNWXQWW
	 qneBhizmZjAQBzlqryJ5M4zMTy0ugs0eqRC8bNtx6YYcdjc/Cg8cTNj8yMEbJK3j3N
	 rwYbkYaySgGlA==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 10 Feb 2025 20:50:36 +0300 (MSK)
From: Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: [PATCH 0/3] arm: meson: extend sm calls to support Amlogic chip_id v1, v2
Date: Mon, 10 Feb 2025 20:50:13 +0300
Message-ID: <20250210-meson_chip_id_all_vers-v1-0-b98f8b6880b8@salutedevices.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFU8qmcC/x3MWwqAIBBG4a3EPCeYXYi2EiGSfzVQFg5IEO096
 fF7OOchQWQIDcVDEYmFz5BRlQXNmwsrFPtsMtq02uheHZAz2Hnjy7K3bt9tQhTVwzfauMWh7ij
 HV8TC9z8ep/f9AOZTlstoAAAA
X-Change-ID: 20250208-meson_chip_id_all_vers-8ed402afae36
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Viacheslav Bocharov <adeep@lexina.in>, Arseniy Krasnov
	<avkrasnov@salutedevices.com>
CC: <kernel@salutedevices.com>, <evgen89bachinin@gmail.com>,
	<u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>, Evgeny Bachinin
	<EABachinin@salutedevices.com>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.28.162.21]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190910 [Feb 10 2025]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;github.com:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/02/10 17:01:00
X-KSMG-LinksScanning: Clean, bases: 2025/02/10 17:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/02/10 15:43:00 #27153787
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 11 Feb 2025 12:30:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2623

The Amlogic Meson SoC secure monitor (TF-A) handles a call (0x82000044)
to retrieve a chip_id from eFuse OTP data [1].

Previously, this sm call (0x82000044) was used to retrieve just unique
SoC number [2] (a.k.a. SoC "serial" [3]), identifying particular die.
This SoC serial, stored in the eFuse, is always 12 bytes long.

However, this smc provides more info and the patch series generalizes
the API to provide SoC serial and support of chip_id.

Chip_id in eFuse OTP storage exists in two flavors [1]: v1 (12 bytes)
and v2 (16 bytes). The vendor U-Boot handles this difference before
returning the chip_id value to the client and generalizes versions to
look like the following (always 16 bytes in size):

    4 bytes      12 bytes
    +-------+-------------------+
    |       |                   |
    | CPUID | SOC SERIAL NUMBER |
    |       |                   |
    +-------+-------------------+
    0                          15

The original chip_id value is utilized in several algorithms (for
example, in the Amlogic boot protocols), making it crucial to have the
ability to read the original chip_id value as intended by the vendor [3]

Links:
[1] https://github.com/TrustedFirmware-A/trusted-firmware-a/blob/03a7a43e18927c876ef5f554e54fa11d252d4f7e/plat/amlogic/common/aml_sip_svc.c#L21
[2] https://lore.kernel.org/u-boot/20190612094908.24858-2-narmstrong@baylibre.com/
[3] https://lore.kernel.org/linux-arm-kernel/202311242104.RjBPI3uI-lkp@intel.com/T/#m630fbeea6a6e7d531290b5c0af205af4fb979757

Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
---
Patch is based on:
- v5 of Linux patch series
  https://lore.kernel.org/linux-amlogic/20240610084032.3096614-1-adeep@lexina.in/

Tested:
* on A1, AXG.
* U-boot CI: https://github.com/u-boot/u-boot/pull/740/checks

---
Evgeny Bachinin (3):
      arm: meson: unify type being used for socinfo
      arm: meson: sm: get rid of SM_CHIP_ID_SIZE
      arch: arm: meson: support Amlogic chip_id v1 and v2

 arch/arm/include/asm/arch-meson/boot.h |  14 ++++
 arch/arm/include/asm/arch-meson/sm.h   |  48 ++++++++++++-
 arch/arm/mach-meson/board-info.c       |  13 ++--
 arch/arm/mach-meson/sm.c               | 120 ++++++++++++++++++++++++++++++---
 4 files changed, 179 insertions(+), 16 deletions(-)
---
base-commit: 6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72
change-id: 20250208-meson_chip_id_all_vers-8ed402afae36

Best regards,
-- 
Evgeny Bachinin <EABachinin@salutedevices.com>


