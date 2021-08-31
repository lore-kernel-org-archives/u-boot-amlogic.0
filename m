Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web10.3740.1630405352423700895
 for <u-boot-amlogic@groups.io>;
 Tue, 31 Aug 2021 03:22:32 -0700
Received: by mail-pg1-f175.google.com with SMTP id w7so15030231pgk.13
        for <u-boot-amlogic@groups.io>; Tue, 31 Aug 2021 03:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I7MkymyBlVNnCDO/4UreJEJKtF/23IpoOTt/NGlza+A=;
        b=h2/D+QY0wokC2gwBLrNjvQWD5jwEuDHtHSIjx/NiwBLOQPFdyVRPlR8+p7IRfsyvcw
         mPftQypF4of4PnkrbtYGoCXAwWhxXKEiDmpmz9VvKMOZLwmfSIh9O+8UBuvtJZhL5q4X
         P1gDKiJ8Y/Vvlu5yBR81MHpMqaHhqJqW6zbeqr5a1Q5XMoWUuFr0Y3cVXzEq7khEpeOX
         kUMeL5dBCrU/orWtMjdec5J9xHTtroDYyJKL1weOga89Rb1+oGA4OVnktS799IA3PHa9
         QdMWAk4kMT38Yni4aPkb+xJuiU8GZ18GVZRdvKLE3qcZbmnWlFSIBbSJKxqA7qaK5VmO
         x3Dw==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH] image: add lz4 zstd compression magic map
Date: Tue, 31 Aug 2021 18:22:18 +0800
Message-Id: <20210831102218.2960058-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: trini@konsulko.com, narmstrong@baylibre.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, christianshewitt@gmail.com, sjg@chromium.org, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Add lz4 and zstd compression magic map. Already can decompress images
with lz4 and zstd compression type.

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 common/image.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/image.c b/common/image.c
index 59c52a1f9a..e199d61a4c 100644
--- a/common/image.c
+++ b/common/image.c
@@ -216,6 +216,8 @@ static const struct comp_magic_map image_comp[] = {
 	{	IH_COMP_GZIP,	"gzip",		{0x1f, 0x8b},},
 	{	IH_COMP_LZMA,	"lzma",		{0x5d, 0x00},},
 	{	IH_COMP_LZO,	"lzo",		{0x89, 0x4c},},
+	{	IH_COMP_LZ4,    "lz4",          {0x04, 0x22},},
+	{	IH_COMP_ZSTD,   "zstd",         {0x28, 0xb5},},
 	{	IH_COMP_NONE,	"none",		{},	},
 };
 
-- 
2.25.1

