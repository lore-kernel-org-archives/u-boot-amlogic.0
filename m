Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web09.7181.1627550536874564565
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 02:22:17 -0700
Received: by mail-wr1-f46.google.com with SMTP id q3so6099240wrx.0
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vb70hq2mmmZpy8OmLe6j4Nps4lJhZF4grHh/R/G9nQA=;
        b=LAyqd9F3de23FeqgHFMoKo3nast7oNQWx/NkECOMVTk7iECzWkKRxc/pIH1+/iqGgR
         7MCoPCT3XTnQo+d2EjV7lNOAlp2AyWFwwepWCQiRlJnhdlSES4nPaLd0swMsT3+asiED
         t+8scfLX5jG/0rQ7COiFMvAbwjxVJh2JfK/8/587/sWBa+2bZ0rx+Ml+M4ev63YUQIDN
         /OGJQW0Yqkn1+aGYRieksMrldTZ5ZA04wVEXAh5Ut2sV1hMZsyEuX1Q19MFgcnb1gOMl
         hyi5utR1WyJ4MVd4ClLKU0Rkw/6wG3eMiiCJohI5AZfpJjP1jMtD+fs256n7rPD4nRED
         A76g==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/6] configs: meson64_android: use CONFIG_FASTBOOT_USB_DEV
References: <20210729072113.208099-1-mkorpershoek@baylibre.com>
 <20210729072113.208099-4-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <02c1da08-a03d-5e48-c2c9-cdaef7ea54b8@baylibre.com>
Date: Thu, 29 Jul 2021 11:22:15 +0200
MIME-Version: 1.0
In-Reply-To: <20210729072113.208099-4-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 29/07/2021 09:21, Mattijs Korpershoek wrote:
> Right now, when running fastboot we use a hard-coded "0" for the
> device number.
> 
> Use the Kconfig option named CONFIG_FASTBOOT_USB_DEV instead.
> 
> Signed-off-by: Guillaume La Roque <mkorpershoek@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/meson64_android.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index 661de76fd7..4027a7fe0d 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -38,7 +38,7 @@
>  		"fi;" \
>  		"if test \"${run_fastboot}\" -eq 1; then " \
>  			"echo Running Fastboot...;" \
> -			"fastboot 0;" \
> +			"fastboot " __stringify(CONFIG_FASTBOOT_USB_DEV) "; " \
>  		"fi\0"
>  
>  #define BOOTENV_DEV_NAME_FASTBOOT(devtypeu, devtypel, instance)	\
> @@ -69,7 +69,7 @@
>  		"fi;" \
>  		"if test \"${run_recovery}\" -eq 1; then " \
>  			"echo Running Recovery...;" \
> -			"fastboot 0;" \
> +			"fastboot " __stringify(CONFIG_FASTBOOT_USB_DEV) "; " \
>  		"fi\0"
>  
>  #define BOOTENV_DEV_NAME_RECOVERY(devtypeu, devtypel, instance)	\
> 


Acked-by: Neil Armstrong <narmstrong@baylibre.com>
