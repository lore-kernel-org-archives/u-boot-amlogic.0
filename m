Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD0ECDB474
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 17:18:10 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.225424.1697563078912599436
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Oct 2023 10:18:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=u44inCuK;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7E1A1100005;
	Tue, 17 Oct 2023 20:17:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7E1A1100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1697563074;
	bh=gK6DHxcfJsW44GuqH3WLiFjJ0wxOZ7QpQEWD6Ow/12E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=u44inCuKiDou69DzMyjmYMKZUY5jLo3UytZMy4S7ysRSuMq/3XzN2xMJaIv2ZFr6A
	 3VYEkdYHp59zwYNRxlAPtcK6acFm+0eC8Qzdi4kuIjBhinL6CKW9/52CNhtF4K5mn3
	 A65dNsF+Bv71lxNbAyaBiKA65/7j4ZLRsajXxDZdOlNxRgaOveKGFwubRI/28gsCjF
	 0NZnOkVditN9xqWZ+mqyWEYbSsNkOZAYpfj6Ix/wWwP1FZddx/ys+9CbBFAeaUnQvJ
	 vwxbD11O6rUrPhZ3Tp9RFwAo8DS/a+zih9BBPn2Uqe9YM9M67vjkRV+kd7iwA2PTO3
	 8OYonJ8dR1pQw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 17 Oct 2023 20:17:54 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 20:17:54 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Jagan Teki
	<jagan@amarulasolutions.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
	<IVPrusov@sberdevices.ru>, Martin Kurbanov <mmkurbanov@sberdevices.ru>,
	<u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>
Subject: [RESEND PATCH v1 1/2] spi: add support for Amlogic A1 SPI Flash Controller
Date: Tue, 17 Oct 2023 20:17:32 +0300
Message-ID: <20231017171733.3989-2-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017171733.3989-1-ivprusov@salutedevices.com>
References: <20231017171733.3989-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180685 [Oct 17 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 540 540 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/17 16:23:00 #22212691
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Oct 2023 17:18:10 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1772

From: Igor Prusov <IVPrusov@sberdevices.ru>

Add A1 SPIFC driver from Linux. Slightly modified to use u-boot driver
framework and accommodate to lack of ioread32_rep/iowrite32_rep.

Based on Linux version 6.6-rc4

Signed-off-by: Igor Prusov <IVPrusov@sberdevices.ru>
Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 drivers/spi/Kconfig          |   8 +
 drivers/spi/Makefile         |   1 +
 drivers/spi/meson_spifc_a1.c | 384 +++++++++++++++++++++++++++++++++++
 3 files changed, 393 insertions(+)
 create mode 100644 drivers/spi/meson_spifc_a1.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 854b8b88da..dedb366370 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -251,6 +251,14 @@ config MICROCHIP_COREQSPI
 	  Enable the QSPI driver for Microchip FPGA QSPI controllers.
 	  This driver can be used on Polarfire SoC.
=20
+config MESON_SPIFC_A1
+	bool "Amlogic Meson A1 SPI Flash Controller driver"
+	depends on ARCH_MESON
+	help
+	  Enable the Amlogic A1 SPI Flash Controller (SPIFC) driver.
+	  This driver can be used to access the SPI NOR/NAND flash chips on
+	  Amlogic A1 SoC.
+
 config MPC8XX_SPI
 	bool "MPC8XX SPI Driver"
 	depends on MPC8xx
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index c27b3327c3..14bdb97f18 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_ICH_SPI) +=3D  ich.o
 obj-$(CONFIG_IPROC_QSPI) +=3D iproc_qspi.o
 obj-$(CONFIG_KIRKWOOD_SPI) +=3D kirkwood_spi.o
 obj-$(CONFIG_MESON_SPIFC) +=3D meson_spifc.o
+obj-$(CONFIG_MESON_SPIFC_A1) +=3D meson_spifc_a1.o
 obj-$(CONFIG_MICROCHIP_COREQSPI) +=3D microchip_coreqspi.o
 obj-$(CONFIG_MPC8XX_SPI) +=3D mpc8xx_spi.o
 obj-$(CONFIG_MPC8XXX_SPI) +=3D mpc8xxx_spi.o
