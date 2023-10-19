Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D50BCDB465
	for <webhook@archiver.kernel.org>; Thu, 19 Oct 2023 15:33:21 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.31203.1697729596944464705
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Oct 2023 08:33:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=M2pnjYrs;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C4ECC120010;
	Thu, 19 Oct 2023 18:33:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C4ECC120010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1697729593;
	bh=xhpcWMVoQIjUFERqRTxlan7nKOvuL8Bk+v1KRD0TAwg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=M2pnjYrsAGETWQ9P7kjodwO2qvWidhDhiljrgah5xH6v26KaauQ3nyTt2JS/DrTQz
	 bitDrNU+JeyFvZKhTRxbJ7QJBwkABkOEvv4GOnViQhxorTpXqWlAwVYVUqegnbeYQY
	 11yFBoHrAcIWDrt8sLWTx31SjbwDCzFioidQQYVQwEmKlSVoiYXYGZPRSEllgYh7LO
	 4gUKRTonzqMMUB6T+kRh0EGQfkDrNSEjUM+P5BzfXuQYI9wKVk30WUOxHYp4QiZR0z
	 q7e60SBi7z8v8HWRLqGBCS2jc7aHjn05LJKyIsHcMjbFSt8MoUySRbEJr4XAzVk6D5
	 7Cb7wxrd0VfhA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 19 Oct 2023 18:33:12 +0300 (MSK)
