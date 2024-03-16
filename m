Return-Path: <christianshewitt@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522ABC54E60
	for <webhook@archiver.kernel.org>; Sat, 16 Mar 2024 13:54:49 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.7056.1710597279866062353
 for <u-boot-amlogic@groups.io>;
 Sat, 16 Mar 2024 06:54:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=d5KdKVO4;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: christianshewitt@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41409fd8b6eso1306685e9.2
        for <u-boot-amlogic@groups.io>; Sat, 16 Mar 2024 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710597278; x=1711202078; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPcxqyTeUTFtLFpSljl4ZTM1noOjuExPBLyjmd+rHbA=;
        b=d5KdKVO47TxBXTFR2tL3TP8T1n3FR4GVpYws1PjHwqo8YgaKPyMgwOMuOsw/xrXw65
         3C9oA1gaYEsH6iNn7NDmAe5Dt37HYhS5BgM/8J6kJF5dPInPtlCt4sg01AeHKDN/EUI7
         MOZL1rlkc5VVIve86Pxsf++dyI/EhV2ND3QRsiWP4ZwkNUavNKafkQrQY9PxEAuDPQfn
         h8c2T2nvhFpRKOx/gv4W8KU9Kzb95FGIbewLwolL30fuEsaB6UXMOdLiKuo+sBnmNC+9
         ix/baMj5M8AYRhFINbBjHrKZXY78WeSWCFEIoJ9vdJT/P377cOk08lq3xvMkBWbX2qyk
         7tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710597278; x=1711202078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPcxqyTeUTFtLFpSljl4ZTM1noOjuExPBLyjmd+rHbA=;
        b=BMpC1t1R6k2LIcJal9BG+mavvbROEM4Z0DVfmj9hC4RNsQhpNKmcrrNxHF4oFxVev0
         SGmMAgdy+l4n7PSsmZpQEzuFPy7T2bYDWaH5QRwx2Omh1KuB0ZbZNNIWK/P2wbrZqYWC
         r+t1JSK5YQScJmAtCURHu/rgUX5dKNFWBkVnRWl2U8plAXyhGXduTkrYnC/TA349rnNg
         A3+9O1XRQDmbfkLzR3i17BLaZPMwRIyJiT35JwhHgk7s43zgeDMPCmw+dMCVIARaYIEv
         T0KreEi/mbgbyKd1jsl+Mp2LrKRwIL2HDbIJnOleyR7E1TElbBoty1FH+9cpPfwkI0gJ
         H42w==
X-Forwarded-Encrypted: i=1; AJvYcCV2M5r+K1iJa3NebY8fLiISHqPe2kL9MPvbRfXNnCGJgoFoHnkBYQfFR/JZIDNxFZ4T19KxAc/tN8pi6TVrcAxKOCCtjWq9vu0=
X-Gm-Message-State: AOJu0YxULTfZQtkonrjT495wvfHyMpubDl/GzYPO8/VDZGOsqyaZ1f5z
	Fi/7NZoxt6g8pIRrgt57yUOgGon0ZsPbIz1Dn8Mp+x33/igHimex
X-Google-Smtp-Source: AGHT+IEYG0eH4ayJUBr8ecRr7PG/f3qDBKXctrgFmfXcnYwNZccND8AUuoO0Z4plKiEDHJJUHtl5jQ==
X-Received: by 2002:a05:600c:a0b:b0:414:21b:9a92 with SMTP id z11-20020a05600c0a0b00b00414021b9a92mr1581883wmp.8.1710597278092;
        Sat, 16 Mar 2024 06:54:38 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0041409fa57c4sm523963wmq.34.2024.03.16.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 06:54:37 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/3] ARM: board: meson: update efuse MAC reading code
Date: Sat, 16 Mar 2024 13:54:29 +0000
Message-Id: <20240316135430.826898-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316135430.826898-1-christianshewitt@gmail.com>
References: <20240316135430.826898-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 16 Mar 2024 13:54:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2194

Current code used for reading the factory programmed MAC from efuse on
p200 boards does not appear to work resulting in a random MAC being
generated. Update the p200 board data reusing the function from the VIM3
source.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 board/amlogic/p200/p200.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/board/amlogic/p200/p200.c b/board/amlogic/p200/p200.c
index 7c432f9d281..fb07eefa532 100644
--- a/board/amlogic/p200/p200.c
+++ b/board/amlogic/p200/p200.c
@@ -14,29 +14,36 @@
 #include <asm/arch/eth.h>
 #include <asm/arch/mem.h>
 
-#define EFUSE_SN_OFFSET		20
-#define EFUSE_SN_SIZE		16
-#define EFUSE_MAC_OFFSET	52
-#define EFUSE_MAC_SIZE		6
+#define EFUSE_MAC_OFFSET	0
+#define EFUSE_MAC_SIZE		12
+#define MAC_ADDR_LEN		6
 
 int misc_init_r(void)
 {
-	u8 mac_addr[EFUSE_MAC_SIZE];
-	char serial[EFUSE_SN_SIZE];
+	u8 mac_addr[MAC_ADDR_LEN];
+	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
 	ssize_t len;
 
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
 		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
-					  mac_addr, EFUSE_MAC_SIZE);
-		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
+					  efuse_mac_addr, EFUSE_MAC_SIZE);
+		if (len != EFUSE_MAC_SIZE)
+			return 0;
+
+		/* MAC is stored in ASCII format, 1bytes = 2characters */
+		for (int i = 0; i < 6; i++) {
+			tmp[0] = efuse_mac_addr[i * 2];
+			tmp[1] = efuse_mac_addr[i * 2 + 1];
+			tmp[2] = '\0';
+			mac_addr[i] = simple_strtoul(tmp, NULL, 16);
+		}
+
+		if (is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
-	}
+		else
+			meson_generate_serial_ethaddr();
 
-	if (!env_get("serial#")) {
-		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
-			EFUSE_SN_SIZE);
-		if (len == EFUSE_SN_SIZE)
-			env_set("serial#", serial);
+		eth_env_get_enetaddr("ethaddr", mac_addr);
 	}
 
 	return 0;
-- 
2.34.1


