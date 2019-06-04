Received: by mail-wm1-f65.google.com with SMTP id v19so2523413wmh.0
        for <u-boot-amlogic@groups.io>; Tue, 04 Jun 2019 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RD2Ni9dELCPccuCcFc7XmweV9vEif+RBz/BvvOVY9uQ=;
        b=Ocp//6NnbIVjsLznpmrgBTPB/KW48bRcuLtpheHKXw4zMZ1Gh3VnuGAxsf5u9UGl0v
         SIQIqzI69/X7g8QsLfulWIhXHac+2BuxOAhrPHXeKp6q3kJh4IkfbSZSZPFSxEGFsBl2
         79/JBHjh9cwVWr54mOclIML7Gp586QNoptR50U4OGa0x2+JPxWoehnYRqi6hcYbv60l3
         bAyR0ZkK/sKc41kzFtEPkA6NZZrENWMI4UOwWhPJcoBzw/flLpsV649RDG2EMoW6IFt0
         vp68SIbiFlZmdqcXxT6UD+RmjWGVqrcQ+rnibTgZlBlM9Fm1a/qJLnTmDy1TR4VWX9v9
         28Hw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/3] Add drive-strength-microamp in Meson pinctrl driver
References: <20190604115308.26510-1-glaroque@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <6f031055-7264-1ed0-868a-2292ef1921fe@baylibre.com>
Date: Tue, 4 Jun 2019 17:19:36 +0200
MIME-Version: 1.0
In-Reply-To: <20190604115308.26510-1-glaroque@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi Guillaume,

On 04/06/2019 13:53, Guillaume La Roque wrote:
> The purpose of this patchset is to add drive-strength-microamp support in meson pinconf
> driver. This is a new feature that was added on the g12a. It is critical for us
> to support this since many functions are failing with default pad drive-strength.
> 
> The value achievable by the SoC are 500uA, 2500uA, 3000uA and 4000uA and the DT property
> 'drive-strength-microamp' is expressed in uA.
> So this patch add another generic property "drive-strength-microamp". The change to do so
> would be minimal and could be benefit to other platforms later on.
> 
> it's backport from linux :
> https://lore.kernel.org/lkml/20190514082652.20686-1-glaroque@baylibre.com/
> 
> Cheers
> Guillaume
> 
> Guillaume La Roque (3):
>   dm: pinctrl: Add driver-strength-microamp property
>   pinctrl: meson: add support of drive-strength-microamp
>   pinctrl: meson: g12a: add DS bank value
> 
>  drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c |  1 +
>  drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 20 ++++----
>  drivers/pinctrl/meson/pinctrl-meson.c         | 46 ++++++++++++++++++-
>  drivers/pinctrl/meson/pinctrl-meson.h         | 43 +++++++++++------
>  include/dm/pinctrl.h                          |  3 ++
>  5 files changed, 89 insertions(+), 24 deletions(-)
> 

Thanks

Tested on an Odroid-N2 !

Tested-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
