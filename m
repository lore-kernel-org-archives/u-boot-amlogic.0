Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282A9C9832A
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 13:42:38 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8356.1790343753633036720
 for <u-boot-amlogic@groups.io>;
 Fri, 25 Sep 2026 06:42:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre.com header.s=google header.b=LVlPFMzR;
 spf=pass (domain: baylibre.com, ip: 74.125.225.140, mailfrom: glaroque@baylibre.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso6757095e9.2
        for <u-boot-amlogic@groups.io>; Fri, 25 Sep 2026 06:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790343752; x=1790948552; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNwV/SB7rHu3dnw/U9aQJw5zejT3kNv1outIXYJHIT4=;
        b=LVlPFMzR3YTqifUZPCZIjFwFCVnOwcdlS5qUAgVeewKbcYb8aFd+ZbE9kR6TPoBs8t
         LZZ8TgngLHnYBUzG8Th4yOyqk4Aec4cwIhrlpVvZiSR5hItP6MB7sOhmmGFW0Fysogh7
         h1+AgDB9A3sYf124IMFeU0cEm5fADxDdJGCxoiGzE7sIu1OV1GDTw20YNJalmlpAgOYk
         TJEI7ctgOPJeAf686YGaZntiU+SHn+VT6R+3BRfBokpi5LbWDStvHrjOS7nluRC9V46g
         6nFBXdk+STclGT1lO17FYGqtugkl+epsLR03h5Qx/G9E7805S+4s/xAqjxYM/4H90iHr
         ZWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343752; x=1790948552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNwV/SB7rHu3dnw/U9aQJw5zejT3kNv1outIXYJHIT4=;
        b=yjEFgHNkXF4i0ZATdKnBmsJeFqVar/ceejqom6gVNeFI/7d6mxMVZIq8pvOxYlltJs
         4qMYrO8HJtW5Q+XS1eFnZ7t3JOT85nAnkM/9ILJZ5Vs+AVzfAcOdwh7MoA1CAxcbKC0E
         +1cVt1rXUWpW13iAexJCSskDcY9O9zLmQzLTDBsY7M4NqHwAyi2i4XVUna2tmJ4HULIv
         jTrTyWiOsbLWnU4HhApApHVdzTlgcUakGhCRDHftkRpJxyNMbEeNqx31Af4U8rY2vSU+
         7SEYobfXD5pYWfRmi3TGVM3lgWD14ax+sw6dxusXn5W5GMcd+27owbFAKTqD1oRPk8qs
         DH4A==
X-Gm-Message-State: AFuF++k6qDI1QAsqp6J20TkYgKQ7giyzWYvsfijz8LJ3MAp/zaBcHNoN
	YcV22ZmlIBqo7PVuWhhvAsd6GolMC/STDZqKH0L73LIHJDc1EZNbPXo/Mfy7nQewMQC7N0vPoWs
	LiWBL1Jo=
X-Gm-Gg: AYBFou03Or3aXJmwgqVHIXLsf+oamohcOABNN8z7CXB42TrZ+yvzMubM6YywjiSdGPm
	hmeSe6FP+fLvvMW5JgH5K22Vs9aXVsrsW7Fnyxu9gJVNkJrbqO024UE5jidmIV1XT4J5LHUfkEo
	WEcKqJl0ozvUnh6liG4jPxnKWTw+RBxjHnju8fYH1lxwGMY1fn5nXsFTHUiHPcnaH1a6XyE/6ax
	PaP4P+4lGPCkstFZfixlunVMkuJ+cwl+Ed6XKO74oT9VV2esL5XcV+G6VuEDZSAn6/TS2dwQx/N
	cpfHglrIBx0qG7CLsR/MTbDQDfZA5AaZEIbn7qAMU/vSiwOD0fTAmuwyMIBoho8IvO/pKDcN4/+
	QPhD8tBjP4CMqWwJuVhRLpz0DYLVX7v47yg/C/3nMqu/h9CQqS870i6x5sQP9vTUQ6XKpQwyMLo
	jyLLnoCEiyTP587VhihNWfRpql9r5AKtpBLn0nq7WFfE7eyZOZoqGf5Zf4Xb4H
X-Received: by 2002:a05:600c:154f:b0:49c:fa21:1c86 with SMTP id 5b1f17b1804b1-49fe7bbaf51mr94871415e9.27.1790343751947;
        Fri, 25 Sep 2026 06:42:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff42b7074sm34738125e9.6.2026.09.25.06.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 06:42:31 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:26 +0200
Subject: [PATCH 3/4] configs: khadas-vim3: update the Android partition
 layout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-update_vim-v1-3-fddf7ba4dc34@baylibre.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
In-Reply-To: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 25 Sep 2026 13:42:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3098

Update the VIM3 and VIM3L GPT layout for the AOSP Android builds.
Add the missing frp, vendor_boot, init_boot, DLKM vbmeta and metadata
partitions. Grow super to 4 GiB, resize userdata and remove rootfs.

Set the vendor_boot and init_boot staging addresses and advertise
metadata as f2fs for fastboot format.

With the non-A/B defconfigs removed, keep only the A/B layout and
drop the unused ROOT_UUID.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 include/configs/khadas-vim3_android.h  | 34 +++++++++++++++-------------------
 include/configs/khadas-vim3l_android.h | 34 +++++++++++++++-------------------
 2 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index 551ab51c881..18632bb95a0 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -10,36 +10,29 @@
 #define __CONFIG_H
 
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
-#define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
-#if defined(CONFIG_CMD_BCB) && defined(CONFIG_ANDROID_AB)
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
 	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
+	"name=frp,size=512K,uuid=${uuid_gpt_frp};" \
 	"name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};" \
 	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
 	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
 	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
+	"name=vbmeta_vendor_dlkm_a,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_a};" \
+	"name=vbmeta_vendor_dlkm_b,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_b};" \
+	"name=vbmeta_system_dlkm_a,size=64K,uuid=${uuid_gpt_vbmeta_system_dlkm_a};" \
+	"name=vbmeta_system_dlkm_b,size=64K,uuid=${uuid_gpt_vbmeta_system_dlkm_b};" \
 	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
 	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
-	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
-	"name=rootfs,size=-,uuid=" ROOT_UUID
-#else
-#define PARTS_DEFAULT \
-	"uuid_disk=${uuid_gpt_disk};" \
-	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
-	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
-	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
-	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
-	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
-	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
-	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
-	"name=rootfs,size=-,uuid=" ROOT_UUID
-#endif
+	"name=vendor_boot_a,size=32M,uuid=${uuid_gpt_vendor_boot_a};" \
+	"name=vendor_boot_b,size=32M,uuid=${uuid_gpt_vendor_boot_b};" \
+	"name=init_boot_a,size=8M,uuid=${uuid_gpt_init_boot_a};" \
+	"name=init_boot_b,size=8M,uuid=${uuid_gpt_init_boot_b};" \
+	"name=super,size=4096M,uuid=${uuid_gpt_super};" \
+	"name=metadata,size=64M,uuid=${uuid_gpt_metadata};" \
+	"name=userdata,size=10240M,uuid=${uuid_gpt_userdata};"
 
 #define CFG_EXTRA_ENV_SETTINGS                                    \
 	"board=vim3\0"                                               \
@@ -61,6 +54,9 @@
 	"kernel_addr_r=0x01080000\0"                                  \
 	"pxefile_addr_r=0x01080000\0"                                 \
 	"ramdisk_addr_r=0x13000000\0"                                 \
+	"vendor_boot_comp_addr_r=0x39000000\0"                        \
+	"init_boot_comp_addr_r=0x41000000\0"                          \
+	"fastboot.partition-type:metadata=f2fs\0"
 
 #include <configs/meson64.h>
 
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index 1869249e7c9..e84820a0d6d 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -10,36 +10,29 @@
 #define __CONFIG_H
 
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
-#define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
-#if defined(CONFIG_CMD_BCB) && defined(CONFIG_ANDROID_AB)
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
 	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
+	"name=frp,size=512K,uuid=${uuid_gpt_frp};" \
 	"name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};" \
 	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
 	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
 	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
+	"name=vbmeta_vendor_dlkm_a,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_a};" \
+	"name=vbmeta_vendor_dlkm_b,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_b};" \
+	"name=vbmeta_system_dlkm_a,size=64K,uuid=${uuid_gpt_vbmeta_system_dlkm_a};" \
+	"name=vbmeta_system_dlkm_b,size=64K,uuid=${uuid_gpt_vbmeta_system_dlkm_b};" \
 	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
 	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
-	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
-	"name=rootfs,size=-,uuid=" ROOT_UUID
-#else
-#define PARTS_DEFAULT \
-	"uuid_disk=${uuid_gpt_disk};" \
-	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
-	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
-	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
-	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
-	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
-	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
-	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
-	"name=rootfs,size=-,uuid=" ROOT_UUID
-#endif
+	"name=vendor_boot_a,size=32M,uuid=${uuid_gpt_vendor_boot_a};" \
+	"name=vendor_boot_b,size=32M,uuid=${uuid_gpt_vendor_boot_b};" \
+	"name=init_boot_a,size=8M,uuid=${uuid_gpt_init_boot_a};" \
+	"name=init_boot_b,size=8M,uuid=${uuid_gpt_init_boot_b};" \
+	"name=super,size=4096M,uuid=${uuid_gpt_super};" \
+	"name=metadata,size=64M,uuid=${uuid_gpt_metadata};" \
+	"name=userdata,size=10240M,uuid=${uuid_gpt_userdata};"
 
 #define CFG_EXTRA_ENV_SETTINGS                                    \
 	"board=vim3l\0"                                               \
@@ -61,6 +54,9 @@
 	"kernel_addr_r=0x01080000\0"                                  \
 	"pxefile_addr_r=0x01080000\0"                                 \
 	"ramdisk_addr_r=0x13000000\0"                                 \
+	"vendor_boot_comp_addr_r=0x39000000\0"                        \
+	"init_boot_comp_addr_r=0x41000000\0"                          \
+	"fastboot.partition-type:metadata=f2fs\0"
 
 #include <configs/meson64.h>
 

-- 
2.34.1


