Return-Path: <adeep@lexina.in>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0EDC021A1
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 07:11:58 +0000 (UTC)
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web10.6567.1739257908274593441
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Feb 2025 23:11:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@lexina.in header.s=dkim header.b=R8eAVdIy;
 spf=pass (domain: lexina.in, ip: 185.250.0.168, mailfrom: adeep@lexina.in)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A40A814CAC8;
	Tue, 11 Feb 2025 10:11:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1739257906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FwRg1kNFVasRZCQWtOgX3xwa9fds8WvRADbpQwkvTRw=;
	b=R8eAVdIyZ9CpSeB68tcp6WpCTQErQgMT5d2lkgNE8KFAlG5ncH2i7ZgzUenDj14MaUb8bD
	r7TdiKI0o99j5IefOy4bF+aqkQ7sdqYX4nIuX7ah+v7FRB8Fzsk+P8h3RTX22+dFjq4kIE
	zrBw4sABV1cWVa6RLJVcAkZzRqReGGFCGvFm5XEOF3uWlVWZmn2ppImOx5pzOIoLfgYGIc
	m07ZCHhalueG3A0QEoKst0EOerDTBFyXIhJWVLkXKDTBFyOh4p+NDSmH9QTuJUKZvyW173
	XCxhShQDcC9CglWdj4n8X1bBSJkcDgNhZUGPb7UHKF5I61HmuaKkoHlRvKmVSA==
Message-ID: <23ddd6fc-78d2-47f8-bce5-df4edfbc7c1c@lexina.in>
Date: Tue, 11 Feb 2025 10:11:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arch: meson: sm: add retrieve SoC chipid
From: Viacheslav <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Nikita Maslo <nam@jethome.ru>
References: <20250117104141.90348-1-adeep@lexina.in>
Content-Language: ru
Autocrypt: addr=adeep@lexina.in; keydata=
 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
In-Reply-To: <20250117104141.90348-1-adeep@lexina.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 11 Feb 2025 07:11:58 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2618

Superseed by 
https://lore.kernel.org/u-boot/20250210-meson_chip_id_all_vers-v1-0-b98f8b6880b8@salutedevices.com/

