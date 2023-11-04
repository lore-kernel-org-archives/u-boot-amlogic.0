Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCB2C4332F
	for <webhook@archiver.kernel.org>; Sat,  4 Nov 2023 15:46:05 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web11.11454.1699111474522200011
 for <u-boot-amlogic@groups.io>;
 Sat, 04 Nov 2023 08:24:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TuifqGcp;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: seanga2@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-66d0ea3e5b8so18894846d6.0
        for <u-boot-amlogic@groups.io>; Sat, 04 Nov 2023 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699111473; x=1699716273; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dL2RkhTpXekTF8Ai6P/vNUxWJG4LIEK0Z2pmSz4RQmw=;
        b=TuifqGcp6UoMUa9otMIF/4njw5DLxUjhdxX/TQ6vVrHXBhLK6yJSgfAGiwQOWlzPDx
         lb29s4ZP2HvkctDeqK0Mbp95Sp8PvDlVq+MmtXZ6luTyflBi06pht6jvD+/Rucn/1YpS
         O6MNdSqDtAndSGJ7Cb07uxJtayb+E5AyWxNdhS+tCS2SCOfepuvPI2SA93YraniCPIl1
         ucYrpCJ8zKUTBOPDxMVFnv2S74wMmfBxnOaPhZHKFFQF761kHwh9OuCYGvNphv84vSEm
         XJyRmjaT6IOAyA7Z7kQOeSCh2n/5ASCwyp++6ZggudSaEGh5iza8RMKo4hCPzOTfC/X4
         Z2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699111473; x=1699716273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dL2RkhTpXekTF8Ai6P/vNUxWJG4LIEK0Z2pmSz4RQmw=;
        b=J1nR8Dy4pkth8kBA8pAOVjS+a9Haj/xGopEBumjuKnAqFL/cO9GLAtLiFM7zQ9tewb
         Ai2AL5OY5iGaa8MZR40mCydBXJMicMYRoad3Dq9YwSbNSVIyOWjYvxiqUkminWgBpRor
         8D0j3sTYw+Oz4C9bJ0b5YXxUzvhM681eRNnS+7zrY5NV+VBltLPecwtlg0sWk3cc6Hx3
         HhGFq38AuC3okz32wVQPBOOmegg4KYS175yhqPufXv4ApNA9BdbODzbLDOVfy6TxiwAD
         lO8OTGjHKDoEeksrPxuZa0yFmYuL3+C5X1o0SjghU2QWCoWXU24WbI2CmgSzndjBxxjm
         I1IQ==
X-Gm-Message-State: AOJu0YzBJLiGZpk2X33YLwUw7zpdAGwuZgmBPBTi2W4+DrFfuW8jABTB
	dbvE70W75AxPIXwf7i9vwpM=
X-Google-Smtp-Source: AGHT+IE04H40wfAcCOloCWAQXdg+ekQlqAHdCNu7UL7HnxPjA6DF48eJgvCUGRHaYCI5YXknuhYV4w==
X-Received: by 2002:a05:6214:c88:b0:671:2c2f:4fe6 with SMTP id r8-20020a0562140c8800b006712c2f4fe6mr22660073qvr.46.1699111473641;
        Sat, 04 Nov 2023 08:24:33 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with ESMTPSA id u14-20020a0cf88e000000b006585069e894sm1692509qvn.109.2023.11.04.08.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 08:24:33 -0700 (PDT)
Message-ID: <712d1810-93ad-8fd5-8989-1274b5ce49ce@gmail.com>
Date: Sat, 4 Nov 2023 11:24:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 5/8] clk: Add dump operation to clk_ops
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
References: <20231102122017.56995-1-ivprusov@sberdevices.ru>
 <20231102122017.56995-6-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231102122017.56995-6-ivprusov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 04 Nov 2023 15:46:05 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1820

On 11/2/23 08:20, Igor Prusov wrote:
> This adds dump function to struct clk_ops which should replace
> soc_clk_dump. It allows clock drivers to provide custom dump
> implementation without overriding generic CCF dump function.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   include/clk-uclass.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/include/clk-uclass.h b/include/clk-uclass.h
> index a22f1a5d84..793bf14160 100644
> --- a/include/clk-uclass.h
> +++ b/include/clk-uclass.h
> @@ -25,6 +25,7 @@ struct ofnode_phandle_args;
>    * @set_parent: Set current clock parent
>    * @enable: Enable a clock.
>    * @disable: Disable a clock.
> + * @dump: Print clock information.
>    *
>    * The individual methods are described more fully below.
>    */
> @@ -39,6 +40,9 @@ struct clk_ops {
>   	int (*set_parent)(struct clk *clk, struct clk *parent);
>   	int (*enable)(struct clk *clk);
>   	int (*disable)(struct clk *clk);
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	int (*dump)(struct udevice *dev);
> +#endif
>   };
>   
>   #if 0 /* For documentation only */
> @@ -135,6 +139,17 @@ int enable(struct clk *clk);
>    * Return: zero on success, or -ve error code.
>    */
>   int disable(struct clk *clk);
> +
> +/**
> + * dump() - Print clock information.
> + * @clk:	The clock device to dump.
> + *
> + * If present, this function is called by "clk dump" command for each
> + * bound device.
> + *
> + * Return: zero on success, or -ve error code.
> + */
> +int dump(struct udevice *dev);

Actually, this should return void, since we don't do anything with the return code.

--Sean

>   #endif
>   
>   #endif


