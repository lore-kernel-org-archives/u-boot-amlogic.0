Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A44F3ED5E
	for <webhook@archiver.kernel.org>; Sat, 11 Apr 2026 18:05:05 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.204768.1775930697532697405
 for <u-boot-amlogic@groups.io>;
 Sat, 11 Apr 2026 11:04:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fDmmLZ7D;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: linux.amoon@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6712eb9139bso96727a12.3
        for <u-boot-amlogic@groups.io>; Sat, 11 Apr 2026 11:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775930696; cv=none;
        d=google.com; s=arc-20240605;
        b=cFF6/lQCRohX5DDGrwe8jcswXIyi7mrfpPXw0cdkqzjlhIkuYJTKsSIbfNuxGwbe3n
         6XwGyJDApopBTBM73xosLsRrZgcah8slaDrc4cyiWUqQUe3NjiBPGYEUMkWg/pEFge+g
         IztpB3wWJ1NiCnv9F8bUbJfsNMY2LoAsuB7tlyLW+B/HL7Nq5i54t9WcseDPNgSRkmfp
         /4Pa0sBAk1W5TNFM9sbx27tKlRAtQVdBDCn+11qBfyrPIJPQeXQDamY/g8qm72kl3GCp
         LC4JI7jg+ao39ZwibzvhAUWb0eWjbPQ/PL/7yiH7eXTKE3IrBwGpDRwTrp5KDQ2t0J1w
         UIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JdZLouB+FGhmSI4C5yFJTNXvQUrmsgAzVBENtTZWj+k=;
        fh=C/Mjd/xS508R3k4Etjl9mGEz+V+TQDRI7iKs6UMoiQU=;
        b=epRHaTgDsMO0tiPWwBi2nwsY0YHuUefI1QKeHiScRiwDSipMF2L4WGkmbNzkA4pwTX
         SEobTs/zX20nQ//xTNBNaXB/GC1PvcrDbnzzZiEfmVBt9A95F+7vrLGO/OmuL2oFemUS
         puA4PeoQQvSGW6tKBoqtLeyE9kSTaUqS5Pa13/SfIy9LYE74b+WnrbFbJbHDExGYv7+j
         rpM4n6MpbvDUn9qk+1JRPuEl8o+5Rs5BHnADuvl5dp5eCGg2HELAWv0IaQEBNdVnB5vL
         v5nWWLk8TX/n9aT4GN0xN245bLTqiYc5zqstYHCHpqEUans+Mcgym7eerNUuaZEPiZ2i
         chAQ==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775930696; x=1776535496; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdZLouB+FGhmSI4C5yFJTNXvQUrmsgAzVBENtTZWj+k=;
        b=fDmmLZ7DCezpDCOvpuxer79PyXbtsJgccjUC47tUGSIaORFmDBwOuqObiv1yxurBCf
         3yqSy3534yi7+/nUM/sdK+ho1Y6mepbGfpZDpQAMGqALTZ6gKfj/hs8uujdFTofkM60i
         lsa+nQNQtHAsH26G8vtfLlz1YjIzEVQy1tORInxtOnVCRrS/H46IoQaq6hchpRiJdBSX
         8vv7blYOxT5CzrTpQS/ABVg3gvQPkpCQSweNYBtUS2cuKyfO4wOAv/atq0tnKX38HcOr
         twvvsdMokdQW81GadlREyosaunQVBXjnCBNDSIWfE7cXiEGzpUpkCfDa+dKI5vum1Cni
         7y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775930696; x=1776535496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JdZLouB+FGhmSI4C5yFJTNXvQUrmsgAzVBENtTZWj+k=;
        b=G5b7vz2fpwoJwaU5J1q56qLnIhW1y2jGJjMnFeg020QyjbJoMHPGKZQsWWNxZc2FU/
         gYx0OCxl2rdDtfFhviOCzoB05XPpOWxFsTwdYtUwi7bNB46zx6sEUwWhO1vA9hqnQXbK
         4LMMMO2+DzR6VHhhsYH1p06w6/zZ894tBVbVgqtwiRU0eUl/oc99Lsf8Swin/C3Mh13f
         vTGa4EkBGgv+zCB+NhszdKXbBJ18D3kxPHp9cA6YY2oCvg5qgpvz0t9h5yVy9z5I1/JT
         oVnyYYsaPlgzO+f3t1vsa52XpEos7pDV2L3PVhHHPfFHMk2HcxV/+WSvs/zXiuAcGFlO
         NKOQ==
