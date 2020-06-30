Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
 by mx.groups.io with SMTP id smtpd.web12.13303.1593516823816567002
 for <u-boot-amlogic@groups.io>;
 Tue, 30 Jun 2020 04:33:43 -0700
Received: by mail-il1-f194.google.com with SMTP id k6so17342626ili.6
        for <u-boot-amlogic@groups.io>; Tue, 30 Jun 2020 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cp1sh5nbrCX5iAeKuwPeVl4OGSQaXol8ZmdBuGulf8=;
        b=tGjJtlUQ3Ms9gxdBxjlOWLxAJAY+8khrSNq25O4q0yjms+HdNZrPD23lRP+AyfYLdH
         w+H+adzeTOs6ZIyJ16ZoySQhufT/LQrK1fFDJTzdDnBt2XapCMdtWDnkZPrfK5wkx1Wn
         XDQ2e1e3CE0k9+/q/doIUkqtXzfqHsV/ZG7JFDtMljgIXWiGhxZ9XymFcTuQwfNSllQX
         WpfBVVpLg1nrTTyT50R7s8J4Gm+gb8wRiyR1FyE+7sn4EOoT4uO4B5EIN4WCHB5d+Q+8
         nMim5potmmLwLgS/YXppyU5msawgEqzsOKRzFE0e+i4naB0sbubTaXpYUTmzuoKwdflc
         WrYA==
MIME-Version: 1.0
References: <20200505202217.7849-1-b.galvani@gmail.com>
In-Reply-To: <20200505202217.7849-1-b.galvani@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 30 Jun 2020 17:03:33 +0530
Message-ID: <CANAwSgT3AcsQkE47CusmC_rCnVo_FRuWaRbivUyxzPXFSjCmSA@mail.gmail.com>
Subject: Re: [PATCH 0/2] u-boot support for ODROID-C4
Content-Type: text/plain; charset="UTF-8"
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Beniamino,

On Wed, 6 May 2020 at 01:53, Beniamino Galvani <b.galvani@gmail.com> wrote:
>
> Hi,
>
> these two patches add initial u-boot support for Hardkernel ODROID-C4.
>
> https://wiki.odroid.com/odroid-c4/odroid-c4
>
> Beniamino Galvani (2):
>   arm: dts: import ODROID-C4 device tree
>   boards: amlogic: add ODROID-C4 support
>

Can you respin this patches, I would like to see these get merged in
the current u-boot release

-Anand
