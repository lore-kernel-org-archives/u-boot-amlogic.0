Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0DBC001E0
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 12:41:51 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web11.119789.1698064909291158454
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Oct 2023 05:41:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=uNvCdHtI;
 spf=pass (domain: linaro.org, ip: 209.85.208.177, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso48576671fa.2
        for <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698064907; x=1698669707; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfS0T2H76Qdru7gYN5qzW3GDdD6skpw7X5W3gkKjwGg=;
        b=uNvCdHtITlicpodtCTD+3DXZL+7CnTbegPWzanbnV27VHwRcltOSmBPFXjHzcA1zU1
         TfPOPg9H6icWArfQvbxGfFbnxC4pNiG3h8+3/FUEzwCYS1SJ+AEwF/FFX3cuBwyVsOKq
         etkIv/6ADksIxLZR5UE51hJEPCHPMf/p+NHNjIHBPCaovpbY7fyml6ZMs3XpilmTjhcV
         ppZ6OOSiROtBkoDed69yCcVDa/7dUGuHh1J0n9Lp6RYZGyCdKi59wfddRqs1wAV4dyKS
         sAQ/Hv9W1brtnhGdSqiBlt1Nn809OJSfXdlKcBYT/hK0UQpB6SkONkjdBFr+M4klxwAr
         6ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064907; x=1698669707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfS0T2H76Qdru7gYN5qzW3GDdD6skpw7X5W3gkKjwGg=;
        b=pIu6JHpPiPxRhnSiNi9Ll2xvN9rMgcDwPWfkBu54zbgqNsItYj5IJTr1hcH901xKMS
         Dh6n5vNfrR4deu3gRjl2Bbu5Cx4UCr75KNLckUvC+SFMSqrju7ZsGDMxxbFfi2UmfS6K
         oOguK7qStOh+RKgok/Gw8Lun/5Szjlte3nr+YdMCM8s6OV/DygQjbzsDY4IxhXqKeI3P
         pH7HhEQ8+XSj32Icn4wqTqOM4RxaZ5SNW+HaMGph8Ruf+OqdLy6KX+v3gs5eCC1AiGHx
         ZRF+vM4dfmAwggaRicj3ydi2HKHkO8Ftl6b9iYdqUOmNDrGPfsZfaVFnFfrB3lGVZ8oz
         01+w==
X-Gm-Message-State: AOJu0YzwujqjN5cRoAci/NSrwyINPAVlRYk2Ww8DXzJK+jMTUqVzaV4b
	LwBfOmdDopud/iok7cW2xJYrZg==
X-Google-Smtp-Source: AGHT+IHttdxiQX2SBZoQtfaOmdlIscrmQw5n29ah8C3W2PsriABzQEne616Mxijjc7JB+i3d0+sBKg==
X-Received: by 2002:a2e:a543:0:b0:2bd:d34:f892 with SMTP id e3-20020a2ea543000000b002bd0d34f892mr6590997ljn.3.1698064907388;
        Mon, 23 Oct 2023 05:41:47 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003fbe4cecc3bsm14230609wmo.16.2023.10.23.05.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:41:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 23 Oct 2023 14:41:36 +0200
Subject: [PATCH 3/4] configs: meson64: add alternate USB DFU boot target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-usb-dfu-boot-v1-3-df9d121c67c1@linaro.org>
References: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
In-Reply-To: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
To: Christian Hewitt <christianshewitt@gmail.com>, 
 Vyacheslav Bocharov <adeep@lexina.in>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=tHu01qz5Fe2UUwEyrfr1+NhVK+wMngiROaN1YhSFWjE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlNmoHRHPolEPcfGqUkS7UQlgWg7ESyiqEaSomR
 +LLG24poyKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTZqBwAKCRB33NvayMhJ
 0ezWEADM9ojFF8mWBtni5CIBf40hfMAU+H/mSK77BGw0KjS5UjCxD7o3yTFXR82qdSODIF7jHbN
 re8t2GDWe0Wm2eVyh3uO42SAhadX3kNl4lAuWN1engxwLt7BA5r15bekXQVs8q2MsAyLSkUL6Cy
 mBFspz49B+HO3sYdHi2myiDq+tepj+SYr0o0jG6bEGBVOBB0XCLCh4nB3QqsZnoDkGr7eZOQxqd
 Ywlk3aGnFii/jf8oTFL7+TiTD3qsheualArayGwItRBemypn1kfAPJTvYAPx9iRZuhxsTl6mCqM
 EqogKSLH1qXW7mqj11kfUI2CYT4NT4BoPd43Vpifp1K56zTbEtSMR5PTKUYnyMlWldUnPiSKvQA
 +Ld39eBzHmDYvhVetdbU4jRcF84epLq+IoVXSgxQSlLzgciTI+Abazo9kxDTs+9I4Ca/XvocCA1
 OOd04XApYHtqL9fWZosK1ddLk0xczVgqoOGC7KUyNTQptWYjeE63+MOmY1I0376gBqmGD9HhrUZ
 nchndapHVIMbAevycU6GkKOmFB7FE45Kp8jCBDwbGd2tirLlNPsvREHBg+3uqMCUiBWGooTgj5a
 BA+0MGXl0TydVGSG28pr7rvvn1u1UiQe3STTZ4wtuLTTaK6uu9IBeXE74qW6/xzj5YwWZVzTZoH
 ljpRvKMxOKgGVBA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 12:41:51 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1792

Add boot over DFU RAM as an alternate to running script at
a fixed address like done today.

The main culprit is that it's not possible to do that
on G12A/Sm1 platforms due to changes in the USB boot protocol.

With this, U-Boot will present a DFU device with a ram slot where
the Host could write a fitImage or legacy U-Boot image, then with the
detach command boot will continue trying to boot the uploaded image.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/configs/meson64.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index a64817ec9b..efab9a624d 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -53,6 +53,30 @@
 #define BOOTENV_DEV_NAME_ROMUSB(devtypeu, devtypel, instance)	\
 		"romusb "
 
+/*
+ * Fallback to "USB DFU" boot if script is not at scriptaddr
+ *
+ * DFU will expose the kernel_addr_r memory range as DFU entry,
+ * then with `dfu-util --detach`, booting the uploaded image
+ * will be attempted:
+ * $ dfu-util -a 0 -D fitImage
+ * $ dfu-util -a 0 -e
+ */
+#if CONFIG_IS_ENABLED(USB_GADGET) && CONFIG_IS_ENABLED(DFU_RAM)
+	#define BOOTENV_DEV_USB_DFU(devtypeu, devtypel, instance) \
+		"bootcmd_usbdfu=" \
+			"if test \"${boot_source}\" = \"usb\"; then " \
+				"dfu 0 ram 0 60;" \
+				"bootm ${kernel_addr_r};" \
+			"fi\0"
+
+	#define BOOTENV_DEV_NAME_USB_DFU(devtypeu, devtypel, instance) \
+		"usbdfu "
+#else
+	#define BOOTENV_DEV_USB_DFU(devtypeu, devtypel, instance)
+	#define BOOTENV_DEV_NAME_USB_DFU(devtypeu, devtypel, instance)
+#endif
+
 #ifdef CONFIG_CMD_USB
 #define BOOT_TARGET_DEVICES_USB(func) func(USB, usb, 0)
 #else
@@ -74,6 +98,7 @@
 #ifndef BOOT_TARGET_DEVICES
 #define BOOT_TARGET_DEVICES(func) \
 	func(ROMUSB, romusb, na)  \
+	func(USB_DFU, usbdfu, na)  \
 	func(MMC, mmc, 0) \
 	func(MMC, mmc, 1) \
 	func(MMC, mmc, 2) \
@@ -109,6 +134,7 @@
 	"fdtoverlay_addr_r=" FDTOVERLAY_ADDR_R "\0" \
 	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
 	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
+	"dfu_alt_info=fitimage ram " KERNEL_ADDR_R " 0x4000000 \0" \
 	BOOTENV
 #endif
 

-- 
2.34.1


