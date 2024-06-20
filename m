Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44299C2BB85
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 07:43:19 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web10.42405.1718869389084815775
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jun 2024 00:43:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=qO5t1eLd;
 spf=pass (domain: linaro.org, ip: 209.85.167.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cc10b5978so586217e87.2
        for <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718869387; x=1719474187; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=282fyFnlOqpclU9yoXXhdOW9Bq7g6LJgGe3tMA067NA=;
        b=qO5t1eLd8eCbeBX5wt7/hNrPcMbyjvZ0KSrB9cAlvf4+WcX9FiMs52OGlXGMubJKYp
         17zDJi95Tkzu9QR/TirincO6klsZsydTFxBKKHRFCqqI5XqbYbILSwgQiowvH+T3dpZC
         bEN5ng/1hQE2IVfxc2dnkrnPZWWkWHn1w8GhUCK+Bfw3rujzviX7G+UHeaNpP51qdGbg
         QqhcZ57ZsGY+PdejGLTfnZA48/RdYrbPPNR4Eajq21hnOq+nxCImxAB4T88BvsB6pAjO
         b231Y4VMbVcP6w3PrrPqnEYHbxx35Oc+g+cMkm7k2SdZc+mWbDkUNS01BGRky0L4Sz8z
         MDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869387; x=1719474187;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=282fyFnlOqpclU9yoXXhdOW9Bq7g6LJgGe3tMA067NA=;
        b=xAGlJGRN3IpIyXufehTBNXo8PCb2dSj8KSJsRuYHnUk78Y0ovck8z4rLNM0s32ih/R
         pyz+jS3gu3QrTsIMFCob1i8mfjkb7V07/us+9ER25s4PWNUrIXc6ToWzhC4eiViFsfu0
         mLzK867VrS9H90Rohof1nYUEqhjD0SjlVIusVN9UtFR1YK47Ab4ZKPcpEpdLndPXAdMS
         J4oHpaoPAAApyMweSrAu7A6stYmclB9eih1j/nxrPPLcEMi97xG7vFx8qdaIFWOFacND
         e8nuTmvB9iwWkThQl0NAtLSvpUpV+dS1Mg0R1gxw+7htdOCEI9Jtfyf8d71QYB4MXz8c
         nDFA==
X-Forwarded-Encrypted: i=1; AJvYcCVlYlgEarEBV9Tc+G9K7BCBqnuX0WDIxrsPUJpXC5E2erXmMDf5YnDfJPnXjZvtoZA+1axru3385fo3QW3AQYBYfFa+BzC1ul8=
X-Gm-Message-State: AOJu0YyZKRh1uhOJ+0gUHoQhatAWFZDMRIho6jf0QQAGB64Pa2RexA3Z
	8uvdCdIXMTCUc2Esr98Nrj3OdBajoT0Hj1CSH6Bwr5ROOaCIrtYRn2mNhU7JODRgcBZ+6JkiYrs
	ooMY=
X-Google-Smtp-Source: AGHT+IEfEhXio9e0Lgo6onLFfma6GexW0gLj2sp1fwjvg9O+wizME77LhQOfaTNAm4+Xs6ZblC6/yQ==
X-Received: by 2002:a05:6512:31c7:b0:52c:90ba:9705 with SMTP id 2adb3069b0e04-52ccaa8862emr3998596e87.49.1718869384872;
        Thu, 20 Jun 2024 00:43:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b6402sm15506785e9.10.2024.06.20.00.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:43:04 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/5] usb: meson: switch to set_mode callback and other
 cleanup
Date: Thu, 20 Jun 2024 09:42:49 +0200
Message-Id: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHndc2YC/43NMQ6DMAyF4asgz3VFQkClU+9RMQRiwBLFKAEEQ
 ty9KSfo+L3hfwcE8kwBnskBnlYOLGOEviXQ9HbsCNlFg061SQv1wAVrkRmXUGO3DTj1Owaa8SO
 OsMnKUjV5q5zVEAuTp5a3q/6uonsOs/j9OlvVb/2vuypMsaiNotaagrL8NfBovdzFd1Cd5/kFz
 CGOT8cAAAA=
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=BXwVDHRfVU99OIOKma55zPHgrI85ZKsZ9sTjxKJag6c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmc92F1qDclnH/7unSfuYE9G5eVTkKUYFdFdhHq1/a
 Jr8ZRsmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnPdhQAKCRB33NvayMhJ0aNhD/
 9vx4Gtf3Q7HNWVlvUc+GTmemplzxDT6J2IICpvDb1HYFZb9Ai500EaemEgYcPdSglyh454Ff8Fc7HV
 ssbj8T2MB7qjdUt5mwamC/tvkrp9mc5YgnudoCZyKole3bZ5rFh/BvgoPXf9OxBP0Jml/qOB6FZwAh
 ibhoV7VOKV43ZaJpG2CUxgXlzxDc6CtrjT4lgFZuMRoxtv3x6mFEwi2DJuwOE5AY5UvAzWFHjEIS/A
 2syP0zLF/Nxz1UbSg47el8zw47O8z6ssgLl9TKObrLQNr1n2iZAiUHCiyITmklbYUD9B2D36X0N1mE
 G8Io1Ssund+55yPCLmL//ZFjL8QvPybibKO7EovOkXHXAtZyl37XaUesd2sirT40Vtn0G6r7BqwhmV
 RklvYtQnreVn5/KBUxK472mSQeKmXtWp8EvCzlbZ0mPGxzsvdg54PWMehQtwlp9NslfB6+a2DLS20q
 BmUTp5+WyMHiXQYZEszJeiCibaDA7lEjnQgVR1agWgm55DjpDmaelPI4OZLlLQvw9850XGLg+0G2zq
 1u4/xgRns/fZni13Lr7yAWsM+rmtuP/HQGUztjmVE4LkP3i9QaI3po9pG0SdhJrMC94kHj2VFQeCM1
 BER0WTBGvuH5y3SbrBwpaYe2yZok7vMvJdYSeJtpfeMjNrVrOb34hUr0upwg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 07:43:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2307

Switch to set_mode callback now it's available and in the same
time make public functions static and drop useless mach-meson
headers that are no more needed.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Update commit message in patch 1 to specify why we use _ in the set_mode callback
- Link to v1: https://lore.kernel.org/r/20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org

---
Neil Armstrong (5):
      phy: meson-gxl-usb2: add set_mode callback
      usb: dwc3: meson-gxl: switch to generic_phy_set_mode
      phy: meson-gxl-usb2: remove phy_meson_gxl_usb2_set_mode
      usb: dwc3: meson-gxl: drop usb-gx.h and make dwc3_meson_gxl_force_mode static
      usb: dwc3: meson-g12a: drop usb.h and make dwc3_meson_g12a_force_mode static

 arch/arm/include/asm/arch-meson/usb-gx.h | 17 -----------------
 arch/arm/include/asm/arch-meson/usb.h    | 12 ------------
 drivers/phy/meson-gxl-usb2.c             | 30 ++++++++++++++++++------------
 drivers/usb/dwc3/dwc3-meson-g12a.c       |  2 +-
 drivers/usb/dwc3/dwc3-meson-gxl.c        | 18 ++++++++++--------
 5 files changed, 29 insertions(+), 50 deletions(-)
---
base-commit: f1de28e67aa9b66bfca0fad3dc18446a6ec0b504
change-id: 20240618-u-boot-usb-gxl-phy-set-mode-c3991c5f1da2

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