Received: from pc (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 19 Oct
 2023 18:33:07 +0300
Date: Thu, 19 Oct 2023 18:33:06 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Simon Glass <sjg@google.com>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Jagan Teki
	<jagan@amarulasolutions.com>, <prusovigor@gmail.com>,
	<kernel@sberdevices.ru>, Igor Prusov <IVPrusov@sberdevices.ru>, Martin
 Kurbanov <mmkurbanov@sberdevices.ru>, <u-boot-amlogic@groups.io>,
	<u-boot@lists.denx.de>
Subject: Re: [RESEND PATCH v1 1/2] spi: add support for Amlogic A1 SPI Flash
 Controller
Message-ID: <20231019153306.oks4grlgcv45kiuo@pc>
References: <20231017171733.3989-1-ivprusov@salutedevices.com>
 <20231017171733.3989-2-ivprusov@salutedevices.com>
 <CAPnjgZ06Le0qRukSRsCZ5CoKur6ciaCGGUnRpbfz7OQYzZaGBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ06Le0qRukSRsCZ5CoKur6ciaCGGUnRpbfz7OQYzZaGBA@mail.gmail.com>
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180741 [Oct 19 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 542 542 3d23828e213bab96daa5e52f9cef518f74e40214, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/19 09:42:00 #22231459
X-KSMG-AntiVirus-Status: Clean, skipped
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 19 Oct 2023 15:33:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1785

On Tue, Oct 17, 2023 at 09:33:02PM -0600, Simon Glass wrote:
> Hi Igor,
> 
> On Tue, 17 Oct 2023 at 11:18, Igor Prusov <ivprusov@salutedevices.com> wrote:
> >
> > From: Igor Prusov <IVPrusov@sberdevices.ru>
> >
> > Add A1 SPIFC driver from Linux. Slightly modified to use u-boot driver
> > framework and accommodate to lack of ioread32_rep/iowrite32_rep.
> 
> Well, you could bring them in!
> 
> >
> > Based on Linux version 6.6-rc4
> >
> > Signed-off-by: Igor Prusov <IVPrusov@sberdevices.ru>
> > Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> > ---
> >  drivers/spi/Kconfig          |   8 +
> >  drivers/spi/Makefile         |   1 +
> >  drivers/spi/meson_spifc_a1.c | 384 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 393 insertions(+)
> >  create mode 100644 drivers/spi/meson_spifc_a1.c
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> nits below
> 
> >
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index 854b8b88da..dedb366370 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -251,6 +251,14 @@ config MICROCHIP_COREQSPI
> >           Enable the QSPI driver for Microchip FPGA QSPI controllers.
> >           This driver can be used on Polarfire SoC.
> >
> > +config MESON_SPIFC_A1
> > +       bool "Amlogic Meson A1 SPI Flash Controller driver"
> > +       depends on ARCH_MESON
> > +       help
> > +         Enable the Amlogic A1 SPI Flash Controller (SPIFC) driver.
> > +         This driver can be used to access the SPI NOR/NAND flash chips on
> > +         Amlogic A1 SoC.
> 
> What speeds does and modes it support? Can you add a little more detail?
> 
Sure, will add in v2.
> > +
> >  config MPC8XX_SPI
> >         bool "MPC8XX SPI Driver"
> >         depends on MPC8xx
> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> > index c27b3327c3..14bdb97f18 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > @@ -41,6 +41,7 @@ obj-$(CONFIG_ICH_SPI) +=  ich.o
> >  obj-$(CONFIG_IPROC_QSPI) += iproc_qspi.o
> >  obj-$(CONFIG_KIRKWOOD_SPI) += kirkwood_spi.o
> >  obj-$(CONFIG_MESON_SPIFC) += meson_spifc.o
> > +obj-$(CONFIG_MESON_SPIFC_A1) += meson_spifc_a1.o
> >  obj-$(CONFIG_MICROCHIP_COREQSPI) += microchip_coreqspi.o
> >  obj-$(CONFIG_MPC8XX_SPI) += mpc8xx_spi.o
> >  obj-$(CONFIG_MPC8XXX_SPI) += mpc8xxx_spi.o
> > diff --git a/drivers/spi/meson_spifc_a1.c b/drivers/spi/meson_spifc_a1.c
> > new file mode 100644
> > index 0000000000..4b840c4634
> > --- /dev/null
> > +++ b/drivers/spi/meson_spifc_a1.c
> > @@ -0,0 +1,384 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Amlogic A1 SPI flash controller (SPIFC)
> > + *
> > + * Copyright (c) 2023, SberDevices. All Rights Reserved.
> > + *
> > + * Author: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> > + *
> > + * Ported to u-boot:
> > + * Author: Igor Prusov <ivprusov@sberdevices.ru>
> > + */
> > +
> > +#include <common.h>
> > +#include <clk.h>
> > +#include <dm.h>
> > +#include <spi.h>
> > +#include <spi-mem.h>
> > +#include <asm/io.h>
> > +#include <linux/log2.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/bitfield.h>
> > +
> > +#define SPIFC_A1_AHB_CTRL_REG          0x0
> > +#define SPIFC_A1_AHB_BUS_EN            BIT(31)
> > +
> > +#define SPIFC_A1_USER_CTRL0_REG                0x200
> > +#define SPIFC_A1_USER_REQUEST_ENABLE   BIT(31)
> > +#define SPIFC_A1_USER_REQUEST_FINISH   BIT(30)
> > +#define SPIFC_A1_USER_DATA_UPDATED     BIT(0)
> > +
> > +#define SPIFC_A1_USER_CTRL1_REG                0x204
> > +#define SPIFC_A1_USER_CMD_ENABLE       BIT(30)
> > +#define SPIFC_A1_USER_CMD_MODE         GENMASK(29, 28)
> > +#define SPIFC_A1_USER_CMD_CODE         GENMASK(27, 20)
> > +#define SPIFC_A1_USER_ADDR_ENABLE      BIT(19)
> > +#define SPIFC_A1_USER_ADDR_MODE                GENMASK(18, 17)
> > +#define SPIFC_A1_USER_ADDR_BYTES       GENMASK(16, 15)
> > +#define SPIFC_A1_USER_DOUT_ENABLE      BIT(14)
> > +#define SPIFC_A1_USER_DOUT_MODE                GENMASK(11, 10)
> > +#define SPIFC_A1_USER_DOUT_BYTES       GENMASK(9, 0)
> > +
> > +#define SPIFC_A1_USER_CTRL2_REG                0x208
> > +#define SPIFC_A1_USER_DUMMY_ENABLE     BIT(31)
> > +#define SPIFC_A1_USER_DUMMY_MODE       GENMASK(30, 29)
> > +#define SPIFC_A1_USER_DUMMY_CLK_SYCLES GENMASK(28, 23)
> > +
> > +#define SPIFC_A1_USER_CTRL3_REG                0x20c
> > +#define SPIFC_A1_USER_DIN_ENABLE       BIT(31)
> > +#define SPIFC_A1_USER_DIN_MODE         GENMASK(28, 27)
> > +#define SPIFC_A1_USER_DIN_BYTES                GENMASK(25, 16)
> > +
> > +#define SPIFC_A1_USER_ADDR_REG         0x210
> > +
> > +#define SPIFC_A1_AHB_REQ_CTRL_REG      0x214
> > +#define SPIFC_A1_AHB_REQ_ENABLE                BIT(31)
> > +
> > +#define SPIFC_A1_ACTIMING0_REG         (0x0088 << 2)
> > +#define SPIFC_A1_TSLCH                 GENMASK(31, 30)
> > +#define SPIFC_A1_TCLSH                 GENMASK(29, 28)
> > +#define SPIFC_A1_TSHWL                 GENMASK(20, 16)
> > +#define SPIFC_A1_TSHSL2                        GENMASK(15, 12)
> > +#define SPIFC_A1_TSHSL1                        GENMASK(11, 8)
> > +#define SPIFC_A1_TWHSL                 GENMASK(7, 0)
> > +
> > +#define SPIFC_A1_DBUF_CTRL_REG         0x240
> > +#define SPIFC_A1_DBUF_DIR              BIT(31)
> > +#define SPIFC_A1_DBUF_AUTO_UPDATE_ADDR BIT(30)
> > +#define SPIFC_A1_DBUF_ADDR             GENMASK(7, 0)
> > +
> > +#define SPIFC_A1_DBUF_DATA_REG         0x244
> > +
> > +#define SPIFC_A1_USER_DBUF_ADDR_REG    0x248
> > +
> > +#define SPIFC_A1_BUFFER_SIZE           512U
> > +
> > +#define SPIFC_A1_MAX_HZ                        200000000
> > +#define SPIFC_A1_MIN_HZ                        1000000
> > +
> > +#define SPIFC_A1_USER_CMD(op) ( \
> > +       SPIFC_A1_USER_CMD_ENABLE | \
> > +       FIELD_PREP(SPIFC_A1_USER_CMD_CODE, (op)->cmd.opcode) | \
> > +       FIELD_PREP(SPIFC_A1_USER_CMD_MODE, ilog2((op)->cmd.buswidth)))
> > +
> > +#define SPIFC_A1_USER_ADDR(op) ( \
> > +       SPIFC_A1_USER_ADDR_ENABLE | \
> > +       FIELD_PREP(SPIFC_A1_USER_ADDR_MODE, ilog2((op)->addr.buswidth)) | \
> > +       FIELD_PREP(SPIFC_A1_USER_ADDR_BYTES, (op)->addr.nbytes - 1))
> > +
> > +#define SPIFC_A1_USER_DUMMY(op) ( \
> > +       SPIFC_A1_USER_DUMMY_ENABLE | \
> > +       FIELD_PREP(SPIFC_A1_USER_DUMMY_MODE, ilog2((op)->dummy.buswidth)) | \
> > +       FIELD_PREP(SPIFC_A1_USER_DUMMY_CLK_SYCLES, (op)->dummy.nbytes << 3))
> > +
> > +#define SPIFC_A1_TSLCH_VAL     FIELD_PREP(SPIFC_A1_TSLCH, 1)
> > +#define SPIFC_A1_TCLSH_VAL     FIELD_PREP(SPIFC_A1_TCLSH, 1)
> > +#define SPIFC_A1_TSHWL_VAL     FIELD_PREP(SPIFC_A1_TSHWL, 7)
> > +#define SPIFC_A1_TSHSL2_VAL    FIELD_PREP(SPIFC_A1_TSHSL2, 7)
> > +#define SPIFC_A1_TSHSL1_VAL    FIELD_PREP(SPIFC_A1_TSHSL1, 7)
> > +#define SPIFC_A1_TWHSL_VAL     FIELD_PREP(SPIFC_A1_TWHSL, 2)
> > +#define SPIFC_A1_ACTIMING0_VAL (SPIFC_A1_TSLCH_VAL | SPIFC_A1_TCLSH_VAL | \
> > +                                SPIFC_A1_TSHWL_VAL | SPIFC_A1_TSHSL2_VAL | \
> > +                                SPIFC_A1_TSHSL1_VAL | SPIFC_A1_TWHSL_VAL)
> > +
> > +struct amlogic_spifc_a1 {
> > +       struct spi_controller *ctrl;
> > +       struct clk clk;
> > +       struct device *dev;
> 
> Can you drop that? Normally we pass 'dev' to a function if needed,
> rather than passing 'priv' and looking up dev from there. In fact I am
> not sure this is used?

Yep, it's not used anywhere. It is also only accessed in Linux driver's
probe(), so it can be replaced with a stack variable there as well. Also
I've noticed that ctrl field is not used here as well, so I'm going to
drop it in v2 as well.
> > +       void __iomem *base;
> > +       u32 curr_speed_hz;
> > +};
> > +
> > +static int amlogic_spifc_a1_request(struct amlogic_spifc_a1 *spifc, bool read)
> > +{
> > +       u32 mask = SPIFC_A1_USER_REQUEST_FINISH |
> > +                  (read ? SPIFC_A1_USER_DATA_UPDATED : 0);
> > +       u32 val;
> > +
> > +       writel(SPIFC_A1_USER_REQUEST_ENABLE,
> > +              spifc->base + SPIFC_A1_USER_CTRL0_REG);
> > +
> > +       return readl_poll_timeout(spifc->base + SPIFC_A1_USER_CTRL0_REG,
> > +                                 val, (val & mask) == mask,
> > +                                 200 * 1000);
> > +}
> > +
> > +static void amlogic_spifc_a1_drain_buffer(struct amlogic_spifc_a1 *spifc,
> > +                                         char *buf, u32 len)
> > +{
> > +       u32 data;
> > +       const u32 count = len / sizeof(data);
> > +       const u32 pad = len % sizeof(data);
> > +
> > +       writel(SPIFC_A1_DBUF_AUTO_UPDATE_ADDR,
> > +              spifc->base + SPIFC_A1_DBUF_CTRL_REG);
> > +       readsl(spifc->base + SPIFC_A1_DBUF_DATA_REG, buf, count);
> > +
> > +       if (pad) {
> > +               data = readl(spifc->base + SPIFC_A1_DBUF_DATA_REG);
> > +               memcpy(buf + len - pad, &data, pad);
> > +       }
> > +}
> > +
> > +static void amlogic_spifc_a1_fill_buffer(struct amlogic_spifc_a1 *spifc,
> > +                                        const char *buf, u32 len)
> > +{
> > +       u32 data;
> > +       const u32 count = len / sizeof(data);
> > +       const u32 pad = len % sizeof(data);
> > +
> > +       writel(SPIFC_A1_DBUF_DIR | SPIFC_A1_DBUF_AUTO_UPDATE_ADDR,
> > +              spifc->base + SPIFC_A1_DBUF_CTRL_REG);
> > +       writesl(spifc->base + SPIFC_A1_DBUF_DATA_REG, buf, count);
> > +
> > +       if (pad) {
> > +               memcpy(&data, buf + len - pad, pad);
> > +               writel(data, spifc->base + SPIFC_A1_DBUF_DATA_REG);
> > +       }
> > +}
> > +
> > +static void amlogic_spifc_a1_user_init(struct amlogic_spifc_a1 *spifc)
> > +{
> > +       writel(0, spifc->base + SPIFC_A1_USER_CTRL0_REG);
> > +       writel(0, spifc->base + SPIFC_A1_USER_CTRL1_REG);
> > +       writel(0, spifc->base + SPIFC_A1_USER_CTRL2_REG);
> > +       writel(0, spifc->base + SPIFC_A1_USER_CTRL3_REG);
> > +}
> > +
> > +static void amlogic_spifc_a1_set_cmd(struct amlogic_spifc_a1 *spifc,
> > +                                    u32 cmd_cfg)
> > +{
> > +       u32 val;
> > +
> > +       val = readl(spifc->base + SPIFC_A1_USER_CTRL1_REG);
> > +       val &= ~(SPIFC_A1_USER_CMD_MODE | SPIFC_A1_USER_CMD_CODE);
> > +       val |= cmd_cfg;
> > +       writel(val, spifc->base + SPIFC_A1_USER_CTRL1_REG);
> 
> You probably want to keep the code the same as Linux, but I'll just
> mention clrsetbits_le32() is case it is useful elsewhere.
> 
Thanks, will keep in mind!
> > +}
> > +
> > +static void amlogic_spifc_a1_set_addr(struct amlogic_spifc_a1 *spifc, u32 addr,
> > +                                     u32 addr_cfg)
> > +{
> > +       u32 val;
> > +
> > +       writel(addr, spifc->base + SPIFC_A1_USER_ADDR_REG);
> > +
> > +       val = readl(spifc->base + SPIFC_A1_USER_CTRL1_REG);
> > +       val &= ~(SPIFC_A1_USER_ADDR_MODE | SPIFC_A1_USER_ADDR_BYTES);
> > +       val |= addr_cfg;
> > +       writel(val, spifc->base + SPIFC_A1_USER_CTRL1_REG);
> > +}
> > +
> > +static void amlogic_spifc_a1_set_dummy(struct amlogic_spifc_a1 *spifc,
> > +                                      u32 dummy_cfg)
> > +{
> > +       u32 val = readl(spifc->base + SPIFC_A1_USER_CTRL2_REG);
> > +
> > +       val &= ~(SPIFC_A1_USER_DUMMY_MODE | SPIFC_A1_USER_DUMMY_CLK_SYCLES);
> > +       val |= dummy_cfg;
> > +       writel(val, spifc->base + SPIFC_A1_USER_CTRL2_REG);
> > +}
> > +
> > +static int amlogic_spifc_a1_read(struct amlogic_spifc_a1 *spifc, void *buf,
> > +                                u32 size, u32 mode)
> > +{
> > +       u32 val = readl(spifc->base + SPIFC_A1_USER_CTRL3_REG);
> > +       int ret;
> > +
> > +       val &= ~(SPIFC_A1_USER_DIN_MODE | SPIFC_A1_USER_DIN_BYTES);
> > +       val |= SPIFC_A1_USER_DIN_ENABLE;
> > +       val |= FIELD_PREP(SPIFC_A1_USER_DIN_MODE, mode);
> > +       val |= FIELD_PREP(SPIFC_A1_USER_DIN_BYTES, size);
> > +       writel(val, spifc->base + SPIFC_A1_USER_CTRL3_REG);
> > +
> > +       ret = amlogic_spifc_a1_request(spifc, true);
> > +       if (!ret)
> > +               amlogic_spifc_a1_drain_buffer(spifc, buf, size);
> > +
> > +       return ret;
> > +}
> > +
> > +static int amlogic_spifc_a1_write(struct amlogic_spifc_a1 *spifc,
> > +                                 const void *buf, u32 size, u32 mode)
> > +{
> > +       u32 val;
> > +
> > +       amlogic_spifc_a1_fill_buffer(spifc, buf, size);
> > +
> > +       val = readl(spifc->base + SPIFC_A1_USER_CTRL1_REG);
> > +       val &= ~(SPIFC_A1_USER_DOUT_MODE | SPIFC_A1_USER_DOUT_BYTES);
> > +       val |= FIELD_PREP(SPIFC_A1_USER_DOUT_MODE, mode);
> > +       val |= FIELD_PREP(SPIFC_A1_USER_DOUT_BYTES, size);
> > +       val |= SPIFC_A1_USER_DOUT_ENABLE;
> > +       writel(val, spifc->base + SPIFC_A1_USER_CTRL1_REG);
> > +
> > +       return amlogic_spifc_a1_request(spifc, false);
> > +}
> > +
> > +static int amlogic_spifc_a1_set_freq(struct amlogic_spifc_a1 *spifc, u32 freq)
> > +{
> > +       int ret;
> > +
> > +       if (freq == spifc->curr_speed_hz)
> > +               return 0;
> > +
> > +       ret = clk_set_rate(&spifc->clk, freq);
> > +       if (ret)
> > +               return ret;
> > +
> > +       spifc->curr_speed_hz = freq;
> > +       return 0;
> > +}
> > +
> > +static int amlogic_spifc_a1_exec_op(struct spi_slave *slave,
> > +                                   const struct spi_mem_op *op)
> > +{
> > +       struct amlogic_spifc_a1 *spifc = dev_get_priv(slave->dev->parent);
> > +       size_t data_size = op->data.nbytes;
> > +       int ret;
> > +
> > +       ret = amlogic_spifc_a1_set_freq(spifc, slave->max_hz);
> > +       if (ret)
> > +               return ret;
> > +
> > +       amlogic_spifc_a1_user_init(spifc);
> > +       amlogic_spifc_a1_set_cmd(spifc, SPIFC_A1_USER_CMD(op));
> > +
> > +       if (op->addr.nbytes)
> > +               amlogic_spifc_a1_set_addr(spifc, op->addr.val,
> > +                                         SPIFC_A1_USER_ADDR(op));
> > +
> > +       if (op->dummy.nbytes)
> > +               amlogic_spifc_a1_set_dummy(spifc, SPIFC_A1_USER_DUMMY(op));
> > +
> > +       if (data_size) {
> > +               u32 mode = ilog2(op->data.buswidth);
> > +
> > +               writel(0, spifc->base + SPIFC_A1_USER_DBUF_ADDR_REG);
> > +
> > +               if (op->data.dir == SPI_MEM_DATA_IN)
> > +                       ret = amlogic_spifc_a1_read(spifc, op->data.buf.in,
> > +                                                   data_size, mode);
> > +               else
> > +                       ret = amlogic_spifc_a1_write(spifc, op->data.buf.out,
> > +                                                    data_size, mode);
> > +       } else {
> > +               ret = amlogic_spifc_a1_request(spifc, false);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int amlogic_spifc_a1_adjust_op_size(struct spi_slave *slave,
> > +                                          struct spi_mem_op *op)
> > +{
> > +       op->data.nbytes = min(op->data.nbytes, SPIFC_A1_BUFFER_SIZE);
> > +       return 0;
> > +}
> > +
> > +static void amlogic_spifc_a1_hw_init(struct amlogic_spifc_a1 *spifc)
> > +{
> > +       u32 regv;
> > +
> > +       regv = readl(spifc->base + SPIFC_A1_AHB_REQ_CTRL_REG);
> > +       regv &= ~(SPIFC_A1_AHB_REQ_ENABLE);
> 
> It is strange seeing these brackets here.
> 
Indeed, though it is copied from Linux, so not sure if I should remove
them here.
> > +       writel(regv, spifc->base + SPIFC_A1_AHB_REQ_CTRL_REG);
> > +
> > +       regv = readl(spifc->base + SPIFC_A1_AHB_CTRL_REG);
> > +       regv &= ~(SPIFC_A1_AHB_BUS_EN);
> > +       writel(regv, spifc->base + SPIFC_A1_AHB_CTRL_REG);
> > +
> > +       writel(SPIFC_A1_ACTIMING0_VAL, spifc->base + SPIFC_A1_ACTIMING0_REG);
> > +
> > +       writel(0, spifc->base + SPIFC_A1_USER_DBUF_ADDR_REG);
> > +}
> > +
> > +static const struct spi_controller_mem_ops amlogic_spifc_a1_mem_ops = {
> > +       .exec_op = amlogic_spifc_a1_exec_op,
> > +       .adjust_op_size = amlogic_spifc_a1_adjust_op_size,
> > +};
> > +
> > +static int amlogic_spifc_a1_probe(struct udevice *dev)
> > +{
> > +       struct amlogic_spifc_a1 *spifc = dev_get_priv(dev);
> > +       int ret;
> > +       struct udevice *bus = dev;
> > +
> > +       spifc->base = (void *)dev_read_addr(dev);
> 
> dev_read_addr_ptr()
> 
> Also please check for NULL and return -EINVAL in that case
> 
Will fix in v2, thanks!
> > +
> > +       ret = clk_get_by_index(bus, 0, &spifc->clk);
> > +       if (ret) {
> > +               pr_err("can't get clk spifc_gate!\n");
> > +               return ret;
> > +       }
> > +
> > +       ret = clk_enable(&spifc->clk);
> > +       if (ret) {
> > +               pr_err("enable clk fail\n");
> > +               return ret;
> > +       }
> > +
> > +       amlogic_spifc_a1_hw_init(spifc);
> > +
> > +       return 0;
> > +}
> > +
> > +static int amlogic_spifc_a1_remove(struct udevice *dev)
> > +{
> > +       struct amlogic_spifc_a1 *spifc = dev_get_priv(dev);
> > +
> > +       clk_free(&spifc->clk);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct udevice_id meson_spifc_ids[] = {
> > +       { .compatible = "amlogic,a1-spifc", },
> > +       { }
> > +};
> > +
> > +int amlogic_spifc_a1_set_speed(struct udevice *bus, uint hz)
> > +{
> > +       return 0;
> > +}
> > +
> > +int amlogic_spifc_a1_set_mode(struct udevice *bus, uint mode)
> > +{
> > +       return 0;
> > +}
> > +
> > +static const struct dm_spi_ops amlogic_spifc_a1_ops = {
> > +       .mem_ops = &amlogic_spifc_a1_mem_ops,
> > +       .set_speed = amlogic_spifc_a1_set_speed,
> > +       .set_mode = amlogic_spifc_a1_set_mode,
> > +};
> > +
> > +U_BOOT_DRIVER(meson_spifc_a1) = {
> > +       .name           = "meson_spifc_a1",
> > +       .id             = UCLASS_SPI,
> > +       .of_match       = meson_spifc_ids,
> > +       .ops            = &amlogic_spifc_a1_ops,
> > +       .probe          = amlogic_spifc_a1_probe,
> > +       .remove         = amlogic_spifc_a1_remove,
> > +       .priv_auto      = sizeof(struct amlogic_spifc_a1),
> > +};
> > --
> > 2.34.1
> >
> 
> Regards,
> Simon

-- 
Best Regards,
Igor Prusov

