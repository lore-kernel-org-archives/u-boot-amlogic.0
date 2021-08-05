Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.10221.1628176660283770849
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 08:17:40 -0700
Received: by mail-wm1-f48.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so6629604wms.2
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgX3d0wIR8iOiq1q1oLv3q6+SZ2xiHBlYlCqVyCVh4Y=;
        b=Xp1aBl9yELac40dtOFi8WH3YrJ97Fv1o6G+3UtSd/Hzr120ufsbTstZj/j7mIK9TX4
         01FSdZyiDoiXgJQJLZUDHY1GyMaAN1JIejgzlO8sZKt+7++NsZBBkYCrVA8SXfIrOp1/
         sNPu1zdHo0UELsH70wRVJrz02gl323ywmj2uH6nOvb4WTsR+ow9kFIpJAelE/Y9th62M
         SB5ctWDGsN3i2nTuVyQYYMEMtzWBGV0ADdr5pqH+babHS30Az5N56t4E7B89MG9qglCB
         SIAqK4eKqKh9BKQa2TBrfomxiiL9ATAO+S4387sD2iuwD8iD+xuTNulFM1NAGt981H1l
         8dAA==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 7/9] configs: sei510/sei610: reformat PARTS_default
Date: Thu,  5 Aug 2021 17:17:26 +0200
Message-Id: <20210805151728.422329-8-mkorpershoek@baylibre.com>
In-Reply-To: <20210805151728.422329-1-mkorpershoek@baylibre.com>
References: <20210805151728.422329-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

There is a mix of spaces and tabs at the leading \. This makes updating
theses lines harder.

Add a single space before each \ for some consistency.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/sei510.h | 14 +++++++-------
 include/configs/sei610.h | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/configs/sei510.h b/include/configs/sei510.h
index d37b4c6405..16a34c717d 100644
--- a/include/configs/sei510.h
+++ b/include/configs/sei510.h
@@ -16,14 +16,14 @@
 #define USERDATA_UUID "9b976e42-5207-11e9-8f16-ff47ac594b22;"
 #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
-#define PARTS_DEFAULT                                        \
-	"uuid_disk=${uuid_gpt_disk};"  			\
+#define PARTS_DEFAULT \
+	"uuid_disk=${uuid_gpt_disk};" \
 	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=logo,size=2M,uuid=" LOGO_UUID             \
-	"name=cache,size=256M,uuid=" CACHE_UUID             \
-	"name=system,size=1536M,uuid=" SYSTEM_UUID           \
-	"name=vendor,size=256M,uuid=" VENDOR_UUID            \
-	"name=userdata,size=5341M,uuid=" USERDATA_UUID	\
+	"name=logo,size=2M,uuid=" LOGO_UUID \
+	"name=cache,size=256M,uuid=" CACHE_UUID \
+	"name=system,size=1536M,uuid=" SYSTEM_UUID \
+	"name=vendor,size=256M,uuid=" VENDOR_UUID \
+	"name=userdata,size=5341M,uuid=" USERDATA_UUID \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 
 
diff --git a/include/configs/sei610.h b/include/configs/sei610.h
index 9eeffdd72c..6d13fd143b 100644
--- a/include/configs/sei610.h
+++ b/include/configs/sei610.h
@@ -16,14 +16,14 @@
 #define USERDATA_UUID "9b976e42-5207-11e9-8f16-ff47ac594b22;"
 #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
-#define PARTS_DEFAULT                                        \
-	"uuid_disk=${uuid_gpt_disk};"  			\
+#define PARTS_DEFAULT \
+	"uuid_disk=${uuid_gpt_disk};" \
 	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=logo,size=2M,uuid=" LOGO_UUID             \
-	"name=cache,size=256M,uuid=" CACHE_UUID             \
-	"name=system,size=1536M,uuid=" SYSTEM_UUID           \
-	"name=vendor,size=256M,uuid=" VENDOR_UUID            \
-	"name=userdata,size=12795M,uuid=" USERDATA_UUID	\
+	"name=logo,size=2M,uuid=" LOGO_UUID \
+	"name=cache,size=256M,uuid=" CACHE_UUID \
+	"name=system,size=1536M,uuid=" SYSTEM_UUID \
+	"name=vendor,size=256M,uuid=" VENDOR_UUID \
+	"name=userdata,size=12795M,uuid=" USERDATA_UUID \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 
 #include <configs/meson64_android.h>
-- 
2.30.2

