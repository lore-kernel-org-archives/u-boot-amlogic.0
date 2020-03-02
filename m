Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by mx.groups.io with SMTP id smtpd.web12.1357.1583179644355824752
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Mar 2020 12:07:24 -0800
Date: Mon, 2 Mar 2020 21:07:20 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] Revert "dm: core: device: switch off power domain after device removal"
Message-ID: <20200302210720.64bdca31@crub>
In-Reply-To: <4ca30460-15e5-1d9e-9a52-0044e308a590@baylibre.com>
References: <20200217091036.19028-1-narmstrong@baylibre.com>
	<20200217125336.39990b93@crub>
	<4ca30460-15e5-1d9e-9a52-0044e308a590@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: sjg@chromium.org, trini@konsulko.com, oliver.graute@gmail.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, lokeshvutla@ti.com, sbabic@denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Mon, 2 Mar 2020 10:30:31 +0100
Neil Armstrong narmstrong@baylibre.com wrote:

> Hi Analolij,
> 
> On 17/02/2020 12:53, Anatolij Gustschin wrote:
> > On Mon, 17 Feb 2020 10:10:36 +0100
> > Neil Armstrong narmstrong@baylibre.com wrote:
> >   
> >> This commit breaks Linux boot on Amlogic libretech-cc, libretech-ac, sei510,
> >> sei610 board by automatically disabling the power domain after device removal.
> >> This because the power domain associated to the video driver must be kept
> >> enabled for linux to boot.
> >>
> >> The only way is to use the introduced flag DM_FLAG_DEFAULT_PD_CTRL_OFF, which
> >> removes automatic handling of power domain.
> >> This flag is not a complete solution since it will force reverting to manually
> >> enable the power domain from the driver probe.
> >>
> >> Instead a flag to keep the power domain enabled after removal should be
> >> introduced.
> >>
> >> In the meantime revert this commit until a proper solution is found.
> >>
> >> This reverts commit 52edfed65de967a86983a55c51ba0727090efc43.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >> Hi Simon, Tom,
> >>
> >> This revert is the simplest fix to make the boards boot again on v2020.04,
> >> the goal is to make this behavior happen again with a proper flag to keep the
> >> power domain enabled on specific drivers.
> >>
> >> I can push it on my next PR on my branch, is it ok ?  
> > 
> > Please test if these two patches fix the problem:
> >  http://patchwork.ozlabs.org/patch/1239143
> >  http://patchwork.ozlabs.org/patch/1239144  
> 
> Should I apply these through my tree or you plan to push these yourself ?

These patches are assigned to Simon in patchwork, and are in his tree
under build-testing I think.

--
Anatolij
