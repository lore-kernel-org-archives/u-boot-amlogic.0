Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF19CD11DF
	for <webhook@archiver.kernel.org>; Mon, 25 Mar 2024 08:18:20 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.46874.1711354691873905781
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Mar 2024 01:18:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=b8hFI5IF;
 spf=pass (domain: linaro.org, ip: 209.85.128.50, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4148678b307so5611165e9.3
        for <u-boot-amlogic@groups.io>; Mon, 25 Mar 2024 01:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711354690; x=1711959490; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vn1W2ruOodemTLcB+pbYYO0c3qegjIEhkk51wov75ag=;
        b=b8hFI5IFlihxVSRFRFpQwcbvRfriqPh5Xe1FS5tSFXO4LslvSS1foyoUD/EZy8te9i
         3k9C6BiKr/VeItwJ8mBXXj3Jqonvb1T8FPj/DIF77UdhnkEOIrAds/uieJyS44sqblKa
         zwophed7tZ1Yt3I5moQyXU3vZ5a2C+n9kUt48FzqpFx/tW10sHxb5/l8byybm6AstZ7w
         ZJwcjsqnxPRLUYOwTIYZb8yuXciyVrIlv1CQA1lAxfFS0Rc752mJe4V2cDYdXsGdJHHN
         TLHPPZh3KTdGp4OtXYdWGbpaO/nxJQ8odGCCWG2q7dFtI82nOHD189NuuN88VDfuRfDB
         eDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711354690; x=1711959490;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn1W2ruOodemTLcB+pbYYO0c3qegjIEhkk51wov75ag=;
        b=E/xqduoysHW31QRvoor9xBnxUxmckDnvT7Vl8+jWtokU3jvIStSkLwHaUgDDJ864vY
         2H5qQr8YYR0O6N2bCZLXNCks1uRbgqAdVDyItz30e43ziIVYA6I5sN7WzwPa43kunzmy
         QLDNXbIzU5Y6a25kGzsg5NuwQ95RdT/Naqdc/I6wrb6sml36cr6BiQjskuVlAPHlxLhW
         cceyeOzmA2EQIaeaOaM9bA5gNPViDw9ZB18xKPAfEM08k4btIOiC2kLJ+KMbGt9aKmNN
         /2PjBWIQ8/WmYh8iiDaPRFMuSDjAh7OlIreae8N64HfHwDwWVZIgslDWrDfIy1q96rah
         UWkg==
X-Forwarded-Encrypted: i=1; AJvYcCWLFrytG4jyWBgS9Fte4vT/jD1nZwPh7jIzFggBYIReFT9f8TbHN+KC8sQFk3or4wUR3vAHLyfPcWpHA/qB5qLb3/9JsrVRosg=
X-Gm-Message-State: AOJu0YyGJqtyZUtUcVqbauPkhvLti5kruc/RaVPnFpMVcZGVapDcQIp/
	S6vbHFoRtwxBBAzCNmbMluMsTp0bvGqqG2wTbkBvVrq+D3I9wgz1pJMHFvFSmNA=
X-Google-Smtp-Source: AGHT+IEnIbCEhnwyDMPL1uDQFsxaR2kmLl6kkQkDTep/4JxGSJgMaqv97d6aGdotW2UExKekvSKGXw==
X-Received: by 2002:a05:600c:474b:b0:414:8948:5f88 with SMTP id w11-20020a05600c474b00b0041489485f88mr1655577wmo.0.1711354690057;
        Mon, 25 Mar 2024 01:18:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b004146750314csm7686212wms.3.2024.03.25.01.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 01:18:09 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 linux-amlogic@lists.infradead.org, 
 Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20240324151905.3817732-1-christianshewitt@gmail.com>
References: <20240324151905.3817732-1-christianshewitt@gmail.com>
Subject: Re: [PATCH v2 0/2] ARM: dts: fix Ethernet and random MAC's on
 WeTek Hub/Play2
Message-Id: <171135468944.4116391.11813937820801790173.b4-ty@linaro.org>
Date: Mon, 25 Mar 2024 09:18:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 25 Mar 2024 08:18:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2243

Hi,

On Sun, 24 Mar 2024 15:19:03 +0000, Christian Hewitt wrote:
> In submitting the original patches for WeTek Hub/Play2 I appear to have
> squashed an experimental change to place the u-boot.dtsi file on the common
> board dtsi, but this was incorrect and results in broken Ethernet. Patch 1
> creates per-board u-boot.dtsi files to fix that. However, while the NIC is
> now probed correctly the current p200.c board file doesn't find the MAC in
> efuse and we get random MAC addresses. Patch 2 adds a fallback method for
> generating a MAC from the CPU serial.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/2] ARM: dts: fix Ethernet on WeTek Hub/Play2
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/cac77418d6be11445c3e1139f6763b5f5f5fe9fb
[2/2] board: amlogic: add meson_generate_serial_ethaddr fallback to p200
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/65d5c367b00cb392bda560c3da1834979adcf137

-- 
Neil


