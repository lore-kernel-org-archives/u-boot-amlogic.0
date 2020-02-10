Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web12.19142.1581323098944521129
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Feb 2020 00:24:59 -0800
Received: by mail-wm1-f65.google.com with SMTP id g1so8790621wmh.4
        for <u-boot-amlogic@groups.io>; Mon, 10 Feb 2020 00:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dqXWqGVJANSiU/dVTjMJJDNckLbAMn8PzxXl6fPGdek=;
        b=ASqO/0xgXsIVjgP+XTeKjWLJ0Je8o5pFCWO2Riyj/smGlWtndzviiteotkmq+zFPZq
         NeBbRWczBDkqcJCLFBa00H9eu0PaUMkJGTSaPmlatfPK7Kt1a3ANlZfrA9txwWRBkQ8T
         Ue7SV2liTeJB0SMBHF4xtrX2yAakwC0BQZ1ZnUuExuchXOLUVWDlFaRDmyta2m4Kas1E
         IvkL1MIEo20ctvBflnKAKPC0UTZn5Y4Bp9KyRnUBZ8VRklrpTSHwcE0gxzK5Ne0bGCM6
         95KC6W7CM8qZW08+N7Nyv4Cu0cqm4IT31QjDrRowcHpRu8v9ZfhD/24KiQQuh9Nca5eM
         7eOw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCHv6 3/5] arm: dts: gx: Move common nodes to the -u-boot.dtsi
References: <20200209110557.1996-1-linux.amoon@gmail.com>
 <20200209110557.1996-4-linux.amoon@gmail.com>
 <3a8d18d5-f253-8a15-9e5c-34f31bec6925@baylibre.com>
 <CANAwSgSx3mSub7=KFoCC8-VVMg2drjFdCBDmhP8p9ccR+S_Ymw@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8eee7c78-13c5-6a97-93c3-c7830109aaf7@baylibre.com>
Date: Mon, 10 Feb 2020 09:24:56 +0100
MIME-Version: 1.0
In-Reply-To: <CANAwSgSx3mSub7=KFoCC8-VVMg2drjFdCBDmhP8p9ccR+S_Ymw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Anand Moon <linux.amoon@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

On 09/02/2020 18:25, Anand Moon wrote:
> Hi Neil,
> 
> Thanks for your review.
> 
> On Sun, 9 Feb 2020 at 18:28, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi,
>>
>> Le 09/02/2020 à 12:05, Anand Moon a écrit :
>>> Move u-boot specific common nodes in the dts files to
>>> meson-gx-u-boot.dtsi. This allows us to keep the basic
>>> dts[i] files up-to-date with the ones in kernel,
>>> but at the same time allowing the u-boot to add its own
>>> properties to the existing nodes.
>>> Also add missing mmc alias to dts nodes to avoid
>>> below debug warning.
>>>
>>> mmc_bind: alias ret=-2, devnum=-1
>>> mmc_bind: alias ret=-2, devnum=-1
>>
>> The mmc aliases are u-boot specific, so only those should be
>> moved into the meson-gx-u-boot.dtsi.
>>
>> Please keep the other aliases in the their linux sync'ed files.
>>
>> Neil
>>
> 
> meson-gx-u-boot.dtsi is included in following dts file so
> their is no another common -u-boot.dtsi for all the SBC dts.
> 
> $ git grep meson-gx-u-boot.dtsi
> arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi:#include "meson-gx-u-boot.dtsi"
> arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi:#include "meson-gx-u-boot.dtsi"
> arch/arm/dts/meson-gxbb-p200-u-boot.dtsi:#include "meson-gx-u-boot.dtsi"
> arch/arm/dts/meson-gxbb-p201-u-boot.dtsi:#include "meson-gx-u-boot.dtsi"
> arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi:#include
> "meson-gx-u-boot.dtsi"
> arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi:#include
> "meson-gx-u-boot.dtsi"
> arch/arm/dts/meson-gxl-s905x-p212-u-boot.dtsi:#include "meson-gx-u-boot.dtsi"
> arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi:#include "meson-gx-u-boot.dtsi"
> 
> So all the common nodes is included in *meson-gx-u-boot.dtsi* for GXBB
> and GXL dts.

It's not the point.

The goal is to keep the dts and dtsi files untouched to be able to sync them
from linux easily.

So :
- all general changes/fixes must go through linux, and temporary in the -u-boot.dtsi
- all u-boot specific in the -u-boot.dtsi

