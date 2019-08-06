Date: Tue, 6 Aug 2019 10:40:00 +0200
From: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH] board: amlogic: document alternative libretech-cc installation methods
Message-ID: <20190806084000.GT12859@voidbox.localdomain>
References: <20190806081042.26399-1-drake@endlessm.com>
MIME-Version: 1.0
In-Reply-To: <20190806081042.26399-1-drake@endlessm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Daniel Drake <drake@endlessm.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, afaerber@suse.de, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Daniel,

On Tue, Aug 06, 2019 at 04:10:42PM +0800, Daniel Drake wrote:
> As already documented in this README, several binaries must be
> glued together in order to boot the device.
> 
> Extend the documentation to cover the prebuilt binaries
> (saving you the hassle of installing ancient cross-compilers),
> and also mention the open source replacements for the encryption
> tool (which is especially useful if you want to avoid requiring
> 32-bit x86 binaries in your build system).
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

I don't know if it worth being mentioned here, but there is also a
reverse engineered effort on bl31 for gxl.

Thus it should be possible to use a bl31 built from mainline branch of
https://github.com/ARM-software/arm-trusted-firmware.

-- 
Remi

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
> -- 
> 2.20.1
> 
