Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040B5C30653
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 09:43:59 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.22043.1719395032715594096
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Jun 2024 02:43:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=T9RWesII;
 spf=pass (domain: linaro.org, ip: 209.85.128.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4248ff53f04so22278215e9.0
        for <u-boot-amlogic@groups.io>; Wed, 26 Jun 2024 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719395031; x=1719999831; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKN1p1pamJhVTARy7UdKn6sH7uxhDkWsOL5N+6QzpG8=;
        b=T9RWesIIMCi6f0TuKVf1k7wJE668j/MDZOy+Oy8QOg937Eiis6hBCjlmWP+P81dYME
         bG5DBk9iCZIf6hMda+SwdqGP52wD8ojAyuLJmmQsvht0u4b0xXh4+JJAHwMgeax9DOFc
         D07tGENLiRqhANaiYoFBxkwDTKkQYKGg018BVEKHLiw2DhHoeolbCZtsZUG+xZBGbqv3
         RvrMs57l9DjIrB7FahXHY+9CwzJwG8jutPhCgjsQpAOZhJ88feDR9CZ7U0L30p5TB8GW
         iQ7xlv2gj43H9Ee8MIsD+ZCCNn5TsfY38ln4osWiZb/efvRKdtHuzMRp/cK2FnxdMUei
         vFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395031; x=1719999831;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKN1p1pamJhVTARy7UdKn6sH7uxhDkWsOL5N+6QzpG8=;
        b=WT7g3y5Dh0Kosh+nA5BkbaAJNaWSjtV89y1VtDWIqqw9fu0JN0ddT682ssc3vqsBmq
         /qGANaUTtdzqjVjp/ZwhuvOQQ6eNeRrRFEMC7UvGM6sQ9+0EdiSpsJQf7qkATG41xpTf
         BJT3F6N6WdHluYsLyHGf/70pwkrGIc+9Cm89r9UMumDoJ2W93+DQB4gdG4NV0mFo+9Sd
         bD1OtrTGQs/3d7mYnoFWwkTCFWrpFa+/QhsxE2LrUldcZxdJZnvhPvoN9ncwL2BeSeGX
         ZgRAWOsiA134b8k8MX0MLdmJoozWxDoVALytFEjO7uwyJtSzLEjZUeNUbo9RkXKIykVw
         nVHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXra3YgX9ia6UqKeCMnEJdy56YB8kjy8wH34EpnFeDtZJqhsJhUYgtbP25XjjdpJyYaURrGVyEkhBe9yGG6z8r44g65eQqoEhA=
X-Gm-Message-State: AOJu0YylWtCEyvgrNy6WPjWpM5G91AoiWrZWHRvZGVagKvgfM4pCB3IW
	2x+hbvhkOj7do8cYWrNw3oWT/88gK7z2L15DtefuN5786i6o56o0ACc80r73qzk=
X-Google-Smtp-Source: AGHT+IFLpNAmCIyiFsgMIXhxvp9bsVR0CgEPv4Ds8KG+cQyjGgV2OcXFpbYDUbYUy9kIQrEJEmM97g==
X-Received: by 2002:a05:600c:56cc:b0:421:7bed:5274 with SMTP id 5b1f17b1804b1-4248b95d0edmr84554065e9.10.1719395030498;
        Wed, 26 Jun 2024 02:43:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c84692c0sm18857175e9.43.2024.06.26.02.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:43:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
Subject: Re: [PATCH v2 0/5] usb: meson: switch to set_mode callback and
 other cleanup
Message-Id: <171939502981.2754394.12351884665745788367.b4-ty@linaro.org>
Date: Wed, 26 Jun 2024 11:43:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Jun 2024 09:43:58 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2329

Hi,

On Thu, 20 Jun 2024 09:42:49 +0200, Neil Armstrong wrote:
> Switch to set_mode callback now it's available and in the same
> time make public functions static and drop useless mach-meson
> headers that are no more needed.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/5] phy: meson-gxl-usb2: add set_mode callback
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e7265f62aa6bf20c9011d0848926d6206fdf7d51
[2/5] usb: dwc3: meson-gxl: switch to generic_phy_set_mode
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8c58c35048cb47a999c050aad9c6c9785fc5870e
[3/5] phy: meson-gxl-usb2: remove phy_meson_gxl_usb2_set_mode
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/affb461d9aa235d12075fbd943cb11e481ada79d
[4/5] usb: dwc3: meson-gxl: drop usb-gx.h and make dwc3_meson_gxl_force_mode static
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/98ce6d3e322c428f37e75956d316fb76479472ea
[5/5] usb: dwc3: meson-g12a: drop usb.h and make dwc3_meson_g12a_force_mode static
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/93b6a52f5a9754e3077c31590a7d5fcc2858d415

-- 
Neil


