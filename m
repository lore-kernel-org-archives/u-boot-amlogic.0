Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.9804.1678177222457139509
 for <u-boot-amlogic@groups.io>;
 Tue, 07 Mar 2023 00:20:27 -0800
Received: by mail-wr1-f53.google.com with SMTP id bw19so11227673wrb.13
        for <u-boot-amlogic@groups.io>; Tue, 07 Mar 2023 00:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678177226;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8IY//EFR9Naxv4UZVVC/BSwaqu/lDvK2UCnXVDE65eI=;
        b=Zqyd+oHg3eXRUPfzj5cx2NrS89wgaR7YE2R1J10qmtG3LRVkb8YDSnQIcJoAjLJud+
         QwHlBGdrdJlmIgejojn2Z7gWFcs4pa0DsfuQLAyFZCZs7gYeDlJdpdfKLeEOPKfkTOsY
         JTilCCvZMXJmrwoXA/Nmr8iHv1SOdehsWo9pMbYSc5aAuB+Np5DInp+wZKX58TABtOXN
         ZhHFop0v1dJrDwD52CmZQA1MQ5odj/1keFXXb8m0P4MowDy+2h42tauy1PpCKuW+cuyD
         l5pzDtnhuffpm1eHUuHWVkrker0ME9tpODKaKFcP1pQdtGZNm9kXGZ/Ri8TzaWJ7lSR7
         1wNw==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] ARM: meson: Add initial support for BPI-CM4 module with BPI-CM4IO baseboard
Date: Tue, 07 Mar 2023 09:20:23 +0100
Message-Id: <20230307-u-boot-cm4-v1-0-43f5a393cd37@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

Add support for both the BananaPi BPI-CM4 module and the BananaPi
baseboard which is compatible with the RaspberryPi CM4IO baseboard.
                                                                                            
The BananaPi BPI-CM4 module follows the CM4 specifications at [1],
but with a single HDMI port and a single DSI output.

The current CM4IO baseboard DT should work fine on the Raspberry CM4
baseboard and other derivatives baseboards, but proper DT should
be written for other baseboards.

The DT is imported from the submission done at [2] and applied
at [3].

[1] https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf
[2] https://lore.kernel.org/all/20230303-topic-amlogic-upstream-bpi-cm4-v2-0-2ecfde76fc4d@linaro.org/
[3] https://git.kernel.org/amlogic/c/0262f2736978b1763363224698f47112a148dab0

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      ARM: dts: import initial DT for BPI-CM4 module with BPI-CM4IO baseboard
      ARM: meson: Add initial support for BPI-CM4 module with BPI-CM4IO baseboard

 arch/arm/dts/Makefile                              |   1 +
 .../dts/meson-g12b-bananapi-cm4-cm4io-u-boot.dtsi  |   6 +
 arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     | 165 +++++++++
 arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          | 388 +++++++++++++++++++++
 board/amlogic/u200/MAINTAINERS                     |   1 +
 configs/bananapi-cm4-cm4io_defconfig               |  84 +++++
 doc/board/amlogic/index.rst                        |   1 +
 7 files changed, 646 insertions(+)
---
base-commit: b08ffdffdce95e267e782366f4a77bf6b5537b28
change-id: 20230307-u-boot-cm4-1311815d8371

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

