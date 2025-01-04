Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BC7E77198
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 08:55:50 +0000 (UTC)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 by mx.groups.io with SMTP id smtpd.web11.28429.1736029405920593227
 for <u-boot-amlogic@groups.io>;
 Sat, 04 Jan 2025 14:23:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kwiboo.se header.s=fe-e1b5cab7be header.b=I6g6R8yt;
 spf=pass (domain: fe-bounces.kwiboo.se, ip: 207.246.76.47, mailfrom: srs0=80b6=t5=kwiboo.se=jonas@fe-bounces.kwiboo.se)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1736029404;
 bh=AD6yXlcYwaxD5KH+Q03US9rXi0xAQeeVqfrZzdheWeo=;
 b=I6g6R8ytdjiV29oRXBYkPxvElfyCVeBULpnJGr4BdrwWXv94GHahABhWzf6i4Aq4fuHZLxyPo
 Tk0no6SFyD8MZVSgjTkm9XWPXN8DAVdQLNdKpvOEGNB5L2+cd6/FvnzJXwi8jBjYhEJc6RHji6P
 ysrv/+VJK7ZLQ1OPHFtTkSkRmo7CIU2ddCQdpuxRvkT9XsC/aJUf5OVDNBrEMWeYDlVmusABHDd
 +AsXtdToCuffM2smUp4whPM6uevF4eJFSAHRmt1Qm/J52bzOML7EKNwbGm6TM1ra99lOM16nbBD
 ODXtUmfReDIwM8LT+wXCQ7sQppBmByW+GwQb2axGds1A==
X-ForwardEmail-Version: 0.4.40
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Received: from [192.168.2.234] ([78.69.151.207]
 78-69-151-207-no600.tbcn.telia.com) by smtp.forwardemail.net (Forward
 Email) with ESMTPSA (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384); Sat,
 04 Jan 2025 22:23:16 +0000
Message-ID: <754d7695-f184-4096-980e-90df66fb2b87@kwiboo.se>
Date: Sat, 4 Jan 2025 23:23:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tools: amlimage: Add support for GXBB eMMC header
To: Simon Glass <sjg@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250103215904.2590769-1-jonas@kwiboo.se>
 <20250103215904.2590769-3-jonas@kwiboo.se>
 <CAFLszTgehJLKF+ty4jig=JGpb9Z2rBu50+8_KcrX4ZzM4bD-Cw@mail.gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTgehJLKF+ty4jig=JGpb9Z2rBu50+8_KcrX4ZzM4bD-Cw@mail.gmail.com>
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6779b4d77402a36e73d823be
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 06 Jan 2025 08:55:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2604

Hi Simon,

