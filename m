Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D755FC369DC
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 14:56:02 +0000 (UTC)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web10.1681.1746061549498601333
 for <u-boot-amlogic@groups.io>;
 Wed, 30 Apr 2025 18:05:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=iwk52fRX;
 spf=pass (domain: chromium.org, ip: 209.85.166.46, mailfrom: sjg@chromium.org)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8644aa73dfcso16955039f.0
        for <u-boot-amlogic@groups.io>; Wed, 30 Apr 2025 18:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746061548; x=1746666348; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bh8WkGqcNYSMg1OhceCTKCkCT6M7wqBYjAYR+O4Jksk=;
        b=iwk52fRXQYgbVux10IT04XmxAo7FbvPjLzCjPI5g0coynyuOshjsA592VQWn5SnDHB
         OBJylbKM5KBN5FYOeiVbOzR/8yS4FZcZYPFaLqGrIiicPLyJi9CKKSAafDT2FRa4Lr3i
         AJbPmqOmVLONcEUVaxSLb9KeE5M5LcPLnJczI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746061548; x=1746666348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bh8WkGqcNYSMg1OhceCTKCkCT6M7wqBYjAYR+O4Jksk=;
        b=lUGmENC9aPkJorvpDLiQkM73MlSiYJ07xjrAz7QHJfhiFxiSrw/83xcly530yPBOZs
         AIGOEZ88b5x/QCImG6m0E30EOZ0cl/zch88U+BdP27a7wAC1H5rAdz8tRK17h0V98krx
         Cn0jwaJe+WpJRRXTtxvl7a8C2/4RudX/amca23yzH8J0lzqxf6CNlvDssFsQwWNe9lUV
         xiG2iprcAOobQdRo+lXm8CWM/TRetF4FBDXhMlxEEntWbP1txC3Dd84schw3n8W97nzQ
         +DE7ku0dVkpcQPSMeNs6cnMncPt0fK+iahd0eGVWJrFbLGUZclA6qghsLQ+hJCORDNL1
         tvTA==
X-Forwarded-Encrypted: i=1; AJvYcCUMUfwbIHwbft+Qp3m1O6jq01SiySahVvZA2V8jMRSWcHkjWzdgSMRoUGQArzCJlj8uCHF2lgMuq8hkGFG/ng==@groups.io
X-Gm-Message-State: AOJu0YzY6iFmIU+03QwSYIhkeR/8Sb9vvB8zDODQm8z3MaYvQTLslNFG
	XexDfsC59B+pcglt8g8qiRiblf9rMST9loJIpVzwjyy5cn1Wq5fhdNIH/3/NtA==
X-Gm-Gg: ASbGncsuyi6VE0dRkQ32wlZSAy3aLODoHSgwDADOgDgVhA8fJQT05u4HEdhy3fhkRWa
	+sZDHuQ38FNHrSPWWb+nmLG0ECVmYoYfnS57VngjtgDKQ9nxhoHjsjTVuvdezjpyqJyUFxoFn+u
	+o+D6zBBZPe5UdClYww7eKSZua1pzSLu/xENj6nldTmWcZq1dZH9hCtZUAokPfUuSyqUPl1wWx7
	64xrdnt0ZjBiuOCPs+pL0e1y9VC1vQcEVmKVJiF0gUmUOnJVrAFxss0v+GgVFEmLSRCrLWJbKf1
	tIgDJOnkuvVlFEmutRYLuL+TtzgPNvjB+0OdTTO2Sxb6aSakJtJRc75pYifIIRId0yMxUIL7mjy
	x74yqpdrbBmwn
X-Google-Smtp-Source: AGHT+IGOKrzRpJ91AjDAXZ7/Xcw667q4GmpbN21fEwQ9eyBqDvbOt3sfaFtzaIEMmC78QkEK9jQ/ew==
X-Received: by 2002:a05:6e02:1aaf:b0:3d9:24a7:db0c with SMTP id e9e14a558f8ab-3d96f1b20ddmr17130795ab.8.1746061548669;
        Wed, 30 Apr 2025 18:05:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net. [73.203.119.151])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 18:05:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Simon Glass <sjg@chromium.org>,
	Viacheslav Bocharov <adeep@lexina.in>,
	u-boot-amlogic@groups.io
Subject: [PATCH v2 12/22] amlogic: Include env.h to permit reading the environment
Date: Wed, 30 Apr 2025 19:04:37 -0600
Message-ID: <20250501010456.3930701-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 01 May 2025 14:56:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2664

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/amlogic/jethub-j100/jethub-j100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/jethub-j100/jethub-j100.c
index b770a1f8c53..9e87fb9f9d7 100644
--- a/board/amlogic/jethub-j100/jethub-j100.c
+++ b/board/amlogic/jethub-j100/jethub-j100.c
@@ -5,6 +5,7 @@
  */
 
 #include <dm.h>
+#include <env.h>
 #include <init.h>
 #include <net.h>
 #include <asm/io.h>
-- 
2.43.0


