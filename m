Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD877CEFC2D
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 16:23:52 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.13656.1728404628942933083
 for <u-boot-amlogic@groups.io>;
 Tue, 08 Oct 2024 09:23:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=QOFLkBFe;
 spf=pass (domain: linaro.org, ip: 209.85.128.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso37141615e9.0
        for <u-boot-amlogic@groups.io>; Tue, 08 Oct 2024 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728404627; x=1729009427; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a7OGYqGu5EZtnsKA8EOPjldtYVA6bSkYUKohrOQPTGg=;
        b=QOFLkBFeDPI/fzW55v/DVX0Pwy81BS9+fAby/rbd+p5zsWw5QtPNAOhaR2GVauyoQf
         PrwyYPCqmGeiWs8nM/tl7JCj8Evt8AYdlLG6vdVymUmDWFpnqXvV1zyVBMbe6RBE8OdU
         xQombnPh010yqRleZCuniTy0fDnsohXKjaEiil4HmBDGuvpJ8CBBf7Mi3BCVIWhOrvhx
         cGcIAwSZmtQYyGgFheFXJdaMS1v3/VJmXXJcyPRRyId1/PPxHvoI+ZkL/Q1ftYUY5Br4
         pguGCZuFz3mLfG+8uA35Lj9QUNK1gZ3XsCHu+SfZoLtFS2MnxF4yGrruR580QzsTusKs
         FmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728404627; x=1729009427;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7OGYqGu5EZtnsKA8EOPjldtYVA6bSkYUKohrOQPTGg=;
        b=ODLH+3wieBHU24TxhFNQ32SA5zwyD0AFjjcC7jSizGwzKHs6gLb00iA7oaszA2d2eF
         iH5hgTiHo0Rq1e/zSTWsyrmCvOhGcM+Kigpxac4Sp33NeE95fVE0GSg6XG16fJ5zpTsO
         TOV6Ea15yQaEBhv3FZ3c+RWP2kP+flXCIJHJZfy8G8yTMb0OI3/kQdiaL4ZeFfLW+zhE
         Lv+d0KEH3haIFKqGXog4yB4fIbV373ubhz2DSe+He/6qTnseh79DLSfQQhpMXohtPRSd
         fMB08IwAhi445szjJ0JhRKM/NoeVDOczZ/Nw3GredFHm6O2uRy3AaANzrnjYcE6xTD0z
         TAGw==
X-Gm-Message-State: AOJu0YxxgvYk2cqUC9wq9jzwdeUkfRnLqzoqscjnRZvhex4XZYwuPvmR
	BoeqGjkHaEfkRgAm+yzZiIEJxG4fdtzBkJ5Q8KKOuM9fGhvoR/yP7xuc9EsMcCo=
X-Google-Smtp-Source: AGHT+IFcbE8qdwlN5iQXHW4F0szPzEucIVp7WUWHzd+M9Hw4IS0IWTZA5wocptODo3G83so661qNmA==
X-Received: by 2002:a05:600c:5104:b0:42c:b991:98bc with SMTP id 5b1f17b1804b1-42f94b71121mr24737175e9.0.1728404627134;
        Tue, 08 Oct 2024 09:23:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e89b42sm112810205e9.13.2024.10.08.09.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:23:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 08 Oct 2024 18:23:42 +0200
Subject: [PATCH] dts: meson-g12-common-u-boot: do not disable canvas
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-u-boot-topic-g12-do-not-disable-canvas-v1-1-b89659370012@linaro.org>
X-B4-Tracking: v=1; b=H4sIAI1cBWcC/x2NMQrDMAwAvxI0V2CbDmm+EjLItpwKghWsNBRC/
 l7T8W64u8C4CRtMwwWNTzHR2sE/Bkhvqiuj5M4QXHh650b8YFQ98NBdEq4+YFasXWQxihtjonq
 SISd2r+JHjlSgx/bGRb7/0bzc9w9/xlqveAAAAA==
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=939;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=w5EYAVkbofpjTS78oTwVI+hLmHoyio61nDbw2Z4MH+8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnBVyRSzo2sjPxK6urSmcBDnsevue7ah4auY8yYUUu
 o9srrEuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwVckQAKCRB33NvayMhJ0U51D/
 0VVgMK+OjtJSL6Jvf3M/M1v4HGhYjCXvIfuni6imgaM+hmPJJYEk+P1N8w6WmuvVcYurM6C+wLE3za
 s+p+4YcwFVPi706OdzKdUQPCPexE7q1FyuUw8EeAhZkYG4TJQfcCn1BfJb7XzETKLP+No59N1Egehd
 8YAKNL56kEbC1yMX6FgSz6csFiFxZZe9pDz+RprzfbLTszkxGrTIYKDzlOb3aSO8WzS2ljkt4KtZYK
 krI/jtpnkgZmUCFo4MG4NUIPLmPfcuIqc91ZB3+fGpd1cSp3goVdxK2cXkIV9sR5H0eIm6dMuYvivt
 6/3+cenazhW+nOf+a5/O8qtGlXhV1Tbst7Jp1bWxqrEBEjwS8nGFOn4+NMfiXE3SU5m7aaxXTBW2L2
 FVj2+1phpOGVi79cY1kJ5VhxPDI5LMw4MibiTgABPTFxT3Zpt18LoJUpJ+ukvhgEiWEiZiSNkRQcbI
 6qfQXbZJsVzc3GhAMtLSXLXMA/XmQxWqZb9UVG7Qz3s3BuQiCzGKpnM6T0S0Kd0wdsAatYQkCFKPVg
 FgjTPECwtFUNOvpS55jNpGC7YKA1CPmXVa1zoeHM4e/WVZ6O38qEcbru6KlkXX//Qf7kKbZN+A5HyR
 MMm3OojDPk4Z8gIHINK4QVd3RGgU32INBXbqg6zG7iYm/UikS2jX1PwdNh4g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 08 Oct 2024 16:23:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2432

We were disabling canvas, which causes meson vpu probe failure,
just stop and leave canvas alone.

Fixes: ce9fa7bffc5 ("ARM: dts: meson-g12a: add U-Boot specific DT for graphics")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/dts/meson-g12-common-u-boot.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/meson-g12-common-u-boot.dtsi b/arch/arm/dts/meson-g12-common-u-boot.dtsi
index 8070b62af5b..6629f3256a8 100644
--- a/arch/arm/dts/meson-g12-common-u-boot.dtsi
+++ b/arch/arm/dts/meson-g12-common-u-boot.dtsi
@@ -17,10 +17,6 @@
 	};
 };
 
-&canvas {
-	status = "disabled";
-};
-
 &vpu {
 	reg = <0x0 0xff900000 0x0 0x100000>,
 	      <0x0 0xff63c000 0x0 0x1000>,

---
base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
change-id: 20241008-u-boot-topic-g12-do-not-disable-canvas-ece09f18ebaf

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


