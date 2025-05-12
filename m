Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FDBC3ABCB
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 07:00:11 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.44367.1747033203847643943
 for <u-boot-amlogic@groups.io>;
 Mon, 12 May 2025 00:00:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A15QmmwB;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: linux.amoon@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac34257295dso697759266b.2
        for <u-boot-amlogic@groups.io>; Mon, 12 May 2025 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747033202; x=1747638002; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE4W61aAOb1s0oTAzxitw/T5NG98quwd4lODU2UlHFo=;
        b=A15QmmwBiL0nYM0YHv3Wjp/jdMslMk8f3vDrjfhk7CRCtpXdVfW6NU/RTrKqfxeI5F
         zgVr1nglJkT/CwBb2qaXT6pa1MA54wDmgwD4jASKnMjyKiiP33jwFn9QKS5O29IVJzOw
         C78ghEcWgfETlXrcBkyLaBU+6hfE+k+oSqkfNPY8G3W2/QR9dtZyu+g/KTKnQcT/F9VY
         KlFQo3pom2kaMQl2HRHoEZ61HtxJSwgVn8Tk680lKBCvOtUYsH2LxNeXRhdpjWdFFuPV
         0S28VpQ90hW84+L6X58KW5EKjKAw0rS7iCZGP+iLQ0Z4AS8GSObk/fuZzcBdNbhldoNc
         TiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747033202; x=1747638002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE4W61aAOb1s0oTAzxitw/T5NG98quwd4lODU2UlHFo=;
        b=cPV6ajwBbDu0fSqct6NtCyFn2S48NqBuh9LkVIySLA8gdsqxfH7/tE9Y29IWuCT9zL
         G98ITHk++65OnIQtq6m9rgFcmAyzXTkutap0F0YmYiLSMkJds+b9SRMkNYU6rjKKNHB4
         g9xQ6JASGI5JC2q6LzQdZjbLmpFMdMQP/eS5Gn5lOk33ZY3s7NkkMC/GAi/hdG8OlIfo
         /AjoU7USVyq9DHv0EgZPqbihUyzX+QgH5sGM7fZ4DSKvqVaUuCzKQlTYAkENrghpZtXC
         Z1T2M6HFu1LKyw5vo0aQvJo1oNHS28/6CkvRQNdmuG1e95EbL8Jr01gccgLtzv6vpKSx
         TWzw==
X-Forwarded-Encrypted: i=1; AJvYcCVxuoz0oujTAOifZn9Y/tAK0jSzzCNtwuD7mStlGCfnSMwEexycjhiYxrfcwQytWNfDp8e224PR0a2G4+hcOg==@groups.io
X-Gm-Message-State: AOJu0YwQYvkAeZESWk7gz3xnTtylPeqzdQyhJMdHaTxxahipcT7fiMr7
	B4Fep8ziGVMAnbtHGIcAdpoHZtgl7NZLR8RJYyA8qW6MtgJPfYoIttbiynsESrc83eyhglx7H94
	pz4Vv+TdEaWeWaI/41n1/7tTPVug=
X-Gm-Gg: ASbGncvDNIYtYvn4ogA6qK/WhabCgM2I2x2Q14RjZYMdjGDgCDcOEtWT1Y1o6iNJ+E2
	nPZg+THFopk7hN8qsVSspN6oEuy+uurlLPutlvwrC2+ITj+D9LnEHjYuQ2NB+xurbTJFnzsfElY
	Vu/Jr1QqY41l2K2u1XI27p/FS/8ZakXbA=
X-Google-Smtp-Source: AGHT+IGMxSCbWcgPzDLdDPHV7TfxL8v/NW+1JmcI6bueniQxO5V4IVkVoPOd+64ynfcPW+GlQfBTX11OdkJnRa9tEGY=
X-Received: by 2002:a17:907:a4c1:b0:ace:d957:d6d8 with SMTP id
 a640c23a62f3a-ad2190246bamr985408566b.34.1747033201870; Mon, 12 May 2025
 00:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org> <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org> <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
 <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org> <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
 <CANAwSgRkqAj5Q4LMO-CKBSoMgO-+zd6JpbVs+eWY3kPgmj9bug@mail.gmail.com>
 <CAEUiLubakMjzhi2sUTQx1S4ciTjkL6ysx465i1t-T5zKUQdUvw@mail.gmail.com> <CAEUiLuY2D_CzkEH0+gCvkbC_MtJ4B-MLYYkx_r2E9BHxPvuVjg@mail.gmail.com>
In-Reply-To: <CAEUiLuY2D_CzkEH0+gCvkbC_MtJ4B-MLYYkx_r2E9BHxPvuVjg@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 12 May 2025 12:29:46 +0530
X-Gm-Features: AX0GCFuPfWHrJ33a9lpuqKkhYPNkooJHOZyZqq_x46YoNFQCXw_ATD6jRE8W2w8
Message-ID: <CANAwSgRvtgsejhsj=TyRAYWdQRfGRigvw9+=HzcdxbDopoiFYw@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: Wayne Schroeder <raz@chewies.net>
Cc: Ferass El Hafidi <funderscore@postmarketos.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
	"u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, 
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 12 May 2025 07:00:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2696

Hi Wayne,

