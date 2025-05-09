Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E8CC3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:03:42 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.8675.1746774220858180665
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:03:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EPEFb45H;
 spf=pass (domain: gmail.com, ip: 209.85.216.43, mailfrom: linux.amoon@gmail.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so1913311a91.1
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746774220; x=1747379020; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xcvuA7gy3MBpfwHOmy/JJn+/ftmt+pamZfSXgCJk5M=;
        b=EPEFb45HJy/kuHhGIRhwz2VC9dDmCNyoaU2D6VrT23Bw6qm3gI0rL4hpBuNxWlzFSn
         sLZdY6SR1js+q+IrrTrbUEskfKkI8eurqBhNwA18YgjET6rjCgVdWdGCKK5Oi7TwlVNK
         wdd3HAivAmYCfIGzuTYhutjFdgXB8XSEIGUTyed49+weBiileGxZeW3rRxLUGwxPgUXu
         vUM8oAhlEAxAtlZFnNsvOAKLC1669BxNVuC5DlWGTOHcpS/y1Eo1nngfsJqXlbh3uKV0
         baFerVz12G+AWfi2Ysinon7GMTGMT7s3fO5q2ie5RjOakrvroc5bFUOtY/bwwAj7cjBi
         VZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774220; x=1747379020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xcvuA7gy3MBpfwHOmy/JJn+/ftmt+pamZfSXgCJk5M=;
        b=s8i/yehz5LwKZcKOV57kwwJWLDk0GT9yPTatNNDNlYvm9ELTgWadotUMazocw84nKf
         /UAFycuFxEZik2dvUykM84l7etfcFRHq0A5kpFDXfrfwJbPKbuSMFTaFMuLWLBLRWqsh
         mbiO1BCkBGlVbiiodcuBNPz9yVj/iqvFi7bOJhE+RG9DeYCQj5nnRskP8r0LcItGbXWO
         fxEHPQTA5+81MHJLmurViSKq4Mid40R+2KGYQHSlejRQnlEoir+UlB1bkZY35A+KCIVX
         2CZVFNhCkta0zWqUMdAZcjQUZy01xhkNKE39Kt0tiQXdHjImXePDfsVT+aDA9TTLFf5W
         Nglw==
X-Forwarded-Encrypted: i=1; AJvYcCWEH6UO+okcLKyyNZ1GgCXaufULKN2s4gPtosb1j6NQoOqhTv4qj5h+8VNEWqhIjhR63avBd9wf2M5cqPFQZA==@groups.io
X-Gm-Message-State: AOJu0Yy0mRnheMzJaluYXrVq+OJ6aezLrBDYoA0gbTTtjYQrOj+jrQtX
	wcnSU95y0Q+NBsyTN7Iol5A/L6lU7gm/Ma9Jk1SCL4LDtoEQtrX0
X-Gm-Gg: ASbGnctim7cgyTrSGboaYBnzxOgI1a4fmnsSy5ymrs+9/fS/ltvlYERPs/RfqYsftBc
	j/usGxk/Ur+QGyz+RtI9tQ5v1FmXz0fjsM0/1EsdqKUbaiSMmy4XracGxnikWzSij5dc6WE7ibM
	Zkr/EXYZbLmibe6BH5Kus9MB0/IVs7r43SCHF5VsOw13QTJSkoLi4st5clqhE6AgAa2bVKsH371
	OW4BwoRflUtx2a992daETXtdF+XWNYB5yOTU+i+BiR5JlYuWQZXEjBZe60AXdyyTbNeit6ZfLUs
	3dVootvT6EK3kFOtQ9n5khga/NdYUbb7VmrdT0y4jNmiSGPTu/oB
X-Google-Smtp-Source: AGHT+IHE7PN4f/X10crVsA/8xZG43L0XBejwETPHL7ljm1iyZmzwQ9aaPvNaWHAzXe+bLq8kvW20ug==
X-Received: by 2002:a17:90b:1344:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-30c3d62e499mr3784106a91.27.1746774220178;
        Fri, 09 May 2025 00:03:40 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 00:03:39 -0700 (PDT)
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
Subject: [RFC v1 3/7] usb: onboard-hub: Add support for Genesys GL853G
Date: Fri,  9 May 2025 12:32:08 +0530
Message-ID: <20250509070258.5077-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509070258.5077-1-linux.amoon@gmail.com>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:03:42 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2678

Enable support for the Genesys GL853G USB2.0 and USB3.1 Hub on
the Odroid N2 and N2-plus. The GL853G driver activates the hub
reset signal, which toggles the GPIO.

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
 partition     0  [ + ]   blk_partition         |               |       |   `-- usb_mass_storage.lun0:1
 bootdev       3  [   ]   usb_bootdev           |               |       `-- usb_mass_storage.lun0.bootdev
 usb_hub       2  [ + ]   usb_hub               |               `-- usb_hub
 clk           2  [ + ]   fixed_clock           |-- xtal-clk
---
 common/usb_onboard_hub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 39bbc1aefa2..3914e2f773d 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -231,6 +231,10 @@ static const struct onboard_hub_data genesys_gl852g_data = {
 	.reset_us = 50,
 };
 
+static const struct onboard_hub_data genesys_gl853g_data = {
+	.reset_us = 50,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
@@ -244,6 +248,9 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	}, {
 		.compatible = "usb5e3,610",     /* GL852G USB 2.0 */
 		.data = (ulong)&genesys_gl852g_data,
+	}, {
+		.compatible = "usb5e3,620",     /* GL852G USB 3.1 */
+		.data = (ulong)&genesys_gl853g_data,
 	}
 };
 
-- 
2.49.0


