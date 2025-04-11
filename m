Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57BFC369AE
	for <webhook@archiver.kernel.org>; Fri, 11 Apr 2025 14:55:41 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.28417.1744383335414888595
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Apr 2025 07:55:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=NcFFfHZr;
 spf=pass (domain: linaro.org, ip: 209.85.221.52, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso1261774f8f.0
        for <u-boot-amlogic@groups.io>; Fri, 11 Apr 2025 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744383334; x=1744988134; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1yF/wHQWcgbug6MjKme3HBljHMVNFih9QiwQnDpYAM=;
        b=NcFFfHZre+tnDUDtpOGW6LB47mG5Y7H062bzkIV1vjh4rbwgoRB2/9w63ni+OB6Yt8
         Ezm97ifCxIbwPaJ79qZsTkLLayfm682f31btidxwXr1IrqstMyejLzCsEvIoeXehzQhV
         oK+6gvPp0yEu7KafoKGm0DHOsyjc097lH2xixmElH5TfjcHJGMkW3e6nn5wFRTdF2DMr
         m1cAHklbIoa+ZI+0sl7lPsd/4XTPMmCTW6JPr/BLzgxSjM8hVSq6svUX2n0TqKd5ZtKl
         ckr565vgjAHOZW13RezKkim4BTFPqboeCJgjmEXIb77Lo7LipN8HoYrUK2pXZC+vM46o
         doZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744383334; x=1744988134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1yF/wHQWcgbug6MjKme3HBljHMVNFih9QiwQnDpYAM=;
        b=TimPFfPpzMRzccMHz3uf2L7CzmRhdl9cnR2amRc+geMO25LWKnJ/V7WyCX0gybTwOG
         4xcuw7HDFgrovfn+I+ByZjeEnH8keHLTPmPAh95FrPp+8+CVWB6E9jiwTovFxvsQP94M
         Ru+j/v+mYBNxPI6AfcCVJkavKdeLCzZmf8z+n4QBdiXfXGkAxBCBt1u1TF4l6xeivYGV
         So3VXrjtkO6cYNSznpDJ2vjUMiegvgdQ6hXT+nc2b1XskuT9lPd912Qj7LDOYi/wnr/9
         kgu89zfGduB7xXqFIltfoSIMuxMzun7Bk0NOYuBhZRXfiu/YWvYai9pNka6G5L+vftvM
         u7MQ==
X-Gm-Message-State: AOJu0Yy3BrQAvtJzAceY9vePMrz9jUakRIRSMmRrl+dYHccuywZHPirw
	H98wB3txfWNuBRYny78EaEgcOdx2QdSOBlONA4RocCdXKN705PAa9l6StDY6mmrpD5PEYmRTROx
	M
X-Gm-Gg: ASbGnctld6SoknCFe5FSdYMxQuGY7cgs3ZEihwP7ocsAA8qmrFmASGYvuTlhcpPkdVg
	xK+HST6di7v4FzSsnA7XCjASG3QH7WnDo7Qt6+Yz4NEmOpk+KlA48W79vp8MlaLwYMmXSfD5gO4
	vDIm5SP1dDWkhGv1kmtD2+CgfGlFgbsV08iwMgwi1H0hPkH68N4r+BpJS6kUEFQoXURPcwCep7h
	WBiDX4OqrUzlbFeariYINPQf2M9YY3fnAj6gyUhPxkOXj9oMxWDiVqWncd8os8IbjbjakaIRXBW
	RoGPUXfW93nvOwqReLZ/2K5DQjU+2i0Ps9G6jPEIPmklh9INW9EuOXWPcgBDSA==
X-Google-Smtp-Source: AGHT+IFjIf/8nwdAdGUu2gCTUJ2UI9ep7vra6M6UsoDHghSw6BXCChT94UhcXyBv3SPIgWGcRXupqQ==
X-Received: by 2002:a05:6000:144f:b0:39d:724f:a8cd with SMTP id ffacd0b85a97d-39eaaea6819mr3002957f8f.35.1744383333780;
        Fri, 11 Apr 2025 07:55:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eadda64ecsm2279119f8f.0.2025.04.11.07.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 07:55:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 11 Apr 2025 16:55:31 +0200
Subject: [PATCH 2/2] ARM: mach-meson: use livetree by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-u-boot-meson-livetree-v1-2-ebe31909cba5@linaro.org>
References: <20250411-u-boot-meson-livetree-v1-0-ebe31909cba5@linaro.org>
In-Reply-To: <20250411-u-boot-meson-livetree-v1-0-ebe31909cba5@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=702;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=eaNAaSCSSQ7imWYnetLb4wl500/wRcYjbd6Y9zLhhBY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn+S1jy0t+bwPwh4VtwaIYIHDHtLtL76yUIvBFqe7I
 ngaQ1f2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/ktYwAKCRB33NvayMhJ0RluEA
 CTAKb/9dekoH2JirX/qzfjw9fP5Mee6tEDeAZPCetaGLzu/VdLUD29/zOoFwT+qMNoyM0E8Z7dL3kM
 MaF7trG+pd1okg5WW2wE9OS8ddzbQKh9llVStK3CNrlUSoDyX7hdBKF4AocmwWOSHzEHkqkyXuG0kh
 Jw0jAC1ooJD3dZw5sIzNrfwZsBjyc+NQRtkuFPvOqoXu+nXRLcywm0EGeyWJ1qrd/1ykW6KSOmKWAS
 h11ornsrtqYMnq8OERwJR0oXxdakfh0UtwX0CfvY+OQI+WBO7EgTkW/aEVi3fQA13KTm2z5rx6k5CV
 hKO9WaWAC3HBp2ZOvopMap28AVKQgAQdsSyTumbSSCkIuo1tEMWNp958JsB58KzSdZR4V5Hgi/nDxR
 GpV0iigHIEKC1e3yVa0cvoySpFqv/gsoJfeEf9LV+37ugA6bNCUMZLllf5QVQqNbJNS3thCa5wF4yl
 hHliGtBpLU2TRFu5Vz26kFjqTzNW2FLgAmyQC4N7APT40TF33nrLOAH7yGGcX8T4VS6jhhyOoCZ4dT
 o/WB8NGvZVMiw/4KZwc+GGyAtT6NM/RoNT1GhXh0Q3bjfBRGzhxJEa9rrDzSkyoLPUgXDRNkrQ88xE
 V0H+E52bJs+oN7x7Q4U+9lccqRVKyOseMAAge47Dc/krUA3+SGAOvdy46yxw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 11 Apr 2025 14:55:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2663

Finally enable OF_LIVE by default on the Amlogic support,
this add some cost to build the live tree, but makes DT
parsing from driver much faster.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 7570f48e25fe477ce4dfb1eb608ed07b3a83d27f..10cef2ad6623180e2ff1ed2802543f3ba0714bd3 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -12,6 +12,7 @@ config MESON64_COMMON
 	select MMC_PWRSEQ
 	select BOARD_LATE_INIT
 	select MESON_SM
+	imply OF_LIVE
 	imply CMD_DM
 
 config MESON_GX

-- 
2.34.1


