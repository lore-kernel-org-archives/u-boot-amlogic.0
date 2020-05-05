Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web11.5897.1588710195962747792
 for <u-boot-amlogic@groups.io>;
 Tue, 05 May 2020 13:23:16 -0700
Received: by mail-wm1-f67.google.com with SMTP id g12so41496wmh.3
        for <u-boot-amlogic@groups.io>; Tue, 05 May 2020 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEOvC1tyBbfcnSwRZOy4sqLI4KrXv3EhiVqmIFqstFc=;
        b=itVZcImWZoT6neayoVevxpX+WXPTJglsLnPvMibLdbLe9h3z/XOYz5UVt9sJiCrgaa
         A/dL6Z3TTrtWj0aPHumZCcEgL1cM+mzG0RbsK6T95ch7wrEy7M/YKgEMiv1BCFzaZPVU
         4D95ru0XJQeGNlF1wn+09nyalj2ZhXD5thhV7RgvhKsF2jbRRqp4OxvTYP7wfLN6wot7
         dbqC5KYk1Y4qWbVhuPNNTuVEUpZn9Svi9DdPy5feluVXr5Y37eXaA2EtAbMEFsu8RJh0
         Ozt54k+3H8J+RcEhue6YLvMRdccH6WU2cRjEYv2wOeZqfPyQoCwYp3YK84HCQPmpJdEe
         S23A==
Return-Path: <b.galvani@gmail.com>
From: Beniamino Galvani <b.galvani@gmail.com>
Subject: [PATCH 0/2] u-boot support for ODROID-C4
Date: Tue,  5 May 2020 22:22:15 +0200
Message-Id: <20200505202217.7849-1-b.galvani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, Beniamino Galvani <b.galvani@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

these two patches add initial u-boot support for Hardkernel ODROID-C4.

https://wiki.odroid.com/odroid-c4/odroid-c4

Beniamino Galvani (2):
  arm: dts: import ODROID-C4 device tree
  boards: amlogic: add ODROID-C4 support

 arch/arm/dts/Makefile                |   1 +
 arch/arm/dts/meson-sm1-odroid-c4.dts | 399 +++++++++++++++++++++++++++
 board/amlogic/odroid-c4/MAINTAINERS  |   6 +
 board/amlogic/odroid-c4/Makefile     |   3 +
 board/amlogic/odroid-c4/README       |  83 ++++++
 board/amlogic/odroid-c4/odroid-c4.c  |  17 ++
 configs/odroid-c4_defconfig          |  63 +++++
 7 files changed, 572 insertions(+)
 create mode 100644 arch/arm/dts/meson-sm1-odroid-c4.dts
 create mode 100644 board/amlogic/odroid-c4/MAINTAINERS
 create mode 100644 board/amlogic/odroid-c4/Makefile
 create mode 100644 board/amlogic/odroid-c4/README
 create mode 100644 board/amlogic/odroid-c4/odroid-c4.c
 create mode 100644 configs/odroid-c4_defconfig

-- 
2.25.1

