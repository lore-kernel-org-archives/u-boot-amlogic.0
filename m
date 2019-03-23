Received: by mail-wm1-f66.google.com with SMTP id h18so4358087wml.1
        for <u-boot-amlogic@groups.io>; Sat, 23 Mar 2019 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=TFyTmYFnJUogsL4p+WuH4SGGlsuwfITHncLMs0N7sD8=;
        b=wcZLljlmk2vMg+FwQKxbAryILnzYOvIftsYpSIo2g1J3EeUQNb9IIRT6km7dxio3W5
         nN8DGFprbNa95N38QrfEjCvjifgexr6fpPzwagYU2KLCItnSVzVJ4awfmRBckF9bTGnm
         yMucGCSOCTLMTw+roy5YG1DUR8kQqhml8ZBW+foE3j2v92zYxQPP/t2Gfzv16/bMyKWV
         HFd0+/hvJpBcKd+xIrIDuVm472UfapHxOMLU5mx+6I0MnPWrpUO7BwQbAwPhtXRrXO+t
         5uSU7GngByygkIjrMewv4KM3eLtfIRABvXdR17JBV/uNF/5zDJEv3ykGzfopz+SPAFnC
         oNLA==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <5C9604A5.4090205@baylibre.com>
Date: Sat, 23 Mar 2019 11:04:21 +0100
From: "Neil Armstrong" <narmstrong@baylibre.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/5] Arm: dts: meson: add u-boot.dtsi for p200 and p201
References: <20190315151946.23105-1-mohammad.rasim96@gmail.com> <20190315151946.23105-2-mohammad.rasim96@gmail.com>
In-Reply-To: <20190315151946.23105-2-mohammad.rasim96@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mohammad Rasim <mohammad.rasim96@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, jbrunet@baylibre.com
List-ID: <u-boot-amlogic@groups.io>



Le 15/03/2019 16:19, Mohammad Rasim a =E9crit :
> This adds *-u-boot.dtsi files for p200 and p201 boards
> These are just copies of arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
>=20
> Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
> ---
>  arch/arm/dts/meson-gxbb-p200-u-boot.dtsi | 7 +++++++
>  arch/arm/dts/meson-gxbb-p201-u-boot.dtsi | 7 +++++++
>  2 files changed, 14 insertions(+)
>  create mode 100644 arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
>=20
> diff --git a/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi b/arch/arm/dts/meso=
n-gxbb-p200-u-boot.dtsi
> new file mode 100644
> index 000000000000..c35158d7e9ee
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-gx-u-boot.dtsi"
> diff --git a/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi b/arch/arm/dts/meso=
n-gxbb-p201-u-boot.dtsi
> new file mode 100644
> index 000000000000..c35158d7e9ee
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-gx-u-boot.dtsi"
> --
> 2.21.0
>=20

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Can you fix the subject with the same casing  (Arm =3D> ARM) ?

Neil
