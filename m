Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C1ACA600B
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:30 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14770.1791463580666127975
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Oct 2026 05:46:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=uONkXjKT;
 spf=pass (domain: linaro.org, ip: 209.85.128.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so43471505e9.3
        for <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791463579; x=1792068379; darn=groups.io;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m2DYDcyD3iuTeZZpAR3lJYMkmDOPAmfxwTJe4niqzlg=;
        b=uONkXjKTAVnr6vjxWJOgXXXudTuJ1JUv/7BagJCHxgiBiL1Fi3Rsf5R/wDD3E8Mvnh
         FQ+QaF2Evc90z/ctGMWfGZVxMdV8G8WnIBlIlTezn2iVQ+8VxqYjVukWGlijS3wRBuf5
         UKfb/AkVkmC7GgO6LX+vlQtlplE1+omROMsT4qbBFUCbKtzqbADzmegOsMOLVwSxrG3c
         N+15AInCbrskf1cguZOr58ewpLIeQFlsE5Tk4m43r1ecV31RGfSDfbhtH/3A0gBLqHSw
         3MH3F+JZrIZph64e+7iaOP8TvSKxqWUvTugwT58JC7Dmd3T4wwLQDnHHn+t2w12xyp2g
         uKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463579; x=1792068379;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2DYDcyD3iuTeZZpAR3lJYMkmDOPAmfxwTJe4niqzlg=;
        b=bPSVDe4uPGVuhRf68TjUt5HoWY2nhnmR7VxWFUVFLxyQ9yDXMUVNOcTXmXcJP9GVV2
         e3nVWRkDCpq76OyVeENCk4/Aq+OvojYcCnyL2DLZiLsNsCexiMa6XdIHvvGQuWB4V7WP
         BbwGnIPTsZzbHcSUoXM9kw0VFc7xKDU/QcwX278lC7PZL/RmXutTqEQTBlQWpuFfmJe1
         Q492PpmujR7iT57I8SPk5lwNoKH3xA7J8IAXNqGiHURQw0gmgjAfLR5nOre3V3a3Aapb
         ZxKcIo03+s+r1ePJRodzMV6z0w4vdr7cqbNCtxPH3/yj2j2omvRLeMI/h1nJWxidZF/Z
         MYlQ==
X-Gm-Message-State: AFuF++mj/Y8sccGmpXbhW+nxM2kqvKzRQYKUAOoR1nC5EkfXqUvQDVWp
	kAEd8YYI/GMHcSAWKPjhYfa/+joCysaoUVp2b8CJTRNaJep7cxsDdEYEBS+trqAA7pk=
X-Gm-Gg: AYBFou1xqDwuxn21snswqFmBM0dtFeORtfo8xtSTe6KsB1BygUvP7E9Ra0XYp1lwLmq
	5qQNKKW94I5EK3WjNsdd4MPHxx1X6MxRHLoltFBWdx3geJfBYDgVuBkr+G3ToLlR+5tU4i+x8VS
	04r8aILZte1zTyeWY9vGSpiUJ/Ro/74CGrHq3ik8tC/+Nyca4MFvBuAGVTpA5MFmU4DxXozsPEI
	zsKl60Aha/JwHSFiTj2oISaQR3xg/3zonIJmsGiKrXrSrCiiNOvn4dXVLj7Ud2HpFstLvogC08b
	ufYM7uWmdxrtoqw4dQyVFV7yTa8W+AkaOwZr7cXBpCIaGV923aGtrvB7pigTZtzrW00lQ6XlRBI
	tUyXx/Uo8ykZnlMO3eQqoZ3qiPSwO8dwrM+1Z6kAZBhI11v4Wixu5xMuzYP8Ad/XV4an/EIxI6u
	unlZESQxdhepBB9hMrNZ7vix2nb1snqMIn7KV7RlMMrWGpftqo2Z4bhNMsqPeNllfCOnYkUHQPr
	GvUzJ6dArpwTFutuNcR
X-Received: by 2002:a05:600c:8116:b0:4a0:108:3b48 with SMTP id 5b1f17b1804b1-4a18030428cmr95668255e9.7.1791463578630;
        Thu, 08 Oct 2026 05:46:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:46:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>
In-Reply-To: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
Subject: Re: [PATCH 0/4] configs: khadas-vim3: refresh Android support
Message-Id: <179146357781.183177.17223915816731601716.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 12:46:30 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3123

Hi,

On Fri, 25 Sep 2026 15:42:23 +0200, Guillaume La Roque wrote:
> Update VIM3 and VIM3L Android support to match the Android 16 AOSP
> A/B images used by these Khadas development boards. Remove the unused
> non-A/B defconfigs, increase the fastboot buffer to 512 MiB, update the
> partition layout and correct the DTB indices in vendor_boot.
> 
> The layout follows the AOSP generic boot and vendor_boot model:
> https://source.android.com/docs/core/architecture/partitions/generic-boot
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/4] configs: khadas-vim3: drop non-A/B Android defconfigs
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a2d0134bfc140b9b2092ab09cfef37a7da7c51ac
[2/4] configs: khadas-vim3: enlarge the fastboot buffer
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/349d13ce42f60dba1604accc3abb24d5f6afeb18
[3/4] configs: khadas-vim3: update the Android partition layout
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/09aee880eea6cf05e117988da1be8231b07c5bc0
[4/4] configs: khadas-vim3: fix the Android DTB index
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7a403d3db56db9f1efba44ed145e875c23fb785d

-- 
Neil


