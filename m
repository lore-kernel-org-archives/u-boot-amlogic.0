Received: by mail-wm1-f44.google.com with SMTP id c66so5864898wmf.0
        for <u-boot-amlogic@groups.io>; Wed, 12 Jun 2019 02:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qug4BPUViJWZB5rrdRdoBkjIpPZ43dobo7J71ZERGuk=;
        b=yVCxzKp0uzMgCOHur1AG3hw87gOrXHZwD8ZQisii5EAPEav/nPJ/vVKraCDO1LG6FY
         Nl7x04pItl/EmN4eR8KQSMNfx1QwNI+YeyUyxhyuv73kvZzJYrOxF4JDHU7JLLS4a7yz
         MW0CyzrizPZdz2UEvs/2lLBjGlKzRql8zKMFjSvguksu9h0yShwwspcjISQIa6Vi6oCC
         ITaYGP3/ekIla+fFMNjtRjldqDYepr9i78TsSYmuGvAHoWm5xQblktkXpq0VNjSdbWFG
         oDiQPIOyvUoz5QcwJRiymW4k1BYbU+zawxfquLtAwFj/M93waBw+XmHxmG54uuKQjkVx
         80vw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/3] board: amlogic: Generate unique MAC address for Q200 and P212 based boards
Date: Wed, 12 Jun 2019 11:49:08 +0200
Message-Id: <20190612094908.24858-4-narmstrong@baylibre.com>
In-Reply-To: <20190612094908.24858-1-narmstrong@baylibre.com>
References: <20190612094908.24858-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Enable unique MAC address generation for boards usins SoCs having
a known functional and valid unique serial number.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/p212/p212.c | 2 ++
 board/amlogic/q200/q200.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/board/amlogic/p212/p212.c b/board/amlogic/p212/p212.c
index 546c4d9c86..1159cee4ce 100644
--- a/board/amlogic/p212/p212.c
+++ b/board/amlogic/p212/p212.c
@@ -32,6 +32,8 @@ int misc_init_r(void)
 					  mac_addr, EFUSE_MAC_SIZE);
 		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
+		else
+			meson_generate_serial_ethaddr();
 	}
 
 	if (!env_get("serial#")) {
diff --git a/board/amlogic/q200/q200.c b/board/amlogic/q200/q200.c
index de97d6ad58..2ea97c362e 100644
--- a/board/amlogic/q200/q200.c
+++ b/board/amlogic/q200/q200.c
@@ -31,6 +31,8 @@ int misc_init_r(void)
 					  mac_addr, EFUSE_MAC_SIZE);
 		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
+		else
+			meson_generate_serial_ethaddr();
 	}
 
 	if (!env_get("serial#")) {
-- 
2.21.0

