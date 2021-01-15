Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web08.128.1610687893957163996
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Jan 2021 21:18:14 -0800
Received: by mail-pg1-f172.google.com with SMTP id c22so5248313pgg.13
        for <u-boot-amlogic@groups.io>; Thu, 14 Jan 2021 21:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7eQU9EK8f6FWiDj32sd/WxuwlDVPVMNT7xgxOVMuMRU=;
        b=Wz2sRToHENKTecB1AGmTITX61n9oBohmm3QbmzGcpZTJ1cB5kyamwwHJih+tT+Imrn
         /2m648sUBCeCXhEYuupiL8sHZCamctdjWqvLzkLFDZZyeOfcLzv9jMruJxRiz57WBUD7
         L5F4VswExwZWTkrCTGFs+AHh87OdxTI/dnOVGOWrDN+E3JsFQzoe673vE9zlK+9VS7/T
         c/ZV1b4cj6x17LQwFL9aEBboInaoTqPi/O/Xi+7bTQ1c8vLL3O9OlxgV//jMnJgN4zLc
         wMq++iH7lRIF9EDm+NLmJDmyxpZlCcca9yg5E2V+DA5D36IfAy8RIMogcskQ4WzRM9TC
         TUrQ==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH 0/2] fix hdmi video setup for khadas vim3x boards
Date: Fri, 15 Jan 2021 13:15:56 +0800
Message-Id: <20210115051558.469734-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: narmstrong@baylibre.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, m.szyprowski@samsung.com, jh80.chung@samsung.com, hs@denx.de, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

next patches add missed parts

Artem Lapkin (2):
  gpio: gpio-uclass: add OPEN_DRAIN flag parsing
  arm64: dts: meson: fix meson-khadas-vim3-u-boot.dtsi

 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi |  2 ++
 drivers/gpio/gpio-uclass.c                 | 10 ++++++++++
 2 files changed, 12 insertions(+)

-- 
2.25.1

