Return-Path: <christianshewitt@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FC8C3ABCD
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 09:35:34 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.46300.1747042529520074550
 for <u-boot-amlogic@groups.io>;
 Mon, 12 May 2025 02:35:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l3IyAjiC;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: christianshewitt@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf257158fso28184975e9.2
        for <u-boot-amlogic@groups.io>; Mon, 12 May 2025 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747042528; x=1747647328; darn=groups.io;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbOjYfsn2Snomp7Q9KJqmaxWA7mFg+pHHLmdmLU++MU=;
        b=l3IyAjiCtd/lv5oZ2QIIbuB3lHxYFnaGhQrr01jIRDxGXWQ11cVUAw9LQhoQy1Ctm7
         lQRw8go3eESY2hZ7JWfNQpeWJF2Jg4FjQ2ZaUv8LbmEVfn5HUyozpUH1iz9risPhAPkC
         gjqUqdSmznomO0jACLELTSrx9T83lYOS/Qn8MuUx0SpUqWX2c6+3/rPoJyUtS++8EUd8
         mnktXVwTduev3DHmFqSuFrBEhWMsseVRA594X315JdVOZsf+Tsuj7+2HazEImHu1rg/G
         oThQKRqzAbicAhtnhNMfdQjMOlaRHBCMqYnDR4jaCSA5o2L42olwpITZjR4KUiFDiPk8
         VFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747042528; x=1747647328;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbOjYfsn2Snomp7Q9KJqmaxWA7mFg+pHHLmdmLU++MU=;
        b=xVg2UC3fM1DxzY2QXq2Mdu5WQppbvZGeU/tUyfuvjS6CtSJW1UkaSNSUbVPtjThVit
         Xr6CwfFLzoitCJP6brURQL5tUNOuAZONsFer5fx1TIJkSvL1eozLcJbhgFhJ2K+Ol3hD
         CjbnE7RMJS6pZcCSYFHKan39IEHDFitRNpvS8z94W5HWYEAJtRk+l8Re6Wjtvtje08Fm
         vm17wC5j9hY4lZ5cZBuvI24mrxlUhLkYnkGYpHUrrw5OQ1N8BaxPZnsJddbgK5UvIc5k
         kY3SgPXzOSKD6cXEMv+BK+bN8iEDnQk32zrLwWoomEKGRa5RI1GC4C11IHAhgpCRCNdI
         rRpw==
X-Gm-Message-State: AOJu0Yy+MW4a6ipU0V025VO0CZkWuYyIYFG4YIOmGy6N/shLZegyR9Qb
	y3wlanb3F0jaVE1IYhU3mCxtz+cjGBofZZxTud5PzQpx+qyvIWo5Poi7er4T
X-Gm-Gg: ASbGncuNdfkqgsq1jYIqWOQx5j33FRgSleLrgflPanXr6wjwZPTDaSIL2IOOYvpe7Pf
	coOEFIvOXnVz0MdJselHQUVFL0UZt7GnTkE9pCn5VfF4Sv0IpEzGelr/5cL8+oucIBj9QPQIWJd
	RWoXf0d85u7PXc+GFMEjse29rqTPkbQeDvpHq24xQpkb7wSl59xuLHSkRK3l+1cQrmN6ZI0X7mY
	Z/qonsJjjOAIkwpgGDTtpN1JRqVKlFG6xCbetxZLXFfmFnkSAmy/2E4Sm6P7HcWznuLjybX6cQV
	W/eyCjN5saiiHTfWhMzWzX9ShGVaCba0OeYO8kFXkH/tvDarmFEtxkCUFHa8eJn9HiYpYOFoO+m
	M
