Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.51])
 by mx.groups.io with SMTP id smtpd.web11.18040.1684748539374117632
 for <u-boot-amlogic@groups.io>;
 Mon, 22 May 2023 02:42:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+MytarVo0hUTuutU70ld4csFnCfy8S9gyDCA7HTPRg=;
 b=EO2TdDGNA0GVpr4rcl+yOXqiDqzClL5yuH/FoPdDCkq8hGq5I23UoSrl+qk0XPt9c7N3G9aJSAZojU7wrDl75g2sxVK+Tyo4x+lMysDxrXyt8is3KmH1b4jjbbxs72p/js0O/0uv1OSJjwJh/RR4k9aMI7QUlSxE0ZVpVBowB5s4h8yFGswwDTwpAM8JHw8liFDGNm7pK1axon3D2s5YHR6fd+KZ3HTAY/1/X7hzIQRSQj3haX4nfsT8onC/bYBq8H5DddnuCrHYFp2VaEYR6NH6O+QDpAHzyj+n19tuKjKfNEif5l+OiNqraLc7XBj8JT8tFjgnfbdI/njSQledOA==
Message-ID: <77a11ab2-f5ef-0476-2836-82a52db88f27@suse.com>
Date: Mon, 22 May 2023 17:41:48 +0800
Subject: Re: [PATCH] global: Use proper project name U-Boot
References: <0dbdf0432405c1c38ffca55703b6737a48219e79.1684307818.git.michal.simek@amd.com>
From: Qu Wenruo <wqu@suse.com>
In-Reply-To: <0dbdf0432405c1c38ffca55703b6737a48219e79.1684307818.git.michal.simek@amd.com>
Return-Path: wqu@suse.com
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com, Tom Rini <trini@konsulko.com>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>, Chris Morgan <macromorgan@hotmail.com>, Dario Binacchi <dario.binacchi@amarulasolutions.com>, Dillon Min <dillon.minfei@gmail.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, FUKAUMI Naoki <naoki@radxa.com>, Fabio Estevam <festevam@denx.de>, Frieder Schrempf <frieder.schrempf@kontron.de>, Harald Seiler <hws@denx.de>, Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Holger Brunck <holger.brunck@hitachienergy.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, =?UTF-8?Q?Javier_Mart=c3=adnez_Canillas?= <javier@dowhile0.org>, Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, Kamil Lulko <kamil.lulko@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, Loic Poulain <loic.poulain@linaro.org>, Luka Kovacic <luka.kovacic@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>, Lukasz Majewski <lukma@denx.de>, Marc Zyngier <maz@kernel.org>, =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Matthias Winker <matthias.winker@de.bosch.com>, Michael Trimarchi <michael@amarulasolutions.com>, Michael Walle <michael@walle.cc>, Mingkai Hu <mingkai.hu@nxp.com>, Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Neil Armstrong <neil.armstrong@linaro.org>, Niel Fourie <lusus@denx.de>, Nikhil M Jain <n-jain1@ti.com>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Philip Oberfichtner <pro@denx.de>, Philipp Tomsich <philipp.tomsich@vrull.eu>, =?UTF-8?Q?Pierre-Cl=c3=a9ment_Tosi?= <ptosi@google.com>, Quentin Schulz <quentin.schulz@theobroma-systems.com>, Rajesh Bhagat <rajesh.bhagat@nxp.com>, Ralph Siemsen <ralph.siemsen@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>, Roger Knecht <rknecht@pm.me>, Sean Anderson <seanga2@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Simon Glass <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>, Uri Mashiach <uri.mashiach@compulab.co.il>, Vikas Manocha <vikas.manocha@st.com>, Will Deacon <willdeacon@google.com>, linux-btrfs@vger.kernel.org, u-boot-amlogic@groups.io, uboot-snps-arc@synopsys.com, uboot-stm32@st-md-mailman.stormreply.com
List-ID: <u-boot-amlogic@groups.io>



On 2023/5/17 15:17, Michal Simek wrote:
> Use proper project name in comments, Kconfig, readmes.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
[...]
> diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
> index 9cf8a10c76c5..02173dea5f48 100644
> --- a/fs/btrfs/compat.h
> +++ b/fs/btrfs/compat.h
> @@ -46,7 +46,7 @@
>   /*
>    * Read data from device specified by @desc and @part
>    *
> - * U-boot equivalent of pread().
> + * U-Boot equivalent of pread().
>    *
>    * Return the bytes of data read.
>    * Return <0 for error.
> diff --git a/fs/btrfs/extent-io.h b/fs/btrfs/extent-io.h
> index 6b0c87da969d..5c5c579d1eaf 100644
> --- a/fs/btrfs/extent-io.h
> +++ b/fs/btrfs/extent-io.h
> @@ -8,7 +8,7 @@
>    *   Use pointer to provide better alignment.
>    * - Remove max_cache_size related interfaces
>    *   Includes free_extent_buffer_nocache()
> - *   As we don't cache eb in U-boot.
> + *   As we don't cache eb in U-Boot.
>    * - Include headers
>    *
>    * Write related functions are kept as we still need to modify dummy extent

For the btrfs part:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
