Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689FFCED63E
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 09:15:29 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.12059.1728465325490729202
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Oct 2024 02:15:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Vo36lBFO;
 spf=pass (domain: linaro.org, ip: 209.85.128.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so5961445e9.3
        for <u-boot-amlogic@groups.io>; Wed, 09 Oct 2024 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728465324; x=1729070124; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eDwNUDP4H+tYsTjvteRwPnLJvmXBQqk9NeBIefz3auQ=;
        b=Vo36lBFOeHJritOU/uckqPwJkOxJhG2qrRk5aGqDXfISVGd/x7YxJz77tHgyEXGFBl
         fXhSkTc5uu1s2m+uZkAUnsSo/UtlcAH4rHZycD0dKeoPPEfKNp5NPoWXdEIEb/ogRWc9
         lr0+gXAMnuHaJ9iabdMoFITZUotvAIi+pBpbK1PQUI1rrVs0rpgfioT1YjXM7A81sv6Z
         vkVp0TsQ/1OIMETjOrVspFQIKog9hdqEmTd/Puq/mRjde/mYJz9Yug0G9RjiCtbTzsBP
         x9GJSqpj2XOuCZIA9+ASBwUk50mZBq/yTmMINPoEinvRqLGE5HUeaZuPXodhu8j0rJbq
         4N5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728465324; x=1729070124;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDwNUDP4H+tYsTjvteRwPnLJvmXBQqk9NeBIefz3auQ=;
        b=HEmRAYdCVpTpGJptxQ4ACBq4g4DpEUyOO0S9dzlI5BV0gxrH3SUrOchiwjc/9LSc8N
         rGwAzeqkaSMQ9zydt49SGSkpXlJrpljg90fydKHrQiQobw1QaldJr9Pd2VkMpzTHlBwN
         MnvrwG1HMWYWtVyRqFMwGMEPN3lYOb1cklR2P4Q3Mm5TL9YYw83AdUzrlFyFKs4fWuAj
         5v5tyLD1tsb8YObrSlmgw2MFeIilnHgVIa72BjfYZJrj0aECM/AsGF2qcPXHF5U+sGj8
         zfgLDlSeEzinY7tEwZU9arZGulQDb08TPlazjcENNLTKHPQgWkKKNZH0WBzRfo0DzAbT
         oZmA==
X-Gm-Message-State: AOJu0YyWR+k+RDsdat4lw/iyE/+qDvCETi5/liXXTxpvTF5ELqwiNx/X
	K20bjh7d4jyyvmcdCh86YrJp3ZdVNFqnvWfwKHY4kz6+aMAVWLtPdr/ZOqUFMnM=
X-Google-Smtp-Source: AGHT+IHgItw8ojQNW3ruLMKSzWiZREHmW+1sMJlnqWGZcEEA29GJ8gv5u9yDl7G4Xg+BPe9bylAJ1w==
X-Received: by 2002:adf:f850:0:b0:37c:c51b:8d9c with SMTP id ffacd0b85a97d-37d3aae2866mr1459753f8f.38.1728465323570;
        Wed, 09 Oct 2024 02:15:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f270sm9865471f8f.21.2024.10.09.02.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 02:15:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] ARM: mach-meson: fix HDMI since DT update to v6.11
Date: Wed, 09 Oct 2024 11:15:19 +0200
Message-Id: <20241009-u-boot-topic-fix-hdmi-v1-0-2479cd90c4ea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKdJBmcC/x2MywqAIBAAfyX23IKV2ONXokPqlnsoQy2C6N+Tj
 sMw80CkwBRhKB4IdHFkv2eoygKMm/eVkG1mqEUtKyF6PFF7nzD5gw0ufKOzG6PWTW9s1yopFeT
 2CJTd/x2n9/0AAjvBE2cAAAA=
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=757;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=l8XmijvTwm7w6IFh5f/hbeLXZrLruekZ0b7APjEkvUg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnBkmpxUSEdZRLhfrlK5id0Wc/9lEeuVe/qDpfHzV9
 t2sd2/6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwZJqQAKCRB33NvayMhJ0aRHD/
 9ipDxV9NvPhyRjezNZejvaKQgqEyEZkIJB31pCb8rcB3RX6Kv+9gydMrnCSJesauzizUn1roGQXdy5
 6FycVlQ5NCe2NWO6SCyhSmLiR0dGwl4M5+YXdNKU6xDpw9QSeJoDoiD+nlHdzomGePGkoMkJJKV+UE
 9PRYQLjAETycrDy/nUJa7PEWAE+JsCL+XSspZ0hrkxOgSe3LuorNRglZpVKFtSTRDhlBObYuP6qpTv
 QXb3hoOG99o1tuIfvKE6vIq92Y0oC07n+kGNs72kcA3cBhvOrWC6ldENVGRFn3yn5piUmVu30glrrc
 VFoR6fqKudeoFeI5onY9fY5aILXZTauIo2Dvz+Vq6rkaMl7IrFLoDRuvUMKAXntxV0rickbdlAC9sJ
 evz8sKxDZbzd6AiEPfSOyYUemDb3u0b9phfBAAy8TG6MyByY+y79JWwlukTCOO4b5Ltx9xOObaeGhp
 dJ4QFGHxDpoaZ3F28L1k6BZ2UwObb2/NrOdNS0DYwnze5MGZ3Kn8l4NG/h1bTJbbaTONTYQrT/+vYx
 AFNJac80Xw90nMLg4Mwz54DhyzpvBBSUaWaWXW4dN2KUMdHDsledjIDrhDxpdFUZ2vt7ddL5OcbuJc
 hJNbdJV7CLq32/lvn2/SsHvI+hWC8yLN3lsejQ3GmKfQJEiy+STDGBI+bQIQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 09 Oct 2024 09:15:29 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2434

The DT was updated with unhandled clocks and a shared
power domain, causing a probe failure and a green output.

Add the missing clocks and avoid enabling a power domain twice.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      clk: meson: gxbb: add HDMI clocks
      power/domain: meson-ee-pwrc: make sure to not enable a domain twice

 drivers/clk/meson/gxbb.c             | 50 +++++++++++++++++++++++++++++++++++-
 drivers/power/domain/meson-ee-pwrc.c | 15 +++++++++--
 2 files changed, 62 insertions(+), 3 deletions(-)
---
base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
change-id: 20241009-u-boot-topic-fix-hdmi-bb39cd876446

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


