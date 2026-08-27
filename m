Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77C8C61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 15:51:31 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.220.1787845891205234267
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Aug 2026 08:51:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=Z0r4z1aD;
 spf=pass (domain: brivo.com, ip: 209.85.222.182, mailfrom: sanderson@brivo.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e57a753f9so183020685a.2
        for <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1787845890; x=1788450690; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bilWJIlHktWoEZjHwyNxhF4sv+bJkyHheRkebupSmqk=;
        b=Z0r4z1aDfuBWqoDh94uDiiXNvjWQQohM95Y6rcrSq3ExWKc0nL7I9V/nqNOpw7zkY3
         nCSsprdfYvtw5fPqaOzrLvZt6SbjsA+YeXo5nbXfN4HnK8jj3XfPQpmPexg2hdp+35/o
         kMUxI8xIs+XlsDvkhL5qq9i433qAVHHdanjeJCpaKHk5ap6OsJlugGcKwk/QNzxqbVPJ
         WCKnldJQr9KOxl/3VTJF1rmphodPXkT1u/FNproA7lgk8W1g2Xb6Fx8KY9u7C4Tx9VQ5
         mJC8uRKBgjfQpmZ8LFqjsKsVcH1Sp9HE35hk3Z0WmDOw9471LnzIKOu2NxW8G2xyvfbP
         y/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787845890; x=1788450690;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bilWJIlHktWoEZjHwyNxhF4sv+bJkyHheRkebupSmqk=;
        b=E64AK4P2v1w5aU7k7mGyiHRo14W+OSrG7tltHJ8q/gcnaa3gPcRP8jKtIkGHHaMfBe
         DypDqo+lC+DKTEy5I9GqACy7C/FhxDhW5eks3ZXBPwWTwGiddtkfE8kp8orzvpU3TCFV
         x4jQ4fgeRwVY9hDbfHv+CBdbXaDlGePc1cG0rgNNtL2wcafhgd9nDB+JypndW7w2bMdG
         LaNpH8exN1khhGMStLtgOh9JhhMMXwmWmuXP/KdeheUMsxPvhRABqG9h4ItStMsIuuuX
         5t/GLOn54JmjNZKrtP2C+EJ0uhJUPRsDalfSXq7Lw5auTPAVZ965WmyVbjsFW3h14VgE
         a/Ew==
X-Gm-Message-State: AFuF++kisg7KpZdERQ3YQXbCKAAScEPamOpAPd1uakY41/fq2RVJfHDS
	VJcPoHBCHh37Sf9k4gWAA7T7VatRMbSo+QqW4nddR4r/IzF0uF5TqzRZwalrwczpW0K2itE5qsm
	hQzqxNj9gMwCBakRsgNeWMVp77RiNvu4eND+6X4gOxiBeJLQgsnHE3A==
X-Gm-Gg: AR+sD11+e15v3dkffgE7m+dYw3l6mTMnpezxmXkCL0a4LgoQSnAWa8s6pqzCXte3Zkh
	/VkJUzqPVhgM0mI01x4Az+PAgBR1odWgY5wSlJaDLlo73y1i0j8E5kb2XLYrC/uRC2XCzfYOYmn
	amF2bQk7bm5GFhb7i0Frw2+kIJZmnqoXaQy89/FjZxeNYFdro/EDJJkvs4OuxHQ0N05bs/+2R+9
	XskAw5/Mjelw5b0sY2Nj+RM1zii6eGlhC0qNXgs/fTVz4WVwzsWElmY/a4IkYN7rtaFyePPMIxy
	0Ypxe921kFh+RR3OX+0mAz4MdskxolUJjOfnqP6nmo8NkirR0dDdp3Q6CkwcZgdR3reXq65RcAo
	+qix4IFRcksYuBaUZhFh4eGlUDJn6PuBKbcbYeOP+/7n4K/9qW2LeuOgYH0dFVNJBxLKeyw8f15
	Hahi5lC6Fm7Yyae07ekgkGsdQTNs1QGongpcZXx4cOgA9gAgUink3nqaCI3SwpE6JTaQ==
X-Received: by 2002:a05:620a:4f3:b0:936:dbd7:fcb3 with SMTP id af79cd13be357-9378019b06cmr1262591985a.21.1787845889677;
        Thu, 27 Aug 2026 08:51:29 -0700 (PDT)
Received: from [10.200.233.210] ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e36955bsm480665085a.19.2026.08.27.08.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:51:29 -0700 (PDT)
Message-ID: <d943fdf0-f54f-4103-87ea-beb8179206c0@brivo.com>
Date: Thu, 27 Aug 2026 11:51:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] arm64: meson: Add s4 SoC support
To: Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-2-sanderson@brivo.com>
 <a05aabf7-9ef2-48a7-be9f-626c49c21a26@linaro.org>
Content-Language: en-US
From: Sean Anderson <sanderson@brivo.com>
In-Reply-To: <a05aabf7-9ef2-48a7-be9f-626c49c21a26@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 27 Aug 2026 15:51:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3082



