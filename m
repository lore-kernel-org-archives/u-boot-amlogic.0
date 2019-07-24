Received: by mail-wr1-f49.google.com with SMTP id p17so45573978wrf.11
        for <u-boot-amlogic@groups.io>; Tue, 23 Jul 2019 23:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Mm7GTnCdGQbUBin+hEsGkDf1UX2fNY/YbE/iadYRUf0=;
        b=u4YSsPRM9XXHqCYnWSOFIwCglS+LmDvtQ0kT02xMxvczsK89bIjF6CKtaEFI+P4EFE
         YqQPmb8V2QPPcT68Pd6mObf0YJ2uFpL6+TEA7Or1HeflsVVlZbNXyXNBvyN3XV1V7DB4
         5rupkIT6r7O166uL2STV9rX+k2BSwm3+oTILXMEWPi/HoZILCc2TuFcYSz17mcJclQOe
         GGm3BWs3y28duUy9wh/3uYp00NoX5qIQTPPMbbcpaxXworPzDytlz7kZNDkDVrKrfq4G
         Z5AMh4faNvM4lMlh/LfxQBbc7gip7MKYnQeTPAaVsE6slT7YZZmgQgyqlFBYhmYF/lBb
         4/Yg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: how to encrypt fip for GXB P201 and possible bug in docs
References: <28195.1563904673848199695@groups.io>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <16bdc4f8-71de-05c0-f976-0a9a76e96f57@baylibre.com>
Date: Wed, 24 Jul 2019 08:45:23 +0200
MIME-Version: 1.0
In-Reply-To: <28195.1563904673848199695@groups.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, krecis@gmail.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 23/07/2019 19:57, krecis@gmail.com wrote:
> Hi,
> this is my first approach to both u-boot and this group, I have an S905w based board .

S905w is a derivative from S905X, not S905 (without X), S905 is GXBB and S905W, like S905X, S905L, S805X, S805Y, is from the GXL family.

> Here is my problem :
> in the vanilla u-boot ( version 2019.07 ), there is a txt file ( u-boot-amlogic/board/amlogic/p201/README.p201 ) containing instructions on how to build the bootloader that you need in order to boot from an SD card starting from the p201_defconfig .

So you should start from the P212 instead, which is the reference board for S905X, we don't support reference designs for S905W since this
soc is not sold for SBCs, but only on final products.

> 
> The problem is that I think that the original author mixed the two GXB and GXL targets and wrote something about GXL inside a document intended for GXB targets .
> 
> According to the description the gxb_p201_v1_defconfig is the target that I'm looking for ( considering the S905W hardware properties ) and it's a GXB target that uses "aml_encrypt_gxb" and not "aml_encrypt_gxl", infact after building the suggested amlogic-openlinux-20170606 Baylibre branch I have a "fip/gxb" populated with all the expected files where the "fip/gxl" content is not enough to build anything.

The P201 is really the S905 reference design for GXBB.

> 
> from this point on I'm unable to build anything since the last instructions in the README.p201 are mentioning files that are simply not generated and an utility like aml_encrypt_gxl which I don't think I should use for my P201 GXB target .
> 
> Am I wrong ? what are the final steps to create the right u-boot.bin.sd.bin by "adding together" the vanilla and Baylibre builds ?

Please retry from the P212 target, and tell me your results.

Typos may still occur, and I'll be happy to apply fixes !

Neil

> 
> 
> 

