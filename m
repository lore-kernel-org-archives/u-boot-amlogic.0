Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279CCC6FD1F
	for <webhook@archiver.kernel.org>; Tue,  2 Apr 2024 08:00:59 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.7251.1712044852611253841
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Apr 2024 01:00:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=N1r/guIz;
 spf=pass (domain: linaro.org, ip: 209.85.221.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-341cf77b86dso4565544f8f.2
        for <u-boot-amlogic@groups.io>; Tue, 02 Apr 2024 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712044851; x=1712649651; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+J1pQDwP80T7/P0i+mw11V6a4QW6AL1/BPSC61RPB08=;
        b=N1r/guIzWwLgwckSD7oyyO/1mT/ZaI73QDgAMBKvCqCSlRSOckmUr4aIk8lxVCtZG6
         NTVWaeYuq7KO/+vj3LhdH9Wm7VXge1twJPG0ZLjsFrKphEmRgnSfA8H9U8lye0S5iHeU
         THSExFaEPxIPMuZiJ8pKcP6uleFaEEdrHCTd2q8kCelvxk0aSdC6pLp0EbIY6z/6Q6JY
         7Gi/rzGWv1Fqxi4hBWY9h6GkoS6nl5VWqWVFA1Oo6Bp/+2Ov17e/MyRz6G8P8kG2EmvU
         uGZT/7NmoW+zLhs3OnU92twoWL79aUjCrDgzSkjrr3dsmf/vMOltZhm1Lm5jIiaO+spc
         HYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712044851; x=1712649651;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+J1pQDwP80T7/P0i+mw11V6a4QW6AL1/BPSC61RPB08=;
        b=PnSbw7vGZ3nmInKuiYomHaFZ4bioPzAlkuNz7K2g1j59YfrRQrdSHkgfsSomEaM3br
         wYeOkb0+oA0d6flZoYG+N5JJl+56POt+BSN9BqvedamlGxUeB9mc29aS3Hu8P9Z5HsQb
         /qabC6GJHZ7qovZeyl7UDWYCHOW3/Wu3FEu4R7Wc8TABwUmKkoWg+Ws+ROYyKl4A6ySZ
         ik26+LSjMS+y/aYM2LMiNwzgaUWVNEy7wx5um/zAOczs7djdYRuigA5yFUf/ThJfQKjW
         H5ZIMcs++ZJCCecKL/Sxhdyfa7EsdIUukoNHr+nW3zfWu9e+Cz+O4fQwEGLdaNoicKpL
         0swA==
X-Gm-Message-State: AOJu0Yx86kV9FwvkdCOF1TPbaGkLKSNwGwkrrKZgqrKiqe3tqlqffLai
	JPog7CZLZxWOMAc0FEBRhCJxPgSKLkPi8p2T76GT1Cele6zdV0AWZE0yNbRMnWM=
X-Google-Smtp-Source: AGHT+IG7vKyNhloLBw0ExydQe713LjSDLa+ZkzUD1XiwegRrKjNT5QPVcypOjyLhx3HEdfo31yNhtg==
X-Received: by 2002:a05:6000:c8c:b0:341:865b:65c9 with SMTP id dp12-20020a0560000c8c00b00341865b65c9mr705706wrb.22.1712044850704;
        Tue, 02 Apr 2024 01:00:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id dn13-20020a0560000c0d00b00341b7d5054bsm13539642wrb.72.2024.04.02.01.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 01:00:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
References: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
Subject: Re: [PATCH v2 0/5] arm: meson: Switch to using upstream DT for
 GXL, GXM, AXG, G12A, G12B & SM1 SoCs
Message-Id: <171204485011.3673856.7933640729089233658.b4-ty@linaro.org>
Date: Tue, 02 Apr 2024 10:00:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 02 Apr 2024 08:00:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2264

Hi,

On Fri, 29 Mar 2024 18:51:47 +0100, Neil Armstrong wrote:
> Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
> DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
> drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
> kept in arch/arm/dts directory for these boards.
> 
> Keep A1 DTs locally since the architecture is still young.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/5] configs: meson64: remove amlogic prefix in fdtfile when CONFIG_OF_UPSTREAM is selected
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a219eb8c314811b7cab06e6169ccf765da0b2d60
[2/5] dts: meson: Switch GXL, GXM & AXG to using upstream DT
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/227c586e80c77d8aaefe415c2abab11f58f41854
[3/5] dts: meson: Drop redundant GXL, GXM & AXG devicetree files
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e747bfc48cc74fd944a1e2a603cf089ec58f20cf
[4/5] dts: meson-g12a: Switch to using upstream DT
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/01f661e46bf8a6837fa1801f09f1da79abda80bb
[5/5] dts: meson: Drop redundant G12A, G12B & SM1 devicetree files
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7b098c305e51086db906a07c5bdc983c8e9ae3f6

-- 
Neil


