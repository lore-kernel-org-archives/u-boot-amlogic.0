Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web12.190542.1598257975998060804
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2020 01:32:56 -0700
Received: by mail-wm1-f48.google.com with SMTP id c19so5637579wmd.1
        for <u-boot-amlogic@groups.io>; Mon, 24 Aug 2020 01:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/JI8dbxc0FdjEbepw+nopIWQHsC94467xqX1uUp1jlA=;
        b=02dGS2s6QRusIovpm8kN19VchsFe9TCumfnWzz68H4yB0uQimquS2RaEyYKahjpXQZ
         ZauiXv9Lv2KKMUKclR7Wxs5qzVI98DlcxhtNZkTQRwUHUB+VHdTt8BUfPa/RlRt91Ih8
         6d0uSjIrgyI4mJvh2BSFlcgsNHgImVbFNKETroYSKCOdkpLtpUdrg97qTdzxI5OskXp1
         wfvXDfcqE5wzUD34MmBAHHJI2W3P2OLUdKc8D5nRp2+tJKyGdjxE/oJSAsmR69YcVpXM
         HDxh1Mw+yJMncZOFqd/vkKCK37n2DlEoQdYbBoK2gf+pawawL9nRJ944T546nk1+3iI0
         yDCg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: HDMI on Odroid-C4
References: <0d556ad4-39b4-4ccd-975d-b5eb96e4007e@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <3d8f1054-6dd0-2d46-eba3-95d0a0cdedb9@baylibre.com>
Date: Mon, 24 Aug 2020 10:32:52 +0200
MIME-Version: 1.0
In-Reply-To: <0d556ad4-39b4-4ccd-975d-b5eb96e4007e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, vicencb@gmail.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 20/08/2020 20:58, Vicente Bergas wrote:
> Hi, i've got an Odroid-C4 and testing u-boot on it but cannot make HDMI work.
> U-Boot version is 2020.10-rc2 and configuration is odroid-c4_defconfig.
> From the serial port, the 'dm uclass' command reports req -1 for display, video and vidconsole uclasses.
> Am i missing something or is it supposed to work?

It' supposed to work, could you test with https://patchwork.ozlabs.org/project/uboot/patch/20200814062515.1803-2-linux.amoon@gmail.com/ ?

Neil

> 
> Regards,
> Vicente.
> 
> 
> 
> 

