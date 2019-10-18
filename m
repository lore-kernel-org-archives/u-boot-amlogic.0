Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.236.1571410445735221045
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Oct 2019 07:54:06 -0700
Received: by mail-wr1-f67.google.com with SMTP id o15so6166897wru.5
        for <u-boot-amlogic@groups.io>; Fri, 18 Oct 2019 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=j6JPdxPD5s3z8p6N1t22mdWnd17QOC+0DUmqJiy+76E=;
        b=n6f7YotZjJLeHwsKfyOF3UdkfO7xo/1FZkrZyutf2WwnB0XUZAG0gcApbm6BdTcY/h
         ANABAQ+YcwQRUWZ09XDsB8Ux/OOkEUdnE/lgRR4uMCc3Lx8n+hyoKjmnpmifaGrv0n4z
         Qb6H5vjclz6bmn3kI5AGct8CGhhR56x73MFOsbd/Ft+XufmyAkN8oCpNqVtL2f6GG5XA
         RRvVjdTmN3MA9XLTr5CiNiReiga98PqCDpRtnu4zSgOM+q0tpfxPhUJaXJ3V9TJ1+eHg
         J5CtHobPdsvB0h6Ctp/1bsPtENiDA1oUt10Y3X0xNNpR43oc0yaYamLsYiU4tXt+1qTm
         WJcQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: Enable USB host controller on Odroid-C2
From: "Neil Armstrong" <narmstrong@baylibre.com>
References: <20190818134255.7135-1-b.galvani@gmail.com>
 <9510b9a4-64c0-c275-4038-cb56fcf373f5@baylibre.com>
Message-ID: <37c3d6cf-eea3-2c2a-519e-f6fa8e5f17d5@baylibre.com>
Date: Fri, 18 Oct 2019 16:54:02 +0200
MIME-Version: 1.0
In-Reply-To: <9510b9a4-64c0-c275-4038-cb56fcf373f5@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Beniamino Galvani <b.galvani@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@ti.com>, Albert Aribaud <albert.u.boot@aribaud.net>, Maxime Jourdan <mjourdan@baylibre.com>, Patrick Delaunay <patrick.delaunay@st.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 28/08/2019 10:22, Neil Armstrong wrote:
> On 18/08/2019 15:42, Beniamino Galvani wrote:
>> Hi,
>>
>> these two patches enable the USB host controller on Odroid-C2. The
>> first patch adds a PHY driver; the second one enables the necessary
>> configuration options and updates the device tree.
>>
>> Note that the DWC2 driver currently does not support enabling PHYs
>> from the device tree and so the following series (still on review) is
>> needed as runtime requirement for the second patch:
>>
>>  [PATCH 0/5] usb: host: dwc2: use driver model for PHY and CLOCK
> 
> 
> Pushed to my u-boot-amlogic-next test tree until this dependency is applied.

The resend version had some comments, could you resent when Patrick sends an
updated version ?

Neil

> 
> Thanks,
> Neil
> 
>>
>> Thanks,
>> Beniamino
>>
>> Beniamino Galvani (2):
>>   phy: meson: add GXBB PHY driver
>>   odroid-c2: enable USB host controller
>>
>>  arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi |   8 +
>>  configs/odroid-c2_defconfig                  |   7 +
>>  drivers/phy/Kconfig                          |   8 +
>>  drivers/phy/Makefile                         |   1 +
>>  drivers/phy/meson-gxbb-usb2.c                | 235 +++++++++++++++++++
>>  include/configs/meson64.h                    |   5 +
>>  6 files changed, 264 insertions(+)
>>  create mode 100644 drivers/phy/meson-gxbb-usb2.c
>>
> 

