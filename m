Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D288D0D7BB
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 15:51:21 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.15347.1728661874194284205
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2024 08:51:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=LENnpQUj;
 spf=pass (domain: baylibre.com, ip: 209.85.128.50, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so23820615e9.0
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728661872; x=1729266672; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=st3gsl4Hv1L87ZmhBwuH6nFBVIE/pTqHf20GzKXC8XE=;
        b=LENnpQUj98IDCiy3Hl+brbnI+XF1r56YyS0SJGw/MRNOje/iO8gDa2TeRvC3EHMdtA
         /uI6jvgygwYkirNrAxmAKnpyAM6VFbHKinAkzA03Yr6RsWjeFBD3LHT1rIBRtuJomXFF
         DNhgqdk/wSsEggoKraou30w/DolmlpSZ53ASPTs2hYTqGRMK9QsSIz2uMYkH0OHFBp8I
         6hSLkIiyFepyiEKXIVy7gY8vlDD7TJbzgUSD7bR8aoXLJ/XheOAM5Iq6AW7ZD024HMOf
         7z98de31xCD+vY4zYL3UnidDZfUBeVo4dsJqtgSSCt2cw+NvQfhJE8UKT9fn1y8fyR70
         X5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661872; x=1729266672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st3gsl4Hv1L87ZmhBwuH6nFBVIE/pTqHf20GzKXC8XE=;
        b=kDXXifvEZONPJ93k0Ukmm626QJ4gcSq4hV8sz8hnYYyUa7mxcSI9oXfcL+B9FMYsak
         u9fi7P+J2sPkPOA4ezgxF4OKBQdi+R29pYRtESqwmvZTSvoVLHAfigCHXbYLOEnsfnmm
         GO8OkzqQ+fc9EE/eU5Et29bk6Mq56YO6akNfLb/cj9FMrvLaxy9z0gFNG1M4t3/LRn6G
         fvk2JpCXe6u+qEcvL/NWGa8G5i+xZ+VZzb0W8fJdqIyf10wrDSda2G5YIGJCpdkQf9zo
         wz0jrqP3QlbJck89UHB5uVwDIXMPVLxZVFdjh426rQkKoHirJqQJTMA1eQT0jIZa2cyI
         mmjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMeBTk6hgenCQHFq052IHowygU+R83dnVmWli12jtTsFw9K1+ZOLsLUpE+q4rA2ULAjSI2wpEoUcYX7gTb9w==@groups.io
X-Gm-Message-State: AOJu0YzfKfEiOWr95yAju2/PsPvmeISCg5rF0vCj9OoPdYLFQQ3yMR9C
	fJ/ZHOPjbs3Ic/POs20T9p768+szFuBkW8n03nKSNaKqmOZmuFTJO1PGqdkVt09sIqU87YLT/fH
	P
X-Google-Smtp-Source: AGHT+IHKaqZDknRe25/ylaGTj6J8KLjhJqrN8L62hWfhu6Oix5rfoPkVlGqBEb+CXF9LoGovWwq9tw==
X-Received: by 2002:a05:600c:21ce:b0:431:24c3:dbaa with SMTP id 5b1f17b1804b1-43124c3dd9cmr4610915e9.2.1728661872590;
        Fri, 11 Oct 2024 08:51:12 -0700 (PDT)
Received: from mkorpershoek-xps13.home ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d794asm45769005e9.1.2024.10.11.08.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:51:12 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 11 Oct 2024 17:51:03 +0200
Subject: [PATCH 2/2] configs: meson64_android: Remove dtbo support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-yukawa-aosp-parts-v1-2-7d74aa13ff8e@baylibre.com>
References: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
In-Reply-To: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 15:51:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2449

The device tree overlays are not part of the
Android Common Kernel code [1]

Historically, they existed to enable some Android specific
features but they have been removed.

Remove the dtbos logic since these files do no longer exist.

[1] https://android.googlesource.com/kernel/common/+/ac2ea0bb91a3b5f5e71eba66c441e58beca6767e/arch/arm64/boot/dts/amlogic/
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index c0e977abb01f..fa520265800c 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -116,31 +116,7 @@
 	"fi; " \
 	"abootimg get dtb --index=$dtb_index dtb_start dtb_size; " \
 	"cp.b $dtb_start $fdt_addr_r $dtb_size; " \
-	"fdt addr $fdt_addr_r  0x80000; " \
-	"if test $board_name = sei510; then " \
-		"echo \"  Reading DTBO for sei510...\"; " \
-		"setenv dtbo_index 0;" \
-	"elif test $board_name = sei610; then " \
-		"echo \"  Reading DTBO for sei610...\"; " \
-		"setenv dtbo_index 1;" \
-	"elif test $board_name = vim3l; then " \
-		"echo \"  Reading DTBO for vim3l...\"; " \
-		"setenv dtbo_index 2;" \
-	"elif test $board_name = vim3; then " \
-		"echo \"  Reading DTBO for vim3...\"; " \
-		"setenv dtbo_index 3;" \
-	"else " \
-		"echo Error: Android boot is not supported for $board_name; " \
-		"exit; " \
-	"fi; " \
-	"part start mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_start; " \
-	"part size mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_size; " \
-	"mmc read ${dtboaddr} ${p_dtbo_start} ${p_dtbo_size}; " \
-	"echo \"  Applying DTBOs...\"; " \
-	"adtimg addr $dtboaddr; " \
-	"adtimg get dt --index=$dtbo_index dtbo0_addr; " \
-	"fdt apply $dtbo0_addr;" \
-	"setenv bootargs \"$bootargs androidboot.dtbo_idx=$dtbo_index \";"\
+	"fdt addr $fdt_addr_r  0x80000; "
 
 #define BOOT_CMD "bootm ${loadaddr} ${loadaddr} ${fdt_addr_r};"
 

-- 
2.46.2


