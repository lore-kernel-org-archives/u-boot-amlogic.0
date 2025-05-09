Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26391C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:04:02 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.8667.1746774238358056142
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:03:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=c53QGdOU;
 spf=pass (domain: gmail.com, ip: 209.85.216.52, mailfrom: linux.amoon@gmail.com)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3081f72c271so1852793a91.0
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746774238; x=1747379038; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyHznH1A+DORyNVPvNXo5ityR0UWlQJHROY2XWQgK+g=;
        b=c53QGdOUlg9qcFAe+XC64yF/wcKrgjBpChIgr/LRfBzJksXqXdsZIz3IFa9o8MarFF
         YI/TUG/QVuaoWD7SNZo46i9yD0B4ev1x1+SMua5NoHpVeEwajoBCwWSATAK6HmF3WzSO
         87Q7DvC2kzv7OuNRYA4mqlDHsiMukEJLZbuHwAY2MKy1iIL/jyxG9nQZict7te7x8gRV
         gqpGdQzeFYnj0/HQulLSt4Re6JNzVOuugtvVtiluuCBxBUu3eZfyx+UmDQYlvuy1jZtO
         4K96xj9XZ2goEm66hJNRujlbHpU0n2rCoW9aDXwn1iAR4VBLjUNNstEhJjYgGm/rbROt
         Lvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774238; x=1747379038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyHznH1A+DORyNVPvNXo5ityR0UWlQJHROY2XWQgK+g=;
        b=gdDNefCu2G+rFEBbmGlAf4znRiRHOPEd/sMxhvsCKLjSWogv/YVQeKUlKcDH7w4gLb
         jlAA4jccp1ZKMPO/xJ2uZjjlj5AdoHK6ldEBrZsX1N+jjOvTJQGFLy3V0OwoeN/9DsmX
         iRpogkQIU4tCrlsVy/g1sOha1vCgGUShPOpFuG31CRazLGUyx9OIrG/YZslyQDsUCJGX
         V3VgYtQDOwtfMvqhRqhhW80Y2m+bLfFhwuAggSq45oavu4Ow3JZfac8M5iRpKCrx1gvN
         3jkBNy7yv4BY84y7L2LKnwHIzMA7ZtuK6MA9yGBtiy5ho06se+SHDT+vkwigOQS56mgX
         XPtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/yq8zS7FDYNLjbCisVpg8QOdRtnLkiccO7UxODPR2JPcATYr4tA7tOhs8YTGRCy7yg6xfKVwSCjAI8kQL6Q==@groups.io
X-Gm-Message-State: AOJu0YzO1sG8Gkx6m2cvaUAc+1QnNnYSq/7TKSUDjzleLihH6IFtBBDa
	Eq6nvlwUnAwop5pZ9+dS4uFJEBRtLFdZ4IXwIYm68dxEhGD4FsYP
X-Gm-Gg: ASbGnctrubZehRzrq14wzA/ixZ2GD5IVuMmiGk0ezUkLCDPbxZv1sfAR89QE59jAn1H
	qMVCgCgsl8GtdL7r4P82H2dnlEgddz8bHziYTYCIG/I2E5HN+H0qZcpJeugXi65bWvtJnfw79Q5
	mmFpVTrcYzvUCQX9HNxVlBoi524wf2KUz4pFhMJnJogeHFhQrqclkevZnkH96C3/6JxXAQyQocX
	fi2Lgwoyl1OkzWB+lcd7PzjdYkInslMYhb10mA7qBGHJju/v3kKzwYFOh9FGUAveAtZB/stQQR4
	vG7X4cvP/07Fl/PSqt8Sum3lEPWJ00cjjvozC93UkPCIXN0TcqjP
X-Google-Smtp-Source: AGHT+IFXuLGS7f5abZ5FN2zh5pnIBkj7DhZipu7roc0bMfqsjt12sa2AEPAOF3N2sGmXV7Khy17xmg==
X-Received: by 2002:a17:90a:c108:b0:30c:5256:3 with SMTP id 98e67ed59e1d1-30c52560188mr297615a91.5.1746774237733;
        Fri, 09 May 2025 00:03:57 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 00:03:57 -0700 (PDT)
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
Subject: [RFC v1 5/7] usb: onboard-hub: Add support for VL817 USB hub
Date: Fri,  9 May 2025 12:32:10 +0530
Message-ID: <20250509070258.5077-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509070258.5077-1-linux.amoon@gmail.com>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:04:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2680

Enable support for the Via labs VL817 USB2.0 and USB3.1 Hub
on the Odroid C4. The Via labs VL817 USB driver activates the
hub reset signal, which toggles the GPIO.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
=> dm tree
 simple_bus   11  [ + ]   dwc3-meson-g12a       |   `-- usb@ffe09000
 usb_gadget    0  [   ]   dwc2-udc-otg          |       |-- usb@ff400000
 usb           0  [ + ]   xhci-dwc3             |       `-- usb@ff500000
 usb_hub       0  [ + ]   usb_hub               |           `-- usb_hub
 usb_hub       1  [ + ]   usb_hub               |               |-- usb_hub
 usb_mass_s    0  [ + ]   usb_mass_storage      |               |   `-- usb_mass_storage
 blk           2  [ + ]   usb_storage_blk       |               |       |-- usb_mass_storage.lun0
 partition     0  [ + ]   blk_partition         |               |       |   |-- usb_mass_storage.lun0:1
 partition     1  [ + ]   blk_partition         |               |       |   |-- usb_mass_storage.lun0:2
 partition     2  [ + ]   blk_partition         |               |       |   |-- usb_mass_storage.lun0:3
 partition     3  [ + ]   blk_partition         |               |       |   `-- usb_mass_storage.lun0:4
 bootdev       3  [   ]   usb_bootdev           |               |       `-- usb_mass_storage.lun0.bootdev
 usb_hub       2  [ + ]   usb_hub               |               `-- usb_hub
---
 common/usb_onboard_hub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 3914e2f773d..1242513c631 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -235,6 +235,10 @@ static const struct onboard_hub_data genesys_gl853g_data = {
 	.reset_us = 50,
 };
 
+static const struct onboard_hub_data vialab_vl817_data = {
+	.reset_us = 10,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
@@ -251,6 +255,12 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	}, {
 		.compatible = "usb5e3,620",     /* GL852G USB 3.1 */
 		.data = (ulong)&genesys_gl853g_data,
+	}, {
+		.compatible = "usb2109,817",	/* Via labs VL817 2.0 */
+		.data = (ulong)&vialab_vl817_data,
+	}, {
+		.compatible = "usb2109,2817",	/* Via labs VL817 3.1 */
+		.data = (ulong)&vialab_vl817_data,
 	}
 };
 
-- 
2.49.0


