Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by mx.groups.io with SMTP id smtpd.web11.11127.1672836647617131514
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Jan 2023 04:50:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1672836636; bh=NIcLtSrGBLXlEu4KrdkOBtj81sTlg1NukJV/luPbQAc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iPWKbFAUe7e7rkrr4gcka8qnf72YvO+GJyHntjTfdGXFgnOO/KurwxHkCsoDwqQXh
	 nS9JY6tw+C4/DHod5MLoMYQQWLtSMwF2W/T435O+OWpA5F6kv9FgO6iRqJN9C9ZcPX
	 bmDQzc9HjE1nkWX3vkYygznfws7IWr2uhDAmpPxS5jY1ex7ioGXEHbflq7zoMcppvM
	 GNepNbeGwXF5EgJkfU0OBN1MeSEiultF7Zt7YgGYzNRjhv8+K0VNtIZJAJ0jkp3o6R
	 i7pVDg2qKj5tzh9sdjDOdMlLZo2wjqP4vrKzyb9QHjL/Qm9+L+pBFUXxjF/j8Gup6j
	 LY9nchni+X0ig==
Message-ID: <9a6fa7c3-7ff2-1530-f884-fad0e54da72f@gmx.de>
Date: Wed, 4 Jan 2023 13:50:33 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/9] efi_loader: GOP: Add damage notification on BLT
References: <20230103215004.22646-1-agraf@csgraf.de>
 <20230103215004.22646-6-agraf@csgraf.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230103215004.22646-6-agraf@csgraf.de>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alexander Graf <agraf@csgraf.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, Da Xue <da@libre.computer>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>, uboot-stm32@st-md-mailman.stormreply.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>
List-ID: <u-boot-amlogic@groups.io>

On 1/3/23 22:50, Alexander Graf wrote:
> Now that we have a damage tracking API, let's populate damage done by
> UEFI payloads when they BLT data onto the screen.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> Reported-by: Da Xue <da@libre.computer>
>
> ---
>
> v1 -> v2:
>
>    - Remove ifdefs from gop
>
> v2 -> v3:
>
>    - Adapt to always assume DM is used
>
> v3 -> v4:
>
>    - Skip damage on EfiBltVideoToBltBuffer
> ---
>   lib/efi_loader/efi_gop.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
> index d1dc2f22d0..425dcbf6b1 100644
> --- a/lib/efi_loader/efi_gop.c
> +++ b/lib/efi_loader/efi_gop.c
> @@ -32,6 +32,7 @@ struct efi_gop_obj {
>   	struct efi_gop ops;
>   	struct efi_gop_mode_info info;
>   	struct efi_gop_mode mode;
> +	struct udevice *vdev;
>   	/* Fields we only have access to during init */
>   	u32 bpix;
>   	void *fb;
> @@ -120,6 +121,7 @@ static __always_inline efi_status_t gop_blt_int(struc=
t efi_gop *this,
>   	u32 *fb32 =3D gopobj->fb;
>   	u16 *fb16 =3D gopobj->fb;
>   	struct efi_gop_pixel *buffer =3D __builtin_assume_aligned(bufferp, 4);
> +	bool blt_to_video =3D (operation !=3D EFI_BLT_VIDEO_TO_BLT_BUFFER);

Using a variable is not really necessary but it could make the code more
accessible to readers.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>
>   	if (delta) {
>   		/* Check for 4 byte alignment */
> @@ -243,6 +245,9 @@ static __always_inline efi_status_t gop_blt_int(struc=
t efi_gop *this,
>   		dlineoff +=3D dwidth;
>   	}
>
> +	if (blt_to_video)
> +		video_damage(gopobj->vdev, dx, dy, width, height);
> +
>   	return EFI_SUCCESS;
>   }
>
> @@ -547,6 +552,7 @@ efi_status_t efi_gop_register(void)
>   	gopobj->info.pixels_per_scanline =3D col;
>   	gopobj->bpix =3D bpix;
>   	gopobj->fb =3D fb;
> +	gopobj->vdev =3D vdev;
>
>   	return EFI_SUCCESS;
>   }

