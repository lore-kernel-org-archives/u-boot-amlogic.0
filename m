Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.71])
 by mx.groups.io with SMTP id smtpd.web10.9018.1618500842111384007
 for <u-boot-amlogic@groups.io>;
 Thu, 15 Apr 2021 08:34:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5DrT/Iba5eNKxBT0VSZckZxEI8+k0TTiMcTAgpNGik=;
 b=ftDTvxv4I/CnUZVnr9V8GEMuXYeyl3/pHf9CQXnj7NJgTxD7HLdLK5SDEcyc57il2x1omyoOWbZw0nz23dJyjzgNXK8+qr+7hVSAEJKkZb+l2rRWJ+HfDxHHpk2jgKya34Hv20971HSCKpyWwX45v3Gh0EXGwybl+jbdfbja/+s=
From: "Priyanka Jain (OSS)" <priyanka.jain@oss.nxp.com>
Subject: Re: [PATCH 2/2] Rename CONFIG_DM_RESET to CONFIG_RESET
Date: Thu, 15 Apr 2021 15:33:57 +0000
Message-ID: 
 <AM6PR04MB5144193831459E3B67053E91E64D9@AM6PR04MB5144.eurprd04.prod.outlook.com>
References: <20210326031303.833293-1-sjg@chromium.org>
 <20210326031303.833293-2-sjg@chromium.org>
In-Reply-To: <20210326031303.833293-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Adam Ford <aford173@gmail.com>, Akash Gajjar <akash@openedev.com>, Alifer Moraes <alifer.wsdm@gmail.com>, Anatolij Gustschin <agust@denx.de>, Andre Przywara <andre.przywara@arm.com>, "Andrew F. Davis" <afd@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Yan <andy.yan@rock-chips.com>, Anup Patel <anup.patel@wdc.com>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Atish Patra <atish.patra@wdc.com>, Banglang Huang <banglang.huang@foxmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>, Bin Meng <bmeng.cn@gmail.com>, Chee Hong Ang <chee.hong.ang@intel.com>, Chen-Yu Tsai <wens@csie.org>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Chin-Liang See <clsee@altera.com>, Christian Hewitt <christianshewitt@gmail.com>, Dalon Westergreen <dwesterg@gmail.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, David Bauer <mail@david-bauer.net>, Dinh Nguyen <dinguyen@kernel.org>, Dirk Eibach <dirk.eibach@gdsys.cc>, Etienne Carriere <etienne.carriere@linaro.org>, Eugeniy Paltsev <paltsev@synopsys.com>, Fabio Estevam <festevam@gmail.com>, Harald Seiler <hws@denx.de>, Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, Holger Brunck <holger.brunck@hitachi-powergrids.com>, Jack Mitchell <ml@embed.me.uk>, Jagan Teki <jagan@amarulasolutions.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Jernej Skrabec <jernej.skrabec@siol.net>, Joao Marcos Costa <joaomarcos.costa@bootlin.com>, Joe Hershberger <joe.hershberger@ni.com>, Joel Johnson <mrjoel@lixil.net>, Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, Levin Du <djw@t-chip.com.cn>, Ley Foon Tan <ley.foon.tan@intel.com>, Loic Devulder <ldevulder@suse.com>, Lokesh Vutla <lokeshvutla@ti.com>, Lukasz Majewski <lukma@denx.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Marco Franchi <marcofrk@gmail.com>, Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>, Masahiro Yamada <yamada.masahiro@socionext.com>, Matthias Brugger <mbrugger@suse.com>, "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, Maxim Sloyko <maxims@google.com>, Michal Simek <michal.simek@xilinx.com>, Neil Armstrong <narmstrong@baylibre.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Ovidiu Panait <ovidiu.panait@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>, Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Paul Walmsley <paul.walmsley@sifive.com>, Pavel Machek <pavel@denx.de>, Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Philippe Reynes <philippe.reynes@softathome.com>, Pratyush Yadav <p.yadav@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Reuben Dowle <reubendowle0@gmail.com>, Robert Marko <robert.marko@sartura.hr>, Ryan Chen <ryan_chen@aspeedtech.com>, Sagar Shrikant Kadam <sagar.kadam@sifive.com>, Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, Siew Chin Lim <elly.siew.chin.lim@intel.com>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Stefan Roese <sr@denx.de>, Suniel Mahesh <sunil@amarulasolutions.com>, Tom Warren <twarren@nvidia.com>, Trevor Woerner <twoerner@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, Wolfgang Grandegger <wg@aries-embedded.de>, "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, "uboot-stm32@st-md-mailman.stormreply.com" <uboot-stm32@st-md-mailman.stormreply.com>, =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez_Rojas?= <noltari@gmail.com>
List-ID: <u-boot-amlogic@groups.io>


