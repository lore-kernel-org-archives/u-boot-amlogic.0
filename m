Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA5FC2BA15
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 07:55:41 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.81276.1718697333503251151
 for <u-boot-amlogic@groups.io>;
 Tue, 18 Jun 2024 00:55:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=AHmZviQX;
 spf=pass (domain: linaro.org, ip: 209.85.221.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35f1e35156cso4497917f8f.1
        for <u-boot-amlogic@groups.io>; Tue, 18 Jun 2024 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718697332; x=1719302132; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ng86sJ2ghzSyCipipXjg3ALFwIc9lDdOQozhclnwpHI=;
        b=AHmZviQXlWehQdjTsABScBzUBveSukbJFQpTxrr/TOp4mOKdQFVn9gl7m356D+8gy2
         SWuJ1IWx6EsKvlLmaMw54mD/IL3ZR31wigW9RPQtqmiBpszQtaNt94lsT7WYVEBWxXdG
         1hrwJu4lK2HeWLTFzdPrWehfxLipZ+Y3gc850KrYQtKMDarsGPv07TYE6+zEb8XB76zx
         1szFiOcoV3SNXXac3FiCe+CgkTvZ5mO1VUSBhDGcaTK30EGxw3amzLpmF6iC7agNvANL
         fHq+AFcKbRt9r5zEqZHd9KiKe1bZGjheBpo05qm523KshVERco9HnUwORxqOJybTe7J9
         tzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697332; x=1719302132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ng86sJ2ghzSyCipipXjg3ALFwIc9lDdOQozhclnwpHI=;
        b=aLAly0VrQeu5pfoC4BOAnoQvS6tYH76x1cDS/gROjGKBtzEwXe4HJJRnNi9LPXLEVV
         OJJwIXEIBayxzhvKTGzJtuQDlcFoYGL+Lfp9IcVysMtf8rU32C5F5RtzYQKs9OTHaTyc
         cAeKWYLNTHowIEj9xqK1FsIkxz/pok8gaUt2N5tVoksbtMCcqwVKv5jcAw1ynynF53K0
         EnZaEnknNvADTfiPnGV1ykAvFrjFU62dlK0wthRIK6VMOUr9NODkJ7Y87z69RxFPgRiz
         zORQLpl2k2Cf3eRLlxzByl1UEYLdfDNxgorJUGgJyXapy49BBwSGs1yi6NUT+O5gFNvp
         0DCA==
X-Forwarded-Encrypted: i=1; AJvYcCVXDJxo7t4mb+ZydZHc3Kv810ZR8NDNWtwgFZ+1CDKvCn9PWalEASiMbv84CGmAEQYEzdMOVmLq7wGw8xpjomsIA/PU7PFV/Yw=
X-Gm-Message-State: AOJu0Yzy3QvaalULYJ3eeoamkIMvUS9SkKAJYZJhjii81vRv5hr0l4H4
	NAC12Mw9k0XYNhD1Llwn8b/nk06kmkz5+neTeJU0a8BFp7pU1fddgkn2JUiEJUI=
X-Google-Smtp-Source: AGHT+IF3+MFlbe8WRPl8wVcUhh9+j996lJz1oFd8QJgHy2Xr5j7iGptdYQzdmpJjNqWFNWAk/CRuXg==
X-Received: by 2002:adf:ed4a:0:b0:360:8610:f65c with SMTP id ffacd0b85a97d-3608610f701mr7147414f8f.2.1718697331728;
        Tue, 18 Jun 2024 00:55:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750934a4sm13523173f8f.10.2024.06.18.00.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:55:31 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Jun 2024 09:55:25 +0200
Subject: [PATCH 1/5] phy: meson-gxl-usb2: add set_mode callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-u-boot-usb-gxl-phy-set-mode-v1-1-6b41efa46e35@linaro.org>
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
In-Reply-To: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=QrdXQDAZOcLlaK5yVj7NQO4xP3YC9Lve3402Xe1o/Z0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmcT1wahIGV93lln4pALoceMgxycK4q4efdD1Tb3Sf
 2UH05sqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnE9cAAKCRB33NvayMhJ0a7VD/
 93Bh9V2JqZnPEA+egLwNCqMtbUxPHoAXfB8lV1pjto5BDWPLz/rNzbmSgY+i6Mzkhazhol+5BXEy+p
 Md+oLtv1RjcsOj9X8JmB1S9cKU6h2T46uUGjQNZE0h3xcP1J9QsTFySmxbSPcaLthVPp0VKiPQTFb2
 IYr1ZnXSgqW0OU0kkEU8KiK9P/sRe1EQ8uGyh/0pt1BRmhQsjRvc2nld2E8FwX/bnC1x1aSOCJuzzs
 NlkGNYNBawte5VsnxjD9eF39QNuXdEpvFkNR94mdOXYcTVLEsibWmkw7dk+ojxEB6vYa0kERSIj8mJ
 dL40+2Ll/vXDhQZCp930phfQQUFDxg0IEqFSqi2RK8MNJvIekCLKRk9+0RkawDH7ywiqLSoABrycLI
 7ojrPv2SRFBWvFMnvl/g+u3sb43x2XJbKhr5FMHY3UgNTthVW1JZBglf7IMJh9oiVBYF7D1EOsv9Rx
 UApqWTToU+AF34hZCSokN2yYUiOd15nq7vjZFRrbP5bmGfrd9Hp9eFe0QtDLRwnSqxJyYRhusxyq0s
 hyJgRoWEVYHWo7+wrtVqlLb+1D45bVVl3GnNafY+y7bn9bn0H3pwq12I3RDQlLmYszdFHvdJzuJ7Vu
 yg5RYGv8AyPqkrDzLNr/JlSVxa88AXP5rpxV+rjvbiq8c+4vz8paGr+LMmnA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 18 Jun 2024 07:55:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2299

Implement set_mode callback by calling the current public
function.

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


