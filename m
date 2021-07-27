Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web08.8466.1627374714401814257
 for <u-boot-amlogic@groups.io>;
 Tue, 27 Jul 2021 01:31:55 -0700
Received: by mail-wr1-f51.google.com with SMTP id l4so14157812wrs.4
        for <u-boot-amlogic@groups.io>; Tue, 27 Jul 2021 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Zsz3iyaaHoowkgKjEzkxHjM3287jZjNIvD3lvaU+4s=;
        b=guZis2yz6SelLVgUb7pO50dk+pB3p6+vFrFEScdxIz1CeuISBoDf3R05vKN9UPcIDj
         LKOfIb/I+r20wlnRPyjeTjSN7cG+J4U1Fl/eCIHz+soLn3DhzPddzBAqyhR9FEXRceQb
         yq3r9Y/VrUNmqGK+k+yPl3IQ8aLQyT8WfDZqtFRxLqgd9outChssxpG4PrpPeTngJuAO
         bIbC3g97nN6iScG2KAnG0QDRrzZIAXIlvXH+eK6VbU9MTN/gHT1M5oz2khZFMJ4tEP3O
         98cPjbOlKf8T00u979jhQstosqT5cJSVPEhbVDHyLkLisU8pYrIJz1MUof8EZu0TyWCT
         qo7w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] meson64: add kernel compression vars
References: <20210527064351.3102968-1-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c8c7e14f-6c94-8924-4735-9d40c49685da@baylibre.com>
Date: Tue, 27 Jul 2021 10:31:51 +0200
MIME-Version: 1.0
In-Reply-To: <20210527064351.3102968-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

On 27/05/2021 08:43, Artem Lapkin wrote:
> make possible to load simple compressed linux kernel for meson64
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  include/configs/meson64.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index e3d25493..552a08c2 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -113,6 +113,8 @@
>  	"stdin=" STDIN_CFG "\0" \
>  	"stdout=" STDOUT_CFG "\0" \
>  	"stderr=" STDOUT_CFG "\0" \
> +	"kernel_comp_addr_r=0x0d080000\0" \
> +	"kernel_comp_size=0x2000000\0" \
>  	"fdt_addr_r=0x08008000\0" \
>  	"loadaddr=0x01000000\0" \
>  	"scriptaddr=0x08000000\0" \
> 

Applied to u-boot-amlogic,

Thanks,
Neil
