Return-Path: <adeep@lexina.in>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF1C54E67
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 09:03:21 +0000 (UTC)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 by mx.groups.io with SMTP id smtpd.web11.39350.1710925394889018263
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Mar 2024 02:03:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@lexina.in header.s=dkim header.b=ir8hZ2V9;
 spf=pass (domain: lexina.in, ip: 62.182.159.68, mailfrom: adeep@lexina.in)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEB0B131599;
	Wed, 20 Mar 2024 09:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1710925391; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=Jt9xO05ovJXDSw9aTiIkE/qgt2l7SFTMJV4a9Ym0WiI=;
	b=ir8hZ2V9fh+GCCYIn0sCjkJx3ax9JlOfHjtLzis3DD2ufaz2VRDOKXT8WVClQr8FrsGahz
	OhzWWc1O5EPCa5dPgzv/Iltq+3TNyl2//Ph4PYB/6WCHYoojX0y7T0WmAN5HQ5uY8rmY5O
	AznNdqniYE2hT+5WJ0gVYcFXy29HDWBIOlItXE0wXGpZUSPJJr12e3Vvf5N13KMtR+hb3/
	+gWEAeY+2CbFC+jj+BRe6/jseV342+mZiJ3LTb12IWK9RzAwQEVTOJhfKRQp/JRz/4I/9k
	qvkeIKVTQuQlj7r19uiSACy7vuf5rtrvWOz2OR6xCLMIANcUZjolyUKMSkU/TQ==
Message-ID: <a5445dd6-3716-441e-ae47-6e0aee2071bf@lexina.in>
Date: Wed, 20 Mar 2024 12:03:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: amlogic: fix buffler overflow in seria, mac &
 usid read
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240320-u-boot-fix-p200-serial-v2-1-972be646a301@linaro.org>
Content-Language: en-US, ru-RU
From: Viacheslav <adeep@lexina.in>
Autocrypt: addr=adeep@lexina.in; keydata=
 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
In-Reply-To: <20240320-u-boot-fix-p200-serial-v2-1-972be646a301@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 20 Mar 2024 09:03:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2207

Hi!
Good catch.

for jethub devices:

Acked-by: Viacheslav Bocharov <adeep@lexina.in>

