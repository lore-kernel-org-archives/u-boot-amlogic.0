Received: by mail-wr1-f51.google.com with SMTP id 31so56910996wrm.1
        for <u-boot-amlogic@groups.io>; Sat, 27 Jul 2019 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=+b2gI1vItlkbG+L48EqXj5i2IRa12n1IQl/e7NEa2XI=;
        b=BCQPRhc109lLsVfUGFJHEpl4lgQVT1DExrlnlpn7wuXOHBrnRhldOf4QRC27NyfjJH
         004vcQPW/bvdTznnbhUwu1QWCSgj0qTIab8aabJ5I99iPublAMh11E3QjIqvysSm5it5
         ZdZNobcfi4BzuwWvjRXTpVmvvsV5UWz96fvUnLH89Jk2NT8prHxxzgsDGEYJSlz3r4OD
         4OkPc2M0jqscFicGEqoQNLz/jHXK3CcrH1h3XViAQwIy0e8szLmJR73dOl0ziOeFp/GN
         lb63WGUo5t/nzOXveF/29RaZ68q0H7tvkmoDrFMhQsZy8qBN6Uknfd/NqZUPq/xu7EQj
         po4Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: how to encrypt fip for GXB P201 and possible bug in docs
References: <5f5ee7b6-ac19-a33a-3aa0-aebe1b080b0f@baylibre.com>
 <10527.1564164183658025956@groups.io>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <64cc7ec7-1915-d478-1d3c-f78ed22cc051@baylibre.com>
Date: Sat, 27 Jul 2019 12:35:35 +0200
MIME-Version: 1.0
In-Reply-To: <10527.1564164183658025956@groups.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, krecis@gmail.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 26/07/2019 à 20:03, krecis@gmail.com a écrit :
> I'm interested in re-using already existing binaries but for now I'm more interested in closing down on how to build u-boot from sources and get it to work . I'll reserve this for another topic .
> 
> I have successfully compiled the "plain" p212 target ( meaning without any p281 specific step ) and I don't get the very last step inside the readme :
> 
>  > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> and this basically means : copy uboot but skip the first 512 bytes so you can leave the partition table alone

Exact,

> 
>  > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
> what are we doing here ? and most importantly : why just 444 bytes ? my fip/u-boot.bin.sd.bin is 803328 bytes .

The first 444bytes are necessary for booting over sdcard, so we need to copy them at the
start of the sdcard. It's a vendor specificity, at some point we stop trying to understand ;-)

> 
> Also, do you have any suggestions about how to create a complete sd image with kernel and rootfs ? I don't want a complete rootfs but really the bare minimum .

Buildroot, or meta-meson with Yocto or OpenEmbedded

With meta-meson, you can generate a full sdcard image, including u-boot :
https://github.com/superna9999/meta-meson

It contains a profile for amlogic-p281, but without u-boot, only with rootfs and a minimal
fat partition containing a script to boot from vendor u-boot.

With buildroot, it should be able to generate you an ext4 image containing the kernel
and the p281 dtb, since it's all upstream, but you'll need to partition and flash the rootfs
manually.

Neil
 
> 
> 
