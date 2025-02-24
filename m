Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4C9C021BC
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 19:54:18 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.99121.1740426852623335727
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Feb 2025 11:54:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=fb6E9prX;
 spf=pass (domain: linaro.org, ip: 209.85.221.52, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so2706470f8f.2
        for <u-boot-amlogic@groups.io>; Mon, 24 Feb 2025 11:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740426851; x=1741031651; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDKHSE6ZfR8soxKP8JY1D+MdXuWHpGO3JPz0sJdX1RQ=;
        b=fb6E9prXCEmW4Vlo5Swf8Cf4yLFbttpb6gQ7LWZyJPWItPTHHObM/0SJnCSw6/4H9U
         hF36NTCzfep1SEI1FCeBjRV0XAHW2iHlGPL3Bt6/PGFNGCXoqtfOb3ksP9pt5BK6jm5M
         Wyv4lmx2fa2IxMZvy3o9WzskeMIElEoy2ota9x6OQI3ZD7HZjLaDfZforx4bHyP+0fzP
         mmOOQ2p2zaSDQ9kAEgggvL39rPDBz3MWLW9OEq7aySQHi0EpDfEB3a9tPkEDWWGlG0IP
         x9Bf26rBGRz4qFL3w43TbAxv9h4xrlYoCY0A0RekVk7ZygxwPSzh9nAo4ewkgkb0ZGFh
         rwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740426851; x=1741031651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDKHSE6ZfR8soxKP8JY1D+MdXuWHpGO3JPz0sJdX1RQ=;
        b=p1hLvYGcQB4KtVPKax0JqKKjIs/dT/jTIPeAJiWZu0LN1p9YiPI9LkHUSw3wZLfQNk
         WaUsYJ1zjME5RGxcOfBLOxeZ5YUNDOUSLPhs9K1N0WeW+jKQAjYUv+vrefL1+T5Nsacn
         aOoxxRI414ah6BX3yD/zg0o6fuSH9J61/0ZzRCcyzqaJnFP88qYOsUkElyjt26mUk2o5
         utKYx59Eu+oPPiysMJTlp0tNBcaNeePNKrVad1M6mSYjWFDVVCadwL5ILI7bHiLy5nqM
         c/VS/sAgdZ9wafmVe9vd9BJutKYBWV8IsXiAJqlftMWcrZ+DxNZ0I1Afi/aveZ9+ioNW
         CnXw==
X-Forwarded-Encrypted: i=1; AJvYcCUCdvDdMihW28QqVDuElGoskumDkZuiC58BWi+BS5jQYeEuEd6xIjRZu2EaO8rXN3yqpRe8J2eZUG0rp5l68g==@groups.io
X-Gm-Message-State: AOJu0Yy81lo6A3zZpcJ1lAG0skEXtG0mFuTqX3Er2f2EVZI8LoEPwvST
	P9thM260aiVZaljWBtgQLQc61cfgtCzJJWTTcAqbEV28gbh0rqqLwaS3W3sPSPials3Gh0GqqGB
	M
X-Gm-Gg: ASbGncsMQaGKBZErLUVSwUVQdQ/Wg9MsQRBKs47Ce08dd3jWrz/WMNmI3qN84Te8w7a
	8vo2c5cHdKoLvS8NT0IT9cgePM0cY98uxA9jdaDCDNSvZdvFPtJEVITBuT5+6fjg001smgPehPN
	dyttRu9s921An4kHE+e5tXjomVmEnP3wIUgtbPWUHoT+MrV5wjLMRuL3IpxgCkwgidTplBnMlex
	VQT/XDyTuv5XBnycl9HJ6pzFkIGyvG83QSQjOvKlsu3bdhsEXC7hQ76l20t5EbV6QjFLWLvdBgI
	KRC9oZR2RDE+/KxdbWExe39mFmZFSZDSkgmo701lugjDaLI=
X-Google-Smtp-Source: AGHT+IFWjEkA/GbJ5vuUamwOu8pCrHw410vr9a61+YuDcrwRMY/vn0b6/gHzxnGCb0ufFQq0geX14Q==
X-Received: by 2002:a5d:59a3:0:b0:38d:e15e:17e9 with SMTP id ffacd0b85a97d-38f6f0b2161mr16193983f8f.35.1740426850894;
        Mon, 24 Feb 2025 11:54:10 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b03675dfsm115992285e9.29.2025.02.24.11.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:54:10 -0800 (PST)
From: neil.armstrong@linaro.org
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] arm: meson: extend sm calls to support Amlogic chip_id v1, v2
Date: Mon, 24 Feb 2025 20:54:06 +0100
Message-Id: <20250224195406.748700-1-neil.armstrong@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Feb 2025 19:54:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2625

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Mon, 10 Feb 2025 20:50:13 +0300, Evgeny Bachinin wrote:
> The Amlogic Meson SoC secure monitor (TF-A) handles a call (0x82000044)
> to retrieve a chip_id from eFuse OTP data [1].
> 
> Previously, this sm call (0x82000044) was used to retrieve just unique
> SoC number [2] (a.k.a. SoC "serial" [3]), identifying particular die.
> This SoC serial, stored in the eFuse, is always 12 bytes long.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/3] arm: meson: unify type being used for socinfo
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/bcacf50d9defd49f12335866570fb41753bc9dc7
[2/3] arm: meson: sm: get rid of SM_CHIP_ID_SIZE
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a64a4149e39b574bb8d550da1356209caa75274e
[3/3] arch: arm: meson: support Amlogic chip_id v1 and v2
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f6b4f91117984a3ecba486f728b9619e75f06d52

-- 
Neil

