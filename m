Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF42ECDB47E
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 07:02:54 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web10.274481.1697600002958068530
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Oct 2023 20:33:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@google.com header.s=20230601 header.b=0n38MQ0S;
 spf=pass (domain: google.com, ip: 209.85.208.169, mailfrom: sjg@google.com)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so76418741fa.1
        for <u-boot-amlogic@groups.io>; Tue, 17 Oct 2023 20:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697600001; x=1698204801; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WEsm9t6WTBjXduh+20srMzjt1fNuB/ZVODEGNftFsWg=;
        b=0n38MQ0SZWn0qRcON3d82/oZzXlXWmvsJxIlbBVN3PJ474DkCk87naPtlCII8lzP6X
         sRygcA4I7SUbRGcnrfRWMFQKnxXvdZ9917qzMCHoNTkLGbJo6L1SzbZXxhYIEl84PW1l
         3YWyJl+RjIl5WAFiDHbamE2f2jMSTFXn8UXYYTuoa7jaNFJuxViYdnTa9xBGZuETwPQs
         jBfJtFi6jUgALMyHTxQu7czu4unWUov/3vM4tgTjeAZgFKq/jMB957PeCDFmHIzxSHpQ
         LvtB2zGydoZPDjqaJvM6Ogt4IpTOgm8lJsVLtF3GIBlmlOzqWmxJRXLiP1kgckywVsZV
         I4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697600001; x=1698204801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEsm9t6WTBjXduh+20srMzjt1fNuB/ZVODEGNftFsWg=;
        b=P57MuNBiaZgomzm68g4XUMbnE6sHXg9Y3bHw1TFRQoGgSxUlhIpLGk55iDO+HrkGop
         2zcFev0CK5L4eMctfNg+Z9Dr94ZvbNTwk8LjhzKckc0gKwSGtPmvTRjaRQrVEaZUomOa
         I0bUlnEM+TvAqapZbkOaPvwfcnyklvHeFRnmwONnJvET6Q//7CHykbkebcYzYKef0XXA
         h0GDXlePGjZ6+AJLftyjESYOtgQyDB0HFDcI98l2fFu2HCifBcyVYTQznRnt3CNhtaRu
         eSGU5dGa4VcHbJe77nej1nBL7/OdndDUzMJm0Gdaiuu3DSVVARkT4HK41Eo/qLC5S/lu
         r/uA==
X-Gm-Message-State: AOJu0YyOEJ+O9sTIU4CFvmwXrEtl26gftka33M+wcUDGc4qZRYnMgzRl
	Ch4KiDsZb94hzDJkxW7Fdm0Gc0+PIWYBYCKu+l3g7A==
X-Google-Smtp-Source: AGHT+IE5oeLpda3TCSceSkfLNmi8eJrE4JJGA9gkOmhTXdu3MzLi1wu+2YcWeQQbMXygWql90Sqh32jYmUtJjCZNm90=
X-Received: by 2002:a05:6512:3b2b:b0:500:7efe:313c with SMTP id
 f43-20020a0565123b2b00b005007efe313cmr3823813lfv.24.1697600000723; Tue, 17
 Oct 2023 20:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231017171733.3989-1-ivprusov@salutedevices.com> <20231017171733.3989-2-ivprusov@salutedevices.com>
In-Reply-To: <20231017171733.3989-2-ivprusov@salutedevices.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 17 Oct 2023 21:33:02 -0600
Message-ID: <CAPnjgZ06Le0qRukSRsCZ5CoKur6ciaCGGUnRpbfz7OQYzZaGBA@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 1/2] spi: add support for Amlogic A1 SPI Flash Controller
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, 
	prusovigor@gmail.com, kernel@sberdevices.ru, 
	Igor Prusov <IVPrusov@sberdevices.ru>, Martin Kurbanov <mmkurbanov@sberdevices.ru>, 
	u-boot-amlogic@groups.io, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 07:02:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1778

Hi Igor,

On Tue, 17 Oct 2023 at 11:18, Igor Prusov <ivprusov@salutedevices.com> wrote:
>
> From: Igor Prusov <IVPrusov@sberdevices.ru>
>
> Add A1 SPIFC driver from Linux. Slightly modified to use u-boot driver
> framework and accommodate to lack of ioread32_rep/iowrite32_rep.

Well, you could bring them in!