diff --git a/drivers/spi/meson_spifc_a1.c b/drivers/spi/meson_spifc_a1.c
new file mode 100644
index 0000000000..4b840c4634
--- /dev/null
+++ b/drivers/spi/meson_spifc_a1.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Amlogic A1 SPI flash controller (SPIFC)
+ *
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ *
+ * Author: Martin Kurbanov <mmkurbanov@sberdevices.ru>
+ *
+ * Ported to u-boot:
+ * Author: Igor Prusov <ivprusov@sberdevices.ru>
+ */
+
+#include <common.h>
+#include <clk.h>
+#include <dm.h>
+#include <spi.h>
+#include <spi-mem.h>
+#include <asm/io.h>
+#include <linux/log2.h>
+#include <linux/iopoll.h>
+#include <linux/bitfield.h>
+
+#define SPIFC_A1_AHB_CTRL_REG		0x0
+#define SPIFC_A1_AHB_BUS_EN		BIT(31)
+
+#define SPIFC_A1_USER_CTRL0_REG		0x200
+#define SPIFC_A1_USER_REQUEST_ENABLE	BIT(31)
+#define SPIFC_A1_USER_REQUEST_FINISH	BIT(30)
+#define SPIFC_A1_USER_DATA_UPDATED	BIT(0)
+
+#define SPIFC_A1_USER_CTRL1_REG		0x204
+#define SPIFC_A1_USER_CMD_ENABLE	BIT(30)
+#define SPIFC_A1_USER_CMD_MODE		GENMASK(29, 28)
+#define SPIFC_A1_USER_CMD_CODE		GENMASK(27, 20)
+#define SPIFC_A1_USER_ADDR_ENABLE	BIT(19)
+#define SPIFC_A1_USER_ADDR_MODE		GENMASK(18, 17)
+#define SPIFC_A1_USER_ADDR_BYTES	GENMASK(16, 15)
+#define SPIFC_A1_USER_DOUT_ENABLE	BIT(14)
+#define SPIFC_A1_USER_DOUT_MODE		GENMASK(11, 10)
+#define SPIFC_A1_USER_DOUT_BYTES	GENMASK(9, 0)
+
+#define SPIFC_A1_USER_CTRL2_REG		0x208
+#define SPIFC_A1_USER_DUMMY_ENABLE	BIT(31)
+#define SPIFC_A1_USER_DUMMY_MODE	GENMASK(30, 29)
+#define SPIFC_A1_USER_DUMMY_CLK_SYCLES	GENMASK(28, 23)
+
+#define SPIFC_A1_USER_CTRL3_REG		0x20c
+#define SPIFC_A1_USER_DIN_ENABLE	BIT(31)
+#define SPIFC_A1_USER_DIN_MODE		GENMASK(28, 27)
+#define SPIFC_A1_USER_DIN_BYTES		GENMASK(25, 16)
+
+#define SPIFC_A1_USER_ADDR_REG		0x210
+
+#define SPIFC_A1_AHB_REQ_CTRL_REG	0x214
+#define SPIFC_A1_AHB_REQ_ENABLE		BIT(31)
+
+#define SPIFC_A1_ACTIMING0_REG		(0x0088 << 2)
+#define SPIFC_A1_TSLCH			GENMASK(31, 30)
+#define SPIFC_A1_TCLSH			GENMASK(29, 28)
+#define SPIFC_A1_TSHWL			GENMASK(20, 16)
+#define SPIFC_A1_TSHSL2			GENMASK(15, 12)
+#define SPIFC_A1_TSHSL1			GENMASK(11, 8)
+#define SPIFC_A1_TWHSL			GENMASK(7, 0)
+
+#define SPIFC_A1_DBUF_CTRL_REG		0x240
+#define SPIFC_A1_DBUF_DIR		BIT(31)
+#define SPIFC_A1_DBUF_AUTO_UPDATE_ADDR	BIT(30)
+#define SPIFC_A1_DBUF_ADDR		GENMASK(7, 0)
+
+#define SPIFC_A1_DBUF_DATA_REG		0x244
+
+#define SPIFC_A1_USER_DBUF_ADDR_REG	0x248
+
+#define SPIFC_A1_BUFFER_SIZE		512U
+
+#define SPIFC_A1_MAX_HZ			200000000
+#define SPIFC_A1_MIN_HZ			1000000
+
+#define SPIFC_A1_USER_CMD(op) ( \
+	SPIFC_A1_USER_CMD_ENABLE | \
+	FIELD_PREP(SPIFC_A1_USER_CMD_CODE, (op)->cmd.opcode) | \
+	FIELD_PREP(SPIFC_A1_USER_CMD_MODE, ilog2((op)->cmd.buswidth)))
+
+#define SPIFC_A1_USER_ADDR(op) ( \
+	SPIFC_A1_USER_ADDR_ENABLE | \
+	FIELD_PREP(SPIFC_A1_USER_ADDR_MODE, ilog2((op)->addr.buswidth)) | \
+	FIELD_PREP(SPIFC_A1_USER_ADDR_BYTES, (op)->addr.nbytes - 1))
+
+#define SPIFC_A1_USER_DUMMY(op) ( \
+	SPIFC_A1_USER_DUMMY_ENABLE | \
+	FIELD_PREP(SPIFC_A1_USER_DUMMY_MODE, ilog2((op)->dummy.buswidth)) | \
+	FIELD_PREP(SPIFC_A1_USER_DUMMY_CLK_SYCLES, (op)->dummy.nbytes << 3))
+
+#define SPIFC_A1_TSLCH_VAL	FIELD_PREP(SPIFC_A1_TSLCH, 1)
+#define SPIFC_A1_TCLSH_VAL	FIELD_PREP(SPIFC_A1_TCLSH, 1)
+#define SPIFC_A1_TSHWL_VAL	FIELD_PREP(SPIFC_A1_TSHWL, 7)
+#define SPIFC_A1_TSHSL2_VAL	FIELD_PREP(SPIFC_A1_TSHSL2, 7)
+#define SPIFC_A1_TSHSL1_VAL	FIELD_PREP(SPIFC_A1_TSHSL1, 7)
+#define SPIFC_A1_TWHSL_VAL	FIELD_PREP(SPIFC_A1_TWHSL, 2)
+#define SPIFC_A1_ACTIMING0_VAL	(SPIFC_A1_TSLCH_VAL | SPIFC_A1_TCLSH_VAL =
| \
+				 SPIFC_A1_TSHWL_VAL | SPIFC_A1_TSHSL2_VAL | \
+				 SPIFC_A1_TSHSL1_VAL | SPIFC_A1_TWHSL_VAL)
+
+struct amlogic_spifc_a1 {
+	struct spi_controller *ctrl;
+	struct clk clk;
+	struct device *dev;
+	void __iomem *base;
+	u32 curr_speed_hz;
+};
+
+static int amlogic_spifc_a1_request(struct amlogic_spifc_a1 *spifc, bool=
 read)
