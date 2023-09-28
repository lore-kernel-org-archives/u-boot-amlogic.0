Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.9780.1695891706161818553
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Sep 2023 02:01:46 -0700
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3231dff4343so5794673f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 28 Sep 2023 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695891704; x=1696496504; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEQGpxyRNw1vaDxWidc8elGY+OEmWW8l9oS3yi9pv2o=;
        b=O7f5UL3GPxbbLVsmPkQNiQItPRwEUKxW3fU3T/6Jkyykm3iUbareVkYwM8lr3kwcMb
         UIV+heBjhW7yRauKYU+mP56qKu1AfnFKhrulj8jpQkkjt2nma+vABUR0Z7iJ3iV4yzUi
         sFaLZp0lMvZlc8IkGzduvRIorNwPl0+3KFd9V6fgV51AovK86OA2vK+jcA+HY8ljIDTr
         xtViQVincyvIuuqSjUH52iABnHcVYdWBewzllc9Pqy3l6s9+GMAIgArhc5c5K73UDGVq
         7KItSr5nJW8E5V/swUeITdnatYszHMCpWknNebP5zFsPDokbaToSP2vmAxLTUYY4fWqQ
         AssA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <e7b32c24-0097-4611-a2da-f32bccb81aa8@linaro.org>
Date: Thu, 28 Sep 2023 11:01:43 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/2] clk: amlogic: a1: Add Amlogic A1 clock driver
References: <20230925155209.130671-1-ivprusov@salutedevices.com>
In-Reply-To: <20230925155209.130671-1-ivprusov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Igor Prusov <ivprusov@salutedevices.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 25/09/2023 17:52, Igor Prusov wrote:
> This series adds dt-bindings and driver implementation for Amlogic A1
> PLL and Peripherals clock controllers.
> 
> V1: https://lore.kernel.org/all/20230917101308.1250-1-ivprusov@salutedevices.com/
> 
> V1 -> V2:
>   - Add more verbose comments for driver
> 
> Igor Prusov (2):
>    dt-bindings: clock: Add Amlogic A1 clock bindings
>    clk: Add clock driver for Amlogic A1
> 
>   arch/arm/include/asm/arch-meson/clock-a1.h    |  23 +
>   drivers/clk/meson/Kconfig                     |   8 +
>   drivers/clk/meson/Makefile                    |   1 +
>   drivers/clk/meson/a1.c                        | 723 ++++++++++++++++++
>   .../clock/amlogic,a1-peripherals-clkc.h       | 168 ++++
>   .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |  25 +
>   6 files changed, 948 insertions(+)
>   create mode 100644 arch/arm/include/asm/arch-meson/clock-a1.h
>   create mode 100644 drivers/clk/meson/a1.c
>   create mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
>   create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

I'll apply it for next u-boot release,

Thanks,
Neil
