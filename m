Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web12.9606.1631864239715174349
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Sep 2021 00:37:20 -0700
Received: by mail-wr1-f52.google.com with SMTP id t18so13658646wrb.0
        for <u-boot-amlogic@groups.io>; Fri, 17 Sep 2021 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ny7PVGmXkePCXf1hKaMKSWYvISoJ9q1s2QvSIsizQI=;
        b=TOCTQtJm2ECNh/HQUqjMFTY4Iur653JPyR/r/MPCq9gv23Yu2P9FEb5G+APreffpte
         LDdEK0qU7n00k9FJv7aJP3mdDDNh3jGfFukb2tmJahIQPqW+IP/NHHLO3MnTzmVAE9Nb
         LV45zhi84VXwjGYNEdrq7st6uQqCAhHDnThpT0x/9L80j2ClxThd9mfVuMu6Ud0ZIVOM
         ToWy9VdbXfdjywrjo3QAKARK3rTK/hyyNah5oIiyesyF+e2FCZ19nW33Xxt9UsPKX0mz
         2VmVlUEb+wzMs3h2Ju/dQ5ZVPFiOTnGQ8evOg/8X4vK3iNTOyjEA4x9lNW9m8MdKj2Rv
         kW/w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v3 08/10] doc: boards: amlogic: update for Odroid HC4
Date: Fri, 17 Sep 2021 09:37:07 +0200
Message-Id: <20210917073709.1052133-8-narmstrong@baylibre.com>
In-Reply-To: <20210917073709.1052133-1-narmstrong@baylibre.com>
References: <20210917073709.1052133-1-narmstrong@baylibre.com>
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

