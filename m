Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.11696.1693468454428321439
 for <u-boot-amlogic@groups.io>;
 Thu, 31 Aug 2023 00:54:14 -0700
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-31c93d2a24fso328328f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 31 Aug 2023 00:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693468453; x=1694073253; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9o4jIzgTDzCS8keb/VJxcr5uR2GxGl78aPztqyoXlc=;
        b=qXgIYbQHbdOK3ZZ6YW0BSm28KjHDqYg5XHK+xHWltSfrdrZwk4m2Ez6XvhAEjbzBpp
         TNkIF6VLQiErPDitYqonu91L0+GPAUYT4LpZqQ3lqfjf8Pws7T214O2Z24NId/7vJLNv
         O3Wo+nbAf26Ut1lXy4Ve8EP7C+e1CE8xhK1gYhHhxtjrolbtNI1V3ydxYAGjcofdKsSb
         qAju2w68YOlcgeME2VpI/60DnKGD+6rW9zk18fZ2zwLowvWotD5Jk01K+3LmPkWt7KGH
         x3ZteFy13TDlKxHpNVyOetWLw4ppShHwpb+Hul4ACM5WJi1VMubGF8CJ5FfhOe8IX0xZ
         LQNQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <d94b0cae-99cc-4f8b-9d0d-52a5858f6e33@linaro.org>
Date: Thu, 31 Aug 2023 09:54:10 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/1] meson: Demonstration of using binman to produce the image
References: <CV61D7ULLVZ0.3OCFZ743L1KSE@flaptop>
 <CAPnjgZ2iff6F3CFjnjEMUVoX3bO=kv3za4Q45YOcVeZqc96=rw@mail.gmail.com>
In-Reply-To: <CAPnjgZ2iff6F3CFjnjEMUVoX3bO=kv3za4Q45YOcVeZqc96=rw@mail.gmail.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>, Ferass El Hafidi <vitali64pmemail@protonmail.com>
Cc: christianshewitt@gmail.com, mark.kettenis@xs4all.nl, u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org, alpernebiyasak@gmail.com, da@lessconfused.com
List-ID: <u-boot-amlogic@groups.io>

On 31/08/2023 05:37, Simon Glass wrote:
> Hi Ferass,
> 
> On Wed, 30 Aug 2023 at 11:53, Ferass El Hafidi
> <vitali64pmemail@protonmail.com> wrote:
>>
>> Hi Simon,
>>
>>> So I wonder how best to move this forward so that we can build things
>>> using binman and everything works?
>>
>> It's still not ready yet, but I'm working on porting U-Boot SPL to some
>> Amlogic SoCs [1]. I'm currently working on Amlogic S905 boards, but
>> eventually I'll work on Amlogic S905X devices too. And speaking of
>> signing, Jonas Karlman wrote amlimage, and integrated it into mkimage,
>> and I applied his patch to my tree. There's a few things to be aware of
>> about Amlogic signing and binaries in general, however.
>>
>> amlimage was intended for use with U-Boot SPL, which obviously has
>> no support for Amlogic's FIP format and as such amlimage will only do as
>> little as possible to get the bootROM to load U-Boot SPL. Most of the
>> packaging format is handled by BL2. The fact that the signing process is
>> completly different across SoC generations makes it difficult to
>> implement them all into one single tool (and by which I mean all of it,
>> not just signing BL2 for the bootROM to run it, that's mostly the same
>> across SoCs). amlimage has been confirmed to work on GXBB (ODROID-C2 and
>> the KII Pro set-top box), GXL (librecomputer lepotato), and SM1 (ODROID-C4).
>>
>> My U-Boot SPL port is still rather incomplete. As of today, it still
>> can't boot anything from any storage device. The goal eventually is to
>> be able to load upstream TF-A BL31 and U-Boot+linux.
>>
>> While Amlogic distributes proprietary BL31 binaries upstream Trusted
>> Firmware-A has a port for some Amlogic SoCs [2], but as far as I know
>> SM1 (which is the SoC generation your ODROID-C4 is using) is still
>> unsupported. GXBB, GXL, AXG, and G12A are all supported however, but the
>> overall port still lacks some features the proprietary implementation
>> has.
>>
>> As for the SCP firmware (aka. BL30) I'm not aware of any
>> reverse-engineering efforts for that.
>>
> 
> Thanks for your efforts on this. I look forward to seeing where it ends up.
> 
>> Honestly, in my opinion, including proprietary and poorly-written
>> Amlogic utilities lacking a proper license, into U-Boot looks like a bad idea.
> 
> With Binman, we don't really include them in U-Boot; we allow them to
> be fetched easily so that a complete build can be produced.
> 
> I don't like it either, but for users it is better than doing the
> build manually.

I'll rather spend time and effort to have a fully-upstream TF-A boot chain
for Amlogic SoC (when possible) that maintaining support for bulky closed-source
x86-64 binary only tools. The tools aren't even officially distributed.

Neil

> 
>>
>> [1]: https://git.vitali64.duckdns.org/misc/u-boot-kii-pro.git/log/?h=wip/spl
>> [2]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/amlogic
>>
>> Cheers.
>>
> 
> Regards,
> Simon