+{
+	u32 mask =3D SPIFC_A1_USER_REQUEST_FINISH |
+		   (read ? SPIFC_A1_USER_DATA_UPDATED : 0);
+	u32 val;
+
+	writel(SPIFC_A1_USER_REQUEST_ENABLE,
+	       spifc->base + SPIFC_A1_USER_CTRL0_REG);
+
+	return readl_poll_timeout(spifc->base + SPIFC_A1_USER_CTRL0_REG,
+				  val, (val & mask) =3D=3D mask,
+				  200 * 1000);
+}
+
+static void amlogic_spifc_a1_drain_buffer(struct amlogic_spifc_a1 *spifc=
,
+					  char *buf, u32 len)
+{
+	u32 data;
+	const u32 count =3D len / sizeof(data);
+	const u32 pad =3D len % sizeof(data);
+
+	writel(SPIFC_A1_DBUF_AUTO_UPDATE_ADDR,
+	       spifc->base + SPIFC_A1_DBUF_CTRL_REG);
+	readsl(spifc->base + SPIFC_A1_DBUF_DATA_REG, buf, count);
+
+	if (pad) {
+		data =3D readl(spifc->base + SPIFC_A1_DBUF_DATA_REG);
+		memcpy(buf + len - pad, &data, pad);
+	}
+}
+
+static void amlogic_spifc_a1_fill_buffer(struct amlogic_spifc_a1 *spifc,
+					 const char *buf, u32 len)
+{
+	u32 data;
+	const u32 count =3D len / sizeof(data);
+	const u32 pad =3D len % sizeof(data);
+
+	writel(SPIFC_A1_DBUF_DIR | SPIFC_A1_DBUF_AUTO_UPDATE_ADDR,
+	       spifc->base + SPIFC_A1_DBUF_CTRL_REG);
+	writesl(spifc->base + SPIFC_A1_DBUF_DATA_REG, buf, count);
+
+	if (pad) {
+		memcpy(&data, buf + len - pad, pad);
+		writel(data, spifc->base + SPIFC_A1_DBUF_DATA_REG);
+	}
+}
+
+static void amlogic_spifc_a1_user_init(struct amlogic_spifc_a1 *spifc)
+{
+	writel(0, spifc->base + SPIFC_A1_USER_CTRL0_REG);
+	writel(0, spifc->base + SPIFC_A1_USER_CTRL1_REG);
+	writel(0, spifc->base + SPIFC_A1_USER_CTRL2_REG);
+	writel(0, spifc->base + SPIFC_A1_USER_CTRL3_REG);
+}
+
+static void amlogic_spifc_a1_set_cmd(struct amlogic_spifc_a1 *spifc,
+				     u32 cmd_cfg)
+{
+	u32 val;
+
+	val =3D readl(spifc->base + SPIFC_A1_USER_CTRL1_REG);
+	val &=3D ~(SPIFC_A1_USER_CMD_MODE | SPIFC_A1_USER_CMD_CODE);
+	val |=3D cmd_cfg;
+	writel(val, spifc->base + SPIFC_A1_USER_CTRL1_REG);
+}
+
+static void amlogic_spifc_a1_set_addr(struct amlogic_spifc_a1 *spifc, u3=
2 addr,
+				      u32 addr_cfg)
+{
+	u32 val;
+
+	writel(addr, spifc->base + SPIFC_A1_USER_ADDR_REG);
+
+	val =3D readl(spifc->base + SPIFC_A1_USER_CTRL1_REG);
+	val &=3D ~(SPIFC_A1_USER_ADDR_MODE | SPIFC_A1_USER_ADDR_BYTES);
+	val |=3D addr_cfg;
+	writel(val, spifc->base + SPIFC_A1_USER_CTRL1_REG);
+}
+
+static void amlogic_spifc_a1_set_dummy(struct amlogic_spifc_a1 *spifc,
+				       u32 dummy_cfg)
+{
+	u32 val =3D readl(spifc->base + SPIFC_A1_USER_CTRL2_REG);
+
+	val &=3D ~(SPIFC_A1_USER_DUMMY_MODE | SPIFC_A1_USER_DUMMY_CLK_SYCLES);
+	val |=3D dummy_cfg;
+	writel(val, spifc->base + SPIFC_A1_USER_CTRL2_REG);
+}
+
+static int amlogic_spifc_a1_read(struct amlogic_spifc_a1 *spifc, void *b=
uf,
+				 u32 size, u32 mode)
+{
+	u32 val =3D readl(spifc->base + SPIFC_A1_USER_CTRL3_REG);
+	int ret;
+
+	val &=3D ~(SPIFC_A1_USER_DIN_MODE | SPIFC_A1_USER_DIN_BYTES);
+	val |=3D SPIFC_A1_USER_DIN_ENABLE;
+	val |=3D FIELD_PREP(SPIFC_A1_USER_DIN_MODE, mode);
+	val |=3D FIELD_PREP(SPIFC_A1_USER_DIN_BYTES, size);
+	writel(val, spifc->base + SPIFC_A1_USER_CTRL3_REG);
+
+	ret =3D amlogic_spifc_a1_request(spifc, true);
+	if (!ret)
+		amlogic_spifc_a1_drain_buffer(spifc, buf, size);
+
+	return ret;
+}
+
+static int amlogic_spifc_a1_write(struct amlogic_spifc_a1 *spifc,
+				  const void *buf, u32 size, u32 mode)
+{
+	u32 val;
+
+	amlogic_spifc_a1_fill_buffer(spifc, buf, size);
+
+	val =3D readl(spifc->base + SPIFC_A1_USER_CTRL1_REG);
+	val &=3D ~(SPIFC_A1_USER_DOUT_MODE | SPIFC_A1_USER_DOUT_BYTES);
+	val |=3D FIELD_PREP(SPIFC_A1_USER_DOUT_MODE, mode);
+	val |=3D FIELD_PREP(SPIFC_A1_USER_DOUT_BYTES, size);
+	val |=3D SPIFC_A1_USER_DOUT_ENABLE;
+	writel(val, spifc->base + SPIFC_A1_USER_CTRL1_REG);
+
+	return amlogic_spifc_a1_request(spifc, false);
+}
+
+static int amlogic_spifc_a1_set_freq(struct amlogic_spifc_a1 *spifc, u32=
 freq)
