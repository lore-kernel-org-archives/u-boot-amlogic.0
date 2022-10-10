Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web09.8090.1665418183974346795
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Oct 2022 09:09:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1665418182;
	bh=UbQqJLO9SwRPRIwQOH9ULbWF2k4ZFF3tI/9IJNtR/j0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KoACXKrRYcWz3vdKXGLXuarYfa5jyDthFPl2cE4C4JAcchyVcpuLs7i54AeLa3GwN
	 +GAjk0uq9RJF/Ld3oEPA2/CKH+zWwjXhVX/VZNGaMX7lR1dsL91q/tNGEz3rFqZqkZ
	 LL4gMI6E4OyXBMmbIz6UT8Rfq9zkzHXfjq3uLgwM8kAtDH8eofzuhMlJEdBtMoK/TE
	 uUtD+8xexB0m+79TKJo7Big3nCzV7Ufc+3iChGbu+aaz4+lpzNr2QdOfFbpYjZP1Dl
	 D8lc3UiQISZiQrAHZ88idQBA8BpEjrNF3Atnml19JIq5RBMfgSKlteqVtDgPtLgR34
	 7wuFghRoYU+UQ==
Message-ID: <503f0753-e3be-6e86-5973-2843f5267f1c@denx.de>
Date: Mon, 10 Oct 2022 18:09:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] mach-meson: g12a: reset usb controller in reset_misc()
References: <20220728-reset-usb-controller-v2-0-ef7657ce78b1@baylibre.com>
 <20220728-reset-usb-controller-v2-2-ef7657ce78b1@baylibre.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20220728-reset-usb-controller-v2-2-ef7657ce78b1@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Christian Hewitt <christianshewitt@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 10/7/22 11:38, Mattijs Korpershoek wrote:
> On some g12a boards like the VIM3L and the SEI610, with some
> USB cables/hosts, there is a long (5s) delay before
> between "fastboot reboot" and the host detecting a USB reset.
> 
> This breaks tools relying on "fastboot reboot fastboot" which assume
> that 1s after the command send, the board should disconnect on usb.
> 
> To reproduce, enable fastboot in U-Boot console:
> => fastboot usb 0
> 
> Then, on the host, run:
>    # echo "running fastboot reboot bootloader" > /dev/kmsg && fastboot reboot bootloader
>    Rebooting into bootloader                          OKAY [  0.003s]
>    Finished. Total time: 3.033s
> 
>    [54074.251551] running fastboot reboot bootloader
>    ... there is a delay of 5s before we detect a disconnection ...
>    [54079.041238] usb 1-7.4: USB disconnect, device number 72
>    [54079.239625] usb 1-7.4: new high-speed USB device number 73 using xhci_hcd
>    [54079.359103] usb 1-7.4: New USB device found, idVendor=1b8e, idProduct=fada, bcdDevice= 2.27
>    [54079.359110] usb 1-7.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>    [54079.359112] usb 1-7.4: Product: USB download gadget
>    [54079.359114] usb 1-7.4: Manufacturer: U-Boot
>    [54079.359116] usb 1-7.4: SerialNumber: C8631470CC41
> 
> Note: this does not happen when we use the RST button on the board.
> 
> To fix this, re-implement a platform reset which calls
> board_usb_cleanup() before resetting the board.

Shouldn't that call happen somewhere in drivers/usb/ .remove() callback 
instead ?
