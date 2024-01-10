Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766B5C47DA2
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web11.8904.1704882977082517545
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 02:36:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=wgAv8Ozd;
 spf=pass (domain: linaro.org, ip: 209.85.215.177, mailfrom: sumit.garg@linaro.org)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c21e185df5so2903338a12.1
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 02:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882976; x=1705487776; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E6fdywU6EW50aUjkVw7y3e/KpKAjgOGXE0XQF5Dqz4=;
        b=wgAv8OzdK8Vs+U3orYF326MsU9hfkg00D2YjVShzczjIFLPh0epcndE1ibgdt61m74
         tOrV86guRhL+97PhcL/bN9WxyftHMvWSwHXAXw9YS9psgkiUpb3zLfl1Z3Y98mxafA4q
         uX1Yz4z7V+UMvbI9zTZYGqCBoWeT+LDZ5cR2Xl9dkH2XHJBvgv989MqLDzbmJuwhZIyW
         K30wMEer6iEh+rECndFrNMre/VPfLQg+7E2YV/oUJlRlmKfG2kSrsHGIIVw/yaVEryvX
         oZhLu/YPVBWlJzpvQoxrjekDmwYPNbN23yUDx9xaR25OKgNwqAnzf189UQ3MVv5DHLWY
         Qxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882976; x=1705487776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8E6fdywU6EW50aUjkVw7y3e/KpKAjgOGXE0XQF5Dqz4=;
        b=CqcqaZaswGFVSmaGVC1MP3mOInHfErf0NYKQZlZ/9WH7KUCIXwOsBcS2TlQUEPd+Fp
         Ut3PuDZ97zHhqMATM5dtfwTzxEu1PuT5C9rEJZlLApT8UjskU+Auvwgnuzac5Cm8ffiq
         ngHlqb7VacFpv9k3BTsCOF5L19R4Yp84t2ml6MaCLIL7+Rp1OmYRkhk6Bp/OJp6ncl83
         nvNBzohEPpQ026HbuBwc9eVxcFp0e9AMrxaHg6pGn+KdCyMH+De+52L87Zo6x4T8cwf6
         fjH2NnDhDIN/joRE7hj4Gln3FltHeHaCTbapmJsfFxlgxWMUb95chrhfA8eTpL7aeHak
         kjRw==
X-Gm-Message-State: AOJu0Yw60Vr5BJlC9y74qaAfjTVB3pyVNC5qrioh06+d20FJJigb2lzT
	JLYnnfd/rCCUW0gBzT7VToAmvHX8ak2xoA==
X-Google-Smtp-Source: AGHT+IHMxbiZP0ppj/kQVvCZTlIseJu814BoA6Q/8k7YIf3mGnL/5D4Rf7gF6LcXmfkw2cMJLhGA6g==
X-Received: by 2002:a05:6a20:8e01:b0:19a:2a0b:b24a with SMTP id y1-20020a056a208e0100b0019a2a0bb24amr415634pzj.79.1704882976475;
        Wed, 10 Jan 2024 02:36:16 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:36:16 -0800 (PST)
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
	maxim.uvarov@linaro.org,
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
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 01/11] CI: Exclude devicetree-rebasing subtree for CONFIG checks
Date: Wed, 10 Jan 2024 16:05:37 +0530
Message-Id: <20240110103547.719757-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2058

Since devicetree-rebasing is an external repo with its own coding style,
exclude it from Azure and gitlab CI CONFIG checks.

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.

Changes in v3:
- Picked up review tags

Changes in v2:
- excluded gitab CI config check and added commit description.

 .azure-pipelines.yml | 3 ++-
 .gitlab-ci.yml       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index b9d6aa98a0b..97c88bc2a5e 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -65,7 +65,8 @@ stages:
       # have no matches.
       - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
                   :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
+                  :^include/linux/kconfig.h :^tools/ :^dts/upstream/ &&
+                  exit 1 || exit 0
 
   - job: docs
     displayName: 'Build documentation'
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fbf99f0322a..6362f2857c5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -161,7 +161,8 @@ check for new CONFIG symbols outside Kconfig:
     # have no matches.
     - git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
         :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-        :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
+        :^include/linux/kconfig.h :^tools/ :^dts/upstream/ &&
+        exit 1 || exit 0
 
 # build documentation
 docs:
-- 
2.34.1


