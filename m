Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F3BC004C0
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 12:41:51 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.119337.1698064906607853660
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Oct 2023 05:41:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=o829axAR;
 spf=pass (domain: linaro.org, ip: 209.85.128.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso3511615e9.0
        for <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 05:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698064905; x=1698669705; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5cnPFABFPBFaCPTSr4ChUhUhj5DMXSyZtG+7/7ZXQNg=;
        b=o829axARyW6730IC1g3XxR8kSWfixJuoQfnfQ5/yev6smc6kkZZ5eMcOjATT8B2s8X
         Hv2SnsSdkn5ge0VTrhswPs1g5bN6f2X/wTMNMC5v3DHQnKIA0fMXMu1MVjFoUXUGeSTo
         oC9wlL8j83IRWzE0uKjqMbWWAoZZ5ncVdFD8UbxR+9/LOVU4KoEl/gDOZIdmx9+mw50B
         REjfj4BHYrrUKAsDz/2hWy5Iu9DTuOoGlk27LSPNoaexUbrHjWBACQKQvsWYJylY7emb
         NM/dGELz1BxDdesDcgT5PR/OouXR7/88KBL5TcSOTjRbdkyGy+6apMuKW2A5u8TEl+MB
         djBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064905; x=1698669705;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cnPFABFPBFaCPTSr4ChUhUhj5DMXSyZtG+7/7ZXQNg=;
        b=qbmiiOseVpev+o/X/hzP0xJ5FdNS4sGiG1F0gWwSDVTaSFzc5Qm9fipoBQSVeaRXVe
         JVSErPMBvwSwjQVEwJfR8mVOC6WpaU7/cuDgPnVnODm/blawE0FWmt995nW9Myhp4i4J
         ZXeIoyos30GK97+9UGrtchjUdl9OJCTrEkjlTbWEmp5xYVPjUf+PdIEpmD6wuVAaB3cG
         ODrPU0NI0qMELtRo+gLxSXS0cZSo+PvaQmWrZT9RhdkkUIOm7NZ6aboR4WLV9OUyszVK
         CqUCV5rYVnDX7jnZuvjKRYHgcZ4xs/LxWZOqVbVaAjvomd45T2cbfOHQtWKffEUPc14v
         P2EQ==
X-Gm-Message-State: AOJu0YyKup+3/tXxvwhO+t4l2r7dKSPCKD+b+jP308dMMy1Fu9DqmFO9
	VNB9swVwXkdVaXIvwU3u4tRBzA==
X-Google-Smtp-Source: AGHT+IGtj8vSl5FaJtybvMrLCUrtUklR9aCw158giQgef0PTTl96Z+ynYX8LOIDarZl5dBUZza/pVw==
X-Received: by 2002:a05:600c:4588:b0:409:7d0:d20b with SMTP id r8-20020a05600c458800b0040907d0d20bmr657350wmo.24.1698064904970;
        Mon, 23 Oct 2023 05:41:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003fbe4cecc3bsm14230609wmo.16.2023.10.23.05.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:41:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/4] ARM: meson: Add boot over DFU RAM as an USB boot step
Date: Mon, 23 Oct 2023 14:41:33 +0200
Message-Id: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP1pNmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDINYtLU7STUkr1U3Kzy/RTTMxtzCxTLNMSzI2UQJqKShKTcusABsXHVt
 bCwCNnvptXgAAAA==
To: Christian Hewitt <christianshewitt@gmail.com>, 
 Vyacheslav Bocharov <adeep@lexina.in>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3451;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nbBq2P4CX/p5+oBzaDTLTAOa9TdVkm/K0vgzlOTLf+w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlNmoDMTRDZk4gBKDWTTYX1+Vd26NiMZaC6HWJ6
 DiHrBOLaw+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTZqAwAKCRB33NvayMhJ
 0dR/EACYhACtvu2uVmL8H9ZMH9ZjzJiRt/b7qze3WCu5zaA90U9FdC99tv4BjHOw5d5phD9XiQB
 rsDb/tkLFOxISKGkcdLHLL7RVWId1tj4O+w+TuhcvrPZcbhBknwGPgt4Ja9vB+Eo2UdpmlNpIp8
 9WaoMA0rBS6kcsi5g8NlYJpXXm7z2t92hcGyDAwUKb5czqTqrfKaVYaz0VhqNY1jgc60eYsm2ro
 k68iCAXxvva/1ayNKa5wqvLrfsmFaNisYUIHTnE8R1YiqZaBE7jU213cAR0zqTn+SxOZqCzWI1Q
 gT8yZH4+tChDNOLlJNh1eeHqmxgVKp56LvXsor8DIh36/RyNPj2/ro+WFs7jfhRUVq92fDnMEev
 UwjG5yQnL+A8YanDkxeXz+Oe12G+0Cn2STJfFZvzd72xU3qoG3LqwqsZP2UFLjKRNIesLuS2Ok7
 Oua4fHEq+5BlUD2ItnIOJYP/zDWOctCM1B1yl3hnNkEpO/8KToTnOt9kyFzr6iImhamprz3sqwM
 d3MCAuDk57KyRQXp1SCf5IakAXZSk171yjlCOtXZ+J65IDHZ1Qo+sB3XoACtIW76OmdLA+wEekX
 fHVy90JGSIljm/RoQjiHPQAal8ZFe4ESTOh7jyX4R0nifVEE9fx3sX34iyEl3Dm5wRPvwBYneqR
 FqekqwpEovs7ZUQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 12:41:51 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1789

