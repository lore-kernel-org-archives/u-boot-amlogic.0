Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web12.19513.1581325424452884773
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Feb 2020 01:03:44 -0800
Received: by mail-wm1-f66.google.com with SMTP id m10so7931803wmc.0
        for <u-boot-amlogic@groups.io>; Mon, 10 Feb 2020 01:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wx/HYmHk0O7wFfhooWumohU2yr6lcv+adHPN1U5wi+4=;
        b=OFWZbUR3w3TkmwFO4x6wC/gVthUQ/wDwgONRA6TnZPn+Y61FTA3xFyJIXu5mlUrf3k
         tZo3PXN3Fm23u6E2ecqH918JEHEnGnSLOpCFtj/WMRGTyHXRXu0bfGMgrGyZgKUKk1ap
         emGzK4qqvz70rhfTOHHkWc3S2+G5J7NFr+laEnMt/zLyADClQnwomqbH7DJxIn+4OjyF
         dOYeqCa64qcawZlat9C7AOFVSeYQ8oOQnXnQdmVBQiVwNeKcAAp2mW/Nn5CXLbudeatL
         jF8JzpIfXy1+H8Z+18EbHTgmiRlwiuTHTFKQKACGflLDu5wrGmdqy1yyHlIeN9s3rZj0
         nLmQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCHv6 1/5] mmc: meson-gx: Fix clk phase tuning for MMC
References: <20200209110557.1996-1-linux.amoon@gmail.com>
 <20200209110557.1996-2-linux.amoon@gmail.com>
 <61096502-4817-a095-4d11-b487781202b0@baylibre.com>
 <CANAwSgT7SyqgwWE9SEvLYasW-qzfCYHSJrFfeCNt2dv0XxVsiA@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <62098468-c490-6dfc-c627-02de6084c50c@baylibre.com>
Date: Mon, 10 Feb 2020 10:03:41 +0100
MIME-Version: 1.0
In-Reply-To: <CANAwSgT7SyqgwWE9SEvLYasW-qzfCYHSJrFfeCNt2dv0XxVsiA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Anand Moon <linux.amoon@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

