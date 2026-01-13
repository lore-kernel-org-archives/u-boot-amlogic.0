Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8B5D29DC6
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 10:15:23 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.56751.1768302998737419730
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Jan 2026 03:16:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sartura.hr header.s=sartura header.b=VyjqQBM+;
 spf=pass (domain: sartura.hr, ip: 209.85.222.170, mailfrom: robert.marko@sartura.hr)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c0f15e8247so1043759085a.3
        for <u-boot-amlogic@groups.io>; Tue, 13 Jan 2026 03:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768302998; x=1768907798; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d1+aJCPuXSARm5Mh5CL6rklHNlCFqVgOR2Vf2wAEcas=;
        b=VyjqQBM+d0FcfOJpkaakVM81v9DqF6EcqcthyAQh7J62ULqZu5tmp+sZYjuWbpES+5
         eonP9nKPuIp3ubDQBRr66DFl2zd6c5/AkmAB4OjwCgiFN6sWyQkpemEXh/rt0Yd9Ys8e
         X6wV/0l08k8OsN/vDcOhntcIOLjJi7YGmE9MymuGgtegus4PCvyXtRT0HOUA+j0m4aj1
         snHqsxuF+MZv2XcFUnNlXdHgNiRW21i6yg8dAl0m4UmvWQDWL76YxynGjcJCfcjwOXc6
         4b4bRiWjZesmEDbPVdzJ6iL/QuMDZZoJ10yCzIZgMEDXEJSt6BxT1kDmKBUivGNUop+Q
         E57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768302998; x=1768907798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1+aJCPuXSARm5Mh5CL6rklHNlCFqVgOR2Vf2wAEcas=;
        b=Dpei3W7VU6kNUQSjYDfPmUxaxtWEaPp52LvaxxTkWF/us9kFjZoxU+E5lT5bExvowt
         O8I3DlmUkF3omBqts+12u2Ut+Dzr6XwnUykO48kUEeQMQ+Ddw3VySPaIEAsWOszM9Shk
         ymEBub7qzEy7lBZA0P0QFiyyuFq42cXVUpFxfgIVqeVCLmL683GQqyimkqEkEMapdDG1
         YoR2+bVnVu42szgqxHohqIgLt1zpu/ci1Y3ippZvsaT4FOK/wpo1r34ERP6jN1inmulp
         Dhy1uJyAjddxW3JxYZMk3nWcZ0pcg6mkuIjqPQIRGn6iqPlooGhmUA2TymtuwUAXKzvU
         APNA==
X-Forwarded-Encrypted: i=1; AJvYcCXnwsT9UNocs5mpGWmOeQ53jZAAhrvzAcCgK63eTxjvvVR9CqI/LeNm1DoYyr3cl16zO+1k/+AXQh8lFqsoqQ==@groups.io
X-Gm-Message-State: AOJu0YwyjCSJ6Vp8fI9oHON2GZC658rY4QDEb2xE6jrl1lqIgkG8uuig
	nespjq0offV5UywrO/YLPlItt+woj2fUXLRgNgEOk/BEeMF2p3q90lCbqvhA/VKRmG85KGhvJ/i
	GNoD0tq0=
X-Gm-Gg: AY/fxX60pVyiqAhUTMNUnQYh3ajDhPsTw24vsapL7fWNbWqmqWsov7KstX+9Pe76GMz
	HAneYkiJUJY6cmPqcOMlflqmGkHFZcJnhjCLhYWqCYbPszjf2D7QtPtogKq0v0pVLtlhA++kr1h
	ImJIXd0XQAK9TskMoSnXINOFQOdtg1jHpeh8Jfcx2rceqqS5U8UynsoCMmrxe6X55S6s7Iby5nj
	ZiDw5pbN8yfBua88qaZ3Hejktr6gDH4oWKbCCzZqpLp6YcYqFPaBYNJ/PZP32X7+gZyPwXk/uKf
	xCCUzVdfOqUSGtFFwZZKQuXg2mZf95tMiJ43f3GQqk36mZx/F4VVMwm98TUm19Ad8x6X8pD24Dc
	Nr7rqeg0qJPk/lttOsNQqOz2eKujPrImFMr/LUz4uDy0WHAr+xGYVb9B/xwfM7zbGS8oGjUwklm
	YTlHI85LhWct+/0XiPfIFK9DnbZRsy01vCs5OKCwd6r2Gm3dVclhdxe5rU8acDmTz5+vxM9cbog
	UogVXI0
X-Google-Smtp-Source: AGHT+IHJz1hqs9cI25sRZLj+kvJC4uHAmA8Rz6cKLi3I0t1Wkr3+TQ4q6+DsvAHQeylTDrulhTZJWg==
X-Received: by 2002:a05:7301:4301:b0:2ab:ca55:89ab with SMTP id 5a478bee46e88-2b17d357488mr15099511eec.42.1768302498222;
        Tue, 13 Jan 2026 03:08:18 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2b1706c503csm20934863eec.15.2026.01.13.03.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 03:08:17 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: neil.armstrong@linaro.org,
	trini@konsulko.com,
	jonas@kwiboo.se,
	funderscore@postmarketos.org,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] tools: amlimage: include <inttypes.h>
Date: Tue, 13 Jan 2026 12:07:38 +0100
Message-ID: <20260113110806.648534-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 14 Jan 2026 10:15:23 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2883

PRIuN, PRIxN, etc macros are defined in <inttypes.h>, without it being
included errors like:
tools/amlimage.c:124:38: error: expected ‘)’ before ‘PRIu8’
tools/amlimage.c:126:31: error: expected ‘)’ before ‘PRIu32’

Can be hit depending on the host compiler and HOSTCFLAGS.

Fixes: 18c1654567dc ("tools: mkimage: Add Amlogic Boot Image type")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 tools/amlimage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/amlimage.c b/tools/amlimage.c
index ecb06bc535b..bc6e19b9c24 100644
--- a/tools/amlimage.c
+++ b/tools/amlimage.c
@@ -2,6 +2,7 @@
 // Copyright Contributors to the U-Boot project.
 
 #include "imagetool.h"
+#include <inttypes.h>
 #include <u-boot/sha256.h>
 
 /*
-- 
2.52.0


