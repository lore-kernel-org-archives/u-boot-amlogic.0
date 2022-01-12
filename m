Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web08.20820.1641978329436336746
 for <u-boot-amlogic@groups.io>;
 Wed, 12 Jan 2022 01:05:30 -0800
Received: by mail-wr1-f47.google.com with SMTP id h10so2957975wrb.1
        for <u-boot-amlogic@groups.io>; Wed, 12 Jan 2022 01:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KfthbBMc/WPblLJ1t/wXa8G8azpxfk3Q/z3GsPVzeMk=;
        b=7Ztctu/3frfMSZTNGQTUAhJM/h8aAcmiyCP819K5Uu5Mhtcmmzy5lYktQ1vjFMi0RM
         razMGYxlB67q88jps3o2m2LjKzUmhp9rwEjx4UYaWd3+3SHSVqMvLedvF69qHvuhIKfP
         FocVcwZ2nil9B0fFZ+SUDq0fbSkxupQcrtN9Exx+AEtX6lvUhM19va3oQyKB91ECumUW
         rPX4wIlRO23OkRmg0i40stS5uUaJYxJQvaLsIi7Fj54pzmAIH8PGi23UTf5EUh3ZUmca
         62OfUk65pjd4wX+qbbazvMYUm8ZeAybcvwYAmEp7MYqpDUTVlL47qmzsoORzbwKMnOMB
         zhFQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] configs: meson64_android: define raw parts for bootloader
References: <20220107163913.3393563-1-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <af7499bf-18d6-8cfa-ce22-284d70d682ad@baylibre.com>
Date: Wed, 12 Jan 2022 10:05:26 +0100
MIME-Version: 1.0
In-Reply-To: <20220107163913.3393563-1-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Gary Bisson <gary.bisson@boundarydevices.com>
List-ID: <u-boot-amlogic@groups.io>

On 07/01/2022 17:39, Mattijs Korpershoek wrote:
> Per the android documentation[1]:
> - the mmc2boot0 partition should be labeled "bootloader".
> - the mmc2boot1 partition should be labeled "bootenv".
> 
> Also the u-boot documentation[2] refers to a BOOT1_OFFSET of 1 block.
> 
> Define 2 raw partitions to store the bootloaders and the bootenv.
> 
> [1] https://source.android.com/setup/build/devices#vim3-fastboot
> [2] https://u-boot.readthedocs.io/en/latest/board/amlogic/khadas-vim3l.html
> 
> Suggested-by: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/meson64_android.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index 0303d187de..1266851196 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -283,6 +283,8 @@
>  	EXTRA_ANDROID_ENV_SETTINGS                                    \
>  	"partitions=" PARTS_DEFAULT "\0"                              \
>  	"mmcdev=2\0"                                                  \
> +	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
> +	"fastboot_raw_partition_bootenv=0x0 0xfff mmcpart 2\0"        \
>  	ANDROIDBOOT_GET_CURRENT_SLOT_CMD                              \
>  	AVB_VERIFY_CMD                                                \
>  	"force_avb=0\0"                                               \
> 

Applied to u-boot-amlogic

Thanks,
Neil