On 8/27/26 11:36 AM, Neil Armstrong wrote:
> On 8/17/26 19:15, Sean Anderson wrote:
>> Add support for amlogic s4 (S805X2/S905W2/S905Y4) SoCs. These are very
>> similar to other recent SoCs, with the exception of a workaround for
>> some BL2 (mis)behavior.
>>
>> Signed-off-by: Sean Anderson <sanderson@brivo.com>
>> ---
>>
>>   arch/arm/include/asm/arch-meson/boot0.h | 14 +++++++
>>   arch/arm/mach-meson/Kconfig             |  7 ++++
>>   arch/arm/mach-meson/Makefile            |  1 +
>>   arch/arm/mach-meson/board-s4.c          | 50 +++++++++++++++++++++++++
>>   4 files changed, 72 insertions(+)
>>   create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
>>   create mode 100644 arch/arm/mach-meson/board-s4.c
>>
>> diff --git a/arch/arm/include/asm/arch-meson/boot0.h b/arch/arm/include/asm/arch-meson/boot0.h
>> new file mode 100644
>> index 00000000000..7338171be15
>> --- /dev/null
>> +++ b/arch/arm/include/asm/arch-meson/boot0.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2026 Brivo Systems LLC
>> + */
>> +b reset
>> +#if IS_ENABLED(CONFIG_MESON_S4)
>> +/*
>> + * BL2 copies some keys to the start of DRAM, clobbering anything in the first
>> + * 2k aside from the initial instruction. I measured the actual data clobbered
>> + * as 1076 bytes, but I suspect the amount depends on the configuration, so
>> + * just go with what amlogic does.
>> + */
>> +.skip 2048
>> +#endif
> 
> How different is this boot0 with the one posted for T7 at [1] ?
> 
> https://lore.kernel.org/all/20260821084603.25974-3-tanure@linux.com/

Should be identical. Actually, the size is the same, but I couldn't figure out how
the "kernel key" was supposed to work. So using the same boot0.h should be fine.

>> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
>> index c687ef822a2..91d1e8342e0 100644
>> --- a/arch/arm/mach-meson/Kconfig
>> +++ b/arch/arm/mach-meson/Kconfig
>> @@ -67,6 +67,13 @@ config MESON_A1
>>       help
>>         Select this if your SoC is an A113L
>> +config MESON_S4
>> +    bool "S4"
>> +    select MESON64_COMMON
>> +    select ENABLE_ARM_SOC_BOOT0_HOOK
>> +    help
>> +      Select this if your SoC is an S905Y4/S905W2/S805X2
>> +
>>   endchoice
>>   config SYS_SOC
>> diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
>> index 08a24d4b24f..2157c35c2d5 100644
>> --- a/arch/arm/mach-meson/Makefile
>> +++ b/arch/arm/mach-meson/Makefile
>> @@ -17,3 +17,4 @@ endif
>>   obj-$(CONFIG_MESON_AXG) += board-axg.o
>>   obj-$(CONFIG_MESON_G12A) += board-g12a.o
>>   obj-$(CONFIG_MESON_A1) += board-a1.o
>> +obj-$(CONFIG_MESON_S4) += board-s4.o
>> diff --git a/arch/arm/mach-meson/board-s4.c b/arch/arm/mach-meson/board-s4.c
>> new file mode 100644
>> index 00000000000..7d0bea9924f
>> --- /dev/null
>> +++ b/arch/arm/mach-meson/board-s4.c
>> @@ -0,0 +1,50 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * (C) Copyright 2023 SberDevices, Inc.
>> + */
>> +
>> +#include <asm/armv8/mmu.h>
>> +#include <asm/io.h>
>> +#include <linux/compiler.h>
>> +#include <linux/errno.h>
>> +
>> +void meson_init_reserved_memory(__maybe_unused void *fdt)
>> +{
>> +}
> 
> No reserved memory at all on S4 ?

Well, ATF is signed by amlogic and can't be modified on this platform, so the
reserved memory can't change unless you use a new version of the ATF binary.
meson-s4-s905y4-khadas-vim1s.dts just hard-codes the block of memory.

>> +
>> +int meson_get_boot_device(void)
>> +{
>> +    return -ENOSYS;
>> +}
>> +
>> +static struct mm_region s4_mem_map[] = {
>> +    {
>> +        .virt = 0x00000000UL,
>> +        .phys = 0x00000000UL,
>> +        .size = 0x80000000UL,
>> +        .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +            PTE_BLOCK_INNER_SHARE
>> +    }, {
>> +        .virt = 0x80000000UL,
>> +        .phys = 0x80000000UL,
>> +        .size = 0x7FE00000UL,
>> +        .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>> +            PTE_BLOCK_NON_SHARE |
>> +            PTE_BLOCK_PXN | PTE_BLOCK_UXN
>> +    }, {
>> +        /*
>> +         * This mem region contains in/out shared memory with bl31,
>> +         * hence it's marked as NORMAL memory type
>> +         */
>> +        .virt = 0xFFE00000UL,
>> +        .phys = 0xFFE00000UL,
>> +        .size = 0x00200000UL,
>> +        .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +            PTE_BLOCK_INNER_SHARE
>> +    }, {
>> +        /* List terminator */
>> +        0,
>> +    }
>> +};
>> +
>> +struct mm_region *mem_map = s4_mem_map;
> 


