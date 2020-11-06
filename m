Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web11.9628.1604655306048994680
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 01:35:06 -0800
Received: by mail-wm1-f66.google.com with SMTP id p19so550305wmg.0
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 01:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8moSjL4KmjUBpCmS/TVC1VV7WRyv1avLQ/pqDxu43Ao=;
        b=cS52GcsHiqoLRgqphwING9kiiqUHOUufXT4ykJID1MUOBw6JG6S4UM5+jxpfXb+uTK
         s1MN4S0h2HEiUmTNDngX70WPzrzSVWslweixC2IWHNXTGzGT/cTskFUN+dawmNTm7kB2
         16YBvzEKoDeo3CVIBIkI+X50DtSu+z5doM0BkB3EbsUR9x4xbptbWZnHsAA2KALNwobn
         CM2Nn2+ZlQJHMc5h7nIRFd/18phv4sgWJV92rrdpX3fGcH257MW//JkvoLRVOG4GKWLU
         XbXuLA6mA3PNJ2vKzkYy7XGZqIHqYSgwrNpZEOkdSf3JLy+mQh2Vs6Z5V7mAAwbYZt5z
         wogg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] Fix the potential warning without DM_REGULATOR
References: <CGME20201106055729epcas1p23448d11a25acd6168d3a514a2c17e6ce@epcas1p2.samsung.com>
 <20201106055748.20042-1-jh80.chung@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <17891017-9ee8-3fbe-f875-a3fd694b7007@baylibre.com>
Date: Fri, 6 Nov 2020 10:32:44 +0100
MIME-Version: 1.0
In-Reply-To: <20201106055748.20042-1-jh80.chung@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: agust@denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 06/11/2020 06:57, Jaehoon Chung wrote:
> When CONFIG_DM_REGULATOR is disabled, there are some warnings.
> This patch-set is fixed them.
> 
> drivers/phy/meson-g12a-usb2.c: In function 'phy_meson_g12a_usb2_power_on':
> drivers/phy/meson-g12a-usb2.c:70:35: warning: unused variable 'priv' [-Wunused-variable]
>    70 |  struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
>       |                                   ^~~~
> drivers/phy/meson-g12a-usb2.c: In function 'phy_meson_g12a_usb2_power_off':
> drivers/phy/meson-g12a-usb2.c:86:35: warning: unused variable 'priv' [-Wunused-variable]
>    86 |  struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
>       |                                   ^~~~
>   LD      drivers/phy/built-in.o
>   CC      drivers/video/simple_panel.o
>   CC      drivers/video/meson/meson_dw_hdmi.o
> drivers/video/meson/meson_dw_hdmi.c: In function 'meson_dw_hdmi_probe':
> drivers/video/meson/meson_dw_hdmi.c:382:18: warning: unused variable 'supply' [-Wunused-variable]
>   382 |  struct udevice *supply;
>       |                  ^~~~~~
> 
> Jaehoon Chung (2):
>   phy: meson-g12a-usb2: fix the potential build warning
>   video: meson: meson_dw_hdmi: fix the potential build warning
> 
>  drivers/phy/meson-g12a-usb2.c       | 4 ++--
>  drivers/video/meson/meson_dw_hdmi.c | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

Thanks,

Applied to u-boot-amlogic

Neil
