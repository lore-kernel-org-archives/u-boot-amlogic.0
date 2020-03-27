Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.11490.1585315833773258492
 for <u-boot-amlogic@groups.io>;
 Fri, 27 Mar 2020 06:30:34 -0700
Received: by mail-wr1-f65.google.com with SMTP id a25so11459748wrd.0
        for <u-boot-amlogic@groups.io>; Fri, 27 Mar 2020 06:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wahJdDlhnPOKTPKarBWnsXtdH0TzxMVzIcLoV1eG3hs=;
        b=Scd8gV5QM1qr1EE3aHbfxs10bu/v2HNx0oqQ0hliZpG58Ey5hatYJ00JgIilAmHVUa
         6ZGMW4M3FknhJGEuY8TrzmjDqu3Hqs9wLrfsK1S3DLDqo4IpbqLAhYG2Li28xkJOCe5a
         QPyYHV2ms921P73xzGaBdt0dsH2GnnuYS82OPF2B1iQPwvTVSxiPzjSbpCO8NbkyuOeJ
         VbkKGbqx6pZaDyq6gA8YG6FUE2HuAMRwnZ9sTmQblNjSfrjPyyxOXwP8HEVRdlc/36Yc
         Vu+d2Wg3pcBfVLMc7N2wqtixGiI5sUkDAuEuPEvOdpPEnJmrOuNdsvs07z9j9/ymY+We
         CAgg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] drivers/rng: add Amlogic hardware RNG driver
References: <20200304011738.33763-1-xypron.glpk@gmx.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <dfa16733-ff13-54f6-86ef-36396cdd0df4@baylibre.com>
Date: Fri, 27 Mar 2020 14:30:30 +0100
MIME-Version: 1.0
In-Reply-To: <20200304011738.33763-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 04/03/2020 02:17, Heinrich Schuchardt wrote:
> The first patch simplifies the Kconfig for hardware RNG drivers and enables
> the Sandbox RNG driver for all Sandbox instances.
> 
> The second introduces a hardware random number generator driver for Amlogic
> SOCs. This second patch had been sent before but the preceding patch was
> missing.
> 
> Heinrich Schuchardt (2):
>   drivers/rng: simplify Kconfig
>   drivers/rng: add Amlogic hardware RNG driver
> 
>  configs/sandbox64_defconfig |   1 -
>  configs/sandbox_defconfig   |   1 -
>  drivers/rng/Kconfig         |  17 ++++-
>  drivers/rng/Makefile        |   1 +
>  drivers/rng/meson-rng.c     | 120 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 136 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/rng/meson-rng.c
> 
> --
> 2.25.1
> 

Hi Sughosh,

Should I take this serie in my tree ?

Neil
