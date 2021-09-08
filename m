Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.12108.1631110662335139108
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Sep 2021 07:17:42 -0700
Received: by mail-wr1-f41.google.com with SMTP id g16so3581486wrb.3
        for <u-boot-amlogic@groups.io>; Wed, 08 Sep 2021 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ny7PVGmXkePCXf1hKaMKSWYvISoJ9q1s2QvSIsizQI=;
        b=ycUOLXxm0LdR7wIcVujWTs/bnrsYfmCPCLVB1Ql+0JnMS7MqqXwOF7LGKR1ASQ5Nzq
         eJ66FOv2D2Rh0uCtpWSDbCuimHzOLuAGS07ACmdPzGDqEcGMw6AJL3O3HhnEVydXJnO3
         oHAqZ/kNa47Zvd2AJsC9niStk4gZ87KecuJUyn1q3HjWt3zBPTp70bM+ZNVfFcTHgHVz
         ESR3TmFK8HJtlANWZblutpfXLhXt+0wyqq3u6yfaHLnPhly0kf4uEJA2SiOMFmYSH0k8
         mtGjJzEcQSMF7meI4qI03eKFCK6kengpNJawa4pJ90N0Z/y92h44RwZFOf7uhIkZUoXv
         Hx8Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 7/9] doc: boards: amlogic: update for Odroid HC4
Date: Wed,  8 Sep 2021 16:17:26 +0200
Message-Id: <20210908141728.585797-7-narmstrong@baylibre.com>
In-Reply-To: <20210908141728.585797-1-narmstrong@baylibre.com>
References: <20210908141728.585797-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add documentation bits for the Odroid-HC4.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 doc/board/amlogic/index.rst     | 2 +-
 doc/board/amlogic/odroid-c4.rst | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 8da7afddb4..af12f94fde 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -18,7 +18,7 @@ This matrix concerns the actual source code version.
 | Boards                       	| Odroid-C2 | P212            | Khadas VIM2  | S400       | U200       | Odroid-N2   | SEI610       |
 |        			| Nanopi-K2 | Khadas-VIM      | Libretech-PC |	          | SEI510     | Khadas-VIM3 | Khadas-VIM3L |
 |        			| P200	    | LibreTech-CC v1 |	WeTek Core2  |	          |            | GT-King/Pro | Odroid-C4    |
-|        			| P201	    | LibreTech-AC v2 |	             |	          |            |             |              |
+|        			| P201	    | LibreTech-AC v2 |	             |	          |            |             | Odroid-HC4   |
 +-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
 | UART                       	| **Yes**   | **Yes**         | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+-----------------+--------------+------------+------------+-------------+--------------+
diff --git a/doc/board/amlogic/odroid-c4.rst b/doc/board/amlogic/odroid-c4.rst
index 5a5a8688b8..f66d60a54d 100644
--- a/doc/board/amlogic/odroid-c4.rst
+++ b/doc/board/amlogic/odroid-c4.rst
@@ -17,6 +17,9 @@ Co. Ltd with the following specifications:
  - UART serial
  - Infrared receiver
 
+The ODROID-HC4 is a variant with a PCIe-SATA controller, the same commands
+applies for HC4.
+
 Schematics are available on the manufacturer website.
 
 U-Boot compilation
-- 
2.25.1

