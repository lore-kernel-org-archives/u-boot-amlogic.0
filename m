Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.9789.1637829079526380010
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Nov 2021 00:31:20 -0800
Received: by mail-wr1-f52.google.com with SMTP id l16so9836280wrp.11
        for <u-boot-amlogic@groups.io>; Thu, 25 Nov 2021 00:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5QMzBWKmmGXy4oYHL9w33v46UF/SKb3I0YOncqLptBE=;
        b=YuyQkEv0bc70sf6fnHXiA4Y67n+jdfGTUempsjbytW5xCA1C26VTzu1HIDDyG02vGu
         7zoROnRBp6tMfltRwF16dQAwfYXBWUTg9gaVdtzr6EXWMRyLOTtxVctkn0YzS2mFx0bP
         GfVij1DFF/KWom9uNdWTp61Q91ewbu5XaoGdy+XOe0e6xaQkDLcTmxriZkNxAcP07jaN
         TVoy/N6OOeYksHPcS3lQdQ2ME/0Msjad02vFq+zlysFrhm0T1TVHGNIpMIy3ii9GPYz8
         +ODYmqheHWewNlhlqxfyAU+YZKSZTXWZKW5NgOY2X3dZk14Vpch7R3EwzU6bYPdjWimp
         9oaw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 7/7] RFC: Move Odroid-C2 to use binman to produce the image
References: <20211124040954.699821-1-sjg@chromium.org>
 <20211124040954.699821-8-sjg@chromium.org>
 <cb1a9b01-cc7c-1c74-d945-0c06faaff8f3@baylibre.com>
 <CAPnjgZ250SXDxSGYM-K5+oK5wT-8NjC=h3hT1c8YU4O0QwKLfA@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <250391b7-c810-421b-caf7-0b08ba16cd86@baylibre.com>
Date: Thu, 25 Nov 2021 09:31:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAPnjgZ250SXDxSGYM-K5+oK5wT-8NjC=h3hT1c8YU4O0QwKLfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 25/11/2021 01:12, Simon Glass wrote:
> Hi Neil,
> 
> On Wed, 24 Nov 2021 at 07:26, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi Simon,
>>
>> On 24/11/2021 05:09, Simon Glass wrote:
>>> This shows how binman can be used to replace the long and complicated
>>> instructions with an automated build. It is still complicated to read
>>> but users don't have to worry about the details.
>>
>> Thanks for demonstarting that !
> 
> Thanks for looking at it.
> 
>>
>> I'm really not confident about using proprietary tools from mainline u-boot
>> source tree.
> 
> Arguably people already are doing this. At least this way it is in the
> open. If people have the right tools installed it will just work, with
> no extra steps.

OK, no problem then

> 
>>
>> Will the binman step quietly fail if tools/bins aren't available ?
> 
> It handles the case where binaries are missing (that's the
> --allow-missing) but not tools. I think we can do a similar thing,
> where it just warns that the image won't work because of a missing
> tool.
> 
> When a blob is missing there are instructions to tell the user how to
> create it. For tools we could have instructions on where to download
> the tool.

Is there a easy way to bypass the binman step ? In case for example we
want to chainload the original u-boot binary, or wrap it using other
tools afterwards like for secure boot ?

> 
> Is someone working on upstreaming the tools?

There is some alternate open-source tools in C:

https://github.com/afaerber/meson-tools (GXBB, GXL & GXM only)
https://github.com/repk/gxlimg (GXBB, GXL, GXM & AXG only)
https://github.com/angerman/meson64-tools (developed for G12B, should work on G12A & SM1)

But no unified tool, all this should probably be rewritten in a binman plugin at some point.

