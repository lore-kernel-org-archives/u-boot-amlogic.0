Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web10.138816.1680719922433573528
 for <u-boot-amlogic@groups.io>;
 Wed, 05 Apr 2023 11:38:42 -0700
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5445009c26bso693942867b3.8
        for <u-boot-amlogic@groups.io>; Wed, 05 Apr 2023 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680719921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=96mMO5VfJymJIg1MTANPgIUd2oRzVUUEM3YC+4sy0ZU=;
        b=C7pXO6K0bRNO3mXV5wy061iPFaoxlE4dcFSM2OH2pAsm9yEr2vroEl5UBxsIWm+3M/
         CSO8GYILdnLqTkzm2TtGr1hV8jeDpIR01SjT1NFmlglYw5rRQpZzz+B6lYBh8Xl0mAMZ
         WNECt+3MzZxMC5FlDIVlBhkZ4siLZSvArbdbA=
MIME-Version: 1.0
References: <20230401185458.2280200-1-sjg@chromium.org> <20230402065454.v2.1.I2d7f563b6a82f32478a7874e36672622aebb7893@changeid>
 <d3308f32-275d-7b37-8c03-76984a2b9ddf@linaro.org>
In-Reply-To: <d3308f32-275d-7b37-8c03-76984a2b9ddf@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Apr 2023 06:38:19 +1200
Message-ID: <CAPnjgZ2TNR2R+20WH_iaz0S-k8kwOSZcxFU_0_NnCfmFJo_rcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] RFC: Move Odroid-C2 to use binman to produce the image
Content-Type: text/plain; charset="UTF-8"
To: neil.armstrong@linaro.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Christian Hewitt <christianshewitt@gmail.com>, linux-amlogic@lists.infradead.org, Alper Nebi Yasak <alpernebiyasak@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Mon, 3 Apr 2023 at 19:31, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Hi Simon !
>
> On 01/04/2023 20:54, Simon Glass wrote:
> > This shows how binman can be used to replace the long and complicated
> > instructions with an automated build. It is still complicated to read
> > but users don't have to worry about the details.
> >
> > It needs some tidying up and only supports Odroid-C2 at present.
>
> Like the v1, the work is really nice, but the dependency on vendor binary-only
> tools doesn't make feel confident about merging this.

So long as we can download it from somewhere, that is OK, or at least
better than nothing. Is there a standard download location for the
tools?

>
> We have open source implementation for all boards, but still dependeing on
> tools we must manually build isn't optimal.
>
> What would be optimal would be to re-implement those tools into python
> libraries and merge them into the u-boot tree then use them from binman.

Or C, perhaps? Then binman can call the tools.

>
> But this could be merged as first step, them the python libaray could be
> modified to support the binary tools & a probable python re-implementation.

Yes I think it would good to get this in, even if it only supports a
few boards. It is easy to add more, when possible.

Regards,
SImon
