Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.3605.1571387450932168071
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Oct 2019 01:30:51 -0700
Received: by mail-wr1-f66.google.com with SMTP id r3so5253568wrj.6
        for <u-boot-amlogic@groups.io>; Fri, 18 Oct 2019 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1SmDxErQsRklDMmMJc+9/T9NOld8l5cVD0TJoUVnxvU=;
        b=UkzsX5Xj5DRURl+z3Tofff+o39+u+FkbRgkmzq9iFk0+kxY9tFqgLKIKTo40BZNEYu
         p32ynH250wVMaiFInM3IufpIFEiLAwqPDnN6TvtLD5T1cSBHobDkbkaAHYaJkejNEubA
         UYXVBp+XAv+aoPT4K3os4FxMHyy0d5GR08yGIYPt927z3YbFddETqB6sxb2UaqmdCB6S
         GBywQABxa6qu/x/VaDeTIHGmLL0hxP+2EKhmViH6YjakMbya2lnOtTOLHK7LYfzmEOvB
         wJO2mW0E64+/83RpRWRcF2IWD5DJHKrvkXKwT1OPFjDpu6nA9RXPQSKgkjI9IRRl6Mnh
         MaPg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] amlogic: Add support for the Everything-Else power domain driver
References: <20191011131220.10873-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <67a5e9ff-e496-52a9-e163-2f9fe4a2bade@baylibre.com>
Date: Fri, 18 Oct 2019 10:30:48 +0200
MIME-Version: 1.0
In-Reply-To: <20191011131220.10873-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jh80.chung@samsung.com
List-ID: <u-boot-amlogic@groups.io>

On 11/10/2019 15:12, Neil Armstrong wrote:
> For SM1 support a new Power Domain driver is needed to handle more than
> the VPU power domain.
> 
> This Power Domain driver is also used for G12A to also control the Ethernet
> Power Domain for example.
> 
> Neil Armstrong (2):
>   power: domain: add Amlogic Everything-Else power domain driver
>   configs: sei510: enable everything-else power domain
> 
>  configs/sei510_defconfig             |   2 +-
>  drivers/power/domain/Kconfig         |   7 +
>  drivers/power/domain/Makefile        |   1 +
>  drivers/power/domain/meson-ee-pwrc.c | 430 +++++++++++++++++++++++++++
>  4 files changed, 439 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/power/domain/meson-ee-pwrc.c
> 

Applied to u-boot-amlogic
