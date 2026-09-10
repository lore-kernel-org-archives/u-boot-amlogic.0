Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730C4C79F9F
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 14:04:45 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15011.1789049076624164780
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2026 07:04:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre.com header.s=google header.b=ZTl8Xipo;
 spf=pass (domain: baylibre.com, ip: 209.85.128.48, mailfrom: glaroque@baylibre.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso70837755e9.3
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2026 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789049075; x=1789653875; darn=groups.io;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XFEWh+b6o54yndpoClMPgSbCJsVRfdLX8+HyvHs5lv0=;
        b=ZTl8XipozICia/rn3Rf8n+AZeOqRM2MigbbhfNnW+AKQhigqzp572blFWBXbLJyFD+
         oNjdCFFgiK7bMi5Mqk3QPt2i5PSL971e/lRaMjoJLIUdVz3EOvIv1bc2AX/IOYO344u4
         3/zcK67KgFtOlANR3fUV9gmNfZE7tbZBYgZuzhIAqzQ6RbcBdaPFz5o2RZhL+RMR6rGQ
         v4N7GAtYIBBIOmNjtmljDBPBJakNxBvLFtohwiYihtC7iePu/RGlDAiFDiQSbJivZwpn
         x9Bg8mADE6yw242hXxX/kKKwNo+q2rzpoyy6m4efMtXbSXdZ5mhLg+pIspwmcQtx+q3S
         MYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789049075; x=1789653875;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XFEWh+b6o54yndpoClMPgSbCJsVRfdLX8+HyvHs5lv0=;
        b=guWKwVamiWEKQBY0YTZBSJRMz/H6MeieqM0taN/Jw/03pQHFkNHwP7cn9EYcszkVu/
         Z9gTl1Hww8ey+UMS1baiK2yWr3RU/ECyF7Et2/AnyCErFqHKGJRI13BVAmTVLGExPWxp
         lrpcPKrJWiud708ruCH7gn/DxNrJsCAU7uDn/zW+XO5hSrvgfefcVSBpYphER5kC6GD3
         NO8OtPmyXyUZHQoJdruYQ+uZo+k3vo+sjKG4s2Dk5D70Ika9P+BDvblmuS5IB870by68
         t23zfoPms8Y6MjH1aX9A9nPCOwPn8SBFT1pc0uBjT4ZckJsneM0QjzXUWgu34zoFG7mx
         MAzQ==
X-Gm-Message-State: AFuF++m2gyLyvd041sawwfvTMixbXXO7GO4CjFhiFvWsxXiWAqjr+AzG
	kAynMSzuXLnDtuJMo4bj57gzhu5bh/UvqWEPjWPOqLKZcAT2zq9wP53dTALRrNZawxI=
X-Gm-Gg: AYBFou3B+A96VZfBB/Va1VraVrHkp0Ra5/8MatD0ygkGZ3pN8wKw7DvPpY4A9xRmXf5
	vPeSvujW05t1d5lHsDeAtqHeAP2e/iK0xMohbQ/9HqIi3gBKL9QlNn2xwMsXgjKey98q0GKg03n
	uD4s2tVN+jNjJD463yz0SwZOrH5w4Ykj8SPjbkBZjqLXvOZDbpAmgJxjw+8E3OSQTupXRgBLokN
	VG5hyEbP8714cdCNPK1Hj0mGx0UBWHEz5M+b+dguGPpdX1+8WkOOknTNF+UQ58pNTxlP+piiJ/0
	BICuDbcsN8EfJdt9OmjHiA2UvMEvtPoF5s3M+qL8iUgASIlbKbyxZXfvuJunhlBMwxN2hI/0qWD
	91Y/JIJpWsse93V5QbK8GoPZNej4CqLOL/oarfp+Exzbv+pwedUCeh1CW+FDvD9TZFwAddSfPws
	e2NsnfjJoLXaqa3s5q8mGH14acazNqXxCuW/eY4QS9E7eopMupzrHVA7IEG9GO
X-Received: by 2002:a05:600c:628b:b0:49d:2856:fcf6 with SMTP id 5b1f17b1804b1-49d2856fe91mr48067335e9.15.1789049074679;
        Thu, 10 Sep 2026 07:04:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20db6e76sm147660745e9.3.2026.09.10.07.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:04:34 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH 0/3] configs: sei510/sei610: drop Android support
Date: Thu, 10 Sep 2026 16:04:21 +0200
Message-Id: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOW4omoC/yXMQQrCMBBG4auUWRuInVaIVxEpsfmrI5jIjBah9
 O5Gu/wW7y1kUIHRsVlIMYtJyRX7XUPjLeYrnKRqan178MEHp3iUGYNBhpiTFkmu60LgyBNzz1T
 Dp2KSz396Om+29+WO8fU70bp+ARUQmGl2AAAA
X-Change-ID: 20260909-remove_sei_android-44993a3f3353
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 10 Sep 2026 14:04:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3088

Remove Android support from SEI510 and SEI610 while retaining generic
board support. Both boards switch to meson64.h, leaving the shared
meson64_android.h header unused, so remove it too.

Fastboot remains enabled, but "oem format" is removed along with the
Android partition layout.

Build-tested sei510, sei610 and the four Khadas VIM3/VIM3L Android
defconfigs. Both SEI defconfigs are unchanged by savedefconfig.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Guillaume La Roque (3):
      configs: sei510: drop Android support
      configs: sei610: drop Android support
      configs: remove unused meson64_android.h

 MAINTAINERS                       |   1 -
 board/amlogic/sei510/MAINTAINERS  |   1 -
 board/amlogic/sei610/MAINTAINERS  |   1 -
 configs/sei510_defconfig          |  10 --
 configs/sei610_defconfig          |  10 --
 include/configs/meson64_android.h | 279 --------------------------------------
 include/configs/sei510.h          |  30 ----
 include/configs/sei610.h          |  30 ----
 8 files changed, 362 deletions(-)
---
base-commit: d4152edb50356338af994d1c0483f65b717b4c15
change-id: 20260909-remove_sei_android-44993a3f3353

Best regards,
--  
Guillaume La Roque <glaroque@baylibre.com>


