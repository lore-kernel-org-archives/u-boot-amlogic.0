Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web10.26874.1578859529858943973
 for <u-boot-amlogic@groups.io>;
 Sun, 12 Jan 2020 12:05:30 -0800
Date: Sun, 12 Jan 2020 21:05:25 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 05/33] power-domain: Rename free() to rfree()
Message-ID: <20200112210525.03e3aab4@crub>
In-Reply-To: <20200112120216.5.I6fda8248defd1b62c3653e578da37986cf89cc0d@changeid>
References: <20200112190624.79077-1-sjg@chromium.org>
	<20200112120216.5.I6fda8248defd1b62c3653e578da37986cf89cc0d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Jaehoon Chung <jh80.chung@samsung.com>, Lokesh Vutla <lokeshvutla@ti.com>, Neil Armstrong <narmstrong@baylibre.com>, Nishanth Menon <nm@ti.com>, Patrick Wildt <patrick@blueri.se>, Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Sun, 12 Jan 2020 12:05:56 -0700
Simon Glass sjg@chromium.org wrote:

> This function name conflicts with our desire to #define free() to
> something else on sandbox. Since it deals with resources, rename it to
> rfree().
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Anatolij Gustschin <agust@denx.de>

--
Anatolij
