Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.5910.1587327444080808297
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Apr 2020 13:17:24 -0700
Received: by mail-wr1-f66.google.com with SMTP id k13so8388839wrw.7
        for <u-boot-amlogic@groups.io>; Sun, 19 Apr 2020 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Aq8AHyWFCyB7nqwqdNyw+bGtm238MlCq/o8WWRuelTw=;
        b=jxNmMTodNITD4zZHR+p9THlqixzbyMnoF7C6p8Mqc9Z6wq8tCd8kKqRHKJEXPZcqZ+
         3xjoh5xUy5iTg09uQclhI17fApLTTQZStagph3GZ/qYe0jhkHKFACgG1/zCbKQ7WYdJH
         jGpodetI/LspEvzQCcCXH0D61ccNjc3VQrtmSGIkCZuEN3WWja1fsSk9IZvjqjmlA2cT
         QgQ2O8FiyZXURa4OVOpvrIDfgAzNM842oR6GjyVjaB7qZfwIJyz4Mp2A8FR4Jg1llRUJ
         FObs1f+lHkzae+lM0dp/iFv10gD/2Gv/Bl0jIB116vA5/ceSI5lY2WsVgkkpl5Lmkh9w
         gfTQ==
Return-Path: <b.galvani@gmail.com>
Date: Sun, 19 Apr 2020 22:16:58 +0200
From: Beniamino Galvani <b.galvani@gmail.com>
Subject: Re: Enable USB host controller on Odroid-C2
Message-ID: <20200419201658.GA1973@gmail.com>
References: <20190818134255.7135-1-b.galvani@gmail.com>
 <f09bd116-97de-81da-50cc-4afa2c1381e8@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <f09bd116-97de-81da-50cc-4afa2c1381e8@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@ti.com>, Albert Aribaud <albert.u.boot@aribaud.net>, Maxime Jourdan <mjourdan@baylibre.com>, Patrick Delaunay <patrick.delaunay@st.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Fri, Mar 27, 2020 at 02:35:50PM +0100, Neil Armstrong wrote:
> Hi,
> 
> On 18/08/2019 15:42, Beniamino Galvani wrote:
> > Hi,
> > 
> > these two patches enable the USB host controller on Odroid-C2. The
> > first patch adds a PHY driver; the second one enables the necessary
> > configuration options and updates the device tree.
> > 
> > Note that the DWC2 driver currently does not support enabling PHYs
> > from the device tree and so the following series (still on review) is
> > needed as runtime requirement for the second patch:
> > 
> >  [PATCH 0/5] usb: host: dwc2: use driver model for PHY and CLOCK
> > 
> > Thanks,
> > Beniamino
> > 
> > Beniamino Galvani (2):
> >   phy: meson: add GXBB PHY driver
> >   odroid-c2: enable USB host controller
> > 
> >  arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi |   8 +
> >  configs/odroid-c2_defconfig                  |   7 +
> >  drivers/phy/Kconfig                          |   8 +
> >  drivers/phy/Makefile                         |   1 +
> >  drivers/phy/meson-gxbb-usb2.c                | 235 +++++++++++++++++++
> >  include/configs/meson64.h                    |   5 +
> >  6 files changed, 264 insertions(+)
> >  create mode 100644 drivers/phy/meson-gxbb-usb2.c
> > 
> 
> Could you re-test with v6 of DWC2 patchset at http://patchwork.ozlabs.org/project/uboot/list/?series=163388 ?

Hi,

I tested my two patches on top of Patrick's v6 and they still work as
expected.

Thanks,
Beniamino
