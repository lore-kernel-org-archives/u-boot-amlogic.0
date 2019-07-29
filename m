Received: by mail-wm1-f41.google.com with SMTP id l2so53587446wmg.0
        for <u-boot-amlogic@groups.io>; Mon, 29 Jul 2019 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdU0FApyq6PFMpHBoVKX9KBIAGOScuZpTz19k0TsSR4=;
        b=FNFQgY15MaNMG5CKdsamGa8zTXPwkIngFvUGO5uYstpJG1Sv6Of8h82BHRqlDsib64
         zNwYXsCiMk9CZfmv56qvTDlk/saPakXSGond7XPkUEGJFHWSrUndvcxx9rYWp+Jf3wDi
         xI+xQeLQAJtO9liLYhl4nJ4LxZZgD1Jy6iIxRUYlBF/b+H2aUzj3DNaJNAFeDC8XkS/D
         A+kv14wugC2zFUjXgadaEKo9hCYFHQa6V7ioo60KrldFHlAdLhClXj8WvNpZlmFbBF2c
         MVFIMvVWN5MlTq/Uv96f49Y7OYqMeFqPoA9qLH99+qMwHY4vOGmSnOYF3e6xdHeZZw7V
         bFUg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [RESEND PATCH 5/5] configs: sei510: disable PSCI_RESET to support fastboot reboot_flag
Date: Mon, 29 Jul 2019 16:07:51 +0200
Message-Id: <20190729140751.7851-6-narmstrong@baylibre.com>
In-Reply-To: <20190729140751.7851-1-narmstrong@baylibre.com>
References: <20190729140751.7851-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jbrunet@baylibre.com, glaroque@baylibre.com, khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Disable the PSCI_RESET reboot handler to permit handling the reboot
flag and calling the PSCI handler with the flag in parameter.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/sei510_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index 20534bd6b4..6c89d4a381 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -7,6 +7,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" sei510"
+# CONFIG_PSCI_RESET is not set
 CONFIG_DEBUG_UART=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_OF_BOARD_SETUP=y
-- 
2.22.0

