Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE43C46CA1
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 07:27:00 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.87454.1696932397373118848
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Oct 2023 03:06:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=ccZGLWgL;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avromanov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 90EBB100010;
	Tue, 10 Oct 2023 13:06:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 90EBB100010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696932393;
	bh=Y5nVu+FrxAUa0QuV2owxreQLfkB3cs+zRrLItUKy+JU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ccZGLWgLFMykdvH5ubbQdC+/wGWju5IqZA+uN8cpUYNGmgdCU+CJ3oZPS802oTvXs
	 EkpeURuLxM89r9ZLx6k9CO+YstD5p4RNzKQo3StkUZvYMzszyuLmFVolvX+nRXLz+Q
	 t1wsGvcG0hKiXsObAt3gYNHA+Ey2BOsBwlXoXvQxbp8OTtZthE3yWEzpCc42v2r/qd
	 kmfBW44omRHv4zYB7PdlmjScm74TCVWqacIAxo/jO8A2gxZ/OaDuqqSEOzr+GnBaC+
	 cr1ohajSyTXOPL8XCptLq7rRvHdyij68RoAK9bqFkk9wbuFCf787sO1CfoCvD2Z0Pk
	 wNUWWqpvo334g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 10 Oct 2023 13:06:33 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 10 Oct 2023 13:06:33 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 2/2] meson-a1: dts: add ao secure node
Date: Tue, 10 Oct 2023 13:06:17 +0300
Message-ID: <20231010100623.74475-3-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010100623.74475-1-avromanov@salutedevices.com>
References: <20231010100623.74475-1-avromanov@salutedevices.com>
MIME-Version: 1.0
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180496 [Oct 10 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 536 536 1ae19c7800f69da91432b5e67ed4a00b9ade0d03, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/10 08:07:00 #22138887
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 12 Oct 2023 07:27:00 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1747
Message-ID: <20231010100617.WGpgbkBWkCh1-HQ0BHenR3Cv8RqHTGdOFKvtVmim8EI@z>

ao-secure node can be used to get information about the board,
so, for example, using show_board_info() we can get following
information for board with Meson A1 SoC:

SoC: Amlogic Meson A1 (A113L) Revision 2c:a (1:a)

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 arch/arm/dts/meson-a1.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/meson-a1.dtsi b/arch/arm/dts/meson-a1.dtsi
index e6e72d4004..e3a42c5b24 100644
--- a/arch/arm/dts/meson-a1.dtsi
+++ b/arch/arm/dts/meson-a1.dtsi
@@ -129,6 +129,12 @@
 				compatible =3D "amlogic,meson-rng";
 				reg =3D <0x0 0x5118 0x0 0x4>;
 			};
+
+			sec_AO: ao-secure@5a20 {
+				compatible =3D "amlogic,meson-gx-ao-secure", "syscon";
+				reg =3D <0x0 0x5a20 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
 		};
=20
 		gic: interrupt-controller@ff901000 {
--=20
2.25.1


