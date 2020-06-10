Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.71.1591806173131874188
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jun 2020 09:22:53 -0700
Received: by mail-wr1-f44.google.com with SMTP id x13so2970474wrv.4
        for <u-boot-amlogic@groups.io>; Wed, 10 Jun 2020 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l1UYplVB1ebL8c0TXfQxTj8g82c4FKbfyu1T9vuuqNQ=;
        b=ejWOTIF+rrIOcTO2p1yiyz2UPZInNrTQERY8lN5iR71LFnCJuSZeFyQIaWgjdfYvG4
         6A6YnzuT1rSUinL8k9FXTRRC/RUKYpc4aADHurPRSFlG6HYC4F0ScOzJOOcWRPnAsdXt
         qwGIqNcNhmOeQtIldkVq5CnzbVkyEBipHQgojZvkBoXLFtoZaG2bKHVWCP6IKzlYWyzl
         wRa+W4xhfYQ2s6Daolh5VA6/TYuIVc+BtkLiwVWOdTzMogJTHqxswcaU0IxfdwdZvHrz
         p+0KHlkRG9VF40UaCKIWqlqoZpr2Cw1HOzxCqGOjLgLGV7Hf/cQJr6/fRmt1Y00vU2kO
         Rzrw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: How to properly boot without a separate initrd
References: <t1wJ.1591805232018748483.qg3Y@groups.io>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <26616143-5a97-1974-e4ab-60a828b80f11@baylibre.com>
Date: Wed, 10 Jun 2020 18:22:49 +0200
MIME-Version: 1.0
In-Reply-To: <t1wJ.1591805232018748483.qg3Y@groups.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, krecis@gmail.com
List-ID: <u-boot-amlogic@groups.io>

H-,

On 10/06/2020 18:07, krecis@gmail.com wrote:
> Hi,
> I have a kernel image which already contains an initramfs, I don't know how to properly boot that with uboot .
> 
> The bootm syntax is
> bootm start <os> <initrd> <fdtaddr>
> 
> which implies that the user always has a 2 separate files for the kernel and the initrd, I have an Image file with kernel+initramfs and a dtb/fdt file : how do I boot ?
> I have not found a proper way/command to achieve this under uboot .
> should I set the initrd address to 0 ?

you can replace the value with "-" and its ignored :

bootm <os> - <fdtaddr>

Neil

> 
> 
> 

