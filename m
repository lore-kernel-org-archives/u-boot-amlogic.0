Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.73871.1679581909720268634
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 07:31:50 -0700
Received: by mail-wr1-f48.google.com with SMTP id y14so20739082wrq.4
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679581908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fGAEjxZmqcGuM4G0te+O7Csnup82dwOapD74BskWR4=;
        b=NRSe22DVQcO6b72zczibgxC2aepUoBRjH16G2n6mGCIr3YIPPsJq9lyL/FDkcf9TSH
         5NKbyg7Or+CII/ufiiz89kqGwwhnOp9JDHdEB7Fv/Nq4IUxDIqagE6sWEAAOSlBQGwoH
         DMUiAU5mFu39meM8M0bxuB3ddlJ8bSYFfaJgzg2f+i4TQfGDgtcojCEtsxwyYydyUNQk
         N0uwInXJxH4agUwHCyrNiY81OFx//WI5SF+vLveOwHPG1Enuc6/h+DBxh10pJN9XBkGJ
         O95RYBlGTrQdJVQBu99Io1rTRxSkuQPxpvBdP4bxc9U5KjX6UGHEOoOZ0gUVQtf4oLB4
         +HWA==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH v2 01/14] docs: boards: amlogic: add bananapi-m5 to u200 maintainer file
Date: Thu, 23 Mar 2023 14:31:29 +0000
Message-Id: <20230323143142.780306-2-christianshewitt@gmail.com>
In-Reply-To: <20230323143142.780306-1-christianshewitt@gmail.com>
References: <20230323143142.780306-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

The bananapi-m5 docs are missing from the file, so add them.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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

