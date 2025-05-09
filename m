Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B5BC3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:04:22 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.8670.1746774256042876279
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:04:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=j7xGtii5;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: linux.amoon@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30c3a038acfso1003826a91.3
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746774255; x=1747379055; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VksTAc8MfNtj+Zo80Tsk7dVzZ22M2QTVt0cXDy/zQAg=;
        b=j7xGtii50jYXnn7W3d2dng0gj7PftZjpAfwW6XLonjm0pzeQHgWT9Tb3fgzd7Snfr9
         sZwV0D0/OkKZmVId5ICqCwYR8g91EriClHzIwG4QT+6CsXOTxsn+ktAozy/QVP/bjLRQ
         QIvRIc1GcaEOae9+fZq7TZEybrdz7ZwOR/Y7R7aiBQsI/9Co56g6XYCGdCuZB98VZtSR
         SzeqLtFkDTT9z40NCVjLrRPCwEVkVNljK6vBs13kwdNC4c9Oj8dYLE1wdqGmuXCmPnOB
         rnCOpYvdE1/nJcoOxQ2tHEc9722/y78Gh1uIzd5hJlKEx9IXrn/geboM3jdJp3sftVg8
         u7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774255; x=1747379055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VksTAc8MfNtj+Zo80Tsk7dVzZ22M2QTVt0cXDy/zQAg=;
        b=ly2dUSc5rzwn75OJCZJOCXAraqfTAG1dLzJB030hXQlBDDlNCwJiB/Uwmwb+pX7JqJ
         2XYgOFpcbIMy9la6aTIqUMpQM2N+6SpV5TpxkP72pJaZ9UqjikfgxpOjPY39gtfbl9X3
         bdvW034nWUBuaUqk+wdcOf/hOAovlKGNGUAcrB+1Ju7dmYMua0qCff9/zRTVqzlrzIrW
         wiSg5fwuHKC5KJcRqZmnkUIlZpn1zEArNjksoIx4MlTtJUZbd1a6G/QLwJm+IwO9UvWP
         cuRjD8H1Gq1cs5BwFCAeMSrg0fHrUZxOgRWfc4jYd55Iq5h+DHx/W2aRlrwQx+xwSSai
         usxw==
X-Forwarded-Encrypted: i=1; AJvYcCXvFeESvrP+61bZp8Z+ugFFdjgp5n738RAe0C/8pElT1+vfJQOv7fNZArI5xI7eLALZ/cPMBwxSTMfVMq3fOQ==@groups.io
X-Gm-Message-State: AOJu0YzVQwTfAsiqCT2n09EB8XZHri0uwaK/I0VpEffCeG8BlJuovseC
	ZSYMAnjYDvVSeT2rMnBevkTrxcKYP5UrjFzfzDfcbpTVRDRfK7e9
X-Gm-Gg: ASbGncu1UvRzZeD2JmUQnuYSyKApxR5O+DfiR6kX0UIgwcdEGHv9P3RSVDGXzKRbR8y
	HVJ0EPrvRIByIfFNIlmphcxnlNfHdWabzftDa+80EvH53W+IKN5W2jRyrLEE3OrQmJ/xxmH7nZs
	pGTG5esH1bzhAUhF27pKVLjQV2qiwymywa/G1BWAvigqJDI+rbBRpjSpk/6abVJFmpMWi3RZQAD
	7d67hKbDipOHVBP/6DZzKjVBYnymMqwkOt1yd1GWiU5DoFihSOeKb6on9kjvtDhn+yRU3VGCTgZ
	KyXgQj0FPWoYtMb1JIHsklo6nFXQjr2X6AV88IV3iXcDWPe1v3W2lxwBFmF+iMY=
X-Google-Smtp-Source: AGHT+IGYOoQXT9TsOq5YEK1vhXpUdE1ezLVSnzq5QPWWManGeJD5veYDMeg1Sgf8GpZHVc8FJmr5rg==
X-Received: by 2002:a17:90b:2701:b0:2ff:6f8a:3a13 with SMTP id 98e67ed59e1d1-30c3d6290d6mr3853219a91.25.1746774255375;
        Fri, 09 May 2025 00:04:15 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 00:04:14 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
	Marek Vasut <marex@denx.de>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Michal Simek <michal.simek@amd.com>,
	u-boot@lists.denx.de (open list),
	u-boot-amlogic@groups.io (open list:P200)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Wayne Schroeder <raz@chewies.net>
Subject: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for I2C initialization
Date: Fri,  9 May 2025 12:32:12 +0530
Message-ID: <20250509070258.5077-8-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509070258.5077-1-linux.amoon@gmail.com>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:04:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2682

Add conditional compilation for the usb5744_i2c_init() function based
on the CONFIG_DM_I2C configuration, to avoid compilation failure.

  CC      net/net-common.o
  AR      net/built-in.o
  LDS     u-boot.lds
  LD      u-boot
aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function `usb5744_i2c_init':
/home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined reference to `i2c_get_chip'
aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0): undefined reference to `dm_i2c_write'
aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8): undefined reference to `dm_i2c_write'
aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0): undefined reference to `dm_i2c_write'
Segmentation fault (core dumped)
make: *** [Makefile:1824: u-boot] Error 139
make: *** Deleting file 'u-boot'

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 common/usb_onboard_hub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 1242513c631..92e3f3a92c9 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -30,6 +30,7 @@ struct onboard_hub_data {
 	int (*init)(struct udevice *dev);
 };
 
+#if CONFIG_IS_ENABLED(DM_I2C)
 static int usb5744_i2c_init(struct udevice *dev)
 {
 	/*
@@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
 
 	return 0;
 }
+#endif
 
 int usb_onboard_hub_reset(struct udevice *dev)
 {
@@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
 };
 
 static const struct onboard_hub_data usb5744_data = {
+#if CONFIG_IS_ENABLED(DM_I2C)
 	.init = usb5744_i2c_init,
+#endif
 	.power_on_delay_us = 1000,
 	.reset_us = 5,
 };
-- 
2.49.0


