Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12273C3ABA3
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 06:51:57 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.13615.1746168708250915476
 for <u-boot-amlogic@groups.io>;
 Thu, 01 May 2025 23:51:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Iaykv1au;
 spf=pass (domain: linaro.org, ip: 209.85.221.47, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso1713166f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 01 May 2025 23:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746168706; x=1746773506; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jvqo3sXWziR8Flkh0fsHX/laX/gCDKF6x4XRvzgY4Q4=;
        b=Iaykv1auJm6obV+Rp06jxhAq+OKvWSdMso6xuxBlFd5DElM6u6k1bqWDgO/8+ony7+
         U8n3fazSRs9Jj6mWg6u8ANCQI22uOT+G/Zyn+onBycfgYm1JbN8luDgbpt+7sdvh5oCp
         BvrTk4UCXG+bL9CmalCQ4WPvsRaB4k7WB9HNvJ/W7fCiyji4fMIne3S8ncHL0/WoKWER
         EkLmdAvgEe4jkW7nGo7t+KVKj72WjxzOXLsaz1Q2wLPVUV+UaUje6ljB5dpNuDq9LwvP
         /mqiX63nv3PViB+sdpyP1DUsRTkzxkUngu8UdPuhVNtKwgcQz7u76EB0r5QDUwSYpP0a
         LpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746168706; x=1746773506;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jvqo3sXWziR8Flkh0fsHX/laX/gCDKF6x4XRvzgY4Q4=;
        b=LnHkTpwgt6aNSTx5ymkfd4r6Ifi2gqfOW7oSN/MaSaB/zFLNDw2tpd5CtA7Ms4TzNF
         Y6oUyxoQS2ZeRCNeO0SXBS1ABkHte3jEg3HfmhNpyYgd6b2UaAenuPDMEizbKU3azyeP
         JPO7V0m/1cd8V3+EFjhgb+HTL6pO4fJxf/geQCELpVgGhZbiaHM+plzj9ZeFycSmNizm
         Uo6XvdQzgMD+iGFYzjlZpu22p4RbxPPFb7cW4Rwa0Uk6PCMtpLl9p9AZpjAPna9j4eF2
         HB7I7ehFBcsYsaYcsAEK0mVdzjvEY66dN0lAQn0TIbJBIWpBBseYO+kdjMOjJYa1v8Jc
         EGtw==
X-Gm-Message-State: AOJu0Yxz+fvmSGI6KP/IY3bkax+fi3ltbHZF/PwH0Y5p3sUPKs5oBiuN
	nE1DtiIwoQFHKrYT8K3eIa9W/G30uHutljUoNQIRIGABsRB+FOwIVlxl/ra6mmQ=
X-Gm-Gg: ASbGncvQMnxOb2eF3oZabbNkmiQRxCC+/u7GT4YR2jbSBJt22QwJgLeQiSPBgjMgSr4
	J+Uw83Y735yW7hPmgbCjWUum81nU6NLRXnLLjSf/VScWMGKs3QWFkC5Fg4lT6AxCcwsmXudvRQ8
	x11NmtpO49t9S8Y12O6WBhB3VPTwYmUlweAeLxbRRMoQqv7YSeYdmNCkmowejbfmM9oUtzTVLdH
	LUc3LTywjvU3LznVsxhNVgixIQwTkqj/YEw3sh1BvqOFRH/TC0F9BanvAbKoAE0YtSSGm3mcDWY
	fP4ge8+N3rTYaUK7DbJbMNut+jR62+InNkv8qRZzUvexckW4xY4gIyrvDQ6D6A==
X-Google-Smtp-Source: AGHT+IH3ERCJL7wsWYOR2zV3do8JLHVQP0huSgFpIItt+jX/OPTNJ7j7EhbAsoynDbXnGbVFiuueZw==
X-Received: by 2002:a05:6000:2908:b0:3a0:88d5:7fca with SMTP id ffacd0b85a97d-3a099ad29fbmr995361f8f.12.1746168706470;
        Thu, 01 May 2025 23:51:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0c3dsm1301109f8f.12.2025.05.01.23.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 23:51:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 02 May 2025 08:51:45 +0200
Subject: [PATCH] net: mdio: mux-meson-gxl: set reversed bit when using
 internal phy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-u-boot-topic-mdio-mux-gxl-bit28-v1-1-399f6c3db154@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIBrFGgC/x3NQQqDMBBG4avIrPtDmmAJvUrpwpjRDlRHkigB8
 e4NXX6b907KnIQzPbuTEh+SRdeG+62j8TOsM0NiM1lje9Mbix1BtaDoJiOWKIplr5jrF0GK9Rg
 e0bgweXbeUatsiSep/8PrfV0/MwMTYXEAAAA=
X-Change-ID: 20250502-u-boot-topic-mdio-mux-gxl-bit28-a6d03bf8e383
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Da Xue <da@libre.computer>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zTJoWKUCYaJ+JTk9qHMoBRiWtUADaEfro8L/suVST7w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoFGuBqWdAidMyi9YN1ynArFf8CC9iinwrPABLfZZ9
 oMQ/k7mJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaBRrgQAKCRB33NvayMhJ0WxCEA
 DDAGNEX+sUkBB6OkOPhXnss0LPhuWHbYz2/ZgRwuvPPbFgjB690cBu93nRpy0u450Iziqut6KBUv/V
 1aVThyoJaLpNWahJv83D+gyCud4f9s8nR830Wd/bhj9yac0EuZz/kXiSKfoQNY3zWjB5V2Z3ZNCDQ6
 JKSOGxkXtuo8foo2afV1xtaam2fJBuQfcCrJzVOxG0Rtg9/eqf5eC+BlQDF9cA1+n4a4ZJmWgc19YZ
 6rIk5j3zoE8DGuK9JU+Lu8RQdl7IVKXICSoCzwOW4ELp8UZ6cU7VK8toHW/6PHffVIleJbcmzN+/jz
 ItXvoREyJhqwAPHQlRFeHa/1NvQ4822cGAgvaqX1/4X5kQuMJKTIYkRA3hjrMn5tq5IhSpN4FhLeDq
 DPQhtiW9N2qKCRv+Dzf+SdwNDoQAlsNMfjfSaOvecOLuRmy+eTUsoPUblxv3RVZ+/OJIDmHyYKY9sz
 zcnu5vfMfRIrIpIbwNMv9z7kCx4xiiHwiHw7WzyIJ5s6el0R450ZI0OZgcdegGyoni4Vyc9sFWo5T6
 EwknbB+ZKW4ke65yHG+RplqcIoJrEBJdVz2c3oFWoEgYI2UWCQhXzcou/37LoEBoZOK4aZEmMUdwAM
 QcBPQnNCtaLmCUfF5iSrs7+uviipHlueR89ePpOudaKXVLKmycx/j8ZGpPrQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 02 May 2025 06:51:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2666

This bit is necessary to receive packets from the internal PHY.
Without this bit set, no activity occurs on the interface.

Normally u-boot sets this bit, but if u-boot is compiled without
net support, the interface will be up but without any activity.

The vendor SDK sets this bit along with the PHY_ID bits.

Ported from the Linux change at [1] from Da Xu merged in
commit [2].

[1] https://lore.kernel.org/all/20250425192009.1439508-1-da@libre.computer/
[2] b23285e93bef ("net: mdio: mux-meson-gxl: set reversed bit when using internal phy")

Suggested-by: Da Xue <da@libre.computer>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/net/mdio_mux_meson_gxl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio_mux_meson_gxl.c b/drivers/net/mdio_mux_meson_gxl.c
index 8ef3ae598b77fabf7b992900141d309708428b13..31898ed437e4857dd7027d311ab496be3e448d16 100644
--- a/drivers/net/mdio_mux_meson_gxl.c
+++ b/drivers/net/mdio_mux_meson_gxl.c
@@ -19,6 +19,7 @@
 #define  REG2_LEDACT		GENMASK(23, 22)
 #define  REG2_LEDLINK		GENMASK(25, 24)
 #define  REG2_DIV4SEL		BIT(27)
+#define  REG2_REVERSED		BIT(28)
 #define  REG2_ADCBYPASS		BIT(30)
 #define  REG2_CLKINSEL		BIT(31)
 #define ETH_REG3		0x4
@@ -66,7 +67,7 @@ static int meson_gxl_enable_internal_mdio(struct mdio_mux_meson_gxl_priv *priv)
 	 * The only constraint is that it must match the one in
 	 * drivers/net/phy/meson-gxl.c to properly match the PHY.
 	 */
-	writel(FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
+	writel(REG2_REVERSED | FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
 	       priv->regs + ETH_REG2);
 
 	/* Enable the internal phy */

---
base-commit: 98a898e58499c78245e4fe36ee404b1b1208e32b
change-id: 20250502-u-boot-topic-mdio-mux-gxl-bit28-a6d03bf8e383

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


