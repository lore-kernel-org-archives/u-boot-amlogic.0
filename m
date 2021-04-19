Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web09.10348.1618844276852812219
 for <u-boot-amlogic@groups.io>;
 Mon, 19 Apr 2021 07:57:57 -0700
Received: by mail-wm1-f42.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so8811202wmq.4
        for <u-boot-amlogic@groups.io>; Mon, 19 Apr 2021 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=og6Tf7oQuJfZ1/GZFsX7RoIsdxpew+PTVWr1nZctvZU=;
        b=cDAC0WeNA3d4ynvVcjKNHj53I5LFDJcNTZ4BXPsmL+mf/Q+byAVwjs/5p1HNJlwpH8
         T2lXY7wXBJUyrVTLbKsq1YapVRVPVMeOzlsJcG2ZQw9RFisj74ZH/rG49TUy5LaGBEBA
         lNgQ8ScLyN86wwBykZnk/vsbY5nHLkyYwBQe0kaxrd6jGGwrfNt+v7SrcoJLzhA1deVY
         udFzIlSbdoHW69h+LSornOPHaouKSHgb3BxsG0jqbg5cG8rQovi5CKGb9wR7STLLXIiq
         2t23xb3JfyJbYIjt4OY2TnIeWaQW8Hp3d1+ZYESo1W/BHP0kw+52oyDbA7RumMnjdT3O
         sJSw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] boards: amlogic: update documentation for PCIe support
References: <20210416122310.2188025-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <78fa1c8d-4d67-6775-6153-5b7d9a147aee@baylibre.com>
Date: Mon, 19 Apr 2021 16:57:53 +0200
MIME-Version: 1.0
In-Reply-To: <20210416122310.2188025-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 16/04/2021 14:23, Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  doc/board/amlogic/index.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
> index 275c3664b7..8da7afddb4 100644
> --- a/doc/board/amlogic/index.rst
> +++ b/doc/board/amlogic/index.rst
> @@ -70,6 +70,8 @@ This matrix concerns the actual source code version.
>  +-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
>  | SoC (version) information     | **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
>  +-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
> +| PCIe (+NVMe)                  | *N/A*     | *N/A*           | *N/A*        | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
> ++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
>  
>  Board Documentation
>  -------------------
> 

Applied to u-boot-amlogic
