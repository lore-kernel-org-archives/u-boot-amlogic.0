Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E0BCA6014
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:20 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14768.1791463577608905438
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Oct 2026 05:46:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=adgKxN0V;
 spf=pass (domain: linaro.org, ip: 209.85.221.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4649b35bso5102183f8f.3
        for <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 05:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791463576; x=1792068376; darn=groups.io;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mUjeBvKQoHp3KF6Il3orO20Bhd5dhm74ocZFNS+U4P8=;
        b=adgKxN0VMmUc8ri68wGNXxKRFxsenpc2os8gl8upgbyfuRmaZJ03mpnTwMLc+VQjjK
         KU1LeG6cbAo08buQrBQsx8GW4WlEP1snYQI1CnET0hVOE19QWxo++mAp3NZ13j9H3cF4
         Yg8DvX41uJWaWQX9lF1nA07NL0/EwNwFXZ6U1n6ITYnAcDFDuhOEJsKK43dtG2uAQR5w
         FYDOb9FjaDpBGaeenRX+3VDAJmE7cyWyR9DAyKSWqs+5D7XT/lApSiTQKU/6HrjUwKxu
         vazdBmCA9EdCfuERKVbunfpRGh2W0MerqZozSmhb0+ardUabWr7ryzO4hG29Oo+Q0XXo
         RM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463576; x=1792068376;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mUjeBvKQoHp3KF6Il3orO20Bhd5dhm74ocZFNS+U4P8=;
        b=zS2+NO+zlgTJ8IMIGHn4EqlExX86rILduS9rlabW+ychS0gXrbCLlXGV1VNEERr31U
         6TkVIS3uvDChVp1GOYtpDNQeB7JWT7kAtk41gv8yBteuY90cbDuKQNN59kPFrZtALJhh
         aUe2ek2koJfU9TrwubUBhwQchI1GakyGs2fCpNKKQBsxhNuDtZPFoB1VyxicNbsDMODB
         sJYdP/m/ZIHzcWNbSL1A3oj5aLMnv0C0sz4xMVx5RHVSbUJMKQspYqqoS1pW+fEegGgw
         4vObeeOAClgFIAihZZIGFX8ldatmnjkkU+KPvtImkXKDpCQv+G8rQFiD2SENnV8JTCeb
         TihA==
X-Forwarded-Encrypted: i=1; AKwUvBxBaFOBGfRhtMec3eAAF43BjnezrBLdhbvckt7ml3mqk404yKJB5xV3NtlZIXZYC6XczF5sp77f6W+NNUEj/Q==@groups.io
X-Gm-Message-State: AFq9FYI71x5k5NJ5sP3OOYqs6kvAJmnppYFkrYyE/rDFEJbrI8D0dMIR
	jyDXpcxW6uvnY1eab7hWvY/FBJDGSJFYszWUM73lOrczOgR69wm8X2BhjRGDqLDrucs=
X-Gm-Gg: AYBFou3AVKF7DMRyAEqmi+XNHPSHTTaZdii5ZYD+3dKO3yzYqWnAzJ05aqMS+fOb7G7
	4kovpsVp+jgQpo8E1nHEtyh98/GmvPivDj0qqQfOC1iy5a6RXor8ztHNPGGxid4d4PtU6CmtWpO
	xAVwSfgO5XFVsoP4lsy4/FGqjtyRMDZ94W/4zLvtll61z15fl/NhGu4YI/PPF0nVvWbscO2fHPO
	eX5G63f46HkN0IGHDJMW4UMOVg14NWihlCLCtVnuXafX8IpHvsg5HceloOv1lKrBwiZ5B/uZ8EE
	RO6iQmg/LWkR+mhxG0V0h5xkAYxEOaX/nGYj2lVXuAun2Klo6Le9ADGxu0VMmKHPHKU5i/TLHZh
	r4YJc4fS70zpGdlb6SH0cbt+MkN4fOiGjHG08S81Lm7ldjhOv7rW8WiLvWOL5eab++cNJE3j7Ux
	bfJhupoQHSAvriQK2htpGTGQUTkSETSwl6ryp5HaNlhEHoy493PalTPv/rgwHDtc7HCTLAg1PTM
	JfH2AgVCpprGlG6vWdPvrz/Gcu0cLs=
X-Received: by 2002:a05:6000:989:b0:48c:6955:a603 with SMTP id ffacd0b85a97d-48c7278fd23mr9553770f8f.13.1791463573840;
        Thu, 08 Oct 2026 05:46:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:46:12 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260824132518.522252-1-sanderson@brivo.com>
References: <20260824132518.522252-1-sanderson@brivo.com>
Subject: Re: [PATCH v2] mmc: meson: Parse devicetree properties
Message-Id: <179146357210.183177.3661541259972957816.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 12:46:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3120

Hi,

On Mon, 24 Aug 2026 09:25:05 -0400, Sean Anderson wrote:
> Parse devicetree properties so things like max-frequency are respected.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] mmc: meson: Parse devicetree properties
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f7e3eaebd300a0e2afdefc54a5c5ed6cb35e5aa9

-- 
Neil


