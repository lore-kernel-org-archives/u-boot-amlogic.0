Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE119F44845
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 11:41:31 +0000 (UTC)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.154177.1775821287603655449
 for <u-boot-amlogic@groups.io>;
 Fri, 10 Apr 2026 04:41:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=SUIZN4Qg;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.181, mailfrom: funderscore@postmarketos.org)
Date: Fri, 10 Apr 2026 11:19:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1775821284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfTdwVIXZgU3o9CNaE4R+AjFAh0F7et0TCRXMCaJ07Y=;
	b=SUIZN4QggwWRb5y581PMUQVQs1tzN+XnpQU4HC+7RQFkms71TNa7bAoOA305OGvpGkIi8r
	KHTkvAQMKveDtDHzE5HMzDxPoXT1AkmTENQoiS0MvwqPfL6x6oQvmnMyw+PWLUDLrTSA7q
	8nl9Q7HcC6wcFl7jrXSVKDY8GzvQgMtKaRXHKQE2URQJI+ekku43buj1l2ciGMN4m322PS
	oPmsYSEmwMGfcFJ8rXAHnbHrwRBqk3xGbuepfaFLpmUH1O6bOinNt5vOraN5mGK3xqEByQ
	XFCMq1JKhRU+ctacUm1VoL3/93fPuUTKgSIpWDmJjXHQMKQNj9mIqWRQdUaUMA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Anand Moon <linux.amoon@gmail.com>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, Evgeny Bachinin <EABachinin@salutedevices.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 0/4] Enable EFI Capsule on Disk on Libre Computer LePotato & LaFrite
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org> <CANAwSgT33unjY1FXmKmC2A1draM=PE5mG1sdPy+iszdGxoLmNA@mail.gmail.com>
In-Reply-To: <CANAwSgT33unjY1FXmKmC2A1draM=PE5mG1sdPy+iszdGxoLmNA@mail.gmail.com>
Message-ID: <tda0gr.210fsxfirzfnv@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 10 Apr 2026 11:41:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2962

Hi Anand,

