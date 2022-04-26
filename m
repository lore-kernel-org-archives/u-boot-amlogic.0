Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.3376.1650957521334606780
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Apr 2022 00:18:41 -0700
Received: by mail-wr1-f42.google.com with SMTP id s21so9379042wrb.8
        for <u-boot-amlogic@groups.io>; Tue, 26 Apr 2022 00:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=bUMWnrmVuvI9sczk8x5z0XPthxqMCTVri5xRxzQGVc4=;
        b=Ox9+L2rdPQN9lmUYj2rghQhRupCCzlNmEw88n+gDMC1ocX+VEmZNkGPZSC0+5sy8Ty
         fSAPI+Yh/tBQHzVQz+zJXI+8HWKAtnkm49mLalaUsgc9RJN6vxyln4eGgePFgvZ/pABv
         BV9t2jzp2kT3NE/YLROwwctiF7/0TQtLW10eC8qUsdE1wVYYvE6JnNESUXDAC+4muQUx
         Y1efGVULF2L6zXabS2HUiMBeQIx/TzRsP0IvXrlP1wSQpWN7n0ce2SGqHeQIKAFBvdUU
         Lsc+25e/GBLfIdjGx+1dHCFjZYYOVE5j7S/TF6UIKRee5eHWtySDiCkH8bTQULneWYJv
         17cg==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <bf0c5036-aa3d-c78c-7443-1082f90b2b8b@baylibre.com>
Date: Tue, 26 Apr 2022 09:18:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] doc: boards: amlogic: update jethub d1 specifications
References: <20220426052633.3027932-1-adeep@lexina.in>
 <20220426052633.3027932-2-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220426052633.3027932-2-adeep@lexina.in>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 26/04/2022 07:26, Vyacheslav Bocharov wrote:
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>   doc/board/amlogic/jethub-j100.rst | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub-j100.rst
> index d54519aaef..8081569bba 100644
> --- a/doc/board/amlogic/jethub-j100.rst
> +++ b/doc/board/amlogic/jethub-j100.rst
> @@ -3,27 +3,31 @@
>   U-Boot for JetHub J100
>   =======================
>   
> -JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation
> -controller manufactured by JetHome with the following specifications:
> +JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a series of home
> +automation controller manufactured by JetHome with the following
> +specifications:
>   
>    - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
>    - no video out
> - - 512Mb/1GB DDR3
> - - 8/16GB eMMC flash
> + - 512MB/1GB DDR3 or 2GB DDR4 SDRAM
> + - 8/16/32GB eMMC flash
>    - 1 x USB 2.0
>    - 1 x 10/100Mbps ethernet
> - - WiFi / Bluetooth AMPAK AP6255 (Broadcom BCM43455) IEEE
> -   802.11a/b/g/n/ac, Bluetooth 4.2.
> - - TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output
> -   power and Zigbee 3.0 support.
> + - WiFi / Bluetooth one from:
> +   - AMPAK AP6255 (Broadcom BCM43455) IEEE 802.11a/b/g/n/ac, Bluetooth 4.2
> +   - RTL8822CS IEEE 802.11a/b/g/n/ac, Bluetooth 5.0
> +   - Amlogic W155S1 WiFi5 IEEE 802.11a/b/g/n/ac, Bluetooth 5.2
>    - 2 x gpio LEDS
>    - GPIO user Button
> + - DC source with a voltage of 9 to 56 V / Passive POE
> + - DIN Rail Mounting case
> +Basic version also has:
> + - TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output
> +   power and Zigbee 3.0 support.
>    - 1 x 1-Wire
>    - 2 x RS-485
>    - 4 x dry contact digital GPIO inputs
>    - 3 x relay GPIO outputs
> - - DC source with a voltage of 9 to 56 V / Passive POE
> - - DIN Rail Mounting case
>   
>   U-Boot compilation
>   ------------------

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
