Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.17070.1684743380070207549
 for <u-boot-amlogic@groups.io>;
 Mon, 22 May 2023 01:16:20 -0700
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3094910b150so4573590f8f.0
        for <u-boot-amlogic@groups.io>; Mon, 22 May 2023 01:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684743378; x=1687335378;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AgQHXRqBL6sIjekEHRGeb4d9imcdcXKEJ98OIw4yTKg=;
        b=XBA9c08aavHUcbKsMbvGBuDaMjzzm1hyLnxUv/iESOzE6jn4Wiu/Yf3lO/PSv4rv1i
         WD6l0cGyMEE7VwwYTnTZ7CyU76egcTtiK/VkSdx4mFAhcQz3GPmXCQ9e2bntSmr+dIUW
         yKCwcu/h+KJ+2fF1Sj1h6k2L2l79R0RNy1pSjXu0qn/6/3CE8OPo1sqpeMX3+PUKZxaP
         7xevqo3ao58RsmEz7ZFKsZtms4LLQnFNdKImCdu53HQnOvA/EGl9l8SYI3BCTJL03fHL
         HNCI8pEa+AdY6AegGEzg8QTV8u1YdZqAeWKYL8W4RCG1osF6strkA2WjJ9OdMfkJz29Q
         Q0YA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <4e3a7b8f-b5e0-4f66-fa10-a37df0eee7c4@linaro.org>
Date: Mon, 22 May 2023 10:16:13 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] global: Use proper project name U-Boot
References: <0dbdf0432405c1c38ffca55703b6737a48219e79.1684307818.git.michal.simek@amd.com>
In-Reply-To: <0dbdf0432405c1c38ffca55703b6737a48219e79.1684307818.git.michal.simek@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com, Tom Rini <trini@konsulko.com>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>, Chris Morgan <macromorgan@hotmail.com>, Dario Binacchi <dario.binacchi@amarulasolutions.com>, Dillon Min <dillon.minfei@gmail.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, FUKAUMI Naoki <naoki@radxa.com>, Fabio Estevam <festevam@denx.de>, Frieder Schrempf <frieder.schrempf@kontron.de>, Harald Seiler <hws@denx.de>, Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Holger Brunck <holger.brunck@hitachienergy.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, =?UTF-8?Q?Javier_Mart=c3=adnez_Canillas?= <javier@dowhile0.org>, Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, Kamil Lulko <kamil.lulko@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, Loic Poulain <loic.poulain@linaro.org>, Luka Kovacic <luka.kovacic@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>, Lukasz Majewski <lukma@denx.de>, Marc Zyngier <maz@kernel.org>, =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Matthias Winker <matthias.winker@de.bosch.com>, Michael Trimarchi <michael@amarulasolutions.com>, Michael Walle <michael@walle.cc>, Mingkai Hu <mingkai.hu@nxp.com>, Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Niel Fourie <lusus@denx.de>, Nikhil M Jain <n-jain1@ti.com>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Philip Oberfichtner <pro@denx.de>, Philipp Tomsich <philipp.tomsich@vrull.eu>, =?UTF-8?Q?Pierre-Cl=c3=a9ment_Tosi?= <ptosi@google.com>, Qu Wenruo <wqu@suse.com>, Quentin Schulz <quentin.schulz@theobroma-systems.com>, Rajesh Bhagat <rajesh.bhagat@nxp.com>, Ralph Siemsen <ralph.siemsen@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>, Roger Knecht <rknecht@pm.me>, Sean Anderson <seanga2@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Simon Glass <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>, Uri Mashiach <uri.mashiach@compulab.co.il>, Vikas Manocha <vikas.manocha@st.com>, Will Deacon <willdeacon@google.com>, linux-btrfs@vger.kernel.org, u-boot-amlogic@groups.io, uboot-snps-arc@synopsys.com, uboot-stm32@st-md-mailman.stormreply.com
List-ID: <u-boot-amlogic@groups.io>

On 17/05/2023 09:17, Michal Simek wrote:
> Use proper project name in comments, Kconfig, readmes.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>


For amlogic changes:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


> ---
> 
> I am ignoring these for now because they can break automated scripts or
> user setting that's why they should be fixed separately.
> 

<snip>

> doc/board/amlogic/pre-generated-fip.rst:77:- bl33.bin: U-boot binary image

You can add this change safely,

Neil



<snip>

