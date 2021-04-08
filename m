Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.4902.1617868256452550643
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Apr 2021 00:50:56 -0700
Received: by mail-wm1-f47.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso2395828wmq.1
        for <u-boot-amlogic@groups.io>; Thu, 08 Apr 2021 00:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nEuhho93fbhyB4BPKtwoFcJAsM3dBY7g76oKAKrkfP8=;
        b=XF8QJXt2RFN4+/TzDH99baDEsw5H6PSyMMva/llQyrBNwXKMX57nqADq4l6rLbY1xQ
         bI0LQksoZ0d9cvIVQTlATfQdmQA2gvuB1Zz/Zbh5K4zXWs6nfKIvF4wyYHmZEkVoIOJp
         5hwpxDY0DwD9tuquFp7j1GYInC/sOgwFDbp1NTkOZoFE93YaC/QD1IYHWNlUxp+orSRj
         T6QHkKYJ5jGi9nlIUcsWfowiZeT8b/ONr5u7xo/4Y0ipaA3JdXKeH7fHLqb3/mQBZE+j
         5YHOZvXibbr6l7NqMtbzs4usWFNlAOaCyG3wrS+a5RWHAIr1WdkkneAw6m4GHA6umu1R
         gA/Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 4/5] configs: khadas-vim3: enable PCIe and NVMe
Date: Thu,  8 Apr 2021 09:50:46 +0200
Message-Id: <20210408075047.4076954-5-narmstrong@baylibre.com>
In-Reply-To: <20210408075047.4076954-1-narmstrong@baylibre.com>
References: <20210408075047.4076954-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Now we have PCIe, let's also enable NVMe to access an eventual NVMe SSDs
connected on the M.2 slot.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 configs/khadas-vim3_defconfig  | 5 +++++
 configs/khadas-vim3l_defconfig | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index bc17430569..5bf821bd38 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -85,3 +85,8 @@ CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_PCI=y
+CONFIG_CMD_PCI=y
+CONFIG_DM_PCI=y
+CONFIG_PCIE_DW_MESON=y
+CONFIG_NVME=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index c1877922c7..f066eb8c61 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -85,3 +85,8 @@ CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_PCI=y
+CONFIG_CMD_PCI=y
+CONFIG_DM_PCI=y
+CONFIG_PCIE_DW_MESON=y
+CONFIG_NVME=y
-- 
2.25.1