On Sun, 11 May 2025 at 01:51, Wayne Schroeder <raz@chewies.net> wrote:
>
> Applied patches to 2025.04 release (applied clean).  Made stock
> defconfig for odroid n2, built, signed, installed.  The reboot issue
> remains and usb ports are unavailable to linux kernel after reboot.
>
> It is worth noting that linux does see some enumeration of devices
> after a while, but even if it logs to the console about device
> attachment, the devices don't actually function.  This was the same
> behavior with the release version.
>
Thanks for testing these patches.
We need to modify the boot order to probe USB before MMC

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index f3275b37a51..3ace59880bd 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -119,8 +119,8 @@
 #define BOOT_TARGET_DEVICES(func) \
        func(ROMUSB, romusb, na)  \
        func(USB_DFU, usbdfu, na)  \
-       BOOT_TARGET_MMC(func) \
        BOOT_TARGET_DEVICES_USB(func) \
+       BOOT_TARGET_MMC(func) \
        BOOT_TARGET_NVME(func) \
        BOOT_TARGET_SCSI(func) \
        BOOT_TARGET_PXE(func) \

Here is the boot sequence at my end.
------------------------
U-Boot 2025.07-rc1-00223-g704a4d1fd804 (May 12 2025 - 12:15:29 +0530)
odroid-n2/n2-plus

Model: Hardkernel ODROID-N2
SoC:   Amlogic Meson G12B (S922X) Revision 29:c (40:2)
DRAM:  1 GiB (total 3.8 GiB)
Core:  402 devices, 30 uclasses, devicetree: separate
MMC:   mmc@ffe05000: 0, mmc@ffe07000: 1
Loading Environment from nowhere... OK
In:    usbkbd,serial
Out:   vidconsole,serial
Err:   vidconsole,serial
Board variant: n2-plus
Net:   eth0: ethernet@ff3f0000

Hit any key to stop autoboot:  0
starting USB...
Register 3000140 NbrPorts 3
Starting the controller
USB XHCI 1.10
Bus usb@ff500000: 4 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found

Device 0: Vendor: ASMT     Rev: 0    Prod: 2115
            Type: Hard Disk
            Capacity: 114473.4 MB =3D 111.7 GB (234441648 x 512)
... is now current device
Scanning usb 0:1...
Card did not respond to voltage select! : -110
Cannot persist EFI variables without system partition
Loading Boot0000 'mmc 1' failed
Loading Boot0001 'usb 0' failed
EFI boot manager: Cannot load any image
Card did not respond to voltage select! : -110
switch to partitions #0, OK
mmc1(part 0) is current device
Scanning mmc 1:1...
Found /extlinux/extlinux.conf
Retrieving file: /extlinux/extlinux.conf
1:      Manjaro ARM
Retrieving file: /Image
Retrieving file: /initramfs-linux.img
append: initrd=3D/initramfs-linux.img console=3DttyAML0,115200n8
root=3DPARTUUID=3D0efc7c36-02 rootwait audit=3D0 clk_ignore_unused
plymouth.ignore-serial-consoles

> Wayne
>
> On Fri, May 9, 2025 at 10:01=E2=80=AFAM Wayne Schroeder <raz@chewies.net>=
 wrote:
> >
> > Yes.  Will report back how it works on the n2+.
> >
> >
> > On Fri, May 9, 2025 at 2:08=E2=80=AFAM Anand Moon <linux.amoon@gmail.co=
m> wrote:
> > >
> > > Hi Wayne,
> > >
> > > On Fri, 9 May 2025 at 01:25, Wayne Schroeder <raz@chewies.net> wrote:
> > > >
> > > > I actually already have a working solution that I documented in my
> > > > github repo (dubschro/odroid-n2).  All I do is set BOOTCOMMAND to
> > > > check/delete a flag file on my boot partition and if it is found, t=
hen
> > > > reset usb and sleep for 10 seconds.  I then have a systemd shutdown
> > > > script only on reboot to touch that file.
> > > >
> > > > CONFIG_BOOTCOMMAND=3D"fatrm mmc 0:1 reboot && echo Resetting USB on
> > > > reboot... && usb reset && sleep 10; run distro_bootcmd"
> > > >
> > > > It is a hack, but... the system reliably reboots remotely now, and
> > > > that's the important part for now.
> > > >
> > > > Wayne
I did not modify this at my end. However, this is not required with
the above fix.

Thanks
-Anand
> > > >
> > > > On Thu, May 8, 2025 at 11:22=E2=80=AFAM Ferass El Hafidi
> > > > <funderscore@postmarketos.org> wrote:
> > > > >
> > > > > On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> > > > > > It's hard for me to quantify if usb works in u-boot as I'm not =
loading
> > > > > > off of any usb storage devices.  It certainly never lets me use=
 the
> > > > > > keyboard to abort auto boot, and never has.  On reboot, to reli=
ably
> > > > >
> > > > > You can send bytes via UART to abort boot, if you happen to have =
a UART
> > > > > adapter around.
> > > >
> > > Can you test this series to see if this resolves the issue?
> > >
> > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D456088
> > >
> > > Thanks
> > > -Anand
> > >
> > > > _______________________________________________
> > > > linux-amlogic mailing list
> > > > linux-amlogic@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-amlogic

