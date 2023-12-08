Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AEAC46CA3
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 15:09:05 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web10.15713.1702023006657017773
 for <u-boot-amlogic@groups.io>;
 Fri, 08 Dec 2023 00:10:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=o2WWhTGP;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.218.52, mailfrom: michael@amarulasolutions.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a06e59384b6so238540366b.1
        for <u-boot-amlogic@groups.io>; Fri, 08 Dec 2023 00:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702023005; x=1702627805; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3ydhgvJEeOKkYmhlJJ+bYfIBfh87dzi+d26oU2YYcU=;
        b=o2WWhTGPadrdhb1NEDYGIx4Kxsjrn6ONxqWQt/ULlE5QJ1xf3VTt3Rp4bZ1gvTVfW0
         CgA6PgNuPXqwB6luTBa5G/9zcHEc7kvUwA+mOs5NCLERF4tVLV8UzE3ojVzq5yck72RF
         k+y07sSnFUxVqOQv+ef/EvvxT80xLpylYbUXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702023005; x=1702627805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3ydhgvJEeOKkYmhlJJ+bYfIBfh87dzi+d26oU2YYcU=;
        b=DrkXWBgIo+IRHeqQt1roBxYvrRDpZbbZoxCXwSOch23z7Ids/oKdVqkPQOXBlYxstX
         W8L0qMXHehzvKbn/yC7F8Mp0DfM/VEYYO8LvfSgFXd+mBDEWbcDj8r1Aw1Kz/wC/w+e2
         8f2+tJJJdq+gCcBQnjoW84vA1LpWhvw7gdrOqMCt7qoiXoeZYH8lEStC+YVsxsUIajo5
         mMk8Cv+NUkGDep1f/sRXG15P0XkPTIixDhp0xu8Y3wBz7Y7SEjkKlSDX8eN8C7lrNmRD
         p1XVu11ymt3vD3kxscV7HIwHWsunquMwNgUFFMPWeNrrtvARNMuHql4K3ZZgC0yJWLRg
         z3tA==
X-Gm-Message-State: AOJu0Ywty4N6cHD58VyaJDRoeh6z3hKiQulXp4K+X/F/8QRN3s6I0V/g
	KEAL7WJHr3+T/vqclDNsPNj8V75t5aT/OTf8ggte7w==
X-Google-Smtp-Source: AGHT+IEVb3BiHnpz1v666KWxfH38S22wRRbkiKAKrXI/wsfvqhJex+Y+EcUv5Xunbr96t2iIuiEG16ro0mmz+Wy/0LM=
X-Received: by 2002:a17:906:897:b0:9e4:b664:baa8 with SMTP id
 n23-20020a170906089700b009e4b664baa8mr1995548eje.7.1702023004737; Fri, 08 Dec
 2023 00:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20231130112122.87934-1-avkrasnov@salutedevices.com>
In-Reply-To: <20231130112122.87934-1-avkrasnov@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 8 Dec 2023 09:09:52 +0100
Message-ID: <CAOf5uw=T459uo0k8j7JMcmoWxG+3WzuQsDn+f-izK8r3AiDJLQ@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: rawnand: Meson NAND controller support
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	kernel@sberdevices.ru, oxffffaa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 08 Dec 2023 15:09:05 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1901

Hi

On Thu, Nov 30, 2023 at 12:29=E2=80=AFPM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Basic support for Amlogic Meson NAND controller on AXG.
>
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  drivers/mtd/nand/raw/Kconfig      |    9 +
>  drivers/mtd/nand/raw/Makefile     |    1 +
>  drivers/mtd/nand/raw/meson_nand.c | 1231 +++++++++++++++++++++++++++++
>  3 files changed, 1241 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/meson_nand.c
>

This come almost from a linux kernel, please reference version in the
commit message

> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index d624589a89..7b7b0226ab 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -488,6 +488,15 @@ config NAND_ARASAN
>           controller. This uses the hardware ECC for read and
>           write operations.
>
> +config NAND_MESON
> +       bool "Meson NAND support"
> +       select SYS_NAND_SELF_INIT
> +       depends on DM_MTD && ARCH_MESON
> +       imply CMD_NAND
> +       help
> +         This enables Nand driver support for Meson raw NAND flash
> +         controller.
> +
>  config NAND_MXC
>         bool "MXC NAND support"
>         depends on CPU_ARM926EJS || CPU_ARM1136 || MX5
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefil=
e
> index add2b4cf65..5b4efd52c9 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_NAND_KMETER1) +=3D kmeter1_nand.o
>  obj-$(CONFIG_NAND_LPC32XX_MLC) +=3D lpc32xx_nand_mlc.o
>  obj-$(CONFIG_NAND_LPC32XX_SLC) +=3D lpc32xx_nand_slc.o
>  obj-$(CONFIG_NAND_VF610_NFC) +=3D vf610_nfc.o
> +obj-$(CONFIG_NAND_MESON) +=3D meson_nand.o
>  obj-$(CONFIG_NAND_MXC) +=3D mxc_nand.o
>  obj-$(CONFIG_NAND_MXS) +=3D mxs_nand.o
>  obj-$(CONFIG_NAND_MXS_DT) +=3D mxs_nand_dt.o
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> new file mode 100644
> index 0000000000..f1d49887ee
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -0,0 +1,1231 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson Nand Flash Controller Driver
> + *
> + * Copyright (c) 2023 SaluteDevices, Inc.
> + * Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
> + */
> +

Are you sure about the author? Should not be the one that wrote the
linux kernel one?

