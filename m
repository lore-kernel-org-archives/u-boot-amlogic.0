Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.152965.1680767081451247740
 for <u-boot-amlogic@groups.io>;
 Thu, 06 Apr 2023 00:44:41 -0700
Received: by mail-wr1-f51.google.com with SMTP id r29so38535447wra.13
        for <u-boot-amlogic@groups.io>; Thu, 06 Apr 2023 00:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680767080; x=1683359080;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6745kLuVSpXwXjkp4dv1wcRzqjtE8S+hW1F6IW6ZwIo=;
        b=ZrHD5kYuZjuZG8pC+XskvMBicsqQEXSgOSiOdfKiNrVdwqQwY9JnIoqCstuD6mnxKv
         sdWqU8CgVJevfuquIesQYZDV6NWAvm5CHmnu2G8ob1iTU7q0Ua49T1lbnWotyP203jq6
         GIPAjhtKywW6t8v5BqlA4ByFr5XCYl5+S1vH04B9n5yEo465XZ1sB3mg3HaSM1udI1bH
         Sbe+jieJUi41yoja7QBAN7qCWYcFsbGQhe9qNey/A1rBWsdo3k72qlwoGAdk35eVNYDL
         H9w94Hl4v4IhYU9ciIXut0iBiy9akuDIce7mA6gXm6dobORktnqQIn9O2c+iLz3BlgMR
         D1YQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <453b14dc-88c1-cb58-7eb7-d2d1c9cf36c9@linaro.org>
Date: Thu, 6 Apr 2023 09:44:38 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/1] RFC: Move Odroid-C2 to use binman to produce the image
References: <20230401185458.2280200-1-sjg@chromium.org>
 <20230402065454.v2.1.I2d7f563b6a82f32478a7874e36672622aebb7893@changeid>
 <d3308f32-275d-7b37-8c03-76984a2b9ddf@linaro.org>
 <CAPnjgZ2TNR2R+20WH_iaz0S-k8kwOSZcxFU_0_NnCfmFJo_rcA@mail.gmail.com>
In-Reply-To: <CAPnjgZ2TNR2R+20WH_iaz0S-k8kwOSZcxFU_0_NnCfmFJo_rcA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Christian Hewitt <christianshewitt@gmail.com>, linux-amlogic@lists.infradead.org, Alper Nebi Yasak <alpernebiyasak@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

On 05/04/2023 20:38, Simon Glass wrote:
> Hi Neil,
> 
> On Mon, 3 Apr 2023 at 19:31, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Hi Simon !
>>
>> On 01/04/2023 20:54, Simon Glass wrote:
>>> This shows how binman can be used to replace the long and complicated
>>> instructions with an automated build. It is still complicated to read
>>> but users don't have to worry about the details.
>>>
>>> It needs some tidying up and only supports Odroid-C2 at present.
>>
>> Like the v1, the work is really nice, but the dependency on vendor binary-only
>> tools doesn't make feel confident about merging this.
> 
> So long as we can download it from somewhere, that is OK, or at least
> better than nothing. Is there a standard download location for the
> tools?

There's no "official" location, historically the tools was shipped with the
buildroot fork in the u-boot sources, but it has been moved into different
repos now they do not ship buildroot anymore, and we can only find those tools
on the SBC vendor u-boot sources.

And the tools have the same name but only support different SoCs, there's no
versioning, licence nor documentation... so relying on those tools is a nightmare.

This is why we made a central repository with the tools + binaries for
each board with an easy script to generate the bootable binary:
https://github.com/LibreELEC/amlogic-boot-fip
and documented at:
https://u-boot.readthedocs.io/en/latest/board/amlogic/pre-generated-fip.html

> 
>>
>> We have open source implementation for all boards, but still dependeing on
>> tools we must manually build isn't optimal.
>>
>> What would be optimal would be to re-implement those tools into python
>> libraries and merge them into the u-boot tree then use them from binman.
> 
> Or C, perhaps? Then binman can call the tools.

Yes, but the open source tools aren't heavily maintained, have different ABIs...

Supporting GXBB and GXL/G12A is impossible, the binary format is totally different
for example so we should import 2 different tools.

> 
>>
>> But this could be merged as first step, them the python libaray could be
>> modified to support the binary tools & a probable python re-implementation.
> 
> Yes I think it would good to get this in, even if it only supports a
> few boards. It is easy to add more, when possible.

If this can rely on the amlogic-boot-fip repo, then why not, then we can find
a native solution to replace calling those tools.

Thanks,
Neil

> 
> Regards,
> SImon

