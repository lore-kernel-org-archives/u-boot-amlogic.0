Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.10826.1672835683119255354
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Jan 2023 04:34:43 -0800
Received: by mail-wr1-f41.google.com with SMTP id z16so16306294wrw.1
        for <u-boot-amlogic@groups.io>; Wed, 04 Jan 2023 04:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yEiR0E0df2Xute6O92uObp1ARtf/naCOXsBwgTUyTbk=;
        b=NJl19UAM5bOrmJBHmuuueZafsmgkDN0HHoN2240qjSUMCZhMG7482AEDQc3mV/mt/t
         qmHNVjP0NwbkOnY6egsmPIgAs+omoik7rHzccodRfQPPOwCrvCxcOquSD6c2GEFJkm+4
         aQ95tRrw6P5fPuQ8v4x/3FM7dDNnZ/3ArmWHn2u57beEthAKH0+pAh7QO4D7FTNWWaGt
         msadLHkYfsdY1k74UmxczmnWryb96KldSsrMTFVy8U61kdHbkTqeRIkIu0cy1MQsebIL
         A9fdMQ5JkBV1BOeXzRbpP5sB02u4mdY4qFdea/ta/OldiM1pRPEWMFZyKUDtPqz5VloJ
         mNlw==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <e702c4c1-9902-0103-a1a1-10d868dfd38f@linaro.org>
Date: Wed, 4 Jan 2023 13:34:39 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/5] cmd/arm: meson: sm: introduce efusedump command
References: <20221222125727.47893-1-avromanov@sberdevices.ru>
 <20221222125727.47893-5-avromanov@sberdevices.ru>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20221222125727.47893-5-avromanov@sberdevices.ru>
Content-Language: fr
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, avromanov@sberdevices.ru, narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Le 22/12/2022 à 13:57, Alexey Romanov via groups.io a écrit :
> Using this command user can print efuse memory:
> 
> $ sm efusedump 0 10
>    00000000: ff 00 31 00 00 ff 66 00 00 00      ..1...f...
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   cmd/meson/sm.c | 36 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/cmd/meson/sm.c b/cmd/meson/sm.c
> index c2b57707258..d5eb1d6c084 100644
> --- a/cmd/meson/sm.c
> +++ b/cmd/meson/sm.c
> @@ -5,6 +5,7 @@
>    * Author: Beniamino Galvani <b.galvani@gmail.com>
>    * Author: Vyacheslav Bocharov <adeep@lexina.in>
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
> + * Author: Alexey Romanov <avromanov@sberdevices.ru>
>    */
>   
>   #include <command.h>
> @@ -119,11 +120,43 @@ static int do_efuse_write(struct cmd_tbl *cmdtp, int flag, int argc,
>   	return CMD_RET_SUCCESS;
>   }
>   
> +static int do_efuse_dump(struct cmd_tbl *cmdtp, int flag, int argc,
> +			char *const argv[])
> +{
> +	ulong offset, size;
> +	u8 *buffer;
> +	int ret;
> +
> +	if (argc != 3)
> +		return CMD_RET_USAGE;
> +
> +	offset = simple_strtoul(argv[1], NULL, 0);
> +	size = simple_strtoul(argv[2], NULL, 0);
> +	buffer = malloc(size);
> +	if (!buffer) {
> +		pr_err("Failed to allocate %lu bytes\n", size);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	ret = meson_sm_read_efuse(offset, (void *)buffer, size);
> +	if (ret != size) {
> +		ret = CMD_RET_FAILURE;
> +		goto free_buffer;
> +	}
> +
> +	print_buffer(0, buffer, 1, size, 0);
> +
> +free_buffer:
> +	free(buffer);
> +	return ret;
> +}
> +
>   static struct cmd_tbl cmd_sm_sub[] = {
>   	U_BOOT_CMD_MKENT(serial, 2, 1, do_sm_serial, "", ""),
>   	U_BOOT_CMD_MKENT(reboot_reason, 1, 1, do_sm_reboot_reason, "", ""),
>   	U_BOOT_CMD_MKENT(efuseread, 4, 1, do_efuse_read, "", ""),
>   	U_BOOT_CMD_MKENT(efusewrite, 4, 0, do_efuse_write, "", ""),
> +	U_BOOT_CMD_MKENT(efusedump, 3, 1, do_efuse_dump, "", ""),
>   };
>   
>   static int do_sm(struct cmd_tbl *cmdtp, int flag, int argc,
> @@ -152,5 +185,6 @@ U_BOOT_CMD(
>   	"serial <address> - read chip unique id to memory address\n"
>   	"sm reboot_reason [name] - get reboot reason and store to environment\n"
>   	"sm efuseread <offset> <size> <address> - read efuse to memory address\n"
> -	"sm efusewrite <offset> <size> <address> - write into efuse from memory address"
> +	"sm efusewrite <offset> <size> <address> - write into efuse from memory address\n"
> +	"sm efusedump <offset> <size> - dump efuse data range to console"
>   );

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
