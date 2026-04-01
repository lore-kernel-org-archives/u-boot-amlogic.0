Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A262B10F6FD6
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 15:01:53 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14776.1775054465041770614
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Apr 2026 07:41:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=dZeZALPi;
 spf=pass (domain: linaro.org, ip: 209.85.221.52, mailfrom: casey.connolly@linaro.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so2936633f8f.1
        for <u-boot-amlogic@groups.io>; Wed, 01 Apr 2026 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775054463; x=1775659263; darn=groups.io;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kiFy/LHtGuPGsRTHUoKi+/IH9ZdGrs4QupreFkSBxTg=;
        b=dZeZALPi9/9Hr2sZc29F1QrVJYNETGTZtOCed41/2R7hDIYbnNTdF2uDzNr2x3vBLI
         Zkoy6ye5uNsWNusEvFviIpCRQ1c6QEwbXwbsD2w95hTWhMd7ztumaSaPAlEYcGbYWpD9
         07DGH6NmWeR/rEykIpdyWgH0ni5KnmOphqgEeGSuSb4K7o7A/vRE/xRiz7KBwpbxyWVA
         Z6xJ485j9dIIxEesNEaGFZqN5Ldb3cMbxkqtHhDxCUQnJkQbiVHgXIwtK6bHj+j7JuA7
         B+IsPLVtKoKi9hf8jkBA2q9qza2IORNUGMAwvVhCfHlmXUf2WI0aJVsU50aO0tRIP/7L
         SptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775054463; x=1775659263;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiFy/LHtGuPGsRTHUoKi+/IH9ZdGrs4QupreFkSBxTg=;
        b=LeRSozdz/YloxXEbOo/2BzMrGAi0SirHaqClq7R4p4Vwq/A460x4dMXEkgPhC8HgsK
         ucZkSsPn3P/6IRBvxvqSMBvhr8k/88i0ca002R38fsNssrPRofEB3ewgtYocd7NU6Bs9
         BN8NOb3VBQ/61g+1G0yggWgCfp/U6Jph9/Nmb1ak+qPd6764d8VePzsgoCjjQV8gwStu
         0jkbTzMUQyj/W5Q7F3VNJpPkhdcZ4jUMJ6ouifut2JaxhzQICmc6i+smRYSiIJZ2SELa
         KweseGSOltTCSABa+DiJIOZoaE2f/U2vloq9jsZLrqBtUrPkB1LizL88FFc2tP8tda6I
         ZUHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW57vdZNjk68UKoF8mAct40ibuaA2tIbIjoaoAQOZEEm8D+aDpnbjGmCy+IcHR7/psmJL5YI9z7CO9iWNtq8Q==@groups.io
X-Gm-Message-State: AOJu0Yxcp1KH4C2qxJpVx2uuiq2Coeo7OL6HkUu8kFCjtt7JN8x5UvCr
	pW/2y12WxVr21ri47D7L2vnRgTmEAo5zDmh69vg7aKmpNh9H7YLf2Mh6CcnRI2AGl9UUkv6zQbs
	/YvYInwY=
X-Gm-Gg: ATEYQzxjvibLJu/R3968sye32RSIXq58Ah9rCOk/QiP6WDWfj9u8Ns+hx+23VChjp7+
	/CdL2fXeT9rrOtyVwoJ9OktHOUCA6MTn+I5detQSsQxePKoiso235FeQI7xu0XgAJfcArWbXVck
	JzEQZkgpA0X2py7M0Q+BbTL/vMgjkCUlOwmjLxdur77Q76fgQb53N7qzX6DulA6hhMmu3Yhq9Ts
	zZ3Rzj38LvpsrbQ6kwOQelh/FtK01uIhdDuHI43v5ga5MT/5QGg0e7TBkoRi1diKSLi6rMRK63C
	pRdjZczTjSVJkGk1KZaql3xFDWZSAyyo2EVsoj9PSqmk6qoXIYFm0FicLt7Tp+b7MN4kNps2gaS
	+a+XJE+i+K9AH0KhMocdHXsHHHPE3APvyJ9I/k0k/JFzJLzCp2Zpu+/OjpTk26k1QPhq0/Eacu9
	Bp6bGk8JrAVZUu4ToJA4HWv9ePICQyTdltULZNldnH6ckoIl8iPeiS2dQjAJzY5RuuIyNu/u1ZB
	jChRqk=
X-Received: by 2002:a05:600c:c09c:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-48883572459mr51559885e9.10.1775054052732;
        Wed, 01 Apr 2026 07:34:12 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a63esm161821795e9.3.2026.04.01.07.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:34:12 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v2 0/7] clk: prepare for adding Linux CCF port
