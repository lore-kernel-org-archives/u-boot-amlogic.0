Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.5420.1617872298984497183
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Apr 2021 01:58:19 -0700
Received: by mail-wr1-f52.google.com with SMTP id a6so1241577wrw.8
        for <u-boot-amlogic@groups.io>; Thu, 08 Apr 2021 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bklqqkrvz4prxWUwfpoDhG4rYr3a9KlPNjS9Se4of1c=;
        b=VIx8deRrONmS84ozIzRc0zITDmm1vSI5HqebZmKx6ufNxsYrprdwBcgjSzLTz9N4ZE
         AJcIANeSBa4wgDrPh2nMyiPdliNVluCOUxqVeGVBUGq9ymTtJ/tailAghQnQ8B0v2rHU
         dKasExFnKC5fN8HIaVEn6xuHH9VL7OPSRaDgOnDjSkOHdxI3jgvZa62P1/tg0mCYVMZP
         pS1D14AxDVM259TB8NAT/04TwAXtUg+Zy2WcYf0fYO0GbTUogjBw3WLmm7wwLHwzQPGE
         mZFiDrdRirHsK9hFt6HYcwdu8zG2BLTdy5nDBcmfmA+m3lCBeqjKpi+260iEATUWvANT
         YiNA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] arm64: dts: meson: odroidc2: readd PHY reset properties
References: <68934d1271af9afa7854ced37e72765381be6421.1617870301.git.stefan@agner.ch>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <dd8f6326-147d-e5ed-68b7-57913c0f31c4@baylibre.com>
Date: Thu, 8 Apr 2021 10:58:16 +0200
MIME-Version: 1.0
In-Reply-To: <68934d1271af9afa7854ced37e72765381be6421.1617870301.git.stefan@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Stefan Agner <stefan@agner.ch>
Cc: jbrunet@baylibre.com, khilman@baylibre.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 08/04/2021 10:25, Stefan Agner wrote:
> The sync of the device tree and dt-bindings from Linux v5.6-rc2
> 11a48a5a18c6 ("Linux 5.6-rc2") causes Ethernet to break on some
> ODROID-C2. The PHY seems to need proper reset timing to be functional
> in U-Boot and Linux afterwards. Readd the old PHY reset bindings for
> dwmac until we support the new bindings in the PHY node.
> 
> Fixes: dd5f2351e99a ("arm64: dts: meson: sync dt and bindings from v5.6-rc2")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
> index 90087b00db..5a2be8171e 100644
> --- a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
> @@ -29,6 +29,12 @@
>  	};
>  };
>  
> +&ethmac {
> +	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> +	snps,reset-delays-us = <0 10000 1000000>;
> +	snps,reset-active-low;
> +};
> +
>  &usb0 {
>  	status = "disabled";
>  };
> 

Thanks,

Applied to u-boot-amlogic
