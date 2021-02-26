Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web12.9804.1614348802062553332
 for <u-boot-amlogic@groups.io>;
 Fri, 26 Feb 2021 06:13:22 -0800
Received: by mail-wm1-f50.google.com with SMTP id p3so7562166wmc.2
        for <u-boot-amlogic@groups.io>; Fri, 26 Feb 2021 06:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J4/QZBRcCm6TYdPJMGKl+G/X6SY8LW7bdny9tFrMl4k=;
        b=1x9j6ult/gFKJyLCGx7qAqFKzGZAtYU5jvwgIPCPlV5JjCJuo1wTobQemkbMVIckfU
         QdN/SL1rUTI36DSHiCXCEG6eJUnzbcfE3uuwrjDwG7KrhvpEYmeKnWrndIhBNHkCab8Z
         sDS4bS2oUZGlZfTPR19TLFwNPwapfIyBcIa5WvBfTfhzRInsAZBacRXaZIVs3ug6XLR6
         wMiwsTAY8/qGtLWfOf/my8vN0VnUT39r43UMP1JmEzSzRQZhlYH2bXwiOoaT398l9TB4
         tBWmtSeRtalMKt2DKyOZUbxRwhg0N+TkGZIi9c57KCmTskpPBcGrPNOEu/bJ0FakzJd1
         Sp/w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] nvme: add cache flush in get/set_features
Date: Fri, 26 Feb 2021 15:13:18 +0100
Message-Id: <20210226141318.3882733-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, bmeng.cn@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On Amlogic G12A platforms, the NVME probe timeouts at get/set_feature(),
adding a cache flush solves the timeout.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/nvme/nvme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 5d6331ad34..44c00a0309 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -487,11 +487,11 @@ int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
 	c.features.nsid = cpu_to_le32(nsid);
 	c.features.prp1 = cpu_to_le64(dma_addr);
 	c.features.fid = cpu_to_le32(fid);
-
 	/*
-	 * TODO: add cache invalidate operation when the size of
+	 * TODO: add better cache invalidate operation when the size of
 	 * the DMA buffer is known
 	 */
+	invalidate_dcache_all();
 
 	return nvme_submit_admin_cmd(dev, &c, result);
 }
@@ -508,9 +508,10 @@ int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
 	c.features.dword11 = cpu_to_le32(dword11);
 
 	/*
-	 * TODO: add cache flush operation when the size of
+	 * TODO: add better cache flush operation when the size of
 	 * the DMA buffer is known
 	 */
+	invalidate_dcache_all();
 
 	return nvme_submit_admin_cmd(dev, &c, result);
 }
-- 
2.25.1

