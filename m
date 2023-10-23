Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F58ACDB474
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 12:41:51 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.119788.1698064908091003982
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Oct 2023 05:41:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=DS1vCbJD;
 spf=pass (domain: linaro.org, ip: 209.85.128.43, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-408002b5b9fso26880415e9.3
        for <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698064906; x=1698669706; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2Gm2qW8CI3twfeJwFyfYbSo2l9H9vkxemh5kc2EPnw=;
        b=DS1vCbJDiTUXM9hTrP4S6vQ+UAzEfwlCrFjfcklT+1BsVn4Uw//iSwxvR7jjrzfKHP
         5nRkZCYEJEDfPNHmmrVhpit9Ep4iz6ZxdhzM2vfz+RcqginhpDY3nICqz/LKTl8QCd13
         h5W2phOnmOqo/Q+bonAUG7xN+5+0atqkOkyyWXNYjWS8fgqHccIoP1Nc+DQ6v6u4+JBD
         xegOjmIFaya7N5BeUSf0IfejWwjtijNTl+h/71vggDsMe2Q3kfKf9/Z2hTBrF9wvn9OI
         BTaE3B4zOsV8mvZDGDDyy5cdyvOtlsWN5d7NaDDCNMv0OpvZm3Zd5WN5WT+RGqPsjYhq
         ql7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064906; x=1698669706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2Gm2qW8CI3twfeJwFyfYbSo2l9H9vkxemh5kc2EPnw=;
        b=O8R4dCxQBNWPa/6OHB6VfsaK3Ia3pgLSzqBPYqsut1NgY0pc2PWBP9/rSUv1bmjQly
         ITFzUFw9/oYuDK+3IqloJLMPNSXEntFHQuSPavJON8p5uI8aEa02o114qzU1CYN5LuXh
         XD/LFPO69vGXa5AeJGPVLgcDzUgI1OYzK84bk22QJLRtzSIdvtmH7F87N62X2I6QS/pT
         GM0bn11/Z9RecRtGmHFhbvsQ4da4fF3sI+KkozJn+hdxhCZ+2WD4XrHbbPtQPQqCJJXz
         8KMY3AKJCQeiYWZAB1gxEMwu443ZsB8Qnt4li2QigxQC8UzlMt4Mnpco90hdC0wrf13F
         c90g==
X-Gm-Message-State: AOJu0YwDgDfPxsxNGXJvaCAAdh++jQLU9uuJE3ZHfFfazMK1yYjogZn0
	gWoZnzciZLx1cKrJxUDBcnUahA==
X-Google-Smtp-Source: AGHT+IFeztAO894SBkhTmawkkOfsliqq+Zp/eXGUfvpWkMR1rRAJtT5wuEgKhl2L9PFBwjma4C0P7A==
X-Received: by 2002:a05:600c:6027:b0:405:3b1f:968b with SMTP id az39-20020a05600c602700b004053b1f968bmr6825481wmb.21.1698064906592;
        Mon, 23 Oct 2023 05:41:46 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003fbe4cecc3bsm14230609wmo.16.2023.10.23.05.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:41:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 23 Oct 2023 14:41:35 +0200
Subject: [PATCH 2/4] configs: meson64: declare addr out of
 EXTRA_ENV_SETTINGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-usb-dfu-boot-v1-2-df9d121c67c1@linaro.org>
References: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
In-Reply-To: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
To: Christian Hewitt <christianshewitt@gmail.com>, 
 Vyacheslav Bocharov <adeep@lexina.in>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1772;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=50KIZnOqvNzyxzkIO5HCZht4MBGtQOUqUQcQnYWKgpw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlNmoHpp7oRpJjFZoQi+Crxg6Cdc3af8kT8WQTv
 /1AZ9SWXWWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTZqBwAKCRB33NvayMhJ
 0TFrEAC/1le8pWwL2IYcWgdgmvOrCVZiskwAFTirGqTAZFaA9f3+IMV57qmITu3XtbJWixIYWWX
 yGYD2xcvlAr9Xtz007Thb6/BPtKknJdPaD4ayTPBGaZmganiTggqc6oyacR0aoRZZEIcBhtgZXB
 v4GWOqNhHmTJKFEnPlKRov+/dh1BpSeD8lfjeaweQRE34G5kbXCDlxt336dnPBTasH/k8fZeE5N
 bTjMTj6EMkQRpuYZ2OvINLawkRyPAMBe3EH8ObZL5ygopwoHaqxyqn0ba+pr6mkhjFS400Brn41
 dhZzMdKMjSJFfJGyhFV/X7DbGfpBU3nBf48Y2qmcUOBi9zxWKsj58LWylAxwu3OHxUsdqL02I07
 azwfZXVmXJ/2RM+WDGDvHqRjBayz6qjpaH3/49E6o9ByJhirkYyWZ2v635R/wWLMKJ+buObPptK
 2+Vs3gtCseOg+0zew7YniuBBSz+rJ7EjLits4aFnT3iD884PGlAVQNS1l2nomvcS7NYMj2euQi9
 ndv5rM8yNzfZYiUI6a39bFj8bcwYk3pinT0KkXrqYZNOYEdy45p0yogUSh4u/n6cMpYmjhbVKWH
 3SzcbVqO89hXN+ABx18byCxAApG36QR2d8UD4Ou0L+Zfr4o5UYjXuRdJs2Ql9WCZSJGyZR2BH47
 REDtbCmJpUBxKAg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 12:41:51 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1791

In order to reuse addresses for DFU RAM, define them separately,
it's cleaner and will be easier to override.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/configs/meson64.h | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index 801cdae470..a64817ec9b 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -84,6 +84,15 @@
 	func(DHCP, dhcp, na)
 #endif
 
+#define BOOTM_SIZE		__stringify(0x1700000)
+#define KERNEL_ADDR_R		__stringify(0x08080000)
+#define KERNEL_COMP_ADDR_R	__stringify(0x0d080000)
+#define FDT_ADDR_R		__stringify(0x08008000)
+#define SCRIPT_ADDR_R		__stringify(0x08000000)
+#define PXEFILE_ADDR_R		__stringify(0x01080000)
+#define FDTOVERLAY_ADDR_R	__stringify(0x01000000)
+#define RAMDISK_ADDR_R		__stringify(0x13000000)
+
 #include <config_distro_bootcmd.h>
 
 #ifndef CFG_EXTRA_ENV_SETTINGS
@@ -91,14 +100,14 @@
 	"stdin=" STDIN_CFG "\0" \
 	"stdout=" STDOUT_CFG "\0" \
 	"stderr=" STDOUT_CFG "\0" \
-	"kernel_comp_addr_r=0x0d080000\0" \
+	"kernel_comp_addr_r=" KERNEL_COMP_ADDR_R "\0" \
 	"kernel_comp_size=0x2000000\0" \
-	"fdt_addr_r=0x08008000\0" \
-	"scriptaddr=0x08000000\0" \
-	"kernel_addr_r=0x08080000\0" \
-	"pxefile_addr_r=0x01080000\0" \
-	"fdtoverlay_addr_r=0x01000000\0" \
-	"ramdisk_addr_r=0x13000000\0" \
+	"fdt_addr_r=" FDT_ADDR_R "\0" \
+	"scriptaddr=" SCRIPT_ADDR_R "\0" \
+	"kernel_addr_r=" KERNEL_ADDR_R "\0" \
+	"pxefile_addr_r=" PXEFILE_ADDR_R "\0" \
+	"fdtoverlay_addr_r=" FDTOVERLAY_ADDR_R "\0" \
+	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
 	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
 	BOOTENV
 #endif

-- 
2.34.1


