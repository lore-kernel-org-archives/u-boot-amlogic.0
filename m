Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web08.9552.1665506189756630572
 for <u-boot-amlogic@groups.io>;
 Tue, 11 Oct 2022 09:36:30 -0700
Received: by mail-wm1-f44.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so1096174wmr.2
        for <u-boot-amlogic@groups.io>; Tue, 11 Oct 2022 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EEB/V6i4HKiu/O5BqmeU9FLC71YPS4wPERIIcoo7Zo=;
        b=Sagql1DNqHFy7BCeaGJxKVdDuD/KyojxccZz0u2j8utYlq0Km1u0WAwubkvNm3l72K
         gpvOC+ClVJLZZegjeoVkYLPWWTsmf14fjeRRczmR6TCwFoqVfpiBRwn04YXgIbvTukjA
         xQRFRdhV3QoRnHC2zYQYDXdUGoMfB9tyw6y2iHycNBJHXSoRhdWq26uiDBbW5ByQUEEe
         f5PSuNBm0m9YpZqO/sA2tkRBvRTiwxKHdaKAWingSvWosRxW+doZ/755YCmZgW+qVc5r
         VRgcq4xXORi6HToLsDBm2cB0QvtGSfftikNiTsdWbZMdNOTqdCiVQn62NRbP/9IZ9rfo
         +KXQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v2 2/2] mach-meson: g12a: reset usb controller in reset_misc()
In-Reply-To: <6b1237b8-746c-c9aa-4be4-ef323396b2f8@denx.de>
References: <20220728-reset-usb-controller-v2-0-ef7657ce78b1@baylibre.com>
 <20220728-reset-usb-controller-v2-2-ef7657ce78b1@baylibre.com>
 <503f0753-e3be-6e86-5973-2843f5267f1c@denx.de>
 <d6d054bd-370f-4da8-808b-94b23fab4c5b@linaro.org>
 <8c083cfa-4d15-e71c-ba67-8077b282fd96@denx.de>
 <938b9439-9014-5ee8-1627-16af508bface@linaro.org>
 <6b1237b8-746c-c9aa-4be4-ef323396b2f8@denx.de>
Date: Tue, 11 Oct 2022 18:36:26 +0200
Message-ID: <87czay2u7p.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Marek Vasut <marex@denx.de>, neil.armstrong@linaro.org, Christian Hewitt <christianshewitt@gmail.com>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Tue, Oct 11, 2022 at 17:39, Marek Vasut <marex@denx.de> wrote:

> On 10/11/22 09:12, neil.armstrong@linaro.org wrote:
>> On 10/10/2022 19:16, Marek Vasut wrote:
>>> On 10/10/22 18:22, Neil Armstrong wrote:
>>>> Hi,
>>>
>>> Hi,
>>>
>>>> On 10/10/2022 18:09, Marek Vasut wrote:
>>>>> On 10/7/22 11:38, Mattijs Korpershoek wrote:
>>>>>> On some g12a boards like the VIM3L and the SEI610, with some
>>>>>> USB cables/hosts, there is a long (5s) delay before
>>>>>> between "fastboot reboot" and the host detecting a USB reset.
>>>>>>
>>>>>> This breaks tools relying on "fastboot reboot fastboot" which assume
>>>>>> that 1s after the command send, the board should disconnect on usb.
>>>>>>
>>>>>> To reproduce, enable fastboot in U-Boot console:
>>>>>> =3D> fastboot usb 0
>>>>>>
>>>>>> Then, on the host, run:
>>>>>> =C2=A0=C2=A0 # echo "running fastboot reboot bootloader" > /dev/kmsg=
 &&=20
>>>>>> fastboot reboot bootloader
>>>>>> =C2=A0=C2=A0 Rebooting into bootloader=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OKAY [=C2=A0 0.003s]
>>>>>> =C2=A0=C2=A0 Finished. Total time: 3.033s
>>>>>>
>>>>>> =C2=A0=C2=A0 [54074.251551] running fastboot reboot bootloader
>>>>>> =C2=A0=C2=A0 ... there is a delay of 5s before we detect a disconnec=
tion ...
>>>>>> =C2=A0=C2=A0 [54079.041238] usb 1-7.4: USB disconnect, device number=
 72
>>>>>> =C2=A0=C2=A0 [54079.239625] usb 1-7.4: new high-speed USB device num=
ber 73=20
>>>>>> using xhci_hcd
>>>>>> =C2=A0=C2=A0 [54079.359103] usb 1-7.4: New USB device found, idVendo=
r=3D1b8e,=20
>>>>>> idProduct=3Dfada, bcdDevice=3D 2.27
>>>>>> =C2=A0=C2=A0 [54079.359110] usb 1-7.4: New USB device strings: Mfr=
=3D1,=20
>>>>>> Product=3D2, SerialNumber=3D3
>>>>>> =C2=A0=C2=A0 [54079.359112] usb 1-7.4: Product: USB download gadget
>>>>>> =C2=A0=C2=A0 [54079.359114] usb 1-7.4: Manufacturer: U-Boot
>>>>>> =C2=A0=C2=A0 [54079.359116] usb 1-7.4: SerialNumber: C8631470CC41
>>>>>>
>>>>>> Note: this does not happen when we use the RST button on the board.
>>>>>>
>>>>>> To fix this, re-implement a platform reset which calls
>>>>>> board_usb_cleanup() before resetting the board.
>>>>>
>>>>> Shouldn't that call happen somewhere in drivers/usb/ .remove()=20
>>>>> callback instead ?
>>>>
>>>> No since dwc2 isn't DM yet, handling is done in arch/arm/mac-meson=20
>>>> board_usb_*() for now
>>>
>>> Seems DWC2 is DM:
>>>
>>> $ git grep U_BOOT_DRIVER drivers/usb/ | grep dwc2
>>> drivers/usb/gadget/dwc2_udc_otg.c:U_BOOT_DRIVER(dwc2_udc_otg) =3D {
>>> drivers/usb/host/dwc2.c:U_BOOT_DRIVER(usb_dwc2) =3D {
>>>
>>=20
>> My bad, seems I missed the dwc2 otg DM wagon...
>>=20
>> We will need to switch to this now then, thanks,
>
> Thanks. I picked 1/2 at least, so you can only focus on 2/2 and send=20
> just that.

Yes, thank you for picking 1/2

Neil, do you want me to look into converting the meson arch which uses
DWC2 to DM?
I'm not sure I'm confident to do these changes properly but I'm willing
to give it a try.
If you plan to do it yourself, fine by me. I'll respin 2/2 after that.
