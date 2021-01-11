Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.34506.1610374648619191045
 for <u-boot-amlogic@groups.io>;
 Mon, 11 Jan 2021 06:17:29 -0800
Received: by mail-wr1-f49.google.com with SMTP id t16so16628465wra.3
        for <u-boot-amlogic@groups.io>; Mon, 11 Jan 2021 06:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AkfpcWijWwqeeOA7igXZCFWjOa3St9nSluce+4GfCmI=;
        b=kDd1K/xqYBZGWjO92WNcUmLZeuB8kdHY7RaAagk5QOsl0gzmxnzYfh6GY/TxebYP4b
         GL0Kf9pWXgG9cVUvJB43WyITAtIh0kPgG1VrKTEzobYBwJyc2zHbTj0Wb5Rpgz0nb67v
         uszDuOf9zWiShognbOvx8fYSAUwm/gDLwQ+yR/4ObLN4OwkY57c2OZcU+Qx+iY163B9f
         wnLrtM7eM/tONl3A78Q06+devAeGuTROgEYQQc6rxGR/gDM5uIbPehOF7JW/NsPNJrwb
         C2IWV+ZkcoWJKpbPGCiZdoueSS7X7MhlXhmwLYd/XYYxjkv0vr5tUvSZDtP5b3MmqzWl
         r4zw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: vim3: setup ethernet mac from efuse
References: <20210111111929.504886-1-art@khadas.com>
 <406660b1-89fd-e402-6e8d-aa358acce96c@baylibre.com>
 <CAKaHn9+GDOaWFEsJBvZBF8oUc-3O99m2gBtc4bv=-rUMTBtFag@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <bc832ddc-a687-116d-4cf2-e8cf4e393758@baylibre.com>
Date: Mon, 11 Jan 2021 15:17:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAKaHn9+GDOaWFEsJBvZBF8oUc-3O99m2gBtc4bv=-rUMTBtFag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Art Nikpal <email2tema@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, khilman@baylibre.com, Christian Hewitt <christianshewitt@gmail.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, m.szyprowski@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>, Artem Lapkin <art@khadas.com>, nick@khadas.com, Gouwa Wang <gouwa@khadas.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 11/01/2021 15:15, Art Nikpal wrote:
>> So the patch from Marek (https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.szyprowski@samsung.com/) doesn't work ?
> yes doesnt works properly im sure if we read as raw 6 bytes from efuse we have
> 
> if (is_valid_ethaddr(mac_addr)) # is always not valid
> eth_env_set_enetaddr("ethaddr", mac_addr);
> else    # and always generated from serial 
> meson_generate_serial_ethaddr();
> 
>> Are you sure the MAC is stored in ASCII like Odroid-N2 ?
> yes im check two times on my vim3 vim3l boards and our amlogic vendor uboot have same method

OK, can you send a patch over the https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/-/tree/u-boot-amlogic-next branch ?

Neil

> 
> On Mon, Jan 11, 2021 at 9:59 PM Neil Armstrong <narmstrong@baylibre.com <mailto:narmstrong@baylibre.com>> wrote:
> 
>     Hi Artem,
> 
>     On 11/01/2021 12:19, Artem Lapkin wrote:
>     > Add the board specific code for reading built-in ethernet MAC address from efuse
>     >
>     > NOTE: MAC is stored in ASCII format, 1bytes = 2characters by 0 offset
>     >
>     > if mac from efuse not valid we use meson_generate_serial_ethaddr
>     >
>     > NOTE: remake odroid-n2.c variant from Neil Armstrong <narmstrong@baylibre.com <mailto:narmstrong@baylibre.com>>
> 
>     So the patch from Marek (https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.szyprowski@samsung.com/) doesn't work ?
>     Are you sure the MAC is stored in ASCII like Odroid-N2 ?
> 
>     Please look at my u-boot-amlogic-next tree I will push this week for the next u-boot release:
>     https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/-/tree/u-boot-amlogic-next
> 
>     Neil
> 
>     >
>     > Signed-off-by: Artem Lapkin <art@khadas.com <mailto:art@khadas.com>>
>     > ---
>     >  board/amlogic/vim3/vim3.c | 35 +++++++++++++++++++++++++++++++++++
>     >  1 file changed, 35 insertions(+)
>     >
>     > diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
>     > index 09ef39ff30..c5d19cc17b 100644
>     > --- a/board/amlogic/vim3/vim3.c
>     > +++ b/board/amlogic/vim3/vim3.c
>     > @@ -11,9 +11,14 @@
>     >  #include <net.h>
>     >  #include <asm/io.h>
>     >  #include <asm/arch/eth.h>
>     > +#include <asm/arch/sm.h>
>     >  #include <i2c.h>
>     >  #include "khadas-mcu.h"
>     > 
>     > +#define EFUSE_MAC_OFFSET     0
>     > +#define EFUSE_MAC_SIZE               12
>     > +#define MAC_ADDR_LEN         6
>     > +
>     >  /*
>     >   * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
>     >   * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
>     > @@ -131,7 +136,37 @@ int meson_ft_board_setup(void *blob, struct bd_info *bd)
>     > 
>     >  int misc_init_r(void)
>     >  {
>     > +     u8 mac_addr[MAC_ADDR_LEN];
>     > +     char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
>     > +     ssize_t len;
>     > +
>     >       meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
>     > 
>     > +     if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
>     > +
>     > +             len = meson_sm_read_efuse(EFUSE_MAC_OFFSET, efuse_mac_addr, EFUSE_MAC_SIZE);
>     > +             if (len != EFUSE_MAC_SIZE)
>     > +                     return 0;
>     > +
>     > +             /* MAC is stored in ASCII format, 1bytes = 2characters */
>     > +             for (int i = 0; i < 6; i++) {
>     > +                     tmp[0] = efuse_mac_addr[i * 2];
>     > +                     tmp[1] = efuse_mac_addr[i * 2 + 1];
>     > +                     tmp[2] = '\0';
>     > +                     mac_addr[i] = simple_strtoul(tmp, NULL, 16);
>     > +             }
>     > +
>     > +             if (is_valid_ethaddr(mac_addr))
>     > +                     eth_env_set_enetaddr("ethaddr", mac_addr);
>     > +             else
>     > +                     meson_generate_serial_ethaddr();
>     > +
>     > +             eth_env_get_enetaddr("ethaddr", mac_addr);
>     > +             printf("[i] setup onboard mac %02X:%02X:%02X:%02X:%02X:%02X\n",
>     > +                     mac_addr[0],mac_addr[1],mac_addr[2],
>     > +                     mac_addr[3],mac_addr[4],mac_addr[5]);
>     > +
>     > +     }
>     > +
>     >       return 0;
>     >  }
>     >
> 

