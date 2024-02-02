Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEC4C48299
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 08:45:54 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.22178.1706879238312367308
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Feb 2024 05:07:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=QgbaMb3g;
 spf=pass (domain: linaro.org, ip: 209.85.214.180, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d71cb97937so19389745ad.3
        for <u-boot-amlogic@groups.io>; Fri, 02 Feb 2024 05:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706879238; x=1707484038; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uOqA2o+JoYPimkWZdK+MDHHE0G6ZoGW+csrPHpPpJA=;
        b=QgbaMb3gCD21rNoYZ9nyWQkWe625ZeiTQuhzge+xMQVmdPIQWxSpJ0YLmD5D4GpJTS
         /rbgQchO6j8setJoDzFyn94BCqY7R4gb5CDyfhxOaHZr2h0Ho+DXMyzYzsX8MedQLABw
         DVvW9qu9ps6r7Uv3/jxgpLmRK/7DFzfJ2DP0DUwE2ZVqdGeg9U4Z5CNYFfU5A3SafvgS
         pLSc/Qh//T0nhhlflqiByOZ5CCTRtsDHINVK3IFzkfIKDOsklIne9+XsfVqQgFZ6Hfnh
         d4LN9Y5Pe9bibECR3TgHI4ff/lWicxosCof0MiT44GjLyHgYksZCCOtokH17m5VMxzbR
         A0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879238; x=1707484038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uOqA2o+JoYPimkWZdK+MDHHE0G6ZoGW+csrPHpPpJA=;
        b=iVggxX+x7Mn0dZyysn6dqJJTMZ2fa8v5L9tTOmeDrhx5PpxYT6nQMF3V1aVHtgjFoF
         uMQAPb0oEsnWl9A0XBtgLrR3ZzY9AMfX1Kq/u2uWjn+06LiDN8jKymHGRN6HeO7JabvR
         OFjbeT2C75WUsImumx10RSs0H1NtfoHmG/caE4eCwN5jR8QG/Zlregq/qdbodz/lJHdr
         +ou4Iz/85KFJGFfkojpeFTSEJQMTgI6O4La5JHstIPZpUYMXcl/AIgD7FUVb04UPiE21
         O7aAmkiYaCVW7bjcU+CJzuqdnuVne7XkdYO6swuppVSwGW9MLk5+Zh0U4mN0qMeQv2gd
         SmDg==
X-Gm-Message-State: AOJu0Yzt2GEbnDEiTZXzIK0NrgAAlfvUxZWFC1NZkAk3/AoJdPlcgYk0
	IjsWOmFlwVINf5jwYX84STYQaG3qFObA2wD5XKlP+nYl84qIESILKi/rfvLOGnA=
X-Google-Smtp-Source: AGHT+IGAUzsjLIgDoP3S6NkALQIVzL953iZHkV8ajjPEldZEnKjg3E3cnAdJ7vAZzoXIeGhw2BcUug==
X-Received: by 2002:a17:902:f7c9:b0:1d9:4ee9:4d8c with SMTP id h9-20020a170902f7c900b001d94ee94d8cmr5014589plw.18.1706879237858;
        Fri, 02 Feb 2024 05:07:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFocORMJix+4USu3VDgUDJuoi6JqDH54U/ZJ4FDIIGeLhxJlRYm66CAhCf41+TXsBqTWRYE8EA68F56WN8YVmN3hZX2OTH/L+sc1U2WMIlJQQfkD5Q45P2z0gkqm6UM8vq5xb4nvmWX/O2QrydCq7FhxL/Dy6dK3fBMXrHKAK6F8UTymlOZkCGX0pv8nC3cLr/tbujnwt0rJkrDnPsr34AIVrDyvj6rOqllH1cj04Pbtd3/skJ3ib72FtQoMDf0H6bp/SktdnkC8boXJQsyxsQXKVIA6zkvO4XZS+k8aPp1n8CDk2w7iCQw3yU9snXKZkKrT9KsSQHlv90KQ+vaismLoDiUzkqsXwLWQe6pz4zu8qXxIzR7onBOu61O9SbzBxFxdCJT8VoFJgmb+4L69fF5JcbFvbWgcLVNNgoAtm/T89UUmn/BhlakEZzex7/JYLMUzfcYbrFM81PUYgFo0XRO1KNGQ8d1cf/alfp4DrtBtcTr83MN3k4n5BGOlaCeiR+gA7BB6B1IX1tVuCwvmDl7OhoTkvJ0iZKEmqfiMd7JGIt8a2/rB4HOIhqWymPHF0aCdSqGNOln/nNnoGlG71HaOIfhcJLqGg1Z9LoMjmmFCtTMl0M8CVO2CGJah3Ckuyww7mPOSB3KTUHBolLjS6Ex1RoAwLENsoc+kLahoBzXzhan1jvUJ7vpJUf5QFxEFx9aaAt65f4yzaveMx80bG1auqCINVvrtKyyD6dQ7gRGH/Too7DTly6zIW9+lOMMjNC8UKuLNBi8SqVN0NU0bUTjIe46xvduRWtQtnrHxIkHz0ABdT/4JKCDOsnq9V1a0IMNevCt8GEDMM8yoZzDMpxRrVOM0UNEAffTBiyDl8z0SsvymA6esrvJfI2dcXPpwusSqwvD8hRJbsUCPUuftAX3W7Uevs5sHtP
Received: from sumit-X1.. ([223.178.213.44])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:07:17 -0800 (PST)
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
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 09/11] MAINTAINERS: Add myself as devicetree-rebasing maintainer
Date: Fri,  2 Feb 2024 18:35:32 +0530
Message-Id: <20240202130534.1051438-10-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 05 Feb 2024 08:45:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2108

Add myself as devicetree-rebasing maintainer.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

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
index da477a4e6add..af05c42e5e42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -960,6 +960,11 @@ F:	cmd/cyclic.c
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


