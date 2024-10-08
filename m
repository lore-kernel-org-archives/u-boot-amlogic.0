Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAB9CEF16C
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 12:58:21 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.8509.1728392300230277663
 for <u-boot-amlogic@groups.io>;
 Tue, 08 Oct 2024 05:58:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=L0rlkYrP;
 spf=pass (domain: linaro.org, ip: 209.85.128.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42e5e758093so49326015e9.1
        for <u-boot-amlogic@groups.io>; Tue, 08 Oct 2024 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728392298; x=1728997098; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gcWlVXet1XNhlBgukl4wg1CgmrOvAOhAbQW4Tt42w3Q=;
        b=L0rlkYrPfFh7XMISgR8stpVTODEtlKmjNocXpqAL8PYHPSZ4LgvK7eTHHzu4SrfI4f
         pGVEdFr3GPCjwJG/dFShNIEY2c4tBFYLCOlFqicI+cOoEHoalrM/Hu9h7PyznAIcFh2H
         pCEV4tucY3zqIKHPTtS+eUpDLWr+Joh9NRiWpnWp5//+ZGcNhFYwTLzcAqCPldRwGVRn
         PXW71qbSNoP/5bTXMXnmQrezPccCHx5ccVEAiBIFs0HB494exzsevS3rVte9xBsvE/Q3
         zpvpH6U3AxhU/VCGtz+nLuV7MBFzcrUW1/gUQuLYdKepgoe48p+l32LyFb4UVUyTywFg
         a/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728392298; x=1728997098;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcWlVXet1XNhlBgukl4wg1CgmrOvAOhAbQW4Tt42w3Q=;
        b=Gc9YNo3OqnC0D87Lv1w/kp7wO8V5Bi591+UHzqKWmIFW4+ZIDBbZ7l7I2x+dOf+r2e
         zD9xbk+wSV0M6wQaD/L+kDabt8HmS8rFche2HxFVyw/xz1OOPdq46qrwd91AYE0Ec0u4
         NLhqT+wl1UEsyJ5Uw5Zkw0if7A/fvSc+7AAz9NHaOjE7EDpum+uKeVlPPXJ9dWVbYaa4
         VdpbMyE8wB9bDgywMxfkyBNUmv1F0keBtPaXXKjv+VEoz+Ac7TBujVvEorjjUzP09vNh
         YFxxvBaobXMtuXZVsO1LxNAe+lZtVhtQmrB5o2SpMhEa7wtm92RspR41GinpdBE+JZ1R
         +85Q==
X-Gm-Message-State: AOJu0YzKcmo6+eQ9Ds2B2UFGDHudZGd2AbVzNx+kqfPr3GvoUjX+X4+R
	t8vtH8hJoft9BiCHOgZ4ndZb1Czb24Rb9bghFup5+ZpghplghR1/jKNDaxYwpkbozkU7BJNAUn0
	Dyow=
X-Google-Smtp-Source: AGHT+IGLFMCVYA9GJaKhXSMQNoogw+EYsUoTgQJpkxi2CZcMedFrgEwu4/GV2XFZ5jJEA9hmnNvsGA==
X-Received: by 2002:adf:a198:0:b0:37c:d20d:447c with SMTP id ffacd0b85a97d-37d0e779f64mr8866519f8f.29.1728392298571;
        Tue, 08 Oct 2024 05:58:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16972a69sm8062855f8f.97.2024.10.08.05.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:58:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 08 Oct 2024 14:58:16 +0200
Subject: [PATCH] video: meson: dw-hdmi: do not fail probe if HDMI regulator
 is already enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-u-boot-video-fix-hdmi-supply-already-on-v1-1-3a12c73ff3f1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGcsBWcC/x2NzQqDMBAGX0X23A+SIP17ldLDxqx1wSYhqVIR3
 72hx4FhZqcqRaXSvdupyKpVU2xgTx0NE8eXQENjcsb11pgrFviUPlg1SMKoX0zhrahLzvMGnot
 w2JAi5Mw3Ht3FW/HUarlIs/+nx/M4foKyiIl5AAAA
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=987;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wSeYiPwevyPWKoX50LCHlizqsN1l/u61R9C7SSOu2ws=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnBSxpMEWEFlhytL+M6w+nVX8qKuQnlsHycAvWS0jT
 NKqFaouJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwUsaQAKCRB33NvayMhJ0UkgEA
 Cjf5Zr2He5xW0PmEy8enFXBs3J5Op+CYVgLaOeB0eXt/cnXYKvbKDz9S/z4iv+mIznFrHTKjETHCte
 k7+SR1QavtkuH5DMY5dycSsERvlixjXaQLhzMUHQYSMqaBbi7TYVTgmcCVSeVFaC7vY6xcpn4vB7bH
 vv65/fmTnSNmJsV6UGY5RBsCQPHyxzho6/QPlUljzofizrlwA/SzFP9N8OqhmQmPszGW0SomXEo4WW
 DUHmqMBRNFf2XDNGVJ9a68e7A2Zzz0lNzMgRK5Tp+pLVg6qj982l2XDRHeKxYua4yxLZ3M6mJx/HZm
 g/W8CB1bpPePsW8hR8Jx7Phd29VP0d8ugTzvngsvexdBULmpRzsisNPFRsX0N0509zY/vMRWLH5iM3
 mVG40XUx3IeLhc9l83kgXP1ryDP5OqKDOxW5wKlcNdcrfwqkHa2oLleAUuHfrkB1HEs2ocVSOdk+u/
 TO4WwULBfl+9N6GFxkjMPHdCDZb2kVE+oV6Bsy/IzugfNtwwff+D9cMn3rrmjtptgYXpKFPaWjjOGn
 pF8e1VxJeMR09l8VDRea6lDDLNPD6pPP6GWJFJKR3/r/BcABvLsEteeSY8M/KzQHWHWvcUr3NBSd28
 jdHecjKzOAhn/niuupUSaONMw7F86IKuvq3LWd34l93lnc21ehIg4nVJkZMg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 08 Oct 2024 12:58:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2430

If the regulator is already enabled, this happens if the regulator
is set in regulator-always-on, regulator_set_enable() return -EALREADY.

Ignore the -EALREADY return since it's not an error.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/video/meson/meson_dw_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
index 587df7beb9b..ee219ce6ec4 100644
--- a/drivers/video/meson/meson_dw_hdmi.c
+++ b/drivers/video/meson/meson_dw_hdmi.c
@@ -419,7 +419,7 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
 
 	if (!ret) {
 		ret = regulator_set_enable(supply, true);
-		if (ret)
+		if (ret && ret != -EALREADY)
 			return ret;
 	}
 #endif

---
base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
change-id: 20241008-u-boot-video-fix-hdmi-supply-already-on-e6a9af27b1eb

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


