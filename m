Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1BAC3ABCE
	for <webhook@archiver.kernel.org>; Mon, 16 Sep 2024 09:42:03 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.4801.1726479714639146312
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Sep 2024 02:41:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=oY49XWvM;
 spf=pass (domain: linaro.org, ip: 209.85.128.47, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so24222195e9.3
        for <u-boot-amlogic@groups.io>; Mon, 16 Sep 2024 02:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726479713; x=1727084513; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOcbqruUmWrhLZkKK60QRhwvF+7jnUdOWYFnWYS9Cqk=;
        b=oY49XWvMe1dqUTQRo1CiAgFb0C+pgcguuk4pON/dejNwnnPorOQpFPuSuOYHaKHx42
         g6Ty75N0+wqHb974HmLbP7uZdg4ByeVkkgjP6uz/Tm/VzpuDogOPE8vtxQVU8UmdQG/k
         o3DO7bsWKw1EvJVrN+IzacRNDgHBbZe5g1prgnH0SaqJPMRxxLC9qs4CCfOnVL1CIFkb
         eh/MpRKB4o0Lz198xN8XZBAuBW79kvy7Uo96ZjXXyAdur4FpoXkJlFhA/r/5cbZbdhyP
         p1IurFHTcoRO/pq/fmD/w73QtC+otpdhHP25JNOZB1RDSr0Vl/m3I7cWItN+pZWVEO2L
         elCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726479713; x=1727084513;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOcbqruUmWrhLZkKK60QRhwvF+7jnUdOWYFnWYS9Cqk=;
        b=gXPPvYKye6J3sn3SBbWndRyN9LKMW9k6Q9BooFyOSPcbNdSVP3WLjMLO3qEEhiKJXH
         qKLkfFm7LDug/596v+G4Y+1/Z7RhFnl5A1DgvZ4LABViDbJOAKhuzKAYAmYAyKxyBI9r
         hANqgL8GuhBfblOaa4ZHlOzKX/jLDTf1jVCVg/isOCf/P9JmRemieg8IcaM9Xhbz0gAY
         B36P4sQTuDy9FjnVPlWOYUlWmuZdBwiWTdjKtois3/IeRo/1aWrobSKN83bLN2M5jDbs
         IRbr7aRKhx3LLyU3Lb+O6f9iFzSc0b8nFYkrX4VUiA7ZQhIjNz/EYr840XpUdhtyaFIT
         rOkw==
X-Gm-Message-State: AOJu0YzkfmVAOEInhUQPiz7y5zPSxXlHSiIzuQERDzIYvDZ8Wb6vXb7G
	ikORyCGLTuXQ5/9wQG9AykUcr3Kx17Orz+zbMXzUo313G0uRqITVhZ5KGrGPpoQ=
X-Google-Smtp-Source: AGHT+IEkZCtMyHm30PNKdgkVipJTmP4B8zHKvi8kWamYZKZgZ6BsSHp1V7TJ3pLf+bTR2U3LRpK7tQ==
X-Received: by 2002:adf:f68a:0:b0:374:cbdd:4813 with SMTP id ffacd0b85a97d-378d61f12e3mr5352421f8f.31.1726479712789;
        Mon, 16 Sep 2024 02:41:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05d4e1sm106398555e9.12.2024.09.16.02.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:41:52 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] ARM: meson: libretech-ac: add suppor for EFI Capsules
 Update
Date: Mon, 16 Sep 2024 11:41:47 +0200
Message-Id: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFv952YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Mz3VLdpPz8Et2S/ILMZN2UyrzEXCBdWpqZoptoYW6YbGRqZGyWaKI
 E1F9QlJqWWQE2Ozq2thYAdG2S2GsAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vaGeJyXX/kpSSEtaYVEkfIDt/XINxBru0wwGOH/N5fc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5/1eFGVqKIdgQSVJqvwbSQUy4MKe4lnRQCcN73ww
 QBhOmUKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuf9XgAKCRB33NvayMhJ0RUxEA
 C2GkdY6Y7eBVYRMDG8ufdYIutpvrgVIUddVEGuStWXXuMMVD/xztPRmmtBt82/TOCO9z1jmTvMky94
 685T1Z5tDQ9WSbqYAUSAv5LxGHx1+u+tH/JKyz3K2qHRANR9F4NVUEK+UkKU7YyJL6Su3Hh3XJlJfj
 YmOj3pOnkX9ogw0p7lFXMfLEC1zZmopdxQUvSKI4lvlwNfhUQdaBfH3Sc46p1ZWLS0fRgYKVxeUVyf
 RbWb3Cs506o1EsG0LO5LtiDJ9dCFCiCB5JmDI9s97Mx6hCoIY3g0Y+A9tMYDzhBq3quHmm7Lkc2O8N
 oYFtt60VgHAAyS8CDEQwe87E6l1OA1Xra/MP31G1e2flaWEgyJJhhyw8960twUUKyJ+BFFTLNnQK/1
 9/B0ts/1wiOIRzPCSmu9MzeGx4zifAlCAVI4owNIoEuUIlp+nDD6cZ7XtZOB7yVFzfwWrS9VOt86Q0
 I4qM1VwK5t2F3qBb6036gXKI9RqoLIReOy4uRv1SSka3dk6LNeYspJIuz4agYD8D2tFcP4hgPwunHq
 pz4bJ0o0uswdaxvMOg0VUissHYN8qF2VxbTrrRv4RuXDS6ZblScNmoAxGN/s366+fj5nJ6C85sKjO3
 6dKgC31p/AgutUMiFj4xCSHVPBQwbAT9bBJ2kEhtZOrpH3mgrfakNPVbr3JA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 16 Sep 2024 09:42:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2387

The necessary changes were made in U-Boot to easily support
EFI Capsules Update and be compliant with Arm SystemReady SR.

Let's add support for the libretech-ac/AML-S805X-CC since
it's an easy well-supported target having a dedicated SPI
Flash to store U-Boot.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      board: libretech-ac: move board support into dedicated directory
      board: libre-computer: aml-s805-cc: Enable capsule updates

 board/amlogic/p212/MAINTAINERS                   |  2 -
 board/libre-computer/aml-s805x-ac/MAINTAINERS    |  8 ++++
 board/libre-computer/aml-s805x-ac/Makefile       |  6 +++
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c | 61 ++++++++++++++++++++++++
 configs/libretech-ac_defconfig                   |  7 +++
 5 files changed, 82 insertions(+), 2 deletions(-)
---
base-commit: df84c019c46e6833cc79385bdb23efba4882c09d
change-id: 20240916-u-boot-topic-dynamic-uuid-a871c25236a4

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


