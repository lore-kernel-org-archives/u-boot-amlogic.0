Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 by mx.groups.io with SMTP id smtpd.web12.9793.1608218389088343759
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Dec 2020 07:19:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1608218326;
	bh=+KaE5ljUF4pzR5XgRaFVD3J3cXX0VMf8fD9DITKuly4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=cnfDSLboiFqaNnyroDTDkdeqbGn7UIqyig2uo7+OFni7p2kgyN2rlVL/6xmrYUbA6
	 HdJyDeTDo3spl2SoskATAVPSMWmolBLWIrcYJ3dz47Uzvk1payJIhEmmAvcE8hyMpr
	 Qbi52ZIHDPYd9PhVX9UU9xRK790pXM4hy0sh8dq8=
Date: Thu, 17 Dec 2020 20:48:44 +0530
From: Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 16/18] dm: Use access methods for dev/uclass private data
Message-ID: <20201217151547.67fwvdsqb2vj2qol@ti.com>
References: <20201216152506.119900-1-sjg@chromium.org>
 <20201216082429.16.I5196895f8bbae1068965f8e3b6db19b2bb56e908@changeid>
MIME-Version: 1.0
In-Reply-To: <20201216082429.16.I5196895f8bbae1068965f8e3b6db19b2bb56e908@changeid>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Alexander Graf <agraf@csgraf.de>, Anatolij Gustschin <agust@denx.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Angelo Durgehello <angelo.dureghello@timesys.com>, Anji J <anji.jagarlmudi@nxp.com>, Bin Meng <bmeng.cn@gmail.com>, Chaitanya Sakinam <chaitanya.sakinam@nxp.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Giulio Benetti <giulio.benetti@benettiengineering.com>, Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Icenowy Zheng <icenowy@aosc.io>, Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Joe Hershberger <joe.hershberger@ni.com>, Kever Yang <kever.yang@rock-chips.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, Lokesh Vutla <lokeshvutla@ti.com>, Lukasz Majewski <lukma@denx.de>, Madalin Bucur <madalin.bucur@oss.nxp.com>, Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>, Martin Fuzzey <martin.fuzzey@flowbird.group>, Masahiro Yamada <masahiroy@kernel.org>, Michael Walle <michael@walle.cc>, Michal Simek <monstr@monstr.eu>, Neil Armstrong <narmstrong@baylibre.com>, "Park, Aiden" <aiden.park@intel.com>, Patrice Chotard <patrice.chotard@st.com>, Patrick Delaunay <patrick.delaunay@st.com>, Patrik =?iso-8859-1?Q?Dahlstr=F6m?= <risca@dalakolonin.se>, Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Pragnesh Patel <Pragnesh.patel@sifive.com>, Priyanka Jain <priyanka.jain@nxp.com>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Rick Chen <rick@andestech.com>, Robert Beckett <bob.beckett@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, Sagar Shrikant Kadam <sagar.kadam@sifive.com>, Sean Anderson <seanga2@gmail.com>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Stefan Roese <sr@denx.de>, Suneel Garapati <sgarapati@marvell.com>, Thor Thayer <thor.thayer@linux.intel.com>, Tien Fong Chee <tien.fong.chee@intel.com>, Walter Lozano <walter.lozano@collabora.com>, Weijie Gao <weijie.gao@mediatek.com>, Wolfgang Wallner <wolfgang.wallner@br-automation.com>, Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
List-ID: <u-boot-amlogic@groups.io>

[Dropping Jean-Jacques Hiblot because his email will bounce anyway.]

Hi Simon,

On 16/12/20 08:25AM, Simon Glass wrote:
> Most drivers use these access methods but a few do not. Update them.
> 
> In some cases the access is not permitted, so mark those with a FIXME tag
> for the maintainer to check.

