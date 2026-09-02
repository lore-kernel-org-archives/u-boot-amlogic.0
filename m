Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4D2C624D5
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 11:42:13 +0000 (UTC)
Received: from mta1.migadu.com (mta1.migadu.com [95.215.58.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10833.1788349326078021593
 for <u-boot-amlogic@groups.io>;
 Wed, 02 Sep 2026 04:42:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=RVNXu0Yp;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.4, mailfrom: funderscore@postmarketos.org)
X-Envelope-To: u-boot-amlogic@groups.io
DKIM-Signature: a=rsa-sha256; bh=9nZXIBV9eVKh4RG4+P83N+0fGouzl/jvI8VQgO+kb+0=;
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788349324; v=1; x=1788954124;
 b=RVNXu0YpndWMidnMRdpRBAo/41MvY0t3+wCAyzEshRYnLRjKu+6mx7yuh+imVrm8h6lJIoMm
 UMv+hzglYBBmuQKc2zUVmuBAFr1lsRGL/bBfp86UKjOX1xBTxx19on4bpKoJrWs/6z9ZlPjeVqf
 TfoPzyrxkClg7JYBkcCDznYF1x5VjPmPNABdVPu4l8TDTsjATA0ThVujIZRQS7BWDTkubvmTveO
 RpX5QVmTfsa5KSwiigcVutDNkTRY9+fPiOY5GIwzbgL+3aLQ4vtGbd2Pe6sXtqCKMeKggio+blY
 WkdGYWHKZrYW+ZX9ViEmc9hHmKrXDkYzmLfiKbDUugOtQ==
X-Envelope-To: u-boot-amlogic@groups.io
Received: by smtp.migadu.com with ESMTPS id 1a0da2cb27795407;
	Wed, 02 Sep 2026 11:42:03 +0000
X-Mizu-Trace-ID: 1a0da2cb27795407
X-Migadu-Flow: FLOW_OUT
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 11:42:03 +0000
Message-Id: <DL4SXDBLA651.1HE98H79C5FJX@postmarketos.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Daniel Golle" <daniel@makrotopia.org>
Subject: Re: [PATCH] spl: rename DISABLE_ALL_EXECPTIONS
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: <u-boot-amlogic@groups.io>, <neil.armstrong@linaro.org>,
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.21.0
References: <20260901-typo-v1-1-89ea773a9a05@arm.com>
 <afe6836f-5366-4177-ab57-7563380e8b74@linaro.org>
In-Reply-To: <afe6836f-5366-4177-ab57-7563380e8b74@linaro.org>
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 02 Sep 2026 11:42:13 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3086

Hi,

On Tue Sep 1, 2026 at 4:35 PM UTC, Neil Armstrong via groups.io wrote:
> On 9/1/26 18:20, Vincent Stehl=C3=A9 wrote:
>> The DISABLE_ALL_EXECPTIONS define has a typo; fix all occurrences using =
the
>> following command:
>>=20
>>    find '(' -type d -name .git -prune ')' -o -type f -print |\
>>      xargs sed -i 's/DISABLE_ALL_EXECPTIONS/DISABLE_ALL_EXCEPTIONS/g'
>>=20
>> This can be verified by pre-processing, for example with the following
>> commands:
>>=20
>>    make libretech-cc_v2_defconfig
>>    make spl/arch/arm/mach-meson/spl.i spl/common/spl/spl_atf.i
>>=20
>> (Adjust as needed for cross-compilation.)
>>=20
>> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm/mach-meson/spl.c | 2 +-
>>   common/spl/spl_atf.c      | 8 ++++----
>>   include/atf_common.h      | 2 +-
>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/arch/arm/mach-meson/spl.c b/arch/arm/mach-meson/spl.c
>> index 28a63f39d36..73445064e4d 100644
>> --- a/arch/arm/mach-meson/spl.c
>> +++ b/arch/arm/mach-meson/spl.c
>> @@ -84,7 +84,7 @@ void board_init_f(ulong dummy)
>>  =20
>>   		SET_PARAM_HEAD(&spl_ep_info, ATF_PARAM_BL31, ATF_VERSION_1, 0);
>>   		spl_ep_info.pc =3D CONFIG_SPL_TEXT_BASE;
>> -		spl_ep_info.spsr =3D SPSR_64(MODE_EL3, MODE_SP_ELX, DISABLE_ALL_EXECP=
TIONS);
>> +		spl_ep_info.spsr =3D SPSR_64(MODE_EL3, MODE_SP_ELX, DISABLE_ALL_EXCEP=
TIONS);
>>  =20
>>   		regs.regs[0] =3D 0xc0000000;
>>   		regs.regs[1] =3D (unsigned long)&spl_ep_info;

Nice catch

Acked-by: Ferass El Hafidi <funderscore@postmarketos.org> # mach-meson spl

Best regards,
Ferass

>> diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
>> index 17acd3665df..cb0604ce034 100644
>> --- a/common/spl/spl_atf.c
>> +++ b/common/spl/spl_atf.c
>> @@ -75,7 +75,7 @@ struct bl31_params *bl2_plat_get_bl31_params_default(u=
long bl32_entry,
>>   	bl32_ep_info->args.arg3 =3D fdt_addr;
>>   	bl32_ep_info->pc =3D bl32_entry ? bl32_entry : 0;
>>   	bl32_ep_info->spsr =3D SPSR_64(MODE_EL1, MODE_SP_ELX,
>> -				     DISABLE_ALL_EXECPTIONS);
>> +				     DISABLE_ALL_EXCEPTIONS);
>>  =20
>>   	bl2_to_bl31_params->bl32_image_info =3D &bl31_params_mem.bl32_image_i=
nfo;
>>   	SET_PARAM_HEAD(bl2_to_bl31_params->bl32_image_info,
>> @@ -91,7 +91,7 @@ struct bl31_params *bl2_plat_get_bl31_params_default(u=
long bl32_entry,
>>   	bl33_ep_info->args.arg0 =3D 0xffff & read_mpidr();
>>   	bl33_ep_info->pc =3D bl33_entry;
>>   	bl33_ep_info->spsr =3D SPSR_64(MODE_EL2, MODE_SP_ELX,
>> -				     DISABLE_ALL_EXECPTIONS);
>> +				     DISABLE_ALL_EXCEPTIONS);
>>  =20
>>   	bl2_to_bl31_params->bl33_image_info =3D &bl31_params_mem.bl33_image_i=
nfo;
>>   	SET_PARAM_HEAD(bl2_to_bl31_params->bl33_image_info,
>> @@ -149,7 +149,7 @@ struct bl_params *bl2_plat_get_bl31_params_v2_defaul=
t(ulong bl32_entry,
>>   	bl_params_node->ep_info->args.arg3 =3D fdt_addr;
>>   	bl_params_node->ep_info->pc =3D bl32_entry ? bl32_entry : 0;
>>   	bl_params_node->ep_info->spsr =3D SPSR_64(MODE_EL1, MODE_SP_ELX,
>> -						DISABLE_ALL_EXECPTIONS);
>> +						DISABLE_ALL_EXCEPTIONS);
>>   	SET_PARAM_HEAD(bl_params_node->image_info, ATF_PARAM_IMAGE_BINARY,
>>   		       ATF_VERSION_2, 0);
>>  =20
>> @@ -166,7 +166,7 @@ struct bl_params *bl2_plat_get_bl31_params_v2_defaul=
t(ulong bl32_entry,
>>   	bl_params_node->ep_info->args.arg0 =3D 0xffff & read_mpidr();
>>   	bl_params_node->ep_info->pc =3D bl33_entry;
>>   	bl_params_node->ep_info->spsr =3D SPSR_64(MODE_EL2, MODE_SP_ELX,
>> -						DISABLE_ALL_EXECPTIONS);
>> +						DISABLE_ALL_EXCEPTIONS);
>>   	SET_PARAM_HEAD(bl_params_node->image_info, ATF_PARAM_IMAGE_BINARY,
>>   		       ATF_VERSION_2, 0);
>>  =20
>> diff --git a/include/atf_common.h b/include/atf_common.h
>> index 03cfcc69cd7..9ef1ef186e1 100644
>> --- a/include/atf_common.h
>> +++ b/include/atf_common.h
>> @@ -69,7 +69,7 @@
>>   #define DAIF_IRQ_BIT (1<<1)
>>   #define DAIF_ABT_BIT (1<<2)
>>   #define DAIF_DBG_BIT (1<<3)
>> -#define DISABLE_ALL_EXECPTIONS	\
>> +#define DISABLE_ALL_EXCEPTIONS	\
>>   	(DAIF_FIQ_BIT | DAIF_IRQ_BIT | DAIF_ABT_BIT | DAIF_DBG_BIT)
>>  =20
>>   #ifndef __ASSEMBLY__
>>=20
>> ---
>> base-commit: 3f19667468fb93bcb5702d23aa057b72639e3ac8
>> change-id: 20260901-typo-465ee352485c
>>=20
>> Best regards,
>> --
>> Vincent.
>>=20
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>
> Thanks,
> Neil