On 09/02/2020 18:22, Anand Moon wrote:
> Hi Neil,
> 
> Thanks for you review comments.
> 
> On Sun, 9 Feb 2020 at 18:38, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi,
>>
>> Le 09/02/2020 à 12:05, Anand Moon a écrit :
>>> As per mainline line kernel fix the clk tuning phase for mmc,
>>> set Core=180, Tx=0, Rx=0 clk phase for mmc initialization.
>>> As per S905, S905X, AGX and S922X datasheet set the default
>>> values for clk tuning.
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>> Changes from previous
>>> v5  Fix the commit message, configure as per mainline kernel.
>>>     drop the RX_DELAY_MASK and TX_DELAY_MASK as they are not used.
>>>
>>> v4  Fix the update mask value using FIELD_PREP macro.
>>>
>>> v3  Fix the initialization of core clk tunning phase as per datasheet.
>>>     Fix the commit message.
>>>
>>> v2: Fix the clk phase macro to support PHASE_180
>>>     drop the wrong CLK_CORE_PHASE_MASK macro.
>>>
>>> v1: use the mainline kernel tuning for clk tuning.
>>>
>>> Fixed the commmit messages.
>>> Patch v1:
>>> https://patchwork.ozlabs.org/patch/1201208/
>>>
>>> Before these changes.
>>>     clock is enabled (380953Hz)
>>>     clock is enabled (25000000Hz)
>>> After these changes
>>>     clock is enabled (380953Hz)
>>>     clock is enabled (25000000Hz)
>>>     clock is enabled (52000000Hz)
>>> Test on Odroid N2 and Odroid C2 with eMMC and microSD cards
>>> ---
>>>  arch/arm/include/asm/arch-meson/sd_emmc.h | 24 +++++++++++--------
>>>  drivers/mmc/meson_gx_mmc.c                | 28 +++++++++++++++++++----
>>>  2 files changed, 38 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include/asm/arch-meson/sd_emmc.h
>>> index e3a72c8b66..f4299485dc 100644
>>> --- a/arch/arm/include/asm/arch-meson/sd_emmc.h
>>> +++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
>>> @@ -7,6 +7,7 @@
>>>  #define __SD_EMMC_H__
>>>
>>>  #include <mmc.h>
>>> +#include <linux/bitops.h>
>>>
>>>  #define SDIO_PORT_A                  0
>>>  #define SDIO_PORT_B                  1
>>> @@ -19,15 +20,20 @@
>>>  #define   CLK_MAX_DIV                        63
>>>  #define   CLK_SRC_24M                        (0 << 6)
>>>  #define   CLK_SRC_DIV2                       (1 << 6)
>>> -#define   CLK_CO_PHASE_000           (0 << 8)
>>> -#define   CLK_CO_PHASE_090           (1 << 8)
>>> -#define   CLK_CO_PHASE_180           (2 << 8)
>>> -#define   CLK_CO_PHASE_270           (3 << 8)
>>> -#define   CLK_TX_PHASE_000           (0 << 10)
>>> -#define   CLK_TX_PHASE_090           (1 << 10)
>>> -#define   CLK_TX_PHASE_180           (2 << 10)
>>> -#define   CLK_TX_PHASE_270           (3 << 10)
>>> -#define   CLK_ALWAYS_ON                      BIT(24)
>>> +
>>> +#define   CRYSTAL_24MHZ                      0
>>> +#define   CLK_PHASE_0                        0
>>> +#define   CLK_PHASE_180                      2
>>> +
>>> +#define   CLK_DIV_MASK                       GENMASK(5, 0)
>>> +#define   CLK_SRC_MASK                       GENMASK(7, 6)
>>> +#define   CLK_CORE_PHASE_MASK                GENMASK(9, 8)
>>> +#define   CLK_TX_PHASE_MASK          GENMASK(11, 10)
>>> +#define   CLK_RX_PHASE_MASK          GENMASK(13, 12)
>>> +
>>> +#define   CLK_V2_ALWAYS_ON           BIT(24)
>>> +
>>> +#define   CLK_V3_ALWAYS_ON           BIT(28)
>>>
>>>  #define MESON_SD_EMMC_CFG            0x44
>>>  #define   CFG_BUS_WIDTH_MASK         GENMASK(1, 0)
>>> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
>>> index 86c1a7164a..b013c7c5fb 100644
>>> --- a/drivers/mmc/meson_gx_mmc.c
>>> +++ b/drivers/mmc/meson_gx_mmc.c
>>> @@ -16,6 +16,10 @@
>>>  #include <asm/arch/sd_emmc.h>
>>>  #include <linux/log2.h>
>>>
>>> +#include <linux/bitops.h>
>>> +#include <linux/compat.h>
>>> +#include <linux/bitfield.h>
>>> +
>>>  static inline void *get_regbase(const struct mmc *mmc)
>>>  {
>>>       struct meson_mmc_platdata *pdata = mmc->priv;
>>> @@ -51,11 +55,25 @@ static void meson_mmc_config_clock(struct mmc *mmc)
>>>       }
>>>       clk_div = DIV_ROUND_UP(clk, mmc->clock);
>>>
>>> -     /* 180 phase core clock */
>>> -     meson_mmc_clk |= CLK_CO_PHASE_180;
>>> -
>>> -     /* 180 phase tx clock */
>>> -     meson_mmc_clk |= CLK_TX_PHASE_000;
>>> +     /* Clock divider */
>>> +     meson_mmc_clk |= CLK_DIV_MASK;
>>
>> This will set the max divider, whatever the value of clk_div, so the following statement:
>> meson_mmc_clk |= clk_div;
>> will have no effect.
> 
> As per the datasheet S905 and S922X max divider is 63.
> CLK_DIV_MASK[0-5]      Cfg_div: Clock divider
>                                         Frequency = clock source/cfg_div
>                                         Clock off: cfg_div==0, the
> clock is disabled
>                                         Divider bypass: cfg_div==1,
> clock source is used as core clock without divider
>                                         Maximum divider 63
> 
> So here is the log of clk_div and clk_freq at my end.
> 
> MMC Device 0 not found
> no mmc device at slot 0
> clock is disabled (0Hz)
> clock is enabled (380953Hz)
> ......clk_div : 63
> Card did not respond to voltage select!
> clock is disabled (0Hz)
> clock is enabled (380953Hz)
> ......clk_div : 63
> clock is enabled (25000000Hz)
> ......clk_div : 40
> ......clk_div : 40
> clock is enabled (52000000Hz)
> ......clk_div : 20
> switch to partitions #0, OK
> mmc2(part 0) is current device
> Scanning mmc 2:1...
> Found U-Boot script /boot/boot.scr


OK, seems you didn't see the issue.

With the original code, let's say mmc->clock = 25000000

