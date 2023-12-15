Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A2CC46CA2
	for <webhook@archiver.kernel.org>; Mon, 18 Dec 2023 08:39:43 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web10.68725.1702662722307764076
 for <u-boot-amlogic@groups.io>;
 Fri, 15 Dec 2023 09:52:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=c8iEckVr;
 spf=pass (domain: gmail.com, ip: 209.85.210.45, mailfrom: seanga2@gmail.com)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d9dc789f23so746789a34.3
        for <u-boot-amlogic@groups.io>; Fri, 15 Dec 2023 09:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702662721; x=1703267521; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fOacWe8aSb+MajK+NcQjELlXNhwOtGSy5GnWM/X+wu8=;
        b=c8iEckVrtm8Kaf8bKqYDw4EA294PPKa1smiYe+Tzw8fH5TzYYXl1HvtWJf0uWb8NbZ
         Y9Gdk9fo7budkvh+NBIL9zKaaoallh3ULWry0Dh30SEww9eygVLZL0tk3UuM5FL39Dqu
         BFZCpIwKRbjRVszJmlWbeka6Wy59N3Qg8lb3Wdx52jv2rvThO8ZVcB51RUtF3Ioqa1D6
         jwj/3fepZW7GlN5cG5FLolN+9LGOZX5/+cRKmqkldV2CRa+xABlqSovVH/+p0Z/CZ3Eq
         oB5z1WDIBK36mKd/r8oPt0HGKMPX8IBPV83ta0DBmd4tARqd3b2mJoWd2DDHb+pxYRPw
         pKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702662721; x=1703267521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOacWe8aSb+MajK+NcQjELlXNhwOtGSy5GnWM/X+wu8=;
        b=naR0HUtwxhxYzsUlPl5t+HNs/VCt627RGWWJx5AplElvyHt40KEu7maTe7O4MxzGzE
         izYcNJOUgW/WOwBFEWlUpuAsoAJEfkvbPT8Kd+eO+Et76Dmz+n67KSa3h3D1Q2GoenLf
         IZvQeT549s1/2ecvg2Yo18aS12rGqoX3+/SB3xNDyLSME3aXTgAyqXPj6yrhMytxNp2D
         WOfXPkSxYhdpiY5Ixu7J1qguBZl85y5o3PB1bq2IrDCeCdw9eb9qcwsdqib15Sxtx50X
         FVO9pW9KFNYsfolCa7oWYAcaDLOGWlvydrj0xmOdO+I5u3DLpnxWASEEodh7Wuj4bs03
         uClg==
X-Gm-Message-State: AOJu0Ywg8acnFZ1siRtx+d9UakqDI730l4xUNbDG32/Zwbfg1oS/keeR
	N9CqCf1jq5KQeqMbfQM0tbg=
X-Google-Smtp-Source: AGHT+IGz2D+kTgXYs0bczvJWqRghXsLy4vcHdkwDvgmh883cIgYh/dWM6wQzzoQQLY63zt7wz8tQyg==
X-Received: by 2002:a05:6871:5a8c:b0:203:2537:5977 with SMTP id oo12-20020a0568715a8c00b0020325375977mr4992743oac.2.1702662721345;
        Fri, 15 Dec 2023 09:52:01 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with ESMTPSA id e7-20020ac845c7000000b00418122186ccsm6823170qto.12.2023.12.15.09.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 09:52:00 -0800 (PST)
Message-ID: <75fa68fe-cdc4-4036-3798-6fd2f281fbc9@gmail.com>
Date: Fri, 15 Dec 2023 12:52:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] clk: meson: add Hardware Clock measure driver
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
References: <20231212-uboot-meson-clk-msr-v2-1-1cd0addf4dda@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231212-uboot-meson-clk-msr-v2-1-1cd0addf4dda@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 18 Dec 2023 08:39:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1939

On 12/12/23 09:12, Neil Armstrong wrote:
> Amlogic SoCs embeds an hardware clock measure block, port it
> from Linux and implement it as a UCLK_CLK with only the dump
> op and fail-only xlate.

Please include a short blurb describing the hardware like you did for Linux
commit 2b45ebef39a2 ("soc: amlogic: Add Meson Clock Measure driver").

> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - remove common.h and include time.h instead
> - Link to v1: https://lore.kernel.org/r/20231113-uboot-meson-clk-msr-v1-1-73204d09fc0b@linaro.org
> ---
>   drivers/clk/meson/Kconfig       |   9 +
>   drivers/clk/meson/Makefile      |   1 +
>   drivers/clk/meson/clk-measure.c | 634 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 644 insertions(+)
> 
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index cdc9d6f76c..da097ae7b8 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -29,3 +29,12 @@ config CLK_MESON_A1
>   	help
>   	  Enable clock support for the Amlogic A1 SoC family, such as
>   	  the A113L
> +
> +config CLK_MESON_MSR
> +	bool "Enable clock measure driver for Amlogic SoCs"
> +	depends on CLK && ARCH_MESON
> +	depends on CMD_CLK
> +	default ARCH_MESON
> +	help
> +	  Enable clock support for the Hardware Clock Measure for various
> +	  Amlogic SoCs.

And something closer to the Linux Kconfig would be nice too. E.g.

Enable measuring a set of internal SoC clock frequencies with the clk dump
command.


> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index d975f07aab..c7a446e86c 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_CLK_MESON_AXG) += axg-ao.o
>   obj-$(CONFIG_CLK_MESON_G12A) += g12a.o
>   obj-$(CONFIG_CLK_MESON_G12A) += g12a-ao.o
>   obj-$(CONFIG_CLK_MESON_A1) += a1.o
> +obj-$(CONFIG_CLK_MESON_MSR) += clk-measure.o
> diff --git a/drivers/clk/meson/clk-measure.c b/drivers/clk/meson/clk-measure.c
> new file mode 100644
> index 0000000000..f653fc6355
> --- /dev/null
> +++ b/drivers/clk/meson/clk-measure.c
> @@ -0,0 +1,634 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Based on Linux driver from:
> + * (C) Copyright 2018 - BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + * (C) Copyright 2023 - Neil Armstrong <neil.armstrong@linaro.org>
> + */
> +
> +#include <log.h>
> +#include <clk-uclass.h>
> +#include <div64.h>
> +#include <dm.h>
> +#include <time.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +
> +#define MSR_CLK_DUTY		0x0
> +#define MSR_CLK_REG0		0x4
> +#define MSR_CLK_REG1		0x8
> +#define MSR_CLK_REG2		0xc
> +
> +#define MSR_DURATION		GENMASK(15, 0)
> +#define MSR_ENABLE		BIT(16)
> +#define MSR_CONT		BIT(17) /* continuous measurement */
> +#define MSR_INTR		BIT(18) /* interrupts */
> +#define MSR_RUN			BIT(19)
> +#define MSR_CLK_SRC		GENMASK(26, 20)
> +#define MSR_BUSY		BIT(31)
> +
> +#define MSR_VAL_MASK		GENMASK(15, 0)
> +
> +#define DIV_MIN			32
> +#define DIV_STEP		32
> +#define DIV_MAX			640
> +
> +#define CLK_MSR_MAX		128
> +
> +struct meson_msr_id {
> +	unsigned int id;
> +	const char *name;
> +};
> +
> +struct meson_msr {
> +	struct regmap *regmap;
> +	struct meson_msr_id *msr_table;
> +};
> +
> +#define CLK_MSR_ID(__id, __name) \
> +	[__id] = {.id = __id, .name = __name,}

To reduce binary size you may want to ifdef these arrays out depending on the
platform. Up to you.

