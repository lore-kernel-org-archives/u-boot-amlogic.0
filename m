Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADCBC9832C
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 13:42:38 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8354.1790343752069291176
 for <u-boot-amlogic@groups.io>;
 Fri, 25 Sep 2026 06:42:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre.com header.s=google header.b=kNNKvr/M;
 spf=pass (domain: baylibre.com, ip: 74.125.225.140, mailfrom: glaroque@baylibre.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so5424885e9.3
        for <u-boot-amlogic@groups.io>; Fri, 25 Sep 2026 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790343750; x=1790948550; darn=groups.io;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YVPuaE9IB66trLiFplA8Hb2+bW0yOvzf7m9HAxeHP0Y=;
        b=kNNKvr/MNLOkCi3QuO5j8k326h+QrhqRB33DFB5gH/9JZWpRqWY/eQ5MK5ZlTsSGJE
         qxX7QasbC5a3vpEuEBpc9Ql7/0kRmDETe20Go75i6EcNfzW8+TU7Y9OVSp4cMxwNFra9
         +WmMfplMX3sXDyOUIMbX/7szGF491g5aSQgFqu3GVUF4hie5+Hu5w6R0UnMueTKiaMo/
         /tuUNDZ6/UMPtipnBVjRM4mPtLTfbxdRsU5myJRgjpTBDAANShgi6FHcqUqh70yc0E+p
         nGX8Hu/YzwIewfhdi8Jvd6MbdE4Vc/HbYPg13w+gDpfvSQre3FW8CSRRKwfTKsiJ1pEL
         niHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343750; x=1790948550;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YVPuaE9IB66trLiFplA8Hb2+bW0yOvzf7m9HAxeHP0Y=;
        b=0Ff+mowSLaghc96OoLmivyiaMcXT/KE+ZwXNQa1fCmbA2rbsoWLHVF3Fg2q/TbS6vK
         EifrXHCr8Tvgp5k7yT7BbxK5aH86soAzcoBwpWcCkzM85rUJ5Pws0JKtSlw6uk91wfYA
         cZeryUEjMVSrVQ6YUOULh+xiRp5RGCXL9j6pjQRsp8/tuSQMMLyXexaE3wEqYePQUtwQ
         wBFeUu54NntN5RijVFwHzzGvmClXdpdjkkOhGwYPyPAukydNIL1CLMLfzBOFEhQYCISa
         mp64qI0coXUoa0oF7i4emaqfRetP4npLsCxHAAIm3JCcFp5JqCVIA7opBnWqqXwewell
         AS6Q==
X-Gm-Message-State: AFuF++kNSBkJtilB2UgHy0iLmC6I3CHOcxpPcuT9M47y95GDTvi5K+ai
	Z+oFSIRhXoixQycsfWxuzj1Wh8PkyY+OpPhWe/6Z2FYZBuM5opzq9egqu7Q9vPGQr+uJOr4/BJs
	YGtXhNSI=
X-Gm-Gg: AYBFou230VmNzH8TWO6cx6BvoO4unAcwfJlWo3m9Shx2ARvVOI9q+EHxfahgjQgmbvG
	50ZRL4T9nwqHv59C5ANo20SI6wJ1JuVcgq7cuCwAom2mi5SmEtp5s/blCjScq3swQzZPxIepG0G
	xz4J3iDTJ4qNVvwgkkXt1kzM9EMSEmZ/RtfyUn/zmpd9RAfPq+MY1hRi4GYA1VKU0iQVW5/SGl9
	zf2MU7YEGOtLmjUBOnqD9dCaHQe1KYnMtxwp4nRSonJ91MeatIRXg3/UN9eV46toHmSzj6wfu2A
	2CqXdI7noaOuKfKEGrJJWj38Kd0fqhnpf6XNHBhCxYOiYcnjJDNb9lCywgIxDihx6w9fvu6AUgK
	fRhfL6xWde9fGPNkKp70hsOUifgsgd1RhJX8XukZf0xnUmSY0mz+lAdshxZE9llRSD2n3dcvrFP
	JSZG14CZahfMEPpKWo2rZ6FVL9hKKtnSBmJy3YEOa8RG1P0lJJm1GhFzG7iVgw
X-Received: by 2002:a05:600c:354e:b0:49f:ce78:356f with SMTP id 5b1f17b1804b1-49fe670b511mr100465885e9.32.1790343750017;
        Fri, 25 Sep 2026 06:42:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff42b7074sm34738125e9.6.2026.09.25.06.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 06:42:29 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH 0/4] configs: khadas-vim3: refresh Android support
Date: Fri, 25 Sep 2026 15:42:23 +0200
Message-Id: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD96tmoC/yXMTQqAIBBA4avErBPURWZXiQjTqSboB60Iwrtnt
 fwW790Q0BMGqLIbPJ4UaF0SRJ6BHc0yICOXDJLLgmtesmNzZsf2pJlprZztpCi5UJCCzWNP1ze
 rm9/h6Ca0+3uAGB9TLPd0bgAAAA==
X-Change-ID: 20260908-update_vim-997dcb218017
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 25 Sep 2026 13:42:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3095

Update VIM3 and VIM3L Android support to match the Android 16 AOSP
A/B images used by these Khadas development boards. Remove the unused
non-A/B defconfigs, increase the fastboot buffer to 512 MiB, update the
partition layout and correct the DTB indices in vendor_boot.

The layout follows the AOSP generic boot and vendor_boot model:
https://source.android.com/docs/core/architecture/partitions/generic-boot

Both Android A/B defconfigs were build-tested. Android boot will be
tested on both VIM3 and VIM3L.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Guillaume La Roque (4):
      configs: khadas-vim3: drop non-A/B Android defconfigs
      configs: khadas-vim3: enlarge the fastboot buffer
      configs: khadas-vim3: update the Android partition layout
      configs: khadas-vim3: fix the Android DTB index

 board/amlogic/vim3/MAINTAINERS            |   2 -
 configs/khadas-vim3_android_ab_defconfig  |   1 +
 configs/khadas-vim3_android_defconfig     | 122 ------------------------------
 configs/khadas-vim3l_android_ab_defconfig |   1 +
 configs/khadas-vim3l_android_defconfig    | 122 ------------------------------
 include/configs/khadas-vim3_android.h     |  36 ++++-----
 include/configs/khadas-vim3l_android.h    |  36 ++++-----
 7 files changed, 34 insertions(+), 286 deletions(-)
---
base-commit: 951132236b9adc592c2e49faadd103c6a355cac3
change-id: 20260908-update_vim-997dcb218017

Best regards,
--  
Guillaume La Roque <glaroque@baylibre.com>


