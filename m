Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
 by mx.groups.io with SMTP id smtpd.web10.1280.1609292227784565112
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Dec 2020 17:37:07 -0800
Received: by mail-yb1-f174.google.com with SMTP id u203so13762808ybb.2
        for <u-boot-amlogic@groups.io>; Tue, 29 Dec 2020 17:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SW3baZ5o//viOFeZ9x9xjt3d5sckWxEzD5sr+TRV520=;
        b=kQal+LEhrSK2jgWYfhgEy4FL37GCC5Uq9rlRGhqCBCUi0mWM8q+BvDENsRWTvRdvH2
         PaxzpjgU+BqqU0KrFXoboupwCWPwk8HCQN48JA87ec0eyVhFR82/foFpYgkagIg32x1b
         w7k5us/SgaZmckX2L1awO4lM0avzu0/LtDom1iatyunzoLSzcRT8xXa/REHCWNEpn8pw
         zO4FsYmc/lOIOl0OLQgZEhRSzGCyyyF1FNaRKJxqe5CEv2/RibROTF/nbmt72MDcmU7M
         /CI7sLc5/SYWdYGwKV2YJ5i2LXVwOpewC+T2baos3jNOLWgSWeCC9bL+DjP4zIyWMvGY
         pP0A==
MIME-Version: 1.0
References: <77ac8cb333048b92600e8781b609251f2399790d.1609270634.git.stefan@agner.ch>
In-Reply-To: <77ac8cb333048b92600e8781b609251f2399790d.1609270634.git.stefan@agner.ch>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 30 Dec 2020 09:36:56 +0800
Message-ID: <CAEUhbmW6w0QoCP6+uRzLxbgWtMwPNkF2whtuf=Y-429QKnT3Xg@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci: Use only 32-bit accesses in nvme_writeq/nvme_readq
Content-Type: text/plain; charset="UTF-8"
To: Stefan Agner <stefan@agner.ch>
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, U-Boot Mailing List <u-boot@lists.denx.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Zhikang Zhang <zhikang.zhang@nxp.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Matthias Brugger <mbrugger@suse.com>, Marek Vasut <marex@denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Stefan,

On Wed, Dec 30, 2020 at 3:37 AM Stefan Agner <stefan@agner.ch> wrote:

The tag is wrong. Should be nvme:

>
> There might be hardware configurations where 64-bit data accesses
> to NVMe registers are not supported properly.  This patch removes
> the readq/writeq so always two 32-bit accesses are used to read/write
> 64-bit NVMe registers, similarly as it is done in Linux kernel.
>
> This patch fixes operation of NVMe devices on RPi4 Broadcom
> BCM2711 SoC based board, where the VL805 USB XHCI controller is
> connected to the PCIe Root Complex, which is attached to the system
> through the SCB bridge.
>
> Even though the architecture is 64-bit the PCIe BAR is 32-bit and likely
> the 64-bit wide register accesses initiated by the CPU are not properly
> translated to a sequence of 32-bit PCIe accesses.
> nvme_readq(), for example, always returns same value in upper and lower
> 32-bits, e.g. 0x3c033fff3c033fff which lead to NVMe devices to fail
> probing.
>
> This fix is analogous to commit 8e2ab05000ab ("usb: xhci: Use only
> 32-bit accesses in xhci_writeq/xhci_readq").
>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Zhikang Zhang <zhikang.zhang@nxp.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>
>  drivers/nvme/nvme.h | 8 --------
>  1 file changed, 8 deletions(-)
>

Otherwise, LGTM:

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
