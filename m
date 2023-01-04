Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.10820.1672835655846889620
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Jan 2023 04:34:16 -0800
Received: by mail-wm1-f44.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso24087728wmb.3
        for <u-boot-amlogic@groups.io>; Wed, 04 Jan 2023 04:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmsmCGtIeg6H68KA/couuMIRvAAN8NUE89N3BR/FyxI=;
        b=M/rs5PqNkJNzbsrahbXtHzk46oLL3z+QQhf7ApG7glEtXZOAoRKUoBfBh+6f/5CO29
         I7MDg/Ljbqc0LCtjK1X1IwxF3Ci2bXzQa1EZh0PfSUS7CnAR6nRuQm7xkkM9Ih8pmMGq
         hhTIRcmLTH09l8B9TVT3T92gfNJ9TpT75384xpFAzvwGIAFW9vcOIDUqq/XvDT0ek1tH
         3PwJ3HyCS+cck0ehYUcsdHegYkr5Ob4gSKDQgaxQkdNq+dV3R3PSt6ccVPd1MjUWpqc2
         8qfvWQt5JBRw/s7OrJzD+Sp8M9tLJHvwF1biMFR7VLWCY2vzPFyvrnd2Gg0fL12IoUfy
         imNQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <3e72aa39-6830-a694-7272-eaa4f206f8b6@linaro.org>
Date: Wed, 4 Jan 2023 13:34:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/5] arm/mach-meson: move smc commands in cmd/meson
References: <20221222125727.47893-1-avromanov@sberdevices.ru>
 <20221222125727.47893-3-avromanov@sberdevices.ru>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20221222125727.47893-3-avromanov@sberdevices.ru>
