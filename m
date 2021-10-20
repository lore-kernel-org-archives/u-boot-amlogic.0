Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web09.8643.1634739833801498021
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Oct 2021 07:23:54 -0700
Received: by mail-wm1-f41.google.com with SMTP id y16-20020a05600c17d000b0030db7a51ee2so5240971wmo.0
        for <u-boot-amlogic@groups.io>; Wed, 20 Oct 2021 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PEVLl5jkdBSWqe64K6mWa8Euok0Pe5OB0F9PEUdYQ7M=;
        b=1nqFH9h+95KVV0ZMleZd2NM4+SEkYW8LVRbvTzctgMA/qhpqibexN3aTcJFLW7iiT5
         XUFGGcevd6uhBi7vcowcJut6zbVrtIEskZsdIEOpYteJTyHLWS3a+SZWVYyM/Uftf8L2
         6w6Nk5epT32XaUNpbhOUMpeHbXo29IQy4kvXIAswRajlBH8lvpDTE8gBOU73LFz0ETsU
         RoDY97EKpbbq4i6DUHjYNS4gd6dy77uQL4vIPTuQNoyju+7uvOQscwnaXNRQdwR/fHqc
         mRXVlxMO0hCSrVv+oF1/DkK2Y9HXdeOKQ8cKfwXTMO5uVZu0jHOH3frkUsFSK9+mt+XR
         nqcw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: amlogic: add sm efuse write support and cmd for read/write efuse
References: <20211005120002.1147482-1-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <38d6e917-d367-ee5c-58a1-1e6201005e41@baylibre.com>
Date: Wed, 20 Oct 2021 16:23:50 +0200
MIME-Version: 1.0
In-Reply-To: <20211005120002.1147482-1-adeep@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 05/10/2021 14:00, Vyacheslav Bocharov wrote:
> This adds support for amlogic efuse write and provides two subcommands
> of "sm" command: "efuseread" and "efusewrite" to read/write bytes between
> memory and efuse.
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>  arch/arm/mach-meson/sm.c | 68 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
> index 1a8f23cb1fa..fb437b94d14 100644
> --- a/arch/arm/mach-meson/sm.c
> +++ b/arch/arm/mach-meson/sm.c
> @@ -68,6 +68,26 @@ ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size)
>  	return regs.regs[0];
>  }
>  
> +ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size)
> +{
> +	struct pt_regs regs;
> +
> +	meson_init_shmem();
> +
> +        memcpy(shmem_input, buffer, size);
> +
> +	regs.regs[0] = FN_EFUSE_WRITE;
> +	regs.regs[1] = offset;
> +	regs.regs[2] = size;
> +
> +	smc_call(&regs);
> +
> +	if (regs.regs[0] == 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  #define SM_CHIP_ID_LENGTH	119
>  #define SM_CHIP_ID_OFFSET	4
>  #define SM_CHIP_ID_SIZE		12
> @@ -187,9 +207,53 @@ static int do_sm_reboot_reason(struct cmd_tbl *cmdtp, int flag, int argc,
>  	return CMD_RET_SUCCESS;
>  }
>  
> +static int do_efuse_read(struct cmd_tbl *cmdtp, int flag, int argc,
> +			char *const argv[])
> +{
> +	ulong address, offset, size;
> +	int ret;
> +
> +	if (argc < 4)
> +		return CMD_RET_USAGE;
> +
> +        offset = simple_strtoul(argv[1], NULL, 0);
> +        size = simple_strtoul(argv[2], NULL, 0);
> +
> +        address = simple_strtoul(argv[3], NULL, 0);
> +
> +	ret = meson_sm_read_efuse(offset, (void *)address, size);
> +	if (ret)
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
> +        offset = simple_strtoul(argv[1], NULL, 0);
> +        size = simple_strtoul(argv[2], NULL, 0);
> +
> +        address = simple_strtoul(argv[3], NULL, 0);
> +
> +	ret = meson_sm_write_efuse(offset, (void *)address, size);
> +	if (ret)
> +		return CMD_RET_FAILURE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
>  static struct cmd_tbl cmd_sm_sub[] = {
>  	U_BOOT_CMD_MKENT(serial, 2, 1, do_sm_serial, "", ""),
>  	U_BOOT_CMD_MKENT(reboot_reason, 1, 1, do_sm_reboot_reason, "", ""),
> +        U_BOOT_CMD_MKENT(efuseread, 4, 1, do_efuse_read, "", ""),
> +        U_BOOT_CMD_MKENT(efusewrite, 4, 0, do_efuse_write, "", ""),

These should be aligned with tabs

>  };
>  
>  static int do_sm(struct cmd_tbl *cmdtp, int flag, int argc,
> @@ -216,5 +280,7 @@ U_BOOT_CMD(
>  	sm, 5, 0, do_sm,
>  	"Secure Monitor Control",
>  	"serial <address> - read chip unique id to memory address\n"
> -	"sm reboot_reason [name] - get reboot reason and store to to environment"
> +	"sm reboot_reason [name] - get reboot reason and store to to environment\n"
> +        "sm efuseread <offset> <size> <address> - read efuse to memory address\n"
> +        "sm efusewrite <offset> <size> <address> - write into efuse from memory address"

Same here

>  );
> 

Applied to u-boot-amlogic while fixing indent

Thanks,
Neil
