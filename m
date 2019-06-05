Received: by mail-wr1-f67.google.com with SMTP id d18so18612996wrs.5
        for <u-boot-amlogic@groups.io>; Wed, 05 Jun 2019 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0YjQlMD7GCCoaajMff5Kk80LsrXLPOmN73xKbMZLzJU=;
        b=st1+BuH1O1pBjkyaseovplAQmeom0Y0sltRff+WEh3PSaTSnfNBOP61h5o8IyzAoQO
         voDuGj0vmAI/WlXgTRCDJihxK3MC4COpGkLRQXFSkegA7aRk8ZZLLS9kRdIy87oZqB3C
         iy0PBVNnO4W1Mliirg9U0o7Fc7d43as4ApGye6CKXnOaWV7YZNDTirIEKLYlQdKC1fnp
         qcgWHG1c9hdLxxziMzZG6KCDngfxEmmxMV50OE0VxyHUgxOX5MXHmyVJZRXTMh9U8b+V
         mOBd0Km3VbXYGeFcwECC6zHdbARHRAZb6hFqJL4haMnN7/+UyCEwcCKf8W9HZDKmW/42
         HSwg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/3] Add drive-strength-microamp in Meson pinctrl driver
References: <20190604115308.26510-1-glaroque@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <9b565b8f-7fda-0509-32cc-ca138ebc3c8f@baylibre.com>
Date: Wed, 5 Jun 2019 11:04:10 +0200
MIME-Version: 1.0
In-Reply-To: <20190604115308.26510-1-glaroque@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

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

Applied to u-boot-amlogic
