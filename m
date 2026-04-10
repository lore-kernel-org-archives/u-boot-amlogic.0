Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F81E99078
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 10:11:11 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.152868.1775815868550625934
 for <u-boot-amlogic@groups.io>;
 Fri, 10 Apr 2026 03:11:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fMGFN/le;
 spf=pass (domain: gmail.com, ip: 209.85.218.41, mailfrom: linux.amoon@gmail.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b886fc047d5so288520666b.3
        for <u-boot-amlogic@groups.io>; Fri, 10 Apr 2026 03:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775815866; cv=none;
        d=google.com; s=arc-20240605;
        b=ijY8U2t6buN7nwmzMNrxbuYQumWTF0FB06HlMZsttN8Yi1SesYf5m7zQdgrRCghGIa
         ezela8d3JDIJlvWyH8Z/db08Dgd3cxgZufk0l1HJr+XTPgw73vGQ4YHOs9s3VqaXd7lW
         AqTOybaoWbC6ApeMyHaJy72FEF8CDXlUrKdun56QFCVxNhefUqRghMh0hntDMsf7zRtu
         Qory+7jLAgcB4dmgE2GYgDREBfVSpeIJvCjMDuDfJSKw+krNvq9s7UDPk+V0TIPWfwmF
         +nLDUf1Cu+VHXyARK+A0WVL4iYwj970AztAZdnvKBTHUp6XLeHRGODyze5CRjSTSxDY9
         qMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JI9MPqZe/XsUWHnvAdpwMk+syRqJB2KyqIeJUkQFlWE=;
        fh=l7yysKdAExrxCUqLzFmRAfJ42xeBPQbhTaYcoW2dpPk=;
        b=fI9o0xiIFKXVkf5OyuInEVlYWvJmhnQwesfWHnSVc/W3ppZElLgRW0cWayfxLQSs4K
         Ct/taJ/YciFGDUweIEqo68v5ZXytlexi6JCGMKRGrQcFWoxjxVtpx/zXwNQOQGyMvHbA
         431tpoTrehVlxWlX7kc2+PTuVKVBmdCD+V8NO8oPLmrbT5TrCt6YDznMewq+TpGTaNUV
         aA9fGRDgz+MdOTizleaxUb5EPAb9buP/fR0B6EWrwgNCgIuK1+7znWgOQV5aRADT+lHR
         1khYfIL4Ujy7HZB+7P3+1o0wzzjOYq0rDF6aFhXKI7bwgOAOhKkQDT+mQQew4/cKVVsv
         84Jg==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815866; x=1776420666; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI9MPqZe/XsUWHnvAdpwMk+syRqJB2KyqIeJUkQFlWE=;
        b=fMGFN/leD+xq6KkSdImny9k5DwR75h9uR8o1BqGtLtj5M1KViPq9xMkUQqMEQbOqnW
         SV9Up0k0eXiBR8dhYxGM3dT8/tCjDg9egGH7Fn6Iz8wq+iH9gd8PaFbpZujtZdfgc24Q
         mE+1pR4B+OypMROAfdmNgD7Z+9TCSE69sxz3UH3iyKTA/diKu0rJcxiYoXnyanBPrNHv
         e9n6hv2dyjMDyt8+n6CrbybkOsLNSdCRmj8SxqFLY3Y9PIzqfZCe9GPpXV+FrSOCvQfi
         IogZUsLr3WRtu0yAjnkpvRV5VINKhIJ+S1vxYYIKTgzr06rjCQ+6U0lZtMffr2V9fcsX
         TdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815866; x=1776420666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JI9MPqZe/XsUWHnvAdpwMk+syRqJB2KyqIeJUkQFlWE=;
        b=VQ/qZhDIx36cdDg2GtFpmgPqoNVY3e08ZbX0HRd4zJFKpgBYqihg17nzof5Z6Hrl9g
         bqofgU//XYptC4XROJyFlrMVbU40YPKHrFBl50Kfo+XDYMFpRy2BZCaHix6cYCbiXRan
         r736FwclXVVzx630YYuMAuzQaEnrxNOuzCeYO5cucjVpdLpsZDzg4OPETPYiWnUbwgCY
         /u7l5G8uJLppClXyt6N1kK4oWTwLbKFC/PDoaeDWzaytSuIBw6Yxqn6eWntSg6/GjcPT
         +SHdA1EFU/8zjldew5DHTGE8wd6IhPE7Iq1qJWh4yRKHHeYxJolUKykvsyFSGTBf4nnl
         ws1Q==
X-Gm-Message-State: AOJu0YyqvPeCk704ctJAq+kJ5vCGDXONbddCuOxROucRC/CyLS6BWQlZ
	RupUDKWnwoVwgJ0391RRhFnKOjRFc0EyTAg8vKC9UkzdoAPcgiS6Y8sMgtIbxYv1aybmlujfBuI
	ZLxTvrSd4Zhu9ydmtyQYDGaXlAaKpVE8Pe773
X-Gm-Gg: AeBDietJybeGEUQ7J/5zOgOuw99CRZ5MYVYrWdfxydOYM1dh+meFV0wQOw5NlaH8S7L
	nIuBnO0daOufIeZe64BvaTA/hc0hnGtQbdrfbOQMCGHq84yS73zYH2l1YvN22H3cwYbmxooLMHN
	UiaURa4SmMijWdM9EYa6m+FNUPe0nU/JGYfLehAxhdUlhMJmM9MTQMBUDrDXaYFRMncaOP/hPtE
	UhDwdflNCxpHwRY/WVTmatuKI7MeSSNzMbJ+yTB5bhLFbx7AI812vV1IXVBRQ9L8y6mq/1/CKcb
	GJPg5Q==
X-Received: by 2002:a17:907:2d89:b0:b9d:8697:73ad with SMTP id
 a640c23a62f3a-b9d86977702mr92740166b.26.1775815865367; Fri, 10 Apr 2026
 03:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 10 Apr 2026 15:40:48 +0530
X-Gm-Features: AQROBzBMFysIRYGQff-xMaTKxZCOgrIUq-ZXogZbNmvViQGIf9QVzVRuppW4pQ0
Message-ID: <CANAwSgT33unjY1FXmKmC2A1draM=PE5mG1sdPy+iszdGxoLmNA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enable EFI Capsule on Disk on Libre Computer LePotato
 & LaFrite
To: u-boot-amlogic@groups.io, funderscore@postmarketos.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Evgeny Bachinin <EABachinin@salutedevices.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 10 Apr 2026 10:11:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2961

Hi  Ferass,

On Thu, 9 Apr 2026 at 02:00, Ferass El Hafidi via groups.io
<funderscore=3Dpostmarketos.org@groups.io> wrote:
>
> Mostly everything is already in place to enable EFI capsules and in parti=
cular
> EFI capsule on disk.
>
> First, switch all Amlogic boards to use SYSRESET. EFI Capsule on Disk
> functionality expects sysreset to be present. As the current reset_cpu()
> function in board-common.c is basically only doing PSCI reset on U-Boot
> proper, we can replace it with sysreset's PSCI support, which works just
> fine for that purpose provided BL31 is running (SPL stays on an
> SoC-specific reset_cpu() which does for(;;);, as the overhead for
> sysreset is too high and we don't have PSCI yet at that point).
>
> Then we can enable capsule on disk. LaFrite has Capsule updates enabled
> already, so it is simply a matter of enabling CoD. LePotato does not
> have Capsule updates enabled by default, however it can be easily enabled
> and setup to update u-boot on eMMC/SD.
>
> With Capsule on Disk setup, it becomes possible to update U-Boot directly
> from Linux, without having to worry about manually using `flashprog`
> (for SPI flash) or `dd` (for eMMC/SD). Instead, thanks to CoD, updates
> can be handled by `fwupd` and applied upon next EFI boot.
>
> To test:
>
>  * build U-Boot as usual
>
>  * in that running U-Boot, run: `efidebug capsule esrt` to get the GUID
>    -OR-
>    run the following in your tree:
>         tools/mkeficapsule guidgen path_to_devicetree_here U_BOOT_MESON_M=
MC
>                                            (or U_BOOT_MESON_SPI on LaFrit=
e)
>
>  * proceed with the following guide to create a capsule file:
>    https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#enabling-uefi=
-capsule-update-feature
>
>  * generate a .cab file suitable for fwupd using `mkcab`:
>    https://gitlab.postmarketos.org/tauchgang/tauchgang-ci/-/tree/main/mkc=
ab
>         mkcab u-boot-libretech-cc.capsule GUID-GOES-HERE libretech-cc "Le=
Potato" 2026.04
>    (as of writing, the README.md suggests this is for Qualcomm only. It
>     actually does nothing that is Qualcomm-specific, and works on any
>     board that supports Capsule on Disk and fwupd)
>
>  * on the board itself, boot to Linux via EFI, install fwupd, copy the re=
sulting
>    .cab file, and run as root:
>         fwupdtool --force install u-boot-libretech-cc.cab
>
>  * reboot, make sure you boot over EFI, else the capsule update will not
>    start
>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
Thanks for your work.

I haven't tested the EFI portion yet, but I have a few questions regarding
the previous commit 17d80a3b326e ("arm: meson: spl: add support for
SPL DRAM init").
Could you please clarify how you generated the Meson DRAM timing parameters=
?

I=E2=80=99m curious about the boot flow since we can apparently boot U-Boot=
 without
the Amlogic-signed BL1 firmware.

I just wanted to understand how to upstream U-Boot for the Meson8b (Odroid =
C1+)
platform, as it=E2=80=99s currently stuck on a very old version (v2011). It=
's
ARM 32-bit.

Thanks
-Anand


> ---
> Ferass El Hafidi (4):
>       arm: mach-meson: move reset_cpu to spl only
>       arm: meson: enable SYSRESET_PSCI
>       configs: libretech-ac_defconfig: enable EFI Capsule on Disk
>       configs: libretech-cc_defconfig: enable EFI Capsule on Disk
>
>  arch/arm/mach-meson/Kconfig        |  2 ++
>  arch/arm/mach-meson/board-common.c | 14 --------------
>  arch/arm/mach-meson/spl.c          | 10 ++++++++++
>  configs/libretech-ac_defconfig     |  1 +
>  configs/libretech-cc_defconfig     |  4 ++++
>  5 files changed, 17 insertions(+), 14 deletions(-)
> ---
> base-commit: 4dc4080805fac1b1ed7606ce3bc8fb44a6d59d5e
> change-id: 20260408-b4-amlogic-sysreset-capsules-8f5962defafb
>
> Best regards,
> --
> Ferass El Hafidi <funderscore@postmarketos.org>
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2952): https://groups.io/g/u-boot-amlogic/message/295=
2
> Mute This Topic: https://groups.io/mt/118732104/6056667
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [linux.amoon@gmail.=
com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

