Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C21EC4167D
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 09:30:31 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.32206.1702459821359042778
 for <u-boot-amlogic@groups.io>;
 Wed, 13 Dec 2023 01:30:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=KO5NvGui;
 spf=pass (domain: linaro.org, ip: 209.85.221.42, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so6113606f8f.0
        for <u-boot-amlogic@groups.io>; Wed, 13 Dec 2023 01:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702459820; x=1703064620; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+Wk6lJKkwdpW5iXxOSKeoq70miEq59nRglwqSNX58k=;
        b=KO5NvGuiqCplDA0UCMCi/2zoGQczzpcNgw79nlDlmhL6DEXcYbTmmg08mxcyfQ5wQ+
         VCStEuazIM24gE0eUoa2XDL+4O6+7XCHlJ2s4lHjEFk6s1bB7kmX02Gjwpcm+K7PkRvM
         HKDzVNgngd2b3KCy/CFhB/f0tl7n9IqWCWYxA+0tMr+VLvk81tx8TTpSRTVK7g9UUZFB
         7OvFbVF+yaSj5OeIm34+9zwlAIid/46UE0Tce5DAD4cS+FluPopYmguTpx10mm+a3KEF
         WBPGYHocQfTkc8lR//av/xkhclcBW+gMXxtRRYbjRcIxIGOqxxojLLkwr05gRVC4K3x3
         kExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702459820; x=1703064620;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+Wk6lJKkwdpW5iXxOSKeoq70miEq59nRglwqSNX58k=;
        b=Io0billCQ3s1c1KOrI1OCahq79w6NgFEcSA1/wMRUJi9PSA8iMqU5n5ikUM3SUCz7Y
         Ar7hGdJi7Eeiq5tL9CtCeubBuFgow64onbzLBIa5Y8p1XMkk2q09GbvXESITygbiM7I0
         fFH0TCcC+dvT4/yflnDRAyuDhavUCGUOXUlHXCUx4VndvVmx+7MZiEKdUignkRO6hCR+
         MJN1wxx2Me3ukV7GSERhj7eoe7uH3abJmH8kjTTIhFw9kBkUCofIG9krM32vjRxeUjZP
         nr5bEjOViJJZKgPivyqkWp4S0OgPqB02f+04ehlBrdFkT/a3ywnaaZGM1flc503nI/9I
         uguA==
X-Gm-Message-State: AOJu0YxKn23+zvHeKrvxBpxB5hOwOQQDNHh3YyioF2/IoMjJdUx4pTr9
	4IHpz+8ufyKlxE5k+wfFJCQpIw==
X-Google-Smtp-Source: AGHT+IFkb4/Z4nAOMUH4O4hr0RwBxW5C+xiTWTHZruGFvbqsPwOAa8SZq1IN/1LDA0jEgBtKqfZ52w==
X-Received: by 2002:a05:6000:1007:b0:333:2fd2:6f7b with SMTP id a7-20020a056000100700b003332fd26f7bmr3543985wrx.133.1702459819758;
        Wed, 13 Dec 2023 01:30:19 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:596e:6d4f:fc0a:ec65])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d504c000000b003333521a1cesm678817wrt.57.2023.12.13.01.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 01:30:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] ARM: meson: introduce GXL MDIO mux driver and
 switch to Linux v6.4 DT
