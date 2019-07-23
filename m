Received: by mail-wr1-f68.google.com with SMTP id f9so41994249wre.12
        for <u-boot-amlogic@groups.io>; Tue, 23 Jul 2019 00:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/IKgaP+iuwPnYqXdl3HJABOrtKl4WQMfjqGR+sJRIQE=;
        b=IckrHwX3RkLixI7ou6qBtBB/Ntk5h5cxCb+vri3xB6zqr3P52uqKqJoWKSbjnFfNWi
         cqe1Q1NpTFJzY3cFygqFNaDLzDmrVVx/S3H38jRRhYRNFYBQCPYTR63B4slCgPde/WC8
         7LuAkuQss3mN0ByXgk3OxPwbiM75rGOsqAJloQ7SLIV+udqjA2AnqZOr2J/XCwv81oHC
         b/MYfH6LE2vQvOKcEmvVAygSQEZ4n3PuvnqABN7cTojOX844k7T4Wws3HXmuMLTA0WvV
         zy18S2VmSVSaGNXdoD9sCi2sWkRhgCAeTkig/kX87solkFVAbvgfSMS7u6EObOkUooHN
         aSLA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [U-Boot] [PATCH 3/3] board: amlogic: add support for Odroid-N2
References: <20190722094814.25602-1-narmstrong@baylibre.com>
 <20190722094814.25602-4-narmstrong@baylibre.com>
 <CANAwSgQT72L_xGRBnbWbVvPMBxy1FTaQMM2KmDBp9n7442m39Q@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <00670e7b-f8f4-84e0-56e9-e84d26e4e2c1@baylibre.com>
Date: Tue, 23 Jul 2019 09:49:10 +0200
MIME-Version: 1.0
In-Reply-To: <CANAwSgQT72L_xGRBnbWbVvPMBxy1FTaQMM2KmDBp9n7442m39Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Anand,

On 22/07/2019 19:08, Anand Moon wrote:
> Hi Neil,
> 
> On Mon, 22 Jul 2019 at 16:00, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> ODROID-N2 is a single board computer manufactured by Hardkernel Co. Ltd
>> with the following specifications:
>>
>>  - Amlogic S922X ARM Cortex-A53 dual-core + Cortex-A73 quad-core SoC
>>  - 4GB DDR4 SDRAM
>>  - Gigabit Ethernet
>>  - HDMI 2.1 4K/60Hz display
>>  - 40-pin GPIO header
>>  - 4 x USB 3.0 Host, 1 x USB OTG
>>  - eMMC, microSD
>>  - Infrared receiver
>>
>> The board directory is W400, the name of the Amlogic Reference Design
>> of Amlogic G12B with Gigabit boards, which will be used for similar
>> boards.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  board/amlogic/w400/MAINTAINERS      |   6 ++
>>  board/amlogic/w400/Makefile         |   6 ++
>>  board/amlogic/w400/README.odroid-n2 | 130 ++++++++++++++++++++++++++++
>>  board/amlogic/w400/README.w400      | 130 ++++++++++++++++++++++++++++
>>  board/amlogic/w400/w400.c           |  18 ++++
>>  configs/odroid-n2_defconfig         |  56 ++++++++++++
>>  6 files changed, 346 insertions(+)
>>  create mode 100644 board/amlogic/w400/MAINTAINERS
>>  create mode 100644 board/amlogic/w400/Makefile
>>  create mode 100644 board/amlogic/w400/README.odroid-n2
>>  create mode 100644 board/amlogic/w400/README.w400
>>  create mode 100644 board/amlogic/w400/w400.c
>>  create mode 100644 configs/odroid-n2_defconfig
>>
[..]

>> +
>> + > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
>> + > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
>> + > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
>> + > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
>> + > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
>> +
> 
> Should we checkout odroidn2-v2015.01 from Hardkernel repository.

Yes, you are right it's a typo !

> 
> 
>> + > DIR=odroid-c2
>> + > git clone --depth 1 \
>> +       https://github.com/hardkernel/u-boot.git -b odroidc2-v2015.01 \
>> +       $DIR
>> +

[..]

Thanks,
Neil
