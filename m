Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DD9D41C1F
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 10:46:31 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6653.1765449981735534762
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Dec 2025 02:46:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=HLcZKdzf;
 spf=pass (domain: linaro.org, ip: 209.85.128.52, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47774d3536dso7587105e9.0
        for <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 02:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765449980; x=1766054780; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1J3wTFCX5hYTGd87Jdwk6x5oPgkCI1MrQQZ+57Bc7s=;
        b=HLcZKdzfhIhfvNU0+8ijjMEn0r2tN4mTiiTChIoUPtvy0RHbUkq+bB40GD3cYtPjs7
         gkeYTzt179qVvXWaFCB32PD/HcKRRveL77ztStCQf6QnViIFbkBKtvt2xwPdTLR9nk4n
         rY42NxBfgRqx9bK07PELXL26tCcmhbcZLs442JCXYrJ8Mz/efqKa1chVdeszQbx2s96k
         h4TlDSUhw2Mp7NrM6YptDoV1fQmfsX71FElfoy1xHx5XdKPBxBFQh1+WpyucojbTQkJ5
         bTbwqQiJzClO/OTFzWtDHrdH3T0Qb7p7wUPQ3WMV4dsWLnKFCYpddPDQ5PvVtRCw6mG2
         Xubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765449980; x=1766054780;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g1J3wTFCX5hYTGd87Jdwk6x5oPgkCI1MrQQZ+57Bc7s=;
        b=T3yMLRMxWh7TfykNrRnmb/K7Ovl1Ig9izienytTJS/hXX6+Ldc3yn7NH9r33ivNDjW
         +mE6qlMtNi4Ql75eZWTxgHBPKEvqlPaS4oq7T0r1xhdqbuNdwhCzRIjjubs1r6y+Nxa9
         FI/KKmaG/v5reejml4XoDFpfAWK1U4D9+xwXiWLdZmLg2Z2V6GBB99jKW9Pv0J4nnmIt
         Y+mBBTbJu07QmmiFsLRGpPyWyT9nBxF2+dOfWR3YtuP4hqlQeb3hM5qG5R2115mSp8ST
         OiVBNyYodWGHp85otIeYnXIIHrizJtGTp2rSyGPI1Um32osfnbLMbR5PCDbR2EBDQx3C
         KzNQ==
X-Gm-Message-State: AOJu0YzIYKxgkmZsoKfViLiqq5b8YgHAYdMjtNEc79vPW7CKTsz222ks
	CxCnRuhi8Tp9lVJL3PVpSBnYAGdMYNyJtzOvB/7cqRII7FEVSPIvNItNrcD5R2sE5b0=
X-Gm-Gg: AY/fxX660IUSh3W9iZxqywLT9WQd38VKxBsyRCbcYHjejGQQvW55XuGKTEGPxwvOKQG
	brw8KpOjLRDQx5DsnjLezSGIWM4ZwNU63UWN23Dmty8wrxQNpSBQT9uW3SdsMMyVgnuWk93RY+e
	DGWOXrZCFzXAEwZwD9YrQ5y+fTvY7ixgueGjBpSQWrNQRGdf3Z/8EvQ0R/TDCBPgM9PeHjEm1kp
	3OBWMWQf3vj9wuyUd4Nzq4lckLU45ACpVjY/wp6rGRRKEhGjwPJA9P0U5hvaq1Nj9AKJPuG0NJZ
	583qqDsIeov2nH0DAT3PCS4QJezyC+Y5BsQSwzkMwFQ7ONBhS/DF2pNkHvOBzKtEs6IRiJCXO/J
	bWmg3TN9j2YV4A/4BStI5m+BEl5LgpOUX4xW/HiXTU2ExJ46SRPS19m8uuSyGT8y6ZMk8OTKFiS
	6FWL5njJjmqVl73dFRPUUwu26/HlNAs3bvbjBzLqfdRQ==
X-Google-Smtp-Source: AGHT+IGgpr3s78Xyl0opWnc5GrmRNTJAUO7j5mYMnyRRlBu5cmZvseh/MXcwvUyfCExbGol2PRQ+Rg==
X-Received: by 2002:a7b:c8c8:0:b0:477:a71c:d200 with SMTP id 5b1f17b1804b1-47a89ecc772mr11837645e9.11.1765449980031;
        Thu, 11 Dec 2025 02:46:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89dac074sm27548245e9.8.2025.12.11.02.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 02:46:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Tom Rini <trini@konsulko.com>, Viacheslav Bocharov <adeep@lexina.in>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Ferass El Hafidi <funderscore@tauchgang.dev>, 
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
References: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
Subject: Re: [PATCH v2] arm: meson: add support for EFI capsule updates
Message-Id: <176544997944.2550755.16914870841985844365.b4-ty@linaro.org>
Date: Thu, 11 Dec 2025 11:46:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 10:46:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2867

Hi,

On Sat, 11 Oct 2025 18:16:23 +0000, Ferass El Hafidi wrote:
> Previously, few Amlogic devices supported EFI capsule updates.
> Generally only the Libre Computer ones with SPI flash supported it,
> thanks to board-specific code.
> 
> This commit commonises capsule update support across supported
> Amlogic boards.  Similar to Qualcomm's support for it, the dfu string
> and firmware name is automatically generated at runtime depending on
> which device we are booted from.  Right now this supports flashing to
> the eMMC/SD and SPI flash.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] arm: meson: add support for EFI capsule updates
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8758e1f67a38e707a7c85cb173f5a8d9324c897a

-- 
Neil


