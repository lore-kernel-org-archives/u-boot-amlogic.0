Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
 by mx.groups.io with SMTP id smtpd.web11.1913.1637727017102489078
 for <u-boot-amlogic@groups.io>;
 Tue, 23 Nov 2021 20:10:17 -0800
Received: by mail-il1-f181.google.com with SMTP id r2so1189011ilb.10
        for <u-boot-amlogic@groups.io>; Tue, 23 Nov 2021 20:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dk/HmavR4Ikj/O45wXrs9+uk6JdxTf9WYE8x57Xbtv0=;
        b=UJw6tgKDhD4uT+kEvuFLlZBAifoUduZQ99ebMt+wBz9nm8d3jO9Afc2uYYYcLVthzu
         31njPucGkNbO9m+hGI+mOj9bcOrtRVmvMZjRWCfedrVwO6oA1Lo1d+6zHp7iiVds7O9o
         KTmt1JWuQkh5pqQbVglD9Gx0c+l427d6D1Qxw=
Return-Path: <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/7] meson: Demonstration of using binman to produce the image
Date: Tue, 23 Nov 2021 21:09:47 -0700
Message-Id: <20211124040954.699821-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>, Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>, Walter Lozano <walter.lozano@collabora.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

The Odroid-C2 is quite a complicated image with many steps. It is an ideal
example for how Binman can be used.

Add a binman description and update the instructions accordingly.


Simon Glass (7):
  binman: Allow providing tools and blob directories
  binman: Allow listing an image created by a newer version
  binman: Allow extracting a file in an alternative format
  dtoc: Add support for reading string-list properties
  binman: Support lists of external blobs
  binman: Rename _ReadSubnodes() to ReadEntries()
  RFC: Move Odroid-C2 to use binman to produce the image

 Makefile                                      |   2 +
 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi  | 107 +++++++++++++++
 arch/arm/mach-meson/Kconfig                   |   1 +
 doc/board/amlogic/odroid-c4.rst               | 127 +++++-------------
 scripts/pylint.base                           |   2 +
 tools/binman/binman.rst                       |  65 ++++++++-
 tools/binman/cmdline.py                       |   2 +
 tools/binman/control.py                       |  28 +++-
 tools/binman/entries.rst                      |  25 +++-
 tools/binman/entry.py                         | 102 +++++++++++---
 tools/binman/entry_test.py                    |   9 ++
 tools/binman/etype/aml_encrypt.py             | 124 +++++++++++++++++
 tools/binman/etype/atf_fip.py                 |  16 ++-
 tools/binman/etype/blob.py                    |  16 ++-
 tools/binman/etype/blob_ext_list.py           |  58 ++++++++
 tools/binman/etype/cbfs.py                    |   8 +-
 tools/binman/etype/fdtmap.py                  |  12 ++
 tools/binman/etype/fit.py                     |   4 +-
 tools/binman/etype/intel_ifwi.py              |   4 +-
 tools/binman/etype/mkimage.py                 |   4 +-
 tools/binman/etype/section.py                 |  26 +++-
 tools/binman/ftest.py                         |  57 ++++++++
 tools/binman/image.py                         |  12 +-
 tools/binman/missing-blob-help                |   6 +
 tools/binman/test/213_aml_encrypt.dts         |  38 ++++++
 tools/binman/test/213_fdtmap_alt_format.dts   |  15 +++
 tools/binman/test/214_list_no_dtb.dts         |  23 ++++
 tools/binman/test/214_no_alt_format.dts       |  13 ++
 tools/binman/test/215_blob_ext_list.dts       |  14 ++
 .../binman/test/216_blob_ext_list_missing.dts |  14 ++
 tools/dtoc/fdt_util.py                        |  21 +++
 tools/dtoc/test_fdt.py                        |   9 ++
 32 files changed, 822 insertions(+), 142 deletions(-)
 create mode 100644 tools/binman/etype/aml_encrypt.py
 create mode 100644 tools/binman/etype/blob_ext_list.py
 create mode 100644 tools/binman/test/213_aml_encrypt.dts
 create mode 100644 tools/binman/test/213_fdtmap_alt_format.dts
 create mode 100644 tools/binman/test/214_list_no_dtb.dts
 create mode 100644 tools/binman/test/214_no_alt_format.dts
 create mode 100644 tools/binman/test/215_blob_ext_list.dts
 create mode 100644 tools/binman/test/216_blob_ext_list_missing.dts

-- 
2.34.0.rc2.393.gf8c9666880-goog