17/01/2025 13.41, Viacheslav Bocharov wrote:
> From: Nikita Maslo <nam@jethome.ru>
> 
> The Amlogic Meson SoC Secure Monitor implements a call to retrieve an
> unique SoC ID starting from the GX Family and all new families.
> But GX-family chips (e.g. GXB, GXL and newer) supports also 128-bit
> chip ID. 128-bit chip ID consists 32-bit SoC version and 96-bit OTP data.
> 
> Add new subcommand "chipid" to Amlogic specific "sm" cmd to write the SoC
> chip ID to memory.
> 
> Signed-off-by: Nikita Maslo <nam@jethome.ru>
> Co-developed-by: Viacheslav Bocharov <adeep@lexina.in>
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> ---
>   arch/arm/include/asm/arch-meson/sm.h | 12 ++++++++++-
>   arch/arm/mach-meson/sm.c             | 32 +++++++++++++++++++++++++++-
>   cmd/meson/sm.c                       | 22 ++++++++++++++++++-
>   3 files changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/arch-meson/sm.h
> index 4b1d564bc48..812c5ed020a 100644
> --- a/arch/arm/include/asm/arch-meson/sm.h
> +++ b/arch/arm/include/asm/arch-meson/sm.h
> @@ -27,9 +27,10 @@ ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size);
>   ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size);
>   
>   #define SM_SERIAL_SIZE	12
> +#define SM_CHIP_ID_SIZE	16
>   
>   /**
> - * meson_sm_get_serial - read chip unique id into buffer
> + * meson_sm_get_serial - read chip unique serial into buffer
>    *
>    * @buffer: pointer to buffer
>    * @size: buffer size.
> @@ -37,6 +38,15 @@ ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size);
>    */
>   int meson_sm_get_serial(void *buffer, size_t size);
>   
> +/**
> + * meson_sm_get_chip_id - read unique chip ID into buffer
> + *
> + * @buffer: pointer to buffer
> + * @size: buffer size.
> + * @return: zero on success or -errno on failure
> + */
> +int meson_sm_get_chip_id(void *buffer, size_t size);
> +
>   enum {
>   	REBOOT_REASON_COLD = 0,
>   	REBOOT_REASON_NORMAL = 1,
> diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
> index 4d9f83d3b38..05d92f878d9 100644
> --- a/arch/arm/mach-meson/sm.c
> +++ b/arch/arm/mach-meson/sm.c
> @@ -78,7 +78,6 @@ ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size)
>   
>   #define SM_CHIP_ID_LENGTH	119
>   #define SM_CHIP_ID_OFFSET	4
> -#define SM_CHIP_ID_SIZE		12
>   
>   int meson_sm_get_serial(void *buffer, size_t size)
>   {
> @@ -101,6 +100,37 @@ int meson_sm_get_serial(void *buffer, size_t size)
>   	return 0;
>   }
>   
> +int meson_sm_get_chip_id(void *buffer, size_t size)
> +{
> +	struct udevice *dev;
> +	struct pt_regs regs = { 0 };
> +	u8 id_buffer[SM_CHIP_ID_LENGTH];
> +	int err;
> +
> +	dev = meson_get_sm_device();
> +	if (IS_ERR(dev))
> +		return PTR_ERR(dev);
> +
> +	regs.regs[1] = 2;
> +	err = sm_call_read(dev, id_buffer, SM_CHIP_ID_LENGTH,
> +			   MESON_SMC_CMD_CHIP_ID_GET, &regs);
> +
> +	if (err < 0) {
> +		pr_err("Failed to read chipid (%d)\n", err);
> +		return err;
> +	}
> +
> +	if (((u32 *)id_buffer)[0] != 2) {
> +		pr_err("Failed to read chipid: invalid chipid call version\n");
> +		return -EINVAL;
> +	}
> +
> +	memcpy(buffer, id_buffer + SM_CHIP_ID_OFFSET,
> +	       size > SM_CHIP_ID_LENGTH ? SM_CHIP_ID_LENGTH : size);
> +
> +	return 0;
> +}
> +
>   #define AO_SEC_SD_CFG15		0xfc
>   #define REBOOT_REASON_MASK	GENMASK(15, 12)
>   
> diff --git a/cmd/meson/sm.c b/cmd/meson/sm.c
> index b69f8123ee2..21bfa58e507 100644
> --- a/cmd/meson/sm.c
> +++ b/cmd/meson/sm.c
> @@ -33,6 +33,24 @@ static int do_sm_serial(struct cmd_tbl *cmdtp, int flag, int argc,
>   	return CMD_RET_SUCCESS;
>   }
>   
> +static int do_sm_chip_id(struct cmd_tbl *cmdtp, int flag, int argc,
> +			 char *const argv[])
> +{
> +	ulong address;
> +	int ret;
> +
> +	if (argc < 2)
> +		return CMD_RET_USAGE;
> +
> +	address = simple_strtoul(argv[1], NULL, 0);
> +
> +	ret = meson_sm_get_chip_id((void *)address, SM_CHIP_ID_SIZE);
> +	if (ret)
> +		return CMD_RET_FAILURE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
>   #define MAX_REBOOT_REASONS 14
>   
>   static const char *reboot_reasons[MAX_REBOOT_REASONS] = {
> @@ -154,6 +172,7 @@ free_buffer:
>   
>   static struct cmd_tbl cmd_sm_sub[] = {
>   	U_BOOT_CMD_MKENT(serial, 2, 1, do_sm_serial, "", ""),
> +	U_BOOT_CMD_MKENT(chipid, 2, 1, do_sm_chip_id, "", ""),
>   	U_BOOT_CMD_MKENT(reboot_reason, 1, 1, do_sm_reboot_reason, "", ""),
>   	U_BOOT_CMD_MKENT(efuseread, 4, 1, do_efuse_read, "", ""),
>   	U_BOOT_CMD_MKENT(efusewrite, 4, 0, do_efuse_write, "", ""),
> @@ -183,7 +202,8 @@ static int do_sm(struct cmd_tbl *cmdtp, int flag, int argc,
>   U_BOOT_CMD(
>   	sm, 5, 0, do_sm,
>   	"Secure Monitor Control",
> -	"serial <address> - read chip unique id to memory address\n"
> +	"serial <address> - read chip unique serial to memory address\n"
> +	"sm chipid <address> - read unique chip id to memory address\n"
>   	"sm reboot_reason [name] - get reboot reason and store to environment\n"
>   	"sm efuseread <offset> <size> <address> - read efuse to memory address\n"
>   	"sm efusewrite <offset> <size> <address> - write into efuse from memory address\n"


