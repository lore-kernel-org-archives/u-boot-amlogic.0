Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD9C36010
	for <webhook@archiver.kernel.org>; Fri, 11 Apr 2025 14:55:41 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.28415.1744383334820966814
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Apr 2025 07:55:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=YgH7l9HV;
 spf=pass (domain: linaro.org, ip: 209.85.221.42, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3914a5def6bso1228820f8f.1
        for <u-boot-amlogic@groups.io>; Fri, 11 Apr 2025 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744383333; x=1744988133; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsNgx6w9Y8XSGBfjyutbVSS9ReV242t00p5t2z2vj5Y=;
        b=YgH7l9HVR/MQ6J23hPOyCn7G+DzUkgFv7SSm+pE4/wT952+D7xmrXdBTe2edZiFJ3n
         ufzHKgISz1Qtv0ZeS0qFHelXQtNjxeHQo5CTVY2/C57F1OkVYvtdpfIuAoT9Bl0B+ASU
         Fth4UVXbHHsX2Asi7s50PWe0t/9sveQ4+yAw71ZYDTlElEtYqmBcH1gvnDpn64+nI/SF
         oyvLidE+SfFCTbB0OEJ+J2nD/gNntvSSxxLwoEJA93ncULL3vahwPRP4qDEmN1vFRyly
         HYE6LcEbpevjPmDI9RgkT1J1hHQIt8M1pAOKXnLebbFalSa/d2ba69kwgS9Fin2eecaI
         Dy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744383333; x=1744988133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsNgx6w9Y8XSGBfjyutbVSS9ReV242t00p5t2z2vj5Y=;
        b=HhbVf5hAGIcpRMzpnnGFBZy7aHtPBoM15k8/a7Z1/IzAAHjcYkZeafdSwwkYKz9N/R
         Z+twr7R1V51Hba6z/4dT27g5KIkKrzEM9qvcwd2U0RDYlCI3eSegwTL8aQQErc0rSRV2
         V/3iDvTHbOdjPPHW1atnKT6rtgjkzOxNx7YyWc+OgLO9yWNi1tNrsjDXpeQObrnsR7A4
         foc8czKjmgDEn0LxMr9LcyUTn6WPx4SQuW26rNwg9oAPQxNMjCWMjVWwzOirwraR6KXw
         aeMRN6YSG1EjhrO2c0OpKHuPC3GfEM2oK+t8x8CPVo1KJ0sEDieWLRnQ0GiWdvUefoyY
         mUMA==
X-Gm-Message-State: AOJu0YxYJeSzoxE07EjfAgO0iNUFwOKk3CIC9Jyr8FcvVt2bGvexzy1x
	VcMumVuZOMF7OF1C+uO+WeIHC3XG+PpDaSQqGL+mcEF3vCei+DQgRmM+4KiWIEE=
X-Gm-Gg: ASbGncvWMYf4z+d/AdzC32Lcy9sHoU7EcA1vyiUYeDnSElvFxVTRbDNq5JBJmUqq9ty
	2sq4Tw7cXj0cWxKM2/MoFM75iL5mV3UwA50Knj8cWE1iA8v1RcJjIrpKPEX2IeKuj85oLYh0sCQ
	ID3SeJ1WAsFgCmQgWxumJ07pwuz32R4SeEGWhc4qiUXMzlkGak55JT+gu4tHPMZgzxPG4EgrL97
	6YAUqOrbCdOzm0BJapFmnQ0WmFLEq2g96nVt9gY+bVkRsDYk9pZMwJo80wcbmorTFDcld38AHBM
	jOA+S33hT7NcMYOgGmIjPUpiC4748T8oAlRaDzAyVfw97UgAlqhW1ttie4JFVQ==
X-Google-Smtp-Source: AGHT+IFZpwyl7wugZBzdjRWD1NP0HnwgDVZsj+Bd9rLCl8fa2aXVarZEmUlZ7tF8iAVZBNAUlXMSkg==
X-Received: by 2002:a05:6000:4205:b0:391:40bd:6222 with SMTP id ffacd0b85a97d-39ea5200a8emr2024168f8f.22.1744383333257;
        Fri, 11 Apr 2025 07:55:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eadda64ecsm2279119f8f.0.2025.04.11.07.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 07:55:32 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Fri, 11 Apr 2025 16:55:30 +0200
Subject: [PATCH 1/2] pinctrl: meson: convert to livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-u-boot-meson-livetree-v1-1-ebe31909cba5@linaro.org>
References: <20250411-u-boot-meson-livetree-v1-0-ebe31909cba5@linaro.org>
In-Reply-To: <20250411-u-boot-meson-livetree-v1-0-ebe31909cba5@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Beniamino Galvani <b.galvani@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4864;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=P6dTiCTGOxNhdQB0+tiXTIyW5a6Up5qyg/k1RIKMCHw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn+S1jOhkbFRFihRzEtKDQsQqgt4qzbeB+io/YrnkQ
 gcNOdAmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/ktYwAKCRB33NvayMhJ0RPOEA
 COJnOv5OF54jIzetmIdVGkN/0chpQaSFfsCCPK/kmNW42sbGlmLMetspbjep5xOWSCzI65F7pyX9j7
 EBNIRKXwYbi2kbb+6Q2zDR12oHPzduc7nARUvssB5z832uuYLxujs/Q3TZBNUOs7jml0YhoQVJv831
 C6iCMqW6BaoTHkAgi0JuO9y1FKOJ2txWh6HETd3nouH3rhZxp1N949b1TYCXWe3/kkEnL4fybeZ+Gr
 h2T8d+c5TuAyPTVjAT57vbrnOMYT3os+84+QyuG3KF6fH6vhVLsUGI3+xbE+w227UloDGv2koq4CA7
 g1EmuClHRTMWQrBzqRlqlqZXkgfvot+k5y3l7nHvbUq45d64esqhKVkvlCrWvqYgsUcxVn6UgXuPIz
 q1ocIrWV3IUJI2muJFiz2IFS9AVrta7MRpDK2lBP5NM8KTR3buiN5T16I6zabjtwbVvnHmtMMToPjP
 8Z390MnPoBKYZINSN8t/Y9KoVxz0hBkVq6Fhjxxnt8xf8lrE4lNv/5oxLNII6hPT0DEA8W2wwn2CDv
 7lL33GmAO4pEQXPK3J7Z0FI3mFAdQWIpYqhnxW3ISbARWX+BF3efZcrLSBmB9VctY1YlOPBpEuHUOp
 eN/wQGG9fekZIvBudPEOrea00NAlW240LTUTnodMIOzr8gDeEj8MY9qptuDA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 11 Apr 2025 14:55:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2662

From: Beniamino Galvani <b.galvani@gmail.com>

Update the Meson pinctrl/gpio driver to support a live device tree.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
Link: https://lore.kernel.org/r/20170709223006.3998-5-b.galvani@gmail.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 73 +++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index babf1bccc9697596522dc93d8906ff0454cfebf5..21409063ee89cd2f8aa3d511f3fed6b64f800e51 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -10,6 +10,8 @@
 #include <dm/device-internal.h>
 #include <dm/device_compat.h>
 #include <dm/lists.h>
+#include <dm/of_addr.h>
+#include <linux/ioport.h>
 #include <dm/pinctrl.h>
 #include <fdt_support.h>
 #include <linux/bitops.h>
@@ -319,88 +321,91 @@ int meson_gpio_probe(struct udevice *dev)
 	return 0;
 }
 
