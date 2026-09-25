Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36877C9832B
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 13:42:38 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8498.1790343754380531498
 for <u-boot-amlogic@groups.io>;
 Fri, 25 Sep 2026 06:42:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre.com header.s=google header.b=ptHHi9fk;
 spf=pass (domain: baylibre.com, ip: 74.125.225.140, mailfrom: glaroque@baylibre.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff23af865so5759695e9.2
        for <u-boot-amlogic@groups.io>; Fri, 25 Sep 2026 06:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790343752; x=1790948552; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WUnXu75ZRdLjaFEPeCJjU2KgvMwj5O9XkDhrT82NxTk=;
        b=ptHHi9fkI55TT91xEj/DvNoeHD/u/k4LWK5Z1nf0ySBKw6BfZDbgUoZwK/3iNgyYA6
         dL0dVdk51x3/rp0wJmqKAn3vN9mI0XCkB2DKUIKT/2GNUnKvHfKIL7A5P4R2rJp17Ltb
         vloeCNH4ctc6XqK6DByq8eO5ln8CRZCsw2XRVbd5vhA0RuioCtsDutCxTPSoPP+EMBAW
         tudVidRDr/b2irAqH6iQ9906se1F0HpM5PwINIRECbwncBLl4wbcdAhytrl5oT1NzMai
         ldkUtu7vN6BYEEtOUNd9gJFgcrXUOoQEp7iB6pLjqDZzGPMQYBMvH53p7jMVZoIv+eCb
         ySXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343752; x=1790948552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WUnXu75ZRdLjaFEPeCJjU2KgvMwj5O9XkDhrT82NxTk=;
        b=v0lezL3rT30TYtF3YeHIo9EnAPKyZ1oBZEJ2pxrEsQ4b1ARS23gKvd62DJR9Y4xabB
         2G3tr9Yj+Pm98SXUZLoQ2k5VvY+W2Q3Bn9cZgzloQouX8rQYjObX3S63wZ/DiVt+wnHe
         pCzHpllTKEgzlv//SRjk6mtRaLjPYqGdz0j4bBy5O1Hc2J8P35hbaq0wnwlT3mg2IpD2
         kOIGBqhGtQVR+ptj5QzdlqJLkKzEzVjYOOe6ClpY7xG2vpDd6UQSAbanjuY/MRJ2gVPW
         EBCV4VL+Elr/r7RCoKxuks+zjV1rnbCmVpqM44TmLyjcXar7n/e1bHZYBkj8KBiBovV2
         gYfA==
X-Gm-Message-State: AFuF++lGxvlkm+QCNjO2TOZgnsLCPEDdlSslapj4S0fIcn5x233wqJdU
	mpbm8sKYqJ6y8YJrKVMMcdCl85i+bFMbvCYPEjhuyX2d7n8uGT42mhONMlcNalfh1T3iJ7sTlfA
	5XHaWhek=
X-Gm-Gg: AYBFou3Oj2MbNrRaZmyr/p+qcMaFOYrh6o92LuWVaq/xHIsq8eQfM3ZRYfuKDgnny27
	03v3RVyrTWn+an/fcRjN+yHDA9nzHuiUQdJMLwSrgKD4ZvJ4h6ADmBXAQCgUwx0wivKlZWGetwj
	zizaQ84CsLFB3PKBKNjJBRvTR52/poe89knd/h8EedwSPeXT22iKBPaUumKApntLQgn0UZo9by8
	dw/co5Oqoe+879npv/Z16YUCcYDI7ah0gAegKN1XGKow+itknLE1Sv/41VnYh2NQHXgf+TMWP83
	oWfi5L5tHWXOzGn5baHYbgfEeAXFbRN6W4Xw38wAaFVhqbKiMJZsQvK+BpuUZMY2Y387j0xoY9S
	CCPKn4DLVHGoZknrVXqfuVQZhrx9JF4meohosz6S7psGiF2MK9tfXfMHskce6JQufrkI1iXzxcc
	0AvU5lmnLrmCZs7ze2LgNTuBHZgYYQIGQy7PqX2DmQzIlppjflEYVZMI6Zt7o+
X-Received: by 2002:a05:600c:8719:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49fe66c6373mr110505875e9.10.1790343752559;
        Fri, 25 Sep 2026 06:42:32 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff42b7074sm34738125e9.6.2026.09.25.06.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 06:42:32 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:27 +0200
Subject: [PATCH 4/4] configs: khadas-vim3: fix the Android DTB index
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-update_vim-v1-4-fddf7ba4dc34@baylibre.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
In-Reply-To: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 25 Sep 2026 13:42:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3099

The AOSP vendor_boot images for VIM3 and VIM3L contain two DTBs:
VIM3L at index 0 and VIM3 at index 1. The current adtb_idx values
of 2 and 3 are out of range, preventing Android from booting.

Use the matching index for each board.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 include/configs/khadas-vim3_android.h  | 2 +-
 include/configs/khadas-vim3l_android.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index 18632bb95a0..607e3bd6e24 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -39,7 +39,7 @@
 	"board_name=vim3\0"                                          \
 	"bootmeths=android\0"                                         \
 	"bootcmd=bootflow scan\0"                                     \
-	"adtb_idx=3\0"                                                \
+	"adtb_idx=1\0"                                                \
 	"partitions=" PARTS_DEFAULT "\0"                              \
 	"mmcdev=2\0"                                                  \
 	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index e84820a0d6d..ba01622166a 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -39,7 +39,7 @@
 	"board_name=vim3l\0"                                          \
 	"bootmeths=android\0"                                         \
 	"bootcmd=bootflow scan\0"                                     \
-	"adtb_idx=2\0"                                                \
+	"adtb_idx=0\0"                                                \
 	"partitions=" PARTS_DEFAULT "\0"                              \
 	"mmcdev=2\0"                                                  \
 	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \

-- 
2.34.1


