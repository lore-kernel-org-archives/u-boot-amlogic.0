Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7424FD42B91
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 15:08:18 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.86294.1731416337344724425
 for <u-boot-amlogic@groups.io>;
 Tue, 12 Nov 2024 04:59:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=BEqs+eAF;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avromanov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 98EAD120003;
	Tue, 12 Nov 2024 15:58:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 98EAD120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731416333;
	bh=S2WFxF4RwI2AgaZH1XaVbpzilYjpfjK+K4rQd/R9vh8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=BEqs+eAFClJYLSBuLI3V5jDw8XILrjzb2CYBozrPOuNNVekkJbNu+E8rmhGs/Oyzi
	 Avz8lVoY9e+rTv2gpRvav6LaGvf9h1Z0bN6RYR1mFzDME3smkBOeUV7Brdv5xF88TP
	 /6KIVBENaoLH1q0Ub7BK20+f3B/F6P6lg0kIb4Ecu+Oyj3LGj1zd/5y9nyWskGQs/k
	 iZtxsnCn7d5pp8B6PM0fFp9mwOyKE7UTHld3Z5HYwLGdaX4MKhQnqTkaiwOf0toO+o
	 9Aii1oErwzAn+RWFvMln0a3k46T6/H3bgw9Ri0ZMcxVNkloqKC/h/PRbdPrYt32ZKr
	 Ky7yr+/2AhEaQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 12 Nov 2024 15:58:53 +0300 (MSK)
From: Alexey Romanov <avromanov@salutedevices.com>
To: <trini@konsulko.com>, <neil.armstrong@linaro.org>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 0/4] Remove legacy Amlogic dtsi and bindings
Date: Tue, 12 Nov 2024 15:58:32 +0300
Message-ID: <20241112125836.3239832-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [172.28.130.77]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189115 [Nov 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/12 09:54:00 #26847665
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 12 Nov 2024 15:08:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2543

We should remove bindings and dtsi from include/ folder for A1
and AXG Amlogic devices. We have exactly the same, or with minor
differences in dts/upstream folder.

I tested this changes on devices closes to reference A1 and AXG SoCs
devices and didn't receive any problems.

Alexey Romanov (4):
  arm: dts: meson: remove meson-a1.dtsi
  dt-bindings: remove a1 bindings from include/
  dt-bindings: remove axg bindings from include/
  dt-bindings: interrupt-controller: remove arm-gic.h from include/

 arch/arm/dts/meson-a1.dtsi                    | 518 ------------------
 .../clock/amlogic,a1-peripherals-clkc.h       | 168 ------
 .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |  25 -
 include/dt-bindings/clock/axg-audio-clkc.h    |  94 ----
 include/dt-bindings/clock/axg-clkc.h          | 100 ----
 include/dt-bindings/gpio/meson-a1-gpio.h      |  73 ---
 .../interrupt-controller/arm-gic.h            |  23 -
 include/dt-bindings/power/meson-a1-power.h    |  32 --
 .../reset/amlogic,meson-a1-reset.h            |  76 ---
 9 files changed, 1109 deletions(-)
 delete mode 100644 arch/arm/dts/meson-a1.dtsi
 delete mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
 delete mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h
 delete mode 100644 include/dt-bindings/clock/axg-audio-clkc.h
 delete mode 100644 include/dt-bindings/clock/axg-clkc.h
 delete mode 100644 include/dt-bindings/gpio/meson-a1-gpio.h
 delete mode 100644 include/dt-bindings/interrupt-controller/arm-gic.h
 delete mode 100644 include/dt-bindings/power/meson-a1-power.h
 delete mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h

--=20
2.34.1


