Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5577EC5B55E
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:35 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.51827.1724675611926541824
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Aug 2024 05:33:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=OfeBpsOZ;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C6403100009;
	Mon, 26 Aug 2024 15:33:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C6403100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1724675608;
	bh=Ydm1WB1xgNCDLvn7DGbP4Mj9EyUVvzYyiTlNe/DLzkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=OfeBpsOZFxZPl16RIbxgnS824a/XMhc0rd00bAFB9azLh3EzKWqYV4ILM1rx+N2SY
	 ObkkJPK7DpoNjv/dWd9gk36NjCEhTM925AA09MAtnTwydXOPKWH4fPLRIHzDoZnS0I
	 7QlulEBJ7PbAL3x63gAehrqxfN2Fd/VAl85NzVmTt1uZWRGk31GLZys35bUr9bjR0+
	 EB9GOn7+lU/mF8A/cWFBZZARlop5rXc3s4O2eBHBwc9Ekjs40+G0XU0tX0E/fdb+fV
	 i7nV8QpZIZ2mWWrDZ9JtHFv259/Tpd+KuiJPDZNttFo3qjX8BxbwFO9OIkzVvHEnQI
	 GkNy24oiQb4vA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 26 Aug 2024 15:33:28 +0300 (MSK)
Message-ID: <238509bc-1174-c042-7493-4c579fb3c1a0@salutedevices.com>
Date: Mon, 26 Aug 2024 15:20:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/3] mtd: rawnand: meson: read/write access for boot ROM pages
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, "Tom
 Rini" <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
	<u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, <kernel@sberdevices.ru>,
	<oxffffaa@gmail.com>
References: <20240826060411.3532105-1-avkrasnov@salutedevices.com>
 <20240826060411.3532105-4-avkrasnov@salutedevices.com>
 <CAOf5uw=UuB1YandpEziF1gp3Amh1J9fk15YCM7J4FZW6zoq7GA@mail.gmail.com>
 <6f361799-2cd2-9573-cb53-82b22ca56c06@salutedevices.com>
 <CAOf5uw=2T7VLdKA+45LedRDvPN29Sv73C8P1NEeB+BRKA=exQg@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CAOf5uw=2T7VLdKA+45LedRDvPN29Sv73C8P1NEeB+BRKA=exQg@mail.gmail.com>
