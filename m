Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
 by mx.groups.io with SMTP id smtpd.web12.15366.1583344301343776683
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Mar 2020 09:51:41 -0800
Received: by mail-ot1-f65.google.com with SMTP id v10so2910765otp.2
        for <u-boot-amlogic@groups.io>; Wed, 04 Mar 2020 09:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8i709DndMBd68IfUpsN4enqLrE1gkTFmfnEImQruMs=;
        b=ZI9dBfL9/HEyfd2pMyPZEj0YDtU9ns5TPJPkKFiZREV3pMO2TinLzi4TgB470BLzFH
         A0q6SqdSF7JcI2PM/JyTKGiO8BXVWKDuw+Q8inuC+hTJdVbWY0G4oPjPYT5GTxCrUHt2
         WTlpiUpb1jISy6qcWHfgCNq8R5717J6beM+qY=
MIME-Version: 1.0
References: <20200304005951.8225-1-kever.yang@rock-chips.com>
 <20200304005951.8225-4-kever.yang@rock-chips.com> <9abd44be-18ce-9c8e-3310-6c45cfa93638@denx.de>
In-Reply-To: <9abd44be-18ce-9c8e-3310-6c45cfa93638@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Mar 2020 10:51:29 -0700
Message-ID: <CAPnjgZ1u3vbErKSQ12fUhDW_CB-cAdMjEOD_ZXCVfUAcB2WwnQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] usb: Migrate to support live DT for some driver
Content-Type: text/plain; charset="UTF-8"
To: Marek Vasut <marex@denx.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, U-Boot Mailing List <u-boot@lists.denx.de>, Frank Wang <frank.wang@rock-chips.com>, Adam Ford <aford173@gmail.com>, Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Fabio Estevam <festevam@gmail.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Lukasz Majewski <lukma@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, Vignesh Raghavendra <vigneshr@ti.com>, Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Wed, 4 Mar 2020 at 05:32, Marek Vasut <marex@denx.de> wrote:
>
> On 3/4/20 1:59 AM, Kever Yang wrote:
> > Use ofnode_ instead of fdt_ APIs so that the drivers can support live DT.
> > This patch updates usb_get_dr_mode() and usb_get_maximum_speed() to use
> > ofnode as parameter instead of fdt offset. And all the drivers who use
> > these APIs update to use live dt APIs at the same time.
> >
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>
> I'll wait for RB from Simon on 2/3 and 3/3 , however they look good to me.

Reviewed-by: Simon Glass <sjg@chromium.org>

(no need to wait though!)
