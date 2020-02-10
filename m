Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.19250.1581323196211555128
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Feb 2020 00:26:36 -0800
Received: by mail-wr1-f66.google.com with SMTP id w12so6408979wrt.2
        for <u-boot-amlogic@groups.io>; Mon, 10 Feb 2020 00:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/HIw26GcnO/MMl1MFNMevDZqC9/VCak8/7TTyg40cSw=;
        b=mMTKL7pifGheSffsPqR5GNeDwLuvlsWqFBHDQ8eCqzmBoo2QTaC8eMI5NVLLSDbIGO
         ZcCKFhxY/o7wkmWmIkrnK1v1LnD0q7m8LjTsSLsVkbwuG+wzM9DhcZI7lxADv3pBSY9D
         Mnm3rN8+N5tDy74m/xP3qtpW8phWVrUOJdKsOyNrxikFpGdEpQIU2ocM6cV5EXWVknBp
         r5TTC3R5zyd8RPLS8XjEeTk0nNjCrCzE+WbJS1aY1aWNYt0Rn+iWrd5FAuFDWoScBd7g
         I0d6aM4G6SZ6tgvwQpZD+3GhcaZ+gOaZwu+jJB/tsEZKBw2v/pQVQZlnh6FxLhWMz875
         ltuA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCHv6 2/5] mmc: meson-gx: Use proper compatible string as per the dts
References: <20200209110557.1996-1-linux.amoon@gmail.com>
 <20200209110557.1996-3-linux.amoon@gmail.com>
 <420ac33a-7b49-40b9-aa41-aee8f83e49f3@baylibre.com>
 <CANAwSgSFDLdSdW8Dys3wGziMQzw=Rg8jc7uCq129reAQeXhkpQ@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8d983af9-988b-c48e-c507-89240919c29b@baylibre.com>
Date: Mon, 10 Feb 2020 09:26:33 +0100
MIME-Version: 1.0
In-Reply-To: <CANAwSgSFDLdSdW8Dys3wGziMQzw=Rg8jc7uCq129reAQeXhkpQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Anand Moon <linux.amoon@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

