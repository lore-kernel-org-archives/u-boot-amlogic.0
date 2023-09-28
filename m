Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.9603.1695891668479744822
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Sep 2023 02:01:08 -0700
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-405361bb94eso129129635e9.0
        for <u-boot-amlogic@groups.io>; Thu, 28 Sep 2023 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695891667; x=1696496467; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcYm25a/EilSoFwSGe3SbRfK+UBHFB6MWlJ2lOpQFwM=;
        b=QY+M9H9nknHhwFbCHAK4ByKA/14rytM59EUaaeS9+MVcP42Xm2sajS3xZpxubUBk2Y
         lDiparxHEht6K3EAVMkDhhAcZtNz5kkb1AxbG63ukwaQu2t78HV50p1AFPxoGNgHvq11
         KIaExmHOWocKXccBV+NsY3M80NDUVrp7C8YZjAGUZ4GMsT5jqBIqErU6Uzbc5NBnr07O
         uw6ix5dIywMcvV0uRL7uIXXduck8T5fifRJu1on4yH4MaQMQk+fiZ7/54udHh94n7Rqe
         Jar1fZIOhy1tVhShfV5WoA1xe4hAm3ZoiKPdeJezqHjN8cXklvv/AodWIuAT6VWeUigd
         q84A==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <88840967-5f39-4f21-ad0b-6b356398ec77@linaro.org>
Date: Thu, 28 Sep 2023 11:01:05 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 0/8] Add SM uclass and Meson SM driver
References: <20230921081346.22157-1-avromanov@salutedevices.com>
In-Reply-To: <20230921081346.22157-1-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sjg@google.com, takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org, post@lespocky.de, marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org, jh80.chung@samsung.com, paul.barker@sancloud.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 21/09/2023 10:13, Alexey Romanov wrote:
> Hello!
> 
> At the moment, there is no single general approach to using
> secure monitor in U-Boot, there is only the smc_call() function,
> over which everyone builds their own add-ons. This patchset
> is designed to solve this problem by adding a new uclass -
> SM_UCLASS. This UCLASS export following generic API:
> 
> 1. sm_call() - generic SMC call to the secure-monitor
> 2. sm_call_read() - retrieve data from secure-monitor
> 3. sm_call_write() - send data to secure-monitor
> 
> In the future, it is necessary to completely get rid of raw
> smc_call() calls, replacing them with the use of SM_UCLASS
> based drivers.
> 
> V2:
> 
> - Add SM UCLASS
> - Add SM sandbox driver
> - Add test for sandbox driver
> - Meson Secure Monitor driver now based on SM_UCLASS
> - Fix include order in arch/arm/mach-meson/sm.c
> 
> Also, during the discussion in V1 of this patchset, it was
> discussed to create MESON_SM_UCLASS, but I considered such
> a uclass to be too arch-specific. That's why I suggest
> SM_UCLASS, which is not so arch-specific: secure monitor can
> used for whole ARM devices, not only for Amlogic SoC's.
> 
> V3:
> 
> - Fix typos in commit messages
> - Use uclass_first_device_err() instead of uclass_get_device_by_name()
> - Return -ENOSYS instead of -EPROTONOSUPPORT if SM_UCLASS option not
> implemented
> 
> Alexey Romanov (8):
>    drivers: introduce Secure Monitor uclass
>    sandbox: add sandbox sm uclass driver
>    sandbox: dts: add meson secure monitor node
>    sandbox: add tests for UCLASS_SM
>    sandbox: defconfig: enable CONFIG_SM option
>    drivers: introduce Meson Secure Monitor driver
>    arch: meson: sm: set correct order of the includes
>    arch: meson: use secure monitor driver
> 
>   MAINTAINERS                 |   1 +
>   arch/arm/mach-meson/Kconfig |   1 +
>   arch/arm/mach-meson/sm.c    | 116 +++++++++++----------
>   arch/sandbox/dts/test.dts   |   4 +
>   configs/sandbox_defconfig   |   1 +
>   drivers/Kconfig             |   2 +
>   drivers/Makefile            |   1 +
>   drivers/sm/Kconfig          |   9 ++
>   drivers/sm/Makefile         |   5 +
>   drivers/sm/meson-sm.c       | 198 ++++++++++++++++++++++++++++++++++++
>   drivers/sm/sandbox-sm.c     |  76 ++++++++++++++
>   drivers/sm/sm-uclass.c      |  55 ++++++++++
>   include/dm/uclass-id.h      |   1 +
>   include/meson/sm.h          |  19 ++++
>   include/sandbox-sm.h        |  18 ++++
>   include/sm-uclass.h         |  72 +++++++++++++
>   include/sm.h                |  67 ++++++++++++
>   test/dm/Makefile            |   1 +
>   test/dm/sm.c                |  65 ++++++++++++
>   19 files changed, 656 insertions(+), 56 deletions(-)
>   create mode 100644 drivers/sm/Kconfig
>   create mode 100644 drivers/sm/Makefile
>   create mode 100644 drivers/sm/meson-sm.c
>   create mode 100644 drivers/sm/sandbox-sm.c
>   create mode 100644 drivers/sm/sm-uclass.c
>   create mode 100644 include/meson/sm.h
>   create mode 100644 include/sandbox-sm.h
>   create mode 100644 include/sm-uclass.h
>   create mode 100644 include/sm.h
>   create mode 100644 test/dm/sm.c
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

I'll apply it for next u-boot release,

Thanks,
Neil