> +#include <common.h>
> +#include <nand.h>
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/ofnode.h>
> +#include <dm/uclass.h>
> +#include <linux/bug.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/iopoll.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/sizes.h>
> +
> +#define NFC_CMD_IDLE                   (0xc << 14)
> +#define NFC_CMD_CLE                    (0x5 << 14)
> +#define NFC_CMD_ALE                    (0x6 << 14)
> +#define NFC_CMD_DWR                    (0x4 << 14)
> +#define NFC_CMD_DRD                    (0x8 << 14)
> +#define NFC_CMD_ADL                    ((0 << 16) | (3 << 20))
> +#define NFC_CMD_ADH                    ((1 << 16) | (3 << 20))
> +#define NFC_CMD_AIL                    ((2 << 16) | (3 << 20))
> +#define NFC_CMD_AIH                    ((3 << 16) | (3 << 20))
> +#define NFC_CMD_SEED                   ((8 << 16) | (3 << 20))
> +#define NFC_CMD_M2N                    ((0 << 17) | (2 << 20))
> +#define NFC_CMD_N2M                    ((1 << 17) | (2 << 20))
> +#define NFC_CMD_RB                     BIT(20)
> +#define NFC_CMD_SCRAMBLER_ENABLE       BIT(19)
> +#define NFC_CMD_SCRAMBLER_DISABLE      0
> +#define NFC_CMD_SHORTMODE_DISABLE      0
> +#define NFC_CMD_RB_INT                 BIT(14)
> +#define NFC_CMD_RB_INT_NO_PIN          ((0xb << 10) | BIT(18) | BIT(16))
> +
> +#define NFC_CMD_GET_SIZE(x)    (((x) >> 22) & GENMASK(4, 0))
> +
> +#define NFC_REG_CMD            0x00
> +#define NFC_REG_CFG            0x04
> +#define NFC_REG_DADR           0x08
> +#define NFC_REG_IADR           0x0c
> +#define NFC_REG_BUF            0x10
> +#define NFC_REG_INFO           0x14
> +#define NFC_REG_DC             0x18
> +#define NFC_REG_ADR            0x1c
> +#define NFC_REG_DL             0x20
> +#define NFC_REG_DH             0x24
> +#define NFC_REG_CADR           0x28
> +#define NFC_REG_SADR           0x2c
> +#define NFC_REG_PINS           0x30
> +#define NFC_REG_VER            0x38
> +
> +#define CMDRWGEN(cmd_dir, ran, bch, short_mode, page_size, pages)      \
> +       (                                                               \
> +               (cmd_dir)                       |                       \
> +               ((ran) << 19)                   |                       \
> +               ((bch) << 14)                   |                       \
> +               ((short_mode) << 13)            |                       \
> +               (((page_size) & 0x7f) << 6)     |                       \
> +               ((pages) & 0x3f)                                        \
> +       )
> +
> +#define GENCMDDADDRL(adl, addr)                ((adl) | ((addr) & 0xffff=
))
> +#define GENCMDDADDRH(adh, addr)                ((adh) | (((addr) >> 16) =
& 0xffff))
> +#define GENCMDIADDRL(ail, addr)                ((ail) | ((addr) & 0xffff=
))
> +#define GENCMDIADDRH(aih, addr)                ((aih) | (((addr) >> 16) =
& 0xffff))
> +
> +#define DMA_DIR(dir)           ((dir) ? NFC_CMD_N2M : NFC_CMD_M2N)
> +
> +#define ECC_CHECK_RETURN_FF    -1
> +
> +#define NAND_CE0               (0xe << 10)
> +#define NAND_CE1               (0xd << 10)
> +
> +#define DMA_BUSY_TIMEOUT_US    1000000
> +#define CMD_DRAIN_TIMEOUT_US   1000
> +#define ECC_POLL_TIMEOUT_US    15
> +
> +#define MAX_CE_NUM             2
> +
> +/* eMMC clock register, misc control */
> +#define CLK_SELECT_NAND                BIT(31)
> +#define CLK_ALWAYS_ON_NAND     BIT(24)
> +#define CLK_ENABLE_VALUE       0x245
> +
> +#define DIRREAD                        1
> +#define DIRWRITE               0
> +
> +#define ECC_PARITY_BCH8_512B   14
> +#define ECC_COMPLETE            BIT(31)
> +#define ECC_ERR_CNT(x)         (((x) >> 24) & GENMASK(5, 0))
> +#define ECC_ZERO_CNT(x)                (((x) >> 16) & GENMASK(5, 0))
> +#define ECC_UNCORRECTABLE      0x3f
> +
> +#define PER_INFO_BYTE          8
> +
> +#define NFC_SEND_CMD(host, cmd) \
> +       (writel((cmd), (host)->reg_base + NFC_REG_CMD))
> +
> +#define NFC_GET_CMD(host) \
> +       (readl((host)->reg_base + NFC_REG_CMD))
> +
> +#define NFC_CMDFIFO_SIZE(host) ((NFC_GET_CMD((host)) >> 22) & GENMASK(4,=
 0))
> +
> +#define NFC_CMD_MAKE_IDLE(ce, delay)   ((ce) | NFC_CMD_IDLE | ((delay) &=
 0x3ff))
