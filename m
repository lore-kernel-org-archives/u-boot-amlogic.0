Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337DEE77194
	for <webhook@archiver.kernel.org>; Mon, 30 Dec 2024 14:05:02 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.23445.1734992594859438397
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Dec 2024 14:23:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PkVdLut/;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: baltazar.radics@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43626213fffso34461915e9.1
        for <u-boot-amlogic@groups.io>; Mon, 23 Dec 2024 14:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734992593; x=1735597393; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v0VBagbTUGG4QonZ2mbSUKq0fo0y+StTV9OHgiRAt8o=;
        b=PkVdLut/B+El4lL94ZX93SlkA5uph3PzABjxZDmv4o3H52txHvkMO6WcUpIGnXszHG
         yiAeyhi5qNMNzJXG44RnExmPk+Qe/H3uwcUw9EoeipVtxAbqhfvGhOpL5hwcT54gC4Fu
         ALbaCSlKc7H692ETC+3EUZ6b7Hb/IIZs+n4C/5JlTsNcG3HGcl+EU03wzvzf4c6kN8sk
         O9BsYcT0gftO+cX5MSqrnLzl/ZbEn6xJ1R++bAkjnF5GjhpS0gTbY+WTPfMQLr/F0aJH
         gq90AwtwXFOAzyCGuT2YANGB4GfZbT6gqJlpqYdXRqR3KomxRApOzz4Z3HBuEmjKD4OO
         Vk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734992593; x=1735597393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0VBagbTUGG4QonZ2mbSUKq0fo0y+StTV9OHgiRAt8o=;
        b=AFVZdAS7hEE8lH7CpC7Ika57RUJm0H6ayX7hDQvQwIMldJgrF2JiyeLXCSnMqS1tFg
         LR8v/JDtg39vcHo2Sb+GoIYskqn0PpDniI+/J4UMz+eqsJHUXpa9d4u1Nqp8EKozoKrt
         +xbjl2OKP4yAKzmfE8y+Xskj7mbY9MN4OTd/p9PNPqIyejNrdsmCOJu7NL4H0iyrwqIQ
         3Dd/etAq7MkD9lbs3sjRsjXEArfQtllDdT22dopvSLMsY+u0NU5t4kZVbv5iQf+mRcm9
         xiwQ0b3YxKS+FZrsnh30ZXEZUN7EcypidfvvlaRz4lQcvVbtGU/ED6rjqkJZWwiXe0BS
         rfsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZmj0ap40czo6Zgn2ffW6kTr/FZqzGaTcsPShm1FeLnGKdp6CZRlmQGRydyRS9it4tdlJ+a7F8dKdcd4h9Ng==@groups.io
X-Gm-Message-State: AOJu0YxuDe4tz2tB/FwZoLjv1YQtAp9cZGFCEMVYhYmWgrvKM0DGsjzh
	9iFOvkHoCvIVCabnEb2fND1id7qp2ogJsWgdAEjM2ugIaUd7DyM25YpvIfV6
X-Gm-Gg: ASbGncs+VPQIurdN2Q/YnnI94MuJnzpQEuKl1bVPEL3CWBt69eUoC4zbepca+kfR+b2
	Opzxxgz4IXob3tVFLAXisUNiqIMAJ3ZtO+zr3CIwdZ/iTvObJqgp8yp+d4t+D6R/O+3a1Co3muK
	WiWN9hWwrtgOTr5qkh9oKNArRq94bSyibdsBpSqwwLwFbirACMVPnsRNu/DA6GExh2h5hIi0V23
	ukvh3+w+NVlRHjCibjVoE5WMo9Ui/uRnLbj4aNdx6Eb7LvzBROT5LvubkLdE0osCvZF6qvuvTya
	pSefNVyPVkNCKxpWTNCVk5oUd9V5WQ==
X-Google-Smtp-Source: AGHT+IHWNDbxee4aHSakdpjGxy1OoL0vu/nKByQiEELNOvslwBVYjmpEkghtffm9KGucAQxlk+hl6g==
X-Received: by 2002:a05:600c:4f89:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-4365fc09731mr145292705e9.16.1734992593019;
        Mon, 23 Dec 2024 14:23:13 -0800 (PST)
