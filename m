Received: by mail-wr1-f68.google.com with SMTP id p17so88368276wrf.11
        for <u-boot-amlogic@groups.io>; Tue, 06 Aug 2019 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdU0FApyq6PFMpHBoVKX9KBIAGOScuZpTz19k0TsSR4=;
        b=JeiupyH4WWl+t+5jQMC36NgaCcvU9qWfhzy0+Mcj1SahBQlBybmrKSaV8OgROKEFQD
         k4lx+XKjFnZrZrCm+K96DlGT5T8uKblJnV+pYutMOyHwKh4Zao1ZUELSiBZaieJdiOzk
         67kp3tHeKLbpLL8oYth7GRBNnG7gxYPokFLJD717V8rIVt/cxM3pBOnVuUcdaNVAyOxa
         vM49iYJi+PgNHwKtRYsQfCNj6XiNIifXWpoMvMlV0z6ium3as+pZn42+w1pdsiWyEIF6
         2by19UMC8pS+Jl2v9VBiort55bw9I2ql8n1yyTwk0O4FmATZRcQeHIZd3WkeNjeZBAMP
         nIQg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 7/7] configs: sei510: disable PSCI_RESET to support fastboot reboot_flag
Date: Tue,  6 Aug 2019 17:43:19 +0200
Message-Id: <20190806154319.10505-8-narmstrong@baylibre.com>
In-Reply-To: <20190806154319.10505-1-narmstrong@baylibre.com>
References: <20190806154319.10505-1-narmstrong@baylibre.com>
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

