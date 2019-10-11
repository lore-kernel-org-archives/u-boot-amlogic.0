Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.1856.1570808045748540146
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2019 08:34:06 -0700
Received: by mail-wm1-f65.google.com with SMTP id m18so10659858wmc.1
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2019 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LGst+tOfwvbblGE+/FmacPFvHNyR163yr+MFtdoa0Fo=;
        b=Vii5WwAP39Cc6Rs2VIgP9OkB1easWu069wQTpIf9crjBtTRgrW34XTUx576M/injR5
         cPmJ9g2hv4df2V/cdEBUJDm5fYJih2YjWJLJWS9GDn1aOg31pS3OCbz0H7lxPaUtMl41
         nQ1PEHNerLIFU5t9oilpn5FRmkaMl7KVxrUR9Dz1MEjsPMH7J2iljP3uCstJUKP+F0Vk
         rT5vN0inyNMhOHzzL5d+wbEJ5VxbV8rlA+6bSCO4Y/z1+rd2e6HU8hPCdCaZLmm+rsTW
         oPCXeXl6jnYByYTPUmyhHWlpjRXZ30n6uSUVsIvArAT+BENMYsr2+4rMFkQnxBmZIiIj
         z44g==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/8] clk: meson-sm1: add compatible
Date: Fri, 11 Oct 2019 17:33:53 +0200
Message-Id: <20191011153358.29739-4-narmstrong@baylibre.com>
In-Reply-To: <20191011153358.29739-1-narmstrong@baylibre.com>
References: <20191011153358.29739-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The SM1 clock controller is almost identical to the G12A and
so far the differences don't matter.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index c03738b6ca..1b2523bbf1 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -992,6 +992,7 @@ static struct clk_ops meson_clk_ops = {
 static const struct udevice_id meson_clk_ids[] = {
 	{ .compatible = "amlogic,g12a-clkc" },
 	{ .compatible = "amlogic,g12b-clkc" },
+	{ .compatible = "amlogic,sm1-clkc" },
 	{ }
 };
 
-- 
2.22.0

