Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.75343.1679583694435689057
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 08:01:53 -0700
Received: by mail-wr1-f52.google.com with SMTP id o7so20867234wrg.5
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679583712;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uEHvgVa+LMqKq7QEat5OceTqZ/J0ejozXR/RKqCohbU=;
        b=TrGatbLPt+7oXQgTgKiavdyRQskWVWYwahHszJiy6iY13ZbNxGgtAqYCGmoUVu14w7
         /HZUSTkPuaQ3CFe5IqWRe539+f3+NRrzqfuuWMxeteUvJDN4CLIwEl3SY7G32hsWcnHp
         GpF58NKuWfudeNh4YHO6BlSVhpkyciCBpZ04nxHPA/iTKypvEw3VfEZBBu/6DmSYYdmo
         hEgA4UbR88je4mFFltZCviMx7m1xpZnVefKeONwQckHGTFFp090MePTjUKEX5XX2IQxB
         f7mD0nmtdxIEn+xnXJpLzS/DjzpC63oaRcxmF4O1ijI+rIr02aJ3/4N0O88LbSDfr0fM
         Ko/g==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <5debe002-5973-58e1-8e86-ea2732c2faf5@linaro.org>
Date: Thu, 23 Mar 2023 16:01:51 +0100
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 11/14] doc: boards: amlogic: add documentation for Radxa Zero2
References: <20230323143142.780306-1-christianshewitt@gmail.com>
 <20230323143142.780306-12-christianshewitt@gmail.com>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230323143142.780306-12-christianshewitt@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com, u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 23/03/2023 15:31, Christian Hewitt wrote:
> Add build docs for the Radxa Zero2 board.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   board/amlogic/w400/MAINTAINERS    |  2 +
>   doc/board/amlogic/index.rst       |  1 +
>   doc/board/amlogic/radxa-zero2.rst | 80 +++++++++++++++++++++++++++++++
>   3 files changed, 83 insertions(+)
>   create mode 100644 doc/board/amlogic/radxa-zero2.rst
> 
> diff --git a/board/amlogic/w400/MAINTAINERS b/board/amlogic/w400/MAINTAINERS
> index 042b523056..117f79ea04 100644
> --- a/board/amlogic/w400/MAINTAINERS
> +++ b/board/amlogic/w400/MAINTAINERS
> @@ -5,6 +5,8 @@ L:	u-boot-amlogic@groups.io
>   F:	board/amlogic/w400/
>   F:	configs/bananapi-cm4-cm4io_defconfig
>   F:	configs/bananapi-m2s_defconfig
> +F:	configs/radxa-zero2_defconfig
>   F:	doc/board/amlogic/w400.rst
>   F:	doc/board/amlogic/bananapi-cm4io.rst
>   F:	doc/board/amlogic/bananapi-m2s.rst
> +F:	doc/board/amlogic/radxa-zero2.rst
> diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
> index fa1b362731..71b7e1f3ed 100644
> --- a/doc/board/amlogic/index.rst
> +++ b/doc/board/amlogic/index.rst
> @@ -112,6 +112,7 @@ Board Documentation
>      p212
>      q200
>      radxa-zero
> +   radxa-zero2
>      sei510
>      sei610
>      s400
> diff --git a/doc/board/amlogic/radxa-zero2.rst b/doc/board/amlogic/radxa-zero2.rst
> new file mode 100644
> index 0000000000..dccf592459
> --- /dev/null
> +++ b/doc/board/amlogic/radxa-zero2.rst
> @@ -0,0 +1,80 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +U-Boot for Radxa Zero2 (A311D)
> +==============================
> +
> +Radxa Zero2 is a small form factor SBC based on the Amlogic A311D chipset with the
> +following specification:
> +
> +- Amlogic A311D (Quad A73 + Dual A53) CPU
> +- 4GB LPDDR4 RAM
> +- 32/64/128GB eMMC
> +- Mali G52-MP4 GPU
> +- HDMI 2.1 output (micro)
> +- BCM4345 WiFi (2.4/5GHz a/b/g/n/ac) and BT 5.0
> +- 1x USB 2.0 port - Type C (OTG)
> +- 1x USB 3.0 port - Type C (Host)
> +- 1x micro SD Card slot
> +- 40 Pin GPIO header
> +
> +Schematics are available on request from Radxa.
> +
> +U-Boot Compilation
> +------------------
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make radxa-zero2_defconfig
> +    $ make
> +
> +U-Boot Signing with Pre-Built FIP repo
> +--------------------------------------
> +
> +.. code-block:: bash
> +
> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> +    $ cd amlogic-boot-fip
> +    $ mkdir my-output-dir
> +    $ ./build-fip.sh radxa-zero2 /path/to/u-boot/u-boot.bin my-output-dir
> +
> +U-Boot Manual Signing
> +---------------------
> +
> +Amlogic does not provide sources for the firmware and tools needed to create a bootloader
> +image so it is necessary to obtain binaries from sources published by the board vendor:
> +
> +.. code-block:: bash
> +
> +    $ git clone -b radxa-zero-v2021.07 https://github.com/radxa/u-boot.git
> +    $ git clone https://github.com/radxa/fip.git
> +
> +    $ sudo apt-get install -y gcc-aarch64-linux-gnu device-tree-compiler libncurses5 libncurses5-dev
> +    $ sudo apt-get install -y bc python dosfstools flex build-essential libssl-dev mtools
> +
> +    $ wget https://developer.arm.com/-/media/Files/downloads/gnu-a/10.3-2021.07/binrel/gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf.tar.xz
> +    $ sudo tar xvf gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf.tar.xz -C /opt
> +
> +    $ export CROSS_COMPILE=/opt/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf/bin/aarch64-none-elf-
> +    $ export ARCH=arm
> +    $ cd u-boot
> +    $ make radxa-zero2_defconfig
> +    $ make
> +
> +    $ cp u-boot.bin ../fip/radxa-zero2/bl33.bin
> +    $ cd ../fip/radxa-zero2
> +    $ make
> +
> +This will generate the signed U-Boot binaries:
> +
> +.. code-block:: bash
> +
> +    $ u-boot.bin u-boot.bin.sd.bin u-boot.bin.usb.bl2 u-boot.bin.usb.tpl
> +
> +Then write U-Boot to SD or eMMC with:
> +
> +.. code-block:: bash
> +
> +    $ DEV=/dev/boot_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