> 
>>
>>> It needs some tidying up and only supports Odroid-C2 at present.
>>
>> --------------------------------------------------- C4
>>
>> But i get the spirit !
>>
>> Seems it should work as-is on allmost all boards except Odroid-C2 which has
>> only pre-signed binaries provided by HK.
> 
> OK. There are a lot of instructions in doc/board/amlogic - are they
> all mostly the same If so we can use a common binman description for
> all boards.
> 
>>
>> The only work will be to replace acs_tool.py for pre-G12 SoCs.
>>
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>>  arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi | 107 ++++++++++++++++
>>>  arch/arm/mach-meson/Kconfig                  |   1 +
>>>  doc/board/amlogic/odroid-c4.rst              | 127 +++++--------------
>>>  scripts/pylint.base                          |   1 +
>>>  tools/binman/etype/aml_encrypt.py            | 124 ++++++++++++++++++
>>>  tools/binman/ftest.py                        |   3 +
>>>  tools/binman/missing-blob-help               |   6 +
>>>  tools/binman/test/213_aml_encrypt.dts        |  38 ++++++
>>>  tools/binman/test/214_list_no_dtb.dts        |  23 ++++
>>>  9 files changed, 338 insertions(+), 92 deletions(-)
>>>  create mode 100644 tools/binman/etype/aml_encrypt.py
>>>  create mode 100644 tools/binman/test/213_aml_encrypt.dts
>>>  create mode 100644 tools/binman/test/214_list_no_dtb.dts
>>>
>>> diff --git a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
>>> index 963bf96b256..b221ce6920b 100644
>>> --- a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
>>> +++ b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
>>> @@ -6,6 +6,113 @@
>>>
>>>  #include "meson-sm1-u-boot.dtsi"
>>>
>>> +/{
>>> +     binman {
>>> +             /* run --bootmk on all the included inputs */
>>> +             aml-encrypt {
>>> +                     missing-msg = "aml-encrypt";
>>> +                     aml-algo = "g12a";
>>> +                     aml-op = "bootmk";
>>> +                     aml-level = "v3";
>>> +
>>> +                     /* produce a bl2, containing signed bl2 binaries */
>>> +                     bl2 {
>>> +                             type = "aml-encrypt";
>>> +                             aml-algo = "g12a";
>>> +                             aml-op = "bl2sig";
>>> +
>>> +                             /* sign the binary contaiing bl2 and acs */
>>> +                             aml-input {
>>> +                                     type = "section";
>>> +                                     bl2 {
>>> +                                             type = "blob-ext";
>>> +                                             size = <0xe000>;
>>> +                                             filename = "bl2.bin";
>>> +                                     };
>>> +                                     acs {
>>> +                                             type = "blob-ext";
>>> +                                             size = <0x1000>;
>>> +                                             filename = "acs.bin";
>>> +                                     };
>>> +                             };
>>
>> This is nice way to get rid of blx_fix.sh !
> 
> Yes that sort of thing is easy with Binman.
> 
>>
>>> +                     };
>>> +
>>> +                     /* produce a bl30, containing signed bl30 binaries */
>>> +                     bl30 {
>>> +                             type = "aml-encrypt";
>>> +                             aml-algo = "g12a";
>>> +                             aml-op = "bl3sig";
>>> +                             aml-level = "v3";
>>> +                             aml-type = "bl30";
>>> +
>>> +                             /* sign the binary contaiing bl30 and bl301 */
>>> +                             aml-input {
>>> +                                     type = "aml-encrypt";
>>> +                                     aml-algo = "g12a";
>>> +                                     aml-op = "bl30sig";
>>> +                                     aml-level = "v3";
>>> +
>>> +                                     /*
>>> +                                      * put bl30 and bl301 together, with
>>> +                                      * the necessary paddiung
>>> +                                      */
>>> +                                     aml-input {
>>> +                                             type = "section";
>>> +                                             bl30 {
>>> +                                                     type = "blob-ext";
>>> +                                                     size = <0xa000>;
>>> +                                                     filename = "bl30.bin";
>>> +                                             };
>>> +                                             bl301 {
>>> +                                                     type = "blob-ext";
>>> +                                                     size = <0x3400>;
>>> +                                                     filename = "bl301.bin";
>>> +                                             };
>>> +                                     };
>>> +                             };
>>> +                     };
>>> +
>>> +                     /* sign the bl31 binary */
>>> +                     bl31 {
>>> +                             type = "aml-encrypt";
>>> +                             aml-algo = "g12a";
>>> +                             aml-op = "bl3sig";
>>> +                             aml-input = "bl31.img";
>>> +                             aml-level = "v3";
>>> +                             aml-type = "bl31";
>>> +                     };
>>> +
>>> +                     /* sign the bl33 binary (which is U-Boot) */
>>> +                     bl33 {
>>> +                             type = "aml-encrypt";
>>> +                             aml-algo = "g12a";
>>> +                             aml-op = "bl3sig";
>>> +                             aml-compress = "lz4";
>>> +                             aml-level = "v3";
>>> +                             aml-type = "bl33";
>>> +
>>> +                             aml-input {
>>> +                                     type = "u-boot";
>>> +                             };
>>> +                     };
>>> +
>>> +                     /* add the various DDR blobs */
>>> +                     aml-ddrfw {
>>> +                             missing-msg = "aml-ddrfw";
>>> +                             type = "blob-ext-list";
>>> +                             filenames = "ddr4_1d.fw", "ddr4_2d.fw",
>>> +                                     "ddr3_1d.fw", "piei.fw",
>>> +                                     "lpddr4_1d.fw", "lpddr4_2d.fw",
>>> +                                     "diag_lpddr4.fw", "aml_ddr.fw",
>>> +                                     "lpddr3_1d.fw";
>>> +                     };
>>> +             };
>>> +
>>> +             fdtmap {
>>> +             };
>>> +     };
>>> +};
>>> +
>>>  &ethmac {
>>>       snps,reset-gpio = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
>>>       snps,reset-delays-us = <0 10000 1000000>;
>>> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
>>> index 6cba2c40dda..bcb87ea243c 100644
>>> --- a/arch/arm/mach-meson/Kconfig
>>> +++ b/arch/arm/mach-meson/Kconfig
>>> @@ -48,6 +48,7 @@ config MESON_AXG
>>>  config MESON_G12A
>>>       bool "G12A"
>>>       select MESON64_COMMON
>>> +     select BINMAN
>>>       help
>>>         Select this if your SoC is an S905X/D2
>>>
>>> diff --git a/doc/board/amlogic/odroid-c4.rst b/doc/board/amlogic/odroid-c4.rst
>>> index f66d60a54d1..5eae1e66e3a 100644
>>> --- a/doc/board/amlogic/odroid-c4.rst
>>> +++ b/doc/board/amlogic/odroid-c4.rst
>>> @@ -22,17 +22,8 @@ applies for HC4.
>>>
>>>  Schematics are available on the manufacturer website.
>>>
>>> -U-Boot compilation
>>> -------------------
>>> -
>>> -.. code-block:: bash
>>> -
>>> -    $ export CROSS_COMPILE=aarch64-none-elf-
>>> -    $ make odroid-c4_defconfig
>>> -    $ make
>>> -
> 
> [..]
> 
> Regards,
> Simon
> 

