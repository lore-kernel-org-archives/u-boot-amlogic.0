Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81CCC28B20
	for <webhook@archiver.kernel.org>; Wed,  2 Apr 2025 14:04:20 +0000 (UTC)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
 by mx.groups.io with SMTP id smtpd.web11.9280.1743602652358966067
 for <u-boot-amlogic@groups.io>;
 Wed, 02 Apr 2025 07:04:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=VUhieOMD;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.170, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1743602649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfGP2domM8zYyHxFUNMuUzGbwZLMvUpfq5xBKoD0v80=;
	b=VUhieOMDHoimjL1Tms1tanZVzlvUd64ZMkOMxCFAxt27W7EBUTNrurI2fblCkXxh3xapXW
	+bqavcH1JeT/97uQ+8RgjquGmbiw9gAXRU/kBxZIcOEolAhGvbAleBMU2RxuDBRLQhZLjU
	1Slskt8O8ZNQNVlZ80C0VG065EoqIgXcexBsD8kUlbFJhk3HIuiCtlFZN9qoA16rYmP+3s
	UFfRCh9jcnC8/9T9YdtZsImNzGu1qpwWwxVRXe91AP7+RxGH+oFnw7IibP+w3H4fSlFgGK
	y21/XLwahizoAyFyut7KtSO0wJTFgbPDNmpo2A6oUfalh1RdMqtECqZmCu0smw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Apr 2025 14:03:24 +0000
Message-Id: <D8W7JECRPL4G.3HTWL5VYGY6Z4@postmarketos.org>
Subject: Re: [PATCH] configs: meson64: move DFU step at the end to give the
 board a chance to boot something on storage
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: <u-boot@lists.denx.de>
To: <u-boot-amlogic@groups.io>, <neil.armstrong@linaro.org>, "Tom Rini"
 <trini@konsulko.com>
References: <20250402-u-boot-meson64-move-dfu-end-v1-1-68399499ee29@linaro.org>
In-Reply-To: <20250402-u-boot-meson64-move-dfu-end-v1-1-68399499ee29@linaro.org>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 02 Apr 2025 14:04:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2648

On Wed Apr 2, 2025 at 2:02 PM UTC, Neil Armstrong via groups.io wrote:
> The DFU was set to run at the beginning, but we may want to
> boot something over USB, MMC or Ethernet even if booted over
> USB, so move the DFU as the final fallback.
>
> This keeps the current Amlogic U-Boot CI working and makes
> the default config more generic.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Ferass El Hafidi <funderscore@postmarketos.org>

Thanks!

> ---
>  include/configs/meson64.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index f3275b37a516da6befd41324ddb2a3fe1f36fc83..675df623311f361f3a55971c3=
894ffbe1d07fee6 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -118,13 +118,13 @@
>  #ifndef BOOT_TARGET_DEVICES
>  #define BOOT_TARGET_DEVICES(func) \
>  	func(ROMUSB, romusb, na)  \
> -	func(USB_DFU, usbdfu, na)  \
>  	BOOT_TARGET_MMC(func) \
>  	BOOT_TARGET_DEVICES_USB(func) \
>  	BOOT_TARGET_NVME(func) \
>  	BOOT_TARGET_SCSI(func) \
>  	BOOT_TARGET_PXE(func) \
> -	BOOT_TARGET_DHCP(func)
> +	BOOT_TARGET_DHCP(func) \
> +	func(USB_DFU, usbdfu, na)
>  #endif
> =20
>  #define BOOTM_SIZE		__stringify(0x1700000)
>
> ---
> base-commit: c17f03a7e93dfbbe5d32f5738274187065d9493f
> change-id: 20250402-u-boot-meson64-move-dfu-end-eb9f5fe55608
>
> Best regards,


