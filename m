Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web12.6991.1642603400326422583
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Jan 2022 06:43:21 -0800
Received: by mail-wm1-f51.google.com with SMTP id w26so5476091wmi.0
        for <u-boot-amlogic@groups.io>; Wed, 19 Jan 2022 06:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fx6EgVbx105vS29py4Xzdon+cchF/rAtvtj+7I6FBso=;
        b=kivWZnSJD1DO4nievW9Eor0ymCS5756afKCO74eCJA/YIB8j6oJHDCTsNEAyexXaf5
         tpVvYm2jEI75lh4NHBk43IfA6QVk3QVULtg2OWL8UIHBLGC2dkBVNxQgDPcT6Oljll/3
         271l80mDLyKQldDxd9GPzB6ij5Udjg0lW4KGfQ9abFp7PE7/nCZqFNhLioR+BQi+Nb/5
         DXE/ruclvr0OMeJ9zbPqSyYDuMMKPLnQvrHE5ZYJSG0k642zcKEz9nnbCN760z2FKCDE
         qv0ZDvbKXoXCgiImneoFqiSFshanNpULUDVrOUymh/417te/VYbPzBKYZnlN8dflP97I
         VFpw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: vim3: configure serial# from ethaddr
References: <20220119142400.127342-1-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <f2662189-2faa-8dd5-1823-1f67c462cceb@baylibre.com>
Date: Wed, 19 Jan 2022 15:43:15 +0100
MIME-Version: 1.0
In-Reply-To: <20220119142400.127342-1-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 19/01/2022 15:24, Mattijs Korpershoek wrote:
> The Khadas VIM3 and VIM3L boards, which are supported in Android via
> Yukawa [1] need a serial number for usb/fastboot enumeration.
> 
> Whenever the environment does not provide a serial#, use the eth mac
> address as serial#.
> 
> [1] https://source.android.com/setup/build/devices#vim3_and_vim3l_boards
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  board/amlogic/vim3/vim3.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> index 5d9ac6458d68..fcd60ab1e058 100644
> --- a/board/amlogic/vim3/vim3.c
> +++ b/board/amlogic/vim3/vim3.c
> @@ -153,6 +153,7 @@ int misc_init_r(void)
>  {
>  	u8 mac_addr[MAC_ADDR_LEN];
>  	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
> +	char serial_string[EFUSE_MAC_SIZE + 1];
>  	ssize_t len;
>  
>  	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
> @@ -177,5 +178,13 @@ int misc_init_r(void)
>  		eth_env_get_enetaddr("ethaddr", mac_addr);
>  	}
>  
> +	if (!env_get("serial#")) {
> +		eth_env_get_enetaddr("ethaddr", mac_addr);
> +		sprintf(serial_string, "%02X%02X%02X%02X%02X%02X",
> +			mac_addr[0], mac_addr[1], mac_addr[2],
> +			mac_addr[3], mac_addr[4], mac_addr[5]);
> +		env_set("serial#", serial_string);
> +	}
> +
>  	return 0;
>  }
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
