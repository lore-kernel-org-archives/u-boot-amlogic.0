Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.17417.1599727845327178037
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2020 01:50:45 -0700
Received: by mail-wr1-f66.google.com with SMTP id x14so5740701wrl.12
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2020 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s+At/Gp4A/GeUXC0v5dLc2Qb9nHoxuq4qQdgQ/IuiW4=;
        b=LCV5uZ7MN3qpuUiSOLblWhHf3MULdQg2rCUAlf5w0vhI1FGdDuMbd9ETnCtO4AoE21
         nc3Nqm/4tExzd4rQWHMtyzzcnSsRRaa5l/owYEM9mtjbk9IRwD/wVITNKE0GI8Cl51/G
         u8gPhBzkt2udm2mq4hv0miQ3bQWzie0iTmJloMKbi4az5XfL5ZRpZDViA5wTzId8mXkZ
         nGxH4KFkjL6f43KSs1RLRX3i/cWZb5zPhKHdiIaKTY13kJaH8XU/yT9BlJh5vBL/wGI6
         H8qLC+MqeuIYmhkx/p3ZglQEkuUFD4nWNWVkSYBTtGxqe2zTobEAt8iaYj9Uj56T2Xm6
         e6eQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] board: s400: generate unique mac address from SoC serial
Date: Thu, 10 Sep 2020 10:50:39 +0200
Message-Id: <20200910085039.25785-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Enable unique mac address generation from SoC serial on S400 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/s400/s400.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/amlogic/s400/s400.c b/board/amlogic/s400/s400.c
index 7e2f0cdae3..b081942dcc 100644
--- a/board/amlogic/s400/s400.c
+++ b/board/amlogic/s400/s400.c
@@ -18,5 +18,7 @@ int misc_init_r(void)
 {
 	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
 
+	meson_generate_serial_ethaddr();
+
 	return 0;
 }
-- 
2.22.0

