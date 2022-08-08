Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web08.22593.1659944539460584214
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Aug 2022 00:42:20 -0700
Received: by mail-wr1-f47.google.com with SMTP id q30so9841199wra.11
        for <u-boot-amlogic@groups.io>; Mon, 08 Aug 2022 00:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=REpozgrQec1OahHoQ2Wr9stXey1N977Lu9aelMTogZE=;
        b=t9ZE6Bqk3JK5gXXw06L/eT23MSAXGFQqMjBb28Clkl3oYkajNW+edOdDFt0I7Avy2K
         J8loX6aOtKegAVUWH9Bon4POM2RhSC3QosmXUQjX7PfYubMC69Pumpl+SAC5bQ2K/YXf
         xtDguTXtzQzEj66vAmNDhWupJd0yXBT4fvV6e1D8IsHqg5Xw7j4vXVTIxOnwOo4aB0VD
         Sl7IrE1wyklofUe85lg/ZRHxSO1atSUxNCS5HKm5hD8obhF22IQEJxMO7N/tvvksmQey
         8AqLs653PBhWOJQF0IVqIjpVazxfs6fqKqJDMka1mIGT/1baTEbo6PhgNPUvgrZjKptR
         2Pfg==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <06970d32-8cca-66ad-403f-2bdb4045a92d@baylibre.com>
Date: Mon, 8 Aug 2022 09:42:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: meson: fixup error on efuse commands return
References: <20220804144138.33809-1-jbrunet@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220804144138.33809-1-jbrunet@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 04/08/2022 16:41, Jerome Brunet wrote:
> All `sm efuseread/efusewrite` commands exit with an error, even if the fuse
> have actually been dealt with correctly.
> 
> This is because the smc call return the size it actually processed but this
> result is checked against 0.
> 
> Return failure in do_efuse_read/write if the return value of
> meson_sm_read/write_efuse() is not the requested size.
> 
> Fixes: 52195ba5f579 ("ARM: amlogic: add sm efuse write support and cmd for read/write efuse")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   arch/arm/mach-meson/sm.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
> index 6c28c0f5e445..d6eb910689f4 100644
> --- a/arch/arm/mach-meson/sm.c
> +++ b/arch/arm/mach-meson/sm.c
> @@ -82,10 +82,7 @@ ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size)
>   
>   	smc_call(&regs);
>   
> -	if (regs.regs[0] == 0)
> -		return -1;
> -
> -	return 0;
> +	return regs.regs[0];
>   }
>   
>   #define SM_CHIP_ID_LENGTH	119
> @@ -222,7 +219,7 @@ static int do_efuse_read(struct cmd_tbl *cmdtp, int flag, int argc,
>           address = simple_strtoul(argv[3], NULL, 0);
>   
>   	ret = meson_sm_read_efuse(offset, (void *)address, size);
> -	if (ret)
> +	if (ret != size)
>   		return CMD_RET_FAILURE;
>   
>   	return CMD_RET_SUCCESS;
> @@ -243,7 +240,7 @@ static int do_efuse_write(struct cmd_tbl *cmdtp, int flag, int argc,
>           address = simple_strtoul(argv[3], NULL, 0);
>   
>   	ret = meson_sm_write_efuse(offset, (void *)address, size);
> -	if (ret)
> +	if (ret != size)
>   		return CMD_RET_FAILURE;
>   
>   	return CMD_RET_SUCCESS;

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
