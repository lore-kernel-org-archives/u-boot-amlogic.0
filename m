Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F57CC61DC7
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:29 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16697.1787578438816395934
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 06:33:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=NYoqv6WG;
 spf=pass (domain: brivo.com, ip: 209.85.222.174, mailfrom: sanderson@brivo.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e55b62640so159956885a.0
        for <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1787578438; x=1788183238; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=exU8SroTTt24qtdfJ9gJ3PqNbDyZv14pQvuuMu2rmjw=;
        b=NYoqv6WGhJ5MLmglkzrjt0Zk0gzhddK6uIRNykSexejmPdKpZIIm59HHFZGXlos28K
         MJwwW3VDvcmlfWsTLaY9F0TMlJFSzXbYU79RDJJNnlh62FkpTFFIFFGkrsr6BADhzjow
         4JPh3Bm6EsOkzI4ECbTkcUEHPcN5P+TYa9iSV68A9cz5lUoEiBss4/+cjkhxwNOCq/V4
         CTAFzH7/TTouTy+WeRBjUU5ZeKaogQRnMBHf01Mh6J2jf+3W4a/hbTkZvm+YFDScXAtG
         8Flie7LK1xtBk4Dx470hPOfGVrHTK4xp9xAF8ha69j16K2OyThNc1tIcLA8i2J2DyqLk
         SyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787578438; x=1788183238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=exU8SroTTt24qtdfJ9gJ3PqNbDyZv14pQvuuMu2rmjw=;
        b=E5sUBC1nXopUIZgCvV0w/AaPBXpXZD34ffwUVfazoNOJJ+a70A66cemLVmfAwWhTtW
         tHeFnPv48ZRncXYdRcRvk/u8NxM/uTlqpkDJmEhMie/LUcxooCf3l1Rwmoql7cHzuUAP
         nV9YaSoL2Xm7yOVRxwXhz/Qr+xqaC9D6kmh+BegTShVvIx3xJcPSM1R2nATmcZ5bixeg
         8dXSenr3z14+s5Q1TpZ1/hUmvzsvIpeYdJ1Imtu8LrCz2G8j2sEmRkZVAmnLuSDlGSdW
         OOGZ8SvTUN5ly6hSeU1wBdmzK6o1yrQ2IIMDiQtEXldktwvE6fOLvQnUFsOoRR5HH5bX
         WZaw==
X-Gm-Message-State: AFuF++keezq9l7cCe/09r3eqdOcxs0XuoDrXKdb4RVP8FEc2KrB4dc5r
	kgsNFvHmvaavWlH1TtslWN6rbE5JawbMbhbOKF8PWYOgeEFXWE4SYsVcfy5JMiFWUEa8A3sjxkt
	GWVeYxkqT/JOUql3Yi6al4RJ+CjzxXHgAF0sjk5UT7fN6ajFvSWoOZw==
X-Gm-Gg: AR+sD10zBsdmJ3wCrhb305xM0pF3NFNnY3/2Txz65X9H9i/xOU0zLR9Tcf9Pnnq23pH
	or+BH125jBCqAoyapNX0aRfmBE9OEzSSmNuowtNnG8crwaCf+l3jHZNcaW9RYxtjTqem8LsUZWO
	KkWSNEHbosCy9RnsiWO2w4FfjcKzu/VTuQpAxduaoPjN0lj3aZJdCnjr5K63wb7e1UfrQfXfyda
	ih5x8YxJb5vY/8QNzxuyg5pNbUWjrSMDkT4CnC1ykTzAgxj18rBxaMi8tmr1nwegg5Lu6LMe//E
	zGEVU9CFr+HejTj4FQ4zMlFHcWdGQvS0omzNRqeVnUNJ4qmjN4sg4KcKAuyqQwaOtfclgxVvG70
	47rG5c7TXKSjQksUInFhYeQIPFThk0EgYZxbjvkj6lBai8NbirRvk1/z9fXZeR2tuhRAXt+JAkn
	1PF8pHrZFckZRG8W+KwjeRAblklqMDBieRSPn9mumNNLKRAg+PQ9LT
X-Received: by 2002:a05:620a:3729:b0:934:ab73:ac53 with SMTP id af79cd13be357-937466c84bbmr1751741285a.0.1787578437557;
        Mon, 24 Aug 2026 06:33:57 -0700 (PDT)
Received: from strozzi ([66.193.28.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749eb4240sm500319685a.47.2026.08.24.06.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:33:57 -0700 (PDT)
From: "Sean Anderson" <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>
Subject: [PATCH v2 1/2] pinctrl: meson: a1: Use gpio regs for ds
Date: Mon, 24 Aug 2026 09:33:49 -0400
Message-ID: <20260824133355.524575-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Aug 2026 13:42:29 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3065

On newer SoCs, the drivestrength registers are included with the rest of
the GPIO registers. Linux has a rather complex system that uses a helper
function to fix up the registers for each SoC before registering the
pinctrl. Instead of that, just fix things up in probe.

This silences warnings like

meson-s4-pinctrl pinctrl@4000: drive-strength-microamp not supported

which I encountered on s4 and which I assume affects a1 as well.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

Changes in v2:
- Add comment to probe on why we're overriding reg_ds

 drivers/pinctrl/meson/pinctrl-meson-a1.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-a1.c b/drivers/pinctrl/meson/pinctrl-meson-a1.c
index 7e9ac6390b1..f736e9017c0 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-a1.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-a1.c
@@ -856,11 +856,22 @@ static const struct udevice_id meson_a1_pinctrl_match[] = {
 	{ },
 };
 
+static int meson_a1_pinctrl_probe(struct udevice *dev)
+{
+	struct meson_pinctrl *priv = dev_get_priv(dev);
+	int ret = meson_pinctrl_probe(dev);
+
+	/* Drive-strength registers are combined with GPIO registers */
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


