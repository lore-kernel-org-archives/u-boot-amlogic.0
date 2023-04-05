Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 by mx.groups.io with SMTP id smtpd.web10.144192.1680732391924014483
 for <u-boot-amlogic@groups.io>;
 Wed, 05 Apr 2023 15:06:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=subject:to:from:message-id:date;
	bh=f5EXuxEx+k4RZenwIaQK/guv07Xz9T3xUEt76X3neWo=;
	b=vQ4b4UBJSYJvGjWdfFSgRbNNXrvd5/5NRZZO7OGuPyfKUUYIUuz5fwo9J4vkA1IyhZPuZXpu3sHBS
	 KBC4p4MhUR2t+K43mmWcAiaegOKU4HBlXjlel3XOkAugUO7a2UHgT+lrm6aR2npAPoT0v1RnaJdZGN
	 NnWHdg3c4jUf5URtTd9U/pzXzIxVu3S8GXQWHyJ3GuPI8stnZKUT1w0ewUawRDUgt22zByYPafnJz/
	 nMbCbhvBm0J41Z2M8s6AGcUV5Qq2YKFRKjdIfhI9fpVuX5rQAP4u/udlIBaS2W97gIKNtGySC1SLiD
	 6sFyvG155ie6Fezh/tS0Z7JX/2TUmuw==
Date: Thu, 06 Apr 2023 00:06:26 +0200
Message-Id: <871qkyasrh.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
In-Reply-To: 
	<CAPnjgZ2TNR2R+20WH_iaz0S-k8kwOSZcxFU_0_NnCfmFJo_rcA@mail.gmail.com>
	(message from Simon Glass on Thu, 6 Apr 2023 06:38:19 +1200)
Subject: Re: [PATCH v2 1/1] RFC: Move Odroid-C2 to use binman to produce the image
References: <20230401185458.2280200-1-sjg@chromium.org>
 <20230402065454.v2.1.I2d7f563b6a82f32478a7874e36672622aebb7893@changeid>
 <d3308f32-275d-7b37-8c03-76984a2b9ddf@linaro.org> <CAPnjgZ2TNR2R+20WH_iaz0S-k8kwOSZcxFU_0_NnCfmFJo_rcA@mail.gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: neil.armstrong@linaro.org, u-boot@lists.denx.de, u-boot-amlogic@groups.io, christianshewitt@gmail.com, linux-amlogic@lists.infradead.org, alpernebiyasak@gmail.com
List-ID: <u-boot-amlogic@groups.io>

> From: Simon Glass <sjg@chromium.org>
> Date: Thu, 6 Apr 2023 06:38:19 +1200
> 
> Hi Neil,
> 
> On Mon, 3 Apr 2023 at 19:31, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >
> > Hi Simon !
> >
> > On 01/04/2023 20:54, Simon Glass wrote:
> > > This shows how binman can be used to replace the long and complicated
> > > instructions with an automated build. It is still complicated to read
> > > but users don't have to worry about the details.
> > >
> > > It needs some tidying up and only supports Odroid-C2 at present.
> >
> > Like the v1, the work is really nice, but the dependency on vendor
> > binary-only tools doesn't make feel confident about merging this.
> 
> So long as we can download it from somewhere, that is OK, or at least
> better than nothing. Is there a standard download location for the
> tools?

The tools are Linux x86-64 only, so...

> > We have open source implementation for all boards, but still dependeing on
> > tools we must manually build isn't optimal.
> >
> > What would be optimal would be to re-implement those tools into python
> > libraries and merge them into the u-boot tree then use them from binman.
> 
> Or C, perhaps? Then binman can call the tools.

...this would be preferable.

> > But this could be merged as first step, them the python libaray could be
> > modified to support the binary tools & a probable python re-implementation.
> 
> Yes I think it would good to get this in, even if it only supports a
> few boards. It is easy to add more, when possible.
> 
> Regards,
> SImon
> 
