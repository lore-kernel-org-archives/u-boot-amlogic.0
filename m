Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
 by mx.groups.io with SMTP id smtpd.web12.20812.1592841420468075725
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Jun 2020 08:57:00 -0700
Received: by mail-il1-f193.google.com with SMTP id l6so16425355ilo.2
        for <u-boot-amlogic@groups.io>; Mon, 22 Jun 2020 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uv3XAzM9K62ZPkBF1Ujkzgthom733VY6rEMQq8IqsN8=;
        b=D1QXrUFrELjpzgT9Nfr5ci6PnO6sAU98U0MXRmADW0SjAbK/lQRHpmZafgwAv2lR+L
         4chS+a6wH7ZAcTnzD2o8pW6NFTIDCtY5ZrmIiVUMNCH25CMqp/vx7B2THR/z8TYwYLy6
         YGt856D5c7BYg5yikJJ2bk586YhtII6e2eIzyWIXXj9bISJiRNeTDaWit0Jt+lZGf/e6
         OpeefouGbA2U9z0K7bxytIbCTNwM281uex0YQLu0mS7KEdjVj5884/EEFI1BognhPhlc
         6cbOvcJ7ife625m+Qy5V7/nsJyXl/E26irDJgehb8iOTQqKjIW+h5N5rSU9bwGDGXUOi
         ThLA==
MIME-Version: 1.0
References: <20200618144037.23392-1-narmstrong@baylibre.com>
 <CANAwSgR2whQUUHWUze8Jy8yE3frrtMxt_u=kyQRNrgDZ4wMsHA@mail.gmail.com> <c22bb120-62f6-c53c-7ba1-fef713708efc@baylibre.com>
In-Reply-To: <c22bb120-62f6-c53c-7ba1-fef713708efc@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 22 Jun 2020 21:26:48 +0530
Message-ID: <CANAwSgT=gzu5EeVnCxv+Zjcg-84DouNOOJwPAZAy8X3q9R=v3w@mail.gmail.com>
Subject: Re: [PATCH] board: amlogic: Add Odroid-N2 board support
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Pascal Vizeli <pvizeli@syshack.ch>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Mon, 22 Jun 2020 at 18:36, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 21/06/2020 19:23, Anand Moon wrote:
> > Hi Neil,
> >
> > On Thu, 18 Jun 2020 at 20:11, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> From: Pascal Vizeli <pvizeli@syshack.ch>
> >>
> >> Add a proper Odroid-N2 board support to handle the Ethernet MAC
> >> address stored in the in-SoC eFuses.
> >>
> >
> > This feature need to be implemented for all Amlogic SoC boards,
> > since many boards link libretech-cc also generate random mac address
> > for ethernet.
>
> In fact, AFAIK only HardKernel stores the MAC in the fuses, now Amlogic stores
> the MAC in the eMMC custom partitions, but they did for GXBB and previous SoCs.
> Earlier I introduced meson_generate_serial_ethaddr() for GXL and later (not GXBB),
> to generate an unique MAC address from the SoC serial.
>
> Neil
>

Thanks for this information.

-Anand
