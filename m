Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com [209.85.217.65])
 by mx.groups.io with SMTP id smtpd.web12.1175.1603735007956314589
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Oct 2020 10:56:48 -0700
Received: by mail-vs1-f65.google.com with SMTP id s15so5307638vsm.0
        for <u-boot-amlogic@groups.io>; Mon, 26 Oct 2020 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78gxbrKtUqayPN8BXohi13ZkI4Y9YG53ecBtIx06rkI=;
        b=MyTwS4RWMDjlJ5VCm9hUVeRMzeJJ2KyyaVyibekyDZZIjSTMAIh4kkmQbFBflQw9LA
         4a8KAO7Ykn9/75UWKCNsBfFFgZdWza3CMkTNJtDbuLxalC9Uy9+wiLDijgmiZNKyzM9C
         Ju+5cBRAeHxF76LFH2oSb0Ihnev9ZiUee0GSvg7lFkh6qFwX4ZCFVIbVGfQWUbIXhHkr
         qFfaiT6QAj54jhWM5xKYox04PwVDr2+XlZ5bmegCas8/5gImeQ94aSRiAPFAldF7DinB
         DVUZ7J98ml1z96yUFwjBNfE12dl8+O85Gbaw9Ez1/fhTFjzJVy0xGjnWGiGZLk04b1EB
         CeOA==
MIME-Version: 1.0
References: <CAMeizLdpoevi6Fj-X=abWe2QKuvdrJ4gkS_=2yzpBmrnO-RDaQ@mail.gmail.com>
 <f1afd339-241d-1708-8a07-9daa008cdfd5@baylibre.com> <CAMeizLcQGkmsZ3MOb8uHGKGxFYfWpEK6Y1YF7OPWLJzs765KRQ@mail.gmail.com>
 <1jblgpj8zd.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jblgpj8zd.fsf@starbuckisacylon.baylibre.com>
From: Anton Arapov <arapov@gmail.com>
Date: Mon, 26 Oct 2020 18:56:35 +0100
Message-ID: <CAMeizLc163WqCM-MVGFSSZnrZ_6mwVTrtje4Vp86d8z4gDw-SQ@mail.gmail.com>
Subject: Re: meson-gxbb regression since u-boot v2020.04
Content-Type: text/plain; charset="UTF-8"
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Mon, Oct 26, 2020 at 4:35 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> On Mon 26 Oct 2020 at 15:59, Anton Arapov <arapov@gmail.com> wrote:
> > Another observation is that u-boot with mentioned patch can't
> > find/initialize ethernet on a brand new Odroid C2, rev0.2 20171114.
> > But after booting without this patch at least once - ethernet is found
> > and working fine. And amazingly it keeps working even after the patch
> > is applied again later.
> That would be amazing indeed

IKR :-)

> > On Mon, Oct 26, 2020 at 3:50 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >> It's weird this fixes the issue, because the BOOT_0 to BOOT_8 have
> >> default Pull-Up by default,
> But it isn't necessarily what you get out of ROM code, which is reason
> for setting up bias in DT initially.
> >> and Linux works fine with this.
> This part is weird ...

> >> S905_Public_Datasheet_V1.1.4.pdf pages 17 & 18
> >> Maybe there is another issue in pinctrl instead ?

I am quite new here,... reading pdf and mapping it to code atm.


> >> On 26/10/2020 15:36, Anton Arapov wrote:
[snip]
> >> > Could you suggest what could be done in order to fix the issue? Where
> >> > should I look?
>
> Now if just removing the "bias-pull-up" is making it "go" for you, it
> would be interresting to know what actually happened, what did you
> inherit from the ROM code?
>
> IOW, could you compare the registers linked to the pin bias a let us
> know what changed with and without ?

Jerome, I am new to u-boot story. Your request made me look into pdf
and registers and this is what I found:

I built two u-boot builds with odroid-c2_defconf, (1) with the patch,
(2) - a commit before the patch
(1) dd5f2351e9 arm64: dts: meson: sync dt and bindings from v5.6-rc2
(2) b3d69aa596 clk: meson: reset mmc clock on probe

I found the registers and offsets at page 87 of
S905_Public_Datasheet_V1.1.4.pdf mentioned earlier.

u-boot build (1) with the patch, can NOT boot from eMMC:
=> md.b 0xc8834528 # PU/PD-EN
c8834528: 01 7a 0f fc 00 c0 00 f0 ff ff 7f 00 00 00 00 00    .z..............
=> md.b 0xc88344f0 # PU/PD
c88344f0: 01 7b 4f fc ff bf 00 f0 bf ff 6f 00 00 00 00 00    .{O.......o.....

u-boot build (2) right prior the patch, can boot from eMMC
=> md.b 0xc8834528 # PU/PD-EN
c8834528: ff ff ff ff ff ff 00 f0 ff ff 7f 00 00 00 00 00    ................
=> md.b 0xc88344f0 # PU/PD
c88344f0: ff ff ff ff ff bf 00 f0 bf ff 6f 00 00 00 00 00    ..........o.....

Just as a matter of experiment I tried to make u-boot build (1) able
to boot from eMMC with:
=> mmc dev 1
Card did not respond to voltage select!
=> mw.b 0xc8834528 ff 1
=> mw.b 0xc88344f0 ff 2
=> mmc dev 1
switch to partitions #0, OK
mmc1(part 0) is current device

IOW, changing 00000001 01111010 and 00000001 01111011 to 1*

To be honest I don't know whether this is useful to you at all, it was
certainly fun for me. :-)

If this is not something you looked for, let me know how I can actually help.

Anton
