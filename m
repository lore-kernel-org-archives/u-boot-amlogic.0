Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
 by mx.groups.io with SMTP id smtpd.web11.4052.1593659386625889089
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Jul 2020 20:09:46 -0700
Received: by mail-io1-f68.google.com with SMTP id v6so13655767iob.4
        for <u-boot-amlogic@groups.io>; Wed, 01 Jul 2020 20:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVY+9Jr29nwCSjQnqwnsuSeURjDkpQiz/vvZSeMOa0w=;
        b=mSEa5H+7K4f1YwuuEwRShVZ/lxsq1ceUDA59jkGai5ZlWjnBAfPfkmJ9tg0zlUGqRL
         11iBafPZ8aDGRdf/QjaW5TwEany5gwgN2bhMAs7tJOmasQTsu4nbMBWUwF6hoJ+fPylo
         YAthHLMWyAovXBfGDyejGJwoTB6hns1suwSWO9JrvPNcMwMRyupWpTXHdEi20zX9gAvM
         D2kI2Xm/QbzsKBfHD0/ZjQ8gcyhsVZqgjr7ADVdXJV/eJGvbjEzY1bmW+gvI0fMmqrFR
         +MwkyK88lcGBQ4M8qOdDpSDrFhufvBScmDSJk7q+bzFq+NoCkfZsFn/09SXJAgiS4Njz
         BfaQ==
MIME-Version: 1.0
References: <20200701144310.25481-1-narmstrong@baylibre.com> <20200701144310.25481-4-narmstrong@baylibre.com>
In-Reply-To: <20200701144310.25481-4-narmstrong@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 2 Jul 2020 08:39:35 +0530
Message-ID: <CANAwSgSYxYpuH3s561JCdC1uLUxaSYrSkQ=EmFaXarqh4CQPFw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: meson-sm1-odroid-c4: add ethernet PHY reset
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Beniamino Galvani <b.galvani@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Wed, 1 Jul 2020 at 20:13, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The PHY needs a reset in order to be functionnal for U-Boot, add the old
> PHY reset bindings for dwmac until we support the new bindings in the PHY node.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

Please add my
Tested-by: Anand Moon <linux.amoon@gmail.com>

>  arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> index ee32c6f43d..2a8f0545b1 100644
> --- a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> +++ b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> @@ -5,3 +5,9 @@
>   */
>
>  #include "meson-g12-common-u-boot.dtsi"
> +
> +&ethmac {
> +       snps,reset-gpio = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
> +       snps,reset-delays-us = <0 10000 1000000>;
> +       snps,reset-active-low;
> +};
> --
> 2.22.0
>
