Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.1023.1685461951630705442
 for <u-boot-amlogic@groups.io>;
 Tue, 30 May 2023 08:52:31 -0700
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so32526155e9.3
        for <u-boot-amlogic@groups.io>; Tue, 30 May 2023 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685461950; x=1688053950;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oxS500S/T6VWUWJEm3DXy4n380KuBPYwsoRtwiUxc/M=;
        b=PdfmeQWhbEkT/RfxgKE6rPFtJLsqogARh6KwoQq/wO5LStUwNx8sHVrjnxKwnCMdq6
         4+i8GEkjgW/BqCVP5n0mmNu4g9O4JsfgXNg8FXzOVE7S7Kes2y9A1j2emyqFQpUal4rV
         bTyiD1QKDpnUprN/Vn6KTYf1eIkHEUr/H0D6zeUw1J/XHyLT5WFN7/x1ewPTX6lhPCkf
         fzyjlDHKW39glpiSdzqLZMncErMl+BsFbX6LZFvYOH6hjpm9LqFX2p1wI4SluZ81tWgs
         8H/L7f74TcajECc7D9vi58g0njOZvmsxx4BwTGd1LBi7UpdtICCtBW4TyHZacnZlvsPb
         gyVQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <a58429cb-1d71-532c-1c78-5efb545bbf6e@linaro.org>
Date: Tue, 30 May 2023 17:52:27 +0200
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/3] arch/arm: meson: sm: introduce power domain functions
References: <20230522120941.63962-1-avromanov@sberdevices.ru>
 <20230522120941.63962-2-avromanov@sberdevices.ru>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230522120941.63962-2-avromanov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, avromanov@sberdevices.ru, narmstrong@baylibre.com, jh80.chung@samsung.com
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 22/05/2023 14:09, Alexey Romanov via groups.io wrote:
> This commit adds functions to manage secure power domain for
> Amlogic SoC's using smc functionality.
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>   arch/arm/include/asm/arch-meson/sm.h | 30 ++++++++++++++++++++++++++++
>   arch/arm/mach-meson/sm.c             | 14 +++++++++++++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/arch-meson/sm.h
> index 53b75176493..4b1d564bc48 100644
> --- a/arch/arm/include/asm/arch-meson/sm.h
> +++ b/arch/arm/include/asm/arch-meson/sm.h
> @@ -58,4 +58,34 @@ enum {
>    */
>   int meson_sm_get_reboot_reason(void);
>   
> +#define PWRDM_OFF 0
> +#define PWRDM_ON 1
> +
> +/**
> + * meson_sm_pwrdm_set - do command at specified power domain.
> + *
> + * @index: power domain index.
> + * @cmd: command index.
> + * @return: zero on success or error code on failure.
> + */
> +int meson_sm_pwrdm_set(size_t index, int cmd);
> +
> +/**
> + * meson_sm_pwrdm_off - disable specified power domain.
> + *
> + * @index: power domain index.
> + * @return: zero on success or error code on failure.
> + */
> +#define meson_sm_pwrdm_off(index) \
> +	meson_sm_pwrdm_set(index, PWRDM_OFF)
> +
> +/**
> + * meson_sm_pwrdm_on - enable specified power domain.
> + *
> + * @index: power domain index.
> + * @return: zero on success or error code on failure.
> + */
> +#define meson_sm_pwrdm_on(index) \
> +	meson_sm_pwrdm_set(index, PWRDM_ON)
> +
>   #endif /* __MESON_SM_H__ */
> diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
> index f2ca7e76932..d600c64d0be 100644
> --- a/arch/arm/mach-meson/sm.c
> +++ b/arch/arm/mach-meson/sm.c
> @@ -24,6 +24,7 @@
>   #define FN_EFUSE_READ			0x82000030
>   #define FN_EFUSE_WRITE			0x82000031
>   #define FN_CHIP_ID			0x82000044
> +#define FN_PWRDM_SET			0x82000093
>   
>   static void *shmem_input;
>   static void *shmem_output;
> @@ -137,3 +138,16 @@ int meson_sm_get_reboot_reason(void)
>   	/* The SMC call is not used, we directly use AO_SEC_SD_CFG15 */
>   	return FIELD_GET(REBOOT_REASON_MASK, reason);
>   }
> +
> +int meson_sm_pwrdm_set(size_t index, int cmd)
> +{
> +	struct pt_regs regs;
> +
> +	regs.regs[0] = FN_PWRDM_SET;
> +	regs.regs[1] = index;
> +	regs.regs[2] = cmd;
> +
> +	smc_call(&regs);
> +
> +	return regs.regs[0];
> +}

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
