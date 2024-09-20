Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AE9C78840
	for <webhook@archiver.kernel.org>; Fri, 20 Sep 2024 13:33:40 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.18320.1726839217609849348
 for <u-boot-amlogic@groups.io>;
 Fri, 20 Sep 2024 06:33:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=UnKK79oI;
 spf=pass (domain: linaro.org, ip: 209.85.221.50, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c3400367so1715487f8f.2
        for <u-boot-amlogic@groups.io>; Fri, 20 Sep 2024 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726839216; x=1727444016; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3CQmp5rTf5JfydKUrzy5y9iSMm/1Tp3tWu6uADAXtA4=;
        b=UnKK79oIvmlkxfy2XGAJrKgIO1wh1wFlHlQ577LjQ/vqCFict+WgEywGSakSeSHQ7d
         6jR9o1UfRvN2x1Q1TLoX1wgly+ZUQECBcdPyWBl5jhDHTGKlMxRr0xQEE9EddVNTwHMc
         ZsVksnPh2nO6OqXq3stLDC1VmuQ8vJU27lLLRBjN7PRdwwPbeEW2Unqic+DldsZqCfxf
         h86TM7N5ONlfmBKwwgPMMJXRucVScCw5VEt/qhxJv9EdP5Ub/DvRc2qMETBlciUOnIp4
         FtFWKzCieoREfJ8nQiY9l2J1LHn7fPYlMgIr0Ak12b7XDZqW9VRARyqjA4c41kngqOMG
         Twqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726839216; x=1727444016;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CQmp5rTf5JfydKUrzy5y9iSMm/1Tp3tWu6uADAXtA4=;
        b=wySg31s1P6UPTXWq1txmSr3CO+VLre0/XEq5vo/1bNzUzJaqHlEDOW46bSPDH+0qNm
         AIT3QiDYSdgunH89EJoxbC8Wxv9bs+jbFPAEMAdlxVc7pd34vsz6nJs4fosCS/du3Uvb
         npsSYnvyZI05wYphuZNd2GyeO/FOqy7b8J+MXg7Txy3fxTpH0n82m+zALtp8jwo637qp
         DEXEfOSAB/nfcMRVM7D7w1AHzng3RJ29BDpxyW7ckBVxCtHKTSer5nxibmbUUoOFv/Vz
         1G5ngnztDC6kjCCEnr1QhdPQmcUUUdrXdg+HHarUjDS136j0LuxsPfsAoLcPEyAKW5VL
         YFLg==
X-Gm-Message-State: AOJu0Yy9F1YgZGFA8XYbcHzRpZg3nKUg++6DUn4HOZPslXuXiW1es+rV
	sawAvRnwh7ZGagNqxdnOemPDXoJ/hRBFB/ALizQbwC3F9NABTk/69dpFT6rIUMk=
X-Google-Smtp-Source: AGHT+IELL5PH0PqziF5qaol1CTjQ7Li2h9il2aCOJGaxVbXB5PI+gXYe0q4UOlGnjsyeomHv1sHf9A==
X-Received: by 2002:adf:f64e:0:b0:371:8dd3:27c8 with SMTP id ffacd0b85a97d-37a42279eb8mr2553295f8f.23.1726839215966;
        Fri, 20 Sep 2024 06:33:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780df0bsm17557466f8f.113.2024.09.20.06.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 06:33:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] board: libre-computer: Add support for Libre Computer
 aml-a311d-cc & aml-s905d3-cc boards
