Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web09.27371.1578861010780696690
 for <u-boot-amlogic@groups.io>;
 Sun, 12 Jan 2020 12:30:11 -0800
Date: Sun, 12 Jan 2020 21:29:57 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 29/33] dm: core: Require users of devres to include the header
Message-ID: <20200112212957.44f7e1f0@crub>
In-Reply-To: <20200112120216.29.I451105ed1149334d1ef6eca303eede6e56b833d1@changeid>
References: <20200112190624.79077-1-sjg@chromium.org>
	<20200112120216.29.I451105ed1149334d1ef6eca303eede6e56b833d1@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Adam Ford <aford173@gmail.com>, Alexander Graf <agraf@csgraf.de>, Andre Przywara <andre.przywara@arm.com>, Andreas Dannenberg <dannenberg@ti.com>, "Andrew F. Davis" <afd@ti.com>, Andy Yan <andy.yan@rock-chips.com>, Anup Patel <Anup.Patel@wdc.com>, Atish Patra <atish.patra@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Boris Brezillon <bbrezillon@kernel.org>, Carlo Caione <ccaione@baylibre.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, "Derald D. Woods" <woods.technical@gmail.com>, Eddie James <eajames@linux.ibm.com>, Eugen Hristev <eugen.hristev@microchip.com>, Eugeniu Rosca <erosca@de.adit-jv.com>, Fabien Dessenne <fabien.dessenne@st.com>, Fabio Estevam <festevam@gmail.com>, Faiz Abbas <faiz_abbas@ti.com>, Frank Wunderlich <frank-w@public-files.de>, Fugang Duan <fugang.duan@nxp.com>, GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Heiko Schocher <hs@denx.de>, Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Horatiu Vultur <horatiu.vultur@microchip.com>, Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Jens Wiklander <jens.wiklander@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>, Joel Stanley <joel@jms.id.au>, Keerthy <j-keerthy@ti.com>, Kever Yang <kever.yang@rock-chips.com>, Kyungmin Park <kmpark@infradead.org>, Lars Povlsen <lars.povlsen@microchip.com>, Levin Du <djw@t-chip.com.cn>, Lokesh Vutla <lokeshvutla@ti.com>, Lukas Auer <lukas.auer@aisec.fraunhofer.de>, Lukasz Majewski <lukma@denx.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marek.vasut@gmail.com>, Marek Vasut <marex@denx.de>, Maxime Ripard <maxime.ripard@bootlin.com>, Michal Simek <michal.simek@xilinx.com>, Michal Suchanek <msuchanek@suse.de>, Miquel Raynal <miquel.raynal@bootlin.com>, "NXP i.MX U-Boot Team  <uboot-imx@nxp.com>, Neil Armstrong <narmstrong@baylibre.com>, Nishanth Menon" <nm@ti.com>, Patrice Chotard <patrice.chotard@st.com>, Patrick Delaunay <patrick.delaunay@st.com>, Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Philippe Reynes <philippe.reynes@softathome.com>, Priyanka Jain <priyanka.jain@nxp.com>, Quentin Schulz <quentin.schulz@bootlin.com>, Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>, Roger Quadros <rogerq@ti.com>, Ryder Lee <ryder.lee@mediatek.com>, Sagar Shrikant Kadam <sagar.kadam@sifive.com>, Sekhar Nori <nsekhar@ti.com>, Sergey Kubushyn <ksi@koi8.net>, Sherry Sun <sherry.sun@nxp.com>, Shyam Saini <shyam.saini@amarulasolutions.com>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Stefan Agner <stefan.agner@toradex.com>, Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>, Suman Anna <s-anna@ti.com>, T Karthik Reddy <t.karthik.reddy@xilinx.com>, Trent Piepho <tpiepho@impinj.com>, Vignesh R <vigneshr@ti.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Weijie Gao <weijie.gao@mediatek.com>, William Zhang <william.zhang@broadcom.com>, Ye Li <ye.li@nxp.com>, titron <tiezhuang.dong.yh@renesas.com>, u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com, =?UTF-8?B?6buY6buY?= <wangqiang1588@sina.com>
List-ID: <u-boot-amlogic@groups.io>

On Sun, 12 Jan 2020 12:06:20 -0700
Simon Glass sjg@chromium.org wrote:

> At present devres.h is included in all files that include dm.h but few
> make use of it. Also this pulls in linux/compat which adds several more
> headers. Drop the automatic inclusion and require files to include devres
> themselves. This provides a good indication of which files use devres.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Anatolij Gustschin <agust@denx.de>

--
Anatolij
