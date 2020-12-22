Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by mx.groups.io with SMTP id smtpd.web08.9672.1608631945974970354
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Dec 2020 02:12:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1608631937;
	bh=5yAOvpKQGHkVAoOr1Q9MhXkVP3oveSCb+VpdI7hq/R8=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=Yt9BmO9q9y+OEmZ7dnad/hiy6t6NAZUXyAy8CZad1du57w1Ufmwzd+VAVHyXaW+LV
	 ridL7TEhOZy5ZOOBguvDEbLsN+3rzPZJyiEognU3G35eh2u2RWIxfR+U40z+9u0j1h
	 6u8rC81UkZzSN0XvWna7BPz8Ya6hRonGOkd7vjFk=
Subject: Re: [PATCH v4 1/3] dt-bindings: input: adc-keys bindings documentation
References: <20201222085633.10194-1-m.szyprowski@samsung.com>
 <CGME20201222085638eucas1p14d9d9da136593a12fea0140c403095c4@eucas1p1.samsung.com>
 <20201222085633.10194-2-m.szyprowski@samsung.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <1b82e9ef-e8af-87e1-ea68-d71d65c2aa8a@gmx.de>
Date: Tue, 22 Dec 2020 11:12:16 +0100
MIME-Version: 1.0
In-Reply-To: <20201222085633.10194-2-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, lkml <linux-kernel@vger.kernel.org>
List-ID: <u-boot-amlogic@groups.io>

On 12/22/20 9:56 AM, Marek Szyprowski wrote:
> Dump adc-keys bindings documentation from Linux kernel source tree v5.10=
.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   doc/device-tree-bindings/input/adc-keys.txt | 49 +++++++++++++++++++++
>   1 file changed, 49 insertions(+)
>   create mode 100644 doc/device-tree-bindings/input/adc-keys.txt
>
> diff --git a/doc/device-tree-bindings/input/adc-keys.txt b/doc/device-tr=
ee-bindings/input/adc-keys.txt
> new file mode 100644
> index 0000000000..e551814629
> --- /dev/null
> +++ b/doc/device-tree-bindings/input/adc-keys.txt
> @@ -0,0 +1,49 @@
> +ADC attached resistor ladder buttons
> +------------------------------------
> +
> +Required properties:
> + - compatible: "adc-keys"
> + - io-channels: Phandle to an ADC channel
> + - io-channel-names =3D "buttons";
> + - keyup-threshold-microvolt: Voltage at which all the keys are conside=
red up.
> +
> +Optional properties:
> +	- poll-interval: Poll interval time in milliseconds
> +	- autorepeat: Boolean, Enable auto repeat feature of Linux input
> +	  subsystem.
> +
> +Each button (key) is represented as a sub-node of "adc-keys":
> +
> +Required subnode-properties:
> +	- label: Descriptive name of the key.
> +	- linux,code: Keycode to emit.
> +	- press-threshold-microvolt: Voltage ADC input when this key is presse=
d.

https://www.merriam-webster.com/dictionary/threshold
defines threshold as "a level, point, or value above which something is
true or will take place and below which it is not or will not"

"when this key is pressed" leaves it completely open if a key is
considered pressed below or above the threshold. Please, replace the
word 'when' by either 'above which' or 'below which'.

In the example keyup-threshold-microvolt is larger than
keyup-threshold-microvolt all values of press-threshold-microvolt. So
one might assume that 'above' is the intended meaning and the
interpretation of the example might be:

2.000.000 <=3D value: no key pressed
1.500.000 <=3D value < 2.000.000: KEY_VOLUMEUP pressed
1.000.000 <=3D value < 1.500.000: KEY_VOLUMEDOWN pressed
500.000 <=3D value < 1.000.000: KEY_ENTER pressed
value < 500.000: no key pressed

Both directions 'above' and 'below' make sense. So maybe if
keyup-threshold-microvolt is lower than all press-threshold-microvolt
you want to invert the logic?

The binding lacks a hysteresis which is needed for a reliable function.

If you look into drivers/input/keyboard/adc-keys.c in the Linux source,
you can see that it is not using the threshold value as a threshold at
all. Instead is uses abs(st->map[i].voltage - value) to find the nearest
"threshold" voltage level.

Could you, please, try to bring this text into a form that cannot be
misinterpreted and reconcile with upstream. This should include

* a results table for the example
* a definition if keyup-threshold-microvolt must be higher than all
   press-threshold-microvolt or may be lower than all
   press-threshold-microvolt
* a sentence forbidding keyup-threshold-microvolt to be between two
   press-threshold-microvolt
* a definition if or when any of the thresholds is a lower or upper
   boundary

Best regards

Heinrich

> +
> +Example:
> +
> +#include <dt-bindings/input/input.h>
> +
> +	adc-keys {
> +		compatible =3D "adc-keys";
> +		io-channels =3D <&lradc 0>;
> +		io-channel-names =3D "buttons";
> +		keyup-threshold-microvolt =3D <2000000>;
> +
> +		button-up {
> +			label =3D "Volume Up";
> +			linux,code =3D <KEY_VOLUMEUP>;
> +			press-threshold-microvolt =3D <1500000>;
> +		};
> +
> +		button-down {
> +			label =3D "Volume Down";
> +			linux,code =3D <KEY_VOLUMEDOWN>;
> +			press-threshold-microvolt =3D <1000000>;
> +		};
> +
> +		button-enter {
> +			label =3D "Enter";
> +			linux,code =3D <KEY_ENTER>;
> +			press-threshold-microvolt =3D <500000>;
> +		};
> +	};
>

