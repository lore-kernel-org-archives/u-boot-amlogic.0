Received: by mail-wr1-f65.google.com with SMTP id g7so331345wrx.2
        for <u-boot-amlogic@groups.io>; Wed, 28 Aug 2019 01:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vqTtwVFgKEgxpmZ+AQ3Tyr2LHt76uH3mb7wqKb+VUbs=;
        b=KlWRuNSQugZZbD2AB2LCQCqB74EpRsxmtREdXJ/6j0io97Ct5/qa4EBh9h4LBGTRzz
         DzLjcAALqC5vbC16l6dcEBCdYiHv5Ilvelt9TWRpz4oAGMT71myL0ZV9tNXVvl9ZX34u
         JECsT7lrSTGBxaUpd8oLfDGkLrbCpRq23hldQyjiaId/JxaB6OrK+TOBC1JWQ0uN90DC
         8BuHoSXw+1FyRBgyMNmQovce/akLkvoWwulzuhnIiGzFLE6AwUce6v+p/3qlcDuWyVuy
         JEqYqwmZIQh8h0sludX+CQoVfV+yat8mwFMVhzSLYIIrEYH2zmtfqroGq6QmyqFH99/Z
         CFow==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: document alternative libretech-cc installation methods
References: <20190806081042.26399-1-drake@endlessm.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <61ace65b-0f5a-35aa-fa2d-6db65e78ba60@baylibre.com>
Date: Wed, 28 Aug 2019 10:24:16 +0200
MIME-Version: 1.0
In-Reply-To: <20190806081042.26399-1-drake@endlessm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Daniel Drake <drake@endlessm.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, afaerber@suse.de, repk@triplefau.lt
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 06/08/2019 10:10, Daniel Drake wrote:
> As already documented in this README, several binaries must be
> glued together in order to boot the device.
> 
> Extend the documentation to cover the prebuilt binaries
> (saving you the hassle of installing ancient cross-compilers),
> and also mention the open source replacements for the encryption
> tool (which is especially useful if you want to avoid requiring
> 32-bit x86 binaries in your build system).

Applied to u-boot-amlogic-next for next u-boot release, feel free
to add the same text to other boards..

Neil

> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  board/amlogic/p212/README.libretech-cc | 41 +++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/board/amlogic/p212/README.libretech-cc b/board/amlogic/p212/README.libretech-cc
> index d007f58764..6af7de3cfa 100644
> --- a/board/amlogic/p212/README.libretech-cc
> +++ b/board/amlogic/p212/README.libretech-cc
> @@ -38,9 +38,28 @@ U-Boot compilation
>  Image creation
>  ==============
>  
> -Amlogic doesn't provide sources for the firmware and for tools needed
> -to create the bootloader image, so it is necessary to obtain them from
> -the git tree published by the board vendor:
> +To boot the system, u-boot must be combined with several earlier stage
> +bootloaders:
> +
> +* bl2.bin: vendor-provided binary blob
> +* bl21.bin: built from vendor u-boot source
> +* bl30.bin: vendor-provided binary blob
> +* bl301.bin: built from vendor u-boot source
> +* bl31.bin: vendor-provided binary blob
> +* acs.bin: built from vendor u-boot source
> +
> +These binaries and the tools required below have been collected and prebuilt
> +for convenience at <https://github.com/BayLibre/u-boot/releases/>
> +
> +Download and extract the libretech-cc release from there, and set FIPDIR to
> +point to the `fip` subdirectory.
> +
> + > export FIPDIR=/path/to/extracted/fip
> +
> +Alternatively, you can obtain the original vendor u-boot tree which
> +contains the required blobs and sources, and build yourself.
> +Note that old compilers are required for this to build. The compilers here
> +are suggested by Amlogic, and they are 32-bit x86 binaries.
>  
>   > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
>   > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> @@ -53,7 +72,10 @@ the git tree published by the board vendor:
>   > make
>   > export FIPDIR=$PWD/fip
>  
> -Go back to mainline U-Boot source tree then :
> +Once you have the binaries available (either through the prebuilt download,
> +or having built the vendor u-boot yourself), you can then proceed to glue
> +everything together. Go back to mainline U-Boot source tree then :
> +
>   > mkdir fip
>  
>   > cp $FIPDIR/gxl/bl2.bin fip/
> @@ -100,3 +122,14 @@ and then write the image to SD with:
>   > DEV=/dev/your_sd_device
>   > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
>   > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> +
> +Note that Amlogic provides aml_encrypt_gxl as a 32-bit x86 binary with no
> +source code. Should you prefer to avoid that, there are open source reverse
> +engineered versions available:
> +
> +1. gxlimg <https://github.com/repk/gxlimg>, which comes with a handy
> +   Makefile that automates the whole process.
> +2. meson-tools <https://github.com/afaerber/meson-tools>
> +
> +However, these community-developed alternatives are not endorsed by or
> +supported by Amlogic.
> 

