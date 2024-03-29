Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5FECD1288
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 17:51:59 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web11.2099.1711734716641232190
 for <u-boot-amlogic@groups.io>;
 Fri, 29 Mar 2024 10:51:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=xuK9EHPN;
 spf=pass (domain: linaro.org, ip: 209.85.208.174, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d700beb6beso30296551fa.2
        for <u-boot-amlogic@groups.io>; Fri, 29 Mar 2024 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711734715; x=1712339515; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPyKR8c+HUGd7Kj901YcjRNsUpk2pLmpbpRUS6I1Fs4=;
        b=xuK9EHPNE3q+xLbQGhc2vjLkZQwE//ksYnTC82wDnfaqgsTAtK22ogSiypsVrHSAnu
         HaPGairZwTFJkIOafQSkhDVTVA/D2OJoorYBLQ5P0KmocsW+npnhZiCrBUHWXvwQy7zS
         82tZUBKD+7YCRDLxwiVavSXaei6TABA7t/gXBSKoE9361ppSlqUju61VXm4CaOAGeybW
         OzIEUGmnvn0rIu8kgHYLOT4unyls7DSHZjykAl579GjJIivZDOQArrRWvAw/Rxo9Z4cl
         o1jQRflKHh4ZFMZxNPGOSccnuxdSWKOsLCbvjVdHp6jJuPmoZpCY3jo0uH43shlX4tU9
         cHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711734715; x=1712339515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPyKR8c+HUGd7Kj901YcjRNsUpk2pLmpbpRUS6I1Fs4=;
        b=UozTrsQ8P1iNqc8koC+SIh4Q9IskZo5G7A8Y7pyGgZ+1rIXRuyoZPz7e0m7pBGcs1k
         LadT66s1D6ueHAA/CT3CPKInhB9iIVMt5pI+H6qaHAw0fUveLINfvErSMAh/J0Q5HJy7
         F+2N9fToI4ejCLoc32jhLmQ5gi6GAOi5f5XSd7621GX/TONxi3j6NIbme0/chKis0O5u
         4kmYcrkArlgu8WnY4uIEN+wRa5RRZnBl2c2wqJsQ52O4p+jwMDZH2dGX/rS12nrgXySf
         lkLMVVjQfzFz0mK9pgHZIBqss2fzorbSZIfW+VOzBrV0AZTLhw9TMyohN6l03anjg/pX
         HokQ==
X-Gm-Message-State: AOJu0YxiyA38hzPuhgZTG/6DgLiHwaXZf4Ww6HWuxvSS/6dpxeboe+Rw
	J/aSTZ+Dak+BwA0czFHF4ZQxHNUlVX/FglqNYEO/hSyaUapapK5B0II6CgVLSp0=
X-Google-Smtp-Source: AGHT+IHda5KRDcIgbWGgiYkYmU4Mq4v/hgUUv1mVABwTqPdTmQu4D/HkT59pIJ0ndW+FJDHTRyxB3w==
X-Received: by 2002:a05:651c:104:b0:2d7:3c2:ef4b with SMTP id a4-20020a05651c010400b002d703c2ef4bmr1458172ljb.26.1711734714786;
        Fri, 29 Mar 2024 10:51:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c3ac700b00415509b33c0sm2127781wms.10.2024.03.29.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:51:54 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 29 Mar 2024 18:51:48 +0100
Subject: [PATCH v2 1/5] configs: meson64: remove amlogic prefix in fdtfile
 when CONFIG_OF_UPSTREAM is selected
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-u-boot-of-upstream-v2-1-2512ad3eb63d@linaro.org>
References: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
In-Reply-To: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OiGcdP/E7JFCNo2hlX3NguWrFUlUUO8UFZQtO3H7QGw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmBv+2yPFsmFhev0pPFOcV9ZVH7Bc7O2OhuuQc83r2
 WVObhHWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgb/tgAKCRB33NvayMhJ0VChD/
 9arAZCfqUHs84bfiXwuUWWObnocgxbGCSsm/NYMvvFYRXBV48kJbichYfscuihsgh7UuXW9O7G4FxX
 VzPHPZhGeaIcoQ9StxqkqzGOivEDNZ0rQhJax8JN7GFqVaz+Ewsc5Kd/i99AFqVG21MJkodl0HBAPJ
 Cx8W0p7Th1ZRBkCgVcZ8Bpk6xwFRc3R7ET3GhmU6u0BmXsEltaaL0l3qGk3Ur14DKjvT3TaTVERou8
 dWv5cv9brb35eHv5ef9uwJVxbs1JQiCPyNGXr6Uxsw3Ee3c+Pc0A/KgFpbCxJD7VpiO9jsd3RM0mge
 UhSqQXRgZSjfR6XzPHGYNN98rNKJwm5d8rLHNTe6MKUBmFqyVq4PL2W6IcNfZuK1luO0uV1VxqO9dd
 ERrhXzSHbScuaEfR9OzPPVXWjNXiUgKmeI0o2bas/HBTFI/zpUZKc6Af118MHAwlLTmhDYMHQKMj7Y
 U6fWLtOgdzIuYTj/PrNVomuFMJnkjinJRGGGsL0NrH9LExy+UAt0jAcGeQTBn9mXSNFRm/GEnkWDDt
 +bV9NOAtr3Jg/eUouRR9nbcUVIhQXHWgpC8wFPinFqAOBvx5oxAexUUFvX9GsYScRVi92KipVfhQBA
 g3og2a4nFGVzPwhgpoMeb+ls6xC8y1R6uMWngwQBK469VVPBAEAKQWThQs9w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 29 Mar 2024 17:51:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2257

Remove amlogic/ path prefix in CFG_EXTRA_ENV_SETTINGS fdtfile when
using CONFIG_OF_UPSTREAM, otherwise amlogic/ is added twice.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/configs/meson64.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index efab9a624d..65fa5f3d6d 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -120,6 +120,12 @@
 
 #include <config_distro_bootcmd.h>
 
+#ifdef CONFIG_OF_UPSTREAM
+#define FDTFILE_NAME		CONFIG_DEFAULT_DEVICE_TREE ".dtb"
+#else
+#define FDTFILE_NAME		"amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb"
+#endif
+
 #ifndef CFG_EXTRA_ENV_SETTINGS
 #define CFG_EXTRA_ENV_SETTINGS \
 	"stdin=" STDIN_CFG "\0" \
@@ -133,7 +139,7 @@
 	"pxefile_addr_r=" PXEFILE_ADDR_R "\0" \
 	"fdtoverlay_addr_r=" FDTOVERLAY_ADDR_R "\0" \
 	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
-	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
+	"fdtfile=" FDTFILE_NAME "\0" \
 	"dfu_alt_info=fitimage ram " KERNEL_ADDR_R " 0x4000000 \0" \
 	BOOTENV
 #endif

-- 
2.34.1


