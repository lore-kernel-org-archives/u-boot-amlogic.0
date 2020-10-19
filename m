Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by mx.groups.io with SMTP id smtpd.web10.6391.1603143468299600535
 for <u-boot-amlogic@groups.io>;
 Mon, 19 Oct 2020 14:37:48 -0700
Date: Mon, 19 Oct 2020 23:37:43 +0200
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 3/3] configs: migrate CONFIG_BMP_16/24/32BPP to defconfigs
Message-ID: <20201019233743.66ddb694@crub>
In-Reply-To: <20200928093017.19053-3-patrick.delaunay@st.com>
References: <20200928093017.19053-1-patrick.delaunay@st.com>
	<20200928093017.19053-3-patrick.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Patrick Delaunay <patrick.delaunay@st.com>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>, Adrian Alonso <adrian.alonso@nxp.com>, Akshay Bhat <akshaybhat@timesys.com>, "Ashok Reddy Soma  <ashok.reddy.soma@xilinx.com>, Baruch Siach <baruch@tkos.co.il>, Beniamino Galvani" <b.galvani@gmail.com>, Eric =?UTF-8?B?QsOpbmFyZA==?= <eric@eukrea.com>, Fabio Estevam <fabio.estevam@nxp.com>, Giulio Benetti <giulio.benetti@benettiengineering.com>, Heiko Schocher <hs@denx.de>, Holger Brunck <holger.brunck@ch.abb.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Jason Liu <jason.hui.liu@nxp.com>, "Joe Hershberger  <joe.hershberger@ni.com>, Ken Lin <Ken.Lin@advantech.com.tw>, Klaus Goger" <klaus.goger@theobroma-systems.com>, Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@xilinx.com>, Neil Armstrong <narmstrong@baylibre.com>, Olaf Mandel <o.mandel@menlosystems.com>, "Otavio Salvador  <otavio@ossystems.com.br>, Peng Fan <peng.fan@nxp.com>,  Philipp Tomsich  <philipp.tomsich@theobroma-systems.com>, Richard Hu" <richard.hu@technexion.com>, Simon Glass <sjg@chromium.org>, "Simon Goldschmidt  <simon.k.r.goldschmidt@gmail.com>, Sjoerd Simons" <sjoerd.simons@collabora.co.uk>, Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>, =?UTF-8?B?U8OpYmFzdGllbg==?= Szymanski <sebastien.szymanski@armadeus.com>, Troy Kisky <troy.kisky@boundarydevices.com>, Vanessa Maegima <vanessa.maegima@nxp.com>, Vikas Manocha <vikas.manocha@st.com>, u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
List-ID: <u-boot-amlogic@groups.io>

On Mon, 28 Sep 2020 11:30:16 +0200
Patrick Delaunay patrick.delaunay@st.com wrote:
...
>  103 files changed, 122 insertions(+), 63 deletions(-)

applied to u-boot-video/master, thanks!

--
Anatolij