Received: from pluto.desnull.home (176-241-17-60.pool.digikabel.hu. [176.241.17.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436723cb159sm96661595e9.16.2024.12.23.14.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 14:23:11 -0800 (PST)
From: =?UTF-8?q?Baltaz=C3=A1r=20Radics?= <baltazar.radics@gmail.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Baltaz=C3=A1r=20Radics?= <baltazar.radics@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io
Subject: [PATCH] board: odroid-n2: Add script and update docs for signing
Date: Mon, 23 Dec 2024 23:23:07 +0100
Message-ID: <20241223222308.22650-1-baltazar.radics@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Dec 2024 14:05:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2597

The previous instructions resulted in a bootloader that wouldn't fit in
an mbr gap. I have updated the docs based on upstream's build process.

Note that the script should be compatible with other g12 based odroid
boards, but I'm unable to test those boards.

Signed-off-by: Baltazár Radics <baltazar.radics@gmail.com>
---

 doc/board/amlogic/odroid-n2.rst | 71 ++-------------------------------
 tools/amlogic-odroidg12-sign.sh | 67 +++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 68 deletions(-)
 create mode 100755 tools/amlogic-odroidg12-sign.sh

diff --git a/doc/board/amlogic/odroid-n2.rst b/doc/board/amlogic/odroid-n2.rst
index 883720f8fb..f81e8222f8 100644
--- a/doc/board/amlogic/odroid-n2.rst
+++ b/doc/board/amlogic/odroid-n2.rst
@@ -54,10 +54,9 @@ image so it is necessary to obtain binaries from sources published by the board
     $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
     $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
 
-    $ DIR=odroid-n2
-    $ git clone --depth 1 https://github.com/hardkernel/u-boot.git -b odroidn2-v2015.01 $DIR
+    $ git clone --depth 1 https://github.com/hardkernel/u-boot.git -b odroidg12-v2015.01 odroidg12
 
-    $ cd odroid-n2
+    $ cd odroidg12
     $ make odroidn2_defconfig
     $ make
     $ export UBOOTDIR=$PWD
@@ -66,71 +65,7 @@ Go back to the mainline U-Boot source tree then:
 
 .. code-block:: bash
 
-    $ mkdir fip
-
-    $ wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
-    $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
-    $ cp $UBOOTDIR/build/board/hardkernel/odroidn2/firmware/acs.bin fip/
-    $ cp $UBOOTDIR/fip/g12b/bl2.bin fip/
-    $ cp $UBOOTDIR/fip/g12b/bl30.bin fip/
-    $ cp $UBOOTDIR/fip/g12b/bl31.img fip/
-    $ cp $UBOOTDIR/fip/g12b/ddr3_1d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/ddr4_1d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/ddr4_2d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/diag_lpddr4.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/lpddr4_1d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/lpddr4_2d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/piei.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/aml_ddr.fw fip/
-    $ cp u-boot.bin fip/bl33.bin
-
-    $ sh fip/blx_fix.sh \
-         fip/bl30.bin \
-         fip/zero_tmp \
-         fip/bl30_zero.bin \
-         fip/bl301.bin \
-         fip/bl301_zero.bin \
-         fip/bl30_new.bin \
-         bl30
-
-    $ sh fip/blx_fix.sh \
-         fip/bl2.bin \
-         fip/zero_tmp \
-         fip/bl2_zero.bin \
-         fip/acs.bin \
-         fip/bl21_zero.bin \
-         fip/bl2_new.bin \
-         bl2
-
-    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
-                                          --output fip/bl30_new.bin.g12a.enc \
-                                          --level v3
-    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
-                                          --output fip/bl30_new.bin.enc \
-                                          --level v3 --type bl30
-    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
-                                          --output fip/bl31.img.enc \
-                                          --level v3 --type bl31
-    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
-                                          --output fip/bl33.bin.enc \
-                                          --level v3 --type bl33 --compress lz4
-    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
-                                          --output fip/bl2.n.bin.sig
-    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
-                                          --output fip/u-boot.bin \
-                                          --bl2 fip/bl2.n.bin.sig \
-                                          --bl30 fip/bl30_new.bin.enc \
-                                          --bl31 fip/bl31.img.enc \
-                                          --bl33 fip/bl33.bin.enc \
-                                          --ddrfw1 fip/ddr4_1d.fw \
-                                          --ddrfw2 fip/ddr4_2d.fw \
-                                          --ddrfw3 fip/ddr3_1d.fw \
-                                          --ddrfw4 fip/piei.fw \
-                                          --ddrfw5 fip/lpddr4_1d.fw \
-                                          --ddrfw6 fip/lpddr4_2d.fw \
-                                          --ddrfw7 fip/diag_lpddr4.fw \
-                                          --ddrfw8 fip/aml_ddr.fw \
-                                          --level v3
+    $ ./tools/amlogic-odroidg12-sign.sh "$UBOOTDIR"
 
 Then write U-Boot to SD or eMMC with:
 
diff --git a/tools/amlogic-odroidg12-sign.sh b/tools/amlogic-odroidg12-sign.sh
new file mode 100755
index 0000000000..30a81e0374
--- /dev/null
+++ b/tools/amlogic-odroidg12-sign.sh
@@ -0,0 +1,67 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: GPL-2.0+
+
+error() {
+	echo "$@" >&2
+	exit 1
+}
+
+[ $# -lt 1 ] && error "usage: $0 <built u-boot odroidg12> [out dir] [binary]"
+
+src=$1 # hardkernel's u-boot tree (built)
+out=${2:-fip}
+bl33=${3:-u-boot.bin}
+
+. "$src/build/include/config/auto.conf"
+SOC=$CONFIG_SYS_SOC
+BOARDDIR=board/$CONFIG_SYS_VENDOR/$CONFIG_SYS_BOARD
+[ "$CONFIG_ODROID_N2L" = y ] && ddr='lp'
+
+fix_blx() {
+	[ "$(wc -c <"$1")" -gt "$2" ] && error "Error: $1 too big."
+	[ "$(wc -c <"$3")" -gt "$4" ] && error "Error: $2 too big."
+
+	cat "$1" /dev/zero | head -c "$2"
+	cat "$3" /dev/zero | head -c "$4"
+}
+
+encrypt_step() {
+	"$src/fip/$SOC/aml_encrypt_$SOC" "$@"
+}
+
+mkdir -p "$out"
+
+fix_blx \
+	"$src/fip/$SOC/bl30.bin" 40960 \
+	"$src/build/scp_task/bl301.bin" 13312 \
+	>"$out/bl30_new.bin"
+fix_blx \
+	"$src/fip/$SOC/bl2.bin" 57344 \
+	"$src/build/$BOARDDIR/firmware/acs.bin" 4096 \
+	>"$out/bl2_new.bin"
+
+encrypt_step --bl30sig --level v3 \
+	--input  "$out/bl30_new.bin" \
+	--output "$out/bl30_new.bin.g12.enc"
+encrypt_step --bl3sig --level v3 --type bl30 \
+	--input  "$out/bl30_new.bin.g12.enc" \
+	--output "$out/bl30_new.bin.enc"
+encrypt_step --bl3sig --level v3 --type bl31 \
+	--input  "$src/fip/$SOC/bl31.img" \
+	--output "$out/bl31.img.enc"
+encrypt_step --bl3sig --level v3 --type bl33 --compress lz4 \
+	--input  "$bl33" \
+	--output "$out/bl33.bin.enc"
+encrypt_step --bl2sig \
+	--input  "$out/bl2_new.bin" \
+	--output "$out/bl2.n.bin.sig"
+encrypt_step --bootmk --level v3 \
+	--bl2  "$out/bl2.n.bin.sig" \
+	--bl30 "$out/bl30_new.bin.enc" \
+	--bl31 "$out/bl31.img.enc" \
+	--bl33 "$out/bl33.bin.enc" \
+	--ddrfw1 "$src/fip/$SOC/${ddr}ddr4_1d.fw" \
+	--ddrfw2 "$src/fip/$SOC/${ddr}ddr4_2d.fw" \
+	--ddrfw4 "$src/fip/$SOC/piei.fw" \
+	--ddrfw8 "$src/fip/$SOC/aml_ddr.fw" \
+	--output "$out/u-boot.bin"
-- 
2.47.1