-static fdt_addr_t parse_address(int offset, const char *name, int na, int ns)
+static phys_addr_t parse_address(struct udevice *dev, ofnode node,
+				 const char *name)
 {
-	int index, len = 0;
-	const fdt32_t *reg;
+	struct resource r;
+	fdt_size_t sz;
+	int na, ns, index;
 
-	index = fdt_stringlist_search(gd->fdt_blob, offset, "reg-names", name);
+	index = ofnode_stringlist_search(node, "reg-names", name);
 	if (index < 0)
 		return FDT_ADDR_T_NONE;
 
-	reg = fdt_getprop(gd->fdt_blob, offset, "reg", &len);
-	if (!reg || (len <= (index * sizeof(fdt32_t) * (na + ns))))
+	if (of_live_active()) {
+		if (of_address_to_resource(ofnode_to_np(node), index, &r))
+			return FDT_ADDR_T_NONE;
+		else
+			return r.start;
+	}
+
+	na = dev_read_addr_cells(dev->parent);
+	if (na < 1) {
+		debug("bad #address-cells\n");
 		return FDT_ADDR_T_NONE;
+	}
 
-	reg += index * (na + ns);
+	ns = dev_read_size_cells(dev->parent);
+	if (ns < 1) {
+		debug("bad #size-cells\n");
+		return FDT_ADDR_T_NONE;
+	}
 
-	return fdt_translate_address((void *)gd->fdt_blob, offset, reg);
+	return fdtdec_get_addr_size_fixed(gd->fdt_blob, ofnode_to_offset(node),
+					  "reg", index, na, ns, &sz, true);
 }
 
 int meson_pinctrl_probe(struct udevice *dev)
 {
 	struct meson_pinctrl *priv = dev_get_priv(dev);
+	ofnode node, gpio = ofnode_null();
 	struct uclass_driver *drv;
 	struct udevice *gpio_dev;
-	fdt_addr_t addr;
-	int node, gpio = -1, len;
-	int na, ns;
+	phys_addr_t addr;
 	char *name;
+	int len;
 
-	/* FIXME: Should use livetree */
-	na = fdt_address_cells(gd->fdt_blob, dev_of_offset(dev->parent));
-	if (na < 1) {
-		debug("bad #address-cells\n");
-		return -EINVAL;
-	}
-
-	ns = fdt_size_cells(gd->fdt_blob, dev_of_offset(dev->parent));
-	if (ns < 1) {
-		debug("bad #size-cells\n");
-		return -EINVAL;
-	}
-
-	fdt_for_each_subnode(node, gd->fdt_blob, dev_of_offset(dev)) {
-		if (fdt_getprop(gd->fdt_blob, node, "gpio-controller", &len)) {
+	dev_for_each_subnode(node, dev) {
+		if (ofnode_read_prop(node, "gpio-controller", &len)) {
 			gpio = node;
 			break;
 		}
 	}
 
-	if (!gpio) {
+	if (!ofnode_valid(gpio)) {
 		debug("gpio node not found\n");
 		return -EINVAL;
 	}
 
-	addr = parse_address(gpio, "mux", na, ns);
+	addr = parse_address(dev, gpio, "mux");
 	if (addr == FDT_ADDR_T_NONE) {
 		debug("mux address not found\n");
 		return -EINVAL;
 	}
 	priv->reg_mux = (void __iomem *)addr;
 
-	addr = parse_address(gpio, "gpio", na, ns);
+	addr = parse_address(dev, gpio, "gpio");
 	if (addr == FDT_ADDR_T_NONE) {
 		debug("gpio address not found\n");
 		return -EINVAL;
 	}
 	priv->reg_gpio = (void __iomem *)addr;
 
-	addr = parse_address(gpio, "pull", na, ns);
+	addr = parse_address(dev, gpio, "pull");
 	/* Use gpio region if pull one is not present */
 	if (addr == FDT_ADDR_T_NONE)
 		priv->reg_pull = priv->reg_gpio;
 	else
 		priv->reg_pull = (void __iomem *)addr;
 
-	addr = parse_address(gpio, "pull-enable", na, ns);
+	addr = parse_address(dev, gpio, "pull-enable");
 	/* Use pull region if pull-enable one is not present */
 	if (addr == FDT_ADDR_T_NONE)
 		priv->reg_pullen = priv->reg_pull;
 	else
 		priv->reg_pullen = (void __iomem *)addr;
 
-	addr = parse_address(gpio, "ds", na, ns);
+	addr = parse_address(dev, gpio, "ds");
 	/* Drive strength region is optional */
 	if (addr == FDT_ADDR_T_NONE)
 		priv->reg_ds = NULL;
@@ -420,8 +425,8 @@ int meson_pinctrl_probe(struct udevice *dev)
 	sprintf(name, "meson-gpio");
 
 	/* Create child device UCLASS_GPIO and bind it */
-	device_bind(dev, priv->data->gpio_driver, name, NULL,
-		    offset_to_ofnode(gpio), &gpio_dev);
+	device_bind_with_driver_data(dev, priv->data->gpio_driver, name, 0,
+				     gpio, &gpio_dev);
 
 	return 0;
 }

-- 
2.34.1


