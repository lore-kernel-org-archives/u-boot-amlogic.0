Received: by mail-ed1-f66.google.com with SMTP id t50so15313042edd.2
        for <u-boot-amlogic@groups.io>; Mon, 09 Sep 2019 18:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fN9hL2xGSx0maP8PWL67PlS+RJ9AbCPwH9+4V4IvAQ=;
        b=L+nNHsBwmrYNpxt1oke5vLfX5CntOJ2MmK8ycsmxx8p/+uq7Q3vpwB8X6/NzT5Hvlx
         CutQYnaDoCwKOjCeSEyemVUr0kbeT/8AvFjkglBCqt1Mx9gzCoodFH+h5JKeoAaO1rWD
         wDktZz8aGnNUyEpB8WpNPrqDEszzXFp5NHWUFUO9D2SW8H1eBGxLrzIp+iqz+BxQE2VX
         yXSpM/vq/0jG5HEGujb5pj5obhsm7jxRxwaAvv4cMnaor16fJLC0mqOXvWYcFL4SE69n
         mEDa2J7XNQ/hvdUOVTDdNYR5am189Xza4TXciM2i2S3QgJk3oxxdxP/575zkSOKBrZ8f
         wijg==
MIME-Version: 1.0
References: <1568055159-27982-1-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1568055159-27982-1-git-send-email-narmstrong@baylibre.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 10 Sep 2019 09:56:24 +0800
Message-ID: <CAEUhbmUQ3kE79jnQ20FFBit2W-96x+bKFEnGc0yZugBrNdr0Zg@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci-dwc3: Add support for dis_u2_susphy_quirk
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Marek Vasut <marex@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Yuri Frolov <crashing.kernel@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

On Tue, Sep 10, 2019 at 2:52 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This quirk is necessary for the Amlogic GXL SoCs otherwise the
> Port 2 PHY doesn't get out of suspend and U-Boot resets the board after:
>
> XHCI timeout on event type 33... cannot recover.
> BUG: failure at drivers/usb/host/xhci-ring.c:474/xhci_wait_for_event()!
> BUG!
>
> This quirk is also handled in the dwc3 core code, but until the
> xhci-dwc3 driver uses the dwc3 core, the quirk must be handled here
> to fix USB support on the Amlogic libretech-cc and libretech-ac board
> when a device is only plugged in the OTG port.
>
> Cc: Yuri Frolov <crashing.kernel@gmail.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Fixes: dc9cdf859e ("usb: dwc3: Add DWC3 controller driver support")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/usb/host/xhci-dwc3.c | 3 +++
>  1 file changed, 3 insertions(+)
>

Thanks for your efforts tracing this down!

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