20/03/2024 11.46, Neil Armstrong wrote:
> While meson_sm_read_efuse() doesn't overflow, the string is not
> zero terminated and env_set*() will buffer overflow and add random
> characters to environment.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Also fix mac_addr
> - Link to v1: https://lore.kernel.org/r/20240319-u-boot-fix-p200-serial-v1-1-9a4e06815de0@linaro.org
> ---
>   board/amlogic/beelink-s922x/beelink-s922x.c | 3 ++-
>   board/amlogic/jethub-j100/jethub-j100.c     | 3 ++-
>   board/amlogic/jethub-j80/jethub-j80.c       | 9 ++++++---
>   board/amlogic/odroid-n2/odroid-n2.c         | 3 ++-
>   board/amlogic/p200/p200.c                   | 6 ++++--
>   board/amlogic/p201/p201.c                   | 6 ++++--
>   board/amlogic/p212/p212.c                   | 6 ++++--
>   board/amlogic/q200/q200.c                   | 6 ++++--
>   board/amlogic/vim3/vim3.c                   | 3 ++-
>   9 files changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/board/amlogic/beelink-s922x/beelink-s922x.c b/board/amlogic/beelink-s922x/beelink-s922x.c
> index adae27fc7e..c2776310a3 100644
> --- a/board/amlogic/beelink-s922x/beelink-s922x.c
> +++ b/board/amlogic/beelink-s922x/beelink-s922x.c
> @@ -20,7 +20,7 @@
>   
>   int misc_init_r(void)
>   {
> -	u8 mac_addr[MAC_ADDR_LEN];
> +	u8 mac_addr[MAC_ADDR_LEN + 1];
>   	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
>   	ssize_t len;
>   
> @@ -41,6 +41,7 @@ int misc_init_r(void)
>   			tmp[2] = '\0';
>   			mac_addr[i] = hextoul(tmp, NULL);
>   		}
> +		mac_addr[MAC_ADDR_LEN] = '\0';
>   
>   		if (is_valid_ethaddr(mac_addr))
>   			eth_env_set_enetaddr("ethaddr", mac_addr);
> diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/jethub-j100/jethub-j100.c
> index 6a2c4ad4c3..010fc0df7d 100644
> --- a/board/amlogic/jethub-j100/jethub-j100.c
> +++ b/board/amlogic/jethub-j100/jethub-j100.c
> @@ -17,7 +17,7 @@
>   
>   int misc_init_r(void)
>   {
> -	u8 mac_addr[ARP_HLEN];
> +	u8 mac_addr[ARP_HLEN + 1];
>   	char serial[SM_SERIAL_SIZE];
>   	u32 sid;
>   
> @@ -34,6 +34,7 @@ int misc_init_r(void)
>   		mac_addr[3] = (sid >> 16) & 0xff;
>   		mac_addr[4] = (sid >>  8) & 0xff;
>   		mac_addr[5] = (sid >>  0) & 0xff;
> +		mac_addr[ARP_HLEN] = '\0';
>   
>   		eth_env_set_enetaddr("ethaddr", mac_addr);
>   	}
> diff --git a/board/amlogic/jethub-j80/jethub-j80.c b/board/amlogic/jethub-j80/jethub-j80.c
> index 185880de13..0b781666e9 100644
> --- a/board/amlogic/jethub-j80/jethub-j80.c
> +++ b/board/amlogic/jethub-j80/jethub-j80.c
> @@ -27,9 +27,9 @@
>   
>   int misc_init_r(void)
>   {
> -	u8 mac_addr[EFUSE_MAC_SIZE];
> -	char serial[EFUSE_SN_SIZE];
> -	char usid[EFUSE_USID_SIZE];
> +	u8 mac_addr[EFUSE_MAC_SIZE + 1];
> +	char serial[EFUSE_SN_SIZE + 1];
> +	char usid[EFUSE_USID_SIZE + 1];
>   	ssize_t len;
>   	unsigned int adcval;
>   	int ret;
> @@ -37,6 +37,7 @@ int misc_init_r(void)
>   	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
>   		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
>   					  mac_addr, EFUSE_MAC_SIZE);
> +		mac_addr[len] = '\0';
>   		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
>   			eth_env_set_enetaddr("ethaddr", mac_addr);
>   		else
> @@ -46,6 +47,7 @@ int misc_init_r(void)
>   	if (!env_get("serial")) {
>   		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
>   					  EFUSE_SN_SIZE);
> +		serial[len] = '\0';
>   		if (len == EFUSE_SN_SIZE)
>   			env_set("serial", serial);
>   	}
> @@ -53,6 +55,7 @@ int misc_init_r(void)
>   	if (!env_get("usid")) {
>   		len = meson_sm_read_efuse(EFUSE_USID_OFFSET, usid,
>   					  EFUSE_USID_SIZE);
> +		usid[len] = '\0';
>   		if (len == EFUSE_USID_SIZE)
>   			env_set("usid", usid);
>   	}
> diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
> index 2135457edd..a4bcc62174 100644
> --- a/board/amlogic/odroid-n2/odroid-n2.c
> +++ b/board/amlogic/odroid-n2/odroid-n2.c
> @@ -107,7 +107,7 @@ static int odroid_detect_variant(void)
>   
>   int misc_init_r(void)
>   {
> -	u8 mac_addr[MAC_ADDR_LEN];
> +	u8 mac_addr[MAC_ADDR_LEN + 1];
>   	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
>   	ssize_t len;
>   
> @@ -128,6 +128,7 @@ int misc_init_r(void)
>   			tmp[2] = '\0';
>   			mac_addr[i] = hextoul(tmp, NULL);
>   		}
> +		mac_addr[MAC_ADDR_LEN] = '\0';
>   
>   		if (is_valid_ethaddr(mac_addr))
>   			eth_env_set_enetaddr("ethaddr", mac_addr);
> diff --git a/board/amlogic/p200/p200.c b/board/amlogic/p200/p200.c
> index 7c432f9d28..769e2735d2 100644
> --- a/board/amlogic/p200/p200.c
> +++ b/board/amlogic/p200/p200.c
> @@ -21,13 +21,14 @@
>   
>   int misc_init_r(void)
>   {
> -	u8 mac_addr[EFUSE_MAC_SIZE];
> -	char serial[EFUSE_SN_SIZE];
> +	u8 mac_addr[EFUSE_MAC_SIZE + 1];
> +	char serial[EFUSE_SN_SIZE + 1];
>   	ssize_t len;
>   
>   	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
>   		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
>   					  mac_addr, EFUSE_MAC_SIZE);
> +		mac_addr[len] = '\0';
>   		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
>   			eth_env_set_enetaddr("ethaddr", mac_addr);
>   	}
> @@ -35,6 +36,7 @@ int misc_init_r(void)
>   	if (!env_get("serial#")) {
>   		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
>   			EFUSE_SN_SIZE);
> +		serial[len] = '\0';
>   		if (len == EFUSE_SN_SIZE)
>   			env_set("serial#", serial);
>   	}
> diff --git a/board/amlogic/p201/p201.c b/board/amlogic/p201/p201.c
> index 7c432f9d28..769e2735d2 100644
> --- a/board/amlogic/p201/p201.c
> +++ b/board/amlogic/p201/p201.c
> @@ -21,13 +21,14 @@
>   
>   int misc_init_r(void)
>   {
> -	u8 mac_addr[EFUSE_MAC_SIZE];
> -	char serial[EFUSE_SN_SIZE];
> +	u8 mac_addr[EFUSE_MAC_SIZE + 1];
> +	char serial[EFUSE_SN_SIZE + 1];
>   	ssize_t len;
>   
>   	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
>   		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
>   					  mac_addr, EFUSE_MAC_SIZE);
> +		mac_addr[len] = '\0';
>   		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
>   			eth_env_set_enetaddr("ethaddr", mac_addr);
>   	}
> @@ -35,6 +36,7 @@ int misc_init_r(void)
>   	if (!env_get("serial#")) {
>   		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
>   			EFUSE_SN_SIZE);
> +		serial[len] = '\0';
>   		if (len == EFUSE_SN_SIZE)
>   			env_set("serial#", serial);
>   	}
> diff --git a/board/amlogic/p212/p212.c b/board/amlogic/p212/p212.c
> index fcef90bce5..f6e60ae3af 100644
> --- a/board/amlogic/p212/p212.c
> +++ b/board/amlogic/p212/p212.c
> @@ -22,13 +22,14 @@
>   
>   int misc_init_r(void)
>   {
> -	u8 mac_addr[EFUSE_MAC_SIZE];
> -	char serial[EFUSE_SN_SIZE];
> +	u8 mac_addr[EFUSE_MAC_SIZE + 1];
> +	char serial[EFUSE_SN_SIZE + 1];
>   	ssize_t len;
>   
>   	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
>   		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
>   					  mac_addr, EFUSE_MAC_SIZE);
> +		mac_addr[len] = '\0';
>   		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
>   			eth_env_set_enetaddr("ethaddr", mac_addr);
>   		else
> @@ -38,6 +39,7 @@ int misc_init_r(void)
>   	if (!env_get("serial#")) {
>   		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
>   			EFUSE_SN_SIZE);
> +		serial[len] = '\0';
>   		if (len == EFUSE_SN_SIZE)
>   			env_set("serial#", serial);
>   	}
> diff --git a/board/amlogic/q200/q200.c b/board/amlogic/q200/q200.c
> index 3aa6d8f200..47f1566a9d 100644
> --- a/board/amlogic/q200/q200.c
> +++ b/board/amlogic/q200/q200.c
> @@ -22,13 +22,14 @@
>   
>   int misc_init_r(void)
>   {
> -	u8 mac_addr[EFUSE_MAC_SIZE];
> -	char serial[EFUSE_SN_SIZE];
> +	u8 mac_addr[EFUSE_MAC_SIZE + 1];
> +	char serial[EFUSE_SN_SIZE + 1];
>   	ssize_t len;
>   
>   	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
>   		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
>   					  mac_addr, EFUSE_MAC_SIZE);
> +		mac_addr[len] = '\0';
>   		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
>   			eth_env_set_enetaddr("ethaddr", mac_addr);
>   		else
> @@ -38,6 +39,7 @@ int misc_init_r(void)
>   	if (!env_get("serial#")) {
>   		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
>   					  EFUSE_SN_SIZE);
> +		serial[len] = '\0';
>   		if (len == EFUSE_SN_SIZE)
>   			env_set("serial#", serial);
>   	}
> diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> index 8bdfb302f7..43d7a8e84f 100644
> --- a/board/amlogic/vim3/vim3.c
> +++ b/board/amlogic/vim3/vim3.c
> @@ -151,7 +151,7 @@ int meson_ft_board_setup(void *blob, struct bd_info *bd)
>   
>   int misc_init_r(void)
>   {
> -	u8 mac_addr[MAC_ADDR_LEN];
> +	u8 mac_addr[MAC_ADDR_LEN + 1];
>   	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
>   	char serial_string[EFUSE_MAC_SIZE + 1];
>   	ssize_t len;
> @@ -169,6 +169,7 @@ int misc_init_r(void)
>   			tmp[2] = '\0';
>   			mac_addr[i] = hextoul(tmp, NULL);
>   		}
> +		mac_addr[MAC_ADDR_LEN] = '\0';
>   
>   		if (is_valid_ethaddr(mac_addr))
>   			eth_env_set_enetaddr("ethaddr", mac_addr);
> 
> ---
> base-commit: b145877c22b391a4872c875145a8f86f6ffebaba
> change-id: 20240319-u-boot-fix-p200-serial-a017f57caf88
> 
> Best regards,


