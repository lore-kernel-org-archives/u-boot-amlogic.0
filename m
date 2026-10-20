Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2672.1792484693737690144
 for <u-boot-amlogic@groups.io>;
 Tue, 20 Oct 2026 01:24:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=JK4vsLs5;
 spf=pass (domain: chromium.org, ip: 209.85.208.52, mailfrom: sjg@chromium.org)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so3693581a12.1
        for <u-boot-amlogic@groups.io>; Tue, 20 Oct 2026 01:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792484692; cv=none;
        d=google.com; s=arc-20260327;
        b=LV1A84NgdzpUivnFMXeM94btpPIvT9e1EldkvCtPrm2TODdSOGQQaQODZLix1m8eKT
         pU+pcVE1DVct8XIe3QYANHZfw3zgMYn6l3fTZ1SAnrwVzdoh9q3rgCmZxcnW6OJqUX76
         M1uN1TpuKm+u7YnUtH6iAwYEQVMLyqrqTrOnvDTGHuh03TL3dqSISFNx8VyOsRgwEVTo
         4D8ntlqmJbO30GQerNHb6A4JtET+ZozShNTdO1gsU4y7t/YKxA+0vcfERZg2lzf0RQmF
         tAD3QeeF5F8nrtJbr7PWjhbLaqY4ppmnAxF7gBwQ6VRB2P3TSBHcCLnzzDlFhzJA2fHS
         ECgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=pQ4uWaLiTOvnYAwe838gnBZoR6ZgrvM47KSuD4eQ++4=;
        fh=8gZ8dTFRrj5sIi/4JkLqgoNncQBHuXpw9veB0CZwCkc=;
        b=hcXjORmAFH04jTQ78ZBUqly2ePsdGbQYyOi3L2ozKdJu4r0uqqFRTC7M5bDNx6gL+h
         0LErgKHnPz976i6M/DVGI69ECkpjmtt3brArbWf+HOGTPLAbFdPZdXvmjJhp+0Lu2NF4
         JgocAnhEiyH/dBUZ+vzFrBlMNVSHVuLByKBTbGPrkQXd7ZRFKOagfHCtmpzy8EIdNpdW
         raIW0kR9AnXgQDqXm6f78dgOaup1uNiPpXW7BNtE6Rf88/4V9lNst6udYZXtg8s852ab
         lDNhclohICLk2YyoYQjxj2BG1goFlc+mGsuiQ8WUpuuO17yWjLylQWCpbWUOv4jLOoVB
         onjQ==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792484692; x=1793089492; darn=groups.io;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pQ4uWaLiTOvnYAwe838gnBZoR6ZgrvM47KSuD4eQ++4=;
        b=JK4vsLs52XUmqjaNorVTspZ/cbm+ZWKUhQjaNiiSxnMjGJNSJ2LYNcTsdP+JCLNBjd
         qXuQzfE/WLqAlZEeZAbPkkIVpXMhevQBWLpccbdu5+ji9DjqIu613p8ZoaxStT2RkRfr
         U3r9rfv7cOGFUZzIuLBV/y+UJJm5iUhUIW2PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484692; x=1793089492;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pQ4uWaLiTOvnYAwe838gnBZoR6ZgrvM47KSuD4eQ++4=;
        b=smFE/7NVl/8Ek7ZJboAII0ZXMxgFTrYPD9tSn4AuYZsIv8CZ5sYCUo/HWmR7EMSX56
         /1HXlcYb6Kvui98CdYYoAYVRVdZIY6Pz84b1zJUFpqkheiQ8E1Qbvy7/0AqpR/w7GRNU
         BVCiH2MIsQGm9GNsiAn6n5ZiZR6Ri9jdpyFRYPVBUJnrDhq89z+cXjNy9XN3crILLAz9
         v/t/jXsE8AyMSamyYiHo/EqvO+GfJAgbZxfCELDsJ56bI/oAi40wwC/v0zSSnVERTvxX
         KwQUA1pCiM9BdITuYa3gK0OjjvHh/qOBs5nbEVCz3Nz2F38Sv9/4P4iWMI84He1EfKNa
         umCw==
X-Forwarded-Encrypted: i=1; AKwUvBwsbPlqL2q17A1/6xaM3NBR8m7bmZMR9wgrzxzOlgXuhmzm8JfrBqRNsnevy2VMs0ZwhyUrVtIs0hDYO/2Bqw==@groups.io
X-Gm-Message-State: AFq9FYKVi7FvGQBwd0AdmQ7zvrHWf24op+Mn+AXG61GRcq/NsuF8WcOF
	bZ4peU2AYpqJKasZDbw59sIGT/RwuOI0mFmR4shEttuDRDzLRrCCnUUGMGrD759j0hHsf6Y+z5t
	yWYe7O/IkdFyYkBKgadclV8u6j6P6N+lrgZIYYdQk
