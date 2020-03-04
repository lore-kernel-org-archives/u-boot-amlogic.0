Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web12.10469.1583325172922812300
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Mar 2020 04:32:53 -0800
Subject: Re: [PATCH v3 3/3] usb: Migrate to support live DT for some driver
References: <20200304005951.8225-1-kever.yang@rock-chips.com>
 <20200304005951.8225-4-kever.yang@rock-chips.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <9abd44be-18ce-9c8e-3310-6c45cfa93638@denx.de>
Date: Wed, 4 Mar 2020 13:24:50 +0100
MIME-Version: 1.0
In-Reply-To: <20200304005951.8225-4-kever.yang@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: frank.wang@rock-chips.com, Adam Ford <aford173@gmail.com>, Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Fabio Estevam <festevam@gmail.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Lukasz Majewski <lukma@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, Simon Glass <sjg@chromium.org>, Vignesh Raghavendra <vigneshr@ti.com>, Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 3/4/20 1:59 AM, Kever Yang wrote:
> Use ofnode_ instead of fdt_ APIs so that the drivers can support live DT.
> This patch updates usb_get_dr_mode() and usb_get_maximum_speed() to use
> ofnode as parameter instead of fdt offset. And all the drivers who use
> these APIs update to use live dt APIs at the same time.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

I'll wait for RB from Simon on 2/3 and 3/3 , however they look good to me.
