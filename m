Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97720C4167B
	for <webhook@archiver.kernel.org>; Sat,  4 Nov 2023 15:46:25 +0000 (UTC)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
 by mx.groups.io with SMTP id smtpd.web10.13309.1698858659189855122
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Nov 2023 10:10:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fgi0ugqX;
 spf=pass (domain: gmail.com, ip: 209.85.222.47, mailfrom: seanga2@gmail.com)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7b9d894be6fso2137548241.2
        for <u-boot-amlogic@groups.io>; Wed, 01 Nov 2023 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698858658; x=1699463458; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/DVyx7HV1QtHnJQKbe6LRy4VncbddBPWfDdtcBheIM=;
        b=fgi0ugqXbNdJ0RHIIZsLcFLZTcWC69VAR4OetDsf5U9tzZbUw3lSsguAfgAVMDXEZn
         49ea/QaBf3uMlGx+BnTkjZxCjtPRMjwzE5y68wn2iafT9z9hDHJUM4n5gCY7xfb+f+m/
         gCo2fasqEqe+T1PAMpGx1EjQ92AwmbWP7e6KBvWi3dotzCDzzGkpr+556YLX4Alf+G9Z
         2mtCKjSclGFOKCXeIlq2hs9L+y5oe01BA8zW9vwXrKQ8gjZAH2YX42wfIfZN7W5ovQge
         i/7b9+FFGqH0qMxFhDwG74NXA4R89ns6mtMHy2M8bb6smj6Fj5XIDm7odZZ0LwTTLbIo
         U96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698858658; x=1699463458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/DVyx7HV1QtHnJQKbe6LRy4VncbddBPWfDdtcBheIM=;
        b=RBh8Y9OgpvlMkZsGxutY75ZN6VqL2Sbs72oosEAIP9XhChb5IEPc5bgcofe82ntn13
         V0tmuL/bZultDiHP0GGA4OEYpFOY75ZvvJDFUHCJe2ORTizrYDDyapktCkSpkCWYPy9T
         YDNzfclvQauoMdRnBrFiAvXeVoEU5jcDtpHrIzU0y6rwMGgXw2dRN6EbCGjnXUo0Iyld
         nYgQzX+1WxAtqBkG336XtT3VspWLMpMI2Ij/PjSdO6ShzdQUPF5ncaKpe7glPOzD7doT
         FNNmzMA0NEiU3eHIBFbrntUCL+5NSfyuS0W47XPVfjdqGK+1VZg/rH0tJ5Xf8hSe4YLy
         dbAw==
X-Gm-Message-State: AOJu0YyxSbk40yYYRVeoGPZ/2FjtqvC08Rotc2mnZZanepXCIM/2YoVm
	GxzCG49C58ryTaZFCCn+uQk8PZEXYa5lkA==
X-Google-Smtp-Source: AGHT+IFlvUnuSsp0RjozNueg7ItSkpx0jpzbbVQ2lc6wIYn+7vbHuSRFiC1NogWAWIAxfT7fDQYCEg==
X-Received: by 2002:a67:c896:0:b0:458:3bc1:c816 with SMTP id v22-20020a67c896000000b004583bc1c816mr11460758vsk.16.1698858658174;
        Wed, 01 Nov 2023 10:10:58 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with ESMTPSA id de43-20020a05620a372b00b007788d2f3d4asm1592402qkb.39.2023.11.01.10.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 10:10:57 -0700 (PDT)
Message-ID: <c1c4205c-edb0-7dd2-3ff0-3be1c6a79104@gmail.com>
Date: Wed, 1 Nov 2023 13:10:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 6/8] cmd: clk: Use dump function from clk_ops
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
 <20231017165649.1492-7-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231017165649.1492-7-ivprusov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 04 Nov 2023 15:46:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1825

On 10/17/23 12:56, Igor Prusov wrote:
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
> index c7c379d7a6..90cc6fa906 100644
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
> +			printf("--------------------------\n");
> +			ops->dump(dev);
> +		}
> +	}
> +
>   	return 0;
>   }
>   #else

So this produces output like

=> clk dump
  Rate               Usecnt      Name
------------------------------------------
  26000000             0        |-- osc
--------------------------
  Rate      Enabled Name
------------------------
  26000000  y       osc
  780000000 y           pll0
  390000000 -               aclk
  390000000 y                   cpu
  390000000 y                   sram0
  390000000 y                   sram1
  7800000   -                   clint
  195000000 y                   apb0
  195000000 y                       gpio
  195000000 y                       uart1
  195000000 y                       uart2
  195000000 y                       uart3
  195000000 y                       fpioa
  195000000 y                       sha
  195000000 y                   apb1
  195000000 y                       aes
  195000000 y                       otp
  195000000 y                   apb2
  195000000 y                   rom
  390000000 y                   dma
  390000000 y                   dvp
  390000000 y                   fft
  390000000 y               spi0
  390000000 y               spi1
  390000000 y               spi2
  97500000  y               spi3
  390000000 y               i2c0
  390000000 y               i2c1
  390000000 y               i2c2
  390000000 y               timer0
  390000000 y               timer1
  390000000 y               timer2
  390000000 y           pll1
  390000000 y               ai
  0         n           pll2
  0         y               i2s0
  0         y               i2s1
  0         y               i2s2
  0         -               i2s0_m
  0         -               i2s1_m
  0         -               i2s2_m
  13000000  y           wdt0
  13000000  n           wdt1
  26000000  n           rtc

And TBH I don't think it's particularly clear (at least at a glance) where
one clock ends and another begins. I think something like

diff --git i/cmd/clk.c w/cmd/clk.c
index f55911db7a3..7bbcbfeda33 100644
--- i/cmd/clk.c
+++ w/cmd/clk.c
@@ -73,7 +73,7 @@ static int soc_clk_dump(void)
         uclass_foreach_dev_probe(UCLASS_CLK, dev) {
                 ops = dev_get_driver_ops(dev);
                 if (ops && ops->dump) {
-                       printf("--------------------------\n");
+                       printf("\n%s %s:\n", dev->driver->name, dev->name);
                         ops->dump(dev);
                 }
         }

would work a lot better. This produces an output like

=> clk dump
  Rate               Usecnt      Name
------------------------------------------
  26000000             0        |-- osc

k210_clk clock-controller:
  Rate      Enabled Name
------------------------
  26000000  y       osc
  780000000 y           pll0
  390000000 -               aclk
  390000000 y                   cpu
  390000000 y                   sram0
  390000000 y                   sram1
</snip>

which I think makes it clearer that we have a new clock tree getting dumped.

This also doesn't really address multiple interacting clock trees (such as
e.g. if I had another clock derived from a k210_clk in the above example)
but at least it's a start.

--Sean

