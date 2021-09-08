Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
 by mx.groups.io with SMTP id smtpd.web10.11015.1631105993299416173
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Sep 2021 05:59:53 -0700
Received: by mail-yb1-f177.google.com with SMTP id r4so4086885ybp.4
        for <u-boot-amlogic@groups.io>; Wed, 08 Sep 2021 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WEbQxH/Q15tR+TFM5ePJFNG0M8kw9/IElDldEfV4f0I=;
        b=XKoFY3cumGCAizYPK1sVhmhb85ttmGnvXcQb7H35ihEs6LtzsET38XmwJL7cj6E3Tu
         qGwNIaTiK3pGCiRtjrfB4NO01wJMej5lMdHyAmygDXmHJS0L8QmgMgxFL1w6CD7r+fA+
         KKruxBNP/hgL05RNYXlwSyZDMJ5xkRWEMUBSeBaV41MD/RVHEX1XQ2B23TIGgQp3SheC
         0jRWrS4Nco4qZ791KyL/hJdmiz6AJFGUiQB4o6+O4rBZjv8P+WvWeUSIuHdke/iHGUY0
         OkHmhVZbjCSVv5j1xtneCGDLspppYMdkPcLRoImsU7+4fibn9WjiUaxJJ0rgfp9wLuv4
         tzRQ==
MIME-Version: 1.0
References: <20210908123212.382716-1-narmstrong@baylibre.com>
In-Reply-To: <20210908123212.382716-1-narmstrong@baylibre.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 8 Sep 2021 20:59:41 +0800
Message-ID: <CAEUhbmVhnrU9gmgJMzwwa=AHfodAuEaEivT_D0qosoH7PLHKNw@mail.gmail.com>
Subject: Re: [PATCH] pci: pcie_dw_meson: fix usb fail when pci link fails to go up
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Art Nikpal <email2tema@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

On Wed, Sep 8, 2021 at 8:32 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On Amlogic A311D, when the PCIe link fails disabling the related clocks
> makes USB fail. For an unknown reason, this doesn happen on the S905D3 SoC.
>
> Mimic the Linux behavior by not considering a link failure a probe failure,
> and continue even if the PCIe link is down.
>
> Reported-by: Art Nikpal <email2tema@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/pci/pcie_dw_meson.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
