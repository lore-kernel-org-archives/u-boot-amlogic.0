Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.10193.1685526430558969095
 for <u-boot-amlogic@groups.io>;
 Wed, 31 May 2023 02:47:10 -0700
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f6e68cc738so41906895e9.1
        for <u-boot-amlogic@groups.io>; Wed, 31 May 2023 02:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685526429; x=1688118429;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wHWRhy6BNhG6dAXWIFsspVEt+Wx6Zu/ghGzxeGPArUk=;
        b=QvnUp49ed5fL8Lw+q4iYIMKncasKm823eKCyhxA6YixgHZPeLQjUykuxPnf+HO4HaW
         mgOnSrbU0KACd8WaOBxS1wAnphLjzXUaj+N2cD1VsS5jOfi8T/70pGSHIssuwXGPY+hX
         wfIeU1YICPT0zLDoXlrvwoYPKiWVEr+LT4xiZv9H8XqO+mhzqg7So/eSCa1QNS6f8otO
         u2I8mRJxQcWKj1XNgl8LG4TfsOSMcYQ1iRaBxnPQfuoLGbuuXNh2aS11KTIMsAlXnxoK
         bOikUc1ESIPqU5u9BkmGoRVqXzm/j5pubbRX6ByvWomTp5yyyg0LtyqBi8CRpU1w3AUP
         shVA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <9f2bc2ad-fe29-1e3a-3ad3-c8d6304041fb@linaro.org>
Date: Wed, 31 May 2023 11:47:08 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/3] drivers: meson: introduce secure power controller driver
References: <20230531093156.29240-1-avromanov@sberdevices.ru>
 <20230531093156.29240-4-avromanov@sberdevices.ru>
