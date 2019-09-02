Subject: Re: [PATCH 2/2] configs: Add Khadas VIM3 defconfig
References: <20190902022851.9228-1-afaerber@suse.de>
 <20190902022851.9228-3-afaerber@suse.de>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <fc9f82e6-3a43-c319-2885-157145423a09@suse.de>
Date: Mon, 2 Sep 2019 05:02:04 +0200
MIME-Version: 1.0
In-Reply-To: <20190902022851.9228-3-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Am 02.09.19 um 04:28 schrieb Andreas F=C3=A4rber:
> diff --git a/board/amlogic/w400/README.khadas-vim3 b/board/amlogic/w400=
/README.khadas-vim3
> new file mode 100644
> index 0000000000..39b2b06000
> --- /dev/null
> +++ b/board/amlogic/w400/README.khadas-vim3
[...]
> + > DIR=3Dvim3-u-boot
> + > git clone --depth 1 \
> +       https://github.com/khadas/u-boot.git -b khadas-vim3-v2015.01 \
> +       $DIR

That branch name should've been khadas-vims-v2015.01 - both exist, the
above one was not working and the reason I held back the patches.

Regards,
Andreas

--=20
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer
HRB 247165 (AG M=C3=BCnchen)