X-Gm-Message-State: AOJu0YxzEttLJnyh1jH+MM0NBKrn0jns2gAguiiYDrE5HjAuwM5eou8U
	4NLqpAFs4zXG/+Mx0T/D7nP/jcDxaeTsPGyd3kO2n9hE039Cxy8vTyygYTRSJ05yiEcT2gVVO+7
	lX0sn+H1gH6/dhahVbtw7F89YlNmboF4=
X-Gm-Gg: AeBDieuUezovmhpj5IJMvv+gJSTTiBzrngJgTnnLmClg9lhYZ+/NrN/PyXdUlLxMDQ/
	OG06fi5Z8c7lsGyPjKa1X1vPspn3ssV94K2AycZZOrxNMlZFEG8eodnCMIvdtB+ShnLZw23LvUK
	zq4BTCtsOcGUzCsvHjyerCJeFRvIQGSWMh/LX8Gxuuk8UpSA+AgSHcTi9dtojvbQ5s6ZvDBVOAp
	X7peE1PBnJW1goPT6WKPaUup/DzAzWTg5kRBmf+EK3W1V2Fs3IxN90xI7enb5P6rRqxiGNU2wZk
	uB5pQA==
X-Received: by 2002:a17:906:518a:10b0:b96:e11e:97c4 with SMTP id
 a640c23a62f3a-b9d72793974mr320965166b.20.1775930695392; Sat, 11 Apr 2026
 11:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
 <CANAwSgT33unjY1FXmKmC2A1draM=PE5mG1sdPy+iszdGxoLmNA@mail.gmail.com> <tda0gr.210fsxfirzfnv@postmarketos.org>
In-Reply-To: <tda0gr.210fsxfirzfnv@postmarketos.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 11 Apr 2026 23:34:38 +0530
X-Gm-Features: AQROBzAZkzeQUNqEc386ptCWXdygu_4FBf88ZWUMSoEKNQQIvPMmcApMyer0iGE
Message-ID: <CANAwSgRwM_GjUuQmwXzBjUKAfwyRC7FHB6gs1u57L=Mk=PMk3g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enable EFI Capsule on Disk on Libre Computer LePotato
 & LaFrite
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
	Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Evgeny Bachinin <EABachinin@salutedevices.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 11 Apr 2026 18:05:05 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2963

Hi Ferass,

Thanks, Sorry for the late reply.