On 2025-01-04 20:31, Simon Glass wrote:
> Hi Jonas,
> 
> On Sat, 4 Jan 2025 at 10:59, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> GXBB BL1 only tries to read boot image from sector 0 on eMMC and sector
>> 1 on SD-card. GXL and newer read boot image from sector 1 on both eMMC
>> and SD-card.
>>
>> Vendor BL2 have solved the issue with different offsets by considering
>> where BL2 was loaded from to adjust the offset where BL3 is read from.
>>
>> This provide a different solution to create a boot image that can be
>> booted from both eMMC and SD-card and where the offset for reading next
>> stage loader can be shared for both boot options.
>>
>> Inject code, that relocate the payload located at 0x1200 offset in TZRAM
>> to the expected offset of 0x1000, into the padding area at offset 0x200
>> when a normal GXBB boot image is created. A special GXBB eMMC header can
>> then be created that have the payload offset point to this relocate
>> code, BL1 will jump to this relocate code when booted from eMMC instead
>> of the normal payload start. One effect of this is that the payload size
>> limit must be reduced by 512 bytes on GXBB.
>>
>> Example of how to use it:
>>   # Create a normal boot image
>>   tools/mkimage -T amlimage -n gxbb -d u-boot-spl.bin bl2.bin
>>
>>   # Create a boot image with a special eMMC header
>>   tools/mkimage -T amlimage -n emmc -d bl2.bin bl2-emmc.bin
>>
>>   # Write normal boot image to sector 1 of eMMC/SD-card
>>   dd if=bl2.bin of=/path/to/dev bs=512 seek=1
>>
>>   # Write eMMC header, 112 bytes, to start of eMMC
>>   dd if=bl2-emmc.bin of=/path/to/dev bs=1 count=112
>>
>> Or with binman using something like:
>>   binman {
>>         multiple-images;
>>
>>         u-boot-gxbb-sd {
>>                 filename = "u-boot-gxbb-sd.bin";
>>                 pad-byte = <0xff>;
>>
>>                 mkimage {
>>                         filename = "bl2.bin";
>>                         args = "-n", "gxbb", "-T", "amlimage";
>>
>>                         u-boot-spl {
>>                         };
>>                 };
>>         };
>>
>>         u-boot-gxbb-emmc {
>>                 filename = "u-boot-gxbb-emmc.bin";
>>                 pad-byte = <0xff>;
>>
>>                 mkimage {
>>                         filename = "bl2-emmc.bin";
>>                         args = "-n", "emmc", "-T", "amlimage";
>>
>>                         blob-ext {
>>                                 filename = "bl2.bin";
>>                         }
>>                 };
>>         };
>>   };
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  tools/amlimage-gxbb-relocate.c | 79 ++++++++++++++++++++++++++++++++++
>>  tools/amlimage.c               | 37 ++++++++++++++++
>>  2 files changed, 116 insertions(+)
>>  create mode 100644 tools/amlimage-gxbb-relocate.c
>>
> 
> I sent [1] some years ago and would quite like to enable the odroid-c2
> in my lab. Is that an older version of what you are supporting here?

The amlimage type in this series is only for creating an image format
that the SoCs BootROM (BL1) can understand. This image type will most
likely only be useful together with Ferass El Hafidi's U-Boot SPL work
or for someone wanting to run bare metal code from SRAM on these SoCs.

Vendor bl2.bin blobs is based on TF-A, is already in correct image
format and expect next stage payload to be signed using a Amlogic FIP
format. For this you will still need to use vendor tools or open source
tools like meson-tools, gxlimg or meson64-tools.

The amlogic-boot-fip repo [2] has blobs, vendor tools and Makefiles to
combine the blobs with a U-Boot proper u-boot.bin to create a firmware
image that should boot for a wide range of boards.

[2] https://github.com/LibreELEC/amlogic-boot-fip

> 
> I heard that there are people working on open source tools, but it has
> been a few years and I'd be quite OK to just use vendor tools.

Open-source tools exist to replace the binary-only Amlogic tools:
- https://github.com/afaerber/meson-tools (GXBB, GXL & GXM only)
- https://github.com/repk/gxlimg (GXBB, GXL, GXM & AXG only)
- https://github.com/angerman/meson64-tools (developed for G12B, should work on G12A & SM1)

Would be nice if someone would combine those into a mkimage amlfip type
or similar (a different format than this amlimage format).

> 
> For your docs, could you put them in doc/ instead?

Not fully sure what you want me to put in doc/, please be specific. The
code comments and commit message should already document as much as
possible until there is upstream use of the GXBB eMMC header workaround.

At such time something like following could be documented:

  Write image to SD-card or eMMC module:
    dd if=u-boot-amlogic.bin of=/path/to/dev bs=512 seek=1 conv=fsync,notrunc

  Write the eMMC header to eMMC module:
    dd if=u-boot-gxbb-emmc.bin of=/path/to/dev bs=1 count=112 conv=fsync,notrunc

Until Ferass El Hafidi's U-Boot SPL work has made its way upstream such
commands and information would purely be speculative and will be easier
to document in a future series.

Regards,
Jonas

> 
> [..]
> 
> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20211124040954.699821-8-sjg@chromium.org/


