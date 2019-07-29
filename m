Received: by mail-wm1-f45.google.com with SMTP id p74so53939244wme.4
        for <u-boot-amlogic@groups.io>; Mon, 29 Jul 2019 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FqXboZtnFxPhUhwQdN2RiClNzlD+fBj4287OcP6XIy0=;
        b=lvhi/RfMQtp6YVYZRAIgI+sBv846akSf7gF/LIFXk6fmVBBFHL8CIQZu11XPy1dNvU
         Nv/gXJ3+1P42QsjTSyJYvpV4RAy2u8znv+u22d/GDjidcxVVWmU5c39E8ZriBPURfQfI
         kj7wLBCKzUhKl7tlzTcDQiokW9m7GOlSVlJpzqmfq27r1ne68TJE5pKvwsP5QMDvVAjA
         ZyWqccwHXXhWf4lyoM2cTqmoEj2skq7lnE9yykuCWE5K6RIgf4u02pFadFZi2nBw26QN
         RbvvjxBCA5t46r5pkwK3FE7tdYmNy7JQRIH+6StQtZOYtLaTTfIu67+IiUnDJPEtRZok
         hW2A==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 5/5] configs: sei510: disable PSCI_RESET to support fastboot reboot_flag
Date: Mon, 29 Jul 2019 16:01:58 +0200
Message-Id: <20190729140158.6954-6-narmstrong@baylibre.com>
In-Reply-To: <20190729140158.6954-1-narmstrong@baylibre.com>
References: <20190729140158.6954-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jbrunet@baylibre.com, glaroque@baylibre.com, khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Disable the PSCI_RESET reboot handler to permit handling the reboot
flag and calling the PSCI handler with the flag in parameter.
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

