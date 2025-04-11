Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68B5C369AF
	for <webhook@archiver.kernel.org>; Fri, 11 Apr 2025 14:55:41 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.28414.1744383334290390210
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Apr 2025 07:55:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=NU6hx1R3;
 spf=pass (domain: linaro.org, ip: 209.85.128.50, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so16855085e9.1
        for <u-boot-amlogic@groups.io>; Fri, 11 Apr 2025 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744383332; x=1744988132; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hUo/xxIeSk33E3I90k0hSLCkhtsyd01BxqbF5etgvbc=;
        b=NU6hx1R3isWXzrqAOJOKJ28hSiFMbZJHg84XqlW7ivVRrzJ/+HOFcKKgOJyLBEdGAT
         hcuew7L21+2noo+aSWD4aZlhsGyzSaTl68vhXU7XI43Ruk0/9kOuTmX57Mk9KlxyvTtc
         vDxgi8T5Nnwe2JbBmersVE5jOD7uxmb5iLN5/jS95upMFCormlB4K6wF8ckF1f0LtGOy
         foZbhtjFFtJSwfK+Aok5hvzm7slCvbnTf/B5vN8hpswfMfaIsua7kTuBrdXt7ST7Lukv
         nMY7Mj14/PyWbPgR+0U9KAQgSiSYaTeMy92QLKIzYFWCuXVqeS9uZiMzqbTtvMRgY/Lf
         S0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744383332; x=1744988132;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUo/xxIeSk33E3I90k0hSLCkhtsyd01BxqbF5etgvbc=;
        b=Xi25Rlr1es1sI7RvWXovXT3qvE0/4Xg0J0DsH4QJm8+dR58gqthqQg/Jmgiz9+4fQn
         47DBgkknmEYoVmPVBhUqLSsON9J7TY8B/Dc2TxYXlH64JC0qmbq8VY9uoMP7aLMabJ/0
         TEkxTGnPH7t+Vi+DYl0kmOQvfx0WsY0oJAScaVgBIvD9fhAGXxmI7+BeQe8lrQEsq4Y+
         8zYTmzcV5H3u1LPnp5XHrvMJ5V+xjj5i5h5pdX4rFK0/PMJ2YFOucP4wjFzyt5ntcGUQ
         Gfq8jBEMC5ZhucEwDRS5iUwKXAVEz4tyRJA3UX7FLqgdubMgjoKZUgy+FZMDy655j+2e
         gZ8w==
X-Gm-Message-State: AOJu0YyguHs9bJmddxs+XW3lRTujDpfCpSu7WObhpKesPGH52N70JZnT
	CCiT/XkqAoeNWEYegpKH6OjrhPR8ee5kCqIhNDV1qes5V5C0ZH5DTxM+yftCfrE=
X-Gm-Gg: ASbGncvmOxQmoLRu+X0mnkRSqGwYYDYwieRhHaZEWOj8BMvFokeDg6XzVXXVCmwdCZ9
	asaRv52DwiPve9GCUpLfHHdCH3o9bZuWbONVXot/HvppJBDFVvOW6BRUx3LP+t6+BtoT0eQvjin
	avcqBrDhfqngUZK3PADjA1rUnbOkEX8gbk4Cns47pN0LWmzgiUpwTTkG5OrkGcpawKaPHmhx6wL
	jUwbxtDpFFa/a5wpSJ3Y47oa47hbdw1FJVj5HVH0Nh8teTBmCTk1lDtQO50Nm1HFi3Fe4HYUY5E
	gvJAry+f+Ge+UGtQ27m2o7SDlvhNdNY/0zX28sYo9t/Fp3MBu0+fEWs5+YilgQ==
X-Google-Smtp-Source: AGHT+IF/k6f2fGkNmHIgVGlQ1f/MaZ/0zcOcGbqg0q4shKj7Z7s64EaCKf9pJ0R/EbHh6An/F8peVg==
X-Received: by 2002:a05:6000:2912:b0:38f:37f3:5ca9 with SMTP id ffacd0b85a97d-39eaaec991cmr2093373f8f.50.1744383332690;
        Fri, 11 Apr 2025 07:55:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eadda64ecsm2279119f8f.0.2025.04.11.07.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 07:55:32 -0700 (PDT)
From: neil.armstrong@linaro.org
Subject: [PATCH 0/2] ARM: meson: finally switch to livetree
Date: Fri, 11 Apr 2025 16:55:29 +0200
Message-Id: <20250411-u-boot-meson-livetree-v1-0-ebe31909cba5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGEt+WcC/x3M3QpAQBCG4VvRHJvaEZJbkQM/H6bY1S5Scu82h
 8/B+z4U4BWB6uQhj0uDOhshaULD0tkZrGM0ZSYrTC7CJ/fOHbwhOMurXjg8wNU0Sm86qUxZUmx
 3j0nv/9u07/sBpLNHOmcAAAA=
X-Change-ID: 20250411-u-boot-meson-livetree-8fd1b0a18066
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Beniamino Galvani <b.galvani@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=722;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nKOit0fq2sUwUDJGEK+Ty6gDjArDGGJQFnmD7JttoaQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn+S1ief5B0clj1m4w8uR9SxA4QmMo/rUyCYIMcdsH
 MSqvNfGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/ktYgAKCRB33NvayMhJ0XkuD/
 4ldkwg231SmVQrhULsImBA4yppSJvyjZEFdSN+/6j1PXQ0Ux5WmPShIE/eO5oXAGMkH48Y5A9a0mdK
 g6xYZvOTbT/FjP7MdCXKci/WV3r3jv7AIMCnRpB4MG+trboM1jhdlIdt5gcOLFyF7oeyJV4mgyCmpp
 hiAHYrd6nscp7ux2dJqrRSFRu48xZTPGgHrILz8/V+7852+iq8oNMemDg/9KNgWt7rWZei/XmXxzyd
 IXTSaO51VTkJ8SnGEaB9RryIxyMgxkNiHN6x83crq3l8WB5WMeVMiLHfISPWGlfXOLW2ClHGe129n1
 rli5oRWyocwcyO9ri06DopGG4CsyiVj9Z02SAWmZxpXoXeDtI9nbqERV0LMmOWOkWu0YrDvM/upovj
 JxB+yFMc6miBwxZMlkL8sB/mtD1WUr5x/YjErd5dJGhUI2OcGZn0yk/vIjVEDAOOh0sLEAlG4gcz2B
 DZGXFnFq8bx2Y51BRMrb9Va9sXOxAmCyA8ShHVwzPDVpFgglV4+IQLSBBxBqUAX+n+3zT71lYGFwMh
 DBEH5I3uIy71tmCrE4DLZv+fLoWE6FRi3CgRpXHeTlDl2rD/hv8cyu0SrBjbYjzyymzSzXsIcNsRYa
 tvub70OHCnUmH6nrVscIRiDUsX0QjWAYFiupBEtvAV++/dtFt5gQXD2/yNTw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 11 Apr 2025 14:55:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2661

Never late than never, finally try to land Beniamino's
"pinctrl: meson: convert to livetree" from 2017 to finally
be a modern platform with OF_LIVE !

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Beniamino Galvani (1):
      pinctrl: meson: convert to livetree

Neil Armstrong (1):
      ARM: mach-meson: use livetree by default

 arch/arm/mach-meson/Kconfig           |  1 +
 drivers/pinctrl/meson/pinctrl-meson.c | 73 +++++++++++++++++++----------------
 2 files changed, 40 insertions(+), 34 deletions(-)
---
base-commit: f892a7f397a66d8d09f418d1e0e06dfb48bac27d
change-id: 20250411-u-boot-meson-livetree-8fd1b0a18066

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


