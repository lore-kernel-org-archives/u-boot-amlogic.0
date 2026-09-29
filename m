Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F75CA5FA5
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 17:52:55 +0000 (UTC)
Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2524.1790704365310329126
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Sep 2026 10:52:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=f3wPqSb+;
 spf=pass (domain: brivo.com, ip: 74.125.230.234, mailfrom: sanderson@brivo.com)
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-53320068d8eso40361321cf.3
        for <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 10:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790704364; x=1791309164; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ay6si2tSqi0zRUPuyi5zD1k1dWeg1wqA7w8pM/vxUsI=;
        b=f3wPqSb+B54c6sJzGZ/2RvsmArquDxlWtmuhIwdatkar5gofYJTmyEhwz+XgTYOsMB
         i2ecPeW2otKmCDbraI5mrAf4Z4Vc5cn7UEdG03N79om/ji6sDCyY6AdKYZFleiPVfUb/
         0cUJ7/06Wffzfh64H4MybHWz4RVy+tXZXBPhmYQtC/j5U0PYROfMIgRZeVM1WrIUbMaT
         l4iIv7MCzilKP4BiYx+sTq+tTB9DqnDXTeUW6lIlZn+EaCaRWBtbMrQ4DpDOixod7wV0
         BDGZ5Qvgl1RRpWxPipea/jQXKO6ud1LgQn09yzzHBoG7xtmm0SJmhVMEEdE8RrdELLyP
         +vCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790704364; x=1791309164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ay6si2tSqi0zRUPuyi5zD1k1dWeg1wqA7w8pM/vxUsI=;
        b=DhnhZFucrzQghb4En4T0UBpVxXLonmH7qlUgQsTfpf2cSjKYyMqXHl8Sobven2U65v
         RX+wQQFa6Is3JzIFY4QwJrytm8wX74DKGwt40rglNSEyyRTnb/Qp+wFrl9wnMeTmSBYA
         ZiMl2zeOHPycdaAfyHtlG5TC3LCLe+tCkpkslJynI2Kq5pytCo3BERve8pbD2gnO/MW2
         zNdd6uaP5sT5XyEpAgQ2XMRQl5YAUmwY2Ajhm6yQh418wVVdkGPb2gUnkMUIxIydAmp0
         CvrUfoNa4+UJzehph9xwSkBhzY7TV1HmwmzKyqtZ73jTvkEy/N4ojVfuQ4On7KjeMoCI
         zDrQ==
X-Gm-Message-State: AFuF++mI3kAEIlBREEwTvMgqKDJ/x8jjfvriADIp0Ar/ei0aOpI7vTWV
	+3sNi/R3QDPBeA+cajr2ZRMfpqKad1LYfzC0Qc2mtZwS2r4sL3LxPBU1E1EQ+3YbWFKj56uImZr
	BtMsJfO/ac5dnyF5F7930jDO86Kq8Uryt9+d9HV2H2GyH2oxEmkd+Fg==
X-Gm-Gg: AYBFou1DpeKEH4N5nHTWbRtu7m0eoQh7XxOiN9DrjG5OfiK8HZZbO0QketnrOzCkNnb
	xqQyFauCS4JpkU4ZIxCMTEKgO6v9BxyjOjmYoGD916E/V1NdZj45eHRn0EMIwkB3hY+UBTiQBmW
	VjgB7Mwa6nDIdJ45s2KwWy6v0K8QObte4XHT0aSx5gMjezTVq8IabFftRO+tcdxO0a8YHLQhe4d
	RLvA6zjIt4uS7FcVWiPfmZHtwuLYNkt2s4gqbC7lCvyCGGZiVIqZIJR3WsNEyu3Ovt6yUg+Xmvv
	uavjpIGRq1j2bhrplXs5Und+t3BqFkatKMWnpb3cZ3DqGh8kVKs9VypgiS/O783+6Q7RKrbVc+2
	8L0/jnGmULhjHqzrA9LtiT7uDQxb704kdvrcyv4Me6OFCwtuPl5gwLXTyerQKqMTqpsVtF1jR9a
	hBRTEBJA121RhJ4WSSDmCM0Egf7TFcLvSVdPVAb58AVqJAPfm16rv3tfoxVrKqUwey
X-Received: by 2002:a05:622a:30a:b0:531:11cc:ab4 with SMTP id d75a77b69052e-5336a388fe7mr43881cf.23.1790704363834;
        Tue, 29 Sep 2026 10:52:43 -0700 (PDT)
Received: from strozzi ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53369bfd390sm718711cf.26.2026.09.29.10.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:52:43 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Sean Anderson <sanderson@brivo.com>
Subject: [RFC PATCH] pwm: meson: Add s4 support
Date: Tue, 29 Sep 2026 13:52:36 -0400
Message-ID: <20260929175239.3298566-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 17:52:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3101

On s4, the devicetree clocks are the direct inputs to the PWMs, so we
don't need to configure the clocks in the driver. Instead, we just need
to grab one clock from the devicetree for each PWM.

The PWM LED isn't working on my VIM1S, but I don't have time to look
into this further. I'm posting this as RFC if anyone else would like to
pick up where I left off.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/pwm/pwm-meson.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index caa7af085fa..654b138d224 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -273,6 +273,13 @@ static int meson_pwm_probe(struct udevice *dev)
 		struct meson_pwm_channel *channel = &priv->channels[i];
 		struct meson_pwm_channel_data *channel_data = &meson_pwm_per_channel_data[i];
 
+		if (!data->parent_ids) {
+			err = clk_get_by_index(dev, i, &channel->clk);
+			if (err)
+				return err;
+			continue;
+		}
+
 		snprintf(name, sizeof(name), "clkin%u", i);
 
 		err = clk_get_by_name(dev, name, &channel->clk);
@@ -488,6 +495,11 @@ static const struct meson_pwm_data pwm_g12a_ee_data = {
 	.num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_ids),
 };
 
+static const struct meson_pwm_data pwm_s4_data = {
+	.parent_ids = NULL,
+	.num_parents = 0,
+};
+
 static const struct udevice_id meson_pwm_ids[] = {
 	{
 		.compatible = "amlogic,meson-gxbb-pwm",
@@ -517,6 +529,11 @@ static const struct udevice_id meson_pwm_ids[] = {
 		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
 		.data = (ulong)&pwm_g12a_ao_cd_data
 	},
+	{
+		.compatible = "amlogic,meson-s4-pwm",
+		.data = (ulong)&pwm_s4_data
+	},
+	{ },
 };
 
 U_BOOT_DRIVER(meson_pwm) = {
---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
branch: s4_pwm

-- 
2.53.0


