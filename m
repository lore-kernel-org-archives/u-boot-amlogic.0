Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.9692.1618996696254212743
 for <u-boot-amlogic@groups.io>;
 Wed, 21 Apr 2021 02:18:16 -0700
Received: by mail-wr1-f52.google.com with SMTP id a4so40577156wrr.2
        for <u-boot-amlogic@groups.io>; Wed, 21 Apr 2021 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hy4dJzhueDt9v2FLPUg4E8fZqMtq/V2s68tHwQAYXEI=;
        b=S1gYMFrWJW3T0yxEOBR7Wd4nUNouiv+U+Ct/7TBjd8MuPB2wE2FfFHy1oEJvNmB27P
         3S1cIpWN8K8kjnlHVNFF6my1JDlXMd/8FRyemvLv8yEJWFTJkuxgToOZHpV34aGL2x7G
         knX2QOOI1eZHGBhwNWgXabH5eeuW9JRVBcr5DRqTcW59DVMZUGMSH0/dcekRE7CAKYya
         N4Pw2MSDglNhJPh+knrp7dJctecuE3vHepdVDnRFYZ+99M2Fhsw3d2d+LubFYv5yAvvd
         Rbg8eI8atSfQ8Nw9zAr+eaLnJXdG0MFwHb3N+Bk8Joke2aYt/oBDZYdpc7/oYoJZIv96
         b2Ig==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/8] net: designware: meson8b: add g12a compatible
Date: Wed, 21 Apr 2021 11:18:03 +0200
Message-Id: <20210421091809.3103002-2-narmstrong@baylibre.com>
In-Reply-To: <20210421091809.3103002-1-narmstrong@baylibre.com>
References: <20210421091809.3103002-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for the Meson G12A dwmac glue compatible needed after Linux 5.12 sync.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/net/dwmac_meson8b.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
index c0b6ef4994..069bf1724d 100644
--- a/drivers/net/dwmac_meson8b.c
+++ b/drivers/net/dwmac_meson8b.c
@@ -133,6 +133,7 @@ static int dwmac_meson8b_probe(struct udevice *dev)
 
 static const struct udevice_id dwmac_meson8b_ids[] = {
 	{ .compatible = "amlogic,meson-gxbb-dwmac", .data = (ulong)dwmac_setup_gx },
+	{ .compatible = "amlogic,meson-g12a-dwmac", .data = (ulong)dwmac_setup_axg },
 	{ .compatible = "amlogic,meson-axg-dwmac", .data = (ulong)dwmac_setup_axg },
 	{ }
 };
-- 
2.25.1