Date: Wed, 01 Apr 2026 16:34:01 +0200
Message-Id: <20260401-casey-ccf-clk-prep-v2-0-16a78c8c62da@linaro.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANoszWkC/02OQW7DMAwEv2LoXBayrFpWTv1HkQNJU6na2HIlJ
 2gQ5O+Rkx56XGJ3OFdVJEcpatdcVZZzLDHNNZiXRvEnzgeBONasjDa97owGxiIXYA7Ax29Ysiy
 gyY227xipH1Qd1mOIvw/ox/6Zy4m+hNeN9NfI8nOq39ZnTVHFAqdpiuuuYactho4H0qFz3nhiG
 digJULjxl4G71vPbkNNUgo+NKv1Jml1+18yTQuucDagwbZ2fCMXaoXej3HGnF5TPqj97XYHRN4
 OMggBAAA=
X-Change-ID: 20260320-casey-ccf-clk-prep-0b7d463cab68
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=14343;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=pgFs1XV33QTsHsdY+I57CRSUSAvR07ZkzCVP6aEj9l4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzOo+WXXW0eXmt3OlE0/GCHM+vO7qFH3dM/sV1xOBCy
 bFkHqH4jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRWhmG/5l/X4lOdhapY+aU
 9H96++MDvtjNs3Url7csXhYjXnfQrYWRYZ2gQt2ihYV+c/dPmzTj2LJrQV93ysS3NHeontPPOn1
 50QoA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 01 Apr 2026 15:01:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2947

This series adjusts the clock framework in preparation for the addition
of full Linux CCF support. Most of the changes here are standalone
improvements which is why this is a separate series.

Patch 1 fixes the clk Makefile so that some IMX specific drivers don't
get built when CLK_CCF is enabled for a different platform.

Patch 2 moves the existing U-Boot CCF port to clk/uccf so it's easier to
keep track of once the Linux CCF versions of the drivers are added.

Patch 3 then moves the basic (not CCF specific) fixed factor/rate
clocks to clk/basic, these may also be used with U-Boot CCF but are
incompatible with Linux CCF.

Patch 4 renames struct clk_ops to clk_ops_uboot, unfortunately these
ops are totally incompatible with Linux CCF. I went with this approach
rather than using a different name for the Linux clk_ops mostly because
it reduces the diff for ported Linux clock drivers.

Patches 5/6 deal with some tech debt by fixing the function prototypes
for clk_set_rate() and clk_get_parent_rate(), both of these can return
a negative errno (and some drivers do this) but the prototype is an
unsigned long. This should help encourage better error checking.

Patch 7 introduces clk_prepare/unprepare and associated functions. These
are stubs for UCLASS_CLK but will be enabled for CCF_FULL. Most drivers
should use clk_prepare_enable() but CCF will automatically prepare
unprepared clocks to aid in the transition.

While it might be convenient to remove support for prepare/unprepare,
there are relevant usecases for it for clocks that can't necessarily
be enabled or that need things like PLL tuning which only needs to be
done once.

---
Changes since v1:
 * Added prepare/unprepare stubs for clk-uclass
 * v1: https://lore.kernel.org/u-boot/20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org/

To: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
Cc: u-boot-qcom@groups.io

