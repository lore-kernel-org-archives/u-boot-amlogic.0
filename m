Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD09D767C8
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 10:32:58 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14197.1766140370008324271
 for <u-boot-amlogic@groups.io>;
 Fri, 19 Dec 2025 02:32:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=tyolTBrp;
 spf=pass (domain: linaro.org, ip: 209.85.128.47, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so9698535e9.3
        for <u-boot-amlogic@groups.io>; Fri, 19 Dec 2025 02:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766140368; x=1766745168; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWTpmjAkQnB5pDtjtyF4kzRBOmjFn5a0N6wX+RDlrK8=;
        b=tyolTBrpxdOZhaNxm2EywnFTV2iqqJZL7yDSac46EMBchwe1DetKRF0ycThr/Hn4gj
         yZXpiRXfYD9x6xbWN22gzudNT4wh5GN8nfvhTc7XgXcMGh700vrXYQ3j3X99jkrwnwmM
         TBUrvhsw90Ec98yhiFXBPPUQpgL5FI0tAmj/iPxj0KY2S8CniDC3wDurvyBfm7NEFr2P
         KYzpUvwcQdlBF7LX8jwyBYF22+7HbE5OKQBgrAPMc/Gg8f1EsuLw51IBeTKYtDDU+I18
         3VDbbm73CD1odLiIeiKh1eygKY/2+i5/zjnZv4PIR0lSBoSv8SiitZOdI4WItJu6yays
         o9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766140368; x=1766745168;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWTpmjAkQnB5pDtjtyF4kzRBOmjFn5a0N6wX+RDlrK8=;
        b=ZaQcE3MmwajipnO8sDsMMAs5OsvJkYocvMHuJC1H1PSaDxs0V/nNLjnTk/yw+o2slX
         eKRCfBRdRC5o2FQQCnDxfaK322+bLqxfUx91k8aCWMGoftnScCmwQQGYP14gOEAfDv5W
         D6It5yipSnlym+c1EAqHtZOSTlJ5xLkUmBtoRorh05Dq3iF3z3uL6jY/noGrU595fxZt
         fe98G4BUlChTItRkW+SU2cm9Ni50mDZZ18WuFPFhTEMuqaofTU9VX7Rq6OI8hNJJ3UCt
         YoXmFY5CMDpgXx1MFwyf6ZzK3SKY6vlkArC6+feXAYxw8Z0NoZPSjuPPWpu1ajTKzzLh
         mxPQ==
X-Gm-Message-State: AOJu0YyQzPo/FAVb9Mf8l9ZO7eWgFgx8rcfkwUkzJ/9pA6x6WeNZx5x4
	UgEJXup4B889Bs3/Um3jeFK0J1qILHmPdSaAu/QpkWsdrEveXSLFgTa6SEAMuixbSm3AB/xAP5e
	JzgcYI84=
X-Gm-Gg: AY/fxX6dArHUrUVkkrz8QfVxHZM30HNKG2qDblSgyncyEdAWe9PmSKezwa8nc1wI2M4
	E2j7tZ1OsUpCFwBCpvdUjOS/nsyEC1Bstus841PJRLoKxgNZOXKj9Aj4rBt6OvSDCHPp7pweqsC
	eb1uiG20R25MAi8K25CHTA19m1LvG1JQ2PEzdaFyD9uGsfyLjMr6+CHuuOHve54ntak7GSH5wic
	NsPouwNe+vfewecAQfJmOXaHg7R1R8Vxq51VVjO7u8dUNR6sNwhTuuh1YVGbGhdQO9hEiLIcgbF
	Ctj1btnOuR6+FIZpMwtcoOr4Q7+sLttKBYX8NGHQmasFQfV3y6UxRiluBwSPRvvkvEpHVwj1dTZ
	Xdz66aFUWGbhnwkLOIz6YHFPF89z2aKp1gfa1pcqZgMqPpWSD+wFS5G6POehYLln7VMQbRSJIK2
	oVmnvPRkWfVd17yEvFqWpFfDOy7Xi4IEcqJ2sRml9zStlA15lAVo2fuRourTXxgDw=
X-Google-Smtp-Source: AGHT+IHE3x8SDUiRwxNfGZ2qxjw3MfDuuQ3OajLsMDoA4xyQtRFUSxU5439dtxgqH7vAuZLJetWvrA==
X-Received: by 2002:a05:600c:35c4:b0:475:dd9a:f791 with SMTP id 5b1f17b1804b1-47d195869e7mr24528085e9.28.1766140368292;
        Fri, 19 Dec 2025 02:32:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:254d:4d6d:3f4e:5bd1? ([2a01:e0a:3d9:2080:254d:4d6d:3f4e:5bd1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a33c1csm36332845e9.1.2025.12.19.02.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 02:32:47 -0800 (PST)
Message-ID: <e151667a-9f5b-4baa-84b6-5a243ec88545@linaro.org>
Date: Fri, 19 Dec 2025 11:32:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20251219
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 19 Dec 2025 10:32:58 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2880

Hi Tom,

Here's a set of Amlogic changes, the principal change is the initial SPL implementation
for GX SoCs, ditching the vendor BL2 by an open source implementation.
Then a frequency lowering on the MMC driver and support for EFI capsules
update for all Amlogic boards.

Thanks,
Neil


The following changes since commit 66be03b7ee19444b23aae3990a434a7470fc1641:

   binman: blob_dtb: improve error message when SPL is not found (2025-12-10 13:45:29 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-next-20251219

for you to fetch changes up to 6e844dd4df6765e5e772b5606a675c16fe98d9ac:

   board: libre-computer: use common Amlogic EFI capsule support (2025-12-11 17:27:15 +0100)

----------------------------------------------------------------
- Add u-boot SPL support for GX SoCs
- meson_gx_mmc: reduce maximum frequency
- Add support for EFI capsule updates on all Amlogic boards

----------------------------------------------------------------
Ferass El Hafidi (11):
       mmc: meson_gx_mmc: add minimal non-DM driver
       serial: serial_meson: add minimal non-DM driver
       arm: meson: initial u-boot SPL support for GX SoCs
       arm: meson: spl: add support for SPL DRAM init
       arm: dts: meson: add meson-gxbb-u-boot.dtsi
       arm: dts: meson-gx-u-boot: add binman configuration for U-Boot SPL
       board: amlogic: add kconfig fragments for SPL
       spl: meson: set SPL max size for GX SoCs
       doc: board: amlogic: add u-boot-spl documentation
       arm: meson: add support for EFI capsule updates
       board: libre-computer: use common Amlogic EFI capsule support

Jonas Karlman (1):
       tools: mkimage: Add Amlogic Boot Image type

Nick Xie (1):
       mmc: meson_gx_mmc: reduce maximum frequency

  MAINTAINERS                                        |   1 +
  arch/arm/dts/meson-gx-u-boot.dtsi                  | 125 ++++++
  arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi        |   2 +-
  arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi      |   2 +-
  arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi       |   2 +-
  arch/arm/dts/meson-gxbb-p200-u-boot.dtsi           |   2 +-
  arch/arm/dts/meson-gxbb-p201-u-boot.dtsi           |   2 +-
  arch/arm/dts/meson-gxbb-u-boot.dtsi                |  27 ++
  arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi      |   2 +-
  arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi    |   2 +-
  arch/arm/dts/meson-gxl-u-boot.dtsi                 |  20 +
  arch/arm/include/asm/arch-meson/boot.h             |   2 +
  arch/arm/include/asm/arch-meson/clock-gx.h         |  14 +
  arch/arm/include/asm/arch-meson/dram-gx.h          | 341 +++++++++++++++++
  arch/arm/include/asm/arch-meson/dram-gxbb.h        | 168 +++++++++
  arch/arm/include/asm/arch-meson/dram-gxl.h         | 193 ++++++++++
  arch/arm/include/asm/arch-meson/dram-settings-gx.h | 296 +++++++++++++++
  arch/arm/include/asm/arch-meson/dram-timings-gx.h  | 117 ++++++
  arch/arm/include/asm/arch-meson/gx.h               |  41 ++
  arch/arm/mach-meson/Kconfig                        | 112 +++++-
  arch/arm/mach-meson/Makefile                       |  12 +-
  arch/arm/mach-meson/board-common.c                 |  16 +
  arch/arm/mach-meson/capsule.c                      |  61 +++
  arch/arm/mach-meson/dram-gx.c                      | 419 +++++++++++++++++++++
  arch/arm/mach-meson/dram-gxbb.c                    | 174 +++++++++
  arch/arm/mach-meson/dram-gxl.c                     | 167 ++++++++
  arch/arm/mach-meson/spl-gx.c                       | 168 +++++++++
  arch/arm/mach-meson/spl-gxbb.c                     | 113 ++++++
  arch/arm/mach-meson/spl-gxl.c                      |  39 ++
  arch/arm/mach-meson/spl.c                          | 123 ++++++
  board/amlogic/p200/spl-odroid-c2.config            |  38 ++
  board/amlogic/p200/spl-videostrong-kii-pro.config  |  39 ++
  board/amlogic/p212/spl-libretech-cc-1gb.config     |  36 ++
  board/amlogic/p212/spl-libretech-cc-2gb.config     |  38 ++
  board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   |  14 -
  board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   |  13 -
  board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c |  14 -
  boot/image.c                                       |   1 +
  common/spl/Kconfig                                 |   1 +
  doc/board/amlogic/index.rst                        |   1 +
  doc/board/amlogic/pre-generated-fip.rst            |   9 +
  doc/board/amlogic/spl.rst                          |  77 ++++
  drivers/mmc/meson_gx_mmc.c                         |  79 +++-
  drivers/serial/serial.c                            |   2 +
  drivers/serial/serial_meson.c                      | 119 +++++-
  include/image.h                                    |   1 +
  tools/Makefile                                     |   1 +
  tools/amlimage.c                                   | 255 +++++++++++++
  48 files changed, 3449 insertions(+), 52 deletions(-)
  create mode 100644 arch/arm/dts/meson-gxbb-u-boot.dtsi
  create mode 100644 arch/arm/include/asm/arch-meson/dram-gx.h
  create mode 100644 arch/arm/include/asm/arch-meson/dram-gxbb.h
  create mode 100644 arch/arm/include/asm/arch-meson/dram-gxl.h
  create mode 100644 arch/arm/include/asm/arch-meson/dram-settings-gx.h
  create mode 100644 arch/arm/include/asm/arch-meson/dram-timings-gx.h
  create mode 100644 arch/arm/mach-meson/capsule.c
  create mode 100644 arch/arm/mach-meson/dram-gx.c
  create mode 100644 arch/arm/mach-meson/dram-gxbb.c
  create mode 100644 arch/arm/mach-meson/dram-gxl.c
  create mode 100644 arch/arm/mach-meson/spl-gx.c
  create mode 100644 arch/arm/mach-meson/spl-gxbb.c
  create mode 100644 arch/arm/mach-meson/spl-gxl.c
  create mode 100644 arch/arm/mach-meson/spl.c
  create mode 100644 board/amlogic/p200/spl-odroid-c2.config
  create mode 100644 board/amlogic/p200/spl-videostrong-kii-pro.config
  create mode 100644 board/amlogic/p212/spl-libretech-cc-1gb.config
  create mode 100644 board/amlogic/p212/spl-libretech-cc-2gb.config
  create mode 100644 doc/board/amlogic/spl.rst
  create mode 100644 tools/amlimage.c

