Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0600FD462D8
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 16:28:13 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.15677.1731515286252077466
 for <u-boot-amlogic@groups.io>;
 Wed, 13 Nov 2024 08:28:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=AnEzR3u2;
 spf=pass (domain: linaro.org, ip: 209.85.167.42, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53da07b78dfso1051874e87.0
        for <u-boot-amlogic@groups.io>; Wed, 13 Nov 2024 08:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731515284; x=1732120084; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVgpKx+NgZYXAl/aW/Jl4A8qQA0ZfLwgsRKW8oitPV0=;
        b=AnEzR3u2qRLmVuqKkZtmpMN0bSt0QG46eMPdLKab0n2B2duWVs+5SuiM/E0sbJolC0
         Q+0/XGCxP+JAad/MxvGeA+Sb2Z77dWo3TBVpnsFUUh06gJp1MIqucgfNSWVLohdDibqC
         BDuJtqRkslIUHsbQ0gBcejMFGFvb0j/bxw7RmjKHwy4PR4TdOYyS4HURKegyURtdby4A
         3Eg3jdpUyTyWqinBhZwIIQh9XHUbyyMB+RC/d+u58Hrq9XjvLdDT9zPLC3CJkhlFNlgb
         PzGmZ5j7WrXRJ9rNf+h9SSvSqawD8LxlnR42CIqIxZ9PLqBMmO5PZqfQEjPa4sfiIk9u
         ffhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515284; x=1732120084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVgpKx+NgZYXAl/aW/Jl4A8qQA0ZfLwgsRKW8oitPV0=;
        b=D7QCWuqM/PJKG2GNfeha2ZWolYSCg5gTDiXL/0aq+QiaEAMEMrzmVfuUqfFsxWaDxz
         qj0KP/Q6A5yOjih+eFC4/7Ijkv/WYvPSBy4ISyEfltnom/2LGU2IuTAGGBuNxwH4hOcT
         w8MpVsi+7xaJwtnww2PmGZCEwUrkPLzRmQ6xDkaMsecAtwo9cVfVXkQtQR9N2zEulKbt
         PTf6yF6lB4QSGwcLRX05akY0/lMsUPc1Nd7WZw/ZPUii6oEx7T2zlPKIEGebcGV2LKHt
         BMm8EVfFCyNS5mIw0eItbSv+amWUJAVb/w16RXN8vKkFolvso9XRPeIFiPLBa9TuGUUF
         hwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWApae0td6Fcjje7rovsjyduemxcCoK7IMvuvKT2bAb+pRm5yoj6iTDm7goPkv6aHW1qQArS/Nqx2RN4LgZ9w==@groups.io
X-Gm-Message-State: AOJu0Yzqk5ay/yUyOPEDBcLKufwRj2vpepPTw7PFaniw6XlL5jqgjx+d
	OBD8uLOr5FslJ8SkQ8C4+D7rEAuOgzVWhdMOUl2+/+ifVimugapJg/fwtc7LLFE=
X-Google-Smtp-Source: AGHT+IGco0f7ogPci6cEJNVwPLqrxJIZZ/9aldgO7fcstWlsWUUAZSChoqf3dMduXYerNGqJZeYWqA==
X-Received: by 2002:a05:6512:33cb:b0:53d:a3bb:b509 with SMTP id 2adb3069b0e04-53da3bbb519mr771878e87.41.1731515284220;
        Wed, 13 Nov 2024 08:28:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e0fecsm31181045e9.4.2024.11.13.08.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:28:03 -0800 (PST)
From: neil.armstrong@linaro.org
To: trini@konsulko.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/4] Remove legacy Amlogic dtsi and bindings
Date: Wed, 13 Nov 2024 17:28:01 +0100
Message-Id: <173151524505.641625.14064529005947453709.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112125836.3239832-1-avromanov@salutedevices.com>
References: <20241112125836.3239832-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 13 Nov 2024 16:28:13 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2549

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Tue, 12 Nov 2024 15:58:32 +0300, Alexey Romanov wrote:
> We should remove bindings and dtsi from include/ folder for A1
> and AXG Amlogic devices. We have exactly the same, or with minor
> differences in dts/upstream folder.
> 
> I tested this changes on devices closes to reference A1 and AXG SoCs
> devices and didn't receive any problems.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/4] arm: dts: meson: remove meson-a1.dtsi
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ea2273911d3e36cca45f73ae82f311a05df4052a
[2/4] dt-bindings: remove a1 bindings from include/
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a5ed242ba6a8dbcf543b670fd8c11f1683b4baac
[3/4] dt-bindings: remove axg bindings from include/
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/827edb6c00be861bfb84391dcd0586b1402f354f
[4/4] dt-bindings: interrupt-controller: remove arm-gic.h from include/
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/1cdb4e03e684d94456dee0cc30c935d7e25b263d

-- 
Neil

