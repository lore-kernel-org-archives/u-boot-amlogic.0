Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F77BCED622
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 08:02:09 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.11037.1728460923036604816
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Oct 2024 01:02:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=n9POohL3;
 spf=pass (domain: linaro.org, ip: 209.85.128.42, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43055b43604so13314755e9.3
        for <u-boot-amlogic@groups.io>; Wed, 09 Oct 2024 01:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728460921; x=1729065721; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrizSI+ELeBvfxtAi3OSK9ynlbK/KOEjGCmCUv3PK3I=;
        b=n9POohL3VZrMNVrPAIXv08R5P20tfRPcFm5p17x/3PByDyFzv6e/4mbXsy9f5llpin
         zZPWXPhHMTGA6epR0IQBI4QFPRUmce88TShAozIrRFn/0lrz390Ctf3TaCZ3aIDJcgFo
         GT33lLzKG475+GZzZ+9NSLfKBiOjvXBsvbf3Lj/M1vFashUoF06D04lEJTPdr0CBY7G5
         uRq6ijtzcXJNk4tgszNh5B77nCac0qVGH1J/pk3qoPGMcH2SXEoYXxrUFV6OaJmiBwAy
         tid6MEiZQuBKcEYB4ZDLK7pwq0XQqTYPfabKVSUrApKeWhONGJVeLXBAon8EVqPuykkb
         0wZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460921; x=1729065721;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrizSI+ELeBvfxtAi3OSK9ynlbK/KOEjGCmCUv3PK3I=;
        b=BySj1zXlr3TF4nysk76J4953djZhmARwQbVGdzJKnb/ZkYqZXV3yLKUrcKAg/Yh2bn
         C53caQmHjrcgcU+8arynVa16GwG+P6MlIRMxYvjVtPns2UXjzQ1BFzkFgsA8fu9vBmRZ
         0PPvXT/bZM8JNql9bHZ/dahakqkxWNCS55AoUUZhv0eCrZnt7ZPokQ29m05uRbU5vgPD
         ydSYJJ3ZVi+sgn4/38F6ZJrvpZa3te9yru11rBFVqMVTisdk7FNNQ7INuxbjlQ0fLfca
         wkS9bXXx+LRiQaVLIaUnwjHbH6wWMVR2vjhdii2GSS67Izj3OoX+Gzjn+aDzcfgpLBpG
         62NQ==
X-Gm-Message-State: AOJu0YyJ2+hDHdCsmeE1TVoPyD4HYG4QwuGRSRz2GOt2bzWW2bYudLC6
	d8v2y/043KY2merRcY3e9fX1d0sSC+5pXlkV++TuWXyw7iuivtCSPnX6+ypAyZKk1cQ3nBVVh/+
	LnZ4=
X-Google-Smtp-Source: AGHT+IHdnmDhIU6ot3F1UXcCd6yjW9/mg/OHawQyiH93sQCv18qy+1FhURQwC20XlXw9u4AH2lXgzQ==
X-Received: by 2002:a05:600c:1c8b:b0:42c:bbd5:af60 with SMTP id 5b1f17b1804b1-430d6faca75mr12231315e9.24.1728460921392;
        Wed, 09 Oct 2024 01:02:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf5f462sm11991225e9.23.2024.10.09.01.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:02:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 09 Oct 2024 10:01:56 +0200
Subject: [PATCH v2] video: meson: dw-hdmi: do not fail probe if HDMI
 regulator is already enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-u-boot-video-fix-hdmi-supply-already-on-v2-1-4478a28d1f49@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHM4BmcC/5WNQQ6CMBBFr0K6dgwtRtSV9zAsCp3CJNghU2gkh
 LtbuYHL9/Pz3qYiCmFUj2JTgokicchgToXqBht6BHKZlSnNRZflDRZomWdI5JDB0wcG9yaIyzS
 NK9hR0LoVOABe7d16U7caW5Vtk2B+H6VXk3mgOLOsRzjp3/p/I2nQUFlturryvvL6OVKwwmeWX
 jX7vn8Bo0/PCd8AAAA=
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Jonas Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IXHFvbVWLsi7Byr7b1kFIvrgdwygIPJYK6vOYIuphXw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnBjh3tpt0WZKKGqSIqO8c/FqgwbIOAavBcdSbAKta
 Ya0tX42JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwY4dwAKCRB33NvayMhJ0QEbD/
 9Kq498cpAgZcrhgjI04kb+9LuN3zIYsBgFef8n+JwVwf6I8T/jRvY8SaquuDM0MA3cG3UjMhcgoL1i
 INeONlv7kWgTUODyMQkcw56mcxBxfjySAipedhERFvGERPYqnUCvmkwQ4dL6JmtZxw022WBnLz2m2Q
 mhOjq9O06WzlmvDeAs+I7iss9zYXxy+AmQA3GT6w3VeR1/A9qVoinM3jd0TKNnJgc+ezzurwoU2a1v
 UOgCLIszTVGY1ostCza+mhyCXysKUEp3Pq340T0RQOceFQDY+Zf/UTldX1FNdI0WntAuc9KJ+TmjtD
 JBFbRvjTXuOvEIPY5QaPA11TC2UZCHsP7mzpnQRWzT4EBmuh7oWwdA2FMeA1PORn8yFuJSCX8Z0DjT
 D5AeVZUzAzvVgWIEgjDUR3Yux9kH6Lbf4Xh4JY/mbQfJV5AioINmyL/rMVkhjZp6bNx90G+b1aGP40
 ZElzkcfrPLYsnLgySaKAQCMP5Y8yUQucuYhIP7u8fxxkE/nZLkMXbHhiJ5BHWyVp2O5osxNVx+WX5y
 /JHGAfaqN4mdRtzn9ZBk2LGnTBIXgkD55b71Qt1tK/yVEEEFMMeL/IjxW9UodTzX0KxTO0PzqGkwrG
 J5kTFWYMH9pfhTULXcp0WL6hVuViOVm6kKkf+Ceghue/aKoNardOQg7UjBHA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 09 Oct 2024 08:02:09 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2433

If the regulator is already enabled, this happens if the regulator
is set in regulator-always-on, regulator_set_enable() return -EALREADY.

Ignore the -EALREADY return since it's not an error.

Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Switch to regulator_set_enable_if_allowed thanks to Jonas's suggestion
- Link to v1: https://lore.kernel.org/r/20241008-u-boot-video-fix-hdmi-supply-already-on-v1-1-3a12c73ff3f1@linaro.org
---
 drivers/video/meson/meson_dw_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
index 587df7beb9b..1631dc38416 100644
--- a/drivers/video/meson/meson_dw_hdmi.c
+++ b/drivers/video/meson/meson_dw_hdmi.c
@@ -418,8 +418,8 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
 	}
 
 	if (!ret) {
-		ret = regulator_set_enable(supply, true);
-		if (ret)
+		ret = regulator_set_enable_if_allowed(supply, true);
+		if (ret && ret != -ENOSYS)
 			return ret;
 	}
 #endif

---
base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
change-id: 20241008-u-boot-video-fix-hdmi-supply-already-on-e6a9af27b1eb

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


