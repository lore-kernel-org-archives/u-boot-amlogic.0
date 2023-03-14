Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.3713.1678781195843078762
 for <u-boot-amlogic@groups.io>;
 Tue, 14 Mar 2023 01:06:36 -0700
Received: by mail-wr1-f51.google.com with SMTP id i9so4425852wrp.3
        for <u-boot-amlogic@groups.io>; Tue, 14 Mar 2023 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781194;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUeql5hEMwgf+bj6As8cvOGDFs1boV259Xl2UdFGP7M=;
        b=dexdysZz6QC5n5SX7DBZRQL5T83nb2tVkRqPmu2BYrjqAQOXd7saWi+gsXZxPtvn7o
         jz+PolOx4EPg4YGg6LyKtUnifApKHxmWCTsOkaC+f0hw+fUJFii1jgtSgYq4NHXA7+XV
         vxZQ6sHrpOJDe+hG0TLgqASjS0mMlt1f1H50PZWqEFc8Y9orGMemJfSsARD/PPK8Sv6i
         r2vddTV+LHNVw9c0NqZ7WcC+gDdq0jnk6UHDaSI2hyd5nZ2iRF4iwyikJqetKMXwvc7Z
         PXbRRP4hIAKgSRhqxZnkA/UU5/2+kB+vlwGgQE3T21jC8JVGjZ2JsAAgGOurYXEMSSoI
         nQXw==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230210-u-boot-odroid-go-ultra-pmics-setup-v1-1-1f16d62b76af@linaro.org>
References: <20230210-u-boot-odroid-go-ultra-pmics-setup-v1-1-1f16d62b76af@linaro.org>
Subject: Re: [PATCH] ARM: meson: odroid-go-ultra: setup PMIC regulators are board init
Message-Id: <167878119365.3431120.5945168043155617438.b4-ty@linaro.org>
Date: Tue, 14 Mar 2023 09:06:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Fri, 10 Feb 2023 11:25:07 +0100, Neil Armstrong wrote:
> The Odroid Go Ultra has 2 chained PMICs RK818 and RK818, and needs
> an adjustment on the BUCK and LDO values.
> 
> Add the initial regulators values in -u-boot.dtsi & run the initial
> regulator setup in a new odroid-go-ultra board.
> 
> Proper OTG and BOOST regulators are still missing to have USB-A
> host properly working.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] ARM: meson: odroid-go-ultra: setup PMIC regulators are board init
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/de58694f0d5431627d7389f50a6b2034a682ba24

-- 
Neil

