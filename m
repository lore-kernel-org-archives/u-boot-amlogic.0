Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web08.67.1614015592214384909
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Feb 2021 09:39:53 -0800
Received: by mail-wr1-f51.google.com with SMTP id n8so19923477wrm.10
        for <u-boot-amlogic@groups.io>; Mon, 22 Feb 2021 09:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QA1ZhxXIZXQLXdD4qO+PC95LwQexQmPmHob9S/iNiJA=;
        b=YbsfaZ9nLE01T1kDpbMrNmq7ZTjwQIGscoWZtCqMHs0LFWVWhjSumk+mtXjsnY0g11
         v5kthdLX2VpY6U0zRRqK0uU0/mA1Xo2DeUwZycANp/MuouzBaz6KkRSujAApN6xnZBNR
         KADqbqyaOGEgpAQXGiV+f1L46nR7f6dmrFyVrebsh7lJi2rzS65tJc1mCbBG9HB91O9W
         NTwnicjdFQ/eK3y5Vwc28zAkIBbdKizwkGqB29an4RH+0ma2jMI3v3vyScLJowzAl67k
         pI94MsIU58vxEl+jvjkv/D8iqFFGKUKbwJxsMLdM5zMOrfPu07H5f57xBkD1fmiTs4pX
         PSXg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] button: add udevice forward declaration
References: <20210219074124.1571269-1-narmstrong@baylibre.com>
 <CAPnjgZ0c3OnOnW0b3xrWNUX1pf90Lc1zBQFWXDNaR2ZWPzpW3w@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <b118a5d5-b3b4-8f82-5426-71143c723dc3@baylibre.com>
Date: Mon, 22 Feb 2021 18:39:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAPnjgZ0c3OnOnW0b3xrWNUX1pf90Lc1zBQFWXDNaR2ZWPzpW3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Szyprowski <m.szyprowski@samsung.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Philippe Reynes <philippe.reynes@softathome.com>
List-ID: <u-boot-amlogic@groups.io>

On 20/02/2021 12:55, Simon Glass wrote:
> On Fri, 19 Feb 2021 at 00:41, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> After 401d1c4f5d2d ("common: Drop asm/global_data.h from common header")
>> build fails with :
>>
>> drivers/button/button-uclass.c:13:5: error: conflicting types for 'button_get_by_label'
>> int button_get_by_label(const char *label, struct udevice **devp)
>>     ^~~~~~~~~~~~~~~~~~~
>>
>> Adding struct udevice forward declaration in button.h solves the build error.
>>
>> Fixes: 401d1c4f5d2d ("common: Drop asm/global_data.h from common header")
>> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>> Hi,
>>
>> This is needed to fix build on vim3/vim3l after [1] is applied.
>>
>> [1] https://patchwork.ozlabs.org/project/uboot/cover/20210218103318.18915-1-m.szyprowski@samsung.com/
>>
>>  include/button.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 

Thanks, applied to u-boot-amlogic

Neil