On Fri, 10 Apr 2026 10:10, Anand Moon <linux.amoon@gmail.com> wrote:
>Hi  Ferass,
>
>On Thu, 9 Apr 2026 at 02:00, Ferass El Hafidi via groups.io
><funderscore=3Dpostmarketos.org@groups.io> wrote:
>>
>> Mostly everything is already in place to enable EFI capsules and in pa=
rticular
>> EFI capsule on disk.
>>
>> First, switch all Amlogic boards to use SYSRESET. EFI Capsule on Disk
>> functionality expects sysreset to be present. As the current reset_cpu=
()
>> function in board-common.c is basically only doing PSCI reset on U-Boo=
t
>> proper, we can replace it with sysreset's PSCI support, which works ju=
st
>> fine for that purpose provided BL31 is running (SPL stays on an
>> SoC-specific reset_cpu() which does for(;;);, as the overhead for
>> sysreset is too high and we don't have PSCI yet at that point).
>>
>> Then we can enable capsule on disk. LaFrite has Capsule updates enable=
d
>> already, so it is simply a matter of enabling CoD. LePotato does not
>> have Capsule updates enabled by default, however it can be easily enab=
led
>> and setup to update u-boot on eMMC/SD.
>>
>> With Capsule on Disk setup, it becomes possible to update U-Boot direc=
tly
>> from Linux, without having to worry about manually using `flashprog`
>> (for SPI flash) or `dd` (for eMMC/SD). Instead, thanks to CoD, updates
>> can be handled by `fwupd` and applied upon next EFI boot.
>>
>> To test:
>>
>>  * build U-Boot as usual
>>
>>  * in that running U-Boot, run: `efidebug capsule esrt` to get the GUI=
D
>>    -OR-
>>    run the following in your tree:
>>         tools/mkeficapsule guidgen path_to_devicetree_here U_BOOT_MESO=
N_MMC
>>                                            (or U_BOOT_MESON_SPI on LaF=
rite)
>>
>>  * proceed with the following guide to create a capsule file:
>>    https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#enabling-u=
efi-capsule-update-feature
>>
>>  * generate a .cab file suitable for fwupd using `mkcab`:
>>    https://gitlab.postmarketos.org/tauchgang/tauchgang-ci/-/tree/main/=
mkcab
>>         mkcab u-boot-libretech-cc.capsule GUID-GOES-HERE libretech-cc =
"LePotato" 2026.04
>>    (as of writing, the README.md suggests this is for Qualcomm only. I=
t
>>     actually does nothing that is Qualcomm-specific, and works on any
>>     board that supports Capsule on Disk and fwupd)
>>
>>  * on the board itself, boot to Linux via EFI, install fwupd, copy the=
 resulting
>>    .cab file, and run as root:
>>         fwupdtool --force install u-boot-libretech-cc.cab
>>
>>  * reboot, make sure you boot over EFI, else the capsule update will n=
ot
>>    start
>>
>> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>Thanks for your work.
>
>I haven't tested the EFI portion yet, but I have a few questions regardi=
ng
>the previous commit 17d80a3b326e ("arm: meson: spl: add support for
>SPL DRAM init").
>Could you please clarify how you generated the Meson DRAM timing paramet=
ers?
>

Reverse-engineering the BL2 blob mainly, though some ancient Amlogic
U-Boot source drops helped a lot, especially the older ones that had
some BL2 source code. Amlogic's U-Boot source drops are a huge treasure
of information when Amlogic's datasheets aren't enough.

I documented some of my work here if you want to know more:
	https://scm.dersco.re/amlogic/reversing-gxbb-bl2.git/about/

and this is my downstream U-Boot tree I use for experiments. The
`wip/spl` ones are the relevant branches:
	https://scm.dersco.re/amlogic/u-boot-kii-pro.git/

Amlogic also defines a few structs in their U-Boot fork, that ends up
being used by BL2 as acs.bin. These proved valuable for reverse-engineeri=
ng.

>I=E2=80=99m curious about the boot flow since we can apparently boot U-B=
oot without
>the Amlogic-signed BL1 firmware.
>

BL1 is the bootROM in Amlogic AArch64 BL terminology, so I suppose you=20
mean BL2. (I'm not familiar with Meson8b, maybe BL1 means something
else there)
In theory BL2, on boards without secureboot fuses blown, is not signed at
all, you can replace it with anything. For a long time, U-Boot depended
on Amlogic's BL2 blob along with the SCP firmware blob (BL30) and their
downstream Trusted Firmware-A blob (BL31). Since then, the TF-A blob got
reverse-engineered and the work was upstreamed, leaving BL2 and BL30.

My work replaces BL2 with U-Boot SPL to do DRAM init and load BL30, BL31
and U-Boot proper. However, right now, this is only possible for Meson
GXBB (S905) and GXL (S905X), though I'd like to make it happen for
G12A/B and SM1 too. It is also still experimental, so for now to have a
good experience, the BL2 blob is still recommended, though that will
hopefully change soon with some polish.

>I just wanted to understand how to upstream U-Boot for the Meson8b (Odro=
id C1+)
>platform, as it=E2=80=99s currently stuck on a very old version (v2011).=
 It's
>ARM 32-bit.
>

As I understand it, Meson8b is a completely different bootflow. I'm not
very familiar about it but I know the bootflow got redone starting with
S905 (which also happens to be the first AArch64 SoC produced by
Amlogic).

Digging in my IRC logs (#linux-amlogic on libera.chat,
https://libera.catirclogs.org/linux-amlogic/2023-06-28#34525179),
apparently these boot to an ARC HS core first, compared to these GXBB
and newer SoCs. Though I don't know the details.

In any case: Good luck and I hope you succeed at it!

If you have any more questions I'm happy to answer them.

Best regards,
Ferass

