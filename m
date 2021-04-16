Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web12.8115.1618575794670326868
 for <u-boot-amlogic@groups.io>;
 Fri, 16 Apr 2021 05:23:15 -0700
Received: by mail-wm1-f52.google.com with SMTP id n127so2415113wmb.5
        for <u-boot-amlogic@groups.io>; Fri, 16 Apr 2021 05:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yuYyZqBTVSRLchH77fjz9ekDU6t9MyXiUXbgWuoQARs=;
        b=VRLz8xbsmfTN+g9tevcpiOPAO+Gb/GXAPI8pr1AwrxidjWGMt3RErvhW6jK0dP8h0u
         cw1L0OVJYpHgzT2p8irDKfXZC/608XBVuJT1pS1hRN68xePOKzFUZm7xQY6u6vfRlwx3
         zfREAQotByiH5Hzhpaw36vvRRBC1qv9XB2txH8K5XVcK5RikOsnPXUkjFK+aYU/2vtaP
         iZtN3cyTse0No6v4VHANlj3DG4vfZQPRbGy1Uee/jbNnT2hoF6qXefLRvfEztlmXuTLb
         EzAVFTsLGJCP9ugilDCKlD3NgvB906FY+0pbZysC7iC/gfwJ6wKqKuPGNM48REW9uOda
         VdLg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] boards: amlogic: update documentation for PCIe support
Date: Fri, 16 Apr 2021 14:23:10 +0200
Message-Id: <20210416122310.2188025-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 doc/board/amlogic/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 275c3664b7..8da7afddb4 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -70,6 +70,8 @@ This matrix concerns the actual source code version.
 +-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
 | SoC (version) information     | **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
+| PCIe (+NVMe)                  | *N/A*     | *N/A*           | *N/A*        | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
++-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
 
 Board Documentation
 -------------------
-- 
2.25.1