Your series does not apply cleanly on the tip of u-boot master 
(a439136599 as of writing this). Is this dependent on some other series 
or branch?

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
[...] 
> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
> index b9868505a3b..00e0282dcc0 100644
> --- a/drivers/mux/mmio.c
> +++ b/drivers/mux/mmio.c
> @@ -12,6 +12,7 @@
>  #include <regmap.h>
>  #include <syscon.h>
>  #include <dm/device.h>
> +#include <dm/device-internal.h>
>  #include <dm/device_compat.h>
>  #include <dm/read.h>
>  #include <dm/devres.h>
> @@ -68,7 +69,7 @@ static int mmio_mux_probe(struct udevice *dev)
>  	fields = devm_kmalloc(dev, num_fields * sizeof(*fields), __GFP_ZERO);
>  	if (!fields)
>  		return -ENOMEM;
> -	dev->priv = fields;
> +	dev_set_priv(dev, fields);

Ok.

>  
>  	mux_reg_masks = devm_kmalloc(dev, num_fields * 2 * sizeof(u32),
>  				     __GFP_ZERO);
[...]
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index b746501f5ff..67980431ba0 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -27,7 +27,7 @@
>  
>  static int cadence_spi_write_speed(struct udevice *bus, uint hz)
>  {
> -	struct cadence_spi_plat *plat = bus->plat;
> +	struct cadence_spi_plat *plat = dev_get_plat(bus);

I am confused. Grepping on the current tip of master (a439136599), I see 
no hits for dev_get_plat(). Your series does not introduce it either. 
Patch 18/18 changes it but I don't see it being added anywhere. What am 
I missing?

>  	struct cadence_spi_priv *priv = dev_get_priv(bus);
>  
>  	cadence_qspi_apb_config_baudrate_div(priv->regbase,
> @@ -130,7 +130,7 @@ static int spi_calibration(struct udevice *bus, uint hz)
>  
>  static int cadence_spi_set_speed(struct udevice *bus, uint hz)
>  {
> -	struct cadence_spi_plat *plat = bus->plat;
> +	struct cadence_spi_plat *plat = dev_get_plat(bus);
>  	struct cadence_spi_priv *priv = dev_get_priv(bus);
>  	int err;
>  
> @@ -165,7 +165,7 @@ static int cadence_spi_set_speed(struct udevice *bus, uint hz)
>  
>  static int cadence_spi_probe(struct udevice *bus)
>  {
> -	struct cadence_spi_plat *plat = bus->plat;
> +	struct cadence_spi_plat *plat = dev_get_plat(bus);
>  	struct cadence_spi_priv *priv = dev_get_priv(bus);
>  	struct clk clk;
>  	int ret;
> @@ -212,7 +212,7 @@ static int cadence_spi_remove(struct udevice *dev)
>  
>  static int cadence_spi_set_mode(struct udevice *bus, uint mode)
>  {
> -	struct cadence_spi_plat *plat = bus->plat;
> +	struct cadence_spi_plat *plat = dev_get_plat(bus);
>  	struct cadence_spi_priv *priv = dev_get_priv(bus);
>  
>  	/* Disable QSPI */
> @@ -235,7 +235,7 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
>  				   const struct spi_mem_op *op)
>  {
>  	struct udevice *bus = spi->dev->parent;
> -	struct cadence_spi_plat *plat = bus->plat;
> +	struct cadence_spi_plat *plat = dev_get_plat(bus);
>  	struct cadence_spi_priv *priv = dev_get_priv(bus);
>  	void *base = priv->regbase;
>  	int err = 0;
> @@ -284,7 +284,7 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
>  
>  static int cadence_spi_of_to_plat(struct udevice *bus)
>  {
> -	struct cadence_spi_plat *plat = bus->plat;
> +	struct cadence_spi_plat *plat = dev_get_plat(bus);
>  	ofnode subnode;
>  
>  	plat->regbase = (void *)devfdt_get_addr_index(bus, 0);

Anyway, assuming dev_get_plat() looks like:

  void *dev_get_plat(const struct udevice *dev) {
	return dev->plat;
  }

Acked-by: Pratyush Yadav <p.yadav@ti.com>

for drivers/{mux/mmio.c,spi/cadence_qspi.c}.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
