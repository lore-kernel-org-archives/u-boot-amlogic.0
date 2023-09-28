Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web10.9863.1695892090040757719
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Sep 2023 02:08:10 -0700
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50317080342so21380848e87.2
        for <u-boot-amlogic@groups.io>; Thu, 28 Sep 2023 02:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695892088; x=1696496888; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhtpgkMV/3aq4wwpo2D6YCZZO9b3KYPcI68CRJRMN98=;
        b=M8MoYdj+458Ttf13aCsN78+jCmvmcVAO/oQEwmFUITo6FLtuhbop8JdN3y1rqzB5q9
         6grYJYKyqJGdM/Ppf8n20r1CL551ZNOUduURfhHjO6RMIFAuPsAd6rn40moPa/9BkkhB
         zYdYiM+Pyf8A43RKd5uTGa4lMQAHlQl/m237WQIPZc0DRbKyP0ww8OVAdC3vJg6MpaaW
         XbGQFzLllM1UiXNh+Cka0i3XpDM618VXpw36HSXk+ODKMff4RGQcDfW9TbPrcwRcYZdK
         WAXwABQx8qvm2JtViNrkbXlQiQX/A1KgfgdVZ6H0x+YpuKDAjKW2rVXCfWv+X7jGhDWW
         v4rg==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230925155209.130671-1-ivprusov@salutedevices.com>
References: <20230925155209.130671-1-ivprusov@salutedevices.com>
Subject: Re: [PATCH v2 0/2] clk: amlogic: a1: Add Amlogic A1 clock driver
Message-Id: <169589208750.3562382.6261825128142750127.b4-ty@linaro.org>
Date: Thu, 28 Sep 2023 11:08:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Igor Prusov <ivprusov@salutedevices.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Mon, 25 Sep 2023 18:52:07 +0300, Igor Prusov wrote:
> This series adds dt-bindings and driver implementation for Amlogic A1
> PLL and Peripherals clock controllers.
> 
> V1: https://lore.kernel.org/all/20230917101308.1250-1-ivprusov@salutedevices.com/
> 
> V1 -> V2:
>  - Add more verbose comments for driver
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/2] dt-bindings: clock: Add Amlogic A1 clock bindings
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/afc86079bff6e2f70df3eee9c2c30be07d9f7082
[2/2] clk: Add clock driver for Amlogic A1
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/def23a39851d52cadd29854a33e3db29ee4a6d26

-- 
Neil