+{
+	int ret;
+
+	if (freq =3D=3D spifc->curr_speed_hz)
+		return 0;
+
+	ret =3D clk_set_rate(&spifc->clk, freq);
+	if (ret)
+		return ret;
+
+	spifc->curr_speed_hz =3D freq;
+	return 0;
+}
+
+static int amlogic_spifc_a1_exec_op(struct spi_slave *slave,
+				    const struct spi_mem_op *op)
+{
+	struct amlogic_spifc_a1 *spifc =3D dev_get_priv(slave->dev->parent);
+	size_t data_size =3D op->data.nbytes;
+	int ret;
+
+	ret =3D amlogic_spifc_a1_set_freq(spifc, slave->max_hz);
+	if (ret)
+		return ret;
+
+	amlogic_spifc_a1_user_init(spifc);
+	amlogic_spifc_a1_set_cmd(spifc, SPIFC_A1_USER_CMD(op));
+
+	if (op->addr.nbytes)
+		amlogic_spifc_a1_set_addr(spifc, op->addr.val,
+					  SPIFC_A1_USER_ADDR(op));
+
+	if (op->dummy.nbytes)
+		amlogic_spifc_a1_set_dummy(spifc, SPIFC_A1_USER_DUMMY(op));
+
+	if (data_size) {
+		u32 mode =3D ilog2(op->data.buswidth);
+
+		writel(0, spifc->base + SPIFC_A1_USER_DBUF_ADDR_REG);
+
+		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
+			ret =3D amlogic_spifc_a1_read(spifc, op->data.buf.in,
+						    data_size, mode);
+		else
+			ret =3D amlogic_spifc_a1_write(spifc, op->data.buf.out,
+						     data_size, mode);
+	} else {
+		ret =3D amlogic_spifc_a1_request(spifc, false);
+	}
+
+	return ret;
+}
+
+static int amlogic_spifc_a1_adjust_op_size(struct spi_slave *slave,
+					   struct spi_mem_op *op)
+{
+	op->data.nbytes =3D min(op->data.nbytes, SPIFC_A1_BUFFER_SIZE);
+	return 0;
+}
+
+static void amlogic_spifc_a1_hw_init(struct amlogic_spifc_a1 *spifc)
+{
+	u32 regv;
+
+	regv =3D readl(spifc->base + SPIFC_A1_AHB_REQ_CTRL_REG);
+	regv &=3D ~(SPIFC_A1_AHB_REQ_ENABLE);
+	writel(regv, spifc->base + SPIFC_A1_AHB_REQ_CTRL_REG);
+
+	regv =3D readl(spifc->base + SPIFC_A1_AHB_CTRL_REG);
+	regv &=3D ~(SPIFC_A1_AHB_BUS_EN);
+	writel(regv, spifc->base + SPIFC_A1_AHB_CTRL_REG);
+
+	writel(SPIFC_A1_ACTIMING0_VAL, spifc->base + SPIFC_A1_ACTIMING0_REG);
+
+	writel(0, spifc->base + SPIFC_A1_USER_DBUF_ADDR_REG);
+}
+
+static const struct spi_controller_mem_ops amlogic_spifc_a1_mem_ops =3D =
{
+	.exec_op =3D amlogic_spifc_a1_exec_op,
+	.adjust_op_size =3D amlogic_spifc_a1_adjust_op_size,
+};
+
+static int amlogic_spifc_a1_probe(struct udevice *dev)
+{
+	struct amlogic_spifc_a1 *spifc =3D dev_get_priv(dev);
+	int ret;
+	struct udevice *bus =3D dev;
+
+	spifc->base =3D (void *)dev_read_addr(dev);
+
+	ret =3D clk_get_by_index(bus, 0, &spifc->clk);
+	if (ret) {
+		pr_err("can't get clk spifc_gate!\n");
+		return ret;
+	}
+
+	ret =3D clk_enable(&spifc->clk);
+	if (ret) {
+		pr_err("enable clk fail\n");
+		return ret;
+	}
+
+	amlogic_spifc_a1_hw_init(spifc);
+
+	return 0;
+}
+
+static int amlogic_spifc_a1_remove(struct udevice *dev)
+{
+	struct amlogic_spifc_a1 *spifc =3D dev_get_priv(dev);
+
+	clk_free(&spifc->clk);
+
+	return 0;
+}
+
+static const struct udevice_id meson_spifc_ids[] =3D {
+	{ .compatible =3D "amlogic,a1-spifc", },
+	{ }
+};
+
+int amlogic_spifc_a1_set_speed(struct udevice *bus, uint hz)
+{
+	return 0;
+}
+
+int amlogic_spifc_a1_set_mode(struct udevice *bus, uint mode)
+{
+	return 0;
+}
+
+static const struct dm_spi_ops amlogic_spifc_a1_ops =3D {
+	.mem_ops =3D &amlogic_spifc_a1_mem_ops,
+	.set_speed =3D amlogic_spifc_a1_set_speed,
+	.set_mode =3D amlogic_spifc_a1_set_mode,
+};
+
+U_BOOT_DRIVER(meson_spifc_a1) =3D {
+	.name		=3D "meson_spifc_a1",
+	.id		=3D UCLASS_SPI,
+	.of_match	=3D meson_spifc_ids,
+	.ops		=3D &amlogic_spifc_a1_ops,
+	.probe		=3D amlogic_spifc_a1_probe,
+	.remove		=3D amlogic_spifc_a1_remove,
+	.priv_auto	=3D sizeof(struct amlogic_spifc_a1),
+};
--=20
2.34.1


