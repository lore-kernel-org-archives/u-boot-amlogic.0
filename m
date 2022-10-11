Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.10639.1665511033404094949
 for <u-boot-amlogic@groups.io>;
 Tue, 11 Oct 2022 10:57:13 -0700
Received: by mail-wr1-f44.google.com with SMTP id j16so22795608wrh.5
        for <u-boot-amlogic@groups.io>; Tue, 11 Oct 2022 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0xkJAcxyA9IN4rf8qaIcU/cixTuwrMZeYOzT4ip1aLQ=;
        b=O/h1EY1DazOVfUGQj0zZptu95IwmP7iKofyOUe3i52lsAuV7nWhlzw2pbCg/9e/iG2
         pLogjkFpIySo7QmG1boio79pMj+cAy+pIF47ekkvcnekGRju+hUsi0ozSnhHT45E0A6Z
         L+Xwl4b49sqgTlJZ1u2NVA7VG2XSqzawj0nTSRmuQsJGcyd+dxg/zL3d1t9uSfm86oYN
         xwoLfq99cKx4yIHZ7LnyMtTzYl9z/Tmhk0J6i3pjqmd9WmJyy2qRqd55jzYcr0Cu5hZ6
         k0gL7haOoU0Qx/ykyNsVaTytOoWu45EZoI4V3nRs9iZJG4pe2qzxIe4vMKV2SNAQ9SCz
         sQtw==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <2fa3ba46-7a63-1a95-1961-9a1268aff709@linaro.org>
Date: Tue, 11 Oct 2022 19:57:10 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] mach-meson: g12a: reset usb controller in reset_misc()
References: <20220728-reset-usb-controller-v2-0-ef7657ce78b1@baylibre.com>
 <20220728-reset-usb-controller-v2-2-ef7657ce78b1@baylibre.com>
 <503f0753-e3be-6e86-5973-2843f5267f1c@denx.de>
 <d6d054bd-370f-4da8-808b-94b23fab4c5b@linaro.org>
 <8c083cfa-4d15-e71c-ba67-8077b282fd96@denx.de>
 <938b9439-9014-5ee8-1627-16af508bface@linaro.org>
 <6b1237b8-746c-c9aa-4be4-ef323396b2f8@denx.de> <87czay2u7p.fsf@baylibre.com>
In-Reply-To: <87czay2u7p.fsf@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>, Christian Hewitt <christianshewitt@gmail.com>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 11/10/2022 18:36, Mattijs Korpershoek wrote:
> On Tue, Oct 11, 2022 at 17:39, Marek Vasut <marex@denx.de> wrote:
> 
>> On 10/11/22 09:12, neil.armstrong@linaro.org wrote:
>>> On 10/10/2022 19:16, Marek Vasut wrote:
>>>> On 10/10/22 18:22, Neil Armstrong wrote:
>>>>> Hi,
>>>>
>>>> Hi,
>>>>
>>>>> On 10/10/2022 18:09, Marek Vasut wrote:
>>>>>> On 10/7/22 11:38, Mattijs Korpershoek wrote:
>>>>>>> On some g12a boards like the VIM3L and the SEI610, with some
>>>>>>> USB cables/hosts, there is a long (5s) delay before
>>>>>>> between "fastboot reboot" and the host detecting a USB reset.
>>>>>>>
>>>>>>> This breaks tools relying on "fastboot reboot fastboot" which assume
>>>>>>> that 1s after the command send, the board should disconnect on usb.
>>>>>>>
>>>>>>> To reproduce, enable fastboot in U-Boot console:
>>>>>>> => fastboot usb 0
>>>>>>>
>>>>>>> Then, on the host, run:
>>>>>>>     # echo "running fastboot reboot bootloader" > /dev/kmsg &&
>>>>>>> fastboot reboot bootloader
>>>>>>>     Rebooting into bootloader                          OKAY [  0.003s]
>>>>>>>     Finished. Total time: 3.033s
>>>>>>>
>>>>>>>     [54074.251551] running fastboot reboot bootloader
>>>>>>>     ... there is a delay of 5s before we detect a disconnection ...
>>>>>>>     [54079.041238] usb 1-7.4: USB disconnect, device number 72
>>>>>>>     [54079.239625] usb 1-7.4: new high-speed USB device number 73
>>>>>>> using xhci_hcd
>>>>>>>     [54079.359103] usb 1-7.4: New USB device found, idVendor=1b8e,
>>>>>>> idProduct=fada, bcdDevice= 2.27
>>>>>>>     [54079.359110] usb 1-7.4: New USB device strings: Mfr=1,
>>>>>>> Product=2, SerialNumber=3
>>>>>>>     [54079.359112] usb 1-7.4: Product: USB download gadget
>>>>>>>     [54079.359114] usb 1-7.4: Manufacturer: U-Boot
>>>>>>>     [54079.359116] usb 1-7.4: SerialNumber: C8631470CC41
>>>>>>>
>>>>>>> Note: this does not happen when we use the RST button on the board.
>>>>>>>
>>>>>>> To fix this, re-implement a platform reset which calls
>>>>>>> board_usb_cleanup() before resetting the board.
>>>>>>
>>>>>> Shouldn't that call happen somewhere in drivers/usb/ .remove()
>>>>>> callback instead ?
>>>>>
>>>>> No since dwc2 isn't DM yet, handling is done in arch/arm/mac-meson
>>>>> board_usb_*() for now
>>>>
>>>> Seems DWC2 is DM:
>>>>
>>>> $ git grep U_BOOT_DRIVER drivers/usb/ | grep dwc2
>>>> drivers/usb/gadget/dwc2_udc_otg.c:U_BOOT_DRIVER(dwc2_udc_otg) = {
>>>> drivers/usb/host/dwc2.c:U_BOOT_DRIVER(usb_dwc2) = {
>>>>
>>>
>>> My bad, seems I missed the dwc2 otg DM wagon...
>>>
>>> We will need to switch to this now then, thanks,
>>
>> Thanks. I picked 1/2 at least, so you can only focus on 2/2 and send
>> just that.
> 
> Yes, thank you for picking 1/2
> 
> Neil, do you want me to look into converting the meson arch which uses
> DWC2 to DM?
> I'm not sure I'm confident to do these changes properly but I'm willing
> to give it a try.
> If you plan to do it yourself, fine by me. I'll respin 2/2 after that.

Sure, give a try, if you don't manage I can help!


Neil
