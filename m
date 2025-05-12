Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E980C3ABCD
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 10:04:44 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web10.46650.1747044277983229394
 for <u-boot-amlogic@groups.io>;
 Mon, 12 May 2025 03:04:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=C/Q15Itc;
 spf=pass (domain: gmail.com, ip: 209.85.218.50, mailfrom: linux.amoon@gmail.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad21a5466f6so561052766b.1
        for <u-boot-amlogic@groups.io>; Mon, 12 May 2025 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747044276; x=1747649076; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7wqUmeQxImZo9I4UjDMb0Yuabns1sdp2FRzB39Gx70=;
        b=C/Q15Itcp719VFSlPWRStqqQ8ARNV0G28pnwLBLIYmskglDT0vz6MOGCd4C+5+AqEU
         gOxtFsebhjf9aeIsAOFCT+Ivg0RSXvQM/0M9Z7mI70xLSNSYuHdLJkStHHih1AVDVGxQ
         Cjg+QHY3Zj4FmD3zPrLvXYBbaLIfJW3jFIhUY7MAq1LYhP3Tt1D2ubj9jyWc/1PLyyMm
         aOpnHbkv4A/cyM6KGbgU3q5eRFRUvurR3BaxUicSBIFfiMdDeqQ3Pjbd4aJ9qcPCeTir
         tpc0XZeJqzrN6F3YaXasivfhsErLLSwCHPHy+cVW03f7uU505U8TFtJV0eq9D+S7ZwfG
         wAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747044276; x=1747649076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7wqUmeQxImZo9I4UjDMb0Yuabns1sdp2FRzB39Gx70=;
        b=ZpT0SIbRYGoB5PJM2LlD49Cg/RMPlPaLgYFSuG6vomXU4caCYbGqEesAbsezbEWPqN
         Rl/2KsIPzeUjyBVsyuRVILDZUbQiwxCtDxIcsw6TFGbOX1k2vP2uAPYDIUUw76vOu+r/
         no3TeCW0vBB3nhGU8irezRdQv3NfWCRJsUalpNHWHV7Dm4X3GO/XPTbEem9/yWHxwloQ
         yHTT8FkP15pe0eOmRnAJvFm0wPY/ZPygGhxFzPYxjb8fU5AnHmDQsq8bSxIUPATsRWIh
         6U+zxj7exYz8Zi/fn93mqpSf5hz0tERNyQAUEGqNvRnwTY2t85vIaO4w3JZr8F8n/oZ/
         yxZg==
X-Gm-Message-State: AOJu0YyWp4fIMggFiKm57NUxhDTLmDU338TiRcloiHSvZnjxbLXDZsRO
	h0W9ADvIQ5QF7CiAq6Kbl0oZesXqkAzg8Mx/ep1sYk2rRUuT0+DiVHF0Fprtxg5Kte/XipXB9xY
	ERoVSGd8dWVlkkNf7P8TNyk107uk=
X-Gm-Gg: ASbGncuSbsHj+1KbrUtUwGsp9Z6JR1yuan8FGcv3l1EFlDqgG1l6KLwr1ha+69t2VyV
	mhNxxqqt+zGPKEb1zL87iDWk8j/mnpR2WG9Xs36zoiQrfD2LlNhKoeRnR2Nj2T2YsGqwBBOpgN3
	7p/9TJPuDsBpCwz9c2oAK5y87YpfLwH9o=
X-Google-Smtp-Source: AGHT+IFa00fBbASZiwwzqM5ZvytS2NjW0Pi9nonQttu1kOtUwY1W98EiZyn0wzjG8V4b10zs8cDhHYC7NRv5OTm1olA=
X-Received: by 2002:a17:907:980f:b0:ad2:5212:5e87 with SMTP id
 a640c23a62f3a-ad252126162mr354983066b.16.1747044276051; Mon, 12 May 2025
 03:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org> <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org> <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
 <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org> <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
 <CANAwSgRkqAj5Q4LMO-CKBSoMgO-+zd6JpbVs+eWY3kPgmj9bug@mail.gmail.com>
 <CAEUiLubakMjzhi2sUTQx1S4ciTjkL6ysx465i1t-T5zKUQdUvw@mail.gmail.com>
 <CAEUiLuY2D_CzkEH0+gCvkbC_MtJ4B-MLYYkx_r2E9BHxPvuVjg@mail.gmail.com>
 <CANAwSgRvtgsejhsj=TyRAYWdQRfGRigvw9+=HzcdxbDopoiFYw@mail.gmail.com> <7BAB0A37-3DA8-4FC9-AFFE-7CAE6FA92367@gmail.com>
In-Reply-To: <7BAB0A37-3DA8-4FC9-AFFE-7CAE6FA92367@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 12 May 2025 15:34:21 +0530
X-Gm-Features: AX0GCFvF7325CEN4o8poH8aCEiTW3B4cGtpSuk-e07uajOPJy3vAypccAc3rTK4
Message-ID: <CANAwSgTtU2oe4jwJySGk7wq3QqShuyUedFjeUrE-VRi=uH1_TQ@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, Wayne Schroeder <raz@chewies.net>, 
	Ferass El Hafidi <funderscore@postmarketos.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	u-boot@lists.denx.de, 
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 12 May 2025 10:04:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2699

Hi Christian,

On Mon, 12 May 2025 at 15:05, Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> > On 12 May 2025, at 10:59=E2=80=AFam, Anand Moon via groups.io <linux.am=
oon=3Dgmail.com@groups.io> wrote:
> >
> > Hi Wayne,
> >
> > On Sun, 11 May 2025 at 01:51, Wayne Schroeder <raz@chewies.net> wrote:
> >>
> >> Applied patches to 2025.04 release (applied clean).  Made stock
> >> defconfig for odroid n2, built, signed, installed.  The reboot issue
> >> remains and usb ports are unavailable to linux kernel after reboot.
> >>
> >> It is worth noting that linux does see some enumeration of devices
> >> after a while, but even if it logs to the console about device
> >> attachment, the devices don't actually function.  This was the same
> >> behavior with the release version.
> >>
> > Thanks for testing these patches.
> > We need to modify the boot order to probe USB before MMC
>
> Why? Most Amlogic boards boot from an mmc device (SD or internal flash
> storage) not USB. It smells like a workaround not a fix, and I wonder
> what the performance impact on boot will be?
>
I'm providing a solution that may not apply to all Amlogic boards.
The goal is to ensure the USB device binds early, allowing the USB keyboard
and mass storage device to be detected promptly.
However, I'm unsure if booting from USB mass storage is supported.

Thanks
-Anand
> Christian
>
> > diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> > index f3275b37a51..3ace59880bd 100644
> > --- a/include/configs/meson64.h
> > +++ b/include/configs/meson64.h
> > @@ -119,8 +119,8 @@
> > #define BOOT_TARGET_DEVICES(func) \
> >        func(ROMUSB, romusb, na)  \
> >        func(USB_DFU, usbdfu, na)  \
> > -       BOOT_TARGET_MMC(func) \
> >        BOOT_TARGET_DEVICES_USB(func) \
> > +       BOOT_TARGET_MMC(func) \
> >        BOOT_TARGET_NVME(func) \
> >        BOOT_TARGET_SCSI(func) \
> >        BOOT_TARGET_PXE(func) \
> >
> > Here is the boot sequence at my end.
> > ------------------------
> > U-Boot 2025.07-rc1-00223-g704a4d1fd804 (May 12 2025 - 12:15:29 +0530)
> > odroid-n2/n2-plus
> >
> > Model: Hardkernel ODROID-N2
> > SoC:   Amlogic Meson G12B (S922X) Revision 29:c (40:2)
> > DRAM:  1 GiB (total 3.8 GiB)
> > Core:  402 devices, 30 uclasses, devicetree: separate
> > MMC:   mmc@ffe05000: 0, mmc@ffe07000: 1
> > Loading Environment from nowhere... OK
> > In:    usbkbd,serial
> > Out:   vidconsole,serial
> > Err:   vidconsole,serial
> > Board variant: n2-plus
> > Net:   eth0: ethernet@ff3f0000
> >
> > Hit any key to stop autoboot:  0
> > starting USB...
> > Register 3000140 NbrPorts 3
> > Starting the controller
> > USB XHCI 1.10
> > Bus usb@ff500000: 4 USB Device(s) found
> >       scanning usb for storage devices... 1 Storage Device(s) found
> >
> > Device 0: Vendor: ASMT     Rev: 0    Prod: 2115
> >            Type: Hard Disk
> >            Capacity: 114473.4 MB =3D 111.7 GB (234441648 x 512)
> > ... is now current device
> > Scanning usb 0:1...
> > Card did not respond to voltage select! : -110
> > Cannot persist EFI variables without system partition
> > Loading Boot0000 'mmc 1' failed
> > Loading Boot0001 'usb 0' failed
> > EFI boot manager: Cannot load any image
> > Card did not respond to voltage select! : -110
> > switch to partitions #0, OK
> > mmc1(part 0) is current device
> > Scanning mmc 1:1...
> > Found /extlinux/extlinux.conf
> > Retrieving file: /extlinux/extlinux.conf
> > 1:      Manjaro ARM
> > Retrieving file: /Image
> > Retrieving file: /initramfs-linux.img
> > append: initrd=3D/initramfs-linux.img console=3DttyAML0,115200n8
> > root=3DPARTUUID=3D0efc7c36-02 rootwait audit=3D0 clk_ignore_unused
> > plymouth.ignore-serial-consoles
> >
> >> Wayne
> >>
> >> On Fri, May 9, 2025 at 10:01=E2=80=AFAM Wayne Schroeder <raz@chewies.n=
et> wrote:
> >>>
> >>> Yes.  Will report back how it works on the n2+.
> >>>
> >>>
> >>> On Fri, May 9, 2025 at 2:08=E2=80=AFAM Anand Moon <linux.amoon@gmail.=
com> wrote:
> >>>>
> >>>> Hi Wayne,
> >>>>
> >>>> On Fri, 9 May 2025 at 01:25, Wayne Schroeder <raz@chewies.net> wrote=
:
> >>>>>
> >>>>> I actually already have a working solution that I documented in my
> >>>>> github repo (dubschro/odroid-n2).  All I do is set BOOTCOMMAND to
> >>>>> check/delete a flag file on my boot partition and if it is found, t=
hen
> >>>>> reset usb and sleep for 10 seconds.  I then have a systemd shutdown
> >>>>> script only on reboot to touch that file.
> >>>>>
> >>>>> CONFIG_BOOTCOMMAND=3D"fatrm mmc 0:1 reboot && echo Resetting USB on
> >>>>> reboot... && usb reset && sleep 10; run distro_bootcmd"
> >>>>>
> >>>>> It is a hack, but... the system reliably reboots remotely now, and
> >>>>> that's the important part for now.
> >>>>>
> >>>>> Wayne
> > I did not modify this at my end. However, this is not required with
> > the above fix.
> >
> > Thanks
> > -Anand
> >>>>>
> >>>>> On Thu, May 8, 2025 at 11:22=E2=80=AFAM Ferass El Hafidi
> >>>>> <funderscore@postmarketos.org> wrote:
> >>>>>>
> >>>>>> On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> >>>>>>> It's hard for me to quantify if usb works in u-boot as I'm not lo=
ading
> >>>>>>> off of any usb storage devices.  It certainly never lets me use t=
he
> >>>>>>> keyboard to abort auto boot, and never has.  On reboot, to reliab=
ly
> >>>>>>
> >>>>>> You can send bytes via UART to abort boot, if you happen to have a=
 UART
> >>>>>> adapter around.
> >>>>>
> >>>> Can you test this series to see if this resolves the issue?
> >>>>
> >>>> https://patchwork.ozlabs.org/project/uboot/list/?series=3D456088
> >>>>
> >>>> Thanks
> >>>> -Anand
> >>>>
> >>>>> _______________________________________________
> >>>>> linux-amlogic mailing list
> >>>>> linux-amlogic@lists.infradead.org
> >>>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Groups.io Links: You receive all messages sent to this group.
> > View/Reply Online (#2696): https://groups.io/g/u-boot-amlogic/message/2=
696
> > Mute This Topic: https://groups.io/mt/112625435/6407323
> > Group Owner: u-boot-amlogic+owner@groups.io
> > Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [christianshewitt=
@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

