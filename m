Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web08.8.1618504611819453945
 for <u-boot-amlogic@groups.io>;
 Thu, 15 Apr 2021 09:36:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1618504607;
	bh=S9ocFICtTnZ1eYW3We8zgpgIDPImv/kcX2WTeyefX2c=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=UfreHLuIm+F0DgUtEH4N8A1icUz/aNMmw1q2jOJB9u5yjKrB8EhbhyQutIB28dfYK
	 bliKWK2fOa0vbIHtwBY8DbmnSEjC+1KrsqHSZYKl7KJaN8XCJq7dPLuxzLe/wCfwey
	 MaYXcoLZEcuk1u+gglbM78FLndQp7rnoUeCVADdjVr6KeyiTOV76fYUR1o/JQ1moZx
	 8j+65cS1bMUCCdjxOHku1ow6iy8xRLol5t5BoudMiL8tfwTQx31Ec/FjelzoAGIvXY
	 NvfLWRYxZg4zumoSMeyFyPiS7KpHHYD33u7LmXlE7UNwI9CLWzfDpqkzB6+EphZgMN
	 P16gZFJ9BzcSw==
Subject: Re: [PATCH 2/2] Rename CONFIG_DM_RESET to CONFIG_RESET
References: <20210326031303.833293-1-sjg@chromium.org>
 <20210326031303.833293-2-sjg@chromium.org>
From: Marek Vasut <marex@denx.de>
Message-ID: <3b3de37f-90ea-b745-8145-0fe63e8941a6@denx.de>
Date: Thu, 15 Apr 2021 18:36:34 +0200
MIME-Version: 1.0
In-Reply-To: <20210326031303.833293-2-sjg@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Adam Ford <aford173@gmail.com>, Akash Gajjar <akash@openedev.com>, Alifer Moraes <alifer.wsdm@gmail.com>, Anatolij Gustschin <agust@denx.de>, Andre Przywara <andre.przywara@arm.com>, "Andrew F. Davis" <afd@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Yan <andy.yan@rock-chips.com>, Anup Patel <anup.patel@wdc.com>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Atish Patra <atish.patra@wdc.com>, Banglang Huang <banglang.huang@foxmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>, Bin Meng <bmeng.cn@gmail.com>, Chee Hong Ang <chee.hong.ang@intel.com>, Chen-Yu Tsai <wens@csie.org>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Chin-Liang See <clsee@altera.com>, Christian Hewitt <christianshewitt@gmail.com>, Dalon Westergreen <dwesterg@gmail.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, David Bauer <mail@david-bauer.net>, Dinh Nguyen <dinguyen@kernel.org>, Dirk Eibach <dirk.eibach@gdsys.cc>, Etienne Carriere <etienne.carriere@linaro.org>, Eugeniy Paltsev <paltsev@synopsys.com>, Fabio Estevam <festevam@gmail.com>, Harald Seiler <hws@denx.de>, Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, Holger Brunck <holger.brunck@hitachi-powergrids.com>, Jack Mitchell <ml@embed.me.uk>, Jagan Teki <jagan@amarulasolutions.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Jernej Skrabec <jernej.skrabec@siol.net>, Joao Marcos Costa <joaomarcos.costa@bootlin.com>, Joe Hershberger <joe.hershberger@ni.com>, Joel Johnson <mrjoel@lixil.net>, Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, Levin Du <djw@t-chip.com.cn>, Ley Foon Tan <ley.foon.tan@intel.com>, Loic Devulder <ldevulder@suse.com>, Lokesh Vutla <lokeshvutla@ti.com>, Lukasz Majewski <lukma@denx.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Marco Franchi <marcofrk@gmail.com>, Mario Six <mario.six@gdsys.cc>, Masahiro Yamada <yamada.masahiro@socionext.com>, Matthias Brugger <mbrugger@suse.com>, "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, Maxim Sloyko <maxims@google.com>, Michal Simek <michal.simek@xilinx.com>, Neil Armstrong <narmstrong@baylibre.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Ovidiu Panait <ovidiu.panait@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>, Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Paul Walmsley <paul.walmsley@sifive.com>, Pavel Machek <pavel@denx.de>, Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Philippe Reynes <philippe.reynes@softathome.com>, Pratyush Yadav <p.yadav@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Reuben Dowle <reubendowle0@gmail.com>, Robert Marko <robert.marko@sartura.hr>, Ryan Chen <ryan_chen@aspeedtech.com>, Sagar Shrikant Kadam <sagar.kadam@sifive.com>, Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, Siew Chin Lim <elly.siew.chin.lim@intel.com>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Stefan Roese <sr@denx.de>, Suniel Mahesh <sunil@amarulasolutions.com>, Tom Warren <twarren@nvidia.com>, Trevor Woerner <twoerner@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, Wolfgang Grandegger <wg@aries-embedded.de>, u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com, =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

On 3/26/21 4:13 AM, Simon Glass wrote:
> This config was misnamed at birth since there has never been a
> CONFIG_RESET option used before driver model. Rename it so that it is
> clear that driver model is the only option here.

I'd say it should be kept as CONFIG_DM_*, to make it clear it is a DM 
option.
