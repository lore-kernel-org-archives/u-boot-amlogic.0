Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322A2D5A6F3
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 08:07:01 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.40855.1732608418325214730
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2024 00:06:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=K16+esom;
 spf=pass (domain: baylibre.com, ip: 209.85.128.49, mailfrom: glaroque@baylibre.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a044dce2so19722155e9.2
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 00:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732608417; x=1733213217; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtbTU7FLjCl8orbIaLhCYTw3PmzNbPP9nFpN4ROC+FU=;
        b=K16+esomlgPvpAMtfRV/krwClCseNw6bynB/sPISmZmfd15ApwtCN7PL2/laV3Fm4k
         C2zw0afDv50j670zYi/tF32LlSyZnfX3OfqiMOwPpMj6vGajn+fwa25/LZVlIW292zVt
         pMuIrdnGzhI/kQtuIh7j7TTucIMP3mxZLkaZYaY90B12Hyxm4hn9FuyCPAi7kM+Z85fd
         8DsS+ULSrkNx2GA8diZasIYFTEd4iSuxcn/CXt/ehhjyLLrpjc00UZwAf5C4EzWE8/NR
         ZrHziZpiN6SsTVOIfNDAouWEDAOSJKn54l6jVq/ednahva0s0LfqVcoqZH39jqtKN6Wb
         6KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608417; x=1733213217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtbTU7FLjCl8orbIaLhCYTw3PmzNbPP9nFpN4ROC+FU=;
        b=jPUnnMzGZ5Lq1NTt0YQKw3vJPohpHz5F1YEr7dEzjcDor2LXENNQK4v7C3VMQtmCKt
         mVeAYjceGvEDrDtV7nkbubh8RddfX1ByAhpY9S5Ad+ip6cjNNrj3cLyn5t6tGr+OVawC
         o9WXDBFow40ZByhQqmnmQubTPnkLruScBqjKLk5PjBD3vTxK6kKDx1qDNikaaHhQhHbT
         cOIitmDIwetMgGAB6RhnMsusTvxZMkU2Dg8UaMGLt/dJHxGkff0yj97iXUVE9ND8ucBs
         NYvcw/JnuYKxMYitg/pGyIO98KGWbVt5eRuqqbTySvxkJJ6eJj2psUPmtq90PW2VtM6u
         KGng==
X-Forwarded-Encrypted: i=1; AJvYcCV4hRjZTZgN/7EqGsd60dulDbgryyI+mzotW3nKAqS9qP2lt4uJ7y8ZhThzHe0Nu6sejFYj+/Zh00OhhDjXrw==@groups.io
X-Gm-Message-State: AOJu0YxhgJHmdboysPky5nfSxxbBLaTgOG32m2VvzOc5trN4rcNVMW7N
	kpEEXvo+1kQg+C8LC/NAB+yqkbjuV0mVVR4g327SFKrShu6NytII8Q81haVmmwE=
X-Gm-Gg: ASbGncve28QoU0NX7VCfL+Hm4XeySVNrvOd5RPwiVLsiBOOkCDylQMJZ5GpW91hIWN5
	UwOAmYilFgb5e4cnhBhbG8xcUnUD7ZXKncxjcneEFDSJJk9iUGG531eCk+3INt5R5pggkL3OzS9
	UaacXkmG9EMOgESR2JQQNqgjjqpJI55jRCTswD5hTY0VvMj/eoiYr8MhS86wnszAWbWBIISoHK3
	NQuGRchsrcpkIt4Y1EQIqAu8s4/+RsfFapkHqrMINA9i4eZaEOCPg==
X-Google-Smtp-Source: AGHT+IGGCUrzf17PZz8FvrrlS6GRm2xpWOjx25ikD5MOBGExUqHCX9jt+Lw2U7MybbLanKN9LUqA7A==
X-Received: by 2002:a5d:64a9:0:b0:382:4fa4:e544 with SMTP id ffacd0b85a97d-38260b3caf5mr15899023f8f.6.1732608416715;
        Tue, 26 Nov 2024 00:06:56 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:86be:4d54:1784:8cf7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb36612sm12513102f8f.59.2024.11.26.00.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 00:06:56 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 26 Nov 2024 09:06:09 +0100
Subject: [PATCH v4 1/5] bootstd: android: add support of bootimage v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-adnroidv2-v4-1-11636106dc69@baylibre.com>
References: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
In-Reply-To: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 08:07:01 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2584

Android bootmeth only support boot image v3/4.

Add support of Android Boot Image version 2 [1].
Vendor boot image is only supported in version 3 and 4 so don't try to
read it when header version is less than 3.

[1] https://source.android.com/docs/core/architecture/bootloader/boot-image-header#header-v2

Tested-by: Julien Masson <jmasson@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 boot/bootmeth_android.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 19b1f2c377b9..2e7f85e4a708 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -259,16 +259,12 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		goto free_priv;
 	}
 
-	if (priv->header_version != 4) {
-		log_debug("only boot.img v4 is supported %u\n", priv->header_version);
-		ret = -EINVAL;
-		goto free_priv;
-	}
-
-	ret = scan_vendor_boot_part(bflow->blk, priv);
-	if (ret < 0) {
-		log_debug("scan vendor_boot failed: err=%d\n", ret);
-		goto free_priv;
+	if (priv->header_version >= 3) {
+		ret = scan_vendor_boot_part(bflow->blk, priv);
+		if (ret < 0) {
+			log_debug("scan vendor_boot failed: err=%d\n", ret);
+			goto free_priv;
+		}
 	}
 
 	/*
@@ -476,12 +472,13 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read boot", ret);
 
-	ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
-	if (ret < 0)
-		return log_msg_ret("read vendor_boot", ret);
-
+	if (priv->header_version >= 3) {
+		ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
+		if (ret < 0)
+			return log_msg_ret("read vendor_boot", ret);
+		set_avendor_bootimg_addr(vloadaddr);
+	}
 	set_abootimg_addr(loadaddr);
-	set_avendor_bootimg_addr(vloadaddr);
 
 	ret = bootm_boot_start(loadaddr, bflow->cmdline);
 

-- 
2.34.1