Date: Fri, 20 Sep 2024 15:33:32 +0200
Message-Id: <20240920-u-boot-topic-libre-computer-solitude-alta-v1-0-8915b108840b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKx57WYC/x3NTQoCMQxA4asMWRvoRBH0KuKiPxkN1Elp00EY5
 u4Wl9/mvR0aV+EG92mHyps00XVgPk0Q3359MUoaBnJ0cTdy2DGoGpoWiZglVMaon9KNKzbNYj0
 x+mwe4zkQxZDma1pg9ErlRb7/1+N5HD9pwPCqewAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, da@libre.computer, 
 ilias.apalodimas@linaro.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1876;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gVVDXiJfDUHHjtzCGVBdK/yhT7uyR5jH1lyx3aGkQY0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7XmtXNU6dECUh6p1DX/JjgUYfejmtORjt5ZBUxXh
 2NarrEuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu15rQAKCRB33NvayMhJ0c2JEA
 DJL4vVfgQe5qQXeBeheddd1/OAErNutHE0bHkNCmCTooEZVbtqeY2ERN44hRH+UsZVy1hOEiKMEelU
 YctU3Ypof52EOlhHJbpxyq+haLtZdvy5lWl5zS/cePJCBkXfnTO+ZCHRqEBkU2yabcBslnVYGHzrIx
 TaspPaTZyVyHrVNdjWbqNT4JEsK3BPllp7JSevhQ1Nm7GvU2aqVtpddSu5wvFYJqL+UWljLFTcBqTy
 erT0lbQXvSpuXFuosuBN0ZV+V/o5pOjbhtkmTAh1wGD3IqeiHQqblRuWBp3G4v3Awo43/S6lWgynku
 l3RXQf2VE+qeiG9VS5QK3BBdzdYZ9jSFSl1lt68RkJRQAzzQiUf3toJ3IVOo/PubfUPe/RsloWSN6r
 67mXp2/yzOEe7gQpXqs4sf7UhSDuyufns9qk6133plTJ+AUuFRDi+WAZ/opuUNfAz2rwUjl+cGT7OX
 czTvGa064NHukLMLnhhw/ZnfVrVdT8stD52ioR0NMZSny3R0X1lLqitr48aiM5L9WdGacPN5tVN7dL
 pN5knylN3h0TB8MctvmUfgULK/61BdBbi5nob8HgV5bHTOzNcQXXNfOLv2hlzIOOhWR5G1Wq+c/3DH
 j/7caCB1apoHPDC88ZglKa3mIjfkjVnCj+b3+juebna/eZGZlIfUNVM3idVA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Sep 2024 13:33:40 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2400

Add support for the Libre Computer aml-a311d-cc "Alta" & aml-s905d3-cc
"Solitude" boards:
https://libre.computer/products/aml-a311d-cc/
https://libre.computer/products/aml-s905d3-cc/

The Alta & Solitude boards have a Credit Card form factor, similar to the
the previous "Le Potato" card, but with the Amlogic A311D or S903D3 SoCS,
MIPI DSI and CSI connectors. PoE header and a single USB2 Type-C
connector replacing the microUSB one for power and USB 2.0.

The boards have an embedded SPI NOR flash, and EFI Capsule support
is added.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      ARM: meson: add support for Libre Computer aml-a311d-cc
      ARM: meson: add support for Libre Computer aml-s905d3-cc

 .../dts/meson-g12b-a311d-libretech-cc-u-boot.dtsi  |  15 +++
 .../dts/meson-sm1-s905d3-libretech-cc-u-boot.dtsi  |  15 +++
 board/libre-computer/aml-a311d-cc/MAINTAINERS      |   7 ++
 board/libre-computer/aml-a311d-cc/Makefile         |   6 ++
 board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   |  44 +++++++++
 board/libre-computer/aml-s905d3-cc/MAINTAINERS     |   7 ++
 board/libre-computer/aml-s905d3-cc/Makefile        |   6 ++
 board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c |  44 +++++++++
 configs/aml-a311d-cc_defconfig                     | 108 +++++++++++++++++++++
 configs/aml-s905d3-cc_defconfig                    | 108 +++++++++++++++++++++
 doc/board/amlogic/aml-a311d-cc.rst                 |  46 +++++++++
 doc/board/amlogic/aml-s905d3-cc.rst                |  46 +++++++++
 doc/board/amlogic/index.rst                        |   2 +
 13 files changed, 454 insertions(+)
---
base-commit: 13fd7a17858e5f2555a1d68e4afa75fceda0dac0
change-id: 20240920-u-boot-topic-libre-computer-solitude-alta-c3b22cbd16df

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


