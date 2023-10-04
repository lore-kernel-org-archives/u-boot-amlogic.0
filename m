Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.22657.1696435238492392445
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Oct 2023 09:00:38 -0700
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-405361bb94eso24062965e9.0
        for <u-boot-amlogic@groups.io>; Wed, 04 Oct 2023 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696435237; x=1697040037; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsBGWuhWhDrzlY5Ar9QKF4+YnosDaZnkKurpFU/qcEg=;
        b=bBejiUBZ1WALZfLhgv2eCYmpfNTxSVKyuzThBWGZp1iIrqfRLq7Z91Z0FCqpU+vQGy
         zDRZspvplIdpZVjcY0tB0SK4lw4bRPL9RCGNXSvvGe7q4eLR4noGC8zbKxo0qzTed5eX
         L8AkjwD1/ENdaDJJ1oNyPnd8/iwn/FPrynpEB5AAYV1r5uBQXNhpeGbvDv9ajiPLC44s
         6vBujulItg0OLRUUDMPrsX6OsLMXRc5P1l0ZXct1WyH4N44Da4Rx5clN6Y81rwwYwRSS
         ddDg2lcL/am0RDI/+0Y2xK1NSmWeNktHbFwrHsRyGdSuIOENtjE/Xx1HU+FuxgCVgPgz
         gVdQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <7521ff4a-4e7f-48c2-be6e-c1489e5bfd19@linaro.org>
Date: Wed, 4 Oct 2023 18:00:34 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 6/8] drivers: introduce Meson Secure Monitor driver
References: <20230921081346.22157-1-avromanov@salutedevices.com>
 <20230921081346.22157-7-avromanov@salutedevices.com>
In-Reply-To: <20230921081346.22157-7-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sjg@google.com, takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org, post@lespocky.de, marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org, jh80.chung@samsung.com, paul.barker@sancloud.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Simon Glass <sjg@chromium.org>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 21/09/2023 10:13, Alexey Romanov wrote:
> This patch adds an implementation of the Meson Secure Monitor
> driver based on UCLASS_SM.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>   MAINTAINERS           |   1 +
>   drivers/sm/Kconfig    |   7 ++
>   drivers/sm/Makefile   |   1 +
>   drivers/sm/meson-sm.c | 198 ++++++++++++++++++++++++++++++++++++++++++
>   include/meson/sm.h    |  19 ++++
>   5 files changed, 226 insertions(+)
>   create mode 100644 drivers/sm/meson-sm.c
>   create mode 100644 include/meson/sm.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c64427782..bdc364fd4c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -158,6 +158,7 @@ F:	drivers/net/phy/meson-gxl.c
>   F:	drivers/adc/meson-saradc.c
>   F:	drivers/phy/meson*
>   F:	drivers/mmc/meson_gx_mmc.c
> +F:	drivers/sm/meson-sm.c
>   F:	drivers/spi/meson_spifc.c
>   F:	drivers/pinctrl/meson/
>   F:	drivers/power/domain/meson-gx-pwrc-vpu.c
> diff --git a/drivers/sm/Kconfig b/drivers/sm/Kconfig
> index 6cc6d55578..b4cc3f768e 100644
> --- a/drivers/sm/Kconfig
> +++ b/drivers/sm/Kconfig
> @@ -1,2 +1,9 @@
>   config SM
>   	bool "Enable Secure Monitor driver support"
> +
> +config MESON_SM
> +	bool "Amlogic Secure Monitor driver"
> +	depends on SM
> +	default n

I get:
WARNING: unmet direct dependencies detected for MESON_SM
   Depends on [n]: SM [=n]
   Selected by [y]:
   - MESON64_COMMON [=y] && ARM [=y] && ARCH_MESON [=y]


so I think this should be:
   select SM
instead of:
   depends on SM

Could you post a fix so I can send the PR ?

Neil


