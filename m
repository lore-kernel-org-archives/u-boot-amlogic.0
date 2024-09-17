Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C24C3601A
	for <webhook@archiver.kernel.org>; Tue, 17 Sep 2024 12:34:59 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.19666.1726576491823318496
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Sep 2024 05:34:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=eCqDvelB;
 spf=pass (domain: linaro.org, ip: 209.85.221.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so3348896f8f.0
        for <u-boot-amlogic@groups.io>; Tue, 17 Sep 2024 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726576490; x=1727181290; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YfrbN8vASUjkWF2dEM56z/vKD6459G2JSploWPqdNow=;
        b=eCqDvelBDNFWwcF6tC6SMI8S3y2o3ArZ6nauXZ2+ZTeIm2dYzxhos0GpF/fQwMmLD2
         Itxt4JmcEKk2VxY4ifbFMEw8D8J7uvpSWhE0vl1AJK/GnOL/d4GnpoQIDOYx4a+k3YhN
         EcswtZwhhaziwKeZhJTZZ7ov2V4BgZ+zaFasmXI/negKntINuZYU4YDST+tSvKmPowHT
         w8DIjzLLTnazm94MoDoKWu4J+0LXyMDjdY99HizkzG1jBA7rgNld3+vL+kFW5vn3MXOE
         E1qB/EdxPzavJMW9OLIRTVElZGe3n0d5nSTXwmWDmWk98jDHk5Kas6fDHUPkvU4Zpi9t
         MfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726576490; x=1727181290;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfrbN8vASUjkWF2dEM56z/vKD6459G2JSploWPqdNow=;
        b=UdOImT8jhDAx2gtwVNm0byBE0ZH+8Q9FvgVhfvWKYxX2ZQhwow9awMt9wnmjHBG0Sa
         2aCGkpRqZWxZXtcYullI9uiFqx2uV9wUKT6qTFKPUxMWnxTPniNLX63FE/IG8+tsVSKA
         XurUpUOob3Qklk6ax8Q6L+TMf91fPaSMSHgK0moSjdCPUv6hYpzIcWRPUmSeg0wjqq0r
         GAJh6oSXt8bdryuzNNcDW6yU0wgpehgN7It7H+uh8gbK96w8FRKSUpPP+z6S4+QsdzEd
         ZfK7BSHWFw/hsea8MYAD/xUMC02tn+xAJADJkl2X8Vl119zawAN5lhWhFFOvZlQu742Y
         Kqlw==
X-Gm-Message-State: AOJu0YxjuifywrE3RAhOXFO4IHA8QtqRUZvk4Y2rJKaX5Plrfso1MT+K
	p2TAK90GM53RUY2eBg7oG6HcVhGEkw+ybgF75XyOmWK6KDoCq5C4apIdUel+vlUbuSFRWYI5FnH
	a
X-Google-Smtp-Source: AGHT+IFMuFng77D/cZfPmSyNuXa4G6MQpGK+33/1CywKPuvq1zJ4rvZBzvFxj8y+bzKRVxl+9xttYA==
X-Received: by 2002:a5d:6189:0:b0:36b:a2bb:b374 with SMTP id ffacd0b85a97d-378c2d61762mr10938211f8f.52.1726576489865;
        Tue, 17 Sep 2024 05:34:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm9381772f8f.30.2024.09.17.05.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 05:34:48 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] ARM: meson: libretech-ac: add support for EFI
 Capsules Update
Date: Tue, 17 Sep 2024 14:34:44 +0200
Message-Id: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGR36WYC/42NTQ6CMBCFr0Jm7Zi2lh9deQ/DokKBSbRDWkokp
 He3cgJXL99L3vd2CNaTDXArdvB2pUDsMqhTAd1k3GiR+syghNLiKiuM+GRecOGZOuw3Z945Y6Q
 eTVPLTpXqUhkNeT97O9DncD/azBOFhf12XK3y1/5jXSUKrK0edFNqZcRwf5Ezns/sR2hTSl9Sz
 lFlwwAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vGG/LVK+m0FKjCCckEJIYd6d4ixfOd/bhBYuFa9jBc8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm6XdnllfzrUrSFt71eboFPj1eTHUNlvc5s1Co3mdU
 KaftkZWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZul3ZwAKCRB33NvayMhJ0TCVD/
 0bFw5XlwQUj76AAHTZlRUaVEcbpdRZ1FJ9+hgscBU6f+NTNcukEta3/umLaiNjssM3LBp6zB6XCCN7
 7v0gIBEX6HJ4OO/rJQOkZmEZoP9oo8CHuZ6nNBZp5XwzgFxV1/TfBL5OJl9jrhKi5zlhiTR3WRClMh
 2OTI2g0ysv31FDtGsjMjnFzWapYU4eSZuSPK3igGZ5u8BBi84aItPuiYHtPTefUZcXhltZi57WASIk
 Ld6sFDR4qGvLQM8XIBDfEmBZ4/68TJGLD4JWiWUmgx8Y6sBAWpvmfQ/vA9CifTHS9g4maTO4bvP92A
 WR21WBpcFygva2OoGGm/P9IRMOq7AB4PTvOCOZiRYLnfLZD5/KI28wR2WGvQwoWezkTtmLrAntDnC6
 +qq7IlpuIGQAkZrjDM8hUB2T12DGJjx3WJLbFbNaniGDm0XUEhnceSUf7/B3uZDzxfWVEW2i07hAnS
 oQS5eMgvh4DCIJQCTbJEXzHMWxvQlq+GDzH9gvulBf9WMEzeveZFL1HVO97csSrKN2iHbm/YHTo69I
 lVGlpv+Zz9qGY8iDiOVTwQMA9oZ75PFkMvYENjjQVW/DDg73jYQRNQrMAOXIXX84vm0+/sH/mQ5J9D
 5ELL2QTXKqdmNmpDXzrxFv2uk35hM65JwX1ztyDdx8quiMNsZ4DIaAlIc/Xg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Sep 2024 12:34:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2391

The necessary changes were made in U-Boot to easily support
EFI Capsules Update and be compliant with Arm SystemReady IR.

Let's add support for the libretech-ac/AML-S805X-CC since
it's an easy well-supported target having a dedicated SPI
Flash to store U-Boot.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Add set_dfu_alt_info() + CONFIG_SET_DFU_ALT_INFO to support both RAM and SF DFU backend
- Fix typo in cover letter and commit message
- Link to v1: https://lore.kernel.org/r/20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org

---
Neil Armstrong (2):
      board: libretech-ac: move board support into dedicated directory
      board: libre-computer: aml-s805x-cc: Enable capsule updates

 board/amlogic/p212/MAINTAINERS                   |  2 -
 board/libre-computer/aml-s805x-ac/MAINTAINERS    |  8 +++
 board/libre-computer/aml-s805x-ac/Makefile       |  6 ++
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c | 71 ++++++++++++++++++++++++
 configs/libretech-ac_defconfig                   |  8 +++
 5 files changed, 93 insertions(+), 2 deletions(-)
---
base-commit: df84c019c46e6833cc79385bdb23efba4882c09d
change-id: 20240916-u-boot-topic-dynamic-uuid-a871c25236a4

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


