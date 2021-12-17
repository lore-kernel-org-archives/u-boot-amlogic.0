Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web12.9214.1639762839829542036
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Dec 2021 09:40:40 -0800
Received: by mail-wr1-f52.google.com with SMTP id a9so5451232wrr.8
        for <u-boot-amlogic@groups.io>; Fri, 17 Dec 2021 09:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=87wcgj1wwhiS8621Aye0xioyBZPOX7F5nj3vDjZB0sw=;
        b=RU1YC1S/05qfRqX+vWjTgmu90daOVQakeNdSMsFbYvuz4BZfAPi5nqh8zI0qLHrJ6A
         VlS5PMkLHaFkoOCt7suAyik5DTNjqA5XxRC9eyWb5XPDemHtjbgrDIevyzM5bqcNTEps
         oTlPNiKoUXINI+7Bvr1bcyZUrDdgCSoSlnkEkgNdot/c4mVN+cN8iS4qhC+cCewmVdUF
         n1bY1Kb46pp+LqdEqJjoyv+hM4YGCzP8dEJgsUzxHROw57qoXcegeIb9wMt8f3ZrRjVl
         jwkrobAFq2trGxOkkN0O5NYu0hmhkdnpC6YGB00LXrfA6CAdzNMNg7twaJEjmdTRR9kd
         ZQqQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v5 25/29] image: Remove #ifdefs from select_ramdisk()
References: <20210926014342.127913-1-sjg@chromium.org>
 <20210926014342.127913-19-sjg@chromium.org>
 <20211009014130.GL7964@bill-the-cat>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <f153017b-c41a-0d32-67b9-f288e695f900@baylibre.com>
Date: Fri, 17 Dec 2021 18:40:36 +0100
MIME-Version: 1.0
In-Reply-To: <20211009014130.GL7964@bill-the-cat>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, Andre Przywara <andre.przywara@arm.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Robert Marko <robert.marko@sartura.hr>, Masahiro Yamada <masahiroy@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 09/10/2021 03:41, Tom Rini wrote:
> On Sat, Sep 25, 2021 at 07:43:38PM -0600, Simon Glass wrote:
> 
>> Use boolean variables to deal with the strange #ifdef logic of this
>> function, so we can remove the #ifdefs.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
> 
> Applied to u-boot/master, thanks!
> 

This commit causes an abort on Libretech-CC when trying to load an initrd (using libretech-cc_defconfig & gcc-arm-9.2-2019.12):

U-Boot 2021.10-00076-gf33a2c1bd0 (Dec 17 2021 - 18:21:08 +0100) libretech-cc

Model: Libre Computer AML-S905X-CC
SoC:   Amlogic Meson GXL (S905X) Revision 21:d (84:2)
DRAM:  2 GiB
MMC:   mmc@72000: 0, mmc@74000: 1
Loading Environment from nowhere... OK
In:    serial
Out:   serial
Err:   serial
[BL31]: tee size: 0
[BL31]: tee size: 0
Net:   eth0: ethernet@c9410000
Hit any key to stop autoboot:  0
(ROM USB boot)
## Executing script at 08000000

Moving Image from 0x8080000 to 0x8200000, end=a6c0000
"Synchronous Abort" handler, esr 0x96000210
elr: 000000000101bd44 lr : 000000000101bf3c (reloc)
elr: 000000007df70d44 lr : 000000007df70f3c
x0 : 0000000000000000 x1 : 000000007dfcd6fc
x2 : 0000000000000003 x3 : 0000000000000000
x4 : 000000007bf74b20 x5 : 0000000000000030
x6 : 0000000000000000 x7 : 0000000000000002
x8 : 000000007bf441c0 x9 : 0000000000000000
x10: 000000007fffffff x11: 0000000000000000
x12: 000000000a6c0000 x13: 000000000a6bffff
x14: 000000007bf49210 x15: 0000000000000020
x16: 000000007df853bc x17: 0000000000000000
x18: 000000007bf52dd0 x19: 000000007dff4e98
x20: 000000007dff4f88 x21: 000000007dff4f90
x22: 0000000000000016 x23: 000000007bf74b20
x24: 0000000000000000 x25: 000000007bf74b48
x26: 0000000000000000 x27: 0000000000000000
x28: 000000007bf74b70 x29: 000000007bf481f0

Code: a9017fff 97fffff5 a8c27bfd d65f03c0 (b9400002)
Resetting CPU ...

Abort is probably in genimg_get_format()

Reverting on master fixes the issue.

Neil
