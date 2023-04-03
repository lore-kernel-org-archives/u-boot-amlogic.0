Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.64319.1680507099107955185
 for <u-boot-amlogic@groups.io>;
 Mon, 03 Apr 2023 00:31:39 -0700
Received: by mail-wm1-f41.google.com with SMTP id n19so16484066wms.0
        for <u-boot-amlogic@groups.io>; Mon, 03 Apr 2023 00:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680507097;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hF/HBH90e248Vk6fn2JWyJqlmDGagbf+inipzYd1lLo=;
        b=EacfELlNnqOC7JSFvi2e0Erf6AcM5/cS76FRYK4XuXJvaRodtz14mNRdUk17wHFcs3
         QEhYZTyR+PG0IcR4LMQMe8z3VozGy1nZWQ9BHwxJvTo/pAEcPtZ7oswJ3ttYT0SYUGgy
         CwCr0rNqnAielYBfFwGAAwqc3214ZkvM/mL6VP1ZVg5ZqkfGHxzXseF02Zxh11BoDdSn
         ziuhqlLhgX5FmWb0Rxx+U7du1MR4kmZCu7249zziV+TmxXXdVWMqiTER8zblhchoCWX5
         DKkNE64IA9Zm15nv39o1mUfJsmW89Oh46IzSpp7ANBioBxqWRjGHPfkIOqKbMl9s5aaU
         vRYQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <d3308f32-275d-7b37-8c03-76984a2b9ddf@linaro.org>
Date: Mon, 3 Apr 2023 09:31:36 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/1] RFC: Move Odroid-C2 to use binman to produce the image
References: <20230401185458.2280200-1-sjg@chromium.org>
 <20230402065454.v2.1.I2d7f563b6a82f32478a7874e36672622aebb7893@changeid>
In-Reply-To: <20230402065454.v2.1.I2d7f563b6a82f32478a7874e36672622aebb7893@changeid>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: u-boot-amlogic@groups.io, Christian Hewitt <christianshewitt@gmail.com>, linux-amlogic@lists.infradead.org, Alper Nebi Yasak <alpernebiyasak@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Simon !

On 01/04/2023 20:54, Simon Glass wrote:
> This shows how binman can be used to replace the long and complicated
> instructions with an automated build. It is still complicated to read
> but users don't have to worry about the details.
> 
> It needs some tidying up and only supports Odroid-C2 at present.

Like the v1, the work is really nice, but the dependency on vendor binary-only
tools doesn't make feel confident about merging this.

We have open source implementation for all boards, but still dependeing on
tools we must manually build isn't optimal.

What would be optimal would be to re-implement those tools into python
libraries and merge them into the u-boot tree then use them from binman.

But this could be merged as first step, them the python libaray could be
modified to support the binary tools & a probable python re-implementation.