In-Reply-To: <20230531093156.29240-4-avromanov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@sberdevices.ru>, jh80.chung@samsung.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 31/05/2023 11:31, Alexey Romanov wrote:
> This patch adds Power controller driver support for Amlogic
> A1 family using secure monitor calls. The power domains register
> only can access in secure world.
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>   drivers/power/domain/Kconfig             |   7 +
>   drivers/power/domain/Makefile            |   1 +
>   drivers/power/domain/meson-secure-pwrc.c | 160 +++++++++++++++++++++++
>   3 files changed, 168 insertions(+)
>   create mode 100644 drivers/power/domain/meson-secure-pwrc.c
> 
> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
> index 7e1b8c072fa..411c210756a 100644
> --- a/drivers/power/domain/Kconfig
> +++ b/drivers/power/domain/Kconfig
> @@ -68,6 +68,13 @@ config MESON_EE_POWER_DOMAIN
>   	  Enable support for manipulating Amlogic Meson Everything-Else power
>   	  domains.
>   
> +config MESON_SECURE_POWER_DOMAIN
> +	bool "Enable Amlogic Secure power domain driver"
> +	depends on POWER_DOMAIN && ARCH_MESON && MESON_A1
> +	help
> +	  Enable support for manipulating Amlogic Meson Secure power domains.
> +	  Support for Amlogic A1 series.
> +
>   config SANDBOX_POWER_DOMAIN
>   	bool "Enable the sandbox power domain test driver"
>   	depends on POWER_DOMAIN && SANDBOX
> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
> index e6244776216..aa5a4ba57cd 100644
> --- a/drivers/power/domain/Makefile
> +++ b/drivers/power/domain/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_IMX8MP_HSIOMIX_BLKCTRL) += imx8mp-hsiomix.o
>   obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
>   obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
>   obj-$(CONFIG_MESON_EE_POWER_DOMAIN) += meson-ee-pwrc.o
> +obj-$(CONFIG_MESON_SECURE_POWER_DOMAIN) += meson-secure-pwrc.o
>   obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain.o
>   obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain-test.o
>   obj-$(CONFIG_TEGRA186_POWER_DOMAIN) += tegra186-power-domain.o
> diff --git a/drivers/power/domain/meson-secure-pwrc.c b/drivers/power/domain/meson-secure-pwrc.c
> new file mode 100644
> index 00000000000..f70f8e02423
> --- /dev/null
> +++ b/drivers/power/domain/meson-secure-pwrc.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 SberDevices, Inc.
> + * Author: Alexey Romanov <avromanov@sberdevices.ru>
> + */
> +
> +#include <dm.h>
> +#include <asm/arch/sm.h>
> +#include <power-domain.h>
> +#include <power-domain-uclass.h>
> +#include <dt-bindings/power/meson-a1-power.h>
> +
> +struct meson_secure_pwrc_domain_desc {
> +	char *name;
> +	size_t index;
> +};
> +
> +struct meson_secure_pwrc_domain_data {
> +	unsigned int count;
> +	struct meson_secure_pwrc_domain_desc *domains;
> +};
> +
> +struct meson_secure_pwrc_priv {
> +	const struct meson_secure_pwrc_domain_data *data;
> +};
> +
> +static int meson_secure_pwrc_on(struct power_domain *power_domain)
> +{
> +	struct meson_secure_pwrc_priv *priv = dev_get_priv(power_domain->dev);
> +	struct meson_secure_pwrc_domain_desc *pwrc_domain;
> +	int err;
> +
> +	pwrc_domain = &priv->data->domains[power_domain->id];
> +
> +	err = meson_sm_pwrdm_on(pwrc_domain->index);
> +	if (err) {
> +		pr_err("meson_sm_pwrdm_on() failed (%d)\n", err);
> +		return err;
> +	}
> +
> +	pr_debug("enable %s power domain\n", pwrc_domain->name);
> +
> +	return 0;
> +}
> +
> +static int meson_secure_pwrc_off(struct power_domain *power_domain)
> +{
> +	struct meson_secure_pwrc_priv *priv = dev_get_priv(power_domain->dev);
> +	struct meson_secure_pwrc_domain_desc *pwrc_domain;
> +	int err;
> +
> +	pwrc_domain = &priv->data->domains[power_domain->id];
> +
> +	err = meson_sm_pwrdm_off(pwrc_domain->index);
> +	if (err) {
> +		pr_err("meson_sm_pwrdm_off() failed (%d)\n", err);
> +		return err;
> +	}
> +
> +	pr_debug("disable %s power domain\n", pwrc_domain->name);
> +
> +	return 0;
> +}
> +
> +static int meson_secure_pwrc_of_xlate(struct power_domain *power_domain,
> +				  struct ofnode_phandle_args *args)
> +{
> +	struct meson_secure_pwrc_priv *priv = dev_get_priv(power_domain->dev);
> +	struct meson_secure_pwrc_domain_desc *pwrc_domain;
> +
> +	if (args->args_count < 1) {
> +		pr_err("invalid args count: %d\n", args->args_count);
> +		return -EINVAL;
> +	}
> +
> +	power_domain->id = args->args[0];
> +
> +	if (power_domain->id >= priv->data->count) {
> +		pr_err("domain with ID=%lu is invalid\n", power_domain->id);
> +		return -EINVAL;
> +	}
> +
> +	pwrc_domain = &priv->data->domains[power_domain->id];
> +
> +	if (!pwrc_domain->name) {
> +		pr_err("domain with ID=%lu is invalid\n", power_domain->id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +#define SEC_PD(__name)			\
> +[PWRC_##__name##_ID] =			\
> +{					\
> +	.name = #__name,		\
> +	.index = PWRC_##__name##_ID,	\
> +}
> +
> +static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
> +	SEC_PD(DSPA),
> +	SEC_PD(DSPB),
> +	SEC_PD(UART),
> +	SEC_PD(DMC),
> +	SEC_PD(I2C),
> +	SEC_PD(PSRAM),
> +	SEC_PD(ACODEC),
> +	SEC_PD(AUDIO),
> +	SEC_PD(OTP),
> +	SEC_PD(DMA),
> +	SEC_PD(SD_EMMC),
> +	SEC_PD(RAMA),
> +	SEC_PD(RAMB),
> +	SEC_PD(IR),
> +	SEC_PD(SPICC),
> +	SEC_PD(SPIFC),
> +	SEC_PD(USB),
> +	SEC_PD(NIC),
> +	SEC_PD(PDMIN),
> +	SEC_PD(RSA),
> +};
> +
> +struct power_domain_ops meson_secure_pwrc_ops = {
> +	.on = meson_secure_pwrc_on,
> +	.off = meson_secure_pwrc_off,
> +	.of_xlate = meson_secure_pwrc_of_xlate,
> +};
> +
> +static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
> +	.count = ARRAY_SIZE(a1_pwrc_domains),
> +	.domains = a1_pwrc_domains,
> +};
> +
> +static const struct udevice_id meson_secure_pwrc_ids[] = {
> +	{
> +		.compatible = "amlogic,meson-a1-pwrc",
> +		.data = (unsigned long)&meson_secure_a1_pwrc_data,
> +	},
> +	{ }
> +};
> +
> +static int meson_secure_pwrc_probe(struct udevice *dev)
> +{
> +	struct meson_secure_pwrc_priv *priv = dev_get_priv(dev);
> +
> +	priv->data = (void *)dev_get_driver_data(dev);
> +	if (!priv->data)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +U_BOOT_DRIVER(meson_secure_pwrc) = {
> +	.name = "meson_secure_pwrc",
> +	.id = UCLASS_POWER_DOMAIN,
> +	.of_match = meson_secure_pwrc_ids,
> +	.probe = meson_secure_pwrc_probe,
> +	.ops = &meson_secure_pwrc_ops,
> +	.priv_auto = sizeof(struct meson_secure_pwrc_priv),
> +};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
