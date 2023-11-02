Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886A2C0018A
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 12:20:47 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.29242.1698927637667909265
 for <u-boot-amlogic@groups.io>;
 Thu, 02 Nov 2023 05:20:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@sberdevices.ru header.s=mail header.b=dNHbALrM;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1AC3210003E;
	Thu,  2 Nov 2023 15:20:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1AC3210003E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1698927636;
	bh=Q1ZLj/XfyvdXXlRLEzGTH9id27ML/mLzmudr8u8JdWc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=dNHbALrMO5BhfH0ZdnkrX143jVrLMohoolfJkbOnBqJR+2xDro0OXrH96xFAUGTod
	 RESngLL1W98Yup3y44/lFkDXi3sSgVJsV18Sj5NKD+YD8t1WNHhAOpaT/FJ7gEEltv
	 aeE4gjKBimZ7JVx8TTj/+Y2lPfAxErRQlWUwZgnj0H25VpdL7h1zC89BdbfS/nhvGv
	 +v/Hv4eSuVHuZ5jCMS0zuJxMKg4vVm8RdAHLc/hOydlJZdDYOYN1lHRfq6Vsrw/K8g
	 OYtj+IteZDMTCcd9zX8wK7E3Oq2YtNxb+5g8NpCS2GxQfYH56sLZ4R18/r07MQtVEf
	 iJCgSrZ4PfTrQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  2 Nov 2023 15:20:35 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 2 Nov 2023 15:20:35 +0300
From: Igor Prusov <ivprusov@sberdevices.ru>
To: Michal Simek <michal.simek@amd.com>, Daniel Schwierzeck
	<daniel.schwierzeck@gmail.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei
 Wang <chiawei_wang@aspeedtech.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
	<ivprusov@sberdevices.ru>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v5 5/8] clk: Add dump operation to clk_ops
Date: Thu, 2 Nov 2023 15:20:14 +0300
Message-ID: <20231102122017.56995-6-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102122017.56995-1-ivprusov@sberdevices.ru>
References: <20231102122017.56995-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181075 [Nov 02 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/02 06:57:00 #22385341
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 02 Nov 2023 12:20:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1812

This adds dump function to struct clk_ops which should replace
soc_clk_dump. It allows clock drivers to provide custom dump
implementation without overriding generic CCF dump function.

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 include/clk-uclass.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/clk-uclass.h b/include/clk-uclass.h
index a22f1a5d84..793bf14160 100644
--- a/include/clk-uclass.h
+++ b/include/clk-uclass.h
@@ -25,6 +25,7 @@ struct ofnode_phandle_args;
  * @set_parent: Set current clock parent
  * @enable: Enable a clock.
  * @disable: Disable a clock.
+ * @dump: Print clock information.
  *
  * The individual methods are described more fully below.
  */
@@ -39,6 +40,9 @@ struct clk_ops {
 	int (*set_parent)(struct clk *clk, struct clk *parent);
 	int (*enable)(struct clk *clk);
 	int (*disable)(struct clk *clk);
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	int (*dump)(struct udevice *dev);
+#endif
 };
=20
 #if 0 /* For documentation only */
@@ -135,6 +139,17 @@ int enable(struct clk *clk);
  * Return: zero on success, or -ve error code.
  */
 int disable(struct clk *clk);
+
+/**
+ * dump() - Print clock information.
+ * @clk:	The clock device to dump.
+ *
+ * If present, this function is called by "clk dump" command for each
+ * bound device.
+ *
+ * Return: zero on success, or -ve error code.
+ */
+int dump(struct udevice *dev);
 #endif
=20
 #endif
--=20
2.34.1


