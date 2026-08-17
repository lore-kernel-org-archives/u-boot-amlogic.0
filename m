Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063DBC61DB6
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:25 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35360.1786986196821253392
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 10:03:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=WYltG7y3;
 spf=pass (domain: brivo.com, ip: 209.85.219.51, mailfrom: sanderson@brivo.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90a6b298889so29355666d6.3
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786986196; x=1787590996; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gv9AMPQihGRdITLoUHsBCtm8aBk4F/JBgXJrs0GQkGk=;
        b=WYltG7y3MEYOdntKQFFYOS4ZV9IMxmMiQrg9Vrib8pPYeiAlKyEOIU/EBh7oxV2LoG
         vZ7z1F3lfjbhxPh1e4nUlUirrKxxfOfwt4yuc3FDh8ZW6CZsJMdZLtjMypkcWZ49rWCI
         ZTvlssIzG0xKkJhTrqfsiZp3kjhjJv/3i238S3bXMAgkzpNt+YQdElL7F4ul8QwVdGl4
         3KVD8RsLHWy9myCVknkFK6Oyjjx/Sx4/lZSTd6yyn3qemPbRQNpxKXJM7x0FvL5M5gNP
         mRTrEJ+blZZxcSD6onWJY+xuej6DBnkhIoPVtqtE6dp4gC+rLn2nBQJg+KUIdp7/lxVO
         sKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986196; x=1787590996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gv9AMPQihGRdITLoUHsBCtm8aBk4F/JBgXJrs0GQkGk=;
        b=dTHvgsgFjEtQDZ1xiwu5UHY5hKN+4M9t2TKHOt7Q1w94t6Iif92m09LbfAVZ1DMKCe
         nvWtzBjHIoIjAOALZsL5ECMFv3PugvKmBs0MWUFfanQv7+phvFhuniLUtCZPHX3F06UU
         go0juTD2QpMTlELss50BSAEzGJppSoLGM+gADouNN/TJvCjFtN265l3kzmmw3olTYvVy
         q+xYqzBf3aW/yjvFNZtI3VZYLl1+gxawBT98nWGhcOV/WSADsUdEdbGPHLp+PpL3Lj0W
         7nO997DPp8dlojXpCTN9m//i6IQ/LPC3P1nz2+prr06dcs7HjWhmdmQGerWCfHq9rMKe
         PKFA==
X-Forwarded-Encrypted: i=1; AHgh+RrDyFFuiekhs2djaIaZoNPO4v6IuYCK/QIjfeYsU0RjeSVl1GgMoJZeqE/6aGfe3iX9e28hOJ2njU3I7wR5tg==@groups.io
X-Gm-Message-State: AOJu0YyCv2zrZQQ9LflnIT5b8sMLVdJums6BWRowEjZQJal9BRLuhx+2
	Q4vstL7UHQVg4NA22tvE2rVZtQKde1rkLZIUHCDqiTKIOF1BR6waH1MFl66BNgRLOoNPkTifFsq
	FsW6sj0SyiV69dP+sLGMbhxincCgMgiqjmEE8zLEoyPOZMadpfNud/w==
X-Gm-Gg: AR+sD11wLSb8SkZ0/S5p3gzMWGXDSM1KnpmRnsw3BNLIRg3IfiFgNgRhP39ahtRNEJg
	tfL9Tm/aiEoMBpr0D7cW5Jp4hJho9dIQ//StI4h0k8N2xQEQL/0RclbIw6trytcKikXo/bppXPF
	Nj7jaK3D8SyGtHZLFMEQuoeQwG7mFqvd3eBVetay0lt9gkIJXpBNzWQpOp2BilLJo9YEwsQDRn2
	CrmUlCom9Uou02AHVq0LAhH3zwJB+RsSEEBH/h17Yqp/IhP6R02DeT+vkCMbsi0htyFwNtIl47H
	zIJ7vcqzNzgpfIwqcMCZz2ger3s0FJRyqqnrfDXzsEs7CFdokeoRkY7nByecPeWS+f4ibsCFZET
	7P5BLhGiznHGi6YiioP2KHzWDLxgFz1kJ1ynEQKZhiTmfbbpvCtdztjcDXdlbQQPNtUkZ6MULt8
	UvnfzgKMsETI9RMg7xVRzWuDS3CIQIujohfY/qmWC4+J0pn3ch5XRbhl2+IPXMAN0jMwSKy8Huz
	7CgZN0H15EVCDwdoMkOfVHjGUk=
X-Received: by 2002:a05:6214:1d2b:b0:8ef:ea2a:2728 with SMTP id 6a1803df08f44-90a91de3181mr304960456d6.19.1786986195663;
        Mon, 17 Aug 2026 10:03:15 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c45857fadsm12931096d6.18.2026.08.17.10.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:03:15 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io,
	Sean Anderson <sanderson@brivo.com>
Subject: [PATCH 1/2] pinctrl: meson: a1: Use gpio regs for ds
Date: Mon, 17 Aug 2026 13:02:32 -0400
Message-ID: <20260817170313.1940219-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3030

On newer SoCs, the drivestrength registers are included with the rest of
the GPIO registers. Linux has a rather complex system that uses a helper
function to fix up the registers for each SoC before registering the
pinctrl. Instead of that, just fix things up in probe.

This silences warnings like

meson-s4-pinctrl pinctrl@4000: drive-strength-microamp not supported

which I encountered on s4 and which I assume affects a1 as well.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/pinctrl/meson/pinctrl-meson-a1.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-a1.c b/drivers/pinctrl/meson/pinctrl-meson-a1.c
index 7e9ac6390b1..e9a7522ce50 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-a1.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-a1.c
@@ -856,11 +856,21 @@ static const struct udevice_id meson_a1_pinctrl_match[] = {
 	{ },
 };
 
+static int meson_a1_pinctrl_probe(struct udevice *dev)
+{
+	struct meson_pinctrl *priv = dev_get_priv(dev);
+	int ret = meson_pinctrl_probe(dev);
+
+	if (!ret)
+		priv->reg_ds = priv->reg_gpio;
+	return ret;
+}
+
 U_BOOT_DRIVER(meson_a1_pinctrl) = {
 	.name	= "meson-a1-pinctrl",
 	.id	= UCLASS_PINCTRL,
 	.of_match = of_match_ptr(meson_a1_pinctrl_match),
-	.probe = meson_pinctrl_probe,
+	.probe = meson_a1_pinctrl_probe,
 	.priv_auto = sizeof(struct meson_pinctrl),
 	.ops = &meson_axg_pinctrl_ops,
 };
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: s4_pinctrl

-- 
2.53.0


