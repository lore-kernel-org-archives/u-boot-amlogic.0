Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF19A10F6FD9
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 15:01:53 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14781.1775054480105468878
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Apr 2026 07:41:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=dLtNQMv/;
 spf=pass (domain: linaro.org, ip: 209.85.208.53, mailfrom: casey.connolly@linaro.org)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so11925251a12.1
        for <u-boot-amlogic@groups.io>; Wed, 01 Apr 2026 07:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775054478; x=1775659278; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/f4S9l/E5i4btKb7Yb2qc06X9sdAkelp31qRHQyfBo=;
        b=dLtNQMv/Hg86p4xdQOEnL/256XmnigrRB1OoPsChVeyLb/4auoGuXY84TMVfFyyqz2
         zzDRnQX9ZGUWySa/ZlHG2oj2SpX6XbnIbJ8vEQ8gOaTdxAkBnhr7GbuP0LnUcyxzxt8K
         pft5j1lpixng/81flIhmI3EsaB7rmRmVNOzX3zyUFpbPu/FBYAuEFGuJf5MXLtE3y8uw
         PULZKUgamJxrcOe6V0hZhEd+sxYJjKLlkgf2f1TuRUW+Ileg+wsFVOAFe8akxt6ge3Kf
         4lVNkvHq19Vio5sLfSfK1Y40XNkfQZAwiFqpuUTaDLpr31t8y1NtfK8coa+BqKgIkQpf
         QP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775054478; x=1775659278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I/f4S9l/E5i4btKb7Yb2qc06X9sdAkelp31qRHQyfBo=;
        b=BorYmvaG7KvTeUg45hkK/ad63jfJKc34G+u4GNq68AKqhnoTY214rhGNUypFvn1Aoe
         IRVN9LyYqYjHOIkfcIDJouXUC/Q2NyGWRGb0QyKDC7e/PyOjL2gUXzzH90KHlwsdJrqN
         erGAn6HrKgHiSaZNgilVj0Fscbp4LkFYZdPmzIxDZBVAnTtI26AhNOuEC5Jk8iQaOux9
         aVT01EMv9w3tUfaxmedjiy62LVouOvvIOr9lE1GvLE9N1QEBkobJWUDHQqjCAJWDW4lo
         F0pk1M0nZVfR+macgMsmaOIz2GybnDOR7CTb409go85PHAJd+26r1eQCTNEHkpAJyR5R
         JV3g==
X-Forwarded-Encrypted: i=1; AJvYcCVTHFMgCt2yGEo3QGIbbLMvIXUVmDzEeHE5pxqtIJhoGkXDPE8xw/mFbp1DI9NMBTtuXBLDWxx2BPUEZIxCPg==@groups.io
X-Gm-Message-State: AOJu0YwiErgHUKe0sNBsjtRNQoZjaJtPqKtKX7WbQgH5SaEPq1rivGE9
	gNmiACpHmo8Bw+ThWb0BywqYny33/XSexpgOicOXHQTx61LWJWzvIL3OLrZewj0eIm7mjiz1kI/
	gfTTxLwo=
X-Gm-Gg: ATEYQzycNc5nTdR9cQWCcADpReCrZieRtpt8oR4uhPDT5py9GNkXibb7QwtlEOk99Ni
	OFVYR/Kgg6S/HFMPx024nbiV76zPMPH5wyx1iKNY5Y5sNlKfVn36IsG6FP55Ye1fGiOS+aWGLei
	eqwN6bhmmgElcKSJK1rMRE36nHzBElB6M0jZTOwcIdSz5LT6UTjhx4FyJ33QSSMidgGQ6pU8cJ6
	VqxSuOPXgk5CdI4hmYx+L0qe7oEXt5QkDkBCudMEigqzmyQ0NoFuRP533lQzLExAIzPYIxymlln
	UwlxLyIi9l9072cJj+jgc97qtbNwISt4RCBfC6E5NMDzz4lxYIvSHljPfNke8eS5+iFCrgbjVfI
	Paq2+ZV8GG8JqYUD7gyw1LXTYnfrruhrPx/7iDT0iv4i1D2kw2XD2DRk4Ssl8HD7AIg3Xu8bkYr
	8ntV7dvTViMGpf6zTP11nhss0zilYikCSUej/r/i6aVu2C9yBxB6YE725GU/I/5v1RBhlfKKmMF
	cYGIeI=
X-Received: by 2002:a05:600d:11:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-4888355df72mr65982025e9.1.1775054057529;
        Wed, 01 Apr 2026 07:34:17 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a63esm161821795e9.3.2026.04.01.07.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:34:17 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:34:05 +0200
Subject: [PATCH v2 4/7] clk: move fixed clocks to clk/basic
MIME-Version: 1.0
Message-Id: <20260401-casey-ccf-clk-prep-v2-4-16a78c8c62da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=715igzV4HS4mUxyYAOfpPGBwwmJ9nlDFxPe0UC3c4oY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzOo9r1U2LkmY2VDpEOEs8V/0nlvzyyZmVoVfyJvjfk
 Hn6hf1ORykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIbTMjw8az0790hjZHJYQ8
 jp19k3+RZduvLSc7Ajemmu1dp/DkiAnDP8Pr/k8O/2B8YvcpTXPD09cy2c1FX1WdHFd1sGZMPex
 TbgwA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 01 Apr 2026 15:01:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2948

Linux CCF has incompatible implementations of fixed-rate/fixed-factor
clocks, move the U-Boot versions of these drivers to clk/basic and only
build them if CCF_FULL is not enabled.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/Makefile                       | 8 ++++++--
 drivers/clk/basic/Makefile                 | 7 +++++++
 drivers/clk/{ => basic}/clk_fixed_factor.c | 0
 drivers/clk/{ => basic}/clk_fixed_rate.c   | 0
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 30991e9f55d7..23f381eb0d9f 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -4,16 +4,20 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
 
 obj-$(CONFIG_$(PHASE_)CLK) += clk-uclass.o
-obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
-obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
 obj-$(CONFIG_$(PHASE_)CLK_GPIO) += clk-gpio.o
 obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
 # U-Boot/IMX "micro" CCF port
 obj-$(CONFIG_$(PHASE_)CLK_CCF) += uccf/
 
+# U-Boot basic fixed clocks, full CCF has a
+# different and incompatible implementation
+ifndef CONFIG_CLK_CCF_FULL
+obj-y += basic/
+endif
+
 obj-y += adi/
 obj-y += airoha/
 obj-y += analogbits/
 obj-$(CONFIG_$(PHASE_)MACH_IMX) += imx/
diff --git a/drivers/clk/basic/Makefile b/drivers/clk/basic/Makefile
new file mode 100644
index 000000000000..4cf9469d2312
--- /dev/null
+++ b/drivers/clk/basic/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2026 Linaro Ltd.
+#
+
+obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
+obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
diff --git a/drivers/clk/clk_fixed_factor.c b/drivers/clk/basic/clk_fixed_factor.c
similarity index 100%
rename from drivers/clk/clk_fixed_factor.c
rename to drivers/clk/basic/clk_fixed_factor.c
diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/basic/clk_fixed_rate.c
similarity index 100%
rename from drivers/clk/clk_fixed_rate.c
rename to drivers/clk/basic/clk_fixed_rate.c

-- 
2.51.0