clk = SD_EMMC_CLKSRC_DIV2
clk_src = CLK_SRC_DIV2
clk_div = 40

meson_mmc_clk |= CLK_CO_PHASE_180;
meson_mmc_clk |= CLK_TX_PHASE_000;
meson_mmc_clk |= CLK_SRC_DIV2;
meson_mmc_clk |= 40;

=> meson_mmc_clk = (2 << 8) | (0 << 10) | (1 << 6) | 40
=> meson_mmc_clk = 0x268

With your code :
meson_mmc_clk |= CLK_DIV_MASK;
meson_mmc_clk |= FIELD_PREP(CLK_SRC_MASK, CRYSTAL_24MHZ);
meson_mmc_clk |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
meson_mmc_clk |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
meson_mmc_clk |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
meson_mmc_clk |= CLK_SRC_DIV2;
meson_mmc_clk |= 40;

=> meson_mmc_clk = 0x3f | (0 << 6) | (2 << 8) | (0 << 11) | (0 << 13) | (1 << 6) | 40

-------------------/\---this---------makes-------this-----useless------------------/\

=> 0x27f

It sets the clock to 15873015Hz instead of the 25000000Hz requested.

so this code sets max divider whatever mmc->clock value, but keeps the CRYSTAL_24MHZ/CLK_SRC_DIV2 selection.

> 
>>
>>
>>> +     /* Clock source : Crystal 24MHz */
>>> +     meson_mmc_clk |= FIELD_PREP(CLK_SRC_MASK, CRYSTAL_24MHZ);
>>
>> You set CRYSTAL_24MHZ here, but the src is selected in clk_src and set with:
>> meson_mmc_clk |= clk_src;
>>
>> In conclusion your change forces the 24MHz crystal and max divider whatever the
>> freq asked by the mmc core !
>>
> As per the datasheet S905 and S922X
> Cfg_src:             Clock source
>                           0: Crystal 24MHz or other frequencies
> selected by clock reset test control register.
>                           1: Fix PLL, 1000MHz
>                           Recommended value: 1
> 
> Note: *setting cfg_src value to I       i.e; Fix PLL 1000 Mhz *
> some how break the clk_freq tuning setting in my testing,
> see the logs below.
> 
> MMC Device 0 not found
> no mmc device at slot 0
> clock is disabled (0Hz)
> clock is enabled (380953Hz)
> ......clk_div : 63
> Card did not respond to voltage select!
> clock is disabled (0Hz)
> clock is enabled (380953Hz)
> ......clk_div : 63
> starting USB...
> 
> No emmc will get discovered,
> *This is the real issue I faced for failure of eMMC not getting detected.*

This is the issue I get on SM1, but when I cap the max freq to 24MHz, it disappears.

This issue is somewhere else, but I don't know where because the Linux driver behaves
correctly with the same setup.

My fix was to always use the 24MHz crystal input on non-GX until we find out why, and it still acceptable.

Could you post instead :
- your patch 2 introducing the MMC_COMPATIBLE_* as patch 1
- this patch but only forcing 24MHz for MMC_COMPATIBLE_AXG as patch 2
- redude patches 3,4 & 5 to only add mmc* aliases into meson-gx-u-boot.dtsi/meson-g12-common-u-boot.dtsi

If you have a issue, please chat with me on #linux-amlogic on freenode.

Thanks,
Neil

> 
>>> +     /* Core clock phase 2:180 */
>>> +     meson_mmc_clk |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
>>> +     /* TX clock phase 0:180 */
>>> +     meson_mmc_clk |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
>>> +     /* RX clock phase 0:180 */
>>> +     meson_mmc_clk |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
>>
>> These are ok, but it's exactly the same as before with a different style.
>>
>>> +
>>> +#ifdef CONFIG_MESON_GX
>>> +     /* clk always on */
>>> +     meson_mmc_clk |= CLK_V2_ALWAYS_ON;
>>> +#endif
>>> +#if (defined(CONFIG_MESON_AXG) || defined(CONFIG_MESON_G12A))
>>> +     /* clk always on */
>>> +     meson_mmc_clk |= CLK_V3_ALWAYS_ON;
>>> +#endif
>>
>> Why not, not sure about the effect.
> 
> Ok, I will changes these to  FIELD_PREP for consultancy.

Really not sure about the effect of these, please drop these until we find out
if we really need these.

> 
>>
>>>
>>>       /* clock settings */
>>>       meson_mmc_clk |= clk_src;
>>>
>>
>> Neil
> 
> -Anand
> 

