Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
 by mx.groups.io with SMTP id smtpd.web12.7036.1605285481777166700
 for <u-boot-amlogic@groups.io>;
 Fri, 13 Nov 2020 08:38:01 -0800
Received: by mail-vs1-f42.google.com with SMTP id x11so5492712vsx.12
        for <u-boot-amlogic@groups.io>; Fri, 13 Nov 2020 08:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2QshnfrVX6usAIQ2uFmKu7+HlJxqmYruIxXH3gXYCQ=;
        b=bkv8s6BNx//wAHUYuEXSS2zF/g3lYbTuXsk1e4luveq/VNgxqEiSFHehh04RtsKJYV
         9ibTyuFhLuR8ZpzgvfMTt094wHfuwE2kn/h6hNO26sKITOt5YTx9kZ9sMbK0snpN/kdx
         AWTNp+kA8JUWL3eVDTmC/rx/SteCgDrMl01b0ho/Bp7jMaKTUYTwQqnXHsYSrJRkuLhs
         HuYwN/vGSkSnq9TKYQIuuLrq/X/ZixnE4aMolyygPoHB8NUPxwrwKFj8o/R+ZXkOkkv4
         5mjunszCvB6ZaFke8tIvQqqvf9n6Ijf/J1CAea4fB07FvnqON1uBLGxSKJYbTL1KV6k0
         YOAw==
MIME-Version: 1.0
References: <CAMeizLdpoevi6Fj-X=abWe2QKuvdrJ4gkS_=2yzpBmrnO-RDaQ@mail.gmail.com>
 <f1afd339-241d-1708-8a07-9daa008cdfd5@baylibre.com> <CAMeizLcQGkmsZ3MOb8uHGKGxFYfWpEK6Y1YF7OPWLJzs765KRQ@mail.gmail.com>
 <1jblgpj8zd.fsf@starbuckisacylon.baylibre.com> <CAMeizLc163WqCM-MVGFSSZnrZ_6mwVTrtje4Vp86d8z4gDw-SQ@mail.gmail.com>
 <032e222c-1f46-0efc-d92b-ee848fc2c12e@baylibre.com>
In-Reply-To: <032e222c-1f46-0efc-d92b-ee848fc2c12e@baylibre.com>
From: Anton Arapov <arapov@gmail.com>
Date: Fri, 13 Nov 2020 17:37:44 +0100
Message-ID: <CAMeizLdD8MZLpPhmhCx-q5CDAVOFA4ig=s3imZCdYVs=+eBSeQ@mail.gmail.com>
Subject: Re: meson-gxbb regression since u-boot v2020.04
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Tue, Oct 27, 2020 at 2:45 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 26/10/2020 18:56, Anton Arapov wrote:
> > On Mon, Oct 26, 2020 at 4:35 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> >> On Mon 26 Oct 2020 at 15:59, Anton Arapov <arapov@gmail.com> wrote:
[snip]
> >>> On Mon, Oct 26, 2020 at 3:50 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[snip]
> >>>> On 26/10/2020 15:36, Anton Arapov wrote:
> > [snip]
> >>>>> Could you suggest what could be done in order to fix the issue? Where
> >>>>> should I look?
> >>
> >> Now if just removing the "bias-pull-up" is making it "go" for you, it
> >> would be interresting to know what actually happened, what did you
> >> inherit from the ROM code?
> >>
> >> IOW, could you compare the registers linked to the pin bias a let us
> >> know what changed with and without ?
> >
> > Jerome, I am new to u-boot story. Your request made me look into pdf
> > and registers and this is what I found:
> >
> > I built two u-boot builds with odroid-c2_defconf, (1) with the patch,
> > (2) - a commit before the patch
> > (1) dd5f2351e9 arm64: dts: meson: sync dt and bindings from v5.6-rc2
> > (2) b3d69aa596 clk: meson: reset mmc clock on probe
> >
> > I found the registers and offsets at page 87 of
> > S905_Public_Datasheet_V1.1.4.pdf mentioned earlier.
> >
> > u-boot build (1) with the patch, can NOT boot from eMMC:
> > => md.b 0xc8834528 # PU/PD-EN
> > c8834528: 01 7a 0f fc 00 c0 00 f0 ff ff 7f 00 00 00 00 00    .z..............
> > => md.b 0xc88344f0 # PU/PD
> > c88344f0: 01 7b 4f fc ff bf 00 f0 bf ff 6f 00 00 00 00 00    .{O.......o.....
>
>
> Indeed, this makes Pull-Up only on these pins:
> BOOT0
> BOOT9
> BOOT11
> BOOT12
> BOOT13
> BOOT14
>
> and the dtsi instructs to set Pull-Up on:
> BOOT0 to BOOT7
> BOOT10
>
> so there is a bug on the pinctrl u-boot driver here...
>
> Can you trace the drivers/pinctrl/meson/pinctrl-meson.c and drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c ?

Neil, I've just recovered from "probably covid" .... Could you give me
a hint as to what you mean by trace here?
Point me to the document perhaps?

I've added additional printouts to the relevant)hopefully) code and
see that it tries to set pull-up on BOOT 0...7 and 10.

pinconfig emmc: set_state_simple op missing
clk_set_defaults(emmc)
clk_set_default_parents: could not read assigned-clock-parents for
000000007bf45c20
ofnode_read_prop: assigned-clock-rates: <not found>
pinctrl_generic_set_state_subnode(pinctrl@4b0, emmc): count=0
pinctrl_generic_set_state_subnode(pinctrl@4b0, mux-0): count=2
        >> pinctrl-meson.c: meson_pinconf_group_set() periphs-banks
                >> pinctrl-meson.c: meson_pinconf_bias_set() :
0xc88344f0 : (1) PIN_CONFIG_BIAS_PULL_UP
                >> pinctrl-meson.c: meson_pinconf_bias_set() :
0xc88344f1 : (1) PIN_CONFIG_BIAS_PULL_UP
                >> pinctrl-meson.c: meson_pinconf_bias_set() :
0xc88344f2 : (1) PIN_CONFIG_BIAS_PULL_UP
                >> pinctrl-meson.c: meson_pinconf_bias_set() :
0xc88344f3 : (1) PIN_CONFIG_BIAS_PULL_UP
                >> pinctrl-meson.c: meson_pinconf_bias_set() :
0xc88344f4 : (1) PIN_CONFIG_BIAS_PULL_UP
                >> pinctrl-meson.c: meson_pinconf_bias_set() :
0xc88344f5 : (1) PIN_CONFIG_BIAS_PULL_UP
                >> pinctrl-meson.c: meson_pinconf_bias_set() :
0xc88344f6 : (1) PIN_CONFIG_BIAS_PULL_UP
                >> pinctrl-meson.c: meson_pinconf_bias_set() :
0xc88344f7 : (1) PIN_CONFIG_BIAS_PULL_UP
        >> pinctrl-meson.c: meson_pinconf_group_set() periphs-banks
                >> pinctrl-meson.c: meson_pinconf_bias_set() :
0xc88344fa : (1) PIN_CONFIG_BIAS_PULL_UP
pinctrl_generic_set_state_subnode(pinctrl@4b0, mux-1): count=1
        >> pinctrl-meson.c: meson_pinconf_group_set() periphs-banks
                >> pinctrl-meson.c: meson_pinconf_bias_set() :
0xc8834530 : (0) PIN_CONFIG_BIAS_DISABLE

wdyt?

> We fixed the AXG and G12 ones, but maybe a bug subsists on the GX side.
> But it's weird it doesn't appear on GXL.
>
> Neil
[snip]
