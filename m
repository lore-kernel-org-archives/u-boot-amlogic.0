Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE5C3DA40
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 07:43:19 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.42275.1718869389462484973
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jun 2024 00:43:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Jwg0wRY3;
 spf=pass (domain: linaro.org, ip: 209.85.128.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4217990f8baso6698835e9.2
        for <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 00:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718869388; x=1719474188; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDDH6W1yI8NI4YqelULBhfcX0NinRTSGgqj9ke2z5fw=;
        b=Jwg0wRY3EN9WiElYbujg/2DMSI1oC1+r3MMyZ6hL1jnL4Pryu/K6lWlhQFtu5MHLoP
         rBxh4aLkqa1QsFsGfjmErlzesF+g1GXyM79AuwShjYmjtYPKpG/G3MGpvLFY8h9nEsRC
         S7vKsVb0DdGAcayJYo87YXxTIDoEgBcf2MTagGT/ZhR76k+onAin5u+PCmrCO0TOrAob
         scvgMvnFK/+WJJDeThu6qyl1G9oPhulzWqGGZcoP99B2DWTHQpa3U1n7T6kh6djiY51A
         u8mqNFclJ5acJknCFGLGjK3pif9PCj7q2o9jXWiQsW1GDnRjKlU44jcLk/Qsdcy5oIiu
         LLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869388; x=1719474188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDDH6W1yI8NI4YqelULBhfcX0NinRTSGgqj9ke2z5fw=;
        b=cfPU6OIotQw9Sggm/UCo3tNXchUeSgX99DfgAH0q+dapF3w+sQJWBlScPL41bW25c+
         2H8+1WoE8iS6mC9VQ44X0fGnBvElYEm6UhGEtTLY01l6ruwn46gZcsrE5Fo6cmGcZqXA
         WozkOk7p8jZl+V1RJxYz3vjtZmbBNO2yRScVEdUzZNpOD8JiAUUwXjfcDZgxKNJY8a31
         Y4QR+uqhbmczn7IbDSmLVcmDf6Lvli4bddhiJuAmeBT2La+k7Q6EHTAqFVdKaynLQRrV
         k7+qBnYNWJD1XRvlwJTBqPQcv1CIBijinhdvfUM6Bt0banT85s0Zqqq58ictvajCkOga
         Uw0A==
X-Forwarded-Encrypted: i=1; AJvYcCU+K6xyVEM8uEdbcto9PAxQFh4QRlZOhaWKpqCGXaNSrchg3lR8acHE06r6HlO+G75SAF0ucNdncCo6NGak5HD1ek6VMRhWthA=
X-Gm-Message-State: AOJu0YwsfomNVlSaxH/AKE36gfsRObor8t9bCCaWnmhKo2o9MNlkuKmu
	U8fkeEl4ikng8IuPZOF0tg0UXWI/91bjxmeCR8xSgh5WkpiOK5iPl7u6ygbXemd6MNcGnhwDDYj
	uoZM=
X-Google-Smtp-Source: AGHT+IFuZPiJdS7+bsHAg8eP4mr2HBiOTNyD4jjT3flArtUqMKnFD5afdjg4Ey4iS43n5RKZiUWaEQ==
X-Received: by 2002:a05:600c:1d08:b0:422:4fcd:d4b3 with SMTP id 5b1f17b1804b1-4247529f03cmr31522135e9.37.1718869387591;
        Thu, 20 Jun 2024 00:43:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b6402sm15506785e9.10.2024.06.20.00.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:43:07 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Jun 2024 09:42:50 +0200
Subject: [PATCH v2 1/5] phy: meson-gxl-usb2: add set_mode callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-u-boot-usb-gxl-phy-set-mode-v2-1-b81c027bc02c@linaro.org>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IWJf0JYlcNf5Di+OmZ8xUtR2HrzmkAk7v7H7DdmZDZE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmc92FbQJ1hDAvd8TBFcIQMBelkib766wFy9HIvJ66
 nkO2eV6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnPdhQAKCRB33NvayMhJ0doHEA
 C2oIVpgGSx/ONK7UhrvNkc0MegEPcaanVPO/wYSfrXrYIxhMArRqWSOtV0Vh6b2rHiy8QSkLKfZP5i
 /dFe2lDHrl7sT6jmNzmui4ik6Km0PgWobAA0zuTiiy7Q+4cz02yFSwrQgxp0FD23T6VB6sPU8pmQWZ
 54PuJLrD3J8lg1dLp5foE21MlPM0ihC2EttLwGFacBtSAmn1HNwXYWGqq02FTcppjTZ//PaFgRhliy
 T98IDIBoGbUjmYqLM3a1J/3MiZDDSfcKmC5Betwni2w7NkC093I0lDpmueOlR+dhWBWEH/c9yNPmMD
 0PLbk0wtyKPLh5wcCDAvCP3PdDqA5EZvMfXZd4VhPAASF0JnbdDPgacSMj1e01Qcc67VAI1C5eczJd
 WWCbjHL4GOQ0JtqZNS4ATZJoWt+77PDTJtUBtrRPGNyAyjo2L/C9gSxMjZL8jQPRBEl+cu/3Rf+AC4
 Iclo6R7hF88dIwMmnyNlAdWZgBoIkb15uC+PsU2rt7xDc87zqXorxdN+nkTQvMxuenK2d+WnJlXujw
 MVOd3gSoKm+Jtk4KCtZdwJxgJoUy87WUDXVX+uCSzRi9PdrkwaWt3zSvRuPma5L4hyuhSRapp0EmFy
 XteXzFtZUwKcl6SqFesbwkT8GdmoUtlmMUTlT2TceA9ufCwdxUQ0RkPho8ZQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 07:43:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2308

Implement set_mode callback by calling the current public
function, use a temporary function name that will be removed
when the public phy_meson_gxl_usb2_set_mode is finally removed
in a following change.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/meson-gxl-usb2.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/meson-gxl-usb2.c b/drivers/phy/meson-gxl-usb2.c
index 92c285103c..e051e66224 100644
--- a/drivers/phy/meson-gxl-usb2.c
+++ b/drivers/phy/meson-gxl-usb2.c
@@ -150,6 +150,28 @@ void phy_meson_gxl_usb2_set_mode(struct phy *phy, enum usb_dr_mode mode)
 	phy_meson_gxl_usb2_reset(priv);
 }
 