X-Google-Smtp-Source: AGHT+IFgDkddwXvqOqqSJT1CZMX1d6GgHBVAgSEHYeaDeXxa6mY3F1a1+xVt3mw4tVlYEy5aUmEcVg==
X-Received: by 2002:a5d:64ab:0:b0:3a1:f635:1133 with SMTP id ffacd0b85a97d-3a1f64220b7mr10415587f8f.7.1747042527433;
        Mon, 12 May 2025 02:35:27 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67df501sm117524455e9.12.2025.05.12.02.35.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2025 02:35:26 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Odroid n2+ usb broken on reboot
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CANAwSgRvtgsejhsj=TyRAYWdQRfGRigvw9+=HzcdxbDopoiFYw@mail.gmail.com>
Date: Mon, 12 May 2025 13:35:13 +0400
Cc: Wayne Schroeder <raz@chewies.net>,
 Ferass El Hafidi <funderscore@postmarketos.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.denx.de,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7BAB0A37-3DA8-4FC9-AFFE-7CAE6FA92367@gmail.com>
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
 <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
 <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
 <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org>
 <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
 <CANAwSgRkqAj5Q4LMO-CKBSoMgO-+zd6JpbVs+eWY3kPgmj9bug@mail.gmail.com>
 <CAEUiLubakMjzhi2sUTQx1S4ciTjkL6ysx465i1t-T5zKUQdUvw@mail.gmail.com>
 <CAEUiLuY2D_CzkEH0+gCvkbC_MtJ4B-MLYYkx_r2E9BHxPvuVjg@mail.gmail.com>
 <CANAwSgRvtgsejhsj=TyRAYWdQRfGRigvw9+=HzcdxbDopoiFYw@mail.gmail.com>
To: u-boot-amlogic@groups.io,
 linux.amoon@gmail.com
X-Mailer: Apple Mail (2.3826.500.181.1.5)
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 12 May 2025 09:35:34 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2698

> On 12 May 2025, at 10:59=E2=80=AFam, Anand Moon via groups.io =
<linux.amoon=3Dgmail.com@groups.io> wrote:
>=20
> Hi Wayne,
>=20
> On Sun, 11 May 2025 at 01:51, Wayne Schroeder <raz@chewies.net> wrote:
>>=20
>> Applied patches to 2025.04 release (applied clean).  Made stock
>> defconfig for odroid n2, built, signed, installed.  The reboot issue
>> remains and usb ports are unavailable to linux kernel after reboot.
>>=20
>> It is worth noting that linux does see some enumeration of devices
>> after a while, but even if it logs to the console about device
>> attachment, the devices don't actually function.  This was the same
>> behavior with the release version.
>>=20
> Thanks for testing these patches.
> We need to modify the boot order to probe USB before MMC

Why? Most Amlogic boards boot from an mmc device (SD or internal flash
storage) not USB. It smells like a workaround not a fix, and I wonder
what the performance impact on boot will be?

Christian

> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index f3275b37a51..3ace59880bd 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -119,8 +119,8 @@
> #define BOOT_TARGET_DEVICES(func) \
>        func(ROMUSB, romusb, na)  \
>        func(USB_DFU, usbdfu, na)  \
> -       BOOT_TARGET_MMC(func) \
>        BOOT_TARGET_DEVICES_USB(func) \
> +       BOOT_TARGET_MMC(func) \
>        BOOT_TARGET_NVME(func) \
>        BOOT_TARGET_SCSI(func) \
>        BOOT_TARGET_PXE(func) \
>=20
> Here is the boot sequence at my end.
> ------------------------
> U-Boot 2025.07-rc1-00223-g704a4d1fd804 (May 12 2025 - 12:15:29 +0530)
> odroid-n2/n2-plus
>=20
> Model: Hardkernel ODROID-N2
> SoC:   Amlogic Meson G12B (S922X) Revision 29:c (40:2)
> DRAM:  1 GiB (total 3.8 GiB)
> Core:  402 devices, 30 uclasses, devicetree: separate
> MMC:   mmc@ffe05000: 0, mmc@ffe07000: 1
> Loading Environment from nowhere... OK
> In:    usbkbd,serial
> Out:   vidconsole,serial
> Err:   vidconsole,serial
> Board variant: n2-plus
> Net:   eth0: ethernet@ff3f0000
>=20
> Hit any key to stop autoboot:  0
> starting USB...
> Register 3000140 NbrPorts 3
> Starting the controller
> USB XHCI 1.10
> Bus usb@ff500000: 4 USB Device(s) found
>       scanning usb for storage devices... 1 Storage Device(s) found
>=20
> Device 0: Vendor: ASMT     Rev: 0    Prod: 2115
>            Type: Hard Disk
>            Capacity: 114473.4 MB =3D 111.7 GB (234441648 x 512)
> ... is now current device
> Scanning usb 0:1...
> Card did not respond to voltage select! : -110
> Cannot persist EFI variables without system partition
> Loading Boot0000 'mmc 1' failed
> Loading Boot0001 'usb 0' failed
> EFI boot manager: Cannot load any image
> Card did not respond to voltage select! : -110
> switch to partitions #0, OK
> mmc1(part 0) is current device
> Scanning mmc 1:1...
> Found /extlinux/extlinux.conf
> Retrieving file: /extlinux/extlinux.conf
> 1:      Manjaro ARM
> Retrieving file: /Image
> Retrieving file: /initramfs-linux.img
> append: initrd=3D/initramfs-linux.img console=3DttyAML0,115200n8
> root=3DPARTUUID=3D0efc7c36-02 rootwait audit=3D0 clk_ignore_unused
> plymouth.ignore-serial-consoles
>=20
>> Wayne
>>=20
>> On Fri, May 9, 2025 at 10:01=E2=80=AFAM Wayne Schroeder =
<raz@chewies.net> wrote:
>>>=20
>>> Yes.  Will report back how it works on the n2+.
>>>=20
>>>=20
>>> On Fri, May 9, 2025 at 2:08=E2=80=AFAM Anand Moon =
<linux.amoon@gmail.com> wrote:
>>>>=20
>>>> Hi Wayne,
>>>>=20
>>>> On Fri, 9 May 2025 at 01:25, Wayne Schroeder <raz@chewies.net> =
wrote:
>>>>>=20
>>>>> I actually already have a working solution that I documented in my
>>>>> github repo (dubschro/odroid-n2).  All I do is set BOOTCOMMAND to
>>>>> check/delete a flag file on my boot partition and if it is found, =
then
>>>>> reset usb and sleep for 10 seconds.  I then have a systemd =
shutdown
>>>>> script only on reboot to touch that file.
>>>>>=20
>>>>> CONFIG_BOOTCOMMAND=3D"fatrm mmc 0:1 reboot && echo Resetting USB =
on
>>>>> reboot... && usb reset && sleep 10; run distro_bootcmd"
>>>>>=20
>>>>> It is a hack, but... the system reliably reboots remotely now, and
>>>>> that's the important part for now.
>>>>>=20
>>>>> Wayne
> I did not modify this at my end. However, this is not required with
> the above fix.
>=20
> Thanks
> -Anand
>>>>>=20
>>>>> On Thu, May 8, 2025 at 11:22=E2=80=AFAM Ferass El Hafidi
>>>>> <funderscore@postmarketos.org> wrote:
>>>>>>=20
>>>>>> On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
>>>>>>> It's hard for me to quantify if usb works in u-boot as I'm not =
loading
>>>>>>> off of any usb storage devices.  It certainly never lets me use =
the
>>>>>>> keyboard to abort auto boot, and never has.  On reboot, to =
reliably
>>>>>>=20
>>>>>> You can send bytes via UART to abort boot, if you happen to have =
a UART
>>>>>> adapter around.
>>>>>=20
>>>> Can you test this series to see if this resolves the issue?
>>>>=20
>>>> https://patchwork.ozlabs.org/project/uboot/list/?series=3D456088
>>>>=20
>>>> Thanks
>>>> -Anand
>>>>=20
>>>>> _______________________________________________
>>>>> linux-amlogic mailing list
>>>>> linux-amlogic@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2696): =
https://groups.io/g/u-boot-amlogic/message/2696
> Mute This Topic: https://groups.io/mt/112625435/6407323
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub =
[christianshewitt@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-



