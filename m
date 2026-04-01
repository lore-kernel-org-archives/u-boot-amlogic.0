Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904FB10F6FCB
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 15:01:53 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14770.1775054453932264154
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Apr 2026 07:40:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=LUck78wl;
 spf=pass (domain: linaro.org, ip: 209.85.221.51, mailfrom: casey.connolly@linaro.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so2936468f8f.1
        for <u-boot-amlogic@groups.io>; Wed, 01 Apr 2026 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775054452; x=1775659252; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHMCT0l4Jf8/yJh3+wXTuLS4ZMIPSdrQseiOyewPPU0=;
        b=LUck78wlVL1uuE2k7/L6zdvuWGGAg4Tax1sGNFCDW8yc2G5UOvABeR1lWmD7nqBkmu
         +rwZgAEyl2QRUlqYWOyuz9iv2ETk39vorNf4qTQ8LSMaiHsPfAD1Er1LJxN2Bvt0VuKa
         mDJ/favGJW50/ZOvOSqY80g1yf/T2HEEaKgkGc8rL2108INe6/ccvEDl6mD0EYnlUqhR
         ZtKrw495R4wtD3aQpmSjVd5sGpMaXqAWW6sJ4zOufOInnRmUWlQqfSXMQHqKLQLhdCBo
         yJtkai5J87jDlK/t+Yv7kr5KLNNmIURfEcLdf97dx+Pd74cfuvq+SvcOkoDGXLLhwPmj
         RkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775054452; x=1775659252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NHMCT0l4Jf8/yJh3+wXTuLS4ZMIPSdrQseiOyewPPU0=;
        b=O/bx90ioIfEOte4QfLiWv2WHkipHgzzOfc8WUkL8WbSWMMFwFGArQGVDJ3Mr6njiwU
         p9BzUhXWRb7zQhS8rsqkLQa3SNQDoSqGk5ykTwwHMoPKhEeTL+RlBDVuQ99RDwG80QNs
         HyLt97AzmfOtbPCJ+7Io94lrQK0RdPysN9O3rhZCZ8Hiikhmvd2pN52SgHx+bEbWJ/wq
         A+KT8E/2UHzRHrWzGGFefY/qQSk8+hvW9rPYx9vKO7eg2yz/7zw1HsqPXaSxQIX7/DyK
         QxQlrZA2P60pg4YI1TPoLXR5OJWem5LUNyExCWW0mI3Gpm+qwBUNKSxTBxbI+IkEH3qu
         xvDg==
X-Forwarded-Encrypted: i=1; AJvYcCWNcYVh9ZN+NCmEcGLWiHVjGixZX8xpXwZOoCcKQkEascFlJbS8wUTAPYnxUd5KfBfYKgqZcF44J5Aph1a/6w==@groups.io
X-Gm-Message-State: AOJu0YxJMAr4zwUO7tHt4djm0cUx4osbpTyv0FL5JC5vv1XAADrVvpLd
	CdZlxtLBWCccAM1CATXqnLoNlNpZTs+uT67SBHhb0z/9IKsMdcAfXaONDh5EHaCX21ixoQGskvL
	O7id5slQ=
X-Gm-Gg: ATEYQzzGeCXbWHe8N3jbNyqf4i5dsddWyrdYumZk7D3sNfyL0yfJ65ki0gmqC6lIHai
	hSkT/dCt18tZjUsS+eBB4seE2MnwCPD2zVLNXtx1M6yctlZsL9+UtUV7fYV+/NNA/M/n2za57dq
	OOHUWz5hy4fB3Uh2goSepj6yXCrD/W1VuHqWCXDFaxdYorwPG1vR4fI15aT20HYMdaRUPei9kn1
	lHxsTuj88kyRT/s8Rr3JgGG5nr7mmcJgV7H2siWqdfhj8tVP6wME5ijH+BIOhg7zKeMEccYU1W7
	OpbK1UJcmj7WvwsA3v1yL50UMKj46+b0eD5wpHRcwLncGoyMWkp2O4/Sl9WkHWIFOeZHcNzEiKW
	CzFERPthU2blqNhpdWYZK2GZreZRZHZaumhTXoaoa6G9MwmAAzGG2ZbLIx5VtrIF1y2xNmV2/JE
	4MH+t0Qwtrju6hSJ8RP2vs8C12wwKl7nTHMu78JjH5eD2QtPWVTZQni8GbzVNr8uNpRyPC
X-Received: by 2002:a05:600c:3515:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4888359cee3mr68156245e9.16.1775054053837;
        Wed, 01 Apr 2026 07:34:13 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a63esm161821795e9.3.2026.04.01.07.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:34:13 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:34:02 +0200
Subject: [PATCH v2 1/7] clk: restrict clk/imx to MACH_IMX
MIME-Version: 1.0
Message-Id: <20260401-casey-ccf-clk-prep-v2-1-16a78c8c62da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=740;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=P+s1PrmAiVVmjoxgBNQcFmgXXPk98ex7zsSP+SOdMU0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzOo/cGLcZuDwp29CgdTg3y/hA171a0RXbNz9bZfjkb
 VHJOyHrjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRI16MDH0/XJfzLhXX/PnP
 pvsT97301P2C+0+uuSnPx96sLnWzMJzhf9Ecrr+97//KFYotbWfdX81frua+6YIE99mzCfn5xYE
 fWwE=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 01 Apr 2026 15:01:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2946

Only build IMX clocks when MACH_IMX is enabled, otherwise IMX clock
drivers get compiled for all platforms with CLK_CCF enabled.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f0c0d8a5c28..f96d57a3223a 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -15,9 +15,9 @@ obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
 obj-y += adi/
 obj-y += airoha/
 obj-y += analogbits/
-obj-y += imx/
+obj-$(CONFIG_$(PHASE_)MACH_IMX) += imx/
 obj-$(CONFIG_CLK_JH7110) += starfive/
 obj-y += tegra/
 obj-y += ti/
 obj-$(CONFIG_CLK_THEAD) += thead/

-- 
2.51.0