Date: Wed, 13 Dec 2023 10:30:11 +0100
Message-Id: <20231213-u-boot-gxl-mdio-mux-v2-0-c56bb02a75ea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKN5eWUC/32NQQqDMBBFryKz7hQTKdKueo/iYhJjHFCnJBpSx
 Ls39QDdfHgf/vs7RBfYRXhUOwSXOLIsBfSlAjvS4h1yXxh0rRullcYNjciKPk849yw4bxmNrXX
 ryJRsoCzfwQ2cT+urKzxyXCV8zpOkfu1/X1JY4516opu1LQ3mOfFCQa4SPHTHcXwB0zNEDbcAA
 AA=
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2503;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=FIuWtHSeZsGEmhH82xAOBSjsdqhkSKLtyLoSiQr92kc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBleXmlu0cqacvEZ1vIX7tnSt448UTz0LVhewYoP
 UwkQxxzJR+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXl5pQAKCRB33NvayMhJ
 0YwMD/46iHk/fveStGNwghlFasPybTTNAXHLW1ro1b+49IdvrXxKddFn60/ymq08xhZ6+DHh4Y+
 hr6f8VqWkQlZQsFXd5V1JcGdUcIZY8ZNHdBPOXxMe5EKwWgocL9ce4oMLULYKp1UJAfGzIOKA4e
 oTW8cOxRZlTscTBwCQYgrwFG6l+HASC7ru3WEvt2q5qC/2U8od3Wy9bzjLFbwuaHL1b6MXhg0os
 Q1HdzNv9Y6CSzBWRObOsyP64LzaRgTp9p3k5Op9hiNISX1lRDDNpbM9BXEB3nXBuNVDC6GNfjea
 EyBSah+Kfeyy1jI0H4gr5duzRv8oMDz2a9zAg3YomT+4Ig+ZsIfdwQfbPLVdrfEl7KVqWJPt38s
 6PPVyAf5+Fhv/DO8/M2/YbT5lr6/zt2EaxlGt3P9Fbdn3uZWaWNWXi1iKSTnqgxGhPIFlTOpxlG
 aJboqttz6nqbtSoAEZQQNODjKNk25EBYXNoM5wc3jDyaNqc8y/YbZ7MlkORreYHL0X9rPS7HenN
 mXr7VSk/SV6sTMktNk/WNJz1+cvC4Jkb7cRzNPJU7lS2Zuw6BP/sWxErDNx9gWnXpPg4r9jL+db
 sr0ckh753mTckD1D4hqRzQcYmgjwOmC7X93e6yvyNvPTNz2vF82CF+9ZcDLR8n/TgRRrDkHLFY3
 lxVjI00FD7uq6Ug==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 13 Dec 2023 09:30:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1913

Linux v6.4 uses a new MDIO mux driver for GXL boards, let's port the driver
to U-Boot and sync the GXBB/GXL/GXM DT to make use of this driver.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Fixed copyright line in mdio mux driver
- Link to v1: https://lore.kernel.org/r/20231212-u-boot-gxl-mdio-mux-v1-0-9adaa5cc7afb@linaro.org

---
Neil Armstrong (2):
      net: Add Amlogic GXL MDIO Mux driver
      ARM: dts: sync Amlogic GX DT to Linux v6.4

 arch/arm/dts/meson-gx-libretech-pc.dtsi            |   4 +-
 arch/arm/dts/meson-gx.dtsi                         |  21 ++--
 arch/arm/dts/meson-gxbb-nanopi-k2.dts              |  13 +-
 arch/arm/dts/meson-gxbb-odroidc2.dts               |  26 ++--
 arch/arm/dts/meson-gxbb.dtsi                       |  18 ++-
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |   2 +-
 .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  12 +-
 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  16 +--
 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |   3 +-
 arch/arm/dts/meson-gxl-s905x-p212.dts              |  68 ++++++++++
 arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  21 ++--
 arch/arm/dts/meson-gxl.dtsi                        |  43 ++++---
 arch/arm/dts/meson-gxm-khadas-vim2.dts             |  15 +--
 arch/arm/dts/meson-gxm-wetek-core2.dts             |   2 -
 configs/beelink-gt1-ultimate_defconfig             |   2 +-
 configs/jethub_j80_defconfig                       |   2 +-
 configs/khadas-vim2_defconfig                      |   2 +-
 configs/khadas-vim_defconfig                       |   2 +-
 configs/libretech-ac_defconfig                     |   2 +-
 configs/libretech-cc_defconfig                     |   2 +-
 configs/libretech-cc_v2_defconfig                  |   2 +-
 configs/libretech-s905d-pc_defconfig               |   2 +-
 configs/libretech-s912-pc_defconfig                |   2 +-
 configs/p212_defconfig                             |   2 +-
 configs/wetek-core2_defconfig                      |   2 +-
 drivers/net/Kconfig                                |   7 ++
 drivers/net/Makefile                               |   1 +
 drivers/net/mdio_mux_meson_gxl.c                   | 138 +++++++++++++++++++++
 28 files changed, 342 insertions(+), 90 deletions(-)
---
base-commit: 65eed687729c28431d38c6c9174da4d878fb107f
change-id: 20231212-u-boot-gxl-mdio-mux-bc027eab0273

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


