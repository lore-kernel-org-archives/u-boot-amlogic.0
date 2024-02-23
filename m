Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C91C5478C
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 17:41:37 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.1132.1708710091874153459
 for <u-boot-amlogic@groups.io>;
 Fri, 23 Feb 2024 09:41:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Air06LY0;
 spf=pass (domain: linaro.org, ip: 209.85.221.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d32f74833so572527f8f.3
        for <u-boot-amlogic@groups.io>; Fri, 23 Feb 2024 09:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708710090; x=1709314890; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RaQ4sgxn8yj9Zk6yrhDznr9Lq7Znufh6/YHLt2hqhjU=;
        b=Air06LY0lZaU8nLNcWHy2SzP4MI5itMDZWTFNX1tPW9S0kNNiFtngJQYteYjyxBXh3
         bkid+BuDvghz9WvpQKJrezndMnxaA1BtAHROxfcuEo+Z+rCs5iIGKEENn7zg5QI7Tihz
         37LeErpFVQluMqBzip72GaGk5Mwzn4FIiYQSUGGQJ6jWxTVhIWiTndXUunNaGZC1mu51
         0lZqCzGM1esGuBQk2/PAVeAGe5ItPcdSNPkV6/fal0nB7jc6r/p8mQzXTEWFr+9EPQoo
         RkWc8cUXkiwlVbp2NITT2GklrddkPUw0oY/8CPoAiySz6vh2bXyLVMnuKxhjfCvxI9aS
         Ee9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710090; x=1709314890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaQ4sgxn8yj9Zk6yrhDznr9Lq7Znufh6/YHLt2hqhjU=;
        b=BlEGqzb+T0hTR5GfNn/s1IVOwBOcg1Y0ad7otUwNa8lOUGTFBdTsQrx+XRcl1DtYmc
         7zNDLBfBw4zeQgg8O+JtF5Yk1zMDztr1ULkfuInGsufkPgJAn1arD+OhZSgFa0Jrc9Ax
         zM9aLyQBdySkmknc3OMAiwEesyeiMSMOGTMc6tVd2YHmWmvv9rXHkjAqVFsmRB6Mmk3e
         2Kgr5SJV/aNKrHYwAp2pTIYFKl+E5K0moa8Jd4T2+IBALJYs2dY08NiAGxdzeQeTcXRF
         gsKbw0BVueoPWqmcauiAG1rZ3yze8H71awF3o/qOCGsE0ucTWvH1UdpJK6iocdnWugBO
         k5WQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6/1D1wlQeiafsrPMrKD3TtMUI8DwYWVl2Ot/8oIPksiiTaHWfMxDIBNlLJYGLLeSIlXE+QwNTl2+7WUVK/5f7Q8X+MlK8nHQ=
X-Gm-Message-State: AOJu0YwCDGnyvYpNjSVnjIi0eqRiYZa9ML2zBabKkRLWAlaDuw9HaSX6
	KxWBP//g2MtsqR9kZrUEmmz8/2T74GypQ/fDrvAnWxJhUQK25iX84Lw0RW/vSFQ=
X-Google-Smtp-Source: AGHT+IGe2UARjfOrnupZh46SQeaz08dl65OQw42ThcACfTENK172+AZxyg1xR7pK3aDPdYzd22OTDA==
X-Received: by 2002:adf:ce83:0:b0:33d:27cf:6208 with SMTP id r3-20020adfce83000000b0033d27cf6208mr368779wrn.7.1708710090299;
        Fri, 23 Feb 2024 09:41:30 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d64a3000000b0033b6e26f0f9sm3649827wrp.42.2024.02.23.09.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:41:29 -0800 (PST)
From: neil.armstrong@linaro.org
To: trini@konsulko.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Subject: [PULL] Please pull u-boot-amlogic-fixes-20240223
Date: Fri, 23 Feb 2024 18:41:24 +0100
Message-Id: <20240223174124.866683-1-neil.armstrong@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 23 Feb 2024 17:41:37 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2130

From: Neil Armstrong <neil.armstrong@linaro.org>

Please pull this simple config fixes for the Khadas VIM3 Android
setup to fix an Out Of Memory error for AVB.

Thanks,
Neil

The following changes since commit 5e4a0c7f4a2c9d4670b75a6a2056243b1a56512b:

  Merge branch 'qcom-fixes-2024.04' of https://gitlab.denx.de/u-boot/custodians/u-boot-snapdragon (2024-02-22 11:34:59 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-fixes-20240223

for you to fetch changes up to fc0a7431e1729f456690468f2e9570fcc2c18175:

  configs: khadas-vim3*_android: fix AVB oom error (2024-02-23 18:22:50 +0100)

----------------------------------------------------------------
- fix AVB oom error for Khadas VIM3 Android configs

----------------------------------------------------------------
Mattijs Korpershoek (1):
      configs: khadas-vim3*_android: fix AVB oom error

 configs/khadas-vim3_android_ab_defconfig  | 1 +
 configs/khadas-vim3_android_defconfig     | 1 +
 configs/khadas-vim3l_android_ab_defconfig | 1 +
 configs/khadas-vim3l_android_defconfig    | 1 +
 4 files changed, 4 insertions(+)

