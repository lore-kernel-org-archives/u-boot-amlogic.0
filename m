Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web09.8715.1633594403089412451
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Oct 2021 01:13:23 -0700
Received: by mail-wr1-f45.google.com with SMTP id r10so16381102wra.12
        for <u-boot-amlogic@groups.io>; Thu, 07 Oct 2021 01:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jIuKtgKB8OsaOwLWEpdE/l37X9F3ceqxOLK/BGtm8Ws=;
        b=zWs10slPv6HlqeXBT91cKa0Cr9vJOeHuXaOTNVyBE7scAuB7de4Ue2KwUZeRglpg8R
         2DDLhVei437GfsrVH1ne9grgauO+xK4tNOm9vR+V96GAbsTo3iwiAr/FE0EjU/hcN3Bf
         WEw5jLyO4G6NE20ccAJL5qN0VCGhT2LSY7SC+ZmKxAiQLEC/HZrZP5S1MenhmfPwiwzV
         bUN05qVwL4APeyJGesa6IE6EgHWix4OwIsQk/reyQLlvVe0u8QyCwTJ/MQHagijBl/DN
         qdo2EIVKJo+xHT9Fhl/rrFllcAJxl/+KdueAsH7tWGDQFUufMJk+uzGWENvNDvRSQYNU
         w3hg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: ARM: amlogic: RFC: meson_sm_get_serial secure call update
References: <58647dfe-714b-cef4-94a9-8507c59c707d@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <a1173925-8bcb-ae9d-0920-e142bfe3a2d6@baylibre.com>
Date: Thu, 7 Oct 2021 10:13:20 +0200
MIME-Version: 1.0
In-Reply-To: <58647dfe-714b-cef4-94a9-8507c59c707d@lexina.in>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Vyacheslav <adeep@lexina.in>
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 05/10/2021 11:35, Vyacheslav wrote:
> Hi.
> 
> I am investigating the source code of uboot from amlogic and found differences in the function to get the cpu serial. In amlogic-uboot it looks like this:
> 
>             int version = *((unsigned int *)sharemem_output_base);
> 
>             if (version == 2) {
>                 memcpy(buff, (void *)sharemem_output_base + 4, 16);
>             }
>             else {
>                 /**
>                  * Legacy 12-byte chip ID read out, transform data
>                  * to expected order format.
>                  */
>                 uint32_t chip_info = readl(P_AO_SEC_SD_CFG8);
>                 uint8_t *ch;
>                 int i;
> 
>                 ((uint32_t *)buff)[0] =
>                     ((chip_info & 0xff000000)    |    // Family ID
>                     ((chip_info << 8) & 0xff0000) |    // Chip Revision
>                     ((chip_info >> 8) & 0xff00)); // Package ID
> 
>                 ((uint32_t *)buff)[0] = htonl(((uint32_t *)buff)[0]);
> 
>                 /* Transform into expected order for display */
>                 ch = (uint8_t *)(sharemem_output_base + 4);
>                 for (i = 0; i < 12; i++)
>                     buff[i + 4] = ch[11 - i];
>             }
> 
> 
> Where P_AO_SEC_SD_CFG8 is offset (0x88<<2) of the AOBUS_BASE register.

We already handle this in arch/arm/mach-meson/board-info.c

> 
> The current uboot source code uses only the read 12 bytes as cpu serial ignoring the chipID and the existence of a 16-byte version of the serial number.
> 
> Does it make sense to transfer the code to the uboot project?
> 

How does it detect when 16 bytes serial is available ?

I'm not against this but I'm not sure when 16 bytes are available.

Neil

