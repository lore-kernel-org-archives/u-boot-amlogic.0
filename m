Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.88])
 by mx.groups.io with SMTP id smtpd.web10.8384.1685449642561205614
 for <u-boot-amlogic@groups.io>;
 Tue, 30 May 2023 05:27:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCncz0py/LySkY/PiQVSGvKP8aJVVusAyVHHBVCnCJ0=;
 b=Ia/D9VEThsMb7diXEEIFtiV96s0HUyRqllbj2G2ux6rG2+kqYJ3FZA/EJ5XBWywD/af+C4qAhG9P7/Yru0JANK4gMfhHWr82JAiysOEDy5mb9j9lbTr72b/bdg07Sm9w56nZ9spnH6yLv9S7PznRCxhUunKHpqBRARvK3nnhYFg=
Message-ID: <505d3ba9-33c3-6dbb-5eaa-7468e1dfe02d@amd.com>
Date: Tue, 30 May 2023 14:26:33 +0200
Subject: Re: [PATCH] global: Use proper project name U-Boot
References: <0dbdf0432405c1c38ffca55703b6737a48219e79.1684307818.git.michal.simek@amd.com>
 <4e3a7b8f-b5e0-4f66-fa10-a37df0eee7c4@linaro.org>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <4e3a7b8f-b5e0-4f66-fa10-a37df0eee7c4@linaro.org>
Return-Path: michal.simek@amd.com
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: neil.armstrong@linaro.org, u-boot@lists.denx.de, git@xilinx.com, Tom Rini <trini@konsulko.com>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>, Chris Morgan <macromorgan@hotmail.com>, Dario Binacchi <dario.binacchi@amarulasolutions.com>, Dillon Min <dillon.minfei@gmail.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, FUKAUMI Naoki <naoki@radxa.com>, Fabio Estevam <festevam@denx.de>, Frieder Schrempf <frieder.schrempf@kontron.de>, Harald Seiler <hws@denx.de>, Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Holger Brunck <holger.brunck@hitachienergy.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, =?UTF-8?Q?Javier_Mart=c3=adnez_Canillas?= <javier@dowhile0.org>, Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, Kamil Lulko <kamil.lulko@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, Loic Poulain <loic.poulain@linaro.org>, Luka Kovacic <luka.kovacic@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>, Lukasz Majewski <lukma@denx.de>, Marc Zyngier <maz@kernel.org>, =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Matthias Winker <matthias.winker@de.bosch.com>, Michael Trimarchi <michael@amarulasolutions.com>, Michael Walle <michael@walle.cc>, Mingkai Hu <mingkai.hu@nxp.com>, Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Niel Fourie <lusus@denx.de>, Nikhil M Jain <n-jain1@ti.com>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Philip Oberfichtner <pro@denx.de>, Philipp Tomsich <philipp.tomsich@vrull.eu>, =?UTF-8?Q?Pierre-Cl=c3=a9ment_Tosi?= <ptosi@google.com>, Qu Wenruo <wqu@suse.com>, Quentin Schulz <quentin.schulz@theobroma-systems.com>, Rajesh Bhagat <rajesh.bhagat@nxp.com>, Ralph Siemsen <ralph.siemsen@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>, Roger Knecht <rknecht@pm.me>, Sean Anderson <seanga2@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Simon Glass <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>, Uri Mashiach <uri.mashiach@compulab.co.il>, Vikas Manocha <vikas.manocha@st.com>, Will Deacon <willdeacon@google.com>, linux-btrfs@vger.kernel.org, u-boot-amlogic@groups.io, uboot-snps-arc@synopsys.com, uboot-stm32@st-md-mailman.stormreply.com
List-ID: <u-boot-amlogic@groups.io>



On 5/22/23 10:16, Neil Armstrong wrote:
> On 17/05/2023 09:17, Michal Simek wrote:
>> Use proper project name in comments, Kconfig, readmes.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> 
> For amlogic changes:
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> 
>> ---
>>
>> I am ignoring these for now because they can break automated scripts or
>> user setting that's why they should be fixed separately.
>>
> 
> <snip>
> 
>> doc/board/amlogic/pre-generated-fip.rst:77:- bl33.bin: U-boot binary image
> 
> You can add this change safely,
> 
> Neil
> 
> 
> 
> <snip>
> 

Applied.
M
