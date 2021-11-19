Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web08.4251.1637296624131059016
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Nov 2021 20:37:04 -0800
Received: by mail-pj1-f53.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so7808832pjb.1
        for <u-boot-amlogic@groups.io>; Thu, 18 Nov 2021 20:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2nWKxqTDNCDoddC5Kdvctrsoecpbbl2kNJTWreOBUg=;
        b=R8GjXqMrtjrZFzF7bJneHXaCKyN9hVVSTWwMKI+IwqVdD1N/q2Uz1BP4Um+htxwRgE
         ghWZBtTXVF2K9h4hBZX+Nc4dZ9Pfb/8kfhSPZwUWmWbPJkZKu+B3VcPIpjCvHxsFyoRP
         VXwKjDNozPH77sul6yysR01uK9ueJ1KZv6zSUg5qul0l/9S/rCFFIhEdpYnlIFhHmryQ
         BtII92DxsDDCxA/eXY4IkhsBXdlDxRHXHPsU7X+GPJgdBr0f+bvdiDUNIAZGIKm7NqMH
         EOFcTUkA5/LT3RTQT2gIVXyzIEPNKzHUI8G0k7ckMilDF3lntRu2/EhVM8cjPS4jdaVB
         X1hg==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH v2 0/2] env: setenv add resolve value option
Date: Fri, 19 Nov 2021 12:36:45 +0800
Message-Id: <20211119043647.1251416-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: sjg@chromium.org
Cc: trini@konsulko.com, marek.behun@nic.cz, narmstrong@baylibre.com, twarren@nvidia.com, andre.przywara@arm.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, christianshewitt@gmail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Add possibility setup env variable with additional resolving vars inside
value.

Usage examples:

=> setenv a hello; setenv b world; setenv c '${a} ${b}'
=> setenv -r d '${c}! ${a}...'
=> printenv d
d=hello world! hello...

/* internal usage example */
env_resolve("d", "${c}! ${a}...");
/* d="hello world! hello..." */

Artem Lapkin (2):
  env: setenv add resolve value option
  test: env: deep resolve value testing

---
V2 changes:
_ fix comments style
_ add comment include/exports.h
_ remake strcpy to strdup
_ env_resolve minimize
_ test added: test/py/tests/test_env.py: test_env_resovle
---

 cmd/nvedit.c              | 43 ++++++++++++++++++++++++++++++++++++++-
 include/_exports.h        |  1 +
 include/env.h             | 11 ++++++++++
 include/exports.h         |  2 ++
 test/py/tests/test_env.py | 24 ++++++++++++++++++++++
 5 files changed, 80 insertions(+), 1 deletion(-)

-- 
2.25.1