Content-Language: fr
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, avromanov@sberdevices.ru, narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Le 22/12/2022 à 13:57, Alexey Romanov via groups.io a écrit :
> It is incorrect to keep commands in the arch/ folder.
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   MAINTAINERS              |   1 +
>   arch/arm/mach-meson/sm.c | 144 ------------------------------------
>   cmd/Kconfig              |   7 ++
>   cmd/Makefile             |   3 +
>   cmd/meson/Makefile       |   5 ++
>   cmd/meson/sm.c           | 156 +++++++++++++++++++++++++++++++++++++++
>   6 files changed, 172 insertions(+), 144 deletions(-)
>   create mode 100644 cmd/meson/Makefile
>   create mode 100644 cmd/meson/sm.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f27ff4c20f..7a5460d4922 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -149,6 +149,7 @@ L:	u-boot-amlogic@groups.io
>   T:	git https://source.denx.de/u-boot/custodians/u-boot-amlogic.git
>   F:	arch/arm/mach-meson/
>   F:	arch/arm/include/asm/arch-meson/
> +F:	cmd/meson/
>   F:	drivers/clk/meson/
>   F:	drivers/serial/serial_meson.c
>   F:	drivers/reset/reset-meson.c
> diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
> index d6eb910689f..f2ca7e76932 100644
> --- a/arch/arm/mach-meson/sm.c
> +++ b/arch/arm/mach-meson/sm.c
> @@ -6,8 +6,6 @@
>    */
>   
>   #include <common.h>
> -#include <command.h>
> -#include <env.h>
>   #include <log.h>
>   #include <asm/arch/sm.h>
>   #include <asm/cache.h>
> @@ -139,145 +137,3 @@ int meson_sm_get_reboot_reason(void)
>   	/* The SMC call is not used, we directly use AO_SEC_SD_CFG15 */
>   	return FIELD_GET(REBOOT_REASON_MASK, reason);
>   }
> -
> -static int do_sm_serial(struct cmd_tbl *cmdtp, int flag, int argc,
> -			char *const argv[])
> -{
> -	ulong address;
> -	int ret;
> -
> -	if (argc < 2)
> -		return CMD_RET_USAGE;
> -
> -	address = simple_strtoul(argv[1], NULL, 0);
> -
> -	ret = meson_sm_get_serial((void *)address, SM_CHIP_ID_SIZE);
> -	if (ret)
> -		return CMD_RET_FAILURE;
> -
> -	return CMD_RET_SUCCESS;
> -}
> -
> -#define MAX_REBOOT_REASONS 14
> -
> -static const char *reboot_reasons[MAX_REBOOT_REASONS] = {
> -	[REBOOT_REASON_COLD] = "cold_boot",
> -	[REBOOT_REASON_NORMAL] = "normal",
> -	[REBOOT_REASON_RECOVERY] = "recovery",
> -	[REBOOT_REASON_UPDATE] = "update",
> -	[REBOOT_REASON_FASTBOOT] = "fastboot",
> -	[REBOOT_REASON_SUSPEND_OFF] = "suspend_off",
> -	[REBOOT_REASON_HIBERNATE] = "hibernate",
> -	[REBOOT_REASON_BOOTLOADER] = "bootloader",
> -	[REBOOT_REASON_SHUTDOWN_REBOOT] = "shutdown_reboot",
> -	[REBOOT_REASON_RPMBP] = "rpmbp",
> -	[REBOOT_REASON_CRASH_DUMP] = "crash_dump",
> -	[REBOOT_REASON_KERNEL_PANIC] = "kernel_panic",
> -	[REBOOT_REASON_WATCHDOG_REBOOT] = "watchdog_reboot",
> -};
> -
> -static int do_sm_reboot_reason(struct cmd_tbl *cmdtp, int flag, int argc,
> -			       char *const argv[])
> -{
> -	const char *reason_str;
> -	char *destarg = NULL;
> -	int reason;
> -
> -	if (argc > 1)
> -		destarg = argv[1];
> -
> -	reason = meson_sm_get_reboot_reason();
> -	if (reason < 0)
> -		return CMD_RET_FAILURE;
> -
> -	if (reason >= MAX_REBOOT_REASONS ||
> -	    !reboot_reasons[reason])
> -		reason_str = "unknown";
> -	else
> -		reason_str = reboot_reasons[reason];
> -
> -	if (destarg)
> -		env_set(destarg, reason_str);
> -	else
> -		printf("reboot reason: %s (%x)\n", reason_str, reason);
> -
> -	return CMD_RET_SUCCESS;
> -}
> -
> -static int do_efuse_read(struct cmd_tbl *cmdtp, int flag, int argc,
> -			char *const argv[])
> -{
> -	ulong address, offset, size;
> -	int ret;
> -
> -	if (argc < 4)
> -		return CMD_RET_USAGE;
> -
> -        offset = simple_strtoul(argv[1], NULL, 0);
> -        size = simple_strtoul(argv[2], NULL, 0);
> -
> -        address = simple_strtoul(argv[3], NULL, 0);
> -
> -	ret = meson_sm_read_efuse(offset, (void *)address, size);
> -	if (ret != size)
> -		return CMD_RET_FAILURE;
> -
> -	return CMD_RET_SUCCESS;
> -}
> -
> -static int do_efuse_write(struct cmd_tbl *cmdtp, int flag, int argc,
> -			char *const argv[])
> -{
> -	ulong address, offset, size;
> -	int ret;
> -
> -	if (argc < 4)
> -		return CMD_RET_USAGE;
> -
> -        offset = simple_strtoul(argv[1], NULL, 0);
> -        size = simple_strtoul(argv[2], NULL, 0);
> -
> -        address = simple_strtoul(argv[3], NULL, 0);
> -
> -	ret = meson_sm_write_efuse(offset, (void *)address, size);
> -	if (ret != size)
> -		return CMD_RET_FAILURE;
> -
> -	return CMD_RET_SUCCESS;
> -}
> -
> -static struct cmd_tbl cmd_sm_sub[] = {
> -	U_BOOT_CMD_MKENT(serial, 2, 1, do_sm_serial, "", ""),
> -	U_BOOT_CMD_MKENT(reboot_reason, 1, 1, do_sm_reboot_reason, "", ""),
> -	U_BOOT_CMD_MKENT(efuseread, 4, 1, do_efuse_read, "", ""),
> -	U_BOOT_CMD_MKENT(efusewrite, 4, 0, do_efuse_write, "", ""),
> -};
> -
> -static int do_sm(struct cmd_tbl *cmdtp, int flag, int argc,
> -		 char *const argv[])
> -{
> -	struct cmd_tbl *c;
> -
> -	if (argc < 2)
> -		return CMD_RET_USAGE;
> -
> -	/* Strip off leading 'sm' command argument */
> -	argc--;
> -	argv++;
> -
> -	c = find_cmd_tbl(argv[0], &cmd_sm_sub[0], ARRAY_SIZE(cmd_sm_sub));
> -
> -	if (c)
> -		return c->cmd(cmdtp, flag, argc, argv);
> -	else
> -		return CMD_RET_USAGE;
> -}
> -
> -U_BOOT_CMD(
> -	sm, 5, 0, do_sm,
> -	"Secure Monitor Control",
> -	"serial <address> - read chip unique id to memory address\n"
> -	"sm reboot_reason [name] - get reboot reason and store to to environment\n"
> -	"sm efuseread <offset> <size> <address> - read efuse to memory address\n"
> -	"sm efusewrite <offset> <size> <address> - write into efuse from memory address"
> -);
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 09193b61b95..07833f958e7 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2565,4 +2565,11 @@ config MMC_SPEED_MODE_SET
>   	  and is indicated using the index from enum bus_mode in
>   	  include/mmc.h. A speed mode can be set only if it has already
>   	  been enabled in the device tree.
> +
> +config CMD_MESON
> +	bool "Amlogic Meson commands"
> +	depends on ARCH_MESON
> +	default y
> +	help
> +	  Enable useful commands for the Meson Soc family developed by Amlogic Inc.
>   endmenu
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 5e43a1e022e..146c5ebb227 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -210,6 +210,9 @@ obj-$(CONFIG_RISCV) += riscv/
>   obj-$(CONFIG_SANDBOX) += sandbox/
>   obj-$(CONFIG_X86) += x86/
>   
> +# Meson
> +obj-$(CONFIG_CMD_MESON) += meson/
> +
>   obj-$(CONFIG_ARCH_MVEBU) += mvebu/
>   endif # !CONFIG_SPL_BUILD
>   
> diff --git a/cmd/meson/Makefile b/cmd/meson/Makefile
> new file mode 100644
> index 00000000000..ee26c175cfe
> --- /dev/null
> +++ b/cmd/meson/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2022, SberDevices. All rights reserved.
> +
> +obj-y += sm.o
> diff --git a/cmd/meson/sm.c b/cmd/meson/sm.c
> new file mode 100644
> index 00000000000..c2b57707258
> --- /dev/null
> +++ b/cmd/meson/sm.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2016 Beniamino Galvani
> + *
> + * Author: Beniamino Galvani <b.galvani@gmail.com>
> + * Author: Vyacheslav Bocharov <adeep@lexina.in>
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include <command.h>
> +#include <common.h>
> +#include <env.h>
> +#include <asm/arch/sm.h>
> +#include <stdlib.h>
> +
> +static int do_sm_serial(struct cmd_tbl *cmdtp, int flag, int argc,
> +			char *const argv[])
> +{
> +	ulong address;
> +	int ret;
> +
> +	if (argc < 2)
> +		return CMD_RET_USAGE;
> +
> +	address = simple_strtoul(argv[1], NULL, 0);
> +
> +	ret = meson_sm_get_serial((void *)address, SM_SERIAL_SIZE);
> +	if (ret)
> +		return CMD_RET_FAILURE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +#define MAX_REBOOT_REASONS 14
> +
> +static const char *reboot_reasons[MAX_REBOOT_REASONS] = {
> +	[REBOOT_REASON_COLD] = "cold_boot",
> +	[REBOOT_REASON_NORMAL] = "normal",
> +	[REBOOT_REASON_RECOVERY] = "recovery",
> +	[REBOOT_REASON_UPDATE] = "update",
> +	[REBOOT_REASON_FASTBOOT] = "fastboot",
> +	[REBOOT_REASON_SUSPEND_OFF] = "suspend_off",
> +	[REBOOT_REASON_HIBERNATE] = "hibernate",
> +	[REBOOT_REASON_BOOTLOADER] = "bootloader",
> +	[REBOOT_REASON_SHUTDOWN_REBOOT] = "shutdown_reboot",
> +	[REBOOT_REASON_RPMBP] = "rpmbp",
> +	[REBOOT_REASON_CRASH_DUMP] = "crash_dump",
> +	[REBOOT_REASON_KERNEL_PANIC] = "kernel_panic",
> +	[REBOOT_REASON_WATCHDOG_REBOOT] = "watchdog_reboot",
> +};
> +
> +static int do_sm_reboot_reason(struct cmd_tbl *cmdtp, int flag, int argc,
> +			       char *const argv[])
> +{
> +	const char *reason_str;
> +	char *destarg = NULL;
> +	int reason;
> +
> +	if (argc > 1)
> +		destarg = argv[1];
> +
> +	reason = meson_sm_get_reboot_reason();
> +	if (reason < 0)
> +		return CMD_RET_FAILURE;
> +
> +	if (reason >= MAX_REBOOT_REASONS ||
> +	    !reboot_reasons[reason])
> +		reason_str = "unknown";
> +	else
> +		reason_str = reboot_reasons[reason];
> +
> +	if (destarg)
> +		env_set(destarg, reason_str);
> +	else
> +		printf("reboot reason: %s (%x)\n", reason_str, reason);
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +static int do_efuse_read(struct cmd_tbl *cmdtp, int flag, int argc,
> +			char *const argv[])
> +{
> +	ulong address, offset, size;
> +	int ret;
> +
> +	if (argc < 4)
> +		return CMD_RET_USAGE;
> +
> +	offset = simple_strtoul(argv[1], NULL, 0);
> +	size = simple_strtoul(argv[2], NULL, 0);
> +
> +	address = simple_strtoul(argv[3], NULL, 0);
> +
> +	ret = meson_sm_read_efuse(offset, (void *)address, size);
> +	if (ret != size)
> +		return CMD_RET_FAILURE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +static int do_efuse_write(struct cmd_tbl *cmdtp, int flag, int argc,
> +			char *const argv[])
> +{
> +	ulong address, offset, size;
> +	int ret;
> +
> +	if (argc < 4)
> +		return CMD_RET_USAGE;
> +
> +	offset = simple_strtoul(argv[1], NULL, 0);
> +	size = simple_strtoul(argv[2], NULL, 0);
> +
> +	address = simple_strtoul(argv[3], NULL, 0);
> +
> +	ret = meson_sm_write_efuse(offset, (void *)address, size);
> +	if (ret != size)
> +		return CMD_RET_FAILURE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +static struct cmd_tbl cmd_sm_sub[] = {
> +	U_BOOT_CMD_MKENT(serial, 2, 1, do_sm_serial, "", ""),
> +	U_BOOT_CMD_MKENT(reboot_reason, 1, 1, do_sm_reboot_reason, "", ""),
> +	U_BOOT_CMD_MKENT(efuseread, 4, 1, do_efuse_read, "", ""),
> +	U_BOOT_CMD_MKENT(efusewrite, 4, 0, do_efuse_write, "", ""),
> +};
> +
> +static int do_sm(struct cmd_tbl *cmdtp, int flag, int argc,
> +		 char *const argv[])
> +{
> +	struct cmd_tbl *c;
> +
> +	if (argc < 2)
> +		return CMD_RET_USAGE;
> +
> +	/* Strip off leading 'sm' command argument */
> +	argc--;
> +	argv++;
> +
> +	c = find_cmd_tbl(argv[0], &cmd_sm_sub[0], ARRAY_SIZE(cmd_sm_sub));
> +
> +	if (c)
> +		return c->cmd(cmdtp, flag, argc, argv);
> +	else
> +		return CMD_RET_USAGE;
> +}
> +
> +U_BOOT_CMD(
> +	sm, 5, 0, do_sm,
> +	"Secure Monitor Control",
> +	"serial <address> - read chip unique id to memory address\n"
> +	"sm reboot_reason [name] - get reboot reason and store to environment\n"
> +	"sm efuseread <offset> <size> <address> - read efuse to memory address\n"
> +	"sm efusewrite <offset> <size> <address> - write into efuse from memory address"
> +);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