---
Casey Connolly (7):
      clk: restrict clk/imx to MACH_IMX
      clk: move U-Boot CCF to clk/uccf
      clk: rename clk_ops to clk_ops_uboot
      clk: move fixed clocks to clk/basic
      clk: make clk_set_rate() return signed long
      clk: make clk_get_parent_rate return signed long
      clk: compat: add clk (un)prepare and associated functions

 arch/arm/cpu/armv7/bcm281xx/clk-core.c             |  8 +--
 arch/arm/cpu/armv7/bcm281xx/clk-core.h             | 14 ++---
 cmd/clk.c                                          |  2 +-
 drivers/clk/Kconfig                                | 51 +++++----------
 drivers/clk/Makefile                               | 17 ++---
 drivers/clk/adi/clk-adi-pll.c                      |  2 +-
 drivers/clk/adi/clk-shared.c                       |  4 +-
 drivers/clk/adi/clk.h                              |  2 +-
 drivers/clk/airoha/clk-airoha.c                    |  4 +-
 drivers/clk/altera/clk-agilex.c                    |  2 +-
 drivers/clk/altera/clk-agilex5.c                   |  2 +-
 drivers/clk/altera/clk-arria10.c                   |  2 +-
 drivers/clk/altera/clk-mem-n5x.c                   |  2 +-
 drivers/clk/altera/clk-n5x.c                       |  2 +-
 drivers/clk/aspeed/clk_ast2500.c                   |  4 +-
 drivers/clk/aspeed/clk_ast2600.c                   |  4 +-
 drivers/clk/at91/clk-generic.c                     |  4 +-
 drivers/clk/at91/clk-main.c                        |  8 +--
 drivers/clk/at91/clk-master.c                      |  8 +--
 drivers/clk/at91/clk-peripheral.c                  |  6 +-
 drivers/clk/at91/clk-programmable.c                |  4 +-
 drivers/clk/at91/clk-sam9x60-pll.c                 | 10 +--
 drivers/clk/at91/clk-sam9x60-usb.c                 |  4 +-
 drivers/clk/at91/clk-system.c                      |  2 +-
 drivers/clk/at91/clk-utmi.c                        |  4 +-
 drivers/clk/at91/compat.c                          | 30 ++++-----
 drivers/clk/at91/pmc.c                             |  2 +-
 drivers/clk/at91/pmc.h                             |  2 +-
 drivers/clk/at91/sckc.c                            |  4 +-
 drivers/clk/basic/Makefile                         |  7 +++
 drivers/clk/{ => basic}/clk_fixed_factor.c         |  2 +-
 drivers/clk/{ => basic}/clk_fixed_rate.c           |  4 +-
 drivers/clk/clk-cdce9xx.c                          |  4 +-
 drivers/clk/clk-gpio.c                             |  2 +-
 drivers/clk/clk-hsdk-cgu.c                         |  4 +-
 drivers/clk/clk-stub.c                             |  4 +-
 drivers/clk/clk-uclass.c                           | 33 ++++++----
 drivers/clk/clk-xlnx-clock-wizard.c                |  4 +-
 drivers/clk/clk_bcm6345.c                          |  2 +-
 drivers/clk/clk_boston.c                           |  2 +-
 drivers/clk/clk_k210.c                             |  8 +--
 drivers/clk/clk_octeon.c                           |  2 +-
 drivers/clk/clk_pic32.c                            |  4 +-
 drivers/clk/clk_sandbox.c                          |  4 +-
 drivers/clk/clk_sandbox_test.c                     |  2 +-
 drivers/clk/clk_scmi.c                             |  6 +-
 drivers/clk/clk_versaclock.c                       | 22 +++----
 drivers/clk/clk_versal.c                           |  4 +-
 drivers/clk/clk_vexpress_osc.c                     |  4 +-
 drivers/clk/clk_zynq.c                             |  8 +--
 drivers/clk/clk_zynqmp.c                           |  6 +-
 drivers/clk/exynos/clk-exynos7420.c                |  6 +-
 drivers/clk/exynos/clk-pll.c                       |  4 +-
 drivers/clk/exynos/clk.h                           |  2 +-
 drivers/clk/ics8n3qv01.c                           |  4 +-
 drivers/clk/imx/clk-composite-8m.c                 |  6 +-
 drivers/clk/imx/clk-composite-93.c                 |  2 +-
 drivers/clk/imx/clk-fracn-gppll.c                  |  4 +-
 drivers/clk/imx/clk-gate-93.c                      |  4 +-
 drivers/clk/imx/clk-gate2.c                        |  4 +-
 drivers/clk/imx/clk-imx6q.c                        |  2 +-
 drivers/clk/imx/clk-imx6ul.c                       |  2 +-
 drivers/clk/imx/clk-imx8.c                         |  4 +-
 drivers/clk/imx/clk-imx8.h                         |  2 +-
 drivers/clk/imx/clk-imx8qm.c                       |  2 +-
 drivers/clk/imx/clk-imx8qxp.c                      |  2 +-
 drivers/clk/imx/clk-imxrt1020.c                    |  2 +-
 drivers/clk/imx/clk-imxrt1170.c                    |  4 +-
 drivers/clk/imx/clk-pfd.c                          |  4 +-
 drivers/clk/imx/clk-pll14xx.c                      |  8 +--
 drivers/clk/imx/clk-pllv3.c                        | 18 +++---
 drivers/clk/intel/clk_intel.c                      |  2 +-
 drivers/clk/mediatek/clk-mtk.c                     | 14 ++---
 drivers/clk/mediatek/clk-mtk.h                     | 10 +--
 drivers/clk/meson/a1.c                             |  8 +--
 drivers/clk/meson/axg-ao.c                         |  2 +-
 drivers/clk/meson/axg.c                            |  2 +-
 drivers/clk/meson/clk-measure.c                    |  2 +-
 drivers/clk/meson/g12a-ao.c                        |  2 +-
 drivers/clk/meson/g12a.c                           | 10 +--
 drivers/clk/meson/gxbb.c                           |  8 +--
 drivers/clk/microchip/mpfs_clk_cfg.c               |  4 +-
 drivers/clk/microchip/mpfs_clk_msspll.c            |  2 +-
 drivers/clk/microchip/mpfs_clk_periph.c            |  2 +-
 drivers/clk/mpc83xx_clk.c                          |  2 +-
 drivers/clk/mtmips/clk-mt7620.c                    |  2 +-
 drivers/clk/mtmips/clk-mt7621.c                    |  2 +-
 drivers/clk/mtmips/clk-mt7628.c                    |  2 +-
 drivers/clk/mvebu/armada-37xx-periph.c             |  4 +-
 drivers/clk/mvebu/armada-37xx-tbg.c                |  2 +-
 drivers/clk/nuvoton/clk_npcm.c                     |  4 +-
 drivers/clk/nuvoton/clk_npcm.h                     |  2 +-
 drivers/clk/owl/clk_owl.c                          |  6 +-
 drivers/clk/qcom/clock-apq8016.c                   |  2 +-
 drivers/clk/qcom/clock-apq8096.c                   |  2 +-
 drivers/clk/qcom/clock-ipq4019.c                   |  2 +-
 drivers/clk/qcom/clock-ipq5424.c                   |  2 +-
 drivers/clk/qcom/clock-ipq9574.c                   |  2 +-
 drivers/clk/qcom/clock-qcm2290.c                   |  2 +-
 drivers/clk/qcom/clock-qcom.c                      |  4 +-
 drivers/clk/qcom/clock-qcom.h                      |  2 +-
 drivers/clk/qcom/clock-qcs404.c                    |  2 +-
 drivers/clk/qcom/clock-qcs615.c                    |  2 +-
 drivers/clk/qcom/clock-qcs8300.c                   |  2 +-
 drivers/clk/qcom/clock-sa8775p.c                   |  2 +-
 drivers/clk/qcom/clock-sc7280.c                    |  2 +-
 drivers/clk/qcom/clock-sdm845.c                    |  4 +-
 drivers/clk/qcom/clock-sm6115.c                    |  2 +-
 drivers/clk/qcom/clock-sm6350.c                    |  2 +-
 drivers/clk/qcom/clock-sm7150.c                    |  2 +-
 drivers/clk/qcom/clock-sm8150.c                    |  2 +-
 drivers/clk/qcom/clock-sm8250.c                    |  2 +-
 drivers/clk/qcom/clock-sm8550.c                    |  4 +-
 drivers/clk/qcom/clock-sm8650.c                    |  4 +-
 drivers/clk/qcom/clock-x1e80100.c                  |  4 +-
 drivers/clk/renesas/clk-rcar-gen2.c                |  4 +-
 drivers/clk/renesas/clk-rcar-gen3.c                |  4 +-
 drivers/clk/renesas/compound-clock.c               |  4 +-
 drivers/clk/renesas/r9a06g032-clocks.c             |  6 +-
 drivers/clk/renesas/rcar-gen2-cpg.h                |  2 +-
 drivers/clk/renesas/rcar-gen3-cpg.h                |  2 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |  8 +--
 drivers/clk/rockchip/clk_px30.c                    | 12 ++--
 drivers/clk/rockchip/clk_rk3036.c                  |  4 +-
 drivers/clk/rockchip/clk_rk3066.c                  |  4 +-
 drivers/clk/rockchip/clk_rk3128.c                  |  4 +-
 drivers/clk/rockchip/clk_rk3188.c                  |  4 +-
 drivers/clk/rockchip/clk_rk322x.c                  |  4 +-
 drivers/clk/rockchip/clk_rk3288.c                  |  4 +-
 drivers/clk/rockchip/clk_rk3308.c                  |  4 +-
 drivers/clk/rockchip/clk_rk3328.c                  |  4 +-
 drivers/clk/rockchip/clk_rk3368.c                  |  4 +-
 drivers/clk/rockchip/clk_rk3399.c                  |  8 +--
 drivers/clk/rockchip/clk_rk3528.c                  | 10 +--
 drivers/clk/rockchip/clk_rk3568.c                  | 14 ++---
 drivers/clk/rockchip/clk_rk3576.c                  |  8 +--
 drivers/clk/rockchip/clk_rk3588.c                  | 12 ++--
 drivers/clk/rockchip/clk_rv1108.c                  |  4 +-
 drivers/clk/rockchip/clk_rv1126.c                  | 12 ++--
 drivers/clk/sifive/sifive-prci.c                   |  4 +-
 drivers/clk/sophgo/clk-cv1800b.c                   |  4 +-
 drivers/clk/sophgo/clk-ip.c                        | 30 ++++-----
 drivers/clk/sophgo/clk-ip.h                        | 18 +++---
 drivers/clk/sophgo/clk-pll.c                       |  8 +--
 drivers/clk/sophgo/clk-pll.h                       |  4 +-
 drivers/clk/starfive/clk-jh7110-pll.c              |  4 +-
 drivers/clk/starfive/clk.h                         |  2 +-
 drivers/clk/stm32/clk-stm32-core.c                 | 22 +++----
 drivers/clk/stm32/clk-stm32-core.h                 |  2 +-
 drivers/clk/stm32/clk-stm32f.c                     |  4 +-
 drivers/clk/stm32/clk-stm32h7.c                    |  2 +-
 drivers/clk/stm32/clk-stm32mp1.c                   |  4 +-
 drivers/clk/sunxi/clk_sun6i_rtc.c                  |  2 +-
 drivers/clk/sunxi/clk_sunxi.c                      |  2 +-
 drivers/clk/tegra/tegra-car-clk.c                  |  4 +-
 drivers/clk/tegra/tegra186-clk.c                   |  4 +-
 drivers/clk/thead/clk-th1520-ap.c                  |  8 +--
 drivers/clk/ti/clk-am3-dpll-x2.c                   |  2 +-
 drivers/clk/ti/clk-am3-dpll.c                      |  4 +-
 drivers/clk/ti/clk-ctrl.c                          |  2 +-
 drivers/clk/ti/clk-divider.c                       |  4 +-
 drivers/clk/ti/clk-gate.c                          |  2 +-
 drivers/clk/ti/clk-k3-pll.c                        |  4 +-
 drivers/clk/ti/clk-k3.c                            |  6 +-
 drivers/clk/ti/clk-mux.c                           |  4 +-
 drivers/clk/ti/clk-sci.c                           |  4 +-
 drivers/clk/uccf/Kconfig                           | 22 +++++++
 drivers/clk/uccf/Makefile                          | 11 ++++
 drivers/clk/{ => uccf}/clk-composite.c             | 20 +++---
 drivers/clk/{ => uccf}/clk-divider.c               |  4 +-
 drivers/clk/{ => uccf}/clk-fixed-factor.c          |  2 +-
 drivers/clk/{ => uccf}/clk-gate.c                  |  2 +-
 drivers/clk/{ => uccf}/clk-mux.c                   |  2 +-
 drivers/clk/{ => uccf}/clk.c                       |  4 +-
 .../{clk_sandbox_ccf.c => uccf/clk_sandbox_uccf.c} |  8 +--
 drivers/clk/uniphier/clk-uniphier-core.c           |  6 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |  2 +-
 drivers/phy/cadence/phy-cadence-torrent.c          |  2 +-
 drivers/phy/phy-stm32-usbphyc.c                    |  2 +-
 drivers/phy/phy-ti-am654.c                         |  2 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |  2 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |  6 +-
 drivers/power/domain/imx8mp-hsiomix.c              |  2 +-
 include/clk-uclass.h                               |  6 +-
 include/clk.h                                      | 72 +++++++++++++++++++++-
 include/clk/sunxi.h                                |  2 +-
 include/linux/clk-provider.h                       | 24 ++++----
 include/sandbox-clk.h                              |  2 +-
 188 files changed, 596 insertions(+), 497 deletions(-)
---
base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7

// Casey (she/they)


