Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F9110F6FD7
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 15:01:53 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14794.1775054520810934598
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Apr 2026 07:42:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=GZE4Rd6+;
 spf=pass (domain: linaro.org, ip: 209.85.218.54, mailfrom: casey.connolly@linaro.org)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9bff57cb62so292515666b.2
        for <u-boot-amlogic@groups.io>; Wed, 01 Apr 2026 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775054519; x=1775659319; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMnsXnuvD55VljGKPUuKjkZRHIGIxyT6zTMvwS8mH4I=;
        b=GZE4Rd6+geIA7EoVyC31EWdm/stnbNJwwHcqmV8YfKOFJ2b5cZxGYeN9V8BzNV88A2
         x+FDJq8OuPm5sZoY57JE1n5gCRxPUMItBk8ezehO3HmilbV7OPph+rYIFfj2PcToO1tW
         3lKoljGO9JNhjHV1e1us2FV0njdAgxb6ncvgQ5f1kAIVGTu55s4qVBVNO+YoPcLrP3w3
         +s3sR2MxqiP/tHOYr8ZbyfS1H522fXDgfWGb2HxAFnDSewYpnjA+EF26FH9KGDu+GyLw
         jJv7C7VlRoKAtLexcQA7vXYFufaaDy0vxVD+mMWR8qxaR9d9d3F93FuouP8V3mSAQUsJ
         g0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775054519; x=1775659319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pMnsXnuvD55VljGKPUuKjkZRHIGIxyT6zTMvwS8mH4I=;
        b=cW09f9j92pFYdKpHkZ0h1LUf+KT73V6Z8nxg/ny9/+IB3kn646BLdhV6oHos3nQ2vb
         B8WJtyZ3tFLOVFdM7IqjqO1lR4ie+6YbNIweFmMTfxOeKO2AmQy/ylhiYczwnUcNQwDH
         hTxk8yf0Hc8KpTuefzyJu/jo9p6qWrtuFTRNWAbUFvx6tVnB26CHiGlavH8P6qJipcRh
         EJLsfYldkeZUZ+e9VwOXh/kCBb3xdmUHmz7nFjcj8d30NTHpjOM4VNC2CduDlFsRzO7L
         nBxaQCSgwgV9uVxd+D4dzd7Hj0Bdy4pvBD0/vIiBHDXrxrFbn4I6iDPD20KgZuyQsfQ3
         iQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCV6QklfJI8Db9Sq7z/kpH8iEsO8TwzEjknpIC4/jNB5kL7lj7VHJOcgYQFJlwXFm1CwONqxjzDeQGfh18DVcw==@groups.io
X-Gm-Message-State: AOJu0Yyfp/Xo4TuhPPEF5DsAe8MIRjBUaNhdW4npdd80b2gCqYmBtWZL
	ln+UyDK4eI/eP2fdjQAPf8ahSqGzKpfXqP5RcdJB3jIcAgGSblRTwL64L0X2KllIm5eMcuz96Sh
	3cXGHd2w=
X-Gm-Gg: ATEYQzwf/relL13kTEqtYYMB/0EiXxTwJEwdFh/NtRlFpE0L39qkN3cjrwtu9Z2lzRh
	5CaKbRY394FHP00+VqcU0T3T/HUJCeRq+bteCPH7hsZRlEGKw0Jo3PZmCA0yhOGS1vT08ywKJH0
	TrLYXFFeVv/aehRNEy72JV35lLTVGnp3H/rl9BV4yZz7urwS7G88UbYfKOyLtZ/G5WzGaAXJxGZ
	lMhpm4FjWYAY3jgg0W1+7N4Pwh8mpz9tSFXOd4PciXgFbPYtece+t5MDT5R+NgJ2wA90869ynnc
	pvl6gOghnGG23HV6FD3S8q+qj1s37wXY/orJ96jUjf6etsVFYADlp5ngkhFsAUhpCoqG/dJhx6m
	oDXkq6L69F8m9gqTcLGZH2QGtvUhnU6Af+icdDgMkdWjvd9mVWi3z0rna/hJizUw+LZshFIQdJt
	vngPeSbESd/edT152Ph4ExH5D4IcjLiaIYH8+wYl2owN+rxf1hUIjlVaAHS7vMzzxmByu/
X-Received: by 2002:a05:600c:5303:b0:487:1826:d89b with SMTP id 5b1f17b1804b1-48883562dafmr62498165e9.9.1775054060072;
        Wed, 01 Apr 2026 07:34:20 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a63esm161821795e9.3.2026.04.01.07.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:34:19 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:34:07 +0200
Subject: [PATCH v2 6/7] clk: make clk_get_parent_rate return signed long
MIME-Version: 1.0
Message-Id: <20260401-casey-ccf-clk-prep-v2-6-16a78c8c62da@linaro.org>
References: <20260401-casey-ccf-clk-prep-v2-0-16a78c8c62da@linaro.org>
In-Reply-To: <20260401-casey-ccf-clk-prep-v2-0-16a78c8c62da@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=FTNIXLG8hV/CteP0oaof3lhlj3wmvNeIdcnwzCFT8d4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzOo+XOBa9ilC+OV1PcV728Rlv1L/ITn/TcNaR+Zxlz
 /muhktRHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAinW8Z/ql/j9n9ZMfnx1wT
 p1elb7oyN3/n3EsOUmvu+0ot5lnb2ZTLyDDbP/FHS+4KDf/YBSc6Qv4nNa7MFyuRv/N7+5mQRbX
 u7+oA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 01 Apr 2026 15:01:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2949

This function can return negative values, update its prototype to
reflect this and avoid potential underflow issues with error conditions.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/clk-uclass.c | 2 +-
 include/clk.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index db4f056e4816..095329e25f15 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -514,9 +514,9 @@ struct clk *clk_get_parent(struct clk *clk)
 
 	return pclk;
 }
 
-ulong clk_get_parent_rate(struct clk *clk)
+long clk_get_parent_rate(struct clk *clk)
 {
 	const struct clk_ops_uboot *ops;
 	struct clk *pclk;
 
diff --git a/include/clk.h b/include/clk.h
index 3cd080b43264..0520032f692c 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -468,9 +468,9 @@ struct clk *clk_get_parent(struct clk *clk);
  *		clk_request/get_by_*().
  *
  * Return: clock rate in Hz, or -ve error code.
  */
-ulong clk_get_parent_rate(struct clk *clk);
+long clk_get_parent_rate(struct clk *clk);
 
 /**
  * clk_round_rate() - Adjust a rate to the exact rate a clock can provide
  * @clk: A clock struct that was previously successfully requested by

-- 
2.51.0


