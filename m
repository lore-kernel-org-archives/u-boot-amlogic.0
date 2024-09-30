Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457DDCE834B
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 14:27:22 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.55838.1727706439810923089
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Sep 2024 07:27:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=dPTuz4Sx;
 spf=pass (domain: linaro.org, ip: 209.85.221.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37cdb42b29dso1648549f8f.0
        for <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727706438; x=1728311238; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTy4NWgRgDq+j6izR3kA2Sx29gvr/380M3CE+fbX1a0=;
        b=dPTuz4SxCom+4Aa508HNNo04+unmluJDSHCTaZG7aAs10mmSU2IGVMN5f+hrDdb1p2
         HZtPmV+/u2LzugCVkkYPf1JR6I9mQVSD8Gl3gaLKE24+IH12TtVnDoPyjVxTPhwija93
         NgKNPnIl/bPtoXoWRvaq5dYTL6iohDwPtPFL4Lwr5xXKtMGOYiaCcM1Qwl/8OjvxByix
         L52qYo4IoX9QMrPDG3JjJPf3ac4FmPRvg7CleaU5VW6KppJKfwRsoFsLzthzZpFIYSdk
         eQgfjQMuVUiZb18uSX6KHZDxcLBHdAicOHHT0TFEVC9h3wn6p9g4x9/x643G6WFUfZ02
         1kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727706438; x=1728311238;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTy4NWgRgDq+j6izR3kA2Sx29gvr/380M3CE+fbX1a0=;
        b=kmuOM8+p0EN69jx+T/t37Qp6djeR0tKc5RDXcKFbepUHb4An9zhr7Qno+gFuUgXZlM
         hkmpEKtMuXG7e0x5WJhSbTAg73VigLUf1sZ65DJkv/gNa0d0tVvcwAcngYQM0ZtwSL7C
         4rvZOeqmdcBPn/Rn4x5yJd95AJnA9gJqTqIWE5qu15oQcGYZW3F4aQ6vkmkUvsBDrKBe
         GZJnxVldCzZsvwt3eLYOmby1K+Ra3x8U+atkM9RtVu3mVT6WeWHH/5HPL3Qg71kIhabN
         fyjKrjMDZm+xdDUck+vwPFWAxx74exi7bKNwiTJByS72i6ucgWd5Qbe5TdkF307lyF6q
         F5nQ==
X-Gm-Message-State: AOJu0YyqlS6Jyvp5OADdcBBuyNa5He44vGQIHxhFgy8n3KsfcDpYCSir
	51o5rOh+bmv3dwJpky4G2DiqhXXXlhHxYuv2daVJJww4CfznFaqG7Fuglf6afjAMTzGKAUwPSQ+
	+
X-Google-Smtp-Source: AGHT+IGkVkRLAnFMNBhq2ckUOemFjVtte20pPdMd8MyjD2M8rkjLNilgJw3+H78iaM35SB0WEslugA==
X-Received: by 2002:a5d:6585:0:b0:368:117c:84fd with SMTP id ffacd0b85a97d-37cd5a6b529mr7989547f8f.3.1727706437918;
        Mon, 30 Sep 2024 07:27:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d2e8sm9303200f8f.18.2024.09.30.07.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 07:27:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>
In-Reply-To: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
References: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
Subject: Re: [PATCH v2 0/2] ARM: meson: libretech-ac: add support for EFI
 Capsules Update
Message-Id: <172770643662.753773.10601289383991053323.b4-ty@linaro.org>
Date: Mon, 30 Sep 2024 16:27:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 14:27:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2426

Hi,

On Tue, 17 Sep 2024 14:34:44 +0200, Neil Armstrong wrote:
> The necessary changes were made in U-Boot to easily support
> EFI Capsules Update and be compliant with Arm SystemReady IR.
> 
> Let's add support for the libretech-ac/AML-S805X-CC since
> it's an easy well-supported target having a dedicated SPI
> Flash to store U-Boot.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/2] board: libretech-ac: move board support into dedicated directory
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8297f25e99f54b9ba8dcbf68a9299ca1b0022f14
[2/2] board: libre-computer: aml-s805x-cc: Enable capsule updates
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/0c4ad96cb7f7a6a771830f934ef333d2da0f2b90

-- 
Neil