On 09/02/2020 18:23, Anand Moon wrote:
> Hi Neil
> 
> Thanks for your review comments.
> 
> On Sun, 9 Feb 2020 at 18:31, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi,
>>
>> Le 09/02/2020 à 12:05, Anand Moon a écrit :
>>> Use proper compatible string as per the dts so that mmc driver
>>> could be tuned properly. SoC family S905, S905X have common clk
>>> tuning parameters setting, while AGX and G12 have common clk tuning
>>> parameters setting for mmc driver.
>>>
>>> Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>> No changes.
>>> ---
>>>  arch/arm/include/asm/arch-meson/sd_emmc.h |  7 ++++
>>>  drivers/mmc/meson_gx_mmc.c                | 46 +++++++++++++++++------
>>>  2 files changed, 41 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
>>> index f4299485dc..83142d5d3f 100644
>>> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
>>> +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
>>> @@ -13,6 +13,12 @@
>>>  #define SDIO_PORT_B                  1
>>>  #define SDIO_PORT_C                  2
>>>
>>> +enum mmc_compatible {
>>> +        MMC_COMPATIBLE_GXBB,
>>> +        MMC_COMPATIBLE_GX,
>>> +        MMC_COMPATIBLE_AXG,
>>> +};
>>> +
>>>  #define SD_EMMC_CLKSRC_24M           24000000        /* 24 MHz */
>>>  #define SD_EMMC_CLKSRC_DIV2          1000000000      /* 1 GHz */
>>>
>>> @@ -87,6 +93,7 @@
>>>  struct meson_mmc_platdata {
>>>       struct mmc_config cfg;
>>>       struct mmc mmc;
>>> +     int compat;
>>>       void *regbase;
>>>       void *w_buf;
>>>  };
>>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
>>> index b013c7c5fb..1aefe360c4 100644
>>> --- a/drivers/mmc/meson_gx_mmc.c
>>> +++ b/drivers/mmc/meson_gx_mmc.c
>>> @@ -37,7 +37,8 @@ static inline void meson_write(struct mmc *mmc, uint32_t val, int offset)
>>>       writel(val, get_regbase(mmc) + offset);
>>>  }
>>>
>>> -static void meson_mmc_config_clock(struct mmc *mmc)
>>> +static void meson_mmc_config_clock(struct mmc *mmc,
>>> +                                struct meson_mmc_platdata *pdata)
>>>  {
>>>       uint32_t meson_mmc_clk = 0;
>>>       unsigned int clk, clk_src, clk_div;
>>> @@ -66,14 +67,20 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>>>       /* RX clock phase 0:180 */
>>>       meson_mmc_clk |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
>>>
>>> -#ifdef CONFIG_MESON_GX
>>> -     /* clk always on */
>>> -     meson_mmc_clk |= CLK_V2_ALWAYS_ON;
>>> -#endif
>>> -#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
>>> -     /* clk always on */
>>> -     meson_mmc_clk |= CLK_V3_ALWAYS_ON;
>>> -#endif
>>> +     switch (pdata->compat) {
>>> +     case MMC_COMPATIBLE_GXBB:
>>> +     case MMC_COMPATIBLE_GX:
>>> +             /* clk always on */
>>> +             meson_mmc_clk |= CLK_V2_ALWAYS_ON;
>>> +             break;
>>> +     case MMC_COMPATIBLE_AXG:
>>> +             /* clk always on */
>>> +             meson_mmc_clk |= CLK_V3_ALWAYS_ON;
>>> +             break;
>>> +     default:
>>> +             debug("no compatible supported");
>>> +             break;
>>> +     }
>>>
>>>       /* clock settings */
>>>       meson_mmc_clk |= clk_src;
>>> @@ -85,9 +92,11 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>>>  static int meson_dm_mmc_set_ios(struct udevice *dev)
>>>  {
>>>       struct mmc *mmc = mmc_get_mmc_dev(dev);
>>> +     struct meson_mmc_platdata *pdata =
>>> +             (struct meson_mmc_platdata *)dev_get_driver_data(dev);
>>>       uint32_t meson_mmc_cfg;
>>>
>>> -     meson_mmc_config_clock(mmc);
>>> +     meson_mmc_config_clock(mmc, pdata);
>>>
>>>       meson_mmc_cfg = meson_read(mmc, MESON_SD_EMMC_CFG);
>>>
>>> @@ -324,9 +333,22 @@ int meson_mmc_bind(struct udevice *dev)
>>>       return mmc_bind(dev, &pdata->mmc, &pdata->cfg);
>>>  }
>>>
>>> +static const struct meson_mmc_platdata gxbb_data = {
>>> +        .compat = MMC_COMPATIBLE_GXBB,
>>> +};
>>> +
>>> +static const struct meson_mmc_platdata gx_data = {
>>> +        .compat = MMC_COMPATIBLE_GX,
>>> +};
>>> +
>>> +static const struct meson_mmc_platdata axg_data = {
>>> +        .compat = MMC_COMPATIBLE_AXG,
>>> +};
>>> +a in 
>>>  static const struct udevice_id meson_mmc_match[] = {
>>> -     { .compatible = "amlogic,meson-gx-mmc" },
>>> -     { .compatible = "amlogic,meson-axg-mmc" },
>>> +     { .compatible = "amlogic,meson-gxbb-mmc", .data = (ulong)&gxbb_data },
>>> +     { .compatible = "amlogic,meson-gx-mmc", .data = (ulong)&gx_data },
>>> +     { .compatible = "amlogic,meson-axg-mmc", .data = (ulong)&axg_data },
>>>       { /* sentinel */ }
>>>  };
>>>
>>>
>>
>>
>> It's fine but you should do that before patch 1, and introduce the clk setup directly with the MMC_COMPATIBLE_*.
>>
> 
> Only GXBB and GLX have  CLK_ALWAYS_ON(24) bit set
> and AXG and G12X  have CLK_ALWAYS_ON(28) bit set
> for clk enable rest of the configuration is all most common for all the SoC.
> let keep this simple as of now.

It's not the point, just add the "struct meson_mmc_platdata" and .data in meson_mmc_match
_before_ patch 1, to avoid adding hideous #ifdef/#elif/#endif in the meantime.

Neil


> 
> 
>> If you move it before, then:
>>
>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> Neil
> 
> -Anand
> 