Add boot over DFU RAM as an alternate to running script at
a fixed address like done today.

The main culprit is that it's not possible to do that
on G12A/SM1 platforms due to changes in the USB boot protocol.

With this, U-Boot will present a DFU device with a ram slot where
the Host could write a fitImage or legacy U-Boot image, then with the
detach command boot will continue trying to boot the uploaded image.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (4):
      ARM: meson: enable FIT with LEGACY_IMAGE_FORMAT on all configs
      configs: meson64: declare addr out of EXTRA_ENV_SETTINGS
      configs: meson64: add alternate USB DFU boot target
      ARM: meson: enable USB DFU + RAM on Amlogic boards with USB Gadget

 configs/ad401_defconfig                   |  2 ++
 configs/bananapi-cm4-cm4io_defconfig      |  6 ++++
 configs/bananapi-m2-pro_defconfig         |  6 ++++
 configs/bananapi-m2s_defconfig            |  6 ++++
 configs/bananapi-m5_defconfig             |  6 ++++
 configs/beelink-gsking-x_defconfig        |  6 ++++
 configs/beelink-gt1-ultimate_defconfig    |  6 ++++
 configs/beelink-gtking_defconfig          |  6 ++++
 configs/beelink-gtkingpro_defconfig       |  6 ++++
 configs/jethub_j100_defconfig             |  6 ++++
 configs/jethub_j80_defconfig              |  6 ++++
 configs/khadas-vim2_defconfig             |  6 ++++
 configs/khadas-vim3_android_ab_defconfig  |  4 +++
 configs/khadas-vim3_android_defconfig     |  4 +++
 configs/khadas-vim3_defconfig             |  6 ++++
 configs/khadas-vim3l_android_ab_defconfig |  4 +++
 configs/khadas-vim3l_android_defconfig    |  4 +++
 configs/khadas-vim3l_defconfig            |  6 ++++
 configs/khadas-vim_defconfig              |  6 ++++
 configs/libretech-ac_defconfig            |  6 ++++
 configs/libretech-cc_defconfig            |  6 ++++
 configs/libretech-cc_v2_defconfig         |  6 ++++
 configs/libretech-s905d-pc_defconfig      |  6 ++++
 configs/libretech-s912-pc_defconfig       |  6 ++++
 configs/nanopi-k2_defconfig               |  4 +++
 configs/odroid-c2_defconfig               |  4 +++
 configs/odroid-c4_defconfig               |  6 ++++
 configs/odroid-go-ultra_defconfig         |  6 ++++
 configs/odroid-hc4_defconfig              |  6 ++++
 configs/odroid-n2_defconfig               |  6 ++++
 configs/odroid-n2l_defconfig              |  6 ++++
 configs/p200_defconfig                    |  4 +++
 configs/p201_defconfig                    |  4 +++
 configs/p212_defconfig                    |  4 +++
 configs/radxa-zero2_defconfig             |  6 ++++
 configs/radxa-zero_defconfig              |  6 ++++
 configs/s400_defconfig                    |  6 ++++
 configs/sei510_defconfig                  |  6 ++++
 configs/sei610_defconfig                  |  6 ++++
 configs/u200_defconfig                    |  6 ++++
 configs/videostrong-kii-pro_defconfig     |  4 +++
 configs/wetek-core2_defconfig             |  6 ++++
 configs/wetek-hub_defconfig               |  4 +++
 configs/wetek-play2_defconfig             |  4 +++
 include/configs/meson64.h                 | 49 ++++++++++++++++++++++++++-----
 45 files changed, 278 insertions(+), 7 deletions(-)
---
base-commit: 9a0cf3993f71043ba08c315572c54622de42d447
change-id: 20231023-usb-dfu-boot-f47849f9fb34

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


