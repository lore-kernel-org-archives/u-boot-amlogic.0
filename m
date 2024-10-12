Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06779CF2566
	for <webhook@archiver.kernel.org>; Sat, 12 Oct 2024 11:02:59 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.8790.1728730972603989892
 for <u-boot-amlogic@groups.io>;
 Sat, 12 Oct 2024 04:02:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=IohWSHhi;
 spf=pass (domain: baylibre.com, ip: 209.85.128.54, mailfrom: glaroque@baylibre.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4311695c6c2so20511195e9.1
        for <u-boot-amlogic@groups.io>; Sat, 12 Oct 2024 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728730971; x=1729335771; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWAWoBCHJnxRn52Hpf9Hg5abaWAn1l1/6xV3j1HmW2U=;
        b=IohWSHhiL6Ylf54eSeg6N+4wOKOrzzYsU/0vRRC/b92Rfv2/zRkEO5lRb+w0IaqKKq
         wXmxfau5KvloMIaT1kaeD3wG6bf5wPbEEMvf0yAuHBaaCXp7LbTmszhwrG69/zrp3nl5
         qPPQFapVNyLPHESj6CpLrw3Kcp/9TjEsym2KL5IWMj+ss8jHM8JpHn+VdIZ/AqUfst9q
         W1iURdV+RPfWh+TGUh3vNvgNvM+a5HXmzs4aSLW6O6yJuLQj9pfcD4JUhJG5o4kLctSE
         +8wNV6/58MuokIPeEOugHki+NCvASLGRpJ6paoeSu4Zqh/PDolSZVVvFMP0xbCAF+Hig
         ew3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728730971; x=1729335771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWAWoBCHJnxRn52Hpf9Hg5abaWAn1l1/6xV3j1HmW2U=;
        b=gj3K7VXOaSQJiKQmSi5Nn2OS//eW84OJY7QbfeVGwq1d8l6lWUiGk+HrAy6/syI/Pa
         XTO4D859WnfifXS3a9sv7WtnaAmrfOJBftnYMxtDmpDK8IVmWfxNZvmSelD342QLIEX7
         E1OJeuQxSvlb+/Ynpktzwwr7oZJNJ2GHjtzCJmOcEroHAShvfWsnYtcWPCNu2VsQxPBg
         79Mpd/eJEcuEiS+xAuH0DWWBsNU72ipWzFFL1xucNgLc1pxNizI8pIBPO3iAwm0fNPcm
         PSFJrreOub/1qn6eQPanCfgqJMfKKieAxbnSnObOtpAt3FToMi6Yk7mB4cx9i1zSZE7k
         OmOw==
X-Forwarded-Encrypted: i=1; AJvYcCXYE2obJ8y1rjXsl14Hhi5nmbATtf6SV2IDHv9ykOrBdlGpi5g3y4QxD5c4wYe7zgoVJ63O9GKPzihX+NWsrg==@groups.io
X-Gm-Message-State: AOJu0Yy3RNGHCsBUe/b24jGF4pAv477/ik4fCJ6mo3QTrpKn64kVcdIP
	1NuHkd5Ry9Z8NR2lcOmtX15Z75C/o1NqesXnzPHjNIxhurKi6HJ/KPMWPmS0MLGSQhWH9nMJrur
	t
X-Google-Smtp-Source: AGHT+IGrUg5TxOrAxBXZeSB2JzXkNarik7rUhCa92BrjygbdI6M1rl0U8U4LE9wzR1ySJWKT5wxOtg==
X-Received: by 2002:a05:600c:3551:b0:42f:7717:ac04 with SMTP id 5b1f17b1804b1-431255e2ca4mr20896035e9.16.1728730970439;
        Sat, 12 Oct 2024 04:02:50 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:e40:30d4:b1ee:f034? ([2a05:6e02:10a5:e010:e40:30d4:b1ee:f034])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf45df4sm96997195e9.13.2024.10.12.04.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 04:02:50 -0700 (PDT)
Message-ID: <66b14071-50e6-4354-b398-028c99c60b06@baylibre.com>
Date: Sat, 12 Oct 2024 13:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: meson64_android: Remove dtbo support
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
References: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
 <20241011-yukawa-aosp-parts-v1-2-7d74aa13ff8e@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20241011-yukawa-aosp-parts-v1-2-7d74aa13ff8e@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 12 Oct 2024 11:02:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2451

Hi,


Le 11/10/2024 à 17:51, Mattijs Korpershoek a écrit :
> The device tree overlays are not part of the
> Android Common Kernel code [1]
>
> Historically, they existed to enable some Android specific
> features but they have been removed.
>
> Remove the dtbos logic since these files do no longer exist.
>
> [1] https://android.googlesource.com/kernel/common/+/ac2ea0bb91a3b5f5e71eba66c441e58beca6767e/arch/arm64/boot/dts/amlogic/
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   include/configs/meson64_android.h | 26 +-------------------------
>   1 file changed, 1 insertion(+), 25 deletions(-)
>
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index c0e977abb01f..fa520265800c 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -116,31 +116,7 @@
>   	"fi; " \
>   	"abootimg get dtb --index=$dtb_index dtb_start dtb_size; " \
>   	"cp.b $dtb_start $fdt_addr_r $dtb_size; " \
> -	"fdt addr $fdt_addr_r  0x80000; " \
> -	"if test $board_name = sei510; then " \
> -		"echo \"  Reading DTBO for sei510...\"; " \
> -		"setenv dtbo_index 0;" \
> -	"elif test $board_name = sei610; then " \
> -		"echo \"  Reading DTBO for sei610...\"; " \
> -		"setenv dtbo_index 1;" \
> -	"elif test $board_name = vim3l; then " \
> -		"echo \"  Reading DTBO for vim3l...\"; " \
> -		"setenv dtbo_index 2;" \
> -	"elif test $board_name = vim3; then " \
> -		"echo \"  Reading DTBO for vim3...\"; " \
> -		"setenv dtbo_index 3;" \
> -	"else " \
> -		"echo Error: Android boot is not supported for $board_name; " \
> -		"exit; " \
> -	"fi; " \
> -	"part start mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_start; " \
> -	"part size mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_size; " \
> -	"mmc read ${dtboaddr} ${p_dtbo_start} ${p_dtbo_size}; " \
> -	"echo \"  Applying DTBOs...\"; " \
> -	"adtimg addr $dtboaddr; " \
> -	"adtimg get dt --index=$dtbo_index dtbo0_addr; " \
> -	"fdt apply $dtbo0_addr;" \
> -	"setenv bootargs \"$bootargs androidboot.dtbo_idx=$dtbo_index \";"\
> +	"fdt addr $fdt_addr_r  0x80000; "
>   
>   #define BOOT_CMD "bootm ${loadaddr} ${loadaddr} ${fdt_addr_r};"
>   
>

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>




