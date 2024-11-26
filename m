Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BB8D5A6F2
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 08:07:01 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.40853.1732608417532736615
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2024 00:06:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=yL97dth1;
 spf=pass (domain: baylibre.com, ip: 209.85.128.41, mailfrom: glaroque@baylibre.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4349f160d62so17647175e9.2
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 00:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732608416; x=1733213216; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=68mSnIrNtR068OZSgD0LLYKHzK2yliNfMsp4/Ndr0Jk=;
        b=yL97dth11RasKAXE+I/7RWxRtnPRNsMKHD2JAIzWFh0mbtX68oNtiJc/Xnw28bUiIy
         7+i8LFP+OaxGXToMc5WKv7PQxvePU6xU4Rv0kdQQvUtXhHe0XRkIpRWdiiBYTjtXtK3R
         TM2aFcADFWRZV8mfjhrP5ObrYexY6nXaqn1APJHO4PZNVNsDZpWJ4BAE5ydn/GgwLU5H
         W27QgNrriQorB0FF9Y8iu2i+HTvQ55I+rweRugjiwp45bjJNM6gy1ZtKeVjJktG++/8K
         BTE9h4RNQvCEGUuqKEghK7r8RaMNSp5loI5uhyvECwK/tLny5E4gDk3PWIkosyO1ahtt
         l+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608416; x=1733213216;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68mSnIrNtR068OZSgD0LLYKHzK2yliNfMsp4/Ndr0Jk=;
        b=X5FOugIrRh9sG+h6OIK61Ulr4c/BUysWksWI5kavh2G3vrIkvV8A9Yuv56Mz9gZzLx
         7ShjjxrsuRmQ1uf2fEUmRaxBPotvRJOSVqE8jyhzjjkI7bfpkR5Cat+uiyROU+o8XVN2
         N3JnLxkwlrVXLkGFAWav+gULmmR5Ts+FM7jX98LyVXE2w9rxyzjlRMrGuRrX8piGRp+m
         S7xqMtMSk+vEvWwgrVisorW+RSs8AcukGjQtUvfJl6CWM/681nO6fhkiq5Wol/csz7G1
         JmDDKVaVT2yMLwb2r1uFW/jeqwKNBkFpx4XWJnfWsL061Xcb3/JM/9gkneJi4qmjPkhm
         U7HA==
X-Forwarded-Encrypted: i=1; AJvYcCWF7tAAwAfmhhkeTyj4x9NmZhvYPQ4q3MtcPg0FXc9Xog9tZyeEQlhqwBKPzwJ9QCTGqWzqdGodf8DE1Tk6dA==@groups.io
X-Gm-Message-State: AOJu0YyrnvtnRm0NlLJPdeD3hCfhPuzI81+hcGbMsCu+F0UxmAmrADIl
	3nqu8+jGaRm5lfY4KHWhhQ31r//9c+UuFS1YGUoL7BJBtSZKvdoBmUQ6R8RvtZmJ5JlvUHGAvTP
	IEZ4=
X-Gm-Gg: ASbGncs5+8m+qwY8jerBEUa8hgHpwI3RlzE5rQPYNprwuhR19wtsDp550ERQX0DzeEs
	BsVl4Uqme9QFcMiiL7JuO+0aYpuXat4tzpEhS9tlJbUCP6md0YazD+L/SW6cMyz3Js2otQLGY8y
	88dIZzZUyFEbrHoDr/KhyDtDqDlsWvHYJZD59aTMrGOKZyM3nuXlCegD32QDKXiSVovE4LjZVgx
	Urog9GwrkEMBOFYUUpy6ONlxwgs8Z6oJSw0gn4RSLp8/CLg5zXeFg==
X-Google-Smtp-Source: AGHT+IGyhWEcUhR9tXD639AoAocVALAu2ClfLCEW8FGvMLBTFP6AWFm8dzO6KvPO9zuYMB70MezViw==
X-Received: by 2002:a05:6000:1ace:b0:382:40ef:4319 with SMTP id ffacd0b85a97d-38260be4e03mr13926752f8f.55.1732608415845;
        Tue, 26 Nov 2024 00:06:55 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:86be:4d54:1784:8cf7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb36612sm12513102f8f.59.2024.11.26.00.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 00:06:55 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH v4 0/5] Add support of Android Boot Image version 2 and
 non-AB image
Date: Tue, 26 Nov 2024 09:06:08 +0100
Message-Id: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHCBRWcC/22O0Q6CIBSGX8VxHY0DKNJV79G6AMRkKyk0lnO+e
 2hrutbl/+98339G1NngbIcO2YiCja5zvk2B7zJkGtVeLHZVyogSyoFAjlXVBu+qSLEiUBlVECm
 IQOn+HmztXovrdP7kYB/PpOzXsnFd78Ow7EWY269abNQRMMGiBCOZlIQaedRquDod7N74G5pFk
 a4wAN/CNMHpVV3XGphg6g/MtrDcwizBPNdK8bKoNYMfeJqmN4TxDMM0AQAA
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 08:07:01 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2583

Actually bootmethod android only support android boot image version 4
and with AB image, some old platform wtill use android boot image
version 2 with AB or without AB slot.

This patchset add support of both version 2 and non-AB slot images.
It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC

patchset was tested on khadas VIM3 and VIM3L with AOSP main branch and
android-mainline kernel and with TI AM62P with android release provided
by TI.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Changes in v4:
- test: fix test after patch done on it by Mattijs :
  https://lore.kernel.org/r/all/20241123024300.GY3600562@bill-the-cat/
- Link to v3: https://lore.kernel.org/r/20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com

Changes in v3:
- Remove gpio recovery stuff not needed anymore. 
- Link to v2: https://lore.kernel.org/r/20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com

Changes in v2:
- Drop patch 3 (configs: khadas-vim3{l}: fix userdata size) already
  applied 
- Apply Tested-by and Reviewed-by from v1
- Fix comments
- Revert malloc/free for slot_suffix
- Remove vim3/vim3l stuff in meson64_android.h 
- Link to v1: https://lore.kernel.org/r/20241017-adnroidv2-v1-0-781c939902c9@baylibre.com

---
Guillaume La Roque (5):
      bootstd: android: add support of bootimage v2
      bootstd: android: add non-A/B image support
      configs: khadas-vim3l_android{_ab}: move on bootmeth android
      configs: khadas-vim3_android{_ab}: move on bootmeth android
      bootstd: Add test for Android boot image v2

 arch/sandbox/dts/test.dts                 | 10 +++-
 boot/Kconfig                              |  1 -
 boot/bootmeth_android.c                   | 78 +++++++++++++++++++++----------
 configs/am62x_a53_android.config          |  1 +
 configs/khadas-vim3_android_ab_defconfig  |  7 ++-
 configs/khadas-vim3_android_defconfig     |  7 ++-
 configs/khadas-vim3l_android_ab_defconfig |  7 ++-
 configs/khadas-vim3l_android_defconfig    |  7 ++-
 configs/sandbox_defconfig                 |  1 +
 include/configs/khadas-vim3_android.h     | 25 ++++++++--
 include/configs/khadas-vim3l_android.h    | 25 ++++++++--
 include/configs/meson64_android.h         |  6 ---
 test/boot/bootflow.c                      | 29 ++++++++++--
 test/py/tests/test_ut.py                  | 49 +++++++++++++++++++
 14 files changed, 206 insertions(+), 47 deletions(-)
---
base-commit: 48380f9b2a12e3fc6339d6af5a154bded769d911
change-id: 20241015-adnroidv2-a01dca609707

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>


