Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
 by mx.groups.io with SMTP id smtpd.web10.10473.1616406087791358616
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Mar 2021 02:41:27 -0700
Received: by mail-yb1-f175.google.com with SMTP id j2so5862982ybj.8
        for <u-boot-amlogic@groups.io>; Mon, 22 Mar 2021 02:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlrEAqYau8LbrBbmtmvYbac30RU2TZ162bF6hLj8iXc=;
        b=ZCIovfGZE0vlYQxz1sALX4zPU8wbNA/7pp6bghiL7k5GoWyjMWPh9yCQ/fhuoTDCKK
         Hg9RqXeYIJIVqLBzD1DeBAyTjlJQtGzYGZe9HHH417j1jFo1y7y/SdnbeeqI1dfhPLQk
         4Wk0a/UoISzY7Ec942g3AFnUPEa0G3m98+CGWoogoqV2X8D6It2OrN8fCnb+hq7D1aUX
         /8GbiApyJGePE/9vrJ50tqAFxEzU1y9W+RQ9jWiOCJN/3YEQE61LoLf1LRlAN3xUK9A8
         l+gCcxVAL83YB1xuA33M0TUbr0O+qnHKdG6eSw10d8FUegK+56aCWrdZPPdRu269s7zQ
         0GiA==
MIME-Version: 1.0
References: <20210322091812.2511462-1-narmstrong@baylibre.com> <20210322091812.2511462-2-narmstrong@baylibre.com>
In-Reply-To: <20210322091812.2511462-2-narmstrong@baylibre.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 22 Mar 2021 17:41:15 +0800
Message-ID: <CAEUhbmUJv_3h8NCFun7ci5R70j2ckCF3SNfXQ_1s9AzZb3pBuA@mail.gmail.com>
Subject: Re: [PATCH RFT 1/4] pci: add common Designware PCIe functions
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>, Green Wan <green.wan@sifive.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, shawn.lin@rock-chips.com, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

+Green Wan for SiFive FU740 PCIe which is another variant of DW PCIe

On Mon, Mar 22, 2021 at 5:18 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> With the introduction of pcie_dw_rockchip, and need to support the DW PCIe in the
> Amlogic AXG & G12 SoCs, most of the DW PCIe helpers would be duplicated.
>
> This introduce a "common" DW PCIe helpers file with common code merged from the
> dw_ti and dw_rockchip drivers and adapted to fit with the upcoming dw_meson.
>
> The following changes will switch the dw_ti and dw_rockchip to use these helpers.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/pci/Kconfig          |   4 +
>  drivers/pci/Makefile         |   1 +
>  drivers/pci/pcie_dw_common.c | 352 +++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie_dw_common.h | 153 +++++++++++++++
>  4 files changed, 510 insertions(+)
>  create mode 100644 drivers/pci/pcie_dw_common.c
>  create mode 100644 drivers/pci/pcie_dw_common.h
>

Regards,
Bin
