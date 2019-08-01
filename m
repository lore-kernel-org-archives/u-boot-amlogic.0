Received: by mail-wm1-f44.google.com with SMTP id u25so52962372wmc.4
        for <u-boot-amlogic@groups.io>; Thu, 01 Aug 2019 07:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:references:cc:to:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=plT9ADyEvPeOM6c5d3WQaBoMtFY3Fr75GLZLB2QyPV8=;
        b=PMWDi3LpLcuxM4SyjaPsUxNJ6seASz43CSnazBhOSK7i6YfjQbR4Ypd2eAh92t5u9A
         tb1IIvf9aOaSwxMdSC+OIYNmbuOXjoWUAAgfZw+12/Kzb1tq9WRjIrNxf9afsTWL+kcj
         62QSO2ZTjvuVpMz9OP8g5bjKIIlze23VmkHBCd1aoMsJERqgVCcSJonLG4IH0E5qb72F
         8lV3ln1RGILSumZt2o9pbXSmIdUFg9VdH5fgW3a5BhGQJo+4OXzBKrrcPGftPyYZWoWT
         NlIr7/xI/EPsviSVk+aB1eFtHDgInRNyZZEko0pDlGhznfFPHlSpTWwhREB0FSgFA/BT
         qx/Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: Using meson-tools to install u-boot
References: <CAD8Lp46mjcT3mqsCcrFAcD3opqp20mGCxrd154H68XvC7haLXg@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <7204db34-6471-b480-d8da-db2c3ffde56e@baylibre.com>
Date: Thu, 1 Aug 2019 16:02:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAD8Lp46mjcT3mqsCcrFAcD3opqp20mGCxrd154H68XvC7haLXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Daniel Drake <drake@endlessm.com>
Cc: linux-amlogic@lists.infradead.org, u-boot-amlogic@groups.io, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Daniel,

On 01/08/2019 10:24, Daniel Drake wrote:
> Hi,
> 
> Thanks for https://github.com/afaerber/meson-tools
> 
> I'm interested in it as a way of dropping reliance on the vendor's
> bitrotting uboot tree, and also because the vendor binaries are
> x86_64, whereas distros benefit from running this on native arm64
> build infrastructure. Is this possible with the current state of
> meson-tools?

I assume yes, and I'm open to a README update with these tools.
I haven't tested these tools personally, and I'll be also happy to have
them integrated in a build system like meta-meson.

> 
> Looking at the instructions at
> https://github.com/u-boot/u-boot/blob/master/board/amlogic/p212/README.libretech-cc
> and your README, most of the steps appear easy to "translate" to
> meson-tools.
> 
> But what about this one?
>  > $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin>
> Does meson-tools provide an alternative here?

No, but the https://github.com/repk/gxlimg provides a uncompiled version :
https://github.com/repk/gxlimg/blob/master/acs_tool.py

No idea about legal terms of reusing a decompiled python script.

Neil

PS: can you Cc u-boot-amlogic@groups.io next time, it's the u-boot list !

> 
> Thanks
> Daniel
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 

