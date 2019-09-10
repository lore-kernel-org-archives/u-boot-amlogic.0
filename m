Received: by mail-ed1-f68.google.com with SMTP id o9so16167710edq.0
        for <u-boot-amlogic@groups.io>; Tue, 10 Sep 2019 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAYVrYwTKqfzbew0+3w/c/vSjOHQyGhh+GVWIw6xYDU=;
        b=cgWPoor3mVlA1+Jy/MEtI18JY1IAicQEMUxyNH8ChPSB93plSRgwG/OU3CnEnXhQ3c
         K3E74z+ibbE45tHoX0Ca8trFN5vHT1ArBBNWqBZqHccaCSuVEzOX4NkGIWQ93lPWuey4
         aV+m5hKarjHJPvH6tdP/40mnT6STR/GhAjfOhacI72imssVn9/5LlHOs8qFyevNXc1E8
         WcW92Mlqw7L3dMrLu4wGo8AJSslHGp241aFW4nRaXZEOpMQ6HpNTso2eH1Ow5WuUvB2q
         bchrbw7bYb1ndSWTw+Sh3fvcX/KauoILEOLafsnKygaJBHa7hBkNTHsG/fyLPyljiWmX
         ZePw==
MIME-Version: 1.0
References: <1568055159-27982-1-git-send-email-narmstrong@baylibre.com>
 <CAEUhbmUQ3kE79jnQ20FFBit2W-96x+bKFEnGc0yZugBrNdr0Zg@mail.gmail.com> <2a299283-7f5b-15ce-cf38-6ebd30a5cecb@baylibre.com>
In-Reply-To: <2a299283-7f5b-15ce-cf38-6ebd30a5cecb@baylibre.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 10 Sep 2019 16:00:36 +0800
Message-ID: <CAEUhbmVra3kcipbKSKDZ=DBKxRDTCnnmwgD=pw0Vb+db0HR_2w@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci-dwc3: Add support for dis_u2_susphy_quirk
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Marek Vasut <marex@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Yuri Frolov <crashing.kernel@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Tue, Sep 10, 2019 at 3:58 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Bin, Marek,
>
> On 10/09/2019 03:56, Bin Meng wrote:
> > On Tue, Sep 10, 2019 at 2:52 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> This quirk is necessary for the Amlogic GXL SoCs otherwise the
> >> Port 2 PHY doesn't get out of suspend and U-Boot resets the board after:
> >>
> >> XHCI timeout on event type 33... cannot recover.
> >> BUG: failure at drivers/usb/host/xhci-ring.c:474/xhci_wait_for_event()!
> >> BUG!
> >>
> >> This quirk is also handled in the dwc3 core code, but until the
> >> xhci-dwc3 driver uses the dwc3 core, the quirk must be handled here
> >> to fix USB support on the Amlogic libretech-cc and libretech-ac board
> >> when a device is only plugged in the OTG port.
> >>
> >> Cc: Yuri Frolov <crashing.kernel@gmail.com>
> >> Cc: Bin Meng <bmeng.cn@gmail.com>
> >> Fixes: dc9cdf859e ("usb: dwc3: Add DWC3 controller driver support")
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  drivers/usb/host/xhci-dwc3.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >
> > Thanks for your efforts tracing this down!
> >
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> >
>
> Should I take it into my amlogic tree or you'll handle it ?
>

I think you can take it via your tree. Thanks!

Regards,
Bin
