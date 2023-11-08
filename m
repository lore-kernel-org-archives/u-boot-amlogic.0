Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378F9C04E85
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 12:48:15 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web10.19954.1699462770572034837
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Nov 2023 08:59:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RxTTHKOX;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: seanga2@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7789a4c01easo453060485a.0
        for <u-boot-amlogic@groups.io>; Wed, 08 Nov 2023 08:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699462769; x=1700067569; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMmYg75P5dlUq1+l87xMHYcn2m6Zjceco9n88HPllCE=;
        b=RxTTHKOX8GAknIbSx0S71UabFZeGGGVVbDqsPWDZGBeJpt32NKxBCDvDiKKWfVLFat
         QEvfGhfTvSVpvziPLkvzQWjgu4YJwqa93cfXNf2bl2GdnxIwTacd4EqczGTvXgJn2dq9
         nKb/T5krHUb7WAvR8H0x0ETY9jUgzIRFcVRv7eNJoVMDDuF2x1BRPKhXSSC7PQdiRsjX
         h1XYahciIZYNnEy65eYcryUZM0uGEhliEx895hYMKxZf6hSF3EE9bTzapFQTXWGuT1MV
         WCzKBAh5cimZVRYnSCuAU+oFOIVtFzVyn9Bj5Y1JLgq29BzmStnBKIMqwxuOYozSIo6H
         7l+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699462769; x=1700067569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMmYg75P5dlUq1+l87xMHYcn2m6Zjceco9n88HPllCE=;
        b=PxF5L/qANgggCuydoVgyC637Un2WJISzMOqrln7Bx252lRJknOX4Lr3j8qFltef3gg
         evVnJMrQ5R97VyZZ4O2oWJ3Lm4ka5slyDQM9I/nrucHCWlZ4zdVSJLZPmN2S30T/k2nr
         FxptM8ZaHQPobGbNfIOb6v3qor/M4V+wGGww53h7iv4JUf0jmJHCGTvIO5c8jLs/bHSA
         H+b35fIN/XV5o1ZUhhzTcZ4Khtu28WWcC1oNKooTWwMrJD4hjCX+tBUsvlUJb0nbclUM
         3v+bIpEtEeWyih7K6RmPOSdu2hVOwcyh2bVNhOJpDcTz2EEZGYjnSR7SBdjitajYLNK7
         Pphw==
X-Gm-Message-State: AOJu0YyI7RsvhP+1X5k9UPEMTAcPlyiSlMFKAakES/+uJ/APHvpAv78G
	NL76WwHV/9oJF1x2ZBl7N7I=
X-Google-Smtp-Source: AGHT+IGEmCpG0eYtdQIN4nV9wfwL4Bx0wCLKI0R8JSwGLGqES1vqiXY9WmplMzSKKwk3wLcU1PdQPw==
X-Received: by 2002:a05:620a:2886:b0:775:93aa:cb91 with SMTP id j6-20020a05620a288600b0077593aacb91mr2147427qkp.35.1699462769617;
        Wed, 08 Nov 2023 08:59:29 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with ESMTPSA id a19-20020a05620a125300b007676f3859fasm1233774qkl.30.2023.11.08.08.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 08:59:29 -0800 (PST)
Message-ID: <0f971f33-79ce-a957-dd7d-e1151364e034@gmail.com>
Date: Wed, 8 Nov 2023 11:59:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 6/8] cmd: clk: Use dump function from clk_ops
To: Igor Prusov <ivprusov@sberdevices.ru>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
References: <20231105083809.3293-1-ivprusov@sberdevices.ru>
 <20231105083809.3293-7-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231105083809.3293-7-ivprusov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 10 Nov 2023 12:48:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1861

On 11/5/23 03:38, Igor Prusov wrote:
> Add another loop to dump additional info from clock providers that
> implement dump operation.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   cmd/clk.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/cmd/clk.c b/cmd/clk.c
> index c7c379d7a6..4b9709d3ff 100644
> --- a/cmd/clk.c
> +++ b/cmd/clk.c
> @@ -62,6 +62,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
>   int __weak soc_clk_dump(void)
>   {
>   	struct udevice *dev;
> +	const struct clk_ops *ops;
>   
>   	printf(" Rate               Usecnt      Name\n");
>   	printf("------------------------------------------\n");
> @@ -69,6 +70,14 @@ int __weak soc_clk_dump(void)
>   	uclass_foreach_dev_probe(UCLASS_CLK, dev)
>   		show_clks(dev, -1, 0);
>   
> +	uclass_foreach_dev_probe(UCLASS_CLK, dev) {
> +		ops = dev_get_driver_ops(dev);
> +		if (ops && ops->dump) {
> +			printf("\n%s %s:\n", dev->driver->name, dev->name);
> +			ops->dump(dev);
> +		}
> +	}
> +
>   	return 0;
>   }
>   #else

Reviewed-by: Sean Anderson <seanga2@gmail.com>