> +static struct meson_msr_id clk_msr_m8[CLK_MSR_MAX] = {
> +	CLK_MSR_ID(0, "ring_osc_out_ee0"),
> +	CLK_MSR_ID(1, "ring_osc_out_ee1"),
> +	CLK_MSR_ID(2, "ring_osc_out_ee2"),
> +	CLK_MSR_ID(3, "a9_ring_osck"),
> +	CLK_MSR_ID(6, "vid_pll"),
> +	CLK_MSR_ID(7, "clk81"),
> +	CLK_MSR_ID(8, "encp"),
> +	CLK_MSR_ID(9, "encl"),
> +	CLK_MSR_ID(11, "eth_rmii"),
> +	CLK_MSR_ID(13, "amclk"),
> +	CLK_MSR_ID(14, "fec_clk_0"),
> +	CLK_MSR_ID(15, "fec_clk_1"),
> +	CLK_MSR_ID(16, "fec_clk_2"),
> +	CLK_MSR_ID(18, "a9_clk_div16"),
> +	CLK_MSR_ID(19, "hdmi_sys"),
> +	CLK_MSR_ID(20, "rtc_osc_clk_out"),
> +	CLK_MSR_ID(21, "i2s_clk_in_src0"),
> +	CLK_MSR_ID(22, "clk_rmii_from_pad"),
> +	CLK_MSR_ID(23, "hdmi_ch0_tmds"),
> +	CLK_MSR_ID(24, "lvds_fifo"),
> +	CLK_MSR_ID(26, "sc_clk_int"),
> +	CLK_MSR_ID(28, "sar_adc"),
> +	CLK_MSR_ID(30, "mpll_clk_test_out"),
> +	CLK_MSR_ID(31, "audac_clkpi"),
> +	CLK_MSR_ID(32, "vdac"),
> +	CLK_MSR_ID(33, "sdhc_rx"),
> +	CLK_MSR_ID(34, "sdhc_sd"),
> +	CLK_MSR_ID(35, "mali"),
> +	CLK_MSR_ID(36, "hdmi_tx_pixel"),
> +	CLK_MSR_ID(38, "vdin_meas"),
> +	CLK_MSR_ID(39, "pcm_sclk"),
> +	CLK_MSR_ID(40, "pcm_mclk"),
> +	CLK_MSR_ID(41, "eth_rx_tx"),
> +	CLK_MSR_ID(42, "pwm_d"),
> +	CLK_MSR_ID(43, "pwm_c"),
> +	CLK_MSR_ID(44, "pwm_b"),
> +	CLK_MSR_ID(45, "pwm_a"),
> +	CLK_MSR_ID(46, "pcm2_sclk"),
> +	CLK_MSR_ID(47, "ddr_dpll_pt"),
> +	CLK_MSR_ID(48, "pwm_f"),
> +	CLK_MSR_ID(49, "pwm_e"),
> +	CLK_MSR_ID(59, "hcodec"),
> +	CLK_MSR_ID(60, "usb_32k_alt"),
> +	CLK_MSR_ID(61, "gpio"),
> +	CLK_MSR_ID(62, "vid2_pll"),
> +	CLK_MSR_ID(63, "mipi_csi_cfg"),
> +};
> +
> +static struct meson_msr_id clk_msr_gx[CLK_MSR_MAX] = {
> +	CLK_MSR_ID(0, "ring_osc_out_ee_0"),
> +	CLK_MSR_ID(1, "ring_osc_out_ee_1"),
> +	CLK_MSR_ID(2, "ring_osc_out_ee_2"),
> +	CLK_MSR_ID(3, "a53_ring_osc"),
> +	CLK_MSR_ID(4, "gp0_pll"),
> +	CLK_MSR_ID(6, "enci"),
> +	CLK_MSR_ID(7, "clk81"),
> +	CLK_MSR_ID(8, "encp"),
> +	CLK_MSR_ID(9, "encl"),
> +	CLK_MSR_ID(10, "vdac"),
> +	CLK_MSR_ID(11, "rgmii_tx"),
> +	CLK_MSR_ID(12, "pdm"),
> +	CLK_MSR_ID(13, "amclk"),
> +	CLK_MSR_ID(14, "fec_0"),
> +	CLK_MSR_ID(15, "fec_1"),
> +	CLK_MSR_ID(16, "fec_2"),
> +	CLK_MSR_ID(17, "sys_pll_div16"),
> +	CLK_MSR_ID(18, "sys_cpu_div16"),
> +	CLK_MSR_ID(19, "hdmitx_sys"),
> +	CLK_MSR_ID(20, "rtc_osc_out"),
> +	CLK_MSR_ID(21, "i2s_in_src0"),
> +	CLK_MSR_ID(22, "eth_phy_ref"),
> +	CLK_MSR_ID(23, "hdmi_todig"),
> +	CLK_MSR_ID(26, "sc_int"),
> +	CLK_MSR_ID(28, "sar_adc"),
> +	CLK_MSR_ID(31, "mpll_test_out"),
> +	CLK_MSR_ID(32, "vdec"),
> +	CLK_MSR_ID(35, "mali"),
> +	CLK_MSR_ID(36, "hdmi_tx_pixel"),
> +	CLK_MSR_ID(37, "i958"),
> +	CLK_MSR_ID(38, "vdin_meas"),
> +	CLK_MSR_ID(39, "pcm_sclk"),
> +	CLK_MSR_ID(40, "pcm_mclk"),
> +	CLK_MSR_ID(41, "eth_rx_or_rmii"),
> +	CLK_MSR_ID(42, "mp0_out"),
> +	CLK_MSR_ID(43, "fclk_div5"),
> +	CLK_MSR_ID(44, "pwm_b"),
> +	CLK_MSR_ID(45, "pwm_a"),
> +	CLK_MSR_ID(46, "vpu"),
> +	CLK_MSR_ID(47, "ddr_dpll_pt"),
> +	CLK_MSR_ID(48, "mp1_out"),
> +	CLK_MSR_ID(49, "mp2_out"),
> +	CLK_MSR_ID(50, "mp3_out"),
> +	CLK_MSR_ID(51, "nand_core"),
> +	CLK_MSR_ID(52, "sd_emmc_b"),
> +	CLK_MSR_ID(53, "sd_emmc_a"),
> +	CLK_MSR_ID(55, "vid_pll_div_out"),
> +	CLK_MSR_ID(56, "cci"),
> +	CLK_MSR_ID(57, "wave420l_c"),
> +	CLK_MSR_ID(58, "wave420l_b"),
> +	CLK_MSR_ID(59, "hcodec"),
> +	CLK_MSR_ID(60, "alt_32k"),
> +	CLK_MSR_ID(61, "gpio_msr"),
> +	CLK_MSR_ID(62, "hevc"),
> +	CLK_MSR_ID(66, "vid_lock"),
> +	CLK_MSR_ID(70, "pwm_f"),
> +	CLK_MSR_ID(71, "pwm_e"),
> +	CLK_MSR_ID(72, "pwm_d"),
> +	CLK_MSR_ID(73, "pwm_c"),
> +	CLK_MSR_ID(75, "aoclkx2_int"),
> +	CLK_MSR_ID(76, "aoclk_int"),
> +	CLK_MSR_ID(77, "rng_ring_osc_0"),
> +	CLK_MSR_ID(78, "rng_ring_osc_1"),
> +	CLK_MSR_ID(79, "rng_ring_osc_2"),
> +	CLK_MSR_ID(80, "rng_ring_osc_3"),
> +	CLK_MSR_ID(81, "vapb"),
> +	CLK_MSR_ID(82, "ge2d"),
> +};
> +
> +static struct meson_msr_id clk_msr_axg[CLK_MSR_MAX] = {
> +	CLK_MSR_ID(0, "ring_osc_out_ee_0"),
> +	CLK_MSR_ID(1, "ring_osc_out_ee_1"),
> +	CLK_MSR_ID(2, "ring_osc_out_ee_2"),
> +	CLK_MSR_ID(3, "a53_ring_osc"),
> +	CLK_MSR_ID(4, "gp0_pll"),
> +	CLK_MSR_ID(5, "gp1_pll"),
> +	CLK_MSR_ID(7, "clk81"),
> +	CLK_MSR_ID(9, "encl"),
> +	CLK_MSR_ID(17, "sys_pll_div16"),
> +	CLK_MSR_ID(18, "sys_cpu_div16"),
> +	CLK_MSR_ID(20, "rtc_osc_out"),
> +	CLK_MSR_ID(23, "mmc_clk"),
> +	CLK_MSR_ID(28, "sar_adc"),
> +	CLK_MSR_ID(31, "mpll_test_out"),
> +	CLK_MSR_ID(40, "mod_eth_tx_clk"),
> +	CLK_MSR_ID(41, "mod_eth_rx_clk_rmii"),
> +	CLK_MSR_ID(42, "mp0_out"),
> +	CLK_MSR_ID(43, "fclk_div5"),
> +	CLK_MSR_ID(44, "pwm_b"),
> +	CLK_MSR_ID(45, "pwm_a"),
> +	CLK_MSR_ID(46, "vpu"),
> +	CLK_MSR_ID(47, "ddr_dpll_pt"),
> +	CLK_MSR_ID(48, "mp1_out"),
> +	CLK_MSR_ID(49, "mp2_out"),
> +	CLK_MSR_ID(50, "mp3_out"),
> +	CLK_MSR_ID(51, "sd_emmm_c"),
> +	CLK_MSR_ID(52, "sd_emmc_b"),
> +	CLK_MSR_ID(61, "gpio_msr"),
> +	CLK_MSR_ID(66, "audio_slv_lrclk_c"),
> +	CLK_MSR_ID(67, "audio_slv_lrclk_b"),
> +	CLK_MSR_ID(68, "audio_slv_lrclk_a"),
> +	CLK_MSR_ID(69, "audio_slv_sclk_c"),
> +	CLK_MSR_ID(70, "audio_slv_sclk_b"),
> +	CLK_MSR_ID(71, "audio_slv_sclk_a"),
> +	CLK_MSR_ID(72, "pwm_d"),
> +	CLK_MSR_ID(73, "pwm_c"),
> +	CLK_MSR_ID(74, "wifi_beacon"),
> +	CLK_MSR_ID(75, "tdmin_lb_lrcl"),
> +	CLK_MSR_ID(76, "tdmin_lb_sclk"),
> +	CLK_MSR_ID(77, "rng_ring_osc_0"),
> +	CLK_MSR_ID(78, "rng_ring_osc_1"),
> +	CLK_MSR_ID(79, "rng_ring_osc_2"),
> +	CLK_MSR_ID(80, "rng_ring_osc_3"),
> +	CLK_MSR_ID(81, "vapb"),
> +	CLK_MSR_ID(82, "ge2d"),
> +	CLK_MSR_ID(84, "audio_resample"),
> +	CLK_MSR_ID(85, "audio_pdm_sys"),
> +	CLK_MSR_ID(86, "audio_spdifout"),
> +	CLK_MSR_ID(87, "audio_spdifin"),
> +	CLK_MSR_ID(88, "audio_lrclk_f"),
> +	CLK_MSR_ID(89, "audio_lrclk_e"),
> +	CLK_MSR_ID(90, "audio_lrclk_d"),
> +	CLK_MSR_ID(91, "audio_lrclk_c"),
> +	CLK_MSR_ID(92, "audio_lrclk_b"),
> +	CLK_MSR_ID(93, "audio_lrclk_a"),
> +	CLK_MSR_ID(94, "audio_sclk_f"),
> +	CLK_MSR_ID(95, "audio_sclk_e"),
> +	CLK_MSR_ID(96, "audio_sclk_d"),
> +	CLK_MSR_ID(97, "audio_sclk_c"),
> +	CLK_MSR_ID(98, "audio_sclk_b"),
> +	CLK_MSR_ID(99, "audio_sclk_a"),
> +	CLK_MSR_ID(100, "audio_mclk_f"),
> +	CLK_MSR_ID(101, "audio_mclk_e"),
> +	CLK_MSR_ID(102, "audio_mclk_d"),
> +	CLK_MSR_ID(103, "audio_mclk_c"),
> +	CLK_MSR_ID(104, "audio_mclk_b"),
> +	CLK_MSR_ID(105, "audio_mclk_a"),
> +	CLK_MSR_ID(106, "pcie_refclk_n"),
> +	CLK_MSR_ID(107, "pcie_refclk_p"),
> +	CLK_MSR_ID(108, "audio_locker_out"),
> +	CLK_MSR_ID(109, "audio_locker_in"),
> +};
> +
> +static struct meson_msr_id clk_msr_g12a[CLK_MSR_MAX] = {
> +	CLK_MSR_ID(0, "ring_osc_out_ee_0"),
> +	CLK_MSR_ID(1, "ring_osc_out_ee_1"),
> +	CLK_MSR_ID(2, "ring_osc_out_ee_2"),
> +	CLK_MSR_ID(3, "sys_cpu_ring_osc"),
> +	CLK_MSR_ID(4, "gp0_pll"),
> +	CLK_MSR_ID(6, "enci"),
> +	CLK_MSR_ID(7, "clk81"),
> +	CLK_MSR_ID(8, "encp"),
> +	CLK_MSR_ID(9, "encl"),
> +	CLK_MSR_ID(10, "vdac"),
> +	CLK_MSR_ID(11, "eth_tx"),
> +	CLK_MSR_ID(12, "hifi_pll"),
> +	CLK_MSR_ID(13, "mod_tcon"),
> +	CLK_MSR_ID(14, "fec_0"),
> +	CLK_MSR_ID(15, "fec_1"),
> +	CLK_MSR_ID(16, "fec_2"),
> +	CLK_MSR_ID(17, "sys_pll_div16"),
> +	CLK_MSR_ID(18, "sys_cpu_div16"),
> +	CLK_MSR_ID(19, "lcd_an_ph2"),
> +	CLK_MSR_ID(20, "rtc_osc_out"),
> +	CLK_MSR_ID(21, "lcd_an_ph3"),
> +	CLK_MSR_ID(22, "eth_phy_ref"),
> +	CLK_MSR_ID(23, "mpll_50m"),
> +	CLK_MSR_ID(24, "eth_125m"),
> +	CLK_MSR_ID(25, "eth_rmii"),
> +	CLK_MSR_ID(26, "sc_int"),
> +	CLK_MSR_ID(27, "in_mac"),
> +	CLK_MSR_ID(28, "sar_adc"),
> +	CLK_MSR_ID(29, "pcie_inp"),
> +	CLK_MSR_ID(30, "pcie_inn"),
> +	CLK_MSR_ID(31, "mpll_test_out"),
> +	CLK_MSR_ID(32, "vdec"),
> +	CLK_MSR_ID(33, "sys_cpu_ring_osc_1"),
> +	CLK_MSR_ID(34, "eth_mpll_50m"),
> +	CLK_MSR_ID(35, "mali"),
> +	CLK_MSR_ID(36, "hdmi_tx_pixel"),
> +	CLK_MSR_ID(37, "cdac"),
> +	CLK_MSR_ID(38, "vdin_meas"),
> +	CLK_MSR_ID(39, "bt656"),
> +	CLK_MSR_ID(41, "eth_rx_or_rmii"),
> +	CLK_MSR_ID(42, "mp0_out"),
> +	CLK_MSR_ID(43, "fclk_div5"),
> +	CLK_MSR_ID(44, "pwm_b"),
> +	CLK_MSR_ID(45, "pwm_a"),
> +	CLK_MSR_ID(46, "vpu"),
> +	CLK_MSR_ID(47, "ddr_dpll_pt"),
> +	CLK_MSR_ID(48, "mp1_out"),
> +	CLK_MSR_ID(49, "mp2_out"),
> +	CLK_MSR_ID(50, "mp3_out"),
> +	CLK_MSR_ID(51, "sd_emmc_c"),
> +	CLK_MSR_ID(52, "sd_emmc_b"),
> +	CLK_MSR_ID(53, "sd_emmc_a"),
> +	CLK_MSR_ID(54, "vpu_clkc"),
> +	CLK_MSR_ID(55, "vid_pll_div_out"),
> +	CLK_MSR_ID(56, "wave420l_a"),
> +	CLK_MSR_ID(57, "wave420l_c"),
> +	CLK_MSR_ID(58, "wave420l_b"),
> +	CLK_MSR_ID(59, "hcodec"),
> +	CLK_MSR_ID(61, "gpio_msr"),
> +	CLK_MSR_ID(62, "hevcb"),
> +	CLK_MSR_ID(63, "dsi_meas"),
> +	CLK_MSR_ID(64, "spicc_1"),
> +	CLK_MSR_ID(65, "spicc_0"),
> +	CLK_MSR_ID(66, "vid_lock"),
> +	CLK_MSR_ID(67, "dsi_phy"),
> +	CLK_MSR_ID(68, "hdcp22_esm"),
> +	CLK_MSR_ID(69, "hdcp22_skp"),
> +	CLK_MSR_ID(70, "pwm_f"),
> +	CLK_MSR_ID(71, "pwm_e"),
> +	CLK_MSR_ID(72, "pwm_d"),
> +	CLK_MSR_ID(73, "pwm_c"),
> +	CLK_MSR_ID(75, "hevcf"),
> +	CLK_MSR_ID(77, "rng_ring_osc_0"),
> +	CLK_MSR_ID(78, "rng_ring_osc_1"),
> +	CLK_MSR_ID(79, "rng_ring_osc_2"),
> +	CLK_MSR_ID(80, "rng_ring_osc_3"),
> +	CLK_MSR_ID(81, "vapb"),
> +	CLK_MSR_ID(82, "ge2d"),
> +	CLK_MSR_ID(83, "co_rx"),
> +	CLK_MSR_ID(84, "co_tx"),
> +	CLK_MSR_ID(89, "hdmi_todig"),
> +	CLK_MSR_ID(90, "hdmitx_sys"),
> +	CLK_MSR_ID(91, "sys_cpub_div16"),
> +	CLK_MSR_ID(92, "sys_pll_cpub_div16"),
> +	CLK_MSR_ID(94, "eth_phy_rx"),
> +	CLK_MSR_ID(95, "eth_phy_pll"),
> +	CLK_MSR_ID(96, "vpu_b"),
> +	CLK_MSR_ID(97, "cpu_b_tmp"),
> +	CLK_MSR_ID(98, "ts"),
> +	CLK_MSR_ID(99, "ring_osc_out_ee_3"),
> +	CLK_MSR_ID(100, "ring_osc_out_ee_4"),
> +	CLK_MSR_ID(101, "ring_osc_out_ee_5"),
> +	CLK_MSR_ID(102, "ring_osc_out_ee_6"),
> +	CLK_MSR_ID(103, "ring_osc_out_ee_7"),
> +	CLK_MSR_ID(104, "ring_osc_out_ee_8"),
> +	CLK_MSR_ID(105, "ring_osc_out_ee_9"),
> +	CLK_MSR_ID(106, "ephy_test"),
> +	CLK_MSR_ID(107, "au_dac_g128x"),
> +	CLK_MSR_ID(108, "audio_locker_out"),
> +	CLK_MSR_ID(109, "audio_locker_in"),
> +	CLK_MSR_ID(110, "audio_tdmout_c_sclk"),
> +	CLK_MSR_ID(111, "audio_tdmout_b_sclk"),
> +	CLK_MSR_ID(112, "audio_tdmout_a_sclk"),
> +	CLK_MSR_ID(113, "audio_tdmin_lb_sclk"),
> +	CLK_MSR_ID(114, "audio_tdmin_c_sclk"),
> +	CLK_MSR_ID(115, "audio_tdmin_b_sclk"),
> +	CLK_MSR_ID(116, "audio_tdmin_a_sclk"),
> +	CLK_MSR_ID(117, "audio_resample"),
> +	CLK_MSR_ID(118, "audio_pdm_sys"),
> +	CLK_MSR_ID(119, "audio_spdifout_b"),
> +	CLK_MSR_ID(120, "audio_spdifout"),
> +	CLK_MSR_ID(121, "audio_spdifin"),
> +	CLK_MSR_ID(122, "audio_pdm_dclk"),
> +};
> +
> +static struct meson_msr_id clk_msr_sm1[CLK_MSR_MAX] = {
> +	CLK_MSR_ID(0, "ring_osc_out_ee_0"),
> +	CLK_MSR_ID(1, "ring_osc_out_ee_1"),
> +	CLK_MSR_ID(2, "ring_osc_out_ee_2"),
> +	CLK_MSR_ID(3, "ring_osc_out_ee_3"),
> +	CLK_MSR_ID(4, "gp0_pll"),
> +	CLK_MSR_ID(5, "gp1_pll"),
> +	CLK_MSR_ID(6, "enci"),
> +	CLK_MSR_ID(7, "clk81"),
> +	CLK_MSR_ID(8, "encp"),
> +	CLK_MSR_ID(9, "encl"),
> +	CLK_MSR_ID(10, "vdac"),
> +	CLK_MSR_ID(11, "eth_tx"),
> +	CLK_MSR_ID(12, "hifi_pll"),
> +	CLK_MSR_ID(13, "mod_tcon"),
> +	CLK_MSR_ID(14, "fec_0"),
> +	CLK_MSR_ID(15, "fec_1"),
> +	CLK_MSR_ID(16, "fec_2"),
> +	CLK_MSR_ID(17, "sys_pll_div16"),
> +	CLK_MSR_ID(18, "sys_cpu_div16"),
> +	CLK_MSR_ID(19, "lcd_an_ph2"),
> +	CLK_MSR_ID(20, "rtc_osc_out"),
> +	CLK_MSR_ID(21, "lcd_an_ph3"),
> +	CLK_MSR_ID(22, "eth_phy_ref"),
> +	CLK_MSR_ID(23, "mpll_50m"),
> +	CLK_MSR_ID(24, "eth_125m"),
> +	CLK_MSR_ID(25, "eth_rmii"),
> +	CLK_MSR_ID(26, "sc_int"),
> +	CLK_MSR_ID(27, "in_mac"),
> +	CLK_MSR_ID(28, "sar_adc"),
> +	CLK_MSR_ID(29, "pcie_inp"),
> +	CLK_MSR_ID(30, "pcie_inn"),
> +	CLK_MSR_ID(31, "mpll_test_out"),
> +	CLK_MSR_ID(32, "vdec"),
> +	CLK_MSR_ID(34, "eth_mpll_50m"),
> +	CLK_MSR_ID(35, "mali"),
> +	CLK_MSR_ID(36, "hdmi_tx_pixel"),
> +	CLK_MSR_ID(37, "cdac"),
> +	CLK_MSR_ID(38, "vdin_meas"),
> +	CLK_MSR_ID(39, "bt656"),
> +	CLK_MSR_ID(40, "arm_ring_osc_out_4"),
> +	CLK_MSR_ID(41, "eth_rx_or_rmii"),
> +	CLK_MSR_ID(42, "mp0_out"),
> +	CLK_MSR_ID(43, "fclk_div5"),
> +	CLK_MSR_ID(44, "pwm_b"),
> +	CLK_MSR_ID(45, "pwm_a"),
> +	CLK_MSR_ID(46, "vpu"),
> +	CLK_MSR_ID(47, "ddr_dpll_pt"),
> +	CLK_MSR_ID(48, "mp1_out"),
> +	CLK_MSR_ID(49, "mp2_out"),
> +	CLK_MSR_ID(50, "mp3_out"),
> +	CLK_MSR_ID(51, "sd_emmc_c"),
> +	CLK_MSR_ID(52, "sd_emmc_b"),
> +	CLK_MSR_ID(53, "sd_emmc_a"),
> +	CLK_MSR_ID(54, "vpu_clkc"),
> +	CLK_MSR_ID(55, "vid_pll_div_out"),
> +	CLK_MSR_ID(56, "wave420l_a"),
> +	CLK_MSR_ID(57, "wave420l_c"),
> +	CLK_MSR_ID(58, "wave420l_b"),
> +	CLK_MSR_ID(59, "hcodec"),
> +	CLK_MSR_ID(60, "arm_ring_osc_out_5"),
> +	CLK_MSR_ID(61, "gpio_msr"),
> +	CLK_MSR_ID(62, "hevcb"),
> +	CLK_MSR_ID(63, "dsi_meas"),
> +	CLK_MSR_ID(64, "spicc_1"),
> +	CLK_MSR_ID(65, "spicc_0"),
> +	CLK_MSR_ID(66, "vid_lock"),
> +	CLK_MSR_ID(67, "dsi_phy"),
> +	CLK_MSR_ID(68, "hdcp22_esm"),
> +	CLK_MSR_ID(69, "hdcp22_skp"),
> +	CLK_MSR_ID(70, "pwm_f"),
> +	CLK_MSR_ID(71, "pwm_e"),
> +	CLK_MSR_ID(72, "pwm_d"),
> +	CLK_MSR_ID(73, "pwm_c"),
> +	CLK_MSR_ID(74, "arm_ring_osc_out_6"),
> +	CLK_MSR_ID(75, "hevcf"),
> +	CLK_MSR_ID(76, "arm_ring_osc_out_7"),
> +	CLK_MSR_ID(77, "rng_ring_osc_0"),
> +	CLK_MSR_ID(78, "rng_ring_osc_1"),
> +	CLK_MSR_ID(79, "rng_ring_osc_2"),
> +	CLK_MSR_ID(80, "rng_ring_osc_3"),
> +	CLK_MSR_ID(81, "vapb"),
> +	CLK_MSR_ID(82, "ge2d"),
> +	CLK_MSR_ID(83, "co_rx"),
> +	CLK_MSR_ID(84, "co_tx"),
> +	CLK_MSR_ID(85, "arm_ring_osc_out_8"),
> +	CLK_MSR_ID(86, "arm_ring_osc_out_9"),
> +	CLK_MSR_ID(87, "mipi_dsi_phy"),
> +	CLK_MSR_ID(88, "cis2_adapt"),
> +	CLK_MSR_ID(89, "hdmi_todig"),
> +	CLK_MSR_ID(90, "hdmitx_sys"),
> +	CLK_MSR_ID(91, "nna_core"),
> +	CLK_MSR_ID(92, "nna_axi"),
> +	CLK_MSR_ID(93, "vad"),
> +	CLK_MSR_ID(94, "eth_phy_rx"),
> +	CLK_MSR_ID(95, "eth_phy_pll"),
> +	CLK_MSR_ID(96, "vpu_b"),
> +	CLK_MSR_ID(97, "cpu_b_tmp"),
> +	CLK_MSR_ID(98, "ts"),
> +	CLK_MSR_ID(99, "arm_ring_osc_out_10"),
> +	CLK_MSR_ID(100, "arm_ring_osc_out_11"),
> +	CLK_MSR_ID(101, "arm_ring_osc_out_12"),
> +	CLK_MSR_ID(102, "arm_ring_osc_out_13"),
> +	CLK_MSR_ID(103, "arm_ring_osc_out_14"),
> +	CLK_MSR_ID(104, "arm_ring_osc_out_15"),
> +	CLK_MSR_ID(105, "arm_ring_osc_out_16"),
> +	CLK_MSR_ID(106, "ephy_test"),
> +	CLK_MSR_ID(107, "au_dac_g128x"),
> +	CLK_MSR_ID(108, "audio_locker_out"),
> +	CLK_MSR_ID(109, "audio_locker_in"),
> +	CLK_MSR_ID(110, "audio_tdmout_c_sclk"),
> +	CLK_MSR_ID(111, "audio_tdmout_b_sclk"),
> +	CLK_MSR_ID(112, "audio_tdmout_a_sclk"),
> +	CLK_MSR_ID(113, "audio_tdmin_lb_sclk"),
> +	CLK_MSR_ID(114, "audio_tdmin_c_sclk"),
> +	CLK_MSR_ID(115, "audio_tdmin_b_sclk"),
> +	CLK_MSR_ID(116, "audio_tdmin_a_sclk"),
> +	CLK_MSR_ID(117, "audio_resample"),
> +	CLK_MSR_ID(118, "audio_pdm_sys"),
> +	CLK_MSR_ID(119, "audio_spdifout_b"),
> +	CLK_MSR_ID(120, "audio_spdifout"),
> +	CLK_MSR_ID(121, "audio_spdifin"),
> +	CLK_MSR_ID(122, "audio_pdm_dclk"),
> +	CLK_MSR_ID(123, "audio_resampled"),
> +	CLK_MSR_ID(124, "earcrx_pll"),
> +	CLK_MSR_ID(125, "earcrx_pll_test"),
> +	CLK_MSR_ID(126, "csi_phy0"),
> +	CLK_MSR_ID(127, "csi2_data"),
> +};
> +
> +static int meson_clk_msr_measure_id(struct meson_msr *priv, unsigned int id,
> +				    unsigned int duration)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	regmap_write(priv->regmap, MSR_CLK_REG0, 0);
> +
> +	/* Set measurement duration */
> +	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_DURATION,
> +			   FIELD_PREP(MSR_DURATION, duration - 1));
> +
> +	/* Set ID */
> +	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_SRC,
> +			   FIELD_PREP(MSR_CLK_SRC, id));
> +
> +	/* Enable & Start */
> +	regmap_update_bits(priv->regmap, MSR_CLK_REG0,
> +			   MSR_RUN | MSR_ENABLE,
> +			   MSR_RUN | MSR_ENABLE);
> +
> +	ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
> +				       val, !(val & MSR_BUSY), 10, 10000);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable */
> +	regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
> +
> +	/* Get the value in multiple of gate time counts */
> +	regmap_read(priv->regmap, MSR_CLK_REG2, &val);
> +
> +	if (val >= MSR_VAL_MASK)
> +		return -EINVAL;
> +
> +	return DIV_ROUND_CLOSEST_ULL((val & MSR_VAL_MASK) * 1000000ULL,
> +				     duration);
> +}
> +
> +static int meson_clk_msr_best_id(struct meson_msr *priv, unsigned int id,
> +				 unsigned int *precision)
> +{
> +	unsigned int duration = DIV_MAX;
> +	int ret;
> +
> +	/* Start from max duration and down to min duration */
> +	do {
> +		ret = meson_clk_msr_measure_id(priv, id, duration);
> +		if (ret >= 0)
> +			*precision = (2 * 1000000) / duration;
> +		else
> +			duration -= DIV_STEP;
> +	} while (duration >= DIV_MIN && ret == -EINVAL);
> +
> +	return ret;
> +}
> +
> +static void meson_clk_msr_dump(struct udevice *dev)
> +{
> +	struct meson_msr *priv = dev_get_priv(dev);
> +	unsigned int precision = 0;
> +	int val, i;
> +
> +	printf("  clock                     rate    precision\n");
> +	printf("---------------------------------------------\n");
> +
> +	for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
> +		if (!priv->msr_table[i].name)
> +			continue;
> +
> +		val = meson_clk_msr_best_id(priv, i, &precision);
> +		if (val < 0)
> +			return;
> +
> +		printf(" %-20s %10d    +/-%dHz\n",
> +		       priv->msr_table[i].name, val, precision);
> +	}
> +}

