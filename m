Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CCDE77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 14:17:50 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.15972.1736507644482696075
 for <u-boot-amlogic@groups.io>;
 Fri, 10 Jan 2025 03:14:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AF40okJ+;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: baltazar.radics@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361815b96cso14072135e9.1
        for <u-boot-amlogic@groups.io>; Fri, 10 Jan 2025 03:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736507643; x=1737112443; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oPd19QcP7V3uZa7KsYCbdkODezOp4JfahAu8Fpuf+wk=;
        b=AF40okJ+xfg7ZnDOI4wAYIcRmiRiI9RFOPPzLhEwrsXHU1uQu7aQpABLDA8rSHzgDs
         jILWcH6Cm+ru84n+Q7MToTSINnQHAkCqMr4hJ8F7N/qFqQ4qcXthE3hOc2WsRu99ISCv
         8Ko4N2pv8XZqyGgHYM6d3ErO/H7FQmXLAhA+pXNYi6lkXSSGOSduzHCz1qlFguRct2N9
         0Hf6urh2daTarw1qQE/k9i/h5mDSM53uy4rTr4ylWWFoPnuYvimyABiBKKmdiSxZk8b8
         xX+4q3slaKCI+Z+i/6URU1XmB+ECkWhkxCryiMSFCOwESo/rkOI31ddfUsmIA1g0R0LD
         gXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736507643; x=1737112443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPd19QcP7V3uZa7KsYCbdkODezOp4JfahAu8Fpuf+wk=;
        b=v+pLAZouJP5yjClMlGygC00hHbPW99dD1PdsfA1nprrctA/cLlm+HzgvN+orqxT8H7
         XNjelrIDMN4X2awW56nyR760FqfckYUzmddyBfben2Qhj6UtxFEXILPureTbY4OJOUiO
         Om5ZmvsenRvjz3EuskcVU2LEZJHmGHutZe5XHbOYPFxtpRLLn3KXEtc1J69KrWWt+L3r
         EcNaE4ah/A4IxMVs7/y43pwZjVrDKSpf+HAsKqRz434SOH1DKGmyCO+UZ+D4IEraJfh6
         z1taWfuWZ0G2BbqNoye333lkW5ZUyORLg0T8RcldcE2hQ60z2pmGs0zfootYkY4u/O3B
         RiTA==
X-Forwarded-Encrypted: i=1; AJvYcCU6wP+Tw2qOJAjlA0JggKokOtc+d2+8eIBNEAjG3h+8Zp4eSEUt1YplIMYx79wLB6LRGRktSakLUyyF5T8rag==@groups.io
X-Gm-Message-State: AOJu0YwfFPI1P7Pp0VRNeX0wuE9POgiXjERkvYjqWBiud0bBY6ZmQtNw
	knyVy4yP1TnCTjFPgWeDzoFAd9YYr9517NxIrG6ExFV7Kfyt6SC2
X-Gm-Gg: ASbGncsa5E8WnXUtPj3FjDBrf3PlclQs1szjEnI5WDwCkXS4nWOzRhjbPzbcIL2PEBO
	by+ZImm9F+BRJlRM3GB5CeJo2pN8S4cg6orntWBAGkKTMLjNuFaHug9MgYohriOsvDPmOGn+XZh
	BnaD3IBNGKw6t2FB/YRLf6BUy7xNBv+kd79f+EJ8k57UaphVm8uMZkLWHhhQY98n3ibVTouG14S
	56JtyxLjfGEKgFVVxhzdsyYQLZWT1oud5/FCqIqP2kb1qDNkxnKnV4pu5Lli4JdbB08toXEZJy5
	Cx8=
X-Google-Smtp-Source: AGHT+IGlttaxKPpoAYPz4GQvpy6zbS9ubm1lRliMdHZNh02xpU6cQst+F/wbTquvAMzs6Q7zLq64Vw==
X-Received: by 2002:a05:600c:1d10:b0:434:9e46:5bc with SMTP id 5b1f17b1804b1-436e26a7af2mr106392185e9.10.1736507642469;
        Fri, 10 Jan 2025 03:14:02 -0800 (PST)
Received: from pluto.karinthy.edu.hu ([2001:738:80e:b5f3:51ba:c885:8ac2:fd5d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a9407fd62sm2469452f8f.92.2025.01.10.03.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 03:14:02 -0800 (PST)
From: =?UTF-8?q?Baltaz=C3=A1r=20Radics?= <baltazar.radics@gmail.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Baltaz=C3=A1r=20Radics?= <baltazar.radics@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io
Subject: [PATCH v2] board: odroid-n2: Update docs for signing
Date: Fri, 10 Jan 2025 12:11:24 +0100
Message-ID: <20250110111335.9221-1-baltazar.radics@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 10 Jan 2025 14:17:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2613

The previous instructions resulted in a bootloader that wouldn't fit in
an MBR gap. I have updated the docs based on upstream's build process.

Signed-off-by: Baltazár Radics <baltazar.radics@gmail.com>
---

 doc/board/amlogic/odroid-n2.rst | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/doc/board/amlogic/odroid-n2.rst b/doc/board/amlogic/odroid-n2.rst
index 883720f8fb..5222a21c80 100644
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
@@ -74,12 +73,8 @@ Go back to the mainline U-Boot source tree then:
     $ cp $UBOOTDIR/fip/g12b/bl2.bin fip/
     $ cp $UBOOTDIR/fip/g12b/bl30.bin fip/
     $ cp $UBOOTDIR/fip/g12b/bl31.img fip/
-    $ cp $UBOOTDIR/fip/g12b/ddr3_1d.fw fip/
     $ cp $UBOOTDIR/fip/g12b/ddr4_1d.fw fip/
     $ cp $UBOOTDIR/fip/g12b/ddr4_2d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/diag_lpddr4.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/lpddr4_1d.fw fip/
-    $ cp $UBOOTDIR/fip/g12b/lpddr4_2d.fw fip/
     $ cp $UBOOTDIR/fip/g12b/piei.fw fip/
     $ cp $UBOOTDIR/fip/g12b/aml_ddr.fw fip/
     $ cp u-boot.bin fip/bl33.bin
@@ -113,7 +108,7 @@ Go back to the mainline U-Boot source tree then:
                                           --level v3 --type bl31
     $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
                                           --output fip/bl33.bin.enc \
-                                          --level v3 --type bl33 --compress lz4
+                                          --level v3 --type bl33
     $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
                                           --output fip/bl2.n.bin.sig
     $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
@@ -124,11 +119,7 @@ Go back to the mainline U-Boot source tree then:
                                           --bl33 fip/bl33.bin.enc \
                                           --ddrfw1 fip/ddr4_1d.fw \
                                           --ddrfw2 fip/ddr4_2d.fw \
-                                          --ddrfw3 fip/ddr3_1d.fw \
                                           --ddrfw4 fip/piei.fw \
-                                          --ddrfw5 fip/lpddr4_1d.fw \
-                                          --ddrfw6 fip/lpddr4_2d.fw \
-                                          --ddrfw7 fip/diag_lpddr4.fw \
                                           --ddrfw8 fip/aml_ddr.fw \
                                           --level v3
 
-- 
2.47.1


