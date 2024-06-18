Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAEDC2BB9A
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 07:55:41 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.80795.1718697333056242641
 for <u-boot-amlogic@groups.io>;
 Tue, 18 Jun 2024 00:55:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=r1q6R0Ux;
 spf=pass (domain: linaro.org, ip: 209.85.221.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-361a8ebcba3so339033f8f.0
        for <u-boot-amlogic@groups.io>; Tue, 18 Jun 2024 00:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718697331; x=1719302131; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ifSUqzbxUY6x/Pi88EcP6Nsq/YXt+oMGhK+7nGodMcA=;
        b=r1q6R0UxzQ70j0VKo441BGwKoNpwi7czuuhXd27fWETXNV33c0KeuqcYNW2UgxquKy
         cJ4ftidobmX7BE0YCfRv7JWyT2NyoQLQgYR4auLFeQ8Jb6P9FwCkkGO/E79VM3vhzDfR
         2ZAX7AyraEOcXZi/1NjJJ0hz50Z44lq9IsX1Aqqfg/jxWAsxR25oOHa1G0m3CgamCBlc
         751UpYJVdm8ewqwVp0HB4tu8ziu/2KB+oxWo8ThOuCpKb1oNidcRIKbBkUlWnUbvJ7kQ
         vH0DQgDviGC4+lEaNrxSRv/Kd/JXOi3PkTl9cLVQ3I/9ele1+QpXMWuVzcu1og/bZlgu
         zRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697331; x=1719302131;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifSUqzbxUY6x/Pi88EcP6Nsq/YXt+oMGhK+7nGodMcA=;
        b=nJpEn8dfJV/SCU4ENbfDiFFbgNjA0bbXOFbZpOUB1d5l+aF5bP8uidV3tmKqGJ7ZRB
         lQ+fLsSV1j/q9IO03ljX9Hw5McSFZSsVRSHCa0inFgziWc1T7lp+ja9wLBRj2W8VlHg3
         6C8AL4wy3eIt/4mGO97d4AyyMcI7TYqr4wCMeWbFLmGJDmhZjatcDZNtzUyTDVqEvEyT
         nNxFCLJGd8XnFHwvsUsm4mj43OsldXypf+6Wmsu4AWw/O81D5RPdR8B50GqwvYwNaQ79
         G5cnwxd+F4i1+W3apfWVL17sx2uAaT69EaQC6pZYnfh8fq2fl7PN/T2iPdxAE2L21gRv
         4gNA==
X-Forwarded-Encrypted: i=1; AJvYcCWxGBF2KxWNB3hKLYRpIboIl0dEm+XvLiJDwsg3YdjjF+bv4Mal6f8Mxva/YQeYRiGzSGLkbQFvajW6ixFiZPa75edXWGMZrx8=
X-Gm-Message-State: AOJu0YxBtfO3+gIGC+qNfXW+Nvl3D82R51LRXZE7amedTzBARanpaOma
	eArxg3ZxKL96kcm4XI39nMJGVTOfBCRmlawuKxyvTx48vVG0q8czgfPEn9ADJ5U=
X-Google-Smtp-Source: AGHT+IF06XO8x5fofPm2HSzRdoTISK3600S8uKZ4YqWDr3JQRAVFHslhY/EbIMbmVanlzSLRsvEHaA==
X-Received: by 2002:a05:6000:1243:b0:362:2e9b:f113 with SMTP id ffacd0b85a97d-3622e9bf2a8mr799578f8f.21.1718697330992;
        Tue, 18 Jun 2024 00:55:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750934a4sm13523173f8f.10.2024.06.18.00.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:55:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/5] usb: meson: switch to set_mode callback and other
 cleanup
Date: Tue, 18 Jun 2024 09:55:24 +0200
Message-Id: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGw9cWYC/x3MQQqDMBAF0KvIrP1gUlu0VxEXmow6YI1ktCji3
 Ru6fJt3kXIUVnpnF0X+ikpYEkyekZu6ZWSITyZb2LJ4mQo7+hA27NpjPGas0wnlDZ/gGe5R18Y
 9B+M7S2lYIw9y/Pemve8fE8cIIm0AAAA=
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=COa0uKveM80+HUFmQ0U8IK1ivU0skAfYMWOcBdLjo3M=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmcT1vrzzMSFDUQtjw1e+m0SgU/WBeHuIzkUyYiPHW
 BykgGWaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnE9bwAKCRB33NvayMhJ0T2CD/
 9ERyYsoMP85p6DIvCypMC9n79hUQ5oAeNx0w/acaQw0f/MkNjRoibq5Fzq0NLCAu3eZE17TlOHUO9X
 Bg5ZqWVnwFp8P1DdgC5XUx6q44a31w+kURyvXWBeQccH1VXkWkLEpoPt14oJnUhixro3RWukwZE2mE
 glvdKFtZ8y38u6lUyIWocODgheDIhGV+4/Iwz69wMBI4pVticLKwTAiDzMyQjtqP3tmVjRjgMkQqvl
 1p1GsOPIbzORp0TA+VTC8dwkGEDz7sHRCYBgjfBhJukrM+2gjw6f7PJSv9FslJi3J+KtXeX75Zd+9/
 Ut6EDx99nVPxK2/GsqOIQbLQDds3n614QZn7c2+KkwFd/Sdpf1SU+66I0jmaJFegigWP+zJpXsal/j
 7BL1cHIDUeojQbGvBdVaYJgulNqW9yZVuUdNPKHwFbHc1F+aStfGf63y5lTvQCFHy55cEoXMQlaYYK
 elo4GM7iIyqveDxS+A54t4Jx/GfKYZKw48LB0J6JOe+vK+W9RrV7aaapWpR1igbpcc6oGGgDuFNcru
 ARz0KreLvRQPDhItoM1dYRm+/P+Jek42ybXIhWMVAKXxA1PbudPSc2SOCL6masOQ9l9eO9vvOrYx6e
 3h/Qw1QksQ31VY1ElWxHGuZ3mpoTsAtKp8RG8LHrdn0+ceoW/uq+tB9i3S7A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 18 Jun 2024 07:55:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2298

Switch to set_mode callback now it's available and in the same
time make public functions static and drop useless mach-meson
headers that are no more needed.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
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


