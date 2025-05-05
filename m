Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE135C3ABC0
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 11:54:32 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.48493.1746446248169478365
 for <u-boot-amlogic@groups.io>;
 Mon, 05 May 2025 04:57:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chewies-net.20230601.gappssmtp.com header.s=20230601 header.b=xnuYiZaF;
 spf=pass (domain: chewies.net, ip: 209.85.208.50, mailfrom: raz@chewies.net)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so7048059a12.1
        for <u-boot-amlogic@groups.io>; Mon, 05 May 2025 04:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chewies-net.20230601.gappssmtp.com; s=20230601; t=1746446246; x=1747051046; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cz9204thALwygq5pb5iv94d9PsoxiBfRcwOeexHh2ko=;
        b=xnuYiZaFHiQHqHoMP/+8qphrKh9ikoglKKOLsC7holfej/1WDw1sAPtxAG78ZTEYBN
         4sw1uff9BpCIVHg8DMkkV7vbuzwiEn9Og6kr72ZZKqvc5bKqErpqSQ1sgSPxIGgwW3S1
         FfTjr9Ri/ozKKhWrgn/vS9jnRzRkrB7mkiLfg4uAvIkMoaEN8+U0fpy50VR++k5cZvlx
         n+fYFLZRE7eW4MU/XmDifpR72B1gM1okhX9p++2yDx/BEYqY30MLvdJaOXHguLNtauA9
         VJZx13nZp99oSwhTs/x0+EuVx/oEaBo2Cb/6uGvDVu3Vv++aK9I1d6CcPw1CvFsanhqN
         azyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746446246; x=1747051046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cz9204thALwygq5pb5iv94d9PsoxiBfRcwOeexHh2ko=;
        b=nf9ofPrlX2g93tKhaW7UyEvPvUtggyNk4Mspzmzh6JkpK2O227aKQwkyNdGrRmqGSU
         I662rjg05m3idCxF1mYs5gc3LHGcZnEJP025//n7G71+299L5w59ILmNMkPLC0fFR2n+
         fw7i+sln1gAj9cd00FhmYHAWiInqRc58k8QKkx3N05nE02ah4VWRDs3cbIVTXOybG/6+
         tPEGYc6NMmIcCcBLDJ/LaHN8eHVA4F4vrne3WK2RewJBi2/1AaxzEAB0o5+/63ddcRoi
         Ucp2+kNku9+jHcx5yjpOcipwi3Ir3Dllk/S907EOOjr3j0ud+vVCguq8DdwMs1C3M90N
         aB8A==
X-Forwarded-Encrypted: i=1; AJvYcCWQRksU/FqHdT/SwfwKyxFSaOZA+p4zX0IQ8Qj6ugk7UBSP3efO3P1AgSY39cQhRQlozfFYX1W5R0JHyewQXw==@groups.io
X-Gm-Message-State: AOJu0YxZ/HmdjOSNO9qFyopw/S1+zWjW5J+OOoQzzToEGICSjyr7HoKB
	HEZjz/J19tVhrVFfASxu/jNImcM6MAKksM3feEHJ7ZPqmnfyqK3GZzIRcSWE5LjE7pFRNm2TyMz
	JKjT2V9Bzxq9XyFOJSr0VxHOlmlgNAmDxO2UzwJsWfmK3VwI=
X-Gm-Gg: ASbGncvnKfSwSsDdr7RHYL3bEfWbs7/j7VbxfMxiW44l0YC5aJkcTxF9+QXCth2xynx
	tGTdpsYNUjE8LeyvxhsQLBIHR/I9fZrmFMNxvFQIBKTCqRprkGPE9VwFu9iIBKT+1yto+NMtdbK
	BUA2FHkCYMgJGfj0rYm/g=
X-Google-Smtp-Source: AGHT+IG5pXqbOSY5LRIkAYuR+FZDlL1W5qAAW9lVh3fATnQS6jZmSGJEAsAVuYq1xm1ejAs3YnkUigf7mEMz+BKK9HE=
X-Received: by 2002:a17:907:9707:b0:ace:da41:a037 with SMTP id
 a640c23a62f3a-ad1a4ab7cd7mr628839466b.42.1746446246411; Mon, 05 May 2025
 04:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
In-Reply-To: <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
From: Wayne Schroeder <raz@chewies.net>
Date: Mon, 5 May 2025 06:57:14 -0500
X-Gm-Features: ATxdqUErTqOPiJBwH0MUNhMj9SeKwQI9gpJe3JUIs3lEO1gBgWFQXwc5mUNFHwY
Message-ID: <CAEUiLuZ+5Y6+TQsq6XrGeMJb5UVGtf5BsoAdK6R2JNY=vLFUOA@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 07 May 2025 11:54:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2668

It works at reboot with USB reset, but fails at a fresh power on now.  I
had to remove it unfortunately.

On Mon, May 5, 2025, 2:07=E2=80=AFAM <neil.armstrong@linaro.org> wrote:

> Hi,
>
> +CC u-boot-amlogic@groups.io
> +CC linux-amlogic@lists.infradead.org
>
> On 05/05/2025 00:34, Wayne Schroeder wrote:
> > Hello.  I am not sure if this is a bug, or even related to u-boot, but =
I
> am
> > reporting it here because it was easiest to resolve via a u-boot change=
.
> >
> > I am using u-boot-2025.04 (source) with a mainline linux from Arch Linu=
x
> > Arm.
> > Linux alarm 6.14.4-1-aarch64-ARCH #1 SMP PREEMPT_DYNAMIC Sat Apr 26
> > 13:02:01 MDT 2025 aarch64 GNU/Linux
> >
> > On my odroid-n2+, the USB ports work on the first boot after power.  If=
 I
> > run shutdown -r now, or hit ctl-alt-del and otherwise reboot the system=
,
> > the usb ports do not function at the next or subsequent boot up.
>
> I think it's a very long term issue, USB lacks a proper reset at probe on
> warm reset, does USB still work from U-Boot after the reboot ?
>
> >
> > My apologies if this is not applicable to u-boot because it is a linux
> > issue--I am not sure what the source of the issue is, but adjusting the
> > u-boot .config after make odroid-n2_defconfig resolved the issue
> entirely.
> >
> > I am booting via extlinux/extlinux.conf and have adjusted my
> > CONFIG_BOOTCOMMAND before build to execute a usb reset prior to the
> > existing run distro_bootcmd.
> >
> > CONFIG_BOOTCOMMAND=3D"usb reset; run distro_bootcmd"
>
> I'm pretty sure there's driver callbacks we should implement to do the
> same here, I need to check.
>
> >
> > This has allowed me to reboot the system and successfully have access t=
o
> > the USB devices such as my keyboard, mouse, and root file system on USB=
3
> > SSD.
> >
> > Thanks!
> >
> > Wayne
>
>

