Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.11166.1633610892847129259
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Oct 2021 05:48:13 -0700
Received: by mail-wr1-f53.google.com with SMTP id u18so18768680wrg.5
        for <u-boot-amlogic@groups.io>; Thu, 07 Oct 2021 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aFIYmu4grW9iUV1dyGDuyPKijE4BN1veeTr3yhZIjJU=;
        b=LY8bcFKxPpuqRJObnyCzNoY5CXOGAt13xKLob9FutA+8W3TJ2N8DDkXd61iPgkZG8j
         KkwBzUvs+3cZej+eclWIHMKqxdVmxKx2SdXBmeC7wsc462cZHe5y3EnvAbEZJOHgYleh
         sXL1vzSdO+JO3rrNNfKeUD1G50/aUCoowdGGnllg8wJZOQl28T1kJNYOvo3uC3l7mP88
         gjKwADu2F3P5ZmNa+lOAIzdxNwaHQPgW88Vlk5Q1+Ezws2jkIGPkSu+4ZBDHsjvOcyVg
         na6xlvAi+jFPOw9FXSgZfcAQAu+ysyyfqw95wwwCnKhASdl5xXF/Fd3DlUFekstozqcr
         IvJA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: ARM: amlogic: RFC: meson_sm_get_serial secure call update
References: <58647dfe-714b-cef4-94a9-8507c59c707d@lexina.in>
 <a1173925-8bcb-ae9d-0920-e142bfe3a2d6@baylibre.com>
 <76a3cab3-c5e5-c557-7db6-426ff8f8bf69@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c3b0b6b0-3dc3-3cd0-699f-2d9578ad6e0c@baylibre.com>
Date: Thu, 7 Oct 2021 14:48:09 +0200
MIME-Version: 1.0
In-Reply-To: <76a3cab3-c5e5-c557-7db6-426ff8f8bf69@lexina.in>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Vyacheslav <adeep@lexina.in>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 07/10/2021 14:11, Vyacheslav wrote:
> 07.10.2021 11:13, Neil Armstrong пишет:
>> Hi,
>>
>> On 05/10/2021 11:35, Vyacheslav wrote:
>>> Hi.
>>>
>>> I am investigating the source code of uboot from amlogic and found differences in the function to get the cpu serial. In amlogic-uboot it looks like this:
>>>
>>>              int version = *((unsigned int *)sharemem_output_base);
>>>
>>>              if (version == 2) {
>>>                  memcpy(buff, (void *)sharemem_output_base + 4, 16);
>>>              }
>>>              else {
>>>                  /**
>>>                   * Legacy 12-byte chip ID read out, transform data
>>>                   * to expected order format.
>>>                   */
>>>                  uint32_t chip_info = readl(P_AO_SEC_SD_CFG8);
>>>                  uint8_t *ch;
>>>                  int i;
>>>
>>>                  ((uint32_t *)buff)[0] =
>>>                      ((chip_info & 0xff000000)    |    // Family ID
>>>                      ((chip_info << 8) & 0xff0000) |    // Chip Revision
>>>                      ((chip_info >> 8) & 0xff00)); // Package ID
>>>
>>>                  ((uint32_t *)buff)[0] = htonl(((uint32_t *)buff)[0]);
>>>
>>>                  /* Transform into expected order for display */
>>>                  ch = (uint8_t *)(sharemem_output_base + 4);
>>>                  for (i = 0; i < 12; i++)
>>>                      buff[i + 4] = ch[11 - i];
>>>              }
>>>
>>>
>>> Where P_AO_SEC_SD_CFG8 is offset (0x88<<2) of the AOBUS_BASE register.
>> We already handle this in arch/arm/mach-meson/board-info.c
> Really, I didn't look there.
>>> The current uboot source code uses only the read 12 bytes as cpu serial ignoring the chipID and the existence of a 16-byte version of the serial number.
>>>
>>> Does it make sense to transfer the code to the uboot project?
>>>
>> How does it detect when 16 bytes serial is available ?
> 
> Call to sm function FN_CHIP_ID returns version number in uint32 at beginning of result (shmem_output var in sm.c):
> 
>> int version = *((unsigned int *)sharemem_output_base);
> 
> if version == 2 then serial is next 16 bytes
> for version == 1 then serial is next 12 bytes and amlogic suggests using chipid as an additional 4 bytes.
> 
> I have gxl and axg platform, there version is 1. Unfortunately I don't have more recent chipsets at hand to check if they have introduced version 2 on them.

Seems to be a very recent addition, I get version 1 on S905Y2 (G12A), A311d (G12B) & S905D3 (SM1).

Neil

> 
>> I'm not against this but I'm not sure when 16 bytes are available.
> I'm not sure if the 16 bytes even exist at all or if this is just in case for future SoC.
> 
> -- 
> Vyacheslav
> 

