Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web12.9115.1608386330058303358
 for <u-boot-amlogic@groups.io>;
 Sat, 19 Dec 2020 05:58:50 -0800
Received: by mail-ed1-f48.google.com with SMTP id u19so5263166edx.2
        for <u-boot-amlogic@groups.io>; Sat, 19 Dec 2020 05:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0Wj3hTLe7QvwO5Tkm/aGsAdbvIGY4dIAULLk39tR4k=;
        b=fqL7dlK4vwrfsFGdZV5K6lmeJpmgtiCLdE1mlj5hOdo12X7uwGUSvuE1A7S1+/NIGP
         LhYtnd3PjQ93dFQ33Msv1X50EwoDmr+I5I+POHgNRg1Tj92wqjOZ8xBdQgRbth4TxKfm
         1oO8DJyYct0puFfSZOw2ltuyJEvj7gKa/+wf/xe/LAAFUHcYMaDfXecst8UGpSoH7HqP
         nAjyzY3LY1fU/+KWgwAFXxQsBSmba/ywtkCB4UG7C+7R6mdQIqBdNsPu3a7ac9KK0qv9
         cI+O1DOnULKlpknCljIrK8fPoHbSA+45Hnt1Q3uIY9oh6FoDiqe6fa96kCBsqZry112k
         ncuQ==
MIME-Version: 1.0
References: <c2dc3507-67a7-3c18-374f-050295bc1d59@gmx.net> <CAFBinCDrMj4GP2cy4dBSt_isGXf4CuhmDz=uAs+gZwUGQc=o6A@mail.gmail.com>
 <8afb2adb-4581-a847-e7e0-db1e915e9247@gmx.net> <CAFBinCD6aqna6YYvXgO5iKWa9N3yvqehhB+SAirLaUu3xScy2Q@mail.gmail.com>
 <bd9d96d2-8b66-db93-a855-5e179adca8c9@gmx.net> <0d05671d-b5f4-55e4-f5bd-58410cc92d08@baylibre.com>
 <dd160e55-55e9-1c41-afcb-22990a05a86b@gmx.net> <CAFBinCDv+TgEgf1g7xBTknr-aJMhC3K1wOW87-06YG4sQ9wUAg@mail.gmail.com>
 <531138bc-d343-1081-d208-ab6c98c1ddd8@gmx.net>
In-Reply-To: <531138bc-d343-1081-d208-ab6c98c1ddd8@gmx.net>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 19 Dec 2020 14:58:37 +0100
Message-ID: <CAFBinCBoWGV02hF=0DK_geLpArDtm-qbAKCrXQitpb33UU_zYA@mail.gmail.com>
Subject: Re: [BUG]odroid-c2 does not hotplug usb-devices
Content-Type: text/plain; charset="UTF-8"
To: Otto Meier <gf435@gmx.net>, Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Otto,

On Mon, Dec 14, 2020 at 8:34 PM Otto Meier <gf435@gmx.net> wrote:
>
> Hi Martin,
>
> Am 13.12.20 um 19:46 schrieb Martin Blumenstingl:
> > Hi Otto,
> >
> > On Mon, Dec 7, 2020 at 1:43 PM Otto Meier <gf435@gmx.net> wrote:
> > [...]
> >>>> So with the latest u-boot and the kernel from https://github.com/chewitt/linux/tree/amlogic-5.10.y
> >>>> commit 725fc8df7898102f9031ba2075f763884ffa3ee8 everything is working again.
> >>>> USB does hotplugging as expected.
> >>> So, this fixes USB under Linux ?? It's not clear
> > if you have time it would be great if you could figure out which of
> > the patches from Christian's tree fixes USB hotplugging for you.
> > Or is it fixed in Linux 5.10-rcX even without any patches?
> >
> The new mainline kernel 5.10.0 from Linus, without any other patches
> does detect USB hotpluging,
> when using u-boot DMI: Hardkernel Co., Ltd. ODROID-C2/ODROID-C2, BIOS
> 2021.01-rc3-00039-gec79f5ce22-dirty 12/08/2020
> and the following u-boot patch:
[...]
> When i use the last unpatched emmc bootable u-boot 2020.04 the kernel
> boots, but usb hotplugging
> does not work.
Thank you for testing this!

> Hope this describes my findings. If i can help further, please give me a
> note.
to be honest: I am a bit lost here. I don't understand how the BOOT_*
pins interfere with USB.
I also don't have any Odroid-C2 board myself so I cannot do any
experiments myself.
Neil, please let me know if you have any idea here.


Best regards,
Martin
