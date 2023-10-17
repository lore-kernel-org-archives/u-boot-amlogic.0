Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A33ECDB482
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 16:57:20 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.224822.1697561832818584042
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Oct 2023 09:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@sberdevices.ru header.s=mail header.b=NXNOFVxw;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 168EE120008;
	Tue, 17 Oct 2023 19:57:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 168EE120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1697561825;
	bh=IqKNktyVLhcA8Aw87Pu2NltAWnBVQN+KKg5tD/A4MOM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=NXNOFVxw4GCDb8OyB3GNB5+WLfBvY2Gaoj0m1dpOXB/7PNs1oNdT1SiQNPWxdbQuO
	 AVmUYUu52dTGpVENmadKoRszLE7chtlWlsRqvnzIgEgf9G4B1qQ3Q83PFBOFlaQRrq
	 zBTIitghfpy0cRrL+9PVYOdC7qrI58FEKibb3+Y+OIbLHgZ0J1bNWOIsmggD/usTTQ
	 9/pVVOP7bVoIjkq/TeRxIkBLu2lAZdbNk4T8yNyxzwORngFAYTYlfIXcYmSpBwTBdR
	 T0EbsyJhY7fElLUU6Q+AyVva4pA14EzF8vgRrcLSk7Y0E4o/Wt/lauH5NFIiFjy/MR
	 EQSSsYIiy8GPQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 17 Oct 2023 19:57:04 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 19:57:04 +0300
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
Subject: [PATCH v4 1/8] clk: zynq: Move soc_clk_dump to Zynq clock driver
Date: Tue, 17 Oct 2023 19:56:42 +0300
Message-ID: <20231017165649.1492-2-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017165649.1492-1-ivprusov@sberdevices.ru>
References: <20231017165649.1492-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180684 [Oct 17 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 540 540 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/17 15:08:00 #22212325
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Oct 2023 16:57:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1766

Move clock dump function in preparation for switching to dump function
in clk_ops.

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
Acked-by: Michal Simek <michal.simek@amd.com>
---
 arch/arm/mach-zynq/clk.c | 57 ---------------------------------------
 drivers/clk/clk_zynq.c   | 58 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-zynq/clk.c b/arch/arm/mach-zynq/clk.c
index 1945f60e08..e6a67326dd 100644
--- a/arch/arm/mach-zynq/clk.c
+++ b/arch/arm/mach-zynq/clk.c
@@ -13,20 +13,6 @@
=20
 DECLARE_GLOBAL_DATA_PTR;
=20
-static const char * const clk_names[clk_max] =3D {
-	"armpll", "ddrpll", "iopll",
-	"cpu_6or4x", "cpu_3or2x", "cpu_2x", "cpu_1x",
-	"ddr2x", "ddr3x", "dci",
-	"lqspi", "smc", "pcap", "gem0", "gem1",
-	"fclk0", "fclk1", "fclk2", "fclk3", "can0", "can1",
-	"sdio0", "sdio1", "uart0", "uart1", "spi0", "spi1", "dma",
-	"usb0_aper", "usb1_aper", "gem0_aper", "gem1_aper",
-	"sdio0_aper", "sdio1_aper", "spi0_aper", "spi1_aper",
-	"can0_aper", "can1_aper", "i2c0_aper", "i2c1_aper",
-	"uart0_aper", "uart1_aper", "gpio_aper", "lqspi_aper",
-	"smc_aper", "swdt", "dbg_trc", "dbg_apb"
-};
-
 /**
  * set_cpu_clk_info() - Setup clock information
  *
@@ -65,46 +51,3 @@ int set_cpu_clk_info(void)
=20
 	return 0;
 }
-
-/**
- * soc_clk_dump() - Print clock frequencies
- * Returns zero on success
- *
- * Implementation for the clk dump command.
- */
-int soc_clk_dump(void)
-{
-	struct udevice *dev;
-	int i, ret;
-
-	ret =3D uclass_get_device_by_driver(UCLASS_CLK,
-		DM_DRIVER_GET(zynq_clk), &dev);
-	if (ret)
-		return ret;
-
-	printf("clk\t\tfrequency\n");
-	for (i =3D 0; i < clk_max; i++) {
-		const char *name =3D clk_names[i];
-		if (name) {
-			struct clk clk;
-			unsigned long rate;
-
-			clk.id =3D i;
-			ret =3D clk_request(dev, &clk);
-			if (ret < 0)
-				return ret;
-
-			rate =3D clk_get_rate(&clk);
-
-			clk_free(&clk);
-
-			if ((rate =3D=3D (unsigned long)-ENOSYS) ||
-			    (rate =3D=3D (unsigned long)-ENXIO))
-				printf("%10s%20s\n", name, "unknown");
-			else
-				printf("%10s%20lu\n", name, rate);
-		}
-	}
-
-	return 0;
-}
diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
index e80500e382..be5226175f 100644
--- a/drivers/clk/clk_zynq.c
+++ b/drivers/clk/clk_zynq.c
@@ -454,6 +454,64 @@ static int dummy_enable(struct clk *clk)
 	return 0;
 }
=20
+static const char * const clk_names[clk_max] =3D {
+	"armpll", "ddrpll", "iopll",
+	"cpu_6or4x", "cpu_3or2x", "cpu_2x", "cpu_1x",
+	"ddr2x", "ddr3x", "dci",
+	"lqspi", "smc", "pcap", "gem0", "gem1",
+	"fclk0", "fclk1", "fclk2", "fclk3", "can0", "can1",
+	"sdio0", "sdio1", "uart0", "uart1", "spi0", "spi1", "dma",
+	"usb0_aper", "usb1_aper", "gem0_aper", "gem1_aper",
+	"sdio0_aper", "sdio1_aper", "spi0_aper", "spi1_aper",
+	"can0_aper", "can1_aper", "i2c0_aper", "i2c1_aper",
+	"uart0_aper", "uart1_aper", "gpio_aper", "lqspi_aper",
+	"smc_aper", "swdt", "dbg_trc", "dbg_apb"
+};
+
+/**
+ * soc_clk_dump() - Print clock frequencies
+ * Returns zero on success
+ *
+ * Implementation for the clk dump command.
+ */
+int soc_clk_dump(void)
+{
+	struct udevice *dev;
+	int i, ret;
+
+	ret =3D uclass_get_device_by_driver(UCLASS_CLK,
+					  DM_DRIVER_GET(zynq_clk), &dev);
+	if (ret)
+		return ret;
+
+	printf("clk\t\tfrequency\n");
+	for (i =3D 0; i < clk_max; i++) {
+		const char *name =3D clk_names[i];
+
+		if (name) {
+			struct clk clk;
+			unsigned long rate;
+
+			clk.id =3D i;
+			ret =3D clk_request(dev, &clk);
+			if (ret < 0)
+				return ret;
+
+			rate =3D clk_get_rate(&clk);
+
+			clk_free(&clk);
+
+			if ((rate =3D=3D (unsigned long)-ENOSYS) ||
+			    (rate =3D=3D (unsigned long)-ENXIO))
+				printf("%10s%20s\n", name, "unknown");
+			else
+				printf("%10s%20lu\n", name, rate);
+		}
+	}
+
+	return 0;
+}
+
 static struct clk_ops zynq_clk_ops =3D {
 	.get_rate =3D zynq_clk_get_rate,
 #ifndef CONFIG_SPL_BUILD
--=20
2.34.1