X-Originating-IP: [172.28.225.232]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187315 [Aug 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/08/26 08:14:00 #26435425
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 14:03:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2379



On 26.08.2024 13:42, Michael Nazzareno Trimarchi wrote:
> Hi
>=20
> On Mon, Aug 26, 2024 at 11:00=E2=80=AFAM Arseniy Krasnov
> <avkrasnov@salutedevices.com> wrote:
>>
>>
>>
>> On 26.08.2024 10:16, Michael Nazzareno Trimarchi wrote:
>>> Hi
>>>
>>> On Mon, Aug 26, 2024 at 8:17=E2=80=AFAM Arseniy Krasnov
>>> <avkrasnov@salutedevices.com> wrote:
>>>>
>>>> Boot ROM on Meson needs some pages to be read/written in a special mod=
e:
>>>> 384 byte ECC mode (so called "short" by Amlogic) and with scrambling
>>>> enabled. Such pages are located on the chip in the following way (for
>>>> example):
>>>>
>>>> [ p0 ][ p1 ][ p2 ][ p3 ][ p4 ][ p5 ][ p6 ][ p7 ] ... [ pN ]
>>>>   ^           ^           ^           ^
>>>>
>>>> pX is page number "X". "^" means "special" page used by boot ROM - e.g=
.
>>>> every 2nd page in the range of [0, 7]. Step (2 here) and last page in
>>>> range is read from the device tree.
>>>>
>>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>>> ---
>>>>  drivers/mtd/nand/raw/meson_nand.c | 56 +++++++++++++++++++++++++-----=
-
>>>>  1 file changed, 46 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/=
meson_nand.c
>>>> index 19f005202b..54ea035d8d 100644
>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>> @@ -40,6 +40,7 @@
>>>>  #define NFC_CMD_RB                     BIT(20)
>>>>  #define NFC_CMD_SCRAMBLER_ENABLE       BIT(19)
>>>>  #define NFC_CMD_SCRAMBLER_DISABLE      0
>>>> +#define NFC_CMD_SHORTMODE_ENABLE       1
>>>>  #define NFC_CMD_SHORTMODE_DISABLE      0
>>>>  #define NFC_CMD_RB_INT                 BIT(14)
>>>>  #define NFC_CMD_RB_INT_NO_PIN          ((0xb << 10) | BIT(18) | BIT(1=
6))
>>>> @@ -78,6 +79,8 @@
>>>>
>>>>  #define DMA_DIR(dir)           ((dir) ? NFC_CMD_N2M : NFC_CMD_M2N)
>>>>
>>>> +#define NFC_SHORT_MODE_ECC_SZ  384
>>>> +
>>>>  #define ECC_CHECK_RETURN_FF    -1
>>>>
>>>>  #define NAND_CE0               (0xe << 10)
>>>> @@ -141,6 +144,8 @@
>>>>  struct meson_nfc_nand_chip {
>>>>         struct list_head node;
>>>>         struct nand_chip nand;
>>>> +       u32 boot_pages;
>>>> +       u32 boot_page_step;
>>>>
>>>>         u32 bch_mode;
>>>>         u8 *data_buf;
>>>> @@ -229,33 +234,46 @@ static void meson_nfc_cmd_seed(const struct meso=
n_nfc *nfc, u32 seed)
>>>>                nfc->reg_base + NFC_REG_CMD);
>>>>  }
>>>>
>>>> +static int meson_nfc_is_boot_page(struct nand_chip *nand, int page)
>>>> +{
>>>> +       const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand=
(nand);
>>>> +
>>>> +       return (nand->options & NAND_IS_BOOT_MEDIUM) &&
>>>> +              !(page % meson_chip->boot_page_step) &&
>>>> +              (page < meson_chip->boot_pages);
>>>> +}
>>>> +
>>>>  static void meson_nfc_cmd_access(struct nand_chip *nand, bool raw, bo=
ol dir, int page)
>>>>  {
>>>> +       const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand=
(nand);
>>>>         struct mtd_info *mtd =3D nand_to_mtd(nand);
>>>>         const struct meson_nfc *nfc =3D nand_get_controller_data(mtd_t=
o_nand(mtd));
>>>> -       const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand=
(nand);
>>>> -       u32 bch =3D meson_chip->bch_mode, cmd;
>>>>         int len =3D mtd->writesize, pagesize, pages;
>>>>         int scrambler;
>>>> +       u32 cmd;
>>>>
>>>>         if (nand->options & NAND_NEED_SCRAMBLING)
>>>>                 scrambler =3D NFC_CMD_SCRAMBLER_ENABLE;
>>>>         else
>>>>                 scrambler =3D NFC_CMD_SCRAMBLER_DISABLE;
>>>>
>>>
>>> scrambler depends on NAND_NEED_SCRAMBLING so suppose
>>> that is not set
>>>
>>> scrambler =3D NAND_NEED_SCRAMBLING;
>>>
>>>> -       pagesize =3D nand->ecc.size;
>>>> -
>>>>         if (raw) {
>>>>                 len =3D mtd->writesize + mtd->oobsize;
>>>>                 cmd =3D len | scrambler | DMA_DIR(dir);
>>>> -               writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>> -               return;
>>>> -       }
>>>> +       } else if (meson_nfc_is_boot_page(nand, page)) {
>>>
>>> Now here you  seems that you don't care anymore about this option and c=
heck
>>> only meson_nfc_is_boot_page
>>>
>>> Is something am I missing?
>>
>> Idea is the following IIUC: such boot pages could be read in ECC mode on=
ly with enabled scrambling -
>> otherwise we get ECC error. Or we need to read it in raw mode. So:
>>
>> if (read page in raw mode) {
>>     use scrambler as provided
>> } else if (read boot page in ECC mode) {
>>     force scrambling mode + NFC_ECC_BCH8_1K + NFC_CMD_SHORTMODE_ENABLE
>> } else {
>>     //we read non-boot page in ECC mode
>>    use scrambler as provided
>> }
>>
>> Thanks
>>
>>
>>>
>>> Michael
>>>
>>>> +               pagesize =3D NFC_SHORT_MODE_ECC_SZ >> 3;
>>>> +               pages =3D mtd->writesize / 512;
>>>>
>>>> -       pages =3D len / nand->ecc.size;
>>>> +               scrambler =3D NFC_CMD_SCRAMBLER_ENABLE;
>>>> +               cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, NFC_ECC_BCH8=
_1K,
>>>> +                              NFC_CMD_SHORTMODE_ENABLE, pagesize, pag=
es);
>>>> +       } else {
>>>> +               pagesize =3D nand->ecc.size >> 3;
>>>> +               pages =3D len / nand->ecc.size;
>>>>
>>>> -       cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, bch,
>>>> -                      NFC_CMD_SHORTMODE_DISABLE, pagesize, pages);
>>>> +               cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, meson_chip->=
bch_mode,
>>>> +                              NFC_CMD_SHORTMODE_DISABLE, pagesize, pa=
ges);
>>>> +       }
>>>>
>>>>         if (scrambler =3D=3D NFC_CMD_SCRAMBLER_ENABLE)
>>>>                 meson_nfc_cmd_seed(nfc, page);
>>>> @@ -1132,6 +1150,24 @@ static int meson_nfc_nand_chip_init(struct udev=
ice *dev, struct meson_nfc *nfc,
>>>>                 goto err_chip_buf_free;
>>>>         }
>>>>
>>>> +       if (nand->options & NAND_IS_BOOT_MEDIUM) {
>>>> +               ret =3D ofnode_read_u32(node, "amlogic,boot-pages",
>>>> +                                     &meson_chip->boot_pages);
>>>> +               if (ret) {
>>>> +                       dev_err(dev, "could not retrieve 'amlogic,boot=
-pages' property: %d",
>>>> +                               ret);
>>>> +                       goto err_chip_buf_free;
>>>> +               }
>>>> +
>>>> +               ret =3D ofnode_read_u32(node, "amlogic,boot-page-step"=
,
>>>> +                                     &meson_chip->boot_page_step);
>>>> +               if (ret) {
>>>> +                       dev_err(dev, "could not retrieve 'amlogic,boot=
-page-step' property: %d",
>>>> +                               ret);
>>>> +                       goto err_chip_buf_free;
>>>> +               }
>>>> +       }
>>>> +
>>>>         ret =3D nand_register(0, mtd);
>>>>         if (ret) {
>>>>                 dev_err(dev, "'nand_register()' failed: %d\n", ret);
>>>> --
>>>> 2.30.1
>>>>
>>>
>>>
>=20
> The first patch seems not apply clean to me on master
>=20
> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

Got it, I'll check

Thanks

>=20
>=20
>=20

