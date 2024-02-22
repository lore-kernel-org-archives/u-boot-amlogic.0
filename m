Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01876C54E49
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 08:49:58 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
 by mx.groups.io with SMTP id smtpd.web10.9328.1708594669837944090
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Feb 2024 01:37:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=rsj4ZjCc;
 spf=pass (domain: linaro.org, ip: 209.85.161.44, mailfrom: sumit.garg@linaro.org)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a00b5e78adso922283eaf.0
        for <u-boot-amlogic@groups.io>; Thu, 22 Feb 2024 01:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708594669; x=1709199469; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XyCybnabdst+3CZ0/r+NmrIx0w00q4z9pT7wJRsqhU=;
        b=rsj4ZjCcFSvKf9dHCmQjF1xgxiNuPvaw0PjRNyetEeno5Tz9fZPp941SKwW90sKP58
         nQRHexNQFIuqjb8/7xNbpdPAb+QRCujU6AYfWuK4gASpF1B4Z9SO86DPzSfHWxTXUf5j
         ZmMwFLP73j7K/zuRJw1Wb+LbwUuOYBChOuM97cmRTMDYSx00k+jyMQ0DL4a0R3iCGCYF
         UYNl69IAg5yu8a4cahwL8vM/9MKO09hUW6xIZ4dQM+snb1ZtCTn5YzD/RRdQMEFbzJgA
         71Wktk5nZtbKpZ2PfEu5jgll7zz3CJTgWEb9cA5O3/DYSEXQVe5vZT9UclqM7hmKN8RF
         9w6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594669; x=1709199469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XyCybnabdst+3CZ0/r+NmrIx0w00q4z9pT7wJRsqhU=;
        b=dwrJEFX3poD/lDZWpfTaoT7M2kGSPUttME39vWCRIxHIdSocV4FAAQ6gau57aYwTyz
         DgPkTZBj3DSSK5nGtpqNoN2i97sDNimyKIHu5jM6/5yJ1V1RrCCRo2CEUvZTPe+DvsbU
         2hpnBW6M0TA5Rzm2Xpk0KJ5V5fjx+Ggn3AoDmja4AzM0YdnC3ZFI4NwEPk8J9z1Ur401
         lo4vlrZP/Lz5DRh6XJkgW8keNNIg5ek5J3Sx5c+ID7GBSQBiNHKNowktvlQxRKMiMVSS
         4bJmGI0i/+lEYRXgpoDXfjqN+/jsO0TzCka3QPOpuMxSEc85uY9GHuZRPJUkQdzeCox1
         IRrw==
X-Forwarded-Encrypted: i=1; AJvYcCU3I6RsurekTkOrrb3noswUJOpGjsP0bXiI0xUZZxLTaDsMW3JnWj9TZme1s0It/ERO0lCA5KzqK/dOzUQZjqsrWmG5agL6HRQ=
X-Gm-Message-State: AOJu0YydeO7KoDFiWaviCxJv89QbOEpOCN4zQie8wgeLUfeepe0LjM5a
	MXwkHrQ3V0qlaKpYLRPrGAMKF/+26KI8xHQx2/llpVvxvycpRO78hjPCk2TH5PY=
X-Google-Smtp-Source: AGHT+IGO8zlm5N3Bw7a8KiFZdFhLz50IigprirfgWKaYEloNBRR8FAIDBPuzCOBFbKcgWODgNe7y3g==
X-Received: by 2002:a05:6358:6f8f:b0:17b:521d:9fcc with SMTP id s15-20020a0563586f8f00b0017b521d9fccmr6734041rwn.9.1708594669094;
        Thu, 22 Feb 2024 01:37:49 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115])
        by smtp.gmail.com with ESMTPSA id u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:37:48 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com,
	sjg@chromium.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	neil.armstrong@linaro.org,
	caleb.connolly@linaro.org,
	ff@shokubai.tech,
	daniel.thompson@linaro.org,
	dgilmore@fedoraproject.org,
	pbrobinson@gmail.com,
	ilias.apalodimas@linaro.org,
	b.galvani@gmail.com,
	xypron.glpk@gmx.de,
	michal.simek@amd.com,
	seanga2@gmail.com,
	rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com,
	jh80.chung@samsung.com,
	rfried.dev@gmail.com,
	marex@denx.de,
	mibodhi@gmail.com,
	bb@ti.com,
	mark.kettenis@xs4all.nl,
	festevam@gmail.com,
	nm@ti.com,
	andre.przywara@arm.com,
	ijc@hellion.org.uk,
	paul.barker.ct@bp.renesas.com,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 09/11] MAINTAINERS: Add myself as devicetree-rebasing maintainer
Date: Thu, 22 Feb 2024 15:06:05 +0530
Message-Id: <20240222093607.3085545-10-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 26 Feb 2024 08:49:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2140

Add myself as devicetree-rebasing maintainer.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v6:
- None

Changes in v5:
- None

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.
- Added commit description.

Changes in v3:
- Picked up review tags

Changes in v2:
- Picked up review tags

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b08ca192397..6541ab2b3a87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -989,6 +989,11 @@ F:	cmd/cyclic.c
 F:	common/cyclic.c
 F:	include/cyclic.h
 
+DEVICETREE REBASING SUBTREE
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	dts/upstream/
+
 DFU
 M:	Lukasz Majewski <lukma@denx.de>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
-- 
2.34.1


