Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web09.22865.1607885200129860771
 for <u-boot-amlogic@groups.io>;
 Sun, 13 Dec 2020 10:46:40 -0800
Received: by mail-ej1-f48.google.com with SMTP id x16so19519669ejj.7
        for <u-boot-amlogic@groups.io>; Sun, 13 Dec 2020 10:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBaDtwXZY4tbMaYeRLsT1+1rhD3o56cmncJfOLsHOAw=;
        b=CfTc3Oru96iMe3dsAT0XCCCJsb4KIlepfdk/mDykyRHFy2X14qZQHRQrqqmEfINJLd
         +NKoCpgyc5Pz2HUt9BxVKcB/2tGlO5c8LLltGaCzf5aWPupous2ODdNp3Fid2if8pme4
         cgp9GtGmVj65Z6PuX22xDOQ7GqEnLNygn6L2ZgrYAlCRi85ufeIpJiHSgace/pFJgabr
         w9g9msgWJyY3K3CsAe6QbqETwbjSLfqDSI3rsjpf9FtS0FWBxbqvP+m45gNguWr97XTL
         B5z6FSkqGU419+KqiWQPiCvwcsBF5UjbNmrjlLCPyC88MNWJLrvA8cjS7Fn+viRS1PCs
         mf0g==
MIME-Version: 1.0
References: <c2dc3507-67a7-3c18-374f-050295bc1d59@gmx.net> <CAFBinCDrMj4GP2cy4dBSt_isGXf4CuhmDz=uAs+gZwUGQc=o6A@mail.gmail.com>
 <8afb2adb-4581-a847-e7e0-db1e915e9247@gmx.net> <CAFBinCD6aqna6YYvXgO5iKWa9N3yvqehhB+SAirLaUu3xScy2Q@mail.gmail.com>
 <bd9d96d2-8b66-db93-a855-5e179adca8c9@gmx.net> <0d05671d-b5f4-55e4-f5bd-58410cc92d08@baylibre.com>
 <dd160e55-55e9-1c41-afcb-22990a05a86b@gmx.net>
In-Reply-To: <dd160e55-55e9-1c41-afcb-22990a05a86b@gmx.net>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 13 Dec 2020 19:46:27 +0100
Message-ID: <CAFBinCDv+TgEgf1g7xBTknr-aJMhC3K1wOW87-06YG4sQ9wUAg@mail.gmail.com>
Subject: Re: [BUG]odroid-c2 does not hotplug usb-devices
Content-Type: text/plain; charset="UTF-8"
To: Otto Meier <gf435@gmx.net>
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-amlogic@lists.infradead.org, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Otto,

On Mon, Dec 7, 2020 at 1:43 PM Otto Meier <gf435@gmx.net> wrote:
[...]
> >> So with the latest u-boot and the kernel from https://github.com/chewitt/linux/tree/amlogic-5.10.y
> >> commit 725fc8df7898102f9031ba2075f763884ffa3ee8 everything is working again.
> >> USB does hotplugging as expected.
> >
> > So, this fixes USB under Linux ?? It's not clear
if you have time it would be great if you could figure out which of
the patches from Christian's tree fixes USB hotplugging for you.
Or is it fixed in Linux 5.10-rcX even without any patches?


Best regards,
Martin
