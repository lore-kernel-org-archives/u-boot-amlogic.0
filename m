Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web12.8274.1665418962269520683
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Oct 2022 09:22:42 -0700
Received: by mail-wr1-f47.google.com with SMTP id bp11so5041589wrb.9
        for <u-boot-amlogic@groups.io>; Mon, 10 Oct 2022 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VMJCBU677FXGaCzubHBXEs2cPcsCFnkX/RdO9zZfnaE=;
        b=tfgMMMJX1oXhE7uvRps6AdAWCvssbqxRSL2O1voXG/AxPH2O1rbrNPCdxHADLP7ONP
         DxZP03QDH5MaU0GXjGhxKAXxOaOOTdAIzgYuxs1K81KMIdMHDvDduDhqO+pnHTG7af/y
         7XdaYpJgdp0RNznG8ys93WNL35ASTzFUahHySWCijHM98HfusidMEhZ7EszTY6MoWxyN
         MVaJVXaFigwN8L1bm2qzfK3zvYdgt2SyTuCN5wJsxwHzkXqUrm5Qp1ugD35pbsDjdeUz
         jpSKHhvbawQP7VevH7qLMk5K1VXgdlbLjlhTdvmklFCNbE/anMZNC3rKVmBDOik/XSuj
         A3DQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <d6d054bd-370f-4da8-808b-94b23fab4c5b@linaro.org>
Date: Mon, 10 Oct 2022 18:22:39 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] mach-meson: g12a: reset usb controller in reset_misc()
References: <20220728-reset-usb-controller-v2-0-ef7657ce78b1@baylibre.com>
 <20220728-reset-usb-controller-v2-2-ef7657ce78b1@baylibre.com>
 <503f0753-e3be-6e86-5973-2843f5267f1c@denx.de>
In-Reply-To: <503f0753-e3be-6e86-5973-2843f5267f1c@denx.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Christian Hewitt <christianshewitt@gmail.com>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 10/10/2022 18:09, Marek Vasut wrote:
> On 10/7/22 11:38, Mattijs Korpershoek wrote:
>> On some g12a boards like the VIM3L and the SEI610, with some
>> USB cables/hosts, there is a long (5s) delay before
>> between "fastboot reboot" and the host detecting a USB reset.
>>
>> This breaks tools relying on "fastboot reboot fastboot" which assume
>> that 1s after the command send, the board should disconnect on usb.
>>
>> To reproduce, enable fastboot in U-Boot console:
>> => fastboot usb 0
>>
>> Then, on the host, run:
>>    # echo "running fastboot reboot bootloader" > /dev/kmsg && fastboot reboot bootloader
>>    Rebooting into bootloader                          OKAY [  0.003s]
>>    Finished. Total time: 3.033s
>>
>>    [54074.251551] running fastboot reboot bootloader
>>    ... there is a delay of 5s before we detect a disconnection ...
>>    [54079.041238] usb 1-7.4: USB disconnect, device number 72
>>    [54079.239625] usb 1-7.4: new high-speed USB device number 73 using xhci_hcd
>>    [54079.359103] usb 1-7.4: New USB device found, idVendor=1b8e, idProduct=fada, bcdDevice= 2.27
>>    [54079.359110] usb 1-7.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>>    [54079.359112] usb 1-7.4: Product: USB download gadget
>>    [54079.359114] usb 1-7.4: Manufacturer: U-Boot
>>    [54079.359116] usb 1-7.4: SerialNumber: C8631470CC41
>>
>> Note: this does not happen when we use the RST button on the board.
>>
>> To fix this, re-implement a platform reset which calls
>> board_usb_cleanup() before resetting the board.
> 
> Shouldn't that call happen somewhere in drivers/usb/ .remove() callback instead ?

No since dwc2 isn't DM yet, handling is done in arch/arm/mac-meson board_usb_*() for now

Neil
