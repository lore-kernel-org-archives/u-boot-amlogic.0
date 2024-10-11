Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F44FD0EE17
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 15:51:21 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.15404.1728661872558167838
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2024 08:51:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=vYE53u8l;
 spf=pass (domain: baylibre.com, ip: 209.85.221.53, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4fd00574so1125831f8f.0
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728661871; x=1729266671; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nFjJGnsC6gWU++GrMe+WK/ovj8M050EAJFUXFQHBgQk=;
        b=vYE53u8lKM4Q7shy91huD4GhP6FbLMmaHBQGaut01FjsaDS9NBgy6Ieu68xg11OQZq
         C2onSLiccBr49Tq5u/kMsFtjbKrq6kUuHplT0+53BkplKnN9NtEYnMEFNB6URnkaafJI
         GPYn6Sxd8Yup0ob4XbvtLSSB6Vtu/4HewIfFmIdHw39Fhu/FH/azu+L+sH3CpF/O+ebk
         3ujzxy15cAJ4fLi5+0bFBy5zHhNq9YXpCBr26Y5+HcfBOqKK9peQudYzSKX9A6azUqoe
         5+vxPCepI/W5fEO6bYYpaaguslO7z3GdSHkbn5zgyLkSp4WRVuc5eO64qcnQGf9T+UpD
         Efxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661871; x=1729266671;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFjJGnsC6gWU++GrMe+WK/ovj8M050EAJFUXFQHBgQk=;
        b=wikRQB1vQHwg0ME5notTkzKne8cB6Sp9tfXZqkU2dMEMdSiwoVqCXuQX1+NShgUcvj
         wyzN2HBHLVuvLgtrJeydyobKIsMb93DK2iiF1x9sIEqR6Bcs1e8ZzjsHILOd5MBuwxse
         DSM3eppBzOjGl3YLJddO605g1vR2PQmwlzr5pkGvjuUI8742lV7jUUrWE/EX3fozVxDv
         iORy7ZUHzSNuuAaHVTNvjoy9QjKd2HJMoOavQpw8Iq+UrBTjX54Kj5oMXZeX2DJq4X+2
         AhjAWLRBI7866xFqEWbp8lNZ7Cav4Kd6PTOan8AH3doOQKufKgFaCX+LW9EjtT6nt5IH
         9DPw==
X-Forwarded-Encrypted: i=1; AJvYcCVS0JM+WB4XqvIjSMRYV6qDCk8t+8qoOYs01ZNZedz40zXovyaz7xb5PjKb+nP07QYEI57vbMo+1ecaHGp62w==@groups.io
X-Gm-Message-State: AOJu0Yw46kegS0r9RBCnRZkL6YXSOnDwhwfDlrlnlCz07fqz0dkXVLyJ
	5B0cyH81FQczeEAJ0kjmyIEpN/IMizaGbGv7/BDe6oa/Mv3P2Yrf7SY1RjL9X80=
X-Google-Smtp-Source: AGHT+IGhWVfXo6SmgV0cKYw/w/km0nsPPOW+VHTSBvLmsyRjPiacH+9O8FU/ieo2NqyTP3GsYbmdxQ==
X-Received: by 2002:a5d:58fc:0:b0:37c:fdc8:77ab with SMTP id ffacd0b85a97d-37d481650acmr5683597f8f.7.1728661870794;
        Fri, 11 Oct 2024 08:51:10 -0700 (PDT)
Received: from mkorpershoek-xps13.home ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d794asm45769005e9.1.2024.10.11.08.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:51:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 0/2] configs: khadas-vim3{l}: Android bootflow updates
Date: Fri, 11 Oct 2024 17:51:01 +0200
Message-Id: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGVJCWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0ND3crS7MTyRN3E/OIC3YLEopJiXXPzFCNT00RDy+SURCWgvoKi1LT
 MCrCZ0bG1tQB0uq0HYwAAAA==
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 15:51:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2447

Hello, 2 small fixes for Khadas VIM3 and VIM3L to boot Android.

Recently, some effort has been made to use the
upstream android-mainline kernel on these boards [1].

To use android-mainline kernel, we should:
* Increase the boot/recovery partition sizes (so that it fits)
* Drop dtbo support, since these are not part of android-mainline

[1] https://android-review.googlesource.com/c/kernel/common/+/3296472

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Mattijs Korpershoek (2):
      configs: khadas-vim3{l}: Increase boot/recovery partition size
      configs: meson64_android: Remove dtbo support

 include/configs/khadas-vim3_android.h  |  8 ++++----
 include/configs/khadas-vim3l_android.h |  8 ++++----
 include/configs/meson64_android.h      | 26 +-------------------------
 3 files changed, 9 insertions(+), 33 deletions(-)
---
base-commit: a404065479be2c1fe1167c3c91367e8194a69d1b
change-id: 20241011-yukawa-aosp-parts-77d255a19cda

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>