Neil

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Rebase to -next
> 
>   arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi | 107 ++++++++++++++++
>   arch/arm/mach-meson/Kconfig                  |   1 +
>   doc/board/amlogic/odroid-c4.rst              | 127 +++++--------------
>   tools/binman/etype/aml_encrypt.py            | 124 ++++++++++++++++++
>   tools/binman/ftest.py                        |   3 +
>   tools/binman/missing-blob-help               |   6 +
>   tools/binman/test/213_aml_encrypt.dts        |  38 ++++++
>   tools/binman/test/214_list_no_dtb.dts        |  23 ++++
>   8 files changed, 337 insertions(+), 92 deletions(-)
>   create mode 100644 tools/binman/etype/aml_encrypt.py
>   create mode 100644 tools/binman/test/213_aml_encrypt.dts
>   create mode 100644 tools/binman/test/214_list_no_dtb.dts
> 
> diff --git a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> index 963bf96b2567..b221ce6920b0 100644
> --- a/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> +++ b/arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
> @@ -6,6 +6,113 @@
>   
>   #include "meson-sm1-u-boot.dtsi"
>   
> +/{
> +	binman {
> +		/* run --bootmk on all the included inputs */
> +		aml-encrypt {
> +			missing-msg = "aml-encrypt";
> +			aml-algo = "g12a";
> +			aml-op = "bootmk";
> +			aml-level = "v3";
> +
> +			/* produce a bl2, containing signed bl2 binaries */
> +			bl2 {
> +				type = "aml-encrypt";
> +				aml-algo = "g12a";
> +				aml-op = "bl2sig";
> +
> +				/* sign the binary contaiing bl2 and acs */
> +				aml-input {
> +					type = "section";
> +					bl2 {
> +						type = "blob-ext";
> +						size = <0xe000>;
> +						filename = "bl2.bin";
> +					};
> +					acs {
> +						type = "blob-ext";
> +						size = <0x1000>;
> +						filename = "acs.bin";
> +					};
> +				};
> +			};
> +
> +			/* produce a bl30, containing signed bl30 binaries */
> +			bl30 {
> +				type = "aml-encrypt";
> +				aml-algo = "g12a";
> +				aml-op = "bl3sig";
> +				aml-level = "v3";
> +				aml-type = "bl30";
> +
> +				/* sign the binary contaiing bl30 and bl301 */
> +				aml-input {
> +					type = "aml-encrypt";
> +					aml-algo = "g12a";
> +					aml-op = "bl30sig";
> +					aml-level = "v3";
> +
> +					/*
> +					 * put bl30 and bl301 together, with
> +					 * the necessary paddiung
> +					 */
> +					aml-input {
> +						type = "section";
> +						bl30 {
> +							type = "blob-ext";
> +							size = <0xa000>;
> +							filename = "bl30.bin";
> +						};
> +						bl301 {
> +							type = "blob-ext";
> +							size = <0x3400>;
> +							filename = "bl301.bin";
> +						};
> +					};
> +				};
> +			};
> +
> +			/* sign the bl31 binary */
> +			bl31 {
> +				type = "aml-encrypt";
> +				aml-algo = "g12a";
> +				aml-op = "bl3sig";
> +				aml-input = "bl31.img";
> +				aml-level = "v3";
> +				aml-type = "bl31";
> +			};
> +
> +			/* sign the bl33 binary (which is U-Boot) */
> +			bl33 {
> +				type = "aml-encrypt";
> +				aml-algo = "g12a";
> +				aml-op = "bl3sig";
> +				aml-compress = "lz4";
> +				aml-level = "v3";
> +				aml-type = "bl33";
> +
> +				aml-input {
> +					type = "u-boot";
> +				};
> +			};
> +
> +			/* add the various DDR blobs */
> +			aml-ddrfw {
> +				missing-msg = "aml-ddrfw";
> +				type = "blob-ext-list";
> +				filenames = "ddr4_1d.fw", "ddr4_2d.fw",
> +					"ddr3_1d.fw", "piei.fw",
> +					"lpddr4_1d.fw", "lpddr4_2d.fw",
> +					"diag_lpddr4.fw", "aml_ddr.fw",
> +					"lpddr3_1d.fw";
> +			};
> +		};
> +
> +		fdtmap {
> +		};
> +	};
> +};
> +
>   &ethmac {
>   	snps,reset-gpio = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
>   	snps,reset-delays-us = <0 10000 1000000>;
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index 6cba2c40ddaa..bcb87ea243c2 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -48,6 +48,7 @@ config MESON_AXG
>   config MESON_G12A
>   	bool "G12A"
>   	select MESON64_COMMON
> +	select BINMAN
>   	help
>   	  Select this if your SoC is an S905X/D2
>   
> diff --git a/doc/board/amlogic/odroid-c4.rst b/doc/board/amlogic/odroid-c4.rst
> index b512c6a3d83d..9b9ea05a6212 100644
> --- a/doc/board/amlogic/odroid-c4.rst
> +++ b/doc/board/amlogic/odroid-c4.rst
> @@ -22,17 +22,8 @@ applies for HC4.
>   
>   Schematics are available on the manufacturer website.
>   
> -U-Boot compilation
> -------------------
> -
> -.. code-block:: bash
> -
> -    $ export CROSS_COMPILE=aarch64-none-elf-
> -    $ make odroid-c4_defconfig
> -    $ make
> -
> -Image creation
> ---------------
> +Setting up binary blobs
> +-----------------------
>   
>   For simplified usage, pleaser refer to :doc:`pre-generated-fip` with codename `odroid-c4` or `odroid-hc4`
>   
> @@ -42,98 +33,50 @@ the git tree published by the board vendor:
>   
>   .. code-block:: bash
>   
> -    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> -    $ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> -    $ tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> -    $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> -    $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +    # This may be needed with this older U-Boot release
> +    apt remove libfdt-dev
>   
> -    $ DIR=odroid-c4
> -    $ git clone --depth 1 \
> +    wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
> +    tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
> +    export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> +
> +    DIR=odroid-c4
> +    git clone --depth 1 \
>          https://github.com/hardkernel/u-boot.git -b odroidg12-v2015.01 \
>          $DIR
>   
> -    $ cd odroid-c4
> -    $ make odroidc4_defconfig
> -    $ make
> -    $ export UBOOTDIR=$PWD
> +    cd odroid-c4
> +    make odroidc4_defconfig
> +    make
> +    export UBOOTDIR=$PWD
> +
> +U-Boot compilation
> +------------------
>   
>   Go back to mainline U-Boot source tree then :
>   
>   .. code-block:: bash
>   
> -    $ mkdir fip
> -
> -    $ wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
> -    $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
> -    $ cp $UBOOTDIR/build/board/hardkernel/odroidc4/firmware/acs.bin fip/
> -    $ cp $UBOOTDIR/fip/g12a/bl2.bin fip/
> -    $ cp $UBOOTDIR/fip/g12a/bl30.bin fip/
> -    $ cp $UBOOTDIR/fip/g12a/bl31.img fip/
> -    $ cp $UBOOTDIR/fip/g12a/ddr3_1d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12a/ddr4_1d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12a/ddr4_2d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12a/diag_lpddr4.fw fip/
> -    $ cp $UBOOTDIR/fip/g12a/lpddr3_1d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12a/lpddr4_1d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12a/lpddr4_2d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12a/piei.fw fip/
> -    $ cp $UBOOTDIR/fip/g12a/aml_ddr.fw fip/
> -    $ cp u-boot.bin fip/bl33.bin
> -
> -    $ sh fip/blx_fix.sh \
> -    	fip/bl30.bin \
> -    	fip/zero_tmp \
> -    	fip/bl30_zero.bin \
> -    	fip/bl301.bin \
> -    	fip/bl301_zero.bin \
> -    	fip/bl30_new.bin \
> -    	bl30
> -
> -    $ sh fip/blx_fix.sh \
> -    	fip/bl2.bin \
> -    	fip/zero_tmp \
> -    	fip/bl2_zero.bin \
> -    	fip/acs.bin \
> -    	fip/bl21_zero.bin \
> -    	fip/bl2_new.bin \
> -    	bl2
> -
> -    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl30sig --input fip/bl30_new.bin \
> -    					--output fip/bl30_new.bin.g12a.enc \
> -    					--level v3
> -    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl30_new.bin.g12a.enc \
> -    					--output fip/bl30_new.bin.enc \
> -    					--level v3 --type bl30
> -    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl31.img \
> -    					--output fip/bl31.img.enc \
> -    					--level v3 --type bl31
> -    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --input fip/bl33.bin --compress lz4 \
> -    					--output fip/bl33.bin.enc \
> -    					--level v3 --type bl33 --compress lz4
> -    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl2sig --input fip/bl2_new.bin \
> -    					--output fip/bl2.n.bin.sig
> -    $ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bootmk \
> -    		--output fip/u-boot.bin \
> -    		--bl2 fip/bl2.n.bin.sig \
> -    		--bl30 fip/bl30_new.bin.enc \
> -    		--bl31 fip/bl31.img.enc \
> -    		--bl33 fip/bl33.bin.enc \
> -    		--ddrfw1 fip/ddr4_1d.fw \
> -    		--ddrfw2 fip/ddr4_2d.fw \
> -    		--ddrfw3 fip/ddr3_1d.fw \
> -    		--ddrfw4 fip/piei.fw \
> -    		--ddrfw5 fip/lpddr4_1d.fw \
> -    		--ddrfw6 fip/lpddr4_2d.fw \
> -    		--ddrfw7 fip/diag_lpddr4.fw \
> -    		--ddrfw8 fip/aml_ddr.fw \
> -    		--ddrfw9 fip/lpddr3_1d.fw \
> -    		--level v3
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make odroid-c4_defconfig
> +    $ BINMAN_TOOLPATHS=$UBOOTDIR/odroid-c4/fip/g12a \
> +      BINMAN_INDIRS="$UBOOTDIR/fip/g12a \
> +      $UBOOTDIR/build/board/hardkernel/odroidc4/firmware \
> +      $UBOOTDIR/build/scp_task" make
>   
>   and then write the image to SD with:
>   
>   .. code-block:: bash
>   
> -    $ DEV=/dev/your_sd_device
> -    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> -    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> +    DEV=/dev/your_sd_device
> +    dd if=image.bin of=$DEV conv=fsync,notrunc
> +
> +If you copy the `$UBOOTDIR/odroid-c4/fip/g12a/aml_encrypt_g12a` tool somewhere
> +in your path, you can omit the `BINMAN_TOOLPATHS` option. The `BINMAN_INDIRS`
> +variable provides a space-seperated list of directories containing the various
> +binary blobs needed by the build.
> +
> +To see these, look at the Binman image description in
> +`arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi`.
> diff --git a/tools/binman/etype/aml_encrypt.py b/tools/binman/etype/aml_encrypt.py
> new file mode 100644
> index 000000000000..3f570702dc58
> --- /dev/null
> +++ b/tools/binman/etype/aml_encrypt.py
> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2016 Google, Inc
> +# Written by Simon Glass <sjg@chromium.org>
> +#
> +# Entry-type module for producing an image using aml-encrypt-g12a
> +#
> +
> +from collections import OrderedDict
> +
> +from binman.entry import Entry
> +from binman.etype.section import Entry_section
> +from binman.etype.blob_ext import Entry_blob_ext
> +from binman.etype.blob_ext_list import Entry_blob_ext_list
> +from dtoc import fdt_util
> +from patman import tools
> +from patman import tout
> +
> +DDR_FW_COUNT = 9
> +
> +class Entry_aml_encrypt(Entry_section):
> +    def __init__(self, section, etype, node):
> +        super().__init__(section, etype, node)
> +        self._entries = OrderedDict()
> +        self.align_default = None
> +        self._aml_algo = None
> +        self._aml_op = None
> +        self._aml_level = None
> +
> +    def ReadNode(self):
> +        super().ReadNode()
> +        self._aml_algo = fdt_util.GetString(self._node, 'aml-algo')
> +        self._aml_op = fdt_util.GetString(self._node, 'aml-op')
> +        self._aml_level = fdt_util.GetString(self._node, 'aml-level')
> +        self._aml_input = fdt_util.GetString(self._node, 'aml-input')
> +        self._aml_compress = fdt_util.GetString(self._node, 'aml-compress')
> +        self._aml_type = fdt_util.GetString(self._node, 'aml-type')
> +        #self._aml_ddrfw = {}
> +        #for i in range(1, DDR_FW_COUNT + 1):
> +            #self._aml_ddrfw[i] = fdt_util.GetString(self._node, f'aml-ddrfw{i}')
> +        self.ReadEntries()
> +
> +    def ReadEntries(self):
> +        """Read the subnodes to find out what should go in this image"""
> +        for node in self._node.subnodes:
> +            etype = None
> +            if node.name.startswith('aml-') and 'type' not in node.props:
> +                etype = 'blob-ext'
> +            entry = Entry.Create(self, node, etype)
> +            entry.ReadNode()
> +            self._entries[entry.name] = entry
> +
> +    def BuildSectionData(self, required):
> +        uniq = self.GetUniqueName()
> +        output_fname = tools.GetOutputFilename('aml-out.%s' % uniq)
> +        args = [f'aml_encrypt_{self._aml_algo}',
> +            f'--{self._aml_op}',
> +            '--output', output_fname
> +            ]
> +        if self._aml_level:
> +            args += ['--level', f'{self._aml_level}']
> +        if self._aml_compress:
> +            args += ['--compress', f'{self._aml_compress}']
> +        if self._aml_type:
> +            args += ['--type', f'{self._aml_type}']
> +        if self._aml_input:
> +            input_pathname = tools.GetInputFilename(
> +                self._aml_input,
> +                self.external and self.section.GetAllowMissing())
> +            if not input_pathname:
> +                missing = True
> +            args += ['--input', f'{input_pathname}']
> +
> +        missing = False
> +        for entry in self._entries.values():
> +            # First get the input data and put it in a file. If not available,
> +            # try later.
> +            entry_data = entry.GetData(required)
> +            if not required and entry_data is None:
> +                return None
> +            flag_name = entry.name.replace('aml-', '')  # Drop the aml- prefix
> +            if isinstance(entry, Entry_blob_ext_list):
> +                for i, pathname in enumerate(entry._pathnames):
> +                    args += [f'--{flag_name}{i + 1}', pathname]
> +            elif isinstance(entry, Entry_blob_ext):
> +                pathname = entry._pathname
> +                args += [f'--{flag_name}', pathname]
> +            else:
> +                data = self.GetPaddedDataForEntry(entry, entry_data)
> +                fname = tools.GetOutputFilename('aml-in.%s' %
> +                                                entry.GetUniqueName())
> +                tools.WriteFile(fname, data)
> +                args += [f'--{flag_name}', fname]
> +            if entry.missing:
> +                missing = True
> +
> +        if missing:
> +            self.missing = True
> +            return b''
> +
> +        tout.Debug(f"Node '{self._node.path}': running: %s" % ' '.join(args))
> +        tools.Run(*args)
> +
> +        # If an input file (or subnode!) is providing the input, the tools
> +        # writes to the requested output file. Otherwise it uses the output file
> +        # as a template for three files that it writes, ending in '.sd.bin',
> +        # 'usb.bl2' and 'usb.tpl'. We use the first one as the image output
> +        if self._aml_input or self._node.FindNode('aml-input'):
> +            real_outfile = output_fname
> +        else:
> +            real_outfile = f'{output_fname}.sd.bin'
> +        data = tools.ReadFile(real_outfile)
> +        return data
> +
> +    def SetAllowMissing(self, allow_missing):
> +        self.allow_missing = allow_missing
> +
> +    def SetImagePos(self, image_pos):
> +        Entry.SetImagePos(self, image_pos)
> +
> +    def SetCalculatedProperties(self):
> +        Entry.SetCalculatedProperties(self)
> +
> +    def CheckEntries(self):
> +        Entry.CheckEntries(self)
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 43b4f850a691..10297d87f3e9 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -6676,6 +6676,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>                                   ['fit'])
>           self.assertIn("Node '/fit': Missing tool: 'mkimage'", str(e.exception))
>   
> +    def testAmlEncrypt(self):
> +        self._DoTestFile('213_aml_encrypt.dts', allow_missing=True)
> +
>   
>   if __name__ == "__main__":
>       unittest.main()
> diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
> index f013367ac36b..37264274c901 100644
> --- a/tools/binman/missing-blob-help
> +++ b/tools/binman/missing-blob-help
> @@ -50,3 +50,9 @@ See the documentation for your board. The OpenSBI git repo is at
>   https://github.com/riscv/opensbi.git
>   You may need to build fw_dynamic.bin first and re-build u-boot with
>   OPENSBI=/path/to/fw_dynamic.bin
> +
> +aml-encrypt:
> +Some AML messages
> +
> +aml-ddrfw
> +Amlogic DDR firmware files are missing
> diff --git a/tools/binman/test/213_aml_encrypt.dts b/tools/binman/test/213_aml_encrypt.dts
> new file mode 100644
> index 000000000000..513da65d500a
> --- /dev/null
> +++ b/tools/binman/test/213_aml_encrypt.dts
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	binman {
> +		aml-encrypt {
> +			missing-msg = "aml-encrypt";
> +			aml-algo = "g12a";
> +			aml-op = "bootmk";
> +			aml-level = "v3";
> +
> +			aml-bl2 {
> +				filename = "bl2.n.bin.sig";
> +			};
> +			aml-bl30 {
> +				filename = "bl30_new.bin.enc";
> +			};
> +			aml-bl31 {
> +				filename = "bl31.img.enc";
> +			};
> +			aml-bl33 {
> +				filename = "bl33.bin.enc";
> +			};
> +			aml-ddrfw {
> +				missing-msg = "aml-ddrfw";
> +				type = "blob-ext-list";
> +				filenames = "ddr4_1d.fw", "ddr4_2d.fw",
> +					"ddr3_1d.fw", "piei.fw",
> +					"lpddr4_1d.fw", "lpddr4_2d.fw",
> +					"diag_lpddr4.fw", "aml_ddr.fw",
> +					"lpddr3_1d.fw";
> +			};
> +		};
> +	};
> +};
> diff --git a/tools/binman/test/214_list_no_dtb.dts b/tools/binman/test/214_list_no_dtb.dts
> new file mode 100644
> index 000000000000..47ecd0586447
> --- /dev/null
> +++ b/tools/binman/test/214_list_no_dtb.dts
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	binman {
> +		size = <0x300>;
> +		atf-bl31 {
> +			filename = "bl31.bin";
> +		};
> +		scp {
> +			filename = "scp.bin";
> +		};
> +		fdtmap {
> +		};
> +		image-header {
> +			location = "end";
> +		};
> +	};
> +};