To confirm, this is based on [1], right?

[1] https://patchwork.ozlabs.org/project/uboot/cover/20231109105516.24892-1-ivprusov@sberdevices.ru/

> +static int meson_clk_msr_xlate(struct clk *clk, struct ofnode_phandle_args *args)
> +{
> +	/* This driver doesn't expose any clocks */
> +	return -EINVAL;
> +}
> +
> +static int meson_clk_msr_probe(struct udevice *dev)
> +{
> +	struct meson_msr *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	priv->msr_table = (struct meson_msr_id *)dev_get_driver_data(dev);
> +
> +	ret = regmap_init_mem(dev_ofnode(dev), &priv->regmap);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct clk_ops meson_clk_msr_ops = {
> +	.of_xlate = meson_clk_msr_xlate,
> +	.dump = meson_clk_msr_dump,
> +};
> +
> +static const struct udevice_id meson_clk_msr_ids[] = {
> +	{
> +		.compatible = "amlogic,meson-gx-clk-measure",
> +		.data = (ulong)clk_msr_gx,
> +	},
> +	{
> +		.compatible = "amlogic,meson8-clk-measure",
> +		.data = (ulong)clk_msr_m8,
> +	},
> +	{
> +		.compatible = "amlogic,meson8b-clk-measure",
> +		.data = (ulong)clk_msr_m8,
> +	},
> +	{
> +		.compatible = "amlogic,meson-axg-clk-measure",
> +		.data = (ulong)clk_msr_axg,
> +	},
> +	{
> +		.compatible = "amlogic,meson-g12a-clk-measure",
> +		.data = (ulong)clk_msr_g12a,
> +	},
> +	{
> +		.compatible = "amlogic,meson-sm1-clk-measure",
> +		.data = (ulong)clk_msr_sm1,
> +	},
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(meson_clk_msr) = {
> +	.name		= "meson_clk_msr",
> +	.id		= UCLASS_CLK,
> +	.of_match	= meson_clk_msr_ids,
> +	.priv_auto	= sizeof(struct meson_msr),
> +	.ops		= &meson_clk_msr_ops,
> +	.probe		= meson_clk_msr_probe,
> +};
> 
> ---
> base-commit: e1b7717928eff69178604a400fe40dbf3287d9a1
> change-id: 20231113-uboot-meson-clk-msr-21cf9101278b
> 
> Best regards,

With the commit/kconfig message expanded a bit,

Reviewed-by: Sean Anderson <seanga2@gmail.com>

