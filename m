Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.429.1665422175688994410
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Oct 2022 10:16:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1665422172;
	bh=Fpy0R+UbQMK70hEwP91WBawnBjhurWxuCUIVWGjttSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UaIHK8WtEk0Acn05/2JIx8icBHOEPABZNJq9pJiqV/r+68Jhu1mgQLSu2aY44fpEO
	 wVH+xQZAOg4HYfhDZMeodX5eWq/qSYchrMWyf/ZQi/NorPkKV7HR1bc7z3gJs4cQSx
	 k+rwCRr4YLnhO2rT9FnJElKthWT9t37Owlckg/S+gYBeESj/PwwCb7IaJSYySMjf5V
	 DqeFc+KCFEUaefdRIQssXlna1BEMwTH8pG9oxB1B/GOfRL3ofcfD1WHQQDJx1ksoLV
	 p96YKmClk5Mvo/EvK2KTpcnCCO8F0KbdAmAXvXC8cjbGXkaK+uYqWescRLuPSRy2lG
	 NmDY0sTRDc3Jw==
Message-ID: <8c083cfa-4d15-e71c-ba67-8077b282fd96@denx.de>
Date: Mon, 10 Oct 2022 19:16:11 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] mach-meson: g12a: reset usb controller in reset_misc()
References: <20220728-reset-usb-controller-v2-0-ef7657ce78b1@baylibre.com>
 <20220728-reset-usb-controller-v2-2-ef7657ce78b1@baylibre.com>
 <503f0753-e3be-6e86-5973-2843f5267f1c@denx.de>
 <d6d054bd-370f-4da8-808b-94b23fab4c5b@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d6d054bd-370f-4da8-808b-94b23fab4c5b@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Christian Hewitt <christianshewitt@gmail.com>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 10/10/22 18:22, Neil Armstrong wrote:
> Hi,

Hi,

> On 10/10/2022 18:09, Marek Vasut wrote:
>> On 10/7/22 11:38, Mattijs Korpershoek wrote:
>>> On some g12a boards like the VIM3L and the SEI610, with some
>>> USB cables/hosts, there is a long (5s) delay before
>>> between "fastboot reboot" and the host detecting a USB reset.
>>>
>>> This breaks tools relying on "fastboot reboot fastboot" which assume
>>> that 1s after the command send, the board should disconnect on usb.
>>>
>>> To reproduce, enable fastboot in U-Boot console:
>>> =3D> fastboot usb 0
>>>
>>> Then, on the host, run:
>>> =C2=A0=C2=A0 # echo "running fastboot reboot bootloader" > /dev/kmsg &&=
=20
>>> fastboot reboot bootloader
>>> =C2=A0=C2=A0 Rebooting into bootloader=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OKAY [=C2=A0 0.003s]
>>> =C2=A0=C2=A0 Finished. Total time: 3.033s
>>>
>>> =C2=A0=C2=A0 [54074.251551] running fastboot reboot bootloader
>>> =C2=A0=C2=A0 ... there is a delay of 5s before we detect a disconnectio=
n ...
>>> =C2=A0=C2=A0 [54079.041238] usb 1-7.4: USB disconnect, device number 72
>>> =C2=A0=C2=A0 [54079.239625] usb 1-7.4: new high-speed USB device number=
 73=20
>>> using xhci_hcd
>>> =C2=A0=C2=A0 [54079.359103] usb 1-7.4: New USB device found, idVendor=
=3D1b8e,=20
>>> idProduct=3Dfada, bcdDevice=3D 2.27
>>> =C2=A0=C2=A0 [54079.359110] usb 1-7.4: New USB device strings: Mfr=3D1,=
=20
>>> Product=3D2, SerialNumber=3D3
>>> =C2=A0=C2=A0 [54079.359112] usb 1-7.4: Product: USB download gadget
>>> =C2=A0=C2=A0 [54079.359114] usb 1-7.4: Manufacturer: U-Boot
>>> =C2=A0=C2=A0 [54079.359116] usb 1-7.4: SerialNumber: C8631470CC41
>>>
>>> Note: this does not happen when we use the RST button on the board.
>>>
>>> To fix this, re-implement a platform reset which calls
>>> board_usb_cleanup() before resetting the board.
>>
>> Shouldn't that call happen somewhere in drivers/usb/ .remove()=20
>> callback instead ?
>=20
> No since dwc2 isn't DM yet, handling is done in arch/arm/mac-meson=20
> board_usb_*() for now

Seems DWC2 is DM:

$ git grep U_BOOT_DRIVER drivers/usb/ | grep dwc2
drivers/usb/gadget/dwc2_udc_otg.c:U_BOOT_DRIVER(dwc2_udc_otg) =3D {
drivers/usb/host/dwc2.c:U_BOOT_DRIVER(usb_dwc2) =3D {

