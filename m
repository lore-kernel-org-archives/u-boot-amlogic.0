Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web09.8950.1604589662676986606
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Nov 2020 07:21:03 -0800
Received: by mail-wm1-f65.google.com with SMTP id p22so1962803wmg.3
        for <u-boot-amlogic@groups.io>; Thu, 05 Nov 2020 07:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oy5SO+SvcZXcn7NR3+uPSNHA9PD8XU/GgbTG0gpUxSQ=;
        b=sYEeUdrGx7QszZ6WPfJwdvO7eXR/dt881h7PYWLVbxV674ggnYTI/rFx4lYxQCu6NY
         b3restub1z8kMSWoqnKIQxTNlMoR7H60B2UtDVQUUkvA+goNB2Ah8I8Pj48uYqvS/H37
         hqOi0dZOkqS/gWX5VuJ0redqYWpczn9AkTxkj2o7nbgtP1qMnUEHu5Iv0hLvRpk8ymry
         vyU8r9uB93TcG6vzSix1EvOW8bXWDuWm2drM0cuVXQ9rGhJpkoGzaDE0Wv0G/rVhBenI
         EVeZ7dikKjaOTsxTnzWbIRhKMPeqHuBMkFOWSgSB05b4Zj8ghM/e19kJl4uge1OJZU+3
         mrjQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/2] doc: board: amlogic: Update support matrix
Date: Thu,  5 Nov 2020 16:18:56 +0100
Message-Id: <20201105151857.1985411-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Update the matrix table with new supported features and
new SoC features to support.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 doc/board/amlogic/index.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 0e2f8c9aad..9e780ba47c 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -26,7 +26,7 @@ This matrix concerns the actual source code version.
 +-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
 | Clock Control      		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| PWM                		| No        | No           | No           | No         | No         | No          | No           |
+| PWM                		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
 | Reset Control      		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
@@ -44,9 +44,9 @@ This matrix concerns the actual source code version.
 +-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
 | I2C               		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| USB               		| **Yes**   | **Yes**      | **Yes**      | No         | **Yes**    | **Yes**     | **Yes**      |
+| USB               		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
-| USB OTG          		| No        | **Yes**      | **Yes**      | No         | **Yes**    | **Yes**     | **Yes**      |
+| USB OTG          		| No        | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
 | eMMC              		| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
@@ -66,6 +66,8 @@ This matrix concerns the actual source code version.
 +-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
 | LCD/LVDS Output    		| No        | *N/A*        | No           | No         | No         | No          | No           |
 +-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
+| MIPI DSI Output    		| *N/A*     | *N/A*        | *N/A*        | No         | No         | No          | No           |
++-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
 | SoC (version) information    	| **Yes**   | **Yes**      | **Yes**      | **Yes**    | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+--------------+--------------+------------+------------+-------------+--------------+
 
-- 
2.25.1

