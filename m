Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web08.11028.1617711721398754140
 for <u-boot-amlogic@groups.io>;
 Tue, 06 Apr 2021 05:22:02 -0700
Received: by mail-wm1-f50.google.com with SMTP id k128so7273626wmk.4
        for <u-boot-amlogic@groups.io>; Tue, 06 Apr 2021 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AG/SYdEBUeDMQPDar4AVuTQH0dQpAgziRGjNkF4IQvs=;
        b=01Gc2O/LsO8B0LcTfVT0DT/H+w0pHn5Y+nBW+7eLWXXbFTAf9Vk/8Xxf38FCppnHNK
         zO1kGnFPotUjn3udtuyygpzATJoN/3ME/pqxuVejNXEoc8/UsEkWeMqm9lv28BMsI6AR
         4GgDsE5nAWF5vjA4MeiDniDAcgnPmZEn4/QhQ7Iq7B3exxxhFe8hd5n8/wAM1R46a1TZ
         GcB6VhfC5XxG4GvZ0x3L3rDj+mez32xd1oQ44scv++LdXmYzDVVNx2y7orxDcuXMd8Kv
         JNx9VhrCeXOZgBmXhpW4H33bxU2LnleayqA9tJomDvn0gZA/1wLqTs1N1EpYIlQLE5Ni
         qnZg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH RFT v2 0/4] pci: add common Designware PCIe functions and support Amlogic Meson PCIe controller
References: <20210325144921.1791892-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <d5f05f02-22e8-1faf-5754-715cd8dcfebd@baylibre.com>
Date: Tue, 6 Apr 2021 14:21:58 +0200
MIME-Version: 1.0
In-Reply-To: <20210325144921.1791892-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, lokeshvutla@ti.com, nsekhar@ti.com, shawn.lin@rock-chips.com, green.wan@sifive.com
List-ID: <u-boot-amlogic@groups.io>

Hi Bin,

On 25/03/2021 15:49, Neil Armstrong wrote:
> With the introduction of pcie_dw_rockchip, and need to support the DW PCIe in the
> Amlogic AXG & G12 SoCs, most of the DW PCIe helpers would be duplicated.
> 
> This introduce a "common" DW PCIe helpers file with common code merged from the
> dw_ti and dw_rockchip drivers and adapted to fit with the upcoming dw_meson.
> 
> The following changes will switch the dw_ti and dw_rockchip, and introduce a new
> driver to support the Amlogic AXG & G12 SoCs using these new common helpers.
> 
> The dw_meson has been validated, but the dw_ti and dw_rockchip would need testing
> on hardware to validate nothing has been broken.

How should be proceed ? I can't possibly test patches 2 & 3, but Green has tested it
on Sifive, should patch 1 & 4 be merged then we should wait feedback from the Ti & Rockchip
owners ?

Neil

> 
> Changes since v1:
> - added prefetch memory region support
> - switched to __iomem
> - fixed circular dependency for PCI_KEYSTONE
> 
> Neil Armstrong (4):
>   pci: add common Designware PCIe functions
>   pci: pcie_dw_ti: migrate to common Designware PCIe functions
>   pci: pcie_dw_rockchip: migrate to common Designware PCIe functions
>   pci: add Amlogic Meson Designware PCIe controller
> 
>  drivers/pci/Kconfig            |  16 +-
>  drivers/pci/Makefile           |   2 +
>  drivers/pci/pcie_dw_common.c   | 366 +++++++++++++++++++++++++
>  drivers/pci/pcie_dw_common.h   | 155 +++++++++++
>  drivers/pci/pcie_dw_meson.c    | 459 ++++++++++++++++++++++++++++++++
>  drivers/pci/pcie_dw_rockchip.c | 472 ++-------------------------------
>  drivers/pci/pcie_dw_ti.c       | 444 +++----------------------------
>  7 files changed, 1062 insertions(+), 852 deletions(-)
>  create mode 100644 drivers/pci/pcie_dw_common.c
>  create mode 100644 drivers/pci/pcie_dw_common.h
>  create mode 100644 drivers/pci/pcie_dw_meson.c
> 