> +	help
> +	  Say y here to enable the Amlogic secure monitor driver.
> diff --git a/drivers/sm/Makefile b/drivers/sm/Makefile
> index af5f475c2b..da81ee898a 100644
> --- a/drivers/sm/Makefile
> +++ b/drivers/sm/Makefile
> @@ -2,3 +2,4 @@
>   
>   obj-y += sm-uclass.o
>   obj-$(CONFIG_SANDBOX) += sandbox-sm.o
> +obj-$(CONFIG_MESON_SM) += meson-sm.o
> diff --git a/drivers/sm/meson-sm.c b/drivers/sm/meson-sm.c
> new file mode 100644
> index 0000000000..25adaf4560
> --- /dev/null
> +++ b/drivers/sm/meson-sm.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 SberDevices, Inc.
> + *
> + * Author: Alexey Romanov <avromanov@salutedevices.com>
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <regmap.h>
> +#include <sm.h>
> +#include <sm-uclass.h>
> +#include <stdlib.h>
> +#include <syscon.h>
> +#include <asm/ptrace.h>
> +#include <asm/system.h>
> +#include <meson/sm.h>
> +#include <linux/bitfield.h>
> +#include <linux/err.h>
> +#include <linux/sizes.h>
> +
> +struct meson_sm_cmd {
> +	u32 smc_id;
> +};
> +
> +#define SET_CMD(index, id)	\
> +	[index] = {		\
> +		.smc_id = (id),	\
> +	}
> +
> +struct meson_sm_data {
> +	u32 cmd_get_shmem_in;
> +	u32 cmd_get_shmem_out;
> +	unsigned int shmem_size;
> +	struct meson_sm_cmd cmd[];
> +};
> +
> +struct meson_sm_priv {
> +	void *sm_shmem_in;
> +	void *sm_shmem_out;
> +	const struct meson_sm_data *data;
> +};
> +
> +static unsigned long __meson_sm_call(u32 cmd, const struct pt_regs *args)
> +{
> +	struct pt_regs r = *args;
> +
> +	r.regs[0] = cmd;
> +	smc_call(&r);
> +
> +	return r.regs[0];
> +};
> +
> +static u32 meson_sm_get_cmd(const struct meson_sm_data *data,
> +			    u32 cmd_index)
> +{
> +	struct meson_sm_cmd cmd;
> +
> +	if (cmd_index >= MESON_SMC_CMD_COUNT)
> +		return 0;
> +
> +	cmd = data->cmd[cmd_index];
> +	return cmd.smc_id;
> +}
> +
> +static int meson_sm_call(struct udevice *dev, u32 cmd_index, s32 *retval,
> +			 struct pt_regs *args)
> +{
> +	struct meson_sm_priv *priv = dev_get_priv(dev);
> +	u32 cmd, ret;
> +
> +	cmd = meson_sm_get_cmd(priv->data, cmd_index);
> +	if (!cmd)
> +		return -ENOENT;
> +
> +	ret = __meson_sm_call(cmd, args);
> +	if (retval)
> +		*retval = ret;
> +
> +	return 0;
> +}
> +
> +static int meson_sm_call_read(struct udevice *dev, void *buffer, size_t size,
> +			      u32 cmd_index, struct pt_regs *args)
> +{
> +	struct meson_sm_priv *priv = dev_get_priv(dev);
> +	s32 nbytes;
> +	int ret;
> +
> +	if (!buffer || size > priv->data->shmem_size)
> +		return -EINVAL;
> +
> +	ret = meson_sm_call(dev, cmd_index, &nbytes, args);
> +	if (ret)
> +		return ret;
> +
> +	if (nbytes < 0 || nbytes > size)
> +		return -ENOBUFS;
> +
> +	/* In some cases (for example GET_CHIP_ID command),
> +	 * SMC doesn't return the number of bytes read, even
> +	 * though the bytes were actually read into sm_shmem_out.
> +	 * So this check is needed.
> +	 */
> +	ret = nbytes;
> +	if (!nbytes)
> +		nbytes = size;
> +
> +	memcpy(buffer, priv->sm_shmem_out, nbytes);
> +
> +	return ret;
> +}
> +
> +static int meson_sm_call_write(struct udevice *dev, void *buffer, size_t size,
> +			       u32 cmd_index, struct pt_regs *args)
> +{
> +	struct meson_sm_priv *priv = dev_get_priv(dev);
> +	s32 nbytes;
> +	int ret;
> +
> +	if (!buffer || size > priv->data->shmem_size)
> +		return -EINVAL;
> +
> +	memcpy(priv->sm_shmem_in, buffer, size);
> +
> +	ret = meson_sm_call(dev, cmd_index, &nbytes, args);
> +	if (ret)
> +		return ret;
> +
> +	if (nbytes <= 0 || nbytes > size)
> +		return -EIO;
> +
> +	return nbytes;
> +}
> +
> +static int meson_sm_probe(struct udevice *dev)
> +{
> +	struct meson_sm_priv *priv = dev_get_priv(dev);
> +	struct pt_regs regs = { 0 };
> +
> +	priv->data = (struct meson_sm_data *)dev_get_driver_data(dev);
> +	if (!priv->data)
> +		return -EINVAL;
> +
> +	priv->sm_shmem_in =
> +		(void *)__meson_sm_call(priv->data->cmd_get_shmem_in, &regs);
> +
> +	if (!priv->sm_shmem_in)
> +		return -ENOMEM;
> +
> +	priv->sm_shmem_out =
> +		(void *)__meson_sm_call(priv->data->cmd_get_shmem_out, &regs);
> +
> +	if (!priv->sm_shmem_out)
> +		return -ENOMEM;
> +
> +	pr_debug("meson sm driver probed\n"
> +		 "shmem_in addr: 0x%p, shmem_out addr: 0x%p\n",
> +		 priv->sm_shmem_in,
> +		 priv->sm_shmem_out);
> +
> +	return 0;
> +}
> +
> +static const struct meson_sm_data meson_sm_gxbb_data = {
> +	.cmd_get_shmem_in  = 0x82000020,
> +	.cmd_get_shmem_out = 0x82000021,
> +	.shmem_size = SZ_4K,
> +	.cmd = {
> +		SET_CMD(MESON_SMC_CMD_EFUSE_READ,  0x82000030),
> +		SET_CMD(MESON_SMC_CMD_EFUSE_WRITE, 0x82000031),
> +		SET_CMD(MESON_SMC_CMD_CHIP_ID_GET, 0x82000044),
> +		SET_CMD(MESON_SMC_CMD_PWRDM_SET,   0x82000093),
> +	},
> +};
> +
> +static const struct udevice_id meson_sm_ids[] = {
> +	{
> +		.compatible = "amlogic,meson-gxbb-sm",
> +		.data = (ulong)&meson_sm_gxbb_data,
> +	},
> +	{ }
> +};
> +
> +static const struct sm_ops sm_ops = {
> +	.sm_call = meson_sm_call,
> +	.sm_call_read = meson_sm_call_read,
> +	.sm_call_write = meson_sm_call_write,
> +};
> +
> +U_BOOT_DRIVER(meson_sm) = {
> +	.name = "meson_sm",
> +	.id = UCLASS_SM,
> +	.of_match = meson_sm_ids,
> +	.probe = meson_sm_probe,
> +	.priv_auto = sizeof(struct meson_sm_priv),
> +	.ops = &sm_ops,
> +};
> diff --git a/include/meson/sm.h b/include/meson/sm.h
> new file mode 100644
> index 0000000000..fbaab1f1ee
> --- /dev/null
> +++ b/include/meson/sm.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2023 SberDevices, Inc.
> + *
> + * Author: Alexey Romanov <avromanov@salutedevices.com>
> + */
> +
> +#ifndef __MESON_SM_CMD_H__
> +#define __MESON_SM_CMD_H__
> +
> +enum meson_smc_cmd {
> +	MESON_SMC_CMD_EFUSE_READ,  /* read efuse memory */
> +	MESON_SMC_CMD_EFUSE_WRITE, /* write efuse memory */
> +	MESON_SMC_CMD_CHIP_ID_GET, /* readh chip unique id */
> +	MESON_SMC_CMD_PWRDM_SET,   /* do command at specified power domain */
> +	MESON_SMC_CMD_COUNT,
> +};
> +
> +#endif

