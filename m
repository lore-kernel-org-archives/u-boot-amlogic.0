Received: from mx.msync.work (mx.msync.work [95.217.65.204])
 by mx.groups.io with SMTP id smtpd.web08.3872.1631956088573470046
 for <u-boot-amlogic@groups.io>;
 Sat, 18 Sep 2021 02:08:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1631956082; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=YekeU+Il51ArudfdgCqsmRwSLnB38lmsgR0wtmkIv8g=;
	b=CQG38be7EgkzTPRkbkkwYhjgYsNZkVNUY9XDxbg7w8z1oAsLvanh5WW6vFIlSJJT+2MP/a
	DFJRkgvHl98mUqhlYEC+jMxIwq8DfeX62HrtwID/maPK4EyvmcjTuFA9V6fWXjM9FcrURK
	gdBBcgS87tx8nv/mF3XYLvIhT/SADynC0PH2AMXmkVThddGMvz9MYJL0uN1wFe9IDTw6zG
	YxDlljszsaAkOlBtVG0nRbyowt1Sod3SIoIKWBkUC9dOVlF3SllLRDvqz12ARkpkcwQfHf
	EwB5K/x699n89mIuRaBujHVjtpnuGuYVu1ohjIENIeJtulEn8gvgv047EbmpQw==
Subject: Re: [PATCH v3 02/10] usb: dwc3: meson-gxl: add AXG compatible
References: <20210917073709.1052133-1-narmstrong@baylibre.com>
 <20210917073709.1052133-2-narmstrong@baylibre.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Message-ID: <12b40c24-f1a3-4d04-f4ef-0a8b5e565b96@lexina.in>
Date: Sat, 18 Sep 2021 12:08:00 +0300
MIME-Version: 1.0
In-Reply-To: <20210917073709.1052133-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Tested-by: Vyacheslav Bocharov <adeep@lexina.in>

17.09.2021 10:37, Neil Armstrong =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Upstream Linux uses the "amlogic,meson-axg-usb-ctrl" for AXG SoCs.
>
> This adds it to the compatible list for this driver.
>
> Reported-by: Vyacheslav Bocharov <adeep@lexina.in>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/usb/dwc3/dwc3-meson-gxl.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-me=
son-gxl.c
> index 08467d6210..b8f3886173 100644
> --- a/drivers/usb/dwc3/dwc3-meson-gxl.c
> +++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
> @@ -409,6 +409,7 @@ static int dwc3_meson_gxl_remove(struct udevice *dev)
>   }
>  =20
>   static const struct udevice_id dwc3_meson_gxl_ids[] =3D {
> +	{ .compatible =3D "amlogic,meson-axg-usb-ctrl" },
>   	{ .compatible =3D "amlogic,meson-gxl-usb-ctrl" },
>   	{ .compatible =3D "amlogic,meson-gxm-usb-ctrl" },
>   	{ }
