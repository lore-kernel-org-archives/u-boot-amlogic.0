Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web10.7499.1587047103975141754
 for <u-boot-amlogic@groups.io>;
 Thu, 16 Apr 2020 07:25:04 -0700
Received: by mail-wr1-f66.google.com with SMTP id i10so5031004wrv.10
        for <u-boot-amlogic@groups.io>; Thu, 16 Apr 2020 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mpw4dpImhD9nMdV7v/V+4RpaGpGHu67hUtl1sLpJGCM=;
        b=RcoAlnsBrglmkPb7WY1/vCXmnzJSLIJgkcCxr8/TpEAahJVFqNplWE5zC8QSwQ8DtT
         mcJwyuOkVrJ5LASqKWahx9pF2XbKTRMaQNYGFVHEd0bM+IFEFeXJiJdx/m01DOgrO5Rj
         IfMROaAyFQfLw/OWhmukHt1nRysQ8rJf9c33gXUHsFWuAv7nBlBc483XnQwZue8F2vXD
         BiUke8A2h+1gImRBgOWj5sG8J4pyeaQF1VRl2Vc4ootQBDTVu99PAB4u596an3Rf5qsf
         Q1TuylTJBYDVFfnxq7eE7VSJsIG7iBpkcQqGEs8L3a8JA5oPGHd75R2ocrzvRKi4SaY0
         6veg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson-gx: add back dmc register range until canvas driver is available
References: <20200416084215.26893-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <2352c1da-d546-a9f6-18ce-a1699f1e2bf4@baylibre.com>
Date: Thu, 16 Apr 2020 16:25:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200416084215.26893-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 16/04/2020 10:42, Neil Armstrong wrote:
> The Linux VPU bindings have changed and dropped the dmc register range.
> 
> Add it back in the meson-gx-u-boot.dtsi file until a proper canvas driver
> is available.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/dts/meson-gx-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-boot.dtsi
> index b84e5edba4..17d2cb95c1 100644
> --- a/arch/arm/dts/meson-gx-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gx-u-boot.dtsi
> @@ -11,6 +11,10 @@
>  };
>  
>  &vpu {
> +	reg = <0x0 0xd0100000 0x0 0x100000>,
> +	      <0x0 0xc883c000 0x0 0x1000>,
> +	      <0x0 0xc8838000 0x0 0x1000>;
> +	reg-names = "vpu", "hhi", "dmc";
>  	u-boot,dm-pre-reloc;
>  };
>  
> 

Fixes video for Libretech-AC & Libretech-CC boards.

Applied to u-boot-amlogic
