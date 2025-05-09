Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A05EC3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:03:32 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.8672.1746774204703295260
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:03:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y0o7d7dp;
 spf=pass (domain: gmail.com, ip: 209.85.216.41, mailfrom: linux.amoon@gmail.com)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30aa3980af5so2248272a91.0
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746774204; x=1747379004; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6WaWaGti2jOFc4xoLrVWLq95qjK+jEHVMYJ0hjSqEc=;
        b=Y0o7d7dpR1jTPdGrAIVZk46JBXH/CG1wOJyTXELF4sjsys8xmNcg50TG4Ym41/481x
         GHMtsS75QkZwChEsKPqU4GPD5a1XGsdsY2QMmxAu42R43FyahcaE5n0Rbmz6WajW0zWF
         DlGiq8mGYVX99lpUFB6jvnWc5Kwwrww5FoQb8LRqLJh+LB8+G1cK63JX06BVT0x+HLDz
         jAyHKml8M2doHKr9z8MCf5hucSekihSPjihRZJ+RH5lwrvAOdDTSNdBg8tDMyN03kone
         egeaV1ix923yCsDpF5PS/xx9q5uTO7lNyGH93+0I7wssfkSBFrBsqY/WlpWqe8aXOHZ/
         9MYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774204; x=1747379004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6WaWaGti2jOFc4xoLrVWLq95qjK+jEHVMYJ0hjSqEc=;
        b=s6X0s5QdMSe5j4gpCpbOS6KAqtyjIhr1DUWeP2rd+zv4vo7Yo/mWEbbjzsUsODZ1Ss
         zWguT4IPQOLHM7qQF5uHFfW0YZEKv81fBWCufNJyeX+2jQEMnQg9PQtnnx3PR8kOduko
         kArPpSzF2TSEY5urFbi1dQ9ORryc1yQ7ue34XLV0GULVWvnCihGBhD0sTyxNuzEam5KX
         mdjtIz6ExaXQyp11Kyt5Bi93gZKUqcq4CLCsNKEuexDpasX1nw68HQjnZrkCrrk7wFks
         OXCB9nHJd1p9pa0C16pLAAJDAkRiMdxt7relWJfpwB4hUgC9mquYPEWULEMpie+RnYiF
         U2cA==
X-Forwarded-Encrypted: i=1; AJvYcCXSGDyaSbGgT37mbODn8HE6jwZqv6T8K8y2f4p2ImkLRe1mZy9oXOpAv7S6DhSBl+7ZbmRNBVXRBDsZ+MYAVA==@groups.io
X-Gm-Message-State: AOJu0YywjLOTxdtWAKVNvqC9q2MrWqVp4bc6/wVkGCe6XXwvwrg7wPc6
	o2amDG8BDtCKG0dLV0sUJXcTofpRhv8fDjjD6gkC804deJrmmTdt
X-Gm-Gg: ASbGncun2DrRacCPWppZ++jC7pVUUB+60n+rq1ZA+sYngCyA7S7j771WogaB88HsGwJ
	1Frlb/0A496yVOh3cgR6FF+6wtOIH/ISN67XeqFtbF9E2GfBT2wVR4wQvFdoSCap4X+ZARQ4YxP
	sPrjuZ3JA3DvNQN5OKxlxEFd/wjEEjcUEKI2LN9gtzevjpPQeLOQ3fsaB8tmsz+HpmvFxPOCgHz
	4w+ipU9Ky+fIvrfvMG05crBQgwGuquRSBQn9BsR00JMwnS1vvWEJG9pxqm/MvSP0w5h6LyNfVDI
	biUtZML0/F1l9Q7DmTsWSLFMdySrTXwTuhDVA4m37IvVQ9PRQ1Sp
X-Google-Smtp-Source: AGHT+IE1CMIaBMP8h05icnfujyvdGIJ2JZTOieI9QsES85yA0Z56G3z01ca2/73qUlAPCDW9dV3/wg==
X-Received: by 2002:a17:90b:1b06:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-30c3b918c9fmr4939686a91.0.1746774202524;
        Fri, 09 May 2025 00:03:22 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 00:03:21 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
	Marek Vasut <marex@denx.de>,
	Michal Simek <michal.simek@amd.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	u-boot@lists.denx.de (open list),
	u-boot-amlogic@groups.io (open list:P200)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Wayne Schroeder <raz@chewies.net>
Subject: [RFC v1 1/7] usb: onboard-hub: Add support for Genesys GL852G hub
Date: Fri,  9 May 2025 12:32:06 +0530
Message-ID: <20250509070258.5077-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509070258.5077-1-linux.amoon@gmail.com>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:03:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2676

Add support for the Genesys GL852G USB2.0 Hub on Odroid C1+
and Odroid C2. The GL852G driver trigger hub reset signal
which toggles the gpio.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Still some issue with USB hub on Odroid C2
=> dm tree

 vidconsole    0  [ + ]   vidconsole0           |   |   `-- vpu@d0100000.vidconsole0
 display       0  [   ]   meson_dw_hdmi         |   |-- hdmi-tx@c883a000
 phy           0  [ + ]   meson_gxbb_usb2_phy   |   |-- phy@c0000020
 usb           0  [ + ]   dwc2_usb              |   `-- usb@c9100000
 usb_hub       0  [ + ]   usb_hub               |       `-- usb_hub
 usb_hub       1  [ + ]   usb_hub               |           `-- usb_hub
 regulator     0  [ + ]   regulator_fixed       |-- regulator-usb-pwrs
---
 common/usb_onboard_hub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 7fe62b043e6..39bbc1aefa2 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -227,6 +227,10 @@ static const struct onboard_hub_data usb5744_data = {
 	.reset_us = 5,
 };
 
+static const struct onboard_hub_data genesys_gl852g_data = {
+	.reset_us = 50,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
@@ -237,6 +241,9 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	}, {
 		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
 		.data = (ulong)&usb5744_data,
+	}, {
+		.compatible = "usb5e3,610",     /* GL852G USB 2.0 */
+		.data = (ulong)&genesys_gl852g_data,
 	}
 };
 
-- 
2.49.0