On Fri, 10 Apr 2026 at 17:11, Ferass El Hafidi
<funderscore@postmarketos.org> wrote:
>
> Hi Anand,
>
> On Fri, 10 Apr 2026 10:10, Anand Moon <linux.amoon@gmail.com> wrote:
> >Hi  Ferass,
> >
> >On Thu, 9 Apr 2026 at 02:00, Ferass El Hafidi via groups.io
> ><funderscore=3Dpostmarketos.org@groups.io> wrote:
> >>
> >> Mostly everything is already in place to enable EFI capsules and in pa=
rticular
> >> EFI capsule on disk.
> >>
> >> First, switch all Amlogic boards to use SYSRESET. EFI Capsule on Disk
> >> functionality expects sysreset to be present. As the current reset_cpu=
()
> >> function in board-common.c is basically only doing PSCI reset on U-Boo=
t
> >> proper, we can replace it with sysreset's PSCI support, which works ju=
st
> >> fine for that purpose provided BL31 is running (SPL stays on an
> >> SoC-specific reset_cpu() which does for(;;);, as the overhead for
> >> sysreset is too high and we don't have PSCI yet at that point).
> >>
> >> Then we can enable capsule on disk. LaFrite has Capsule updates enable=
d
> >> already, so it is simply a matter of enabling CoD. LePotato does not
> >> have Capsule updates enabled by default, however it can be easily enab=
led
> >> and setup to update u-boot on eMMC/SD.
> >>
> >> With Capsule on Disk setup, it becomes possible to update U-Boot direc=
tly
> >> from Linux, without having to worry about manually using `flashprog`
> >> (for SPI flash) or `dd` (for eMMC/SD). Instead, thanks to CoD, updates
> >> can be handled by `fwupd` and applied upon next EFI boot.
> >>
> >> To test:
> >>
> >>  * build U-Boot as usual
> >>
> >>  * in that running U-Boot, run: `efidebug capsule esrt` to get the GUI=
D
> >>    -OR-
> >>    run the following in your tree:
> >>         tools/mkeficapsule guidgen path_to_devicetree_here U_BOOT_MESO=
N_MMC
> >>                                            (or U_BOOT_MESON_SPI on LaF=
rite)
> >>
> >>  * proceed with the following guide to create a capsule file:
> >>    https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#enabling-u=
efi-capsule-update-feature
> >>
> >>  * generate a .cab file suitable for fwupd using `mkcab`:
> >>    https://gitlab.postmarketos.org/tauchgang/tauchgang-ci/-/tree/main/=
mkcab
> >>         mkcab u-boot-libretech-cc.capsule GUID-GOES-HERE libretech-cc =
"LePotato" 2026.04
> >>    (as of writing, the README.md suggests this is for Qualcomm only. I=
t
> >>     actually does nothing that is Qualcomm-specific, and works on any
> >>     board that supports Capsule on Disk and fwupd)
> >>
> >>  * on the board itself, boot to Linux via EFI, install fwupd, copy the=
 resulting
> >>    .cab file, and run as root:
> >>         fwupdtool --force install u-boot-libretech-cc.cab
> >>
> >>  * reboot, make sure you boot over EFI, else the capsule update will n=
ot
> >>    start
> >>
> >> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> >Thanks for your work.
> >
> >I haven't tested the EFI portion yet, but I have a few questions regardi=
ng
> >the previous commit 17d80a3b326e ("arm: meson: spl: add support for
> >SPL DRAM init").
> >Could you please clarify how you generated the Meson DRAM timing paramet=
ers?
> >
Thanks for sharing your progress on this
>
> Reverse-engineering the BL2 blob mainly, though some ancient Amlogic
> U-Boot source drops helped a lot, especially the older ones that had
> some BL2 source code. Amlogic's U-Boot source drops are a huge treasure
> of information when Amlogic's datasheets aren't enough.
>
> I documented some of my work here if you want to know more:
>         https://scm.dersco.re/amlogic/reversing-gxbb-bl2.git/about/
>
> and this is my downstream U-Boot tree I use for experiments. The
> `wip/spl` ones are the relevant branches:
>         https://scm.dersco.re/amlogic/u-boot-kii-pro.git/
>
Thanks, I will check this out.
> Amlogic also defines a few structs in their U-Boot fork, that ends up
> being used by BL2 as acs.bin. These proved valuable for reverse-engineeri=
ng.
>
> >I=E2=80=99m curious about the boot flow since we can apparently boot U-B=
oot without
> >the Amlogic-signed BL1 firmware.
> >
>
> BL1 is the bootROM in Amlogic AArch64 BL terminology, so I suppose you
> mean BL2. (I'm not familiar with Meson8b, maybe BL1 means something
> else there)
> In theory BL2, on boards without secureboot fuses blown, is not signed at
> all, you can replace it with anything. For a long time, U-Boot depended
> on Amlogic's BL2 blob along with the SCP firmware blob (BL30) and their
> downstream Trusted Firmware-A blob (BL31). Since then, the TF-A blob got
> reverse-engineered and the work was upstreamed, leaving BL2 and BL30.
>

> My work replaces BL2 with U-Boot SPL to do DRAM init and load BL30, BL31
> and U-Boot proper. However, right now, this is only possible for Meson
> GXBB (S905) and GXL (S905X), though I'd like to make it happen for
> G12A/B and SM1 too. It is also still experimental, so for now to have a
> good experience, the BL2 blob is still recommended, though that will
> hopefully change soon with some polish.
>
You have done good work in reverse engineering.
> >I just wanted to understand how to upstream U-Boot for the Meson8b (Odro=
id C1+)
> >platform, as it=E2=80=99s currently stuck on a very old version (v2011).=
 It's
> >ARM 32-bit.
> >
>
> As I understand it, Meson8b is a completely different bootflow. I'm not
> very familiar about it but I know the bootflow got redone starting with
> S905 (which also happens to be the first AArch64 SoC produced by
> Amlogic).
>
Correct, only repository I know for mesom8b
But I could not find the configuration file to build this U-Boot.
[1] https://github.com/endlessm/u-boot-meson.git
Let me check on what I can do to gather some more input on this.

> Digging in my IRC logs (#linux-amlogic on libera.chat,
> https://libera.catirclogs.org/linux-amlogic/2023-06-28#34525179),
> apparently these boot to an ARC HS core first, compared to these GXBB
> and newer SoCs. Though I don't know the details.
>
> In any case: Good luck and I hope you succeed at it!
Thanks
>
> If you have any more questions I'm happy to answer them.
>
> Best regards,
> Ferass
Thanks
-Anand

