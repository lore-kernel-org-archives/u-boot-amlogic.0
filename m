Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241E3CAC581
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 16:54:09 +0000 (UTC)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
 by mx.groups.io with SMTP id smtpd.web10.1312.1757350444612667868
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Sep 2025 09:54:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=m06U+Frj;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.181, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757350441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xoaLtuKH5fNjX+ouJkpkgIf0EXpjE0xgMU/8sEdbAr4=;
	b=m06U+FrjuJ8s1dTuQfB32eW3UnWL2ybHnxU1M2LY3IDQTFYIvsmPLCuwqJQQXV8yyzqBgu
	hLkBx5VgtXJP/TNW+BpJcRDNgWGur8Jkh3I+ivaH4VUy0p9U8bJikfdiApDnDhvaVD4RjZ
	NnafAHJMjfAQGBGKvdA1Yx7WOp/LLGFwOiiZUaWTHmoVZesguWS16Kl2RTGCzMQEgWwvAu
	6JqrHo5Cm+hOp9VSro7MO1prIhbadHVq7hvpPzNH63wEHP8U1ZYNet/2N8GsRR6oruE3IA
	5L+csCSOQzGAq+3TlZs7vZgnDiFLFNCVkQjpYNygb7+1KGYzvKqqCfyQWkvpeg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 16:53:57 +0000
Message-Id: <DCNKQM04PWE0.35QSN1T1Z5CEZ@postmarketos.org>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH RFC 5/9] arm: meson: initial u-boot SPL support for GX
 SoCs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: <u-boot-amlogic@groups.io>, <neil.armstrong@linaro.org>, "Ferass El
 Hafidi" <funderscore@postmarketos.org>, "Tom Rini" <trini@konsulko.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Beniamino Galvani" <b.galvani@gmail.com>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-5-37395d9ff5af@postmarketos.org>
 <b6d9c116-f37d-4793-ba53-f94ed95130dd@linaro.org>
In-Reply-To: <b6d9c116-f37d-4793-ba53-f94ed95130dd@linaro.org>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Sep 2025 16:54:09 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2759

On Mon Sep 8, 2025 at 8:24 AM UTC, Neil Armstrong via groups.io wrote:
> On 07/09/2025 16:36, Ferass El Hafidi wrote:
>> Add initial boilerplate for U-Boot SPL support on Amlogic.
>>=20
>> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>> ---
>>   arch/arm/include/asm/arch-meson/clock-gx.h |   1 +
>>   arch/arm/include/asm/arch-meson/gx.h       |  36 ++++
>>   arch/arm/mach-meson/Kconfig                |  42 ++++-
>>   arch/arm/mach-meson/Makefile               |   5 +
>>   arch/arm/mach-meson/board-common.c         |  11 ++
>>   arch/arm/mach-meson/spl-gx.c               | 278 +++++++++++++++++++++=
++++++++
>>   arch/arm/mach-meson/spl.c                  | 123 +++++++++++++
>>   7 files changed, 495 insertions(+), 1 deletion(-)
>>=20
> <...>
>> diff --git a/arch/arm/mach-meson/spl-gx.c b/arch/arm/mach-meson/spl-gx.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..65b301bc9ed89b7ca2156b7f=
a672ed4ef3f8633b
>> --- /dev/null
>> +++ b/arch/arm/mach-meson/spl-gx.c
>> @@ -0,0 +1,278 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Portions Copyright (C) 2015, Amlogic, Inc. All rights reserved.
>> + * Copyright (C) 2023, Ferass El Hafidi <funderscore@postmarketos.org>
>> + */
>> +#include <hang.h>
>> +#include <image.h>
>> +#include <spl.h>
>> +#include <vsprintf.h>
>> +#include <asm/io.h>
>> +#include <asm/arch/boot.h>
>> +#include <asm/arch/clock-gx.h>
>> +#include <asm/arch/gx.h>
>> +#include <linux/delay.h>
>> +
>> +/* Meson GX SPL code */
>> +
>> +#if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
>> +#if defined(CONFIG_MESON_GXBB)
>
> I think you should indicate why it's only needed for GXBB
>

Sure!  I will also explain here to clarify.
Basically this is sending the SCP firmware (aka. bl30/bl301) to the SCP.
Historically (in GXBB) this was done by bl2.bin, but (to save space?) it
was moved to BL31 in GXL:

- https://git.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmware-a/+=
/refs/heads/master/plat/amlogic/gxl/gxl_bl31_setup.c#129

and BL2 would give image info for bl30/bl301 to BL31.  I patched this
upstream so we don't have to do that in SPL:

- https://git.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmware-a/+=
/refs/heads/master/plat/amlogic/gxl/gxl_bl31_setup.c#105