If you have an issue with the aliases, please discuss it on the linux-amlogic ML, but
the linux policy is to only declare the needed aliases in the boards dts and avoid having
a bunch of aliases in the dtsi files.

Neil

> 
> 
> 
> -Anand
> 
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>> no changes from previous
>>> ---
>>>  arch/arm/dts/meson-gx-u-boot.dtsi             | 15 +++++++++++++++
>>>  arch/arm/dts/meson-gxbb-nanopi-k2.dts         |  9 ---------
>>>  arch/arm/dts/meson-gxbb-odroidc2.dts          |  9 ---------
>>>  arch/arm/dts/meson-gxbb-p20x.dtsi             |  9 ---------
>>>  arch/arm/dts/meson-gxl-s805x-libretech-ac.dts | 10 ----------
>>>  arch/arm/dts/meson-gxl-s905x-khadas-vim.dts   |  5 -----
>>>  arch/arm/dts/meson-gxl-s905x-libretech-cc.dts |  9 ---------
>>>  arch/arm/dts/meson-gxl-s905x-p212.dtsi        | 10 ----------
>>>  arch/arm/dts/meson-gxm-khadas-vim2.dts        | 10 ----------
>>>  9 files changed, 15 insertions(+), 71 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-boot.dtsi
>>> index b84e5edba4..13be3a7b8f 100644
>>> --- a/arch/arm/dts/meson-gx-u-boot.dtsi
>>> +++ b/arch/arm/dts/meson-gx-u-boot.dtsi
>>> @@ -8,6 +8,21 @@
>>>       soc {
>>>               u-boot,dm-pre-reloc;
>>>       };
>>> +
>>> +     aliases {
>>> +             serial0 = &uart_AO;
>>> +             serial1 = &uart_A;
>>> +             serial2 = &uart_AO_B;
>>> +             ethernet0 = &ethmac;
>>> +             spi0 = &spifc;
>>> +             mmc0 = &sd_emmc_a;
>>> +             mmc1 = &sd_emmc_b;
>>> +             mmc2 = &sd_emmc_c;
>>> +     };
>>> +
>>> +     chosen {
>>> +             stdout-path = "serial0:115200n8";
>>> +     };
>>>  };
>>>
>>>  &vpu {
>>> diff --git a/arch/arm/dts/meson-gxbb-nanopi-k2.dts b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
>>> index cbe99bd4e0..11690d6c46 100644
>>> --- a/arch/arm/dts/meson-gxbb-nanopi-k2.dts
>>> +++ b/arch/arm/dts/meson-gxbb-nanopi-k2.dts
>>> @@ -11,15 +11,6 @@
>>>  / {
>>>       compatible = "friendlyarm,nanopi-k2", "amlogic,meson-gxbb";
>>>
>>> -     aliases {
>>> -             serial0 = &uart_AO;
>>> -             ethernet0 = &ethmac;
>>> -     };
>>> -
>>> -     chosen {
>>> -             stdout-path = "serial0:115200n8";
>>> -     };
>>> -
>>>       memory@0 {
>>>               device_type = "memory";
>>>               reg = <0x0 0x0 0x0 0x80000000>;
>>> diff --git a/arch/arm/dts/meson-gxbb-odroidc2.dts b/arch/arm/dts/meson-gxbb-odroidc2.dts
>>> index 54954b314a..f8cd76a2ef 100644
>>> --- a/arch/arm/dts/meson-gxbb-odroidc2.dts
>>> +++ b/arch/arm/dts/meson-gxbb-odroidc2.dts
>>> @@ -14,15 +14,6 @@
>>>       compatible = "hardkernel,odroid-c2", "amlogic,meson-gxbb";
>>>       model = "Hardkernel ODROID-C2";
>>>
>>> -     aliases {
>>> -             serial0 = &uart_AO;
>>> -             ethernet0 = &ethmac;
>>> -     };
>>> -
>>> -     chosen {
>>> -             stdout-path = "serial0:115200n8";
>>> -     };
>>> -
>>>       memory@0 {
>>>               device_type = "memory";
>>>               reg = <0x0 0x0 0x0 0x80000000>;
>>> diff --git a/arch/arm/dts/meson-gxbb-p20x.dtsi b/arch/arm/dts/meson-gxbb-p20x.dtsi
>>> index 0be0f2a5d2..c9822e50f9 100644
>>> --- a/arch/arm/dts/meson-gxbb-p20x.dtsi
>>> +++ b/arch/arm/dts/meson-gxbb-p20x.dtsi
>>> @@ -8,15 +8,6 @@
>>>  #include "meson-gxbb.dtsi"
>>>
>>>  / {
>>> -     aliases {
>>> -             serial0 = &uart_AO;
>>> -             ethernet0 = &ethmac;
>>> -     };
>>> -
>>> -     chosen {
>>> -             stdout-path = "serial0:115200n8";
>>> -     };
>>> -
>>>       memory@0 {
>>>               device_type = "memory";
>>>               reg = <0x0 0x0 0x0 0x40000000>;
>>> diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts b/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
>>> index 82b1c48511..4f9072a83e 100644
>>> --- a/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
>>> +++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
>>> @@ -16,16 +16,6 @@
>>>                    "amlogic,meson-gxl";
>>>       model = "Libre Computer Board AML-S805X-AC";
>>>
>>> -     aliases {
>>> -             serial0 = &uart_AO;
>>> -             ethernet0 = &ethmac;
>>> -             spi0 = &spifc;
>>> -     };
>>> -
>>> -     chosen {
>>> -             stdout-path = "serial0:115200n8";
>>> -     };
>>> -
>>>       cvbs-connector {
>>>               /*
>>>                * The pads are present but no connector is soldered on
>>> diff --git a/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts b/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
>>> index ceb34afe42..072e4575d2 100644
>>> --- a/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
>>> +++ b/arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
>>> @@ -26,11 +26,6 @@
>>>               };
>>>       };
>>>
>>> -     aliases {
>>> -             serial2 = &uart_AO_B;
>>> -             ethernet0 = &ethmac;
>>> -     };
>>> -
>>>       gpio-keys-polled {
>>>               compatible = "gpio-keys-polled";
>>>               #address-cells = <1>;
>>> diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts b/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
>>> index a23252efc6..8d3965ab42 100644
>>> --- a/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
>>> +++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
>>> @@ -15,15 +15,6 @@
>>>       compatible = "libretech,cc", "amlogic,s905x", "amlogic,meson-gxl";
>>>       model = "Libre Computer Board AML-S905X-CC";
>>>
>>> -     aliases {
>>> -             serial0 = &uart_AO;
>>> -             ethernet0 = &ethmac;
>>> -     };
>>> -
>>> -     chosen {
>>> -             stdout-path = "serial0:115200n8";
>>> -     };
>>> -
>>>       cvbs-connector {
>>>               compatible = "composite-video-connector";
>>>
>>> diff --git a/arch/arm/dts/meson-gxl-s905x-p212.dtsi b/arch/arm/dts/meson-gxl-s905x-p212.dtsi
>>> index a1b31013ab..70f437fc3a 100644
>>> --- a/arch/arm/dts/meson-gxl-s905x-p212.dtsi
>>> +++ b/arch/arm/dts/meson-gxl-s905x-p212.dtsi
>>> @@ -13,16 +13,6 @@
>>>  #include "meson-gxl-s905x.dtsi"
>>>
>>>  / {
>>> -     aliases {
>>> -             serial0 = &uart_AO;
>>> -             serial1 = &uart_A;
>>> -             ethernet0 = &ethmac;
>>> -     };
>>> -
>>> -     chosen {
>>> -             stdout-path = "serial0:115200n8";
>>> -     };
>>> -
>>>       memory@0 {
>>>               device_type = "memory";
>>>               reg = <0x0 0x0 0x0 0x80000000>;
>>> diff --git a/arch/arm/dts/meson-gxm-khadas-vim2.dts b/arch/arm/dts/meson-gxm-khadas-vim2.dts
>>> index 782e9edac8..4e68e289d3 100644
>>> --- a/arch/arm/dts/meson-gxm-khadas-vim2.dts
>>> +++ b/arch/arm/dts/meson-gxm-khadas-vim2.dts
>>> @@ -16,16 +16,6 @@
>>>       compatible = "khadas,vim2", "amlogic,s912", "amlogic,meson-gxm";
>>>       model = "Khadas VIM2";
>>>
>>> -     aliases {
>>> -             serial0 = &uart_AO;
>>> -             serial1 = &uart_A;
>>> -             serial2 = &uart_AO_B;
>>> -     };
>>> -
>>> -     chosen {
>>> -             stdout-path = "serial0:115200n8";
>>> -     };
>>> -
>>>       memory@0 {
>>>               device_type = "memory";
>>>               reg = <0x0 0x0 0x0 0x80000000>;
>>>

