Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web12.7990.1618575192354591628
 for <u-boot-amlogic@groups.io>;
 Fri, 16 Apr 2021 05:13:12 -0700
Received: by mail-wr1-f41.google.com with SMTP id x7so26449377wrw.10
        for <u-boot-amlogic@groups.io>; Fri, 16 Apr 2021 05:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y6m/nvE0AOzuqITNmtxA2f3DeoQ9jnfEEv3z/SH9L1U=;
        b=aCnnmE3rsRQiavLTiXvc2HSuaxrcrleFnn+CjObNnW+RwwD+0pD5m8vFqt0f/edpQJ
         L+vGxZWPIIV8ldyoBBb3CUlnlhaV2lzaxT5/RuSCtQOtvoyAXrhrjSejVDDMdmdROiWh
         T5jWBi8+J1Ajxwf9ezyzFdtKKxyS/ZiFBWYaiu/m6NHuVS9cBSR0tSmGBtsr4Wj2JY6C
         Mb0j4VCY2AVQRFje/kQTDGeO2fw1FwO5SkGbQDB3zcSO+aV1usf5AzbgHRvgTUprQao4
         QP1poKBUmNke79S+9IN16cKTphwGuvGO8FLmDg0MmohXkREv6/2iQ+4yLR1W23itUg8b
         vrFA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/5] ARM: khadas-vim3: enable PCIe and NVMe
References: <20210408075047.4076954-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <119aab50-9257-07cf-a735-eff58e7b6f5a@baylibre.com>
Date: Fri, 16 Apr 2021 14:13:09 +0200
MIME-Version: 1.0
In-Reply-To: <20210408075047.4076954-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 08/04/2021 09:50, Neil Armstrong wrote:
> This adds the missing bits to enable PCIe and NVMe support in U-Boot for
> the Khadas VIM3 & VIM3L board.
> 
> This serie depends on [1].
> 
> [1] https://patchwork.ozlabs.org/project/uboot/cover/20210325144921.1791892-1-narmstrong@baylibre.com/
> 
> Neil Armstrong (5):
>   clk: meson-g12a: add PCIe gates
>   phy: meson-g12a-usb3-pcie: add support for PCIe ops
>   arm: dts: meson-khadas-vim3: enable PCIe in U-boot
>   configs: khadas-vim3: enable PCIe and NVMe
>   configs: meson64: add NVME boot target
> 
>  arch/arm/dts/meson-khadas-vim3-u-boot.dtsi |  4 ++
>  configs/khadas-vim3_defconfig              |  5 ++
>  configs/khadas-vim3l_defconfig             |  5 ++
>  drivers/clk/meson/g12a.c                   |  2 +
>  drivers/phy/meson-g12a-usb3-pcie.c         | 81 ++++++++++++++++++++--
>  include/configs/meson64.h                  |  7 ++
>  6 files changed, 100 insertions(+), 4 deletions(-)
> 

Applied to u-boot-amlogic
