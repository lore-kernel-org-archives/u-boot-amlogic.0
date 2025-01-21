Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF8C02194
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:44:19 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web10.26261.1737491511663948607
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Jan 2025 12:31:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=MrSTrMqU;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6ff72ba5aso582847885a.1
        for <u-boot-amlogic@groups.io>; Tue, 21 Jan 2025 12:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1737491511; x=1738096311; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EJrnZv0LO1XhiS3uV1LvjuqLzOt5GH3cqGwHyrIXcw=;
        b=MrSTrMqUnD0Cl3PAwKZLofjqAlNzCgurIxbG6qeiuDY7nxUmTwO5wskbMEO2uZLCCR
         ZLYn7yODDn+XYRaJZ7VcxaRp14n/uAPreSJBDuQUkfMmG9+eByHSYrLJFwBwi37RwBSf
         b1/dIZL78mHz0JepMDghXdfafi6nsS4j9K2D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737491511; x=1738096311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EJrnZv0LO1XhiS3uV1LvjuqLzOt5GH3cqGwHyrIXcw=;
        b=OgpAqrvCPfU8tyY4e6grqkWsjH7wUfaO+lINe6ijpIVZWshOkCjtQaxiF2HbQAiAdg
         QHRH+RYnhOsC1embNp1VSZMC68j/Z9C3zetBuMhizIX3j0mKB3hIVniCaMhKbUkUyCVg
         Ksj8vlrYiAKFNTl4Dtr21ecRLXGWR5klH40aR3wsZgFMESuHDSU7eqL/d4YYwNh+bGIw
         0EfT2fHBb5VEhDdskHAsjdPlqgqgvLR3iiXvJzRG8pzUzyPO1bA05X4skbXQfbffemZf
         rWf7qpdR3iRWtfRSGsdfuzQFCtzGIZ+tg85+vwgEtHa0rL3TNwLElgy9cphs4kyWpKd/
         Ke+w==
X-Gm-Message-State: AOJu0Yxt7GGq9eUY+BvoxGAEbKBRgigKJQlF8fEGwIJPdP+3n1ENWq6S
	SaqHybbX/5szu+ipVShsO+rGkRngMvy0hGf7PwrC8Z/KGdJoUhGxafdpi35wZi0=
X-Gm-Gg: ASbGncsaKKHWaVygx7rTFJXEX7zZ5LR2DXsRfXAiMnxuus578YA9zwSxG1+4I3I/5/g
	DNY+nYYLFvHhKACOgbNwbiTWOiTKzMU68VCeM/LRp6pQEIPF7KH9RWVDtUwfXuRGHZ6Y/dKk8kE
	+2hvb0Iebt+xz6yHZcs0UX1HQkU69bAcqbmRKYSvlxLiqagCz1NngthrzFuSYSBaiWAaEq7Owxn
	s/IDwxA8iXuUt/TjoqimX2bGriIE9TccDdkRUKx8K6a+seWKB4jmvWJ3S/+SxObGz21Ky2/8B5s
	fHidmuSi+aHHJw==
X-Google-Smtp-Source: AGHT+IHd13/Mi+/FcRN2M4dGTYDp0xi1uorwTGoqrfIOy74dvhsx0xpyl1xfyCJornwMpFEY/1+TTg==
X-Received: by 2002:a05:620a:2408:b0:7b7:106a:19b7 with SMTP id af79cd13be357-7be6323b53emr3057191585a.18.1737491510738;
        Tue, 21 Jan 2025 12:31:50 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.16.9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be61473cf8sm589027385a.15.2025.01.21.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 12:31:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io,
	u-boot-qcom@groups.io,
	u-boot@dh-electronics.com,
	uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] Squashed 'dts/upstream/' changes from 9b6ba2666d63..8531b4b4988c
Date: Tue, 21 Jan 2025 14:31:37 -0600
Message-ID: <20250121203147.4133618-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 30 Jan 2025 09:44:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2615

8531b4b4988c Merge tag 'v6.13-rc7-dts-raw'
[snip]
git-subtree-dir: dts/upstream
git-subtree-split: 8531b4b4988c2c9bddc90ea74f2d3e2dca9d5056
---
This will bring us to the v6.13-dts tag of the devicetree-rebasing tree
and so match v6.13 release. Changes and changelog omitted due to size,
and everyone who is listed as a maintainer of a platform with
OF_UPSTREAM enabled has been bcc'd, while other lists were cc'd to avoid
being marked as spam, hopefully.

-- 
Tom