+static int _phy_meson_gxl_usb2_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	if (submode)
+		return -EOPNOTSUPP;
+
+	switch (mode) {
+	case PHY_MODE_USB_DEVICE:
+		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_PERIPHERAL);
+		break;
+
+	case PHY_MODE_USB_HOST:
+	case PHY_MODE_USB_OTG:
+		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_HOST);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int phy_meson_gxl_usb2_power_on(struct phy *phy)
 {
 	struct udevice *dev = phy->dev;
@@ -161,7 +183,7 @@ static int phy_meson_gxl_usb2_power_on(struct phy *phy)
 	val &= ~U2P_R0_POWER_ON_RESET;
 	regmap_write(priv->regmap, U2P_R0, val);
 
-	phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_HOST);
+	_phy_meson_gxl_usb2_set_mode(phy, PHY_MODE_USB_HOST, 0);
 
 	return 0;
 }
@@ -183,6 +205,7 @@ static int phy_meson_gxl_usb2_power_off(struct phy *phy)
 struct phy_ops meson_gxl_usb2_phy_ops = {
 	.power_on = phy_meson_gxl_usb2_power_on,
 	.power_off = phy_meson_gxl_usb2_power_off,
+	.set_mode = _phy_meson_gxl_usb2_set_mode,
 };
 
 int meson_gxl_usb2_phy_probe(struct udevice *dev)

-- 
2.34.1


