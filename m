Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.66610.1679554505258517498
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Mar 2023 23:55:05 -0700
Received: by mail-wm1-f47.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so443489wms.1
        for <u-boot-amlogic@groups.io>; Wed, 22 Mar 2023 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679554504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rN6aHfIsm9J0O0IQ057yFCHJ2uZZpYnxmMmMU+EKtRM=;
        b=Gy+8Lu6v/bZlW+vbnMVC+IKKgO1JvfVKi0m/+A8kaCCB3fsXOenBF41+sD+VteMRty
         n5pTU/r4+EIyLzcIpzKMiqJHzp/h2w1tB8iEKYJGlrmr8hp9r0wXRrrpQQ8rFhfQjRby
         SaBgmkEnerfM+i6JERh/FgsRgVsHVLypCisfNXDNa29lOXRGTzXPqxY9AORMpmD+Hj6Q
         1dzpHU9FoGodTxhDYGbIjKO6T9XWtFFqKtP1o4s24qi7p887aMhaFeEpb2h/HsMlHZ3g
         Cuz5a2+l1HGTDI4oZ26/84rpUU2mFVE4FbiLhhqVUqBQ024KhSHrAMBvzrarLzTDE3bm
         2QjQ==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH 01/13] docs: boards: amlogic: add bananapi-m5 to u200 maintainer file
Date: Thu, 23 Mar 2023 06:54:46 +0000
Message-Id: <20230323065458.776029-2-christianshewitt@gmail.com>
In-Reply-To: <20230323065458.776029-1-christianshewitt@gmail.com>
References: <20230323065458.776029-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

The bananapi-m5 docs are missing from the file, so add them.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 board/amlogic/u200/MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/amlogic/u200/MAINTAINERS b/board/amlogic/u200/MAINTAINERS
index 47cec234a1..919e349922 100644
--- a/board/amlogic/u200/MAINTAINERS
+++ b/board/amlogic/u200/MAINTAINERS
@@ -7,4 +7,5 @@ F:	configs/u200_defconfig
 F:	configs/bananapi-m5_defconfig
 F:	configs/radxa-zero_defconfig
 F:	doc/board/amlogic/u200.rst
+F:	doc/board/amlogic/bananapi-m5.rst
 F:	doc/board/amlogic/radxa-zero.rst
-- 
2.34.1

