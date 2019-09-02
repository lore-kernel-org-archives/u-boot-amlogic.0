Received: by mail-wr1-f68.google.com with SMTP id y19so13384065wrd.3
        for <u-boot-amlogic@groups.io>; Mon, 02 Sep 2019 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pxzGfNR72U7dPomWUw6MDyHYBPCRu1Zvla3ZcnpWoOw=;
        b=jdUSxe2QsHJy9uKPpZ0BLWR742CvUqT6PyUHijqqsBFoXbjWh/GbSmpD7qDZtTaFqx
         KS0pcdu4j1LAaSxnxIl/MShVugCu53BOV6hAGq/SOEBWRT3DA9H5mrNZ7bpkBqxjHOFD
         SagK1g35BrXgwU55Zodir/KD5X8GFb3C6EoiwrPMPmbcUxhwuApICdyemn4d74I2WOnG
         aS+30oJIouTtjibqHkfM1iOBUZaEeNY7ONwoclozG2jtGiCP3jJe2skBl93JjliqczI/
         WCbGjEV6VOb8LAaMbSKxx6Fhn9vPIGiMAQ0F1bmQssU3s1Dp04Y5niTxkekhPautxdfx
         zbJw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] configs: Add Khadas VIM3 defconfig
References: <20190902022851.9228-1-afaerber@suse.de>
 <20190902022851.9228-3-afaerber@suse.de>
 <fc9f82e6-3a43-c319-2885-157145423a09@suse.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c8334552-a75d-a7bc-c236-f99216079c25@baylibre.com>
Date: Mon, 2 Sep 2019 12:05:14 +0200
MIME-Version: 1.0
In-Reply-To: <fc9f82e6-3a43-c319-2885-157145423a09@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 02/09/2019 05:02, Andreas Färber wrote:
> Am 02.09.19 um 04:28 schrieb Andreas Färber:
>> diff --git a/board/amlogic/w400/README.khadas-vim3 b/board/amlogic/w400/README.khadas-vim3
>> new file mode 100644
>> index 0000000000..39b2b06000
>> --- /dev/null
>> +++ b/board/amlogic/w400/README.khadas-vim3
> [...]
>> + > DIR=vim3-u-boot
>> + > git clone --depth 1 \
>> +       https://github.com/khadas/u-boot.git -b khadas-vim3-v2015.01 \
>> +       $DIR
> 
> That branch name should've been khadas-vims-v2015.01 - both exist, the
> above one was not working and the reason I held back the patches.

Ok, this patch looks fine, please add :
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
when you re-spin.

Neil

> 
> Regards,
> Andreas
> 

