Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAA8C4332F
	for <webhook@archiver.kernel.org>; Sun,  5 Nov 2023 07:19:50 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web11.15538.1699123237045087784
 for <u-boot-amlogic@groups.io>;
 Sat, 04 Nov 2023 11:40:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PlmxAipN;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: seanga2@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-66d0252578aso19523696d6.0
        for <u-boot-amlogic@groups.io>; Sat, 04 Nov 2023 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699123236; x=1699728036; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ja/FE5wN+tTL4Kr54S+UUTq69lbgK/uClyCwJTa5hF4=;
        b=PlmxAipNgJYSa8+NO4jUnLlUhXUxAnWOAvO/JKU6dg62JJOO7d8jwwHvpH9coreOi0
         msxP2rX/1fArvs8pL4/yxMlIboFN3ku10GsAFywA2akPDdtGPqpP/sainL/IPmo4/dcc
         BZLW/3LKF4magZuGbl0/dyHDSnu/cY9KZr1B2vY+JaEjWPbUi4sl+XARmlcjZg/zAzCf
         pby6uI8Ct9YhxX1n5JOeKP4NxbY4VWfrPLC5f2PDjW0u0uSgBdrApAOiaW/00Qm1OuxC
         XZXcxvMbQoxVWVEC3WDACAYbjtqMAKHgt8yh+CwaVJz+RXIOOfC6ylu0nF1mHC2auD4i
         DiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699123236; x=1699728036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja/FE5wN+tTL4Kr54S+UUTq69lbgK/uClyCwJTa5hF4=;
        b=qz8359yy7t8FH2rxfayF/INlw8zkR8oM9B1LAJU9FgU6XZ0KIDtVPZAqOglhb3FnAP
         vHM3ZGvbY/PycEun7TnbpEtQozk5TNBi9tEsNff93uumMGtnteiswVp9FYW1nTbdxRi/
         uPXB1bl5iFYhtQr4QpTKspY/7PKJA1p85yNkupBTLj5L3G888jkznpgq0sMzCsmmMdcQ
         7E4ul2StyBGwVed10LglZ9Cn+/340ZCrhhJyGmtkdECmHgbnZJ49NoCoC/Bplt4RqQUy
         Xph9ilT2ZbFciAGf2Cy43VMhoHYuxjYnG11TlAALC872wqZbO2aPF0cqmjMVx8JftzKm
         iJaQ==
X-Gm-Message-State: AOJu0YzHKy5nr1GlHRAr/CuGsFVVUFNNvYoNvwAmMXMmfCDTHIQR9hIu
	CRBZYbqs6x+rz33FNHEJyDc=
X-Google-Smtp-Source: AGHT+IFJ4GXr/ZUzlj3TCJF03jyuJoGGJdQcfPZSQd7HT2n5QUjYITLbS854SHftoIr5Gy7SO23OTg==
X-Received: by 2002:a05:6214:c2c:b0:672:e2d5:7a7f with SMTP id a12-20020a0562140c2c00b00672e2d57a7fmr18346059qvd.29.1699123235999;
        Sat, 04 Nov 2023 11:40:35 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with ESMTPSA id x1-20020ad44581000000b00647386a3234sm1845865qvu.85.2023.11.04.11.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 11:40:35 -0700 (PDT)
Message-ID: <d6968ccd-9bd9-56d9-030c-52892d137c07@gmail.com>
Date: Sat, 4 Nov 2023 14:40:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 5/8] clk: Add dump operation to clk_ops
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, prusovigor@gmail.com,
 kernel@sberdevices.ru, Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
References: <20231102122017.56995-1-ivprusov@sberdevices.ru>
 <20231102122017.56995-6-ivprusov@sberdevices.ru>
 <712d1810-93ad-8fd5-8989-1274b5ce49ce@gmail.com>
 <20231104180920.ubq4odp454n4wo52@pc>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231104180920.ubq4odp454n4wo52@pc>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 05 Nov 2023 07:19:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1832

On 11/4/23 14:09, Igor Prusov wrote:
> On Sat, Nov 04, 2023 at 11:24:32AM -0400, Sean Anderson wrote:
>> On 11/2/23 08:20, Igor Prusov wrote:
>>> This adds dump function to struct clk_ops which should replace
>>> soc_clk_dump. It allows clock drivers to provide custom dump
>>> implementation without overriding generic CCF dump function.
>>>
>>> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
>>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> ---
>>>    include/clk-uclass.h | 15 +++++++++++++++
>>>    1 file changed, 15 insertions(+)
>>>
>>> diff --git a/include/clk-uclass.h b/include/clk-uclass.h
>>> index a22f1a5d84..793bf14160 100644
>>> --- a/include/clk-uclass.h
>>> +++ b/include/clk-uclass.h
>>> @@ -25,6 +25,7 @@ struct ofnode_phandle_args;
>>>     * @set_parent: Set current clock parent
>>>     * @enable: Enable a clock.
>>>     * @disable: Disable a clock.
>>> + * @dump: Print clock information.
>>>     *
>>>     * The individual methods are described more fully below.
>>>     */
>>> @@ -39,6 +40,9 @@ struct clk_ops {
>>>    	int (*set_parent)(struct clk *clk, struct clk *parent);
>>>    	int (*enable)(struct clk *clk);
>>>    	int (*disable)(struct clk *clk);
>>> +#if IS_ENABLED(CONFIG_CMD_CLK)
>>> +	int (*dump)(struct udevice *dev);
>>> +#endif
>>>    };
>>>    #if 0 /* For documentation only */
>>> @@ -135,6 +139,17 @@ int enable(struct clk *clk);
>>>     * Return: zero on success, or -ve error code.
>>>     */
>>>    int disable(struct clk *clk);
>>> +
>>> +/**
>>> + * dump() - Print clock information.
>>> + * @clk:	The clock device to dump.
>>> + *
>>> + * If present, this function is called by "clk dump" command for each
>>> + * bound device.
>>> + *
>>> + * Return: zero on success, or -ve error code.
>>> + */
>>> +int dump(struct udevice *dev);
>>
>> Actually, this should return void, since we don't do anything with the return code.
> Good catch! Though there is, for example, zynqmp_clk_dump() that may
> return an error code. Wouldn't it be better to print an error message
> with the code in soc_clk_dump()? It might be convinient to have common
> code handling unexpected errors during dump.

Since this function is for printing, if the driver gets an error
it should just print the error itself. It can probably provide a better
error message than we can. And this command is mainly informational anyway,
so we don't really need to set the return code (e.g. $?).

--Sean