> +#define NFC_CMD_MAKE_DRD(ce, size)     ((ce) | NFC_CMD_DRD | (size))
> +#define NFC_CMD_MAKE_DWR(ce, data)     ((ce) | NFC_CMD_DWR | ((data) & 0=
xff))
> +#define NFC_CMD_MAKE_CLE(ce, cmd_val)  ((ce) | NFC_CMD_CLE | ((cmd_val) =
& 0xff))
> +#define NFC_CMD_MAKE_ALE(ce, addr)     ((ce) | NFC_CMD_ALE | ((addr) & 0=
xff))
> +
> +#define NAND_TWB_TIME_CYCLE    10
> +
> +#define NFC_DEV_READY_TICK_MAX 5000
> +
> +#define NFC_DEFAULT_BUS_CYCLE  6
> +#define NFC_DEFAULT_BUS_TIMING 7
> +
> +#define NFC_SEED_OFFSET                0xc2
> +#define NFC_SEED_MASK          0x7fff
> +
> +#define DMA_ADDR_ALIGN         8
> +
> +struct meson_nfc_nand_chip {
> +       struct list_head node;
> +       struct nand_chip nand;
> +
> +       u32 bch_mode;
> +       u8 *data_buf;
> +       __le64 *info_buf;
> +       u32 nsels;
> +       u8 sels[];
> +};
> +
> +struct meson_nfc_param {
> +       u32 chip_select;
> +       u32 rb_select;
> +};
> +
> +struct meson_nfc {
> +       void __iomem *reg_base;
> +       void __iomem *reg_clk;
> +       struct list_head chips;
> +       struct meson_nfc_param param;
> +       struct udevice *dev;
> +       dma_addr_t daddr;
> +       dma_addr_t iaddr;
> +       u32 data_bytes;
> +       u32 info_bytes;
> +       u64 assigned_cs;
> +};
> +
> +struct meson_nand_ecc {
> +       u32 bch;
> +       u32 strength;
> +       u32 size;
> +};
> +
> +enum {
> +       NFC_ECC_BCH8_512 =3D 1,
> +       NFC_ECC_BCH8_1K,
> +       NFC_ECC_BCH24_1K,
> +       NFC_ECC_BCH30_1K,
> +       NFC_ECC_BCH40_1K,
> +       NFC_ECC_BCH50_1K,
> +       NFC_ECC_BCH60_1K,
> +};
> +
> +#define MESON_ECC_DATA(b, s, sz) { .bch =3D (b), .strength =3D (s), .siz=
e =3D (sz) }
> +
> +static struct meson_nand_ecc meson_ecc[] =3D {
> +       MESON_ECC_DATA(NFC_ECC_BCH8_512, 8,  512),
> +       MESON_ECC_DATA(NFC_ECC_BCH8_1K,  8,  1024),
> +};
> +
> +static int meson_nand_calc_ecc_bytes(int step_size, int strength)
> +{
> +       int ecc_bytes;
> +
> +       if (step_size =3D=3D 512 && strength =3D=3D 8)
> +               return ECC_PARITY_BCH8_512B;
> +
> +       ecc_bytes =3D DIV_ROUND_UP(strength * fls(step_size * 8), 8);
> +       ecc_bytes =3D ALIGN(ecc_bytes, 2);
> +
> +       return ecc_bytes;
> +}
> +
> +static struct meson_nfc_nand_chip *to_meson_nand(struct nand_chip *nand)
> +{
> +       return container_of(nand, struct meson_nfc_nand_chip, nand);
> +}
> +
> +static void meson_nfc_nand_select_chip(struct mtd_info *mtd, int chip)
> +{
> +       struct nand_chip *nand =3D mtd_to_nand(mtd);
> +       struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +       struct meson_nfc *nfc =3D nand_get_controller_data(nand);
> +
> +       nfc->param.chip_select =3D meson_chip->sels[chip] ? NAND_CE1 : NA=
ND_CE0;
> +}
> +
> +static void meson_nfc_cmd_idle(struct meson_nfc *nfc, u32 time)
> +{
> +       writel(NFC_CMD_MAKE_IDLE(nfc->param.chip_select, time),
> +              nfc->reg_base + NFC_REG_CMD);
> +}
> +
> +static void meson_nfc_cmd_seed(const struct meson_nfc *nfc, u32 seed)
> +{
> +       writel(NFC_CMD_SEED | (NFC_SEED_OFFSET + (seed & NFC_SEED_MASK)),
> +              nfc->reg_base + NFC_REG_CMD);
> +}
> +
> +static void meson_nfc_cmd_access(struct nand_chip *nand, bool raw, bool =
dir,
> +                                int scrambler)
> +{
> +       struct mtd_info *mtd =3D nand_to_mtd(nand);
> +       const struct meson_nfc *nfc =3D nand_get_controller_data(mtd_to_n=
and(mtd));
> +       const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(na=
nd);
> +       u32 bch =3D meson_chip->bch_mode, cmd;
> +       int len =3D mtd->writesize, pagesize, pages;
> +
> +       pagesize =3D nand->ecc.size;
> +
> +       if (raw) {
> +               len =3D mtd->writesize + mtd->oobsize;
> +               cmd =3D len | scrambler | DMA_DIR(dir);
> +               writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +               return;
> +       }
> +
> +       pages =3D len / nand->ecc.size;
> +
> +       cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, bch,
> +                      NFC_CMD_SHORTMODE_DISABLE, pagesize, pages);
> +
> +       writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +}
> +
> +static void meson_nfc_drain_cmd(struct meson_nfc *nfc)
> +{
> +       /*
> +        * Insert two commands to make sure all valid commands are finish=
ed.
> +        *
> +        * The Nand flash controller is designed as two stages pipleline =
-
> +        *  a) fetch and b) execute.
> +        * There might be cases when the driver see command queue is empt=
y,
> +        * but the Nand flash controller still has two commands buffered,
> +        * one is fetched into NFC request queue (ready to run), and anot=
her
> +        * is actively executing. So pushing 2 "IDLE" commands guarantees=
 that
> +        * the pipeline is emptied.
> +        */
> +       meson_nfc_cmd_idle(nfc, 0);
> +       meson_nfc_cmd_idle(nfc, 0);
> +}
> +
> +static int meson_nfc_wait_cmd_finish(const struct meson_nfc *nfc,
> +                                    unsigned int timeout_us)
> +{
> +       u32 cmd_size =3D 0;
> +
> +       /* wait cmd fifo is empty */
> +       return readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cm=
d_size,
> +                                         !NFC_CMD_GET_SIZE(cmd_size),
> +                                         timeout_us);
> +}
> +
> +static int meson_nfc_wait_dma_finish(struct meson_nfc *nfc)
> +{
> +       meson_nfc_drain_cmd(nfc);
> +
> +       return meson_nfc_wait_cmd_finish(nfc, DMA_BUSY_TIMEOUT_US);
> +}
> +
> +static u8 *meson_nfc_oob_ptr(struct nand_chip *nand, int i)
> +{
> +       const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(na=
nd);
> +       int len;
> +
> +       len =3D nand->ecc.size * (i + 1) + (nand->ecc.bytes + 2) * i;
> +
> +       return meson_chip->data_buf + len;
> +}
> +
> +static u8 *meson_nfc_data_ptr(struct nand_chip *nand, int i)
> +{
> +       const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(na=
nd);
> +       int len, temp;
> +
> +       temp =3D nand->ecc.size + nand->ecc.bytes;
> +       len =3D (temp + 2) * i;
> +
> +       return meson_chip->data_buf + len;
> +}
> +
> +static void meson_nfc_get_data_oob(struct nand_chip *nand,
> +                                  u8 *buf, u8 *oobbuf)
> +{
> +       u8 *dsrc, *osrc;
> +       int i, oob_len;
> +
> +       oob_len =3D nand->ecc.bytes + 2;
> +       for (i =3D 0; i < nand->ecc.steps; i++) {
> +               if (buf) {
> +                       dsrc =3D meson_nfc_data_ptr(nand, i);
> +                       memcpy(buf, dsrc, nand->ecc.size);
> +                       buf +=3D nand->ecc.size;
> +               }
> +
> +               if (oobbuf) {
> +                       osrc =3D meson_nfc_oob_ptr(nand, i);
> +                       memcpy(oobbuf, osrc, oob_len);
> +                       oobbuf +=3D oob_len;
> +               }
> +       }
> +}
> +
> +static void meson_nfc_set_data_oob(struct nand_chip *nand,
> +                                  const u8 *buf, u8 *oobbuf)
> +{
> +       int i, oob_len;
> +
> +       oob_len =3D nand->ecc.bytes + 2;
> +       for (i =3D 0; i < nand->ecc.steps; i++) {
> +               u8 *osrc;
> +
> +               if (buf) {
> +                       u8 *dsrc;
> +
> +                       dsrc =3D meson_nfc_data_ptr(nand, i);
> +                       memcpy(dsrc, buf, nand->ecc.size);
> +                       buf +=3D nand->ecc.size;
> +               }
> +
> +               osrc =3D meson_nfc_oob_ptr(nand, i);
> +               memcpy(osrc, oobbuf, oob_len);
> +               oobbuf +=3D oob_len;
> +       }
> +}
> +
> +static void meson_nfc_set_user_byte(struct nand_chip *nand, const u8 *oo=
b_buf)
> +{
> +       struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +       int i, count;
> +
> +       for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D (=
2 + nand->ecc.bytes)) {
> +               __le64 *info =3D &meson_chip->info_buf[i];
> +
> +               *info |=3D oob_buf[count];
> +               *info |=3D oob_buf[count + 1] << 8;
> +       }
> +}
> +
> +static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_buf)
> +{
> +       struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +       int i, count;
> +
> +       for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D (=
2 + nand->ecc.bytes)) {
> +               const __le64 *info =3D &meson_chip->info_buf[i];
> +
> +               oob_buf[count] =3D *info;
> +               oob_buf[count + 1] =3D *info >> 8;
> +       }
> +}
> +
> +static int meson_nfc_ecc_correct(struct nand_chip *nand, u32 *bitflips,
> +                                u64 *correct_bitmap)
> +{
> +       struct mtd_info *mtd =3D nand_to_mtd(nand);
> +       int ret =3D 0, i;
> +
> +       for (i =3D 0; i < nand->ecc.steps; i++) {
> +               struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(=
nand);
> +               const __le64 *info =3D &meson_chip->info_buf[i];
> +
> +               if (ECC_ERR_CNT(*info) !=3D ECC_UNCORRECTABLE) {
> +                       mtd->ecc_stats.corrected +=3D ECC_ERR_CNT(*info);
> +                       *bitflips =3D max_t(u32, *bitflips, ECC_ERR_CNT(*=
info));
> +                       *correct_bitmap |=3D BIT_ULL(i);
> +                       continue;
> +               }
> +
> +               if ((nand->options & NAND_NEED_SCRAMBLING) &&
> +                   ECC_ZERO_CNT(*info) < nand->ecc.strength) {
> +                       mtd->ecc_stats.corrected +=3D ECC_ZERO_CNT(*info)=
;
> +                       *bitflips =3D max_t(u32, *bitflips,
> +                                         ECC_ZERO_CNT(*info));
> +                       ret =3D ECC_CHECK_RETURN_FF;
> +               } else {
> +                       ret =3D -EBADMSG;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int meson_nfc_dma_buffer_setup(struct nand_chip *nand, void *data=
buf,
> +                                     int datalen, void *infobuf, int inf=
olen,
> +                                     enum dma_data_direction dir)
> +{
> +       struct meson_nfc *nfc =3D nand_get_controller_data(nand);
> +       int ret;
> +       u32 cmd;
> +
> +       nfc->daddr =3D dma_map_single(databuf, datalen, DMA_BIDIRECTIONAL=
);
> +       ret =3D dma_mapping_error(nfc->dev, nfc->daddr);
> +       if (ret)
> +               return ret;
> +
> +       cmd =3D GENCMDDADDRL(NFC_CMD_ADL, nfc->daddr);
> +       writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +       cmd =3D GENCMDDADDRH(NFC_CMD_ADH, nfc->daddr);
> +       writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +       if (infobuf) {
> +               nfc->iaddr =3D dma_map_single(infobuf, infolen,
> +                                           DMA_BIDIRECTIONAL);
> +               ret =3D dma_mapping_error(nfc->dev, nfc->iaddr);
> +               if (ret) {
> +                       dma_unmap_single(nfc->daddr, datalen, dir);
> +                       return ret;
> +               }
> +
> +               nfc->info_bytes =3D infolen;
> +               cmd =3D GENCMDIADDRL(NFC_CMD_AIL, nfc->iaddr);
> +               writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +               cmd =3D GENCMDIADDRH(NFC_CMD_AIH, nfc->iaddr);
> +               writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +       }
> +
> +       return 0;
> +}
> +
> +static void meson_nfc_dma_buffer_release(struct nand_chip *nand,
> +                                        int datalen, int infolen,
> +                                        enum dma_data_direction dir)
> +{
> +       struct meson_nfc *nfc =3D nand_get_controller_data(nand);
> +
> +       dma_unmap_single(nfc->daddr, datalen, dir);
> +
> +       if (infolen) {
> +               dma_unmap_single(nfc->iaddr, infolen, dir);
> +               nfc->info_bytes =3D 0;
> +       }
> +}
> +
> +static void meson_nfc_read_buf(struct mtd_info *mtd, u8 *buf, int size)
> +{
> +       struct nand_chip *nand =3D mtd_to_nand(mtd);
> +       struct meson_nfc *nfc =3D nand_get_controller_data(nand);
> +       struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +       u8 *dma_buf;
> +       int ret;
> +       u32 cmd;
> +
> +       if ((uintptr_t)buf % DMA_ADDR_ALIGN) {
> +               unsigned long tmp_addr;
> +
> +               dma_buf =3D dma_alloc_coherent(size, &tmp_addr);
> +               if (!dma_buf)
> +                       return;
> +       } else {
> +               dma_buf =3D buf;
> +       }
> +
> +       ret =3D meson_nfc_dma_buffer_setup(nand, dma_buf, size, meson_chi=
p->info_buf,
> +                                        PER_INFO_BYTE, DMA_FROM_DEVICE);
> +       if (ret) {
> +               pr_err("Failed to setup DMA buffer %p/%p\n", dma_buf,
> +                      meson_chip->info_buf);
> +               return;
> +       }
> +
> +       cmd =3D NFC_CMD_N2M | size;
> +       writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +       meson_nfc_drain_cmd(nfc);
> +       meson_nfc_wait_cmd_finish(nfc, CMD_DRAIN_TIMEOUT_US);
> +       meson_nfc_dma_buffer_release(nand, size, PER_INFO_BYTE, DMA_FROM_=
DEVICE);
> +
> +       if (buf !=3D dma_buf) {
> +               memcpy(buf, dma_buf, size);
> +               dma_free_coherent(dma_buf);
> +       }
> +}
> +
> +static void meson_nfc_write_buf(struct mtd_info *mtd, const u8 *buf, int=
 size)
> +{
> +       struct nand_chip *nand =3D mtd_to_nand(mtd);
> +       struct meson_nfc *nfc =3D nand_get_controller_data(nand);
> +       u8 *dma_buf;
> +       int ret;
> +       u32 cmd;
> +
> +       if ((uintptr_t)buf % DMA_ADDR_ALIGN) {
> +               unsigned long tmp_addr;
> +
> +               dma_buf =3D dma_alloc_coherent(size, &tmp_addr);
> +               if (!dma_buf)
> +                       return;
> +
> +               memcpy(dma_buf, buf, size);
> +       } else {
> +               dma_buf =3D (u8 *)buf;
> +       }
> +
> +       ret =3D meson_nfc_dma_buffer_setup(nand, (void *)dma_buf, size, N=
ULL,
> +                                        0, DMA_TO_DEVICE);
> +       if (ret) {
> +               pr_err("Failed to setup DMA buffer %p\n", dma_buf);
> +               return;
> +       }
> +
> +       cmd =3D NFC_CMD_M2N | size;
> +       writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +       meson_nfc_drain_cmd(nfc);
> +       meson_nfc_wait_cmd_finish(nfc, CMD_DRAIN_TIMEOUT_US);
> +       meson_nfc_dma_buffer_release(nand, size, 0, DMA_TO_DEVICE);
> +
> +       if (buf !=3D dma_buf)
> +               dma_free_coherent(dma_buf);
> +}
> +
> +static int meson_nfc_write_page_sub(struct nand_chip *nand,
> +                                   int page, bool raw)
> +{
> +       const struct mtd_info *mtd =3D nand_to_mtd(nand);
> +       struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +       struct meson_nfc *nfc =3D nand_get_controller_data(nand);
> +       int data_len, info_len;
> +       int ret;
> +       u32 cmd;
> +
> +       data_len =3D  mtd->writesize + mtd->oobsize;
> +       info_len =3D nand->ecc.steps * PER_INFO_BYTE;
> +
> +       ret =3D meson_nfc_dma_buffer_setup(nand, meson_chip->data_buf,
> +                                        data_len, meson_chip->info_buf,
> +                                        info_len, DMA_TO_DEVICE);
> +       if (ret) {
> +               pr_err("Failed to setup DMA buffer %p/%p\n",
> +                      meson_chip->data_buf, meson_chip->info_buf);
> +               return ret;
> +       }
> +
> +       if (nand->options & NAND_NEED_SCRAMBLING) {
> +               meson_nfc_cmd_seed(nfc, page);
> +               meson_nfc_cmd_access(nand, raw, DIRWRITE,
> +                                    NFC_CMD_SCRAMBLER_ENABLE);
> +       } else {
> +               meson_nfc_cmd_access(nand, raw, DIRWRITE,
> +                                    NFC_CMD_SCRAMBLER_DISABLE);
> +       }
> +
> +       cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
> +       writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +       meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEV=
ICE);
> +
> +       return 0;
> +}
> +
> +static int meson_nfc_write_page_raw(struct mtd_info *mtd, struct nand_ch=
ip *chip,
> +                                   const u8 *buf, int oob_required, int =
page)
> +{
> +       meson_nfc_set_data_oob(chip, buf, oob_required ? chip->oob_poi : =
NULL);
> +
> +       return meson_nfc_write_page_sub(chip, page, true);
> +}
> +
> +static int meson_nfc_write_page_hwecc(struct mtd_info *mtd, struct nand_=
chip *chip,
> +                                     const u8 *buf, int oob_required, in=
t page)
> +{
> +       struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(chip);
> +
> +       if (buf)
> +               memcpy(meson_chip->data_buf, buf, mtd->writesize);
> +
> +       memset(meson_chip->info_buf, 0, chip->ecc.steps * PER_INFO_BYTE);
> +
> +       if (oob_required)
> +               meson_nfc_set_user_byte(chip, chip->oob_poi);
> +
> +       return meson_nfc_write_page_sub(chip, page, false);
> +}
> +
> +static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
> +                                           struct nand_chip *nand, bool =
raw)
> +{
> +       struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +       __le64 *info;
> +       u32 neccpages;
> +       int ret;
> +
> +       neccpages =3D raw ? 1 : nand->ecc.steps;
> +       info =3D &meson_chip->info_buf[neccpages - 1];
> +       do {
> +               udelay(ECC_POLL_TIMEOUT_US);
> +               /* info is updated by nfc dma engine*/
> +               rmb();
> +               invalidate_dcache_range(nfc->iaddr, nfc->iaddr + nfc->inf=
o_bytes);
> +               ret =3D *info & ECC_COMPLETE;
> +       } while (!ret);
> +}
> +
> +static int meson_nfc_read_page_sub(struct nand_chip *nand,
> +                                  int page, bool raw)
> +{
> +       struct mtd_info *mtd =3D nand_to_mtd(nand);
> +       struct meson_nfc *nfc =3D nand_get_controller_data(nand);
> +       struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +       u32 data_len, info_len;
> +       int ret;
> +
> +       data_len =3D mtd->writesize + mtd->oobsize;
> +       info_len =3D nand->ecc.steps * PER_INFO_BYTE;
> +
> +       ret =3D meson_nfc_dma_buffer_setup(nand, meson_chip->data_buf, da=
ta_len,
> +                                        meson_chip->info_buf, info_len,
> +                                        DMA_FROM_DEVICE);
> +       if (ret)
> +               return ret;
> +
> +       meson_nfc_cmd_access(nand, raw, DIRREAD, 0);
> +
> +       meson_nfc_wait_dma_finish(nfc);
> +       meson_nfc_check_ecc_pages_valid(nfc, nand, raw);
> +
> +       meson_nfc_dma_buffer_release(nand, data_len, info_len,
> +                                    DMA_FROM_DEVICE);
> +
> +       return 0;
> +}
> +
> +static int meson_nfc_read_page_raw(struct mtd_info *mtd, struct nand_chi=
p *chip,
> +                                  u8 *buf, int oob_required, int page)
> +{
> +       int ret;
> +
> +       ret =3D meson_nfc_read_page_sub(chip, page, true);
> +       if (ret)
> +               return ret;
> +
> +       meson_nfc_get_data_oob(chip, buf, oob_required ? chip->oob_poi : =
NULL);
> +
> +       return 0;
> +}
> +
> +static int meson_nfc_read_page_hwecc(struct mtd_info *mtd, struct nand_c=
hip *chip,
> +                                    u8 *buf, int oob_required, int page)
> +{
> +       const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(ch=
ip);
> +       u64 correct_bitmap =3D 0;
> +       u32 bitflips =3D 0;
> +       int ret;
> +
> +       ret =3D meson_nfc_read_page_sub(chip, page, false);
> +       if (ret)
> +               return ret;
> +
> +       if (oob_required)
> +               meson_nfc_get_user_byte(chip, chip->oob_poi);
> +
> +       ret =3D meson_nfc_ecc_correct(chip, &bitflips, &correct_bitmap);
> +
> +       if (ret =3D=3D ECC_CHECK_RETURN_FF) {
> +               if (buf)
> +                       memset(buf, 0xff, mtd->writesize);
> +
> +               if (oob_required)
> +                       memset(chip->oob_poi, 0xff, mtd->oobsize);
> +       } else if (ret < 0) {
> +               struct nand_ecc_ctrl *ecc;
> +               int i;
> +
> +               if ((chip->options & NAND_NEED_SCRAMBLING) || !buf) {
> +                       mtd->ecc_stats.failed++;
> +                       return bitflips;
> +               }
> +
> +               chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
> +
> +               ret =3D meson_nfc_read_page_raw(mtd, chip, buf, 1, page);
> +               if (ret)
> +                       return ret;
> +
> +               ecc =3D &chip->ecc;
> +
> +               for (i =3D 0; i < chip->ecc.steps ; i++) {
> +                       u8 *data =3D buf + i * ecc->size;
> +                       u8 *oob =3D chip->oob_poi + i * (ecc->bytes + 2);
> +
> +                       if (correct_bitmap & BIT_ULL(i))
> +                               continue;
> +
> +                       ret =3D nand_check_erased_ecc_chunk(data, ecc->si=
ze,
> +                                                         oob, ecc->bytes=
 + 2,
> +                                                         NULL, 0,
> +                                                         ecc->strength);
> +                       if (ret < 0) {
> +                               mtd->ecc_stats.failed++;
> +                       } else {
> +                               mtd->ecc_stats.corrected +=3D ret;
> +                               bitflips =3D  max_t(u32, bitflips, ret);
> +                       }
> +               }
> +       } else if (buf && buf !=3D meson_chip->data_buf) {
> +               memcpy(buf, meson_chip->data_buf, mtd->writesize);
> +       }
> +
> +       return bitflips;
> +}
> +
> +static int meson_nfc_read_oob_raw(struct mtd_info *mtd, struct nand_chip=
 *chip,
> +                                 int page)
> +{
> +       int ret;
> +
> +       ret =3D nand_read_page_op(chip, page, 0, NULL, 0);
> +       if (ret)
> +               return ret;
> +
> +       return meson_nfc_read_page_raw(mtd, chip, NULL, 1, page);
> +}
> +
> +static int meson_nfc_read_oob(struct mtd_info *mtd, struct nand_chip *ch=
ip,
> +                             int page)
> +{
> +       int ret;
> +
> +       ret =3D nand_read_page_op(chip, page, 0, NULL, 0);
> +       if (ret)
> +               return ret;
> +
> +       return meson_nfc_read_page_hwecc(mtd, chip, NULL, 1, page);
> +}
> +
> +static int meson_nfc_write_oob_raw(struct mtd_info *mtd, struct nand_chi=
p *chip,
> +                                  int page)
> +{
> +       int ret;
> +
> +       ret =3D nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D meson_nfc_write_page_raw(mtd, chip, NULL, 1, page);
> +       if (ret)
> +               return ret;
> +
> +       return nand_prog_page_end_op(chip);
> +}
> +
> +static int meson_nfc_write_oob(struct mtd_info *mtd, struct nand_chip *c=
hip,
> +                              int page)
> +{
> +       int ret;
> +
> +       ret =3D nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D meson_nfc_write_page_hwecc(mtd, chip, NULL, 1, page);
> +       if (ret)
> +               return ret;
> +
> +       return nand_prog_page_end_op(chip);
> +}
> +
> +static void meson_nfc_nand_cmd_function(struct mtd_info *mtd, unsigned i=
nt command,
> +                                       int column, int page_addr)
> +{
> +       struct nand_chip *chip =3D mtd_to_nand(mtd);
> +
> +       chip->cmd_ctrl(mtd, command, NAND_NCE | NAND_CLE | NAND_CTRL_CHAN=
GE);
> +
> +       if (column !=3D -1 || page_addr !=3D -1) {
> +               int ctrl =3D NAND_CTRL_CHANGE | NAND_NCE | NAND_ALE;
> +
> +               /* Serially input address */
> +               if (column !=3D -1) {
> +                       /* Adjust columns for 16 bit buswidth */
> +                       if (chip->options & NAND_BUSWIDTH_16 &&
> +                           !nand_opcode_8bits(command))
> +                               column >>=3D 1;
> +
> +                       chip->cmd_ctrl(mtd, column, ctrl);
> +                       ctrl &=3D ~NAND_CTRL_CHANGE;
> +                       /* Only output a single addr cycle for 8bits
> +                        * opcodes.
> +                        */
> +                       if (!nand_opcode_8bits(command))
> +                               chip->cmd_ctrl(mtd, column >> 8, ctrl);
> +               }
> +
> +               if (page_addr !=3D -1) {
> +                       chip->cmd_ctrl(mtd, page_addr, ctrl);
> +                       chip->cmd_ctrl(mtd, page_addr >> 8, NAND_NCE |
> +                                                           NAND_ALE);
> +                       /* One more address cycle for devices > 128MiB */
> +                       if (chip->chipsize > SZ_128M)
> +                               chip->cmd_ctrl(mtd, page_addr >> 16,
> +                                              NAND_NCE | NAND_ALE);
> +               }
> +
> +               switch (command) {
> +               case NAND_CMD_READ0:
> +                       chip->cmd_ctrl(mtd, NAND_CMD_READSTART,
> +                                      NAND_NCE | NAND_CLE | NAND_CTRL_CH=
ANGE);
> +                       fallthrough;
> +               case NAND_CMD_PARAM:
> +                       nand_wait_ready(mtd);
> +                       nand_exit_status_op(chip);
> +               }
> +       }
> +}
> +
> +static void meson_nfc_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned i=
nt ctrl)
> +{
> +       struct nand_chip *nand =3D mtd_to_nand(mtd);
> +       struct meson_nfc *nfc =3D nand_get_controller_data(nand);
> +
> +       if (cmd =3D=3D NAND_CMD_NONE)
> +               return;
> +
> +       if (ctrl & NAND_CLE)
> +               cmd =3D NFC_CMD_MAKE_CLE(nfc->param.chip_select, cmd);
> +       else
> +               cmd =3D NFC_CMD_MAKE_ALE(nfc->param.chip_select, cmd);
> +
> +       writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +}
> +
> +static void meson_nfc_wait_cmd_fifo(struct meson_nfc *nfc)
> +{
> +       while ((NFC_GET_CMD(nfc) >> 22) & GENMASK(4, 0))
> +               ;
> +}
> +
> +static u8 meson_nfc_nand_read_byte(struct mtd_info *mtd)
> +{
> +       struct nand_chip *nand =3D mtd_to_nand(mtd);
> +       struct meson_nfc *nfc =3D nand_get_controller_data(nand);
> +
> +       writel(NFC_CMD_MAKE_DRD(nfc->param.chip_select, 0), nfc->reg_base=
 + NFC_REG_CMD);
> +
> +       meson_nfc_cmd_idle(nfc, NAND_TWB_TIME_CYCLE);
> +       meson_nfc_cmd_idle(nfc, 0);
> +       meson_nfc_cmd_idle(nfc, 0);
> +
> +       meson_nfc_wait_cmd_fifo(nfc);
> +
> +       return readl(nfc->reg_base + NFC_REG_BUF);
> +}
> +
> +static void meson_nfc_nand_write_byte(struct mtd_info *mtd, u8 val)
> +{
> +       struct nand_chip *nand =3D mtd_to_nand(mtd);
> +       struct meson_nfc *nfc =3D nand_get_controller_data(nand);
> +
> +       meson_nfc_cmd_idle(nfc, NAND_TWB_TIME_CYCLE);
> +
> +       writel(NFC_CMD_MAKE_DWR(nfc->param.chip_select, val), nfc->reg_ba=
se + NFC_REG_CMD);
> +
> +       meson_nfc_cmd_idle(nfc, NAND_TWB_TIME_CYCLE);
> +       meson_nfc_cmd_idle(nfc, 0);
> +       meson_nfc_cmd_idle(nfc, 0);
> +
> +       meson_nfc_wait_cmd_fifo(nfc);
> +}
> +
> +static int meson_nfc_dev_ready(struct mtd_info *mtd)
> +{
> +       struct nand_chip *chip =3D mtd_to_nand(mtd);
> +       unsigned int time_out_cnt =3D 0;
> +
> +       chip->select_chip(mtd, 0);
> +
> +       chip->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
> +
> +       do {
> +               int status;
> +
> +               status =3D (int)chip->read_byte(mtd);
> +               if (status & NAND_STATUS_READY)
> +                       break;
> +       } while (time_out_cnt++ < NFC_DEV_READY_TICK_MAX);
> +
> +       return time_out_cnt !=3D NFC_DEV_READY_TICK_MAX;
> +}
> +
> +static int meson_chip_buffer_init(struct nand_chip *nand)
> +{
> +       const struct mtd_info *mtd =3D nand_to_mtd(nand);
> +       struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +       u32 page_bytes, info_bytes, nsectors;
> +       unsigned long tmp_addr;
> +
> +       nsectors =3D mtd->writesize / nand->ecc.size;
> +
> +       page_bytes =3D  mtd->writesize + mtd->oobsize;
> +       info_bytes =3D nsectors * PER_INFO_BYTE;
> +
> +       meson_chip->data_buf =3D dma_alloc_coherent(page_bytes, &tmp_addr=
);
> +       if (!meson_chip->data_buf)
> +               return -ENOMEM;
> +
> +       meson_chip->info_buf =3D dma_alloc_coherent(info_bytes, &tmp_addr=
);
> +       if (!meson_chip->info_buf) {
> +               dma_free_coherent(meson_chip->data_buf);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static const int axg_stepinfo_strengths[] =3D { 8 };
> +static const struct nand_ecc_step_info axg_stepinfo_1024 =3D {
> +       .stepsize =3D 1024,
> +       .strengths =3D axg_stepinfo_strengths,
> +       .nstrengths =3D ARRAY_SIZE(axg_stepinfo_strengths)
> +};
> +
> +static const struct nand_ecc_step_info axg_stepinfo_512 =3D {
> +       .stepsize =3D 512,
> +       .strengths =3D axg_stepinfo_strengths,
> +       .nstrengths =3D ARRAY_SIZE(axg_stepinfo_strengths)
> +};
> +
> +static const struct nand_ecc_step_info axg_stepinfo[] =3D { axg_stepinfo=
_1024, axg_stepinfo_512 };
> +
> +static const struct nand_ecc_caps meson_axg_ecc_caps =3D {
> +       .stepinfos =3D axg_stepinfo,
> +       .nstepinfos =3D ARRAY_SIZE(axg_stepinfo),
> +       .calc_ecc_bytes =3D meson_nand_calc_ecc_bytes,
> +};
> +
> +/*
> + * OOB layout:
> + *
> + * For ECC with 512 bytes step size:
> + * 0x00: AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
> + * 0x10: AA AA CC CC CC CC CC CC CC CC CC CC CC CC CC CC
> + * 0x20:
> + * 0x30:
> + *
> + * For ECC with 1024 bytes step size:
> + * 0x00: AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
> + * 0x10: AA AA CC CC CC CC CC CC CC CC CC CC CC CC CC CC
> + * 0x20: AA AA DD DD DD DD DD DD DD DD DD DD DD DD DD DD
> + * 0x30: AA AA EE EE EE EE EE EE EE EE EE EE EE EE EE EE
> + *
> + * AA - user bytes.
> + * BB, CC, DD, EE - ECC code bytes for each step.
> + */
> +static struct nand_ecclayout nand_oob;
> +
> +static void meson_nfc_init_nand_oob(struct nand_chip *nand)
> +{
> +       int section_size =3D 2 + nand->ecc.bytes;
> +       int i;
> +       int k;
> +
> +       nand_oob.eccbytes =3D nand->ecc.steps * nand->ecc.bytes;
> +       k =3D 0;
> +
> +       for (i =3D 0; i < nand->ecc.steps; i++) {
> +               int j;
> +
> +               for (j =3D 0; j < nand->ecc.bytes; j++)
> +                       nand_oob.eccpos[k++] =3D (i * section_size) + 2 +=
 j;
> +
> +               nand_oob.oobfree[i].offset =3D (i * section_size);
> +               nand_oob.oobfree[i].length =3D 2;
> +       }
> +
> +       nand_oob.oobavail =3D 2 * nand->ecc.steps;
> +       nand->ecc.layout =3D &nand_oob;
> +}
> +
> +static int meson_nfc_init_ecc(struct nand_chip *nand, ofnode node)
> +{
> +       const struct mtd_info *mtd =3D nand_to_mtd(nand);
> +       int ret;
> +       int i;
> +
> +       ret =3D nand_check_ecc_caps(nand, &meson_axg_ecc_caps, mtd->oobsi=
ze - 2);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(meson_ecc); i++) {
> +               if (meson_ecc[i].strength =3D=3D nand->ecc.strength &&
> +                   meson_ecc[i].size =3D=3D nand->ecc.size) {
> +                       struct meson_nfc_nand_chip *meson_chip =3D to_mes=
on_nand(nand);
> +
> +                       nand->ecc.steps =3D mtd->writesize / nand->ecc.si=
ze;
> +                       meson_chip->bch_mode =3D meson_ecc[i].bch;
> +
> +                       meson_nfc_init_nand_oob(nand);
> +
> +                       return 0;
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int meson_nfc_nand_chip_init(struct udevice *dev, struct meson_nf=
c *nfc,
> +                                   ofnode node)
> +{
> +       struct meson_nfc_nand_chip *meson_chip;
> +       struct nand_chip *nand;
> +       struct mtd_info *mtd;
> +       u32 cs[MAX_CE_NUM];
> +       u32 nsels;
> +       int ret;
> +       int i;
> +
> +       if (!ofnode_get_property(node, "reg", &nsels)) {
> +               dev_err(dev, "\"reg\" property is not found\n");
> +               return -ENODEV;
> +       }
> +
> +       nsels /=3D sizeof(u32);
> +       if (nsels >=3D MAX_CE_NUM) {
> +               dev_err(dev, "invalid size of CS array, max is %d\n",
> +                       MAX_CE_NUM);
> +               return -EINVAL;
> +       }
> +
> +       ret =3D ofnode_read_u32_array(node, "reg", cs, nsels);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to read \"reg\" property\n");
> +               return ret;
> +       }
> +
> +       for (i =3D 0; i < nsels; i++) {
> +               if (test_and_set_bit(cs[i], &nfc->assigned_cs)) {
> +                       dev_err(dev, "CS %d already assigned\n", cs[i]);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       meson_chip =3D malloc(sizeof(*meson_chip) + nsels * sizeof(meson_=
chip->sels[0]));
> +       if (!meson_chip) {
> +               dev_err(dev, "failed to allocate memory for chip\n");
> +               return -ENOMEM;
> +       }
> +
> +       meson_chip->nsels =3D nsels;
> +       nand =3D &meson_chip->nand;
> +
> +       nand->flash_node =3D node;
> +       nand_set_controller_data(nand, nfc);
> +       /* Set the driver entry points for MTD */
> +       nand->cmdfunc =3D meson_nfc_nand_cmd_function;
> +       nand->cmd_ctrl =3D meson_nfc_cmd_ctrl;
> +       nand->select_chip =3D meson_nfc_nand_select_chip;
> +       nand->read_byte =3D meson_nfc_nand_read_byte;
> +       nand->write_byte =3D meson_nfc_nand_write_byte;
> +       nand->dev_ready =3D meson_nfc_dev_ready;
> +
> +       /* Buffer read/write routines */
> +       nand->read_buf =3D meson_nfc_read_buf;
> +       nand->write_buf =3D meson_nfc_write_buf;
> +       nand->options |=3D NAND_NO_SUBPAGE_WRITE;
> +
> +       nand->ecc.mode =3D NAND_ECC_HW;
> +       nand->ecc.hwctl =3D NULL;
> +       nand->ecc.read_page =3D meson_nfc_read_page_hwecc;
> +       nand->ecc.write_page =3D meson_nfc_write_page_hwecc;
> +       nand->ecc.read_page_raw =3D meson_nfc_read_page_raw;
> +       nand->ecc.write_page_raw =3D meson_nfc_write_page_raw;
> +
> +       nand->ecc.read_oob =3D meson_nfc_read_oob;
> +       nand->ecc.write_oob =3D meson_nfc_write_oob;
> +       nand->ecc.read_oob_raw =3D meson_nfc_read_oob_raw;
> +       nand->ecc.write_oob_raw =3D meson_nfc_write_oob_raw;
> +
> +       nand->ecc.algo =3D NAND_ECC_BCH;
> +
> +       mtd =3D nand_to_mtd(nand);
> +
> +       ret =3D nand_scan_ident(mtd, 1, NULL);
> +       if (ret) {
> +               dev_err(dev, "'nand_scan_ident()' failed: %d\n", ret);
> +               goto err_chip_free;
> +       }
> +
> +       ret =3D meson_nfc_init_ecc(nand, node);
> +       if (ret) {
> +               dev_err(dev, "failed to init ECC settings: %d\n", ret);
> +               goto err_chip_free;
> +       }
> +
> +       ret =3D meson_chip_buffer_init(nand);
> +       if (ret) {
> +               dev_err(dev, "failed to init DMA buffers: %d\n", ret);
> +               goto err_chip_free;
> +       }
> +
> +       /* 'nand_scan_tail()' needs ECC parameters to be already
> +        * set and correct.
> +        */
> +       ret =3D nand_scan_tail(mtd);
> +       if (ret) {
> +               dev_err(dev, "'nand_scan_tail()' failed: %d\n", ret);
> +               goto err_chip_buf_free;
> +       }
> +
> +       ret =3D nand_register(0, mtd);
> +       if (ret) {
> +               dev_err(dev, "'nand_register()' failed: %d\n", ret);
> +               goto err_chip_buf_free;
> +       }
> +
> +       list_add_tail(&meson_chip->node, &nfc->chips);
> +
> +       return 0;
> +
> +err_chip_buf_free:
> +       dma_free_coherent(meson_chip->info_buf);
> +       dma_free_coherent(meson_chip->data_buf);
> +
> +err_chip_free:
> +       free(meson_chip);
> +
> +       return ret;
> +}
> +
> +static int meson_nfc_nand_chips_init(struct udevice *dev,
> +                                    struct meson_nfc *nfc)
> +{
> +       ofnode parent =3D dev_ofnode(dev);
> +       ofnode node;
> +
> +       ofnode_for_each_subnode(node, parent) {
> +               int ret =3D meson_nfc_nand_chip_init(dev, nfc, node);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void meson_nfc_clk_init(struct meson_nfc *nfc)
> +{
> +       u32 bus_cycle =3D NFC_DEFAULT_BUS_CYCLE;
> +       u32 bus_timing =3D NFC_DEFAULT_BUS_TIMING;
> +       u32 bus_cfg_val;
> +
> +       writel(CLK_ALWAYS_ON_NAND | CLK_SELECT_NAND | CLK_ENABLE_VALUE, n=
fc->reg_clk);
> +       writel(0, nfc->reg_base + NFC_REG_CFG);
> +
> +       bus_cfg_val =3D (((bus_cycle - 1) & 31) | ((bus_timing & 31) << 5=
));
> +       writel(bus_cfg_val, nfc->reg_base + NFC_REG_CFG);
> +       writel(BIT(31), nfc->reg_base + NFC_REG_CMD);
> +}
> +

Is not any clock reference implementation from meson paltform? Please
add some more
notes a about those two hard coded value BUS_CYCLE and BUS_TIMING.
Should not depend
on EDO mode of the NAND?

> +static int meson_probe(struct udevice *dev)
> +{
> +       struct meson_nfc *nfc =3D dev_get_priv(dev);
> +       fdt_addr_t addr;
> +       int ret;
> +
> +       addr =3D dev_read_addr(dev);
> +       if (addr =3D=3D FDT_ADDR_T_NONE) {
> +               dev_err(dev, "base register address not found\n");
> +               return -EINVAL;
> +       }

Please use the _ptr variant

> +
> +       nfc->reg_base =3D (void *)addr;
> +
> +       addr =3D dev_read_addr_index(dev, 1);
> +       if (addr =3D=3D FDT_ADDR_T_NONE) {
> +               dev_err(dev, "clk register address not found\n");
> +               return -EINVAL;
> +       }

Ditto

> +
> +       nfc->reg_clk =3D (void *)addr;
> +       nfc->dev =3D dev;
> +
> +       meson_nfc_clk_init(nfc);
> +
> +       ret =3D meson_nfc_nand_chips_init(dev, nfc);
> +       if (ret) {
> +               dev_err(nfc->dev, "failed to init chips\n");
> +               return ret;
> +       }
> +

Michael

> +       return 0;
> +}
> +
> +static const struct udevice_id meson_nand_dt_ids[] =3D {
> +       {.compatible =3D "amlogic,meson-axg-nfc",},
> +       { /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(meson_nand) =3D {
> +       .name =3D "meson_nand",
> +       .id =3D UCLASS_MTD,
> +       .of_match =3D meson_nand_dt_ids,
> +       .probe =3D meson_probe,
> +       .priv_auto =3D sizeof(struct meson_nfc),
> +};
> +
> +void board_nand_init(void)
> +{
> +       struct udevice *dev;
> +       int ret;
> +
> +       ret =3D uclass_get_device_by_driver(UCLASS_MTD,
> +                                         DM_DRIVER_GET(meson_nand), &dev=
);
> +
> +       if (ret && ret !=3D -ENODEV)
> +               pr_err("Failed to initialize: %d\n", ret);
> +}
> --
> 2.35.0
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

