Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by mx.groups.io with SMTP id smtpd.web09.10458.1608636496199201799
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Dec 2020 03:28:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1608636487;
	bh=HwMnnb0SE29Jktf+AvdkyZmGuN2AX0JVfsjEdY2OFUA=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
	b=AzEq3CSnXmJvwEflPlv+WS8wAOwdTJWBoDTB96dCRptzG+O0sm3lj/V31aARyY/43
	 LDYXup250sTRJCqW9RkawKf7eSLZw53qnLpFhfTV3HOHs1XcNf2qKeFb+hLlmICp45
	 pm8RSHu26eR3eiuEoUA95XWexg1Wd17pgLbhIcx8=
Subject: Re: [PATCH v4 1/3] dt-bindings: input: adc-keys bindings documentation
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20201222085633.10194-1-m.szyprowski@samsung.com>
 <CGME20201222085638eucas1p14d9d9da136593a12fea0140c403095c4@eucas1p1.samsung.com>
 <20201222085633.10194-2-m.szyprowski@samsung.com>
 <1b82e9ef-e8af-87e1-ea68-d71d65c2aa8a@gmx.de>
Message-ID: <f8930b5a-e1eb-7c41-19ad-6ba539c59322@gmx.de>
Date: Tue, 22 Dec 2020 12:28:06 +0100
MIME-Version: 1.0
In-Reply-To: <1b82e9ef-e8af-87e1-ea68-d71d65c2aa8a@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, lkml <linux-kernel@vger.kernel.org>
List-ID: <u-boot-amlogic@groups.io>

On 12/22/20 11:12 AM, Heinrich Schuchardt wrote:
> On 12/22/20 9:56 AM, Marek Szyprowski wrote:
>> Dump adc-keys bindings documentation from Linux kernel source tree v5.1=
0.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> =C2=A0 doc/device-tree-bindings/input/adc-keys.txt | 49 +++++++++++++++=
++++++
>> =C2=A0 1 file changed, 49 insertions(+)
>> =C2=A0 create mode 100644 doc/device-tree-bindings/input/adc-keys.txt
>>
>> diff --git a/doc/device-tree-bindings/input/adc-keys.txt
>> b/doc/device-tree-bindings/input/adc-keys.txt
>> new file mode 100644
>> index 0000000000..e551814629
>> --- /dev/null
>> +++ b/doc/device-tree-bindings/input/adc-keys.txt
>> @@ -0,0 +1,49 @@
>> +ADC attached resistor ladder buttons
>> +------------------------------------
>> +
>> +Required properties:
>> + - compatible: "adc-keys"
>> + - io-channels: Phandle to an ADC channel
>> + - io-channel-names =3D "buttons";
>> + - keyup-threshold-microvolt: Voltage at which all the keys are
>> considered up.
>> +
>> +Optional properties:
>> +=C2=A0=C2=A0=C2=A0 - poll-interval: Poll interval time in milliseconds
>> +=C2=A0=C2=A0=C2=A0 - autorepeat: Boolean, Enable auto repeat feature o=
f Linux input
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subsystem.
>> +
>> +Each button (key) is represented as a sub-node of "adc-keys":
>> +
>> +Required subnode-properties:
>> +=C2=A0=C2=A0=C2=A0 - label: Descriptive name of the key.
>> +=C2=A0=C2=A0=C2=A0 - linux,code: Keycode to emit.
>> +=C2=A0=C2=A0=C2=A0 - press-threshold-microvolt: Voltage ADC input when=
 this key is
>> pressed.
>
> https://www.merriam-webster.com/dictionary/threshold
> defines threshold as "a level, point, or value above which something is
> true or will take place and below which it is not or will not"
>
> "when this key is pressed" leaves it completely open if a key is
> considered pressed below or above the threshold. Please, replace the
> word 'when' by either 'above which' or 'below which'.
>
> In the example keyup-threshold-microvolt is larger than
> keyup-threshold-microvolt all values of press-threshold-microvolt. So
> one might assume that 'above' is the intended meaning and the
> interpretation of the example might be:
>
> 2.000.000 <=3D value: no key pressed
> 1.500.000 <=3D value < 2.000.000: KEY_VOLUMEUP pressed
> 1.000.000 <=3D value < 1.500.000: KEY_VOLUMEDOWN pressed
> 500.000 <=3D value < 1.000.000: KEY_ENTER pressed
> value < 500.000: no key pressed
>
> Both directions 'above' and 'below' make sense. So maybe if
> keyup-threshold-microvolt is lower than all press-threshold-microvolt
> you want to invert the logic?
>
> The binding lacks a hysteresis which is needed for a reliable function.
>
> If you look into drivers/input/keyboard/adc-keys.c in the Linux source,
> you can see that it is not using the threshold value as a threshold at
> all. Instead is uses abs(st->map[i].voltage - value) to find the nearest
> "threshold" voltage level.
>
> Could you, please, try to bring this text into a form that cannot be
> misinterpreted and reconcile with upstream. This should include
>
> * a results table for the example
> * a definition if keyup-threshold-microvolt must be higher than all
>  =C2=A0 press-threshold-microvolt or may be lower than all
>  =C2=A0 press-threshold-microvolt
> * a sentence forbidding keyup-threshold-microvolt to be between two
>  =C2=A0 press-threshold-microvolt
> * a definition if or when any of the thresholds is a lower or upper
>  =C2=A0 boundary

Cf. [PATCH 1/1] dt-bindings: adc-keys.txt: clarify description
https://lore.kernel.org/linux-input/20201222110815.24121-1-xypron.glpk@gmx=
.de/T/#u

Best regards

Heinrich

>
> Best regards
>
> Heinrich
>
>> +
>> +Example:
>> +
>> +#include <dt-bindings/input/input.h>
>> +
>> +=C2=A0=C2=A0=C2=A0 adc-keys {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adc-keys";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io-channels =3D <&lradc 0>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io-channel-names =3D "butto=
ns";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 keyup-threshold-microvolt =
=3D <2000000>;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 button-up {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lab=
el =3D "Volume Up";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lin=
ux,code =3D <KEY_VOLUMEUP>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pre=
ss-threshold-microvolt =3D <1500000>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 button-down {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lab=
el =3D "Volume Down";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lin=
ux,code =3D <KEY_VOLUMEDOWN>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pre=
ss-threshold-microvolt =3D <1000000>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 button-enter {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lab=
el =3D "Enter";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lin=
ux,code =3D <KEY_ENTER>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pre=
ss-threshold-microvolt =3D <500000>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> +=C2=A0=C2=A0=C2=A0 };
>>
>