>
> Based on Linux version 6.6-rc4
>
> Signed-off-by: Igor Prusov <IVPrusov@sberdevices.ru>
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>  drivers/spi/Kconfig          |   8 +
>  drivers/spi/Makefile         |   1 +
>  drivers/spi/meson_spifc_a1.c | 384 +++++++++++++++++++++++++++++++++++
>  3 files changed, 393 insertions(+)
>  create mode 100644 drivers/spi/meson_spifc_a1.c

Reviewed-by: Simon Glass <sjg@chromium.org>

nits below

>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 854b8b88da..dedb366370 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -251,6 +251,14 @@ config MICROCHIP_COREQSPI
>           Enable the QSPI driver for Microchip FPGA QSPI controllers.
>           This driver can be used on Polarfire SoC.
>
> +config MESON_SPIFC_A1
> +       bool "Amlogic Meson A1 SPI Flash Controller driver"
> +       depends on ARCH_MESON
> +       help
> +         Enable the Amlogic A1 SPI Flash Controller (SPIFC) driver.
> +         This driver can be used to access the SPI NOR/NAND flash chips on
> +         Amlogic A1 SoC.

What speeds does and modes it support? Can you add a little more detail?

> +
>  config MPC8XX_SPI
>         bool "MPC8XX SPI Driver"
>         depends on MPC8xx
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index c27b3327c3..14bdb97f18 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_ICH_SPI) +=  ich.o
>  obj-$(CONFIG_IPROC_QSPI) += iproc_qspi.o
>  obj-$(CONFIG_KIRKWOOD_SPI) += kirkwood_spi.o
>  obj-$(CONFIG_MESON_SPIFC) += meson_spifc.o
> +obj-$(CONFIG_MESON_SPIFC_A1) += meson_spifc_a1.o
>  obj-$(CONFIG_MICROCHIP_COREQSPI) += microchip_coreqspi.o
>  obj-$(CONFIG_MPC8XX_SPI) += mpc8xx_spi.o
>  obj-$(CONFIG_MPC8XXX_SPI) += mpc8xxx_spi.o
> diff --git a/drivers/spi/meson_spifc_a1.c b/drivers/spi/meson_spifc_a1.c
> new file mode 100644
> index 0000000000..4b840c4634
> --- /dev/null
> +++ b/drivers/spi/meson_spifc_a1.c
> @@ -0,0 +1,384 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Amlogic A1 SPI flash controller (SPIFC)
> + *
> + * Copyright (c) 2023, SberDevices. All Rights Reserved.
> + *
> + * Author: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> + *
> + * Ported to u-boot:
> + * Author: Igor Prusov <ivprusov@sberdevices.ru>
> + */
> +
> +#include <common.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <spi.h>
> +#include <spi-mem.h>
> +#include <asm/io.h>
> +#include <linux/log2.h>
> +#include <linux/iopoll.h>
> +#include <linux/bitfield.h>
> +
> +#define SPIFC_A1_AHB_CTRL_REG          0x0
> +#define SPIFC_A1_AHB_BUS_EN            BIT(31)
> +
> +#define SPIFC_A1_USER_CTRL0_REG                0x200
> +#define SPIFC_A1_USER_REQUEST_ENABLE   BIT(31)
> +#define SPIFC_A1_USER_REQUEST_FINISH   BIT(30)
> +#define SPIFC_A1_USER_DATA_UPDATED     BIT(0)
> +
> +#define SPIFC_A1_USER_CTRL1_REG                0x204
> +#define SPIFC_A1_USER_CMD_ENABLE       BIT(30)
> +#define SPIFC_A1_USER_CMD_MODE         GENMASK(29, 28)
> +#define SPIFC_A1_USER_CMD_CODE         GENMASK(27, 20)
> +#define SPIFC_A1_USER_ADDR_ENABLE      BIT(19)
> +#define SPIFC_A1_USER_ADDR_MODE                GENMASK(18, 17)
> +#define SPIFC_A1_USER_ADDR_BYTES       GENMASK(16, 15)
> +#define SPIFC_A1_USER_DOUT_ENABLE      BIT(14)
> +#define SPIFC_A1_USER_DOUT_MODE                GENMASK(11, 10)
> +#define SPIFC_A1_USER_DOUT_BYTES       GENMASK(9, 0)
> +
> +#define SPIFC_A1_USER_CTRL2_REG                0x208
> +#define SPIFC_A1_USER_DUMMY_ENABLE     BIT(31)
> +#define SPIFC_A1_USER_DUMMY_MODE       GENMASK(30, 29)
> +#define SPIFC_A1_USER_DUMMY_CLK_SYCLES GENMASK(28, 23)
> +
> +#define SPIFC_A1_USER_CTRL3_REG                0x20c
> +#define SPIFC_A1_USER_DIN_ENABLE       BIT(31)
> +#define SPIFC_A1_USER_DIN_MODE         GENMASK(28, 27)
> +#define SPIFC_A1_USER_DIN_BYTES                GENMASK(25, 16)
> +
> +#define SPIFC_A1_USER_ADDR_REG         0x210
> +
> +#define SPIFC_A1_AHB_REQ_CTRL_REG      0x214
> +#define SPIFC_A1_AHB_REQ_ENABLE                BIT(31)
> +
> +#define SPIFC_A1_ACTIMING0_REG         (0x0088 << 2)
> +#define SPIFC_A1_TSLCH                 GENMASK(31, 30)
> +#define SPIFC_A1_TCLSH                 GENMASK(29, 28)
> +#define SPIFC_A1_TSHWL                 GENMASK(20, 16)
> +#define SPIFC_A1_TSHSL2                        GENMASK(15, 12)
> +#define SPIFC_A1_TSHSL1                        GENMASK(11, 8)
> +#define SPIFC_A1_TWHSL                 GENMASK(7, 0)
> +
> +#define SPIFC_A1_DBUF_CTRL_REG         0x240
> +#define SPIFC_A1_DBUF_DIR              BIT(31)
> +#define SPIFC_A1_DBUF_AUTO_UPDATE_ADDR BIT(30)
> +#define SPIFC_A1_DBUF_ADDR             GENMASK(7, 0)
> +
> +#define SPIFC_A1_DBUF_DATA_REG         0x244
> +
> +#define SPIFC_A1_USER_DBUF_ADDR_REG    0x248
> +
> +#define SPIFC_A1_BUFFER_SIZE           512U
> +
> +#define SPIFC_A1_MAX_HZ                        200000000
> +#define SPIFC_A1_MIN_HZ                        1000000
> +
> +#define SPIFC_A1_USER_CMD(op) ( \
> +       SPIFC_A1_USER_CMD_ENABLE | \
> +       FIELD_PREP(SPIFC_A1_USER_CMD_CODE, (op)->cmd.opcode) | \
> +       FIELD_PREP(SPIFC_A1_USER_CMD_MODE, ilog2((op)->cmd.buswidth)))
> +
> +#define SPIFC_A1_USER_ADDR(op) ( \
> +       SPIFC_A1_USER_ADDR_ENABLE | \
> +       FIELD_PREP(SPIFC_A1_USER_ADDR_MODE, ilog2((op)->addr.buswidth)) | \
> +       FIELD_PREP(SPIFC_A1_USER_ADDR_BYTES, (op)->addr.nbytes - 1))
> +
> +#define SPIFC_A1_USER_DUMMY(op) ( \
> +       SPIFC_A1_USER_DUMMY_ENABLE | \
> +       FIELD_PREP(SPIFC_A1_USER_DUMMY_MODE, ilog2((op)->dummy.buswidth)) | \
> +       FIELD_PREP(SPIFC_A1_USER_DUMMY_CLK_SYCLES, (op)->dummy.nbytes << 3))
> +
> +#define SPIFC_A1_TSLCH_VAL     FIELD_PREP(SPIFC_A1_TSLCH, 1)
> +#define SPIFC_A1_TCLSH_VAL     FIELD_PREP(SPIFC_A1_TCLSH, 1)
> +#define SPIFC_A1_TSHWL_VAL     FIELD_PREP(SPIFC_A1_TSHWL, 7)
> +#define SPIFC_A1_TSHSL2_VAL    FIELD_PREP(SPIFC_A1_TSHSL2, 7)
> +#define SPIFC_A1_TSHSL1_VAL    FIELD_PREP(SPIFC_A1_TSHSL1, 7)
> +#define SPIFC_A1_TWHSL_VAL     FIELD_PREP(SPIFC_A1_TWHSL, 2)
> +#define SPIFC_A1_ACTIMING0_VAL (SPIFC_A1_TSLCH_VAL | SPIFC_A1_TCLSH_VAL | \
> +                                SPIFC_A1_TSHWL_VAL | SPIFC_A1_TSHSL2_VAL | \
> +                                SPIFC_A1_TSHSL1_VAL | SPIFC_A1_TWHSL_VAL)
> +
> +struct amlogic_spifc_a1 {
> +       struct spi_controller *ctrl;
> +       struct clk clk;
> +       struct device *dev;

Can you drop that? Normally we pass 'dev' to a function if needed,
rather than passing 'priv' and looking up dev from there. In fact I am
not sure this is used?

> +       void __iomem *base;
> +       u32 curr_speed_hz;
> +};
> +
> +static int amlogic_spifc_a1_request(struct amlogic_spifc_a1 *spifc, bool read)
> +{
> +       u32 mask = SPIFC_A1_USER_REQUEST_FINISH |
> +                  (read ? SPIFC_A1_USER_DATA_UPDATED : 0);
> +       u32 val;
> +
> +       writel(SPIFC_A1_USER_REQUEST_ENABLE,
> +              spifc->base + SPIFC_A1_USER_CTRL0_REG);
> +
> +       return readl_poll_timeout(spifc->base + SPIFC_A1_USER_CTRL0_REG,
> +                                 val, (val & mask) == mask,
> +                                 200 * 1000);
> +}
> +
> +static void amlogic_spifc_a1_drain_buffer(struct amlogic_spifc_a1 *spifc,
> +                                         char *buf, u32 len)
> +{
> +       u32 data;
> +       const u32 count = len / sizeof(data);
> +       const u32 pad = len % sizeof(data);
> +
> +       writel(SPIFC_A1_DBUF_AUTO_UPDATE_ADDR,
> +              spifc->base + SPIFC_A1_DBUF_CTRL_REG);
> +       readsl(spifc->base + SPIFC_A1_DBUF_DATA_REG, buf, count);
> +
> +       if (pad) {
> +               data = readl(spifc->base + SPIFC_A1_DBUF_DATA_REG);
> +               memcpy(buf + len - pad, &data, pad);
> +       }
> +}
> +
> +static void amlogic_spifc_a1_fill_buffer(struct amlogic_spifc_a1 *spifc,
> +                                        const char *buf, u32 len)
> +{
> +       u32 data;
> +       const u32 count = len / sizeof(data);
> +       const u32 pad = len % sizeof(data);
> +
> +       writel(SPIFC_A1_DBUF_DIR | SPIFC_A1_DBUF_AUTO_UPDATE_ADDR,
> +              spifc->base + SPIFC_A1_DBUF_CTRL_REG);
> +       writesl(spifc->base + SPIFC_A1_DBUF_DATA_REG, buf, count);
> +
> +       if (pad) {
> +               memcpy(&data, buf + len - pad, pad);
> +               writel(data, spifc->base + SPIFC_A1_DBUF_DATA_REG);
> +       }
> +}
> +
> +static void amlogic_spifc_a1_user_init(struct amlogic_spifc_a1 *spifc)
> +{
> +       writel(0, spifc->base + SPIFC_A1_USER_CTRL0_REG);
> +       writel(0, spifc->base + SPIFC_A1_USER_CTRL1_REG);
> +       writel(0, spifc->base + SPIFC_A1_USER_CTRL2_REG);
> +       writel(0, spifc->base + SPIFC_A1_USER_CTRL3_REG);
> +}
> +
> +static void amlogic_spifc_a1_set_cmd(struct amlogic_spifc_a1 *spifc,
> +                                    u32 cmd_cfg)
> +{
> +       u32 val;
> +
> +       val = readl(spifc->base + SPIFC_A1_USER_CTRL1_REG);
> +       val &= ~(SPIFC_A1_USER_CMD_MODE | SPIFC_A1_USER_CMD_CODE);
> +       val |= cmd_cfg;
> +       writel(val, spifc->base + SPIFC_A1_USER_CTRL1_REG);

You probably want to keep the code the same as Linux, but I'll just
mention clrsetbits_le32() is case it is useful elsewhere.

> +}
> +
> +static void amlogic_spifc_a1_set_addr(struct amlogic_spifc_a1 *spifc, u32 addr,
> +                                     u32 addr_cfg)
> +{
> +       u32 val;
> +
> +       writel(addr, spifc->base + SPIFC_A1_USER_ADDR_REG);
> +
> +       val = readl(spifc->base + SPIFC_A1_USER_CTRL1_REG);
> +       val &= ~(SPIFC_A1_USER_ADDR_MODE | SPIFC_A1_USER_ADDR_BYTES);
> +       val |= addr_cfg;
> +       writel(val, spifc->base + SPIFC_A1_USER_CTRL1_REG);
> +}
> +
> +static void amlogic_spifc_a1_set_dummy(struct amlogic_spifc_a1 *spifc,
> +                                      u32 dummy_cfg)
> +{
> +       u32 val = readl(spifc->base + SPIFC_A1_USER_CTRL2_REG);
> +
> +       val &= ~(SPIFC_A1_USER_DUMMY_MODE | SPIFC_A1_USER_DUMMY_CLK_SYCLES);
> +       val |= dummy_cfg;
> +       writel(val, spifc->base + SPIFC_A1_USER_CTRL2_REG);
> +}
> +
> +static int amlogic_spifc_a1_read(struct amlogic_spifc_a1 *spifc, void *buf,
> +                                u32 size, u32 mode)
> +{
> +       u32 val = readl(spifc->base + SPIFC_A1_USER_CTRL3_REG);
> +       int ret;
> +
> +       val &= ~(SPIFC_A1_USER_DIN_MODE | SPIFC_A1_USER_DIN_BYTES);
> +       val |= SPIFC_A1_USER_DIN_ENABLE;
> +       val |= FIELD_PREP(SPIFC_A1_USER_DIN_MODE, mode);
> +       val |= FIELD_PREP(SPIFC_A1_USER_DIN_BYTES, size);
> +       writel(val, spifc->base + SPIFC_A1_USER_CTRL3_REG);
> +
> +       ret = amlogic_spifc_a1_request(spifc, true);
> +       if (!ret)
> +               amlogic_spifc_a1_drain_buffer(spifc, buf, size);
> +
> +       return ret;
> +}
> +
> +static int amlogic_spifc_a1_write(struct amlogic_spifc_a1 *spifc,
> +                                 const void *buf, u32 size, u32 mode)
> +{
> +       u32 val;
> +
> +       amlogic_spifc_a1_fill_buffer(spifc, buf, size);
> +
> +       val = readl(spifc->base + SPIFC_A1_USER_CTRL1_REG);
> +       val &= ~(SPIFC_A1_USER_DOUT_MODE | SPIFC_A1_USER_DOUT_BYTES);
> +       val |= FIELD_PREP(SPIFC_A1_USER_DOUT_MODE, mode);
> +       val |= FIELD_PREP(SPIFC_A1_USER_DOUT_BYTES, size);
> +       val |= SPIFC_A1_USER_DOUT_ENABLE;
> +       writel(val, spifc->base + SPIFC_A1_USER_CTRL1_REG);
> +
> +       return amlogic_spifc_a1_request(spifc, false);
> +}
> +
> +static int amlogic_spifc_a1_set_freq(struct amlogic_spifc_a1 *spifc, u32 freq)
> +{
> +       int ret;
> +
> +       if (freq == spifc->curr_speed_hz)
> +               return 0;
> +
> +       ret = clk_set_rate(&spifc->clk, freq);
> +       if (ret)
> +               return ret;
> +
> +       spifc->curr_speed_hz = freq;
> +       return 0;
> +}
> +
> +static int amlogic_spifc_a1_exec_op(struct spi_slave *slave,
> +                                   const struct spi_mem_op *op)
> +{
> +       struct amlogic_spifc_a1 *spifc = dev_get_priv(slave->dev->parent);
> +       size_t data_size = op->data.nbytes;
> +       int ret;
> +
> +       ret = amlogic_spifc_a1_set_freq(spifc, slave->max_hz);
> +       if (ret)
> +               return ret;
> +
> +       amlogic_spifc_a1_user_init(spifc);
> +       amlogic_spifc_a1_set_cmd(spifc, SPIFC_A1_USER_CMD(op));
> +
> +       if (op->addr.nbytes)
> +               amlogic_spifc_a1_set_addr(spifc, op->addr.val,
> +                                         SPIFC_A1_USER_ADDR(op));
> +
> +       if (op->dummy.nbytes)
> +               amlogic_spifc_a1_set_dummy(spifc, SPIFC_A1_USER_DUMMY(op));
> +
> +       if (data_size) {
> +               u32 mode = ilog2(op->data.buswidth);
> +
> +               writel(0, spifc->base + SPIFC_A1_USER_DBUF_ADDR_REG);
> +
> +               if (op->data.dir == SPI_MEM_DATA_IN)
> +                       ret = amlogic_spifc_a1_read(spifc, op->data.buf.in,
> +                                                   data_size, mode);
> +               else
> +                       ret = amlogic_spifc_a1_write(spifc, op->data.buf.out,
> +                                                    data_size, mode);
> +       } else {
> +               ret = amlogic_spifc_a1_request(spifc, false);
> +       }
> +
> +       return ret;
> +}
> +
> +static int amlogic_spifc_a1_adjust_op_size(struct spi_slave *slave,
> +                                          struct spi_mem_op *op)
> +{
> +       op->data.nbytes = min(op->data.nbytes, SPIFC_A1_BUFFER_SIZE);
> +       return 0;
> +}
> +
> +static void amlogic_spifc_a1_hw_init(struct amlogic_spifc_a1 *spifc)
> +{
> +       u32 regv;
> +
> +       regv = readl(spifc->base + SPIFC_A1_AHB_REQ_CTRL_REG);
> +       regv &= ~(SPIFC_A1_AHB_REQ_ENABLE);

It is strange seeing these brackets here.

> +       writel(regv, spifc->base + SPIFC_A1_AHB_REQ_CTRL_REG);
> +
> +       regv = readl(spifc->base + SPIFC_A1_AHB_CTRL_REG);
> +       regv &= ~(SPIFC_A1_AHB_BUS_EN);
> +       writel(regv, spifc->base + SPIFC_A1_AHB_CTRL_REG);
> +
> +       writel(SPIFC_A1_ACTIMING0_VAL, spifc->base + SPIFC_A1_ACTIMING0_REG);
> +
> +       writel(0, spifc->base + SPIFC_A1_USER_DBUF_ADDR_REG);
> +}
> +
> +static const struct spi_controller_mem_ops amlogic_spifc_a1_mem_ops = {
> +       .exec_op = amlogic_spifc_a1_exec_op,
> +       .adjust_op_size = amlogic_spifc_a1_adjust_op_size,
> +};
> +
> +static int amlogic_spifc_a1_probe(struct udevice *dev)
> +{
> +       struct amlogic_spifc_a1 *spifc = dev_get_priv(dev);
> +       int ret;
> +       struct udevice *bus = dev;
> +
> +       spifc->base = (void *)dev_read_addr(dev);

dev_read_addr_ptr()

Also please check for NULL and return -EINVAL in that case

> +
> +       ret = clk_get_by_index(bus, 0, &spifc->clk);
> +       if (ret) {
> +               pr_err("can't get clk spifc_gate!\n");
> +               return ret;
> +       }
> +
> +       ret = clk_enable(&spifc->clk);
> +       if (ret) {
> +               pr_err("enable clk fail\n");
> +               return ret;
> +       }
> +
> +       amlogic_spifc_a1_hw_init(spifc);
> +
> +       return 0;
> +}
> +
> +static int amlogic_spifc_a1_remove(struct udevice *dev)
> +{
> +       struct amlogic_spifc_a1 *spifc = dev_get_priv(dev);
> +
> +       clk_free(&spifc->clk);
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id meson_spifc_ids[] = {
> +       { .compatible = "amlogic,a1-spifc", },
> +       { }
> +};
> +
> +int amlogic_spifc_a1_set_speed(struct udevice *bus, uint hz)
> +{
> +       return 0;
> +}
> +
> +int amlogic_spifc_a1_set_mode(struct udevice *bus, uint mode)
> +{
> +       return 0;
> +}
> +
> +static const struct dm_spi_ops amlogic_spifc_a1_ops = {
> +       .mem_ops = &amlogic_spifc_a1_mem_ops,
> +       .set_speed = amlogic_spifc_a1_set_speed,
> +       .set_mode = amlogic_spifc_a1_set_mode,
> +};
> +
> +U_BOOT_DRIVER(meson_spifc_a1) = {
> +       .name           = "meson_spifc_a1",
> +       .id             = UCLASS_SPI,
> +       .of_match       = meson_spifc_ids,
> +       .ops            = &amlogic_spifc_a1_ops,
> +       .probe          = amlogic_spifc_a1_probe,
> +       .remove         = amlogic_spifc_a1_remove,
> +       .priv_auto      = sizeof(struct amlogic_spifc_a1),
> +};
> --
> 2.34.1
>

Regards,
Simon