Whether we can move SCP fw loading to BL31 on GXBB is .. an interesting
thing that could be considered.  That way we could possibly also save
some space in U-Boot SPL.

>> +inline void send_scp(void *addr, size_t size, const uint8_t *sha2,
>> +	uint32_t sha2_length)
>> +{
>> +	int i;
>> +
>> +	puts("Trying to send the SCP firmware\n");
>> +	writel(size, GX_MB_SRAM_BASE);
>> +
>> +	udelay(500);
>> +
>> +	writel(GX_MB_CMD_DATA_LEN, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
>> +	while (readl(GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4))
>> +		;
>> +	udelay(500);
>> +
>> +	memcpy((void *)GX_MB_SRAM_BASE, (const void *)sha2, sha2_length);
>> +	writel(GX_MB_CMD_SHA, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
>> +	while (readl(GX_SEC_HIU_MAILBOX_STAT_0 + 3 * 3 * 4))
>> +		;
>> +	udelay(500);
>> +
>> +	for (i =3D 0; i < size; i +=3D 1024) {
>> +		if (size >=3D i + 1024)
>> +			memcpy((void *)GX_MB_SRAM_BASE,
>> +			       (const void *)(unsigned long)(addr + i), 1024);
>> +		else if (size > i)
>> +			memcpy((void *)GX_MB_SRAM_BASE,
>> +			       (const void *)(unsigned long)(addr + i), (size - i));
>> +
>> +		writel(GX_MB_CMD_DATA, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
>> +		while (readl(GX_SEC_HIU_MAILBOX_STAT_0 + 3 * 3 * 4))
>> +			;
>> +	}
>> +	writel(GX_MB_CMD_OP_SHA, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
>> +
>> +	while (readl(GX_SEC_HIU_MAILBOX_STAT_0 + 3 * 3 * 4))
>> +		;
>> +	udelay(500);
>> +
>> +	/* We transferred all of the SCP firmware. Running it */
>> +	writel(GX_MB_CMD_END, GX_SEC_HIU_MAILBOX_SET_0 + 3 * 3 * 4);
>> +}
>> +#endif
>> +
>> +void board_fit_image_post_process(const void *fit, int node, void **p_i=
mage, size_t *p_size)
>> +{
>> +#if defined(CONFIG_MESON_GXBB)
>> +	const char *name =3D fit_get_name(fit, node, NULL);
>> +	int noffset =3D 0, value_len;
>> +	u8 *value;
>> +
>> +	if (strcmp("scp", name) && strcmp("bl301", name))
>> +		return;
>> +
>> +	fdt_for_each_subnode(noffset, fit, node) {
>> +		if (strncmp(fit_get_name(fit, noffset, NULL),
>> +			    FIT_HASH_NODENAME, strlen(FIT_HASH_NODENAME)))
>> +			continue;
>> +
>> +		if (fit_image_hash_get_value(fit, noffset, &value, &value_len))
>> +			continue;
>> +
>> +		/* Send the SCP firmware to the SCP */
>> +		send_scp(*p_image, *p_size, value, value_len);
>> +		break;
>> +	}
>> +#endif
>> +}
>> +#endif
>> +
>> +inline void cpu_pll_switch_to(int mode)
>> +{
>> +	u32 reg;
>> +
>> +	reg =3D readl(GX_HIU_BASE + HHI_SYS_CPU_CLK_CNTL0);
>> +
>> +	while (reg & (1 << 28))
>> +		reg =3D readl(GX_HIU_BASE + HHI_SYS_CPU_CLK_CNTL0);
>> +
>> +	reg |=3D (1 << 26);
>> +
>> +	if (mode =3D=3D 1) {
>> +		/* Switch to System PLL */
>> +		reg |=3D (1 << 11);
>> +	} else {
>> +		if (reg & (1 << 10)) {
>> +			reg =3D (reg & ~((1 << 10) | (0x3f << 4) | (1 << 2) |
>> +				(0x3 << 0)));
>> +		} else {
>> +			reg =3D (reg & ~((1 << 10) | (0x3f << 20) |
>> +				(1 << 18) | (0x3 << 16))) | (1 << 10);
>> +		}
>> +		/* Select dynamic mux */
>> +		reg =3D reg & ~(1 << 11);
>> +	}
>> +	writel(reg, GX_HIU_BASE + HHI_SYS_CPU_CLK_CNTL0);
>
> I know it's a lot, but it would nbe mush better if you had defines
> for all those PLL register bits.
>
> Or perhaps you can use the `struct parm` & PARM_GET/PARM_SET from
> drivers/clk/meson/clk_meson.h to define and set all the PLL parameters
>

ACK.

>> +}
>> +
>> +int meson_pll_init(void)
>> +{
>> +	clrbits_32(GX_HIU_BASE + HHI_MPEG_CLK_CNTL, 1 << 8);
>> +	cpu_pll_switch_to(0);
>> +
>> +	setbits_32(GX_HIU_BASE + HHI_MPLL_CNTL6, 1 << 26);
>> +	udelay(100);
>> +
>> +	while (!((readl(GX_HIU_BASE + HHI_SYS_PLL_CNTL) >> 31) & 1)) {
>> +		if (IS_ENABLED(CONFIG_MESON_GXBB)) {
>> +			setbits_32(GX_HIU_BASE + HHI_SYS_PLL_CNTL, 1 << 29);
>> +			writel(0x5ac80000, GX_HIU_BASE + HHI_SYS_PLL_CNTL2);
>> +			writel(0x8e452015, GX_HIU_BASE + HHI_SYS_PLL_CNTL3);
>> +			writel(0x401d40c, GX_HIU_BASE + HHI_SYS_PLL_CNTL4);
>> +			writel(0x870, GX_HIU_BASE + HHI_SYS_PLL_CNTL5);
>> +			writel((1 << 30) | (1 << 29) |
>> +				((0 << 16) | (1 << 9) |
>> +				(1536 / 24)), /* 1.5 GHz */
>> +				GX_HIU_BASE + HHI_SYS_PLL_CNTL);
>> +			clrbits_32(GX_HIU_BASE + HHI_SYS_PLL_CNTL, 1 << 29);
>> +		} else if (IS_ENABLED(CONFIG_MESON_GXL)) {
>> +			writel(0xc4258100, GX_HIU_BASE + HHI_SYS_PLL_CNTL1);
>> +			writel(0xb7400000, GX_HIU_BASE + HHI_SYS_PLL_CNTL2);
>> +			writel(0xa59a288, GX_HIU_BASE + HHI_SYS_PLL_CNTL3);
>> +			writel(0x40002d, GX_HIU_BASE + HHI_SYS_PLL_CNTL4);
>> +			writel(0x7c700007, GX_HIU_BASE + HHI_SYS_PLL_CNTL5);
>> +			writel((1 << 30) | ((1 << 9) |
>> +				(1200 / 24)), /* 1.2 GHz */
>> +				GX_HIU_BASE + HHI_SYS_PLL_CNTL);
>> +		}
>> +		udelay(20);
>> +	}
>> +	cpu_pll_switch_to(1); /* Hook the CPU to the PLL divider output */
>> +
>> +	if (IS_ENABLED(CONFIG_MESON_GXBB))
>> +		writel(0x10007, GX_HIU_BASE + HHI_MPLL_CNTL4);
>> +	else if (IS_ENABLED(CONFIG_MESON_GXL))
>> +		writel(0x10006, GX_HIU_BASE + HHI_MPLL_CNTL4);
>> +
>> +	setbits_32(GX_HIU_BASE + HHI_MPLL_CNTL, 1 << 29);
>> +	udelay(200);
>> +
>> +	writel(0x59C80000, GX_HIU_BASE + HHI_MPLL_CNTL2);
>> +	writel(0xCA45B822, GX_HIU_BASE + HHI_MPLL_CNTL3);
>> +
>> +	if (IS_ENABLED(CONFIG_MESON_GXBB))
>> +		writel(0xB5500E1A, GX_HIU_BASE + HHI_MPLL_CNTL5);
>> +	else if (IS_ENABLED(CONFIG_MESON_GXL))
>> +		writel(0x95520E1A, GX_HIU_BASE + HHI_MPLL_CNTL5);
>> +
>> +	writel(0xFC454545, GX_HIU_BASE + HHI_MPLL_CNTL6);
>> +
>> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
>> +		writel((1 << 30) | (1 << 29) | (3 << 9) | (250 << 0), GX_HIU_BASE + H=
HI_MPLL_CNTL);
>> +		clrbits_32(GX_HIU_BASE + HHI_MPLL_CNTL, 1 << 29);
>> +	} else if (IS_ENABLED(CONFIG_MESON_GXL)) {
>> +		writel((1 << 30) | (3 << 9) | (250 << 0), GX_HIU_BASE + HHI_MPLL_CNTL=
);
>> +	}
>> +	udelay(800);
>> +
>> +	setbits_32(GX_HIU_BASE + HHI_MPLL_CNTL4, 1 << 14);
>> +
>> +	while (!((readl(GX_HIU_BASE + HHI_MPLL_CNTL) >> 31) & 1)) {
>> +		if ((readl(GX_HIU_BASE + HHI_MPLL_CNTL) & (1 << 31)) !=3D 0)
>> +			break;
>> +		setbits_32(GX_HIU_BASE + HHI_MPLL_CNTL, 1 << 29);
>> +		udelay(1000);
>> +		clrbits_32(GX_HIU_BASE + HHI_MPLL_CNTL, 1 << 29);
>> +		udelay(1000);
>> +	}
>> +
>> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
>> +		writel(0xFFF << 16, GX_HIU_BASE + HHI_MPLL_CNTL10);
>> +		writel(((7 << 16) | (1 << 15) | (1 << 14) | (4681 << 0)),
>> +		       GX_HIU_BASE + HHI_MPLL_CNTL7);
>> +		writel(((readl(GX_HIU_BASE + HHI_MPEG_CLK_CNTL) & (~((0x7 << 12) | (1=
 << 7) |
>> +			(0x7F << 0)))) | ((5 << 12) | (1 << 7)	| (2 << 0))),
>> +			GX_HIU_BASE + HHI_MPEG_CLK_CNTL);
>> +		setbits_32(GX_HIU_BASE + HHI_MPEG_CLK_CNTL, 1 << 8);
>> +		writel(((5 << 16) | (1 << 15) | (1 << 14) | (12524 << 0)),
>> +		       GX_HIU_BASE + HHI_MPLL_CNTL8);
>> +	} else if (IS_ENABLED(CONFIG_MESON_GXL)) {
>> +		writel((1 << 12) | 3, GX_HIU_BASE + HHI_MPLL_CNTL10);
>> +		writel(0x5edb7, GX_HIU_BASE + HHI_MPLL_CNTL7);
>> +		clrbits_32(GX_HIU_BASE + HHI_MPEG_CLK_CNTL,
>> +			   (3 << 13) | (1 << 12) | (15 << 4) | 15);
>> +		setbits_32(GX_HIU_BASE + HHI_MPEG_CLK_CNTL,
>> +			   (1 << 14) | (1 << 12) | (1 << 8) | (2 << 6) | (1 << 1));
>> +		writel((4 << 16) | (7 << 13) | (1 << 8) | (5 << 4) | 10,
>> +		       GX_HIU_BASE + HHI_MPLL_CNTL8);
>> +	}
>> +
>> +	udelay(200);
>> +
>> +	/* TODO: Some error handling and timeouts... */
>> +	return 0;
>> +}
>> +
> <...>
>> +void meson_power_init(void)
>> +{
>> +	/* TODO: Support more voltages */
>> +
>> +	/* Init PWM B */
>> +	clrsetbits_32(GX_PWM_MISC_REG_AB, 0x7f << 16, (1 << 23) | (1 << 1));
>> +
>> +	/* Set voltage */
>> +	if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1120MV))
>> +		writel(0x02001a, GX_PWM_PWM_B);
>> +	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1100MV))
>> +		writel(0x040018, GX_PWM_PWM_B);
>> +	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1000MV))
>> +		writel(0x0e000e, GX_PWM_PWM_B);
>> +
>> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
>> +		clrbits_32(GX_PIN_MUX_REG7, 1 << 22);
>> +		clrsetbits_32(GX_PIN_MUX_REG3, 1 << 22, 1 << 21);
>> +	} else {
>> +		clrbits_32(GX_PIN_MUX_REG1, 1 << 10);
>> +		clrsetbits_32(GX_PIN_MUX_REG2, 1 << 5, 1 << 11);
>> +	}
>> +
>> +	/* Init PWM D */
>> +	clrsetbits_32(GX_PWM_MISC_REG_CD, 0x7f << 16, (1 << 23) | (1 << 1));
>> +
>> +	/* Set voltage */
>> +	if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1100MV))
>> +		writel(0x040018, GX_PWM_PWM_B);
>> +	else if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1000MV))
>> +		writel(0x0e000e, GX_PWM_PWM_B);
>> +
>> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
>> +		clrbits_32(GX_PIN_MUX_REG7, 1 << 23);
>> +		setbits_32(GX_PIN_MUX_REG3, 1 << 20);
>> +	} else {
>> +		clrbits_32(GX_PIN_MUX_REG1, (1 << 9) | (1 << 11));
>> +		setbits_32(GX_PIN_MUX_REG2, 1 << 12);
>> +	}
>> +}
>
> Seems much of the code is duplicated between GXBB and GXL, so I wonder if=
 it would'nt
> be cleaner to have spl-gxbb an spl-gxl ?
>

You mean separate power init functions (meson_power_init_gxbb/gxl)?  Should=
 be doable.

> <...>
>
> Anyway it's really clean !
>
> Thanks!
> Neil
>

Thank you!

>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2757): https://groups.io/g/u-boot-amlogic/message/275=
7
> Mute This Topic: https://groups.io/mt/115113902/8399868
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [funderscore@postma=
rketos.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


