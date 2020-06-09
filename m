Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.140.1591728974426127054
 for <u-boot-amlogic@groups.io>;
 Tue, 09 Jun 2020 11:56:15 -0700
Received: by mail-wr1-f53.google.com with SMTP id q11so22537728wrp.3
        for <u-boot-amlogic@groups.io>; Tue, 09 Jun 2020 11:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=auHOzpQuQoAHcNz4/rgZ15Y5DU/JKJMUXM1EHLTvSoY=;
        b=uyQ484XafKYgLj6OVA9BdotFUxcdxrJPj5MMq7TOGl0TLAvOTQmZzfjIXlovh/og8j
         6k7Upk8flyZY5TCAFbjok9RRjXdoyDkLKyoq100AoQzkZS05oC82JqiB4vAGTzcyO3Zg
         f2j74td9WVaCdHq1OTrL4UXXIFM8KaTIxn/R2bZrBJmKfwbLbV6VlJzGbOwMzqTxnOmD
         D7J1VYV2mRxMZV6HxmToAEzdlg8zoWuZ9i+M/Yv1KIAOgEaLKOLONXL1ARcGQzFFee1m
         etiOuN3TdjEKx/32DsRRWmJS5L7pFbJmHS4uxmI33VUPptoSqxOqMFU98FKCBIUtvgIF
         BBrA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: Unable to build n-amlogic-openlinux-20170606 branch
References: <rzSV.1591619492938357935.gFRa@groups.io>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <e847feed-4606-a0fb-6cc0-a274483664fe@baylibre.com>
Date: Tue, 9 Jun 2020 20:56:10 +0200
MIME-Version: 1.0
In-Reply-To: <rzSV.1591619492938357935.gFRa@groups.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, krecis@gmail.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 08/06/2020 à 14:31, krecis@gmail.com a écrit :
> Hi,
> according to the file README.p200 in the mainline u-boot, I need to build both the mainline u-boot and a some other extra bits from a second vendor-specific repository . In the case of the P200 is the n-amlogic-openlinux-20170606 from Baylibre .
> 
> Now here is a short script that reproduces the problem I'm having ( notice the use of sed because there is an hardcoded path inside a Makefile )
> [ START of the script ]
> #!/bin/zsh
> set -e
> ROOT_DIR="${PWD}/firmware_build_cache"
> 
> mkdir "${ROOT_DIR}"
> cd "${ROOT_DIR}"
> 
> curl -sL https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz | tar xfJ -
> curl -sL https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz | tar xfJ -
> 
> export PATH=${PATH}:${ROOT_DIR}/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:${ROOT_DIR}/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin
> 
> git clone --depth=1 https://github.com/BayLibre/u-boot.git -b n-amlogic-openlinux-20170606 amlogic-u-boot
> cd amlogic-u-boot
> sed -i -e '/export\ /s/\/opt\/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux\/bin\///' Makefile
> make gxb_p200_v1_defconfig
> make
> [ END of the script ]
> 
> the error that I get is
> [ START log ]
> make[1]: aarch64-none-elf-gcc: No such file or directory


aarch64-none-elf-gcc: is not found in your PATH.

Neil


> /bin/sh: /tmp/firmware_build_cache/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin/aarch64-none-elf-gcc: No such file or directory
> dirname: missing operand
> Try 'dirname --help' for more information.
>   GEN     ./Makefile
> scripts/kconfig/conf --silentoldconfig Kconfig
>   CHK     include/config.h
>   UPD     include/config.h
>   GEN     include/autoconf.mk
> /bin/sh: /tmp/firmware_build_cache/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin/aarch64-none-elf-gcc: No such file or directory
> make[3]: *** [../scripts/Makefile.autoconf:64: include/autoconf.mk] Error 1
> make[2]: *** [../Makefile:477: silentoldconfig] Error 1
> make[1]: *** No rule to make target 'include/config/auto.conf', needed by 'include/config/uboot.release'.  Stop.
> make: *** [Makefile:147: sub-make] Error 2
> [ END log ]
> 
> Now, I checked files and configs and it does not seem to be anything wrong with that .
> I have noticed that make does something weird, inside the top Makefile there is an invocation that moves to the <build> subdir, and inside the <build> dir there is an invocation to the top Makefile : why ? 
> 
> What I'm doing wrong ?
> 
> 
> 
