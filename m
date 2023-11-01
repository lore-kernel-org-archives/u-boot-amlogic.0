Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99958C4332F
	for <webhook@archiver.kernel.org>; Sat,  4 Nov 2023 15:46:35 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web11.13325.1698858694211254789
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Nov 2023 10:11:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JJcRnrUv;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: seanga2@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-77063481352so92183985a.1
        for <u-boot-amlogic@groups.io>; Wed, 01 Nov 2023 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698858693; x=1699463493; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46h/KhN/7RdInOJ3BBu0welC5pqJf6vbaHJ5AuuWfxc=;
        b=JJcRnrUvMFJ1pZ4L/fPQ3tDYot78z4GfKeZ2gtdZt5MCe4Q3WSrsFb0TfDGSSHa8U5
         ttw3OSFFwMWs3ehyWqFCw8yMtv5Axqya6hU4Wi4JinyBTCF5M3VUE6Y2JuxIlv8HTsB2
         hU9nz7H4fgjZDSuCNzNLCEIixoFjD4gubv7xG3n8TBFBzMdg0gOJmb5DSA4ohNGJLiZe
         vYIv+Iv/3rfO9E0M6t+X9eWRCFlCZ12OW8fm+3IWAxTSPcaV39JQ6XiUPlI5Zn1d1QX2
         DP3QEZG/D0LBRPcBWzcFROU9QAhF/Q90iVRoPJHulrTMDRUj0UiVFG4R8BgpL8ZsynGt
         JNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698858693; x=1699463493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46h/KhN/7RdInOJ3BBu0welC5pqJf6vbaHJ5AuuWfxc=;
        b=rDu8goGa+61533Bu6Z6toDsPpoM1LaOesFfLQIH3x+RSPAa8fHtiEBtQNAGrvx891z
         VLERYX+3SMZUm4aSQxE7ecMRFHHNTAIrJl9PZhTZ2dhmX0Jh69ZkaJ/FjmocWr6UwBhe
         KfGHIHef5LX7kRZlf8bEJeiXd06vCAXAcJxXB14bda/PVBGNSS5b/1lEddPMR/ghWoGv
         o51ZqxCJzWAOKa5ljP5vsBLfWU9nwGfWk0xNDl3FPjOFDqbt3XiWqToWzIvwB37hdKTI
         EZTr2rjyfjM+DoP4VxxvDLq/nvTDLrjJYmJItkke8/o6cXeN6VDvlxPY3HoGNCeTytRS
         0iXg==
X-Gm-Message-State: AOJu0YyIvICB5720x/OW5yyIUMDDX1Q38VJ5h13rR8fANs1Zg24IBmWZ
	Fa5IauN+E4LcxGkK62Jau40=
X-Google-Smtp-Source: AGHT+IEcwjX/wTuzVtFvF9fyx6gqKP6h8lXShoRRIbfXGmfv9FK3wjgzUwWau5AEn1kE3m2qRG5YpA==
X-Received: by 2002:a05:620a:1488:b0:778:8ebc:129e with SMTP id w8-20020a05620a148800b007788ebc129emr8351667qkj.15.1698858693336;
        Wed, 01 Nov 2023 10:11:33 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with ESMTPSA id a14-20020a05620a02ee00b0076f21383b6csm1582561qko.112.2023.11.01.10.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 10:11:33 -0700 (PDT)
Message-ID: <df88e98f-99de-abca-de7c-6d755c6283ff@gmail.com>
Date: Wed, 1 Nov 2023 13:11:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 5/8] clk: Add dump operation to clk_ops
To: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20231017165649.1492-1-ivprusov@sberdevices.ru>
 <20231017165649.1492-6-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231017165649.1492-6-ivprusov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 04 Nov 2023 15:46:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1827

On 10/17/23 12:56, Igor Prusov wrote:
> This adds dump function to struct clk_ops which should replace
> soc_clk_dump. It allows clock drivers to provide custom dump
> implementation without overriding generic CCF dump function.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   include/clk-uclass.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/clk-uclass.h b/include/clk-uclass.h
> index a22f1a5d84..30621e4823 100644
> --- a/include/clk-uclass.h
> +++ b/include/clk-uclass.h
> @@ -39,6 +39,9 @@ struct clk_ops {
>   	int (*set_parent)(struct clk *clk, struct clk *parent);
>   	int (*enable)(struct clk *clk);
>   	int (*disable)(struct clk *clk);
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	int (*dump)(struct udevice *dev);
> +#endif
>   };
>   
>   #if 0 /* For documentation only */

Please add documentation.

--Sean

