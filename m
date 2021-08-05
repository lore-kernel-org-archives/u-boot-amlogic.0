Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web12.10191.1628176661191717662
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 08:17:41 -0700
Received: by mail-wm1-f51.google.com with SMTP id l8-20020a05600c1d08b02902b5acf7d8b5so3264905wms.2
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dxbz/V5cyxgp7anjOv88TI94L+T3fRTFo1NjZtsKY2s=;
        b=LbbioBFwKe+yVghsiRkF3gSEIlhIgyPsPXNzJ6pqTIxTN0bpD+n+98KT9mTSPHHkNh
         js/yN3pDmAlU3P6uTEuNxC0R7G5h80Zx5ITxX8zEON5D7Pmm4wQbuUt5hSTkK+Q7coCz
         jd2T2BeeMKxmwmhKw1wVywceDvqVUPxRSoAPCAV5xUwkxv8KPbouXeer6NQ6vVqWeotF
         zVKttugcSeFk5yWmxxPLDV9z9Kgb4E9WN/ctNJL7NouMJOZY/BCKPbwp8RTji056L8mm
         ir/7pmBT75sx/U4RocsaAcphdsNAqFeCeTV1r1OA83IJdaEGQRu9GIzPUf2r74+e9jSC
         1ptw==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 8/9] configs: sei510/sei610: don't use hard-coded gpt uuids
Date: Thu,  5 Aug 2021 17:17:27 +0200
Message-Id: <20210805151728.422329-9-mkorpershoek@baylibre.com>
In-Reply-To: <20210805151728.422329-1-mkorpershoek@baylibre.com>
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

doc/README.gpt states:

> The fields 'uuid' and 'uuid_disk' are optional if CONFIG_RANDOM_UUID is
> enabled. A random uuid will be used if omitted or they point to an empty/
> non-existent environment variable. The environment variable will be
> set to the generated UUID.  The 'gpt guid' command reads the current
> value of the uuid_disk from the GPT.

Since we have CONFIG_RANDOM_UUID=y, remove the hard-coded uuids
and use meaningful variable names instead.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/sei510.h | 12 ++++--------
 include/configs/sei610.h | 12 ++++--------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/configs/sei510.h b/include/configs/sei510.h
index 16a34c717d..5bf2668803 100644
--- a/include/configs/sei510.h
+++ b/include/configs/sei510.h
@@ -10,20 +10,16 @@
 #define __CONFIG_H
 
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
-#define CACHE_UUID "99207ae6-5207-11e9-999e-6f77a3612069;"
-#define SYSTEM_UUID "99f9b7ac-5207-11e9-8507-c3c037e393f3;"
-#define VENDOR_UUID "9d082802-5207-11e9-954c-cbbce08ba108;"
-#define USERDATA_UUID "9b976e42-5207-11e9-8f16-ff47ac594b22;"
 #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
 	"name=logo,size=2M,uuid=" LOGO_UUID \
-	"name=cache,size=256M,uuid=" CACHE_UUID \
-	"name=system,size=1536M,uuid=" SYSTEM_UUID \
-	"name=vendor,size=256M,uuid=" VENDOR_UUID \
-	"name=userdata,size=5341M,uuid=" USERDATA_UUID \
+	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
+	"name=system,size=1536M,uuid=${uuid_gpt_system};" \
+	"name=vendor,size=256M,uuid=${uuid_gpt_vendor};" \
+	"name=userdata,size=5341M,uuid={uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 
 
diff --git a/include/configs/sei610.h b/include/configs/sei610.h
index 6d13fd143b..baace75a02 100644
--- a/include/configs/sei610.h
+++ b/include/configs/sei610.h
@@ -10,20 +10,16 @@
 #define __CONFIG_H
 
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
-#define CACHE_UUID "99207ae6-5207-11e9-999e-6f77a3612069;"
-#define SYSTEM_UUID "99f9b7ac-5207-11e9-8507-c3c037e393f3;"
-#define VENDOR_UUID "9d082802-5207-11e9-954c-cbbce08ba108;"
-#define USERDATA_UUID "9b976e42-5207-11e9-8f16-ff47ac594b22;"
 #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
 	"name=logo,size=2M,uuid=" LOGO_UUID \
-	"name=cache,size=256M,uuid=" CACHE_UUID \
-	"name=system,size=1536M,uuid=" SYSTEM_UUID \
-	"name=vendor,size=256M,uuid=" VENDOR_UUID \
-	"name=userdata,size=12795M,uuid=" USERDATA_UUID \
+	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
+	"name=system,size=1536M,uuid=${uuid_gpt_system};" \
+	"name=vendor,size=256M,uuid=${uuid_gpt_vendor};" \
+	"name=userdata,size=12795M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 
 #include <configs/meson64_android.h>
-- 
2.30.2