X-Gm-Gg: AYBFou1IeolFd/wjoRA6JbF9PbsuI9ELLG/Y5KvjlaBW5JUyZos6UmTGV9qhKQ0MprM
	Xncz3gKnayTF+qB9VyXDELliADp+yaXVzQ8hAlEccsKZGmFWK6JQk2/5Sz0DCXzwMYtaAjoTuDD
	wiY/hPACpyRNfnVn1YwLVJJLIwVlO/SS0qwESTLrTiFsVU98NzkChFsNS87AlpKQGkP/grgLTEB
	wA0vkmQfdaA5ypXCDLBJoRGI3rA5FcuGdh55tXlrWuwD0QPFjbNxrPFKDlxMvOOxboD+SP7svVb
	/ivgGfNyaR3lKxqXu9xC4CG2lvAt9ozrbBg0MWg/GrrnQTROQ9+2TOcxQHKGgx6M
X-Received: by 2002:a05:6402:20d6:10b0:6aa:e589:87d7 with SMTP id
 4fb4d7f45d1cf-6b3a8100c06mr4967249a12.6.1792484691758; Tue, 20 Oct 2026
 01:24:51 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 01:24:49 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 01:24:19 -0700
MIME-Version: 1.0
In-Reply-To: <20261016-bpp-helpers-v2-1-ca1e6bba2820@gmail.com>
References: <20261016-bpp-helpers-v2-1-ca1e6bba2820@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 01:24:49 -0700
X-Gm-Features: AclHuK9XDeB5A6aRT2gO77-IIU8q1cHzzPkOU3emTSpBMfBQaukQcXWSPb5shi4
Message-ID: <CAFLszTgPjXzeYKt+AjF6HdXsE4TxxsjeyreuqTDGHJ-jbur+xQ@mail.gmail.com>
Subject: Re: [PATCH v2] video: use bpp conversion helpers consistently
To: imkyufie@gmail.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
	u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, 
	Anatolij Gustschin <ag.dev.uboot@gmail.com>, Eugen Hristev <ehristev@kernel.org>, 
	Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Quentin Schulz <u-boot@0leil.net>, 
	Kever Yang <kever.yang@rock-chips.com>, Andre Przywara <andre.przywara@arm.com>, 
	Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Tue, 20 Oct 2026 08:48:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3140

Hi Reza,

On 2026-10-16T06:30:48, Reza Kurniawan <imkyufie@gmail.com> wrote:
> video: use bpp conversion helpers consistently
>
> Many places open-code the conversion between log2 bits-per-pixel and
> the actual number of bits or bytes per pixel, using expressions such as
> "1 << bpix", "(1 << bpix) / 8" and "((1 << bpix) >> 3)". Meanwhile,
> <video.h> already provides VNBITS() and VNBYTES() helpers for exactly
> these conversions. Replace the open-coded expressions with the helpers.
>
> Using the helpers makes the intent of the expression clear, removes
> duplicated bit manipulation, and reduces the reliance on the specially
> crafted VIDEO_BPP* enum values, since callers no longer need to know
> that those values are log2 quantities which is also important for
> future extensions.
>
> Note that VNBYTES() is only correct for 8bpp and above, since it returns
> a whole number of bytes per pixel and cannot represent sub-byte pixel
> sizes. Every site converted to VNBYTES() here uses 16bpp or 32bpp, so
> the result is identical to the original expression.
>
> No functional change is made.
> [...]
>
>  arch/sandbox/cpu/sdl.c                 | 4 ++--
>  boot/fdt_simplefb.c                    | 2 +-
>  cmd/bdinfo.c                           | 2 +-
>  drivers/video/atmel_hlcdfb.c           | 2 +-
>  drivers/video/atmel_lcdfb.c            | 4 ++--
>  drivers/video/imx/mxc_ipuv3_fb.c       | 2 +-
>  drivers/video/meson/meson_vpu.c        | 4 ++--
>  drivers/video/mvebu_lcd.c              | 2 +-
>  drivers/video/rockchip/rk_vop.c        | 4 ++--
>  drivers/video/sunxi/sunxi_de2.c        | 8 ++++----
>  drivers/video/tegra/dc.c               | 4 ++--
>  drivers/video/tegra/tegra124/display.c | 4 ++--
>  drivers/video/ti/tilcdc.c              | 4 ++--
>  drivers/video/tidss/tidss_drv.c        | 4 ++--
>  test/cmd/bdinfo.c                      | 2 +-
>  15 files changed, 26 insertions(+), 26 deletions(-)

Thanks for the respin.

Reviewed-by: Simon Glass <sjg@chromium.org>
