Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web10.2272.1588879781665760701
 for <u-boot-amlogic@groups.io>;
 Thu, 07 May 2020 12:29:41 -0700
Received: by mail-wm1-f68.google.com with SMTP id u127so8106398wmg.1
        for <u-boot-amlogic@groups.io>; Thu, 07 May 2020 12:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ng3ClFX9F0t2V5QuNj1A/rSV4Cg7SpI2lEATuFzhu4A=;
        b=M72QWinBPqHXWzj1ajIL+GDj5A08CIxRmYd9GBUBKeVje5HQwCgipYr+KvAs5wST/T
         bjN7FSPGH5L565hHpi2zgYwCCiRjmJ+75TJZkXovnLbPnYUVJbTQsuZW7setWP5d7vd8
         /ic9uKjk09L80FjW6FZq1EylKxT7CWHzaRlTPyyxjDc7f+u0uhMnK88nRTcB+UmHS6pU
         84mQUNLAWDW3Jz4wvHQhfFZ9+9s6jEM2kC2qwlMfWGcSkKeST1UrU4eHl2zX6sL1nnSK
         oq6Coqv4WX454SDfMQR7oAJQZJmAQGwfo8rCHdVBfXB9dkpHYBLvJ45F8IOgaoXTYpea
         udXQ==
Return-Path: <b.galvani@gmail.com>
Date: Thu, 7 May 2020 21:28:56 +0200
From: Beniamino Galvani <b.galvani@gmail.com>
Subject: Re: [PATCH 0/2] u-boot support for ODROID-C4
Message-ID: <20200507192856.GA4514@gmail.com>
References: <20200505202217.7849-1-b.galvani@gmail.com>
 <4b3c7fda-d644-4a4b-46de-7f243a1dc33a@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <4b3c7fda-d644-4a4b-46de-7f243a1dc33a@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Wed, May 06, 2020 at 09:59:17AM +0200, Neil Armstrong wrote:
> Hi Beniamino,
> 
> On 05/05/2020 22:22, Beniamino Galvani wrote:
> > Hi,
> > 
> > these two patches add initial u-boot support for Hardkernel ODROID-C4.
> 
> Thanks for the patchset, I already have one in my test tree, by you did beat me
> by sending it to the list !

Oh, I didn't notice, sorry.

> > https://wiki.odroid.com/odroid-c4/odroid-c4
> > 
> > Beniamino Galvani (2):
> >   arm: dts: import ODROID-C4 device tree
> 
> The DT is not yet applied by kevin, thus I'll prefer waiting it to be accepted
> and merged in a stable linux tree to keep DT synced.
> 
> >   boards: amlogic: add ODROID-C4 support
> 
> Please re-use the w400 board instead of adding a new board, there is no need for a new
> one until you'll need to add more functionalities.
> 
> I know meson_generate_serial_ethaddr() is absent from w400, I'll add it shortly.

Okay, I'll wait that the DT gets merged and then will resubmit using w400.

Thanks,
Beniamino