>-----Original Message-----
>From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Simon Glass
>Sent: Friday, March 26, 2021 8:43 AM
>To: U-Boot Mailing List <u-boot@lists.denx.de>
>Cc: Simon Glass <sjg@chromium.org>; Adam Ford <aford173@gmail.com>;
>Akash Gajjar <akash@openedev.com>; Alifer Moraes
><alifer.wsdm@gmail.com>; Anatolij Gustschin <agust@denx.de>; Andre
>Przywara <andre.przywara@arm.com>; Andrew F. Davis <afd@ti.com>; Andy
>Shevchenko <andriy.shevchenko@linux.intel.com>; Andy Yan
><andy.yan@rock-chips.com>; Anup Patel <anup.patel@wdc.com>; Aspeed
>BMC SW team <BMC-SW@aspeedtech.com>; Atish Patra
><atish.patra@wdc.com>; Banglang Huang <banglang.huang@foxmail.com>;
>Beniamino Galvani <b.galvani@gmail.com>; Bharat Gooty
><bharat.gooty@broadcom.com>; Bin Meng <bmeng.cn@gmail.com>; Chee
>Hong Ang <chee.hong.ang@intel.com>; Chen-Yu Tsai <wens@csie.org>;
>Chia-Wei Wang <chiawei_wang@aspeedtech.com>; Chin-Liang See
><clsee@altera.com>; Christian Hewitt <christianshewitt@gmail.com>;
>Dalon Westergreen <dwesterg@gmail.com>; Daniel Schwierzeck
><daniel.schwierzeck@gmail.com>; David Bauer <mail@david-bauer.net>;
>Dinh Nguyen <dinguyen@kernel.org>; Dirk Eibach <dirk.eibach@gdsys.cc>;
>Etienne Carriere <etienne.carriere@linaro.org>; Eugeniy Paltsev
><paltsev@synopsys.com>; Fabio Estevam <festevam@gmail.com>; Harald
>Seiler <hws@denx.de>; Heiko Stuebner <heiko.stuebner@theobroma-
>systems.com>; Holger Brunck <holger.brunck@hitachi-powergrids.com>;
>Jack Mitchell <ml@embed.me.uk>; Jagan Teki
><jagan@amarulasolutions.com>; Jean-Jacques Hiblot <jjhiblot@ti.com>;
>Jernej Skrabec <jernej.skrabec@siol.net>; Joao Marcos Costa
><joaomarcos.costa@bootlin.com>; Joe Hershberger
><joe.hershberger@ni.com>; Joel Johnson <mrjoel@lixil.net>; Kever Yang
><kever.yang@rock-chips.com>; Klaus Goger <klaus.goger@theobroma-
>systems.com>; Levin Du <djw@t-chip.com.cn>; Ley Foon Tan
><ley.foon.tan@intel.com>; Loic Devulder <ldevulder@suse.com>; Lokesh
>Vutla <lokeshvutla@ti.com>; Lukasz Majewski <lukma@denx.de>;
>Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>; Marco
>Franchi <marcofrk@gmail.com>; Marek Vasut <marex@denx.de>; Mario Six
><mario.six@gdsys.cc>; Masahiro Yamada
><yamada.masahiro@socionext.com>; Matthias Brugger
><mbrugger@suse.com>; Matwey V. Kornilov
><matwey.kornilov@gmail.com>; Maxim Sloyko <maxims@google.com>;
>Michal Simek <michal.simek@xilinx.com>; Neil Armstrong
><narmstrong@baylibre.com>; Nicolas Saenz Julienne
><nsaenzjulienne@suse.de>; Oleksandr Andrushchenko
><oleksandr_andrushchenko@epam.com>; Ovidiu Panait
><ovidiu.panait@windriver.com>; Palmer Dabbelt <palmer@dabbelt.com>;
>Patrice Chotard <patrice.chotard@foss.st.com>; Patrick Delaunay
><patrick.delaunay@foss.st.com>; Paul Walmsley
><paul.walmsley@sifive.com>; Pavel Machek <pavel@denx.de>; Peng Fan
><peng.fan@nxp.com>; Peter Robinson <pbrobinson@gmail.com>; Philipp
>Tomsich <philipp.tomsich@theobroma-systems.com>; Philippe Reynes
><philippe.reynes@softathome.com>; Pratyush Yadav <p.yadav@ti.com>;
>Ramon Fried <rfried.dev@gmail.com>; Rayagonda Kokatanur
><rayagonda.kokatanur@broadcom.com>; Reuben Dowle
><reubendowle0@gmail.com>; Robert Marko <robert.marko@sartura.hr>;
>Ryan Chen <ryan_chen@aspeedtech.com>; Sagar Shrikant Kadam
><sagar.kadam@sifive.com>; Samuel Holland <samuel@sholland.org>; Sean
>Anderson <seanga2@gmail.com>; Sebastian Reichel
><sebastian.reichel@collabora.com>; Siew Chin Lim
><elly.siew.chin.lim@intel.com>; Simon Goldschmidt
><simon.k.r.goldschmidt@gmail.com>; Stefan Roese <sr@denx.de>; Suniel
>Mahesh <sunil@amarulasolutions.com>; Tom Warren
><twarren@nvidia.com>; Trevor Woerner <twoerner@gmail.com>; Weijie
>Gao <weijie.gao@mediatek.com>; Wolfgang Grandegger <wg@aries-
>embedded.de>; u-boot-amlogic@groups.io; uboot-stm32@st-md-
>mailman.stormreply.com; =C1lvaro Fern=E1ndez Rojas <noltari@gmail.com>
>Subject: [PATCH 2/2] Rename CONFIG_DM_RESET to CONFIG_RESET
>
>This config was misnamed at birth since there has never been a
>CONFIG_RESET option used before driver model. Rename it so that it is
>clear that driver model is the only option here.
>
>Signed-off-by: Simon Glass <sjg@chromium.org>
>---
>
<snip>
I merged 1/2. This patch needs to be rebased on top of tree.

Regards
Priyanka

