Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C485C25B74
	for <webhook@archiver.kernel.org>; Tue, 21 May 2024 07:49:23 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web11.21083.1715704964482651919
 for <u-boot-amlogic@groups.io>;
 Tue, 14 May 2024 09:42:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=r8+PjqP3;
 spf=pass (domain: konsulko.com, ip: 209.85.210.54, mailfrom: trini@konsulko.com)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f0f0494459so2426034a34.0
        for <u-boot-amlogic@groups.io>; Tue, 14 May 2024 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1715704964; x=1716309764; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/wYYQrgM0bURQSvqbsD0GRSFttw0WKnFQJQLLJRdU4=;
        b=r8+PjqP3YDGNuFlZix6DJwBfEoPQOJT//6VKEgsk86y2O+DPMWf096Ft39DflYtizL
         Ys9IBUR2GYWpy72pYZ+GJQZ1rNq196nc/moJ5lt6fNE3hIW5dm77Z7wr09ECBBYUJ6zO
         raskzJDDYe4G7veZjHVujtc193MHY8SRIKkE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715704964; x=1716309764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/wYYQrgM0bURQSvqbsD0GRSFttw0WKnFQJQLLJRdU4=;
        b=i6Slh+AQJSIoc9s/DAyQYARbeFVE+oH3xfYdmZmSnkMEJOAv+ghGSzrU8O3WwbDrht
         0ngDpIzVIfNswSaj1cp7aNL7xeSjgZO1ROgo4azv9vglfpYZLGI7jBCK7F7xX7J0ICXW
         eGo9rdEg0U/U/NGqqGiEhakDbndl5FpRUEFsII60Bk3lX2akbPOmYrjS66nRw6Uj9x6T
         KqjPBcV9ds5gEulejMgbaHJXfL06tOEBTDEqj/iiMeh8RwHqonWgRkq44URfl5UL5qKi
         Np/i8hXZttVns1EVfWTydwbz4olgCB4TL1d/XsQAZlAtZKhE0YdMGnur5JxiIiKs+Te3
         rsqA==
X-Forwarded-Encrypted: i=1; AJvYcCUeZ9ORkIWjE+sbhtk/1k4KPq9/DUlCJ5g/hQyAO5Nypl/Q7t+wdwmNCDqo7hI+2DNi+1w6k6+YaYG4MBUSNr5ex8Nx6GSdQsU=
X-Gm-Message-State: AOJu0YzRsnA8P18E7wbRXmYRTLZdHO3eprxuaMoNFb+/lsQSNQVMOjwh
	W7kONi1QkQRxEUFxmULqDKYclyzqcj72AObzKK0UmJdMurGO9mmwA7Rxha7rrt0mqfjplbQk8zy
	BNKM=
X-Google-Smtp-Source: AGHT+IE2LI3n2D23Y28+KieF2pspVCYxAdM+R9XitCSEgLe48qioiY3UJdiyaDa71vvTnWTrWV4oeg==
X-Received: by 2002:a9d:4b03:0:b0:6f0:e6e2:83b0 with SMTP id 46e09a7af769-6f0e90f201bmr16627449a34.5.1715704962927;
        Tue, 14 May 2024 09:42:42 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2802e7sm581710985a.48.2024.05.14.09.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 09:42:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Bryan Brattlof <bb@ti.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Christian Hewitt <christianshewitt@gmail.com>,
	"Cogent Embedded, Inc." <source@cogentembedded.com>,
	Dave Purdy <david.c.purdy@gmail.com>,
	Evgeni Dobrev <evgeni@studio-punkt.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jason Cooper <u-boot@lakedaemon.net>,
	Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Luka Perkov <luka@openwrt.org>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
	Michael Walle <michael@walle.cc>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Paul Barker <paul.barker.ct@bp.renesas.com>,
	Peng Fan <peng.fan@nxp.com>,
	Ramon Fried <rfried.dev@gmail.com>,
	Siddarth Gore <gores@marvell.com>,
	Simon Guinot <simon.guinot@sequanux.org>,
	Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
	Stefan Roese <sr@denx.de>,
	Sumit Garg <sumit.garg@linaro.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Tony Dinh <mibodhi@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vyacheslav Bocharov <adeep@lexina.in>,
	Wadim Egorov <w.egorov@phytec.de>,
	Walter Schweizer <swwa@users.sourceforge.net>,
	u-boot-amlogic@groups.io,
	u-boot-qcom@groups.io
Subject: [PATCH 1/1] Squashed 'dts/upstream/' changes from b35b9bd1d4ee..7e08733c96c8
Date: Tue, 14 May 2024 10:42:36 -0600
Message-Id: <20240514164236.516595-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 21 May 2024 07:49:23 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2285

7e08733c96c8 Merge tag 'v6.9-dts-raw'
ccdce3340fc5 Merge tag 'net-6.9-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
cb4ccb79bf49 dt-bindings: net: mediatek: remove wrongly added clocks and SerDes
6bd14595bb37 Merge tag 'soc-fixes-6.9-3' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
a6d12fb4ba6f Merge tag 'qcom-arm64-fixes-for-6.9-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
71c2fe626e53 Merge tag 'v6.9-rc7-dts-raw'
62d74bd1c58f Merge tag 'char-misc-6.9-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
bdc631c5b7eb arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node
9818a367c6b8 Merge tag 'sound-6.9-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
c861ae2b0770 Merge tag 'pinctrl-v6.9-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
c9551dbd4ea4 Merge tag 'v6.9-rc6-dts-raw'
17c632b49122 Merge tag 'i2c-for-6.9-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
a1bf8545a7b4 Merge tag 'soc-fixes-6.9-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
d13e05c0fe9b Merge tag 'arc-6.9-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc
83b7bf1bdd47 Merge tag 'imx-fixes-6.9-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into for-next
3a940d011934 Merge tag 'mtk-dts64-fixes-for-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux into for-next
6eeb1be299fc Merge tag 'at91-fixes-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into for-next
733db5273cb7 Merge tag 'qcom-arm64-fixes-for-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into for-next
76a235f6ef02 Merge branch 'v6.9-armsoc/dtsfixes' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into for-next
a4916498fb4a Merge tag 'at24-fixes-for-v6.9-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into i2c/for-current
6ee8c2d34ea8 ARM: dts: imx6ull-tarragon: fix USB over-current polarity
c3ee365cb940 Merge tag 'iio-fixes-for-6.9a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus
bb3b0f6bb688 Merge tag 'v6.9-rc5-dts-raw'
ca2b45c908c0 arm64: dts: imx8mp: Fix assigned-clocks for second CSI2
b91b30ccdb82 Merge tag 'tty-6.9-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
9e347843c73f ARM: dts: microchip: at91-sama7g54_curiosity: Replace regulator-suspend-voltage with the valid property
a6e3d2cb9d6d ARM: dts: microchip: at91-sama7g5ek: Replace regulator-suspend-voltage with the valid property
01c2febb3cdb arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin configuration
460856d18366 arm64: dts: rockchip: Fix USB interface compatible string on kobol-helios64
e91f447c8573 Merge tag 'pwm/for-6.9-rc5-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux
b362458a0941 dt-bindings: eeprom: at24: Fix ST M24C64-D compatible schema
4c77f098d193 ARC: [plat-hsdk]: Remove misplaced interrupt-cells property
bc5665bd550f dt-bindings: pwm: mediatek,pwm-disp: Document power-domains property
bdb049c4d14f Merge tag 'v6.9-rc4-dts-raw'
ea20dda12f5b Merge tag 'soc-fixes-6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
c43f5bbe57fe arm64: dts: qcom: sc8180x: Fix ss_phy_irq for secondary USB controller
09bbdcd84ac2 arm64: dts: qcom: sm8650: Fix the msi-map entries
864783541376 arm64: dts: qcom: sm8550: Fix the msi-map entries
ddedda592d70 arm64: dts: qcom: sm8450: Fix the msi-map entries
960336e0e880 arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
eb57b8e07fd7 arm64: dts: qcom: x1e80100: Fix the compatible for cluster idle states
64b22344a08d arm64: dts: qcom: Fix type of "wdog" IRQs for remoteprocs
3d4da9353d8a Merge tag 'drm-fixes-2024-04-12' of https://gitlab.freedesktop.org/drm/kernel
94d5ae8ffd5b Merge tag 'drm-msm-next-2024-04-11' of https://gitlab.freedesktop.org/drm/msm into drm-fixes
45ab49b70c99 LoongArch: Update dts for Loongson-2K2000 to support GMAC/GNET
e5f2765cdef5 LoongArch: Update dts for Loongson-2K2000 to support PCI-MSI
65d54f215c81 LoongArch: Update dts for Loongson-2K2000 to support ISA/LPC
05bddcf85f2c LoongArch: Update dts for Loongson-2K1000 to support ISA/LPC
e32b794a9062 arm64: dts: rockchip: regulator for sd needs to be always on for BPI-R2Pro
cf90790de0b2 dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node
ad6402eb7acc arm64: dts: rockchip: drop redundant disable-gpios in Lubancat 2
ace753017ab4 arm64: dts: rockchip: drop redundant disable-gpios in Lubancat 1
24eae3d76a2b arm64: dts: rockchip: drop redundant pcie-reset-suspend in Scarlet Dumo
6ddbc8e4f612 arm64: dts: rockchip: mark system power controller and fix typo on orangepi-5-plus
7d1e92c191e5 arm64: dts: rockchip: Designate the system power controller on QuartzPro64
b2f8ee07aa8e ASoC: dt-bindings: rt5645: add cbj sleeve gpio property
39841e784daa MAINTAINERS: mailmap: update Richard Genoud's email address
10c6631c86d1 Merge tag 'v6.9-rc3-dts-raw'
4ea847a91dd6 Merge tag 'devicetree-fixes-for-6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
446b3564a952 arm64: dts: mediatek: mt2712: fix validation errors
65d0eb62f0f1 arm64: dts: mediatek: mt7986: prefix BPI-R3 cooling maps with "map-"
a2ac24e9a4dc arm64: dts: mediatek: mt7986: drop invalid thermal block clock
7d65b24f6c7b arm64: dts: mediatek: mt7986: drop "#reset-cells" from Ethernet controller
6674a5ba09ef arm64: dts: mediatek: mt7986: drop invalid properties from ethsys
fb0a8e849646 dt-bindings: timer: narrow regex for unit address to hex numbers
cb1b6952348f dt-bindings: soc: fsl: narrow regex for unit address to hex numbers
27c8017d28c8 dt-bindings: remoteproc: ti,davinci: remove unstable remark
9095a10d281f dt-bindings: clock: ti: remove unstable remark
3f61301c1488 dt-bindings: clock: keystone: remove unstable remark
31b1ce263042 arm64: dts: imx8qm-ss-dma: fix can lpcg indices
743b20b5d4db arm64: dts: imx8-ss-dma: fix can lpcg indices
d8f0818c58bc arm64: dts: imx8-ss-dma: fix adc lpcg indices
2349133feee2 arm64: dts: imx8-ss-dma: fix pwm lpcg indices
a18420af419e arm64: dts: imx8-ss-dma: fix spi lpcg indices
d6d2add292ae arm64: dts: imx8-ss-conn: fix usb lpcg indices
fc19a9596662 arm64: dts: imx8-ss-lsio: fix pwm lpcg indices
64a1c4a72a08 arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
f91467bb0e7c arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
8e632e3e98df arm64: dts: mediatek: mt7622: fix IR nodename
1472eb8a5653 arm64: dts: mediatek: mt7622: fix clock controllers
5802f95e74db arm64: dts: mediatek: mt8186-corsola: Update min voltage constraint for Vgpu
6cb73d686d58 arm64: dts: mediatek: mt8183-kukui: Use default min voltage for MT6358
cd3a14e0479e arm64: dts: mediatek: mt8195-cherry: Update min voltage constraint for MT6315
2814659a8a80 arm64: dts: mediatek: mt8192-asurada: Update min voltage constraint for MT6315
3ea180fa00c5 arm64: dts: mediatek: cherry: Describe CPU supplies
c452106eb835 arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex1
5893bd804364 arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex
ad1660ce46c3 arm64: dts: mediatek: mt8195: Add missing gce-client-reg to vpp/vdosys
744724419d4c arm64: dts: mediatek: mt8192: Add missing gce-client-reg to mutex
902cad91425f arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg
7b49bc388147 ARM: dts: imx7s-warp: Pass OV2680 link-frequencies
bd5623d08b6c ARM: dts: imx7-mba7: Use 'no-mmc' property
51b8028c7925 arm64: dts: imx8-ss-conn: fix usdhc wrong lpcg clock order
6beeed742637 dt-bindings: display/msm: sm8150-mdss: add DP node
954f369b81da ARC: Fix typos
3d2c4d764916 arm64: dts: rockchip: drop panel port unit address in GRU Scarlet
fa6ab1a0c8a1 arm64: dts: rockchip: Remove unsupported node from the Pinebook Pro dts
7f80622495d4 arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
92953647265f dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
6421f94d75f4 arm64: dts: freescale: imx8mp-venice-gw73xx-2x: fix USB vbus regulator
4bb321df9164 arm64: dts: freescale: imx8mp-venice-gw72xx-2x: fix USB vbus regulator
f37161a9cf0c dt-bindings: ufs: qcom: document SM6125 UFS
b2a26b71ae7d dt-bindings: ufs: qcom: document SC7180 UFS
1cb1e2605d33 dt-bindings: ufs: qcom: document SC8180X UFS
6bd77a407d2e dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow 'input' and 'output-enable' properties
2639a0e2fdbd Merge tag 'v6.9-rc1-dts-raw'
15eca7b21493 docs: dt-bindings: add missing address/size-cells to example
9ace491cae40 arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi CM5
d8bdab44b3fe arm64: dts: rockchip: add regulators for PCIe on RK3399 Puma Haikou
1331876fe9c8 arm64: dts: rockchip: enable internal pull-up on PCIE_WAKE# for RK3399 Puma
57878497676a arm64: dts: rockchip: enable internal pull-up on Q7_USB_ID for RK3399 Puma
a9686a9d2878 arm64: dts: rockchip: fix alphabetical ordering RK3399 puma
6125abd98f94 arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on RK3399 Puma
e51b8871e6a8 arm64: dts: rockchip: set PHY address of MT7531 switch to 0x1f
8c7a1135d13d dt-bindings: iio: health: maxim,max30102: fix compatible check
7eea89692b5a Merge tag 'timers-core-2024-03-23' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
665795c05a77 Merge tag 'riscv-for-linus-6.9-mw2' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
9497bb8a116e Merge tag 'spi-fix-v6.9-merge-window' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
6aef9b1ef737 Merge tag 'sound-fix2-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
17cde028ffcc Merge tag 'i2c-for-6.9-rc1-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
7bbd20ac15d0 Merge tag 'rtc-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
b2bb86451efb Merge tag 'ubifs-for-linus-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs
203aa834e5f2 Merge tag 'char-misc-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
9125147fa946 Merge tag 'tty-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
e5738ce51174 Merge tag 'usb-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
d4a1391985cc Merge tag 'rproc-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux
b3632b121e0d Merge tag 'asoc-fix-v6.9-merge-window' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus
4a7dcd8c3a18 dt-bindings: i2c: qcom,i2c-cci: Fix OV7251 'data-lanes' entries
f76fa412f9a8 Merge tag 'i2c-host-6.9-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/for-mergewindow
8cd35b85c4b0 Merge tag 'soc-late-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
f6c32d4a4ede Merge tag 'thermal-6.9-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
6630f47c5f9a spi: Merge up v6.8 release
ec2e44a038f5 Merge tag 'timers-v6.9-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core
ef0c6b10c2da Merge tag 'i3c/for-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux
6defc064e93e Merge tag 'linux-watchdog-6.9-rc1' of git://www.linux-watchdog.org/linux-watchdog
72fe2cde7b8a Merge tag 'input-for-v6.9-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
a546e7273d2d Merge tag 'phy-for-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
3972e256bfa2 Merge tag 'v6.9-p1' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
a355cc2d4dcb Merge tag 'mips_6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
aefedca6e1b1 Merge tag 'devicetree-for-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
8eb838e35ade Merge tag 'mtd/for-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
7497080a0eda Merge tag 'dmaengine-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine
571f27ef129d Merge tag 'i2c-for-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
fb60e6d58b2d dt-bindings: input: samsung,s3c6410-keypad: convert to DT Schema
34598dab4724 Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
9d67b3ce96cb Merge tag 'media/v6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
3fe3426bca72 dt-bindings: soc: imx: fsl,imx-anatop: add imx6q regulators
7311bc58c158 Merge tag 'nand/for-6.9' into mtd/next
146d9a6f3ded dt-bindings: atmel-nand: add microchip,sam9x7-pmecc
e2a5c7c3959b arm64: dts: broadcom: bcmbca: Update router boards
1bd13f3b7695 arm64: dts: broadcom: bcmbca: Add NAND controller node
cc519333e3cf ARM: dts: broadcom: bcmbca: Add NAND controller node
c1e4264b6d55 Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
6371c24fe180 Merge tag 'sound-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
98c06b3a9483 Merge tag 'pci-v6.9-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
7fa73443a89b Merge tag 'platform-drivers-x86-v6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
e76bc30ffbd6 Merge tag 'leds-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds
19186d59b259 Merge tag 'backlight-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
75c5518e62b1 Merge tag 'mfd-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
099699809967 Merge tag 'pinctrl-v6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
8e49bd3cbb58 Merge tag 'auxdisplay-v6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay
a775511def90 Merge tag 'drm-next-2024-03-13' of https://gitlab.freedesktop.org/drm/kernel
4d3acb15ed8a Merge tag 'spi-nor/for-6.9' into mtd/next
51591c70d1ca Merge branches 'clk-samsung', 'clk-imx', 'clk-rockchip', 'clk-clkdev' and 'clk-rate-exclusive' into clk-next
0c05d2bca0f7 Merge tag 'thermal-v6.9-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux
a55648d846e7 Merge branches 'clk-remove', 'clk-amlogic', 'clk-qcom', 'clk-parent' and 'clk-microchip' into clk-next
749f625e4547 Merge branches 'clk-aspeed', 'clk-keystone', 'clk-mobileye' and 'clk-allwinner' into clk-next
82d0f90167fc Merge branches 'clk-renesas', 'clk-cleanup', 'clk-hisilicon', 'clk-mediatek' and 'clk-bulk' into clk-next
6526c4a4b4e5 Merge tag 'tpmdd-v6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
1da1a2503cbc Merge tag 'mailbox-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox
cecb3b4fdac3 Merge tag 'pm-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
49c8db52641c Merge tag 'pmdomain-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm
b15efb2ec6a3 Merge tag 'hwmon-for-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
51da5c0be9f6 ASoC: Merge up release
82088fb378a1 Merge tag 'gpio-updates-for-v6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
08aa0ae1911b Merge tag 'spi-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
4a3bf9f36d1e Merge tag 'regulator-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
c77ca2066932 Merge tag 'mmc-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
c5d224537c1b Merge tag 'pwm/for-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux
4915b8cd98b1 Merge tag 'ata-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
087aaa6a3b72 Merge tag 'iommu-updates-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
8a195fe51ba1 Merge tag 'net-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
80731b204b02 Merge tag 'soc-drivers-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
ba13a7bc46d2 Merge tag 'soc-dt-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
8bdef0681554 Merge branch 'pci/controller/qcom'
5ad36cd7e767 riscv: dts: renesas: Add Andes PMU extension for r9a07g043f
8ecbb51f81c3 dt-bindings: riscv: Add Andes PMU extension description
9b464e19669d riscv: dts: renesas: r9a07g043f: Update compatible string to use Andes INTC
7d51e7e2e08f dt-bindings: riscv: Add Andes interrupt controller compatible string
9ff0305a8ca8 ASoC: dt-bindings: cirrus,cs42l43: Fix 'gpio-ranges' schema
9527f40e46b6 Input: allocate keycode for Display refresh rate toggle
62e63d55bebc Merge tag 'i2c-host-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux into i2c/for-mergewindow
9570e92757ae dt-bindings: tpm: Add compatible string atmel,attpm20p
7cfac8b79d64 Merge tag 'irq-core-2024-03-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
432d7edb5952 dt-bindings: thermal: rcar-gen3-thermal: Add r8a779h0 support
338820b14493 dt-bindings: thermal-zones: Don't require polling-delay(-passive)
586ddb37a9a4 dt-bindings: thermal: sun8i: Add H616 THS controller
167b4b5a2247 dt-bindings: thermal: qoriq-thermal: Adjust fsl,tmu-range min/maxItems
97f8ab2a1af7 Merge tag 'opp-updates-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm into pm
6478cc89c8f9 Merge tag 'asoc-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus
ac6125bb95c2 mips: dts: ralink: mt7621: add cell count properties to usb
c5bb691ccc3e mips: dts: ralink: mt7621: add serial1 and serial2 nodes
7b09814959b2 mips: dts: ralink: mt7621: reorder serial0 properties
ec836787ded4 mips: dts: ralink: mt7621: associate uart1_pins with serial0
7d9359e47208 Merge tag 'riscv-dt-fixes-for-v6.8-final' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into soc/dt
078fe0b4bda8 Merge tag 'arm-soc/for-6.9/drivers' of https://github.com/Broadcom/stblinux into soc/late
a851536f7d1f Merge tag 'arm-soc/for-6.9/devicetree-arm64' of https://github.com/Broadcom/stblinux into soc/late
63fbbfa8e739 dt-bindings: opp: drop maxItems from inner items
54c13b3c325d dt-bindings: mailbox: fsl,mu: add i.MX95 Generic/ELE/V2X MU compatible
4950062963d6 dt-bindings: input: imagis: Document touch keys
cfb6e7e4aab8 dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller
c779c938fb22 dt-bindings: pinctrl: qcom: update compatible name for match with driver
98b8ca8bcb74 dt-bindings: input: atmel,captouch: convert bindings to YAML
f4627ef4c35c dt-bindings: i2c: nomadik: add mobileye,eyeq5-i2c bindings and example
e6a7453cf514 Merge tag 'wireless-next-2024-03-08' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
826587e76776 dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
e776ecb01509 dt-bindings: PCI: qcom: Allow 'required-opps'
41c94df7b508 dt-bindings: auxdisplay: Add bindings for generic 7-segment LED
51ec88485bd0 dt-bindings: rtc: zynqmp: Add support for Versal/Versal NET SoCs
4a0688c342c5 dt-bindings: rtc: abx80x: Improve checks on trickle charger constraints
09ed5b86a7c0 Merge branches 'arm/mediatek', 'arm/renesas', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next
1ca49df08091 dt-bindings: net: dp83822: change ti,rmii-mode description
9e691f2ca146 Merge tag 'drm-msm-next-2024-03-07' of https://gitlab.freedesktop.org/drm/msm into drm-next
cfe04ff5f8c9 dt-bindings: serial: stm32: add power-domains property
b072a75f7faf dt-bindings: nvmem: add common definition of nvmem-cell-cells
be64edb74cf7 dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml
baca151add1c nvmem: fixed-cell: Simplify nested if/then schema
1c0b231f57e0 dt-bindings: hwmon: Support Aspeed g6 PWM TACH Control
a0c034ed370f dt-bindings: hwmon: fan: Add fan binding to schema
5f3df8a26d1e dt-bindings: hwmon: tda38640: Add interrupt & regulator properties
ea5fd00e7566 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
1cd0ddec1f0e dt-bindings: timer: mediatek: Convert to json-schema
4a513c9ee434 ASoC: codecs: ES8326: change support for ES8326
9428855666bf dt-bindings: backlight: qcom-wled: Fix bouncing email addresses
ded680d1011e dt-bindings: leds: Add NCP5623 multi-LED Controller
36c053ec1940 dt-bindings: leds: qcom-lpg: Narrow nvmem for other variants
86d79b6e9034 dt-bindings: leds: qcom-lpg: Drop redundant qcom,pm8550-pwm in if:then:
0d9351b5397b dt-bindings: leds: Add LED_FUNCTION_WAN_ONLINE for Internet access
00b899276322 dt-bindings: leds: Add FUNCTION defines for per-band WLANs
0d85184c07f6 dt-bindings: leds: leds-qcom-lpg: Add support for LPG PPG
b4ab63101636 Merge branches 'ib-qcom-leds-6.9' and 'ib-leds-backlight-6.9' into ibs-for-leds-merged
3555e8d0b9fc dt-bindings: backlight: Add Kinetic KTD2801 binding
a8c949969077 Merge branch 'ib-nomadik-gpio' into devel
62c3262f7fe3 dt-bindings: net: renesas,etheravb: Add support for R-Car V4M
918ae23afab4 dt-bindings: interrupt-controller: fsl,intmux: Include power-domains support
e53ec66488c1 Merge tag 'icc-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
1f0e4fc46ee7 Merge tag 'qcom-arm64-for-6.9-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/dt
ea75705aeacc Merge tag 'riscv-dt-for-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into soc/late
584c83fce20d dt-bindings: remoteproc: qcom,sm8550-pas: document the X1E80100 aDSP & cDSP
c04e94fc3b79 dt-bindings: remoteproc: do not override firmware-name $ref
4b39a7e1c39f dt-bindings: remoteproc: qcom,glink-rpm-edge: drop redundant type from label
e6ec88170ffc dt-bindings: pinctrl: Add bindings for Awinic AW9523/AW9523B
fc76e2ec0af9 spi: dt-bindings: introduce FIFO depth properties
649423f8a081 ASoC: dt-bindings: rt1015: Convert to dtschema
7a4e8175bafb riscv: dts: starfive: jh7100: fix root clock names
eed1e7dce0c5 Merge tag 'ath-next-20240305' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath
b77c6d6ecd26 Merge tag 'v6.8-rc7' into gpio/for-next
b6f4257e837d dt-bindings: input: allwinner,sun4i-a10-lrad: drop redundant type from label
ab13fd756619 dt-bindings: fsl-imx-sdma: fix HDMI audio index
8183e8af3de8 dt-bindings: soc: imx: fsl,imx-iomuxc-gpr: add imx6
364eb93f21bc dt-bindings: soc: imx: fsl,imx-anatop: add binding
0d6b9633b62c dt-bindings: input: touchscreen: fsl,imx6ul-tsc convert to YAML
e24d180df3e3 dt-bindings: pinctrl: fsl,imx6ul-pinctrl: convert to YAML
c6cb9528755c Merge tag 'v6.9-rockchip-drivers1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
1541b5f7169a dt-bindings: usb: typec-tcpci: add tcpci fallback binding
30cfb408e45f dt-bindings: usb: Add downstream facing ports to realtek binding
ba19f225f401 dt-bindings: usb: Add binding for TI USB8020B hub controller
c3251302f8d3 dt-bindings: usb: analogix,anx7411: drop redundant connector properties
c6425032f69e dt-bindings: usb: add hisilicon,hi3798mv200-dwc3
a1bd84637b96 dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc: add Hi3798MV200 binding
7fc53b04c1ea dt-bindings: mmc: dw-mshc-hi3798cv200: convert to YAML
f1338ec7ac44 dt-bindings: i2c: mpc: use proper binding for transfer timeouts
78ad26b5f48f dt-bindings: interrupt-controller: Convert Atmel AIC to json-schema
99d17f43c09c Merge tag 'reset-for-v6.9' of git://git.pengutronix.de/pza/linux into soc/late
14c572ddf1f9 Merge tag 'omap-for-v6.9/dt-warnings-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/late
04cdefa63030 Merge tag 'vexpress-update-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into soc/dt
8100aecad25e ARM: dts: samsung: exynos4412: decrease memory to account for unusable region
44ffff36c17a Merge tag 'ti-keystone-dt-for-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/dt
38d2af77456f Merge tag 'memory-controller-drv-6.9-2' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
4b3d3727fe21 Merge tag 'qcom-drivers-for-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/drivers
1390bca92db4 spi: dt-bindings: samsung: make dma properties not required
f3f062800bf5 dt-bindings: perf: starfive: Add JH8100 StarLink PMU
8ade2ed03067 dt-bindings: usb: qcom,pmic-typec: add support for the PM4125 block
ffd54b03300e dt-bindings: leds: pwm-multicolour: re-allow active-low
2bd3e3e38b19 dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
a1a33ad5df89 dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
d5b3866ee39c dt-bindings: imx6q-pcie: Restruct reg and reg-name
17964120885e dt-bindings: imx6q-pcie: Clean up duplicate clocks check
b2e87666166c Merge tag 'qcom-arm32-for-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/dt
d6f0d6fbd771 Merge tag 'v6.9-rockchip-dts32-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
9beae6e4f5b2 Merge tag 'v6.9-rockchip-dts64-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
bfa16e672f23 Merge tag 'riscv-sophgo-dt-for-v6.9' of https://github.com/sophgo/linux into soc/dt
b9a523277cff Merge tag 'mvebu-dt64-6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into soc/dt
472acadc4b85 Merge tag 'mvebu-dt-6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into soc/dt
a1c9c09fe4c6 Merge tag 'renesas-dt-bindings-for-v6.9-tag3' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
ed9768f823d1 Merge tag 'stm32-dt-for-v6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32 into soc/dt
a93afb6c68a1 arm64: dts: qcom: sm8250-xiaomi-elish: set rotation
c1d25c9b315c arm64: dts: qcom: sm8650: Fix SPMI channels size
f203c283f5bb arm64: dts: qcom: sm8550: Fix SPMI channels size
6b3cdc5e247c Merge tag 'drm-misc-next-2024-02-29' into msm-next
0ccaa0050371 dt-bindings: input/touchscreen: imagis: add compatible for IST3032C
f4cd9022dce6 dt-bindings: input/touchscreen: Add compatible for IST3038B
147eff3c7cff dt-bindings: watchdog: sama5d4-wdt: add compatible for sam9x7-wdt
3a9200687cf7 dt-bindings: watchdog: sprd,sp9860-wdt: convert to YAML
cbe08f41aa59 dt-bindings: watchdog: starfive,jh7100-wdt: Add compatible for JH8100
be02d67086d9 dt-bindings: watchdog: arm,sp805: document the reset signal
201c69876dc6 dt-bindings: watchdog: renesas-wdt: Add support for R-Car V4M
653594df87d5 dt-bindings: serial: convert st,asc to DT schema
1a0b7e8acef8 powerpc: dts: akebono: Harmonize EHCI/OHCI DT nodes name
8d179c0b54fb dt-bindings: usb: qcom,dwc3: fix a typo in interrupts' description
c630e9b5a72f arm64: dts: qcom: pm6150: define USB-C related blocks
da1d13674619 dt-bindings: usb: qcom,pmic-typec: Add support for the PM6150 PMIC
d3864961a639 Merge tag 'w1-drv-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1 into tty-next
8f130bd54c7b Merge tag 'iio-for-6.9b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
20d54e06e2a3 Merge tag 'coresight-next-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
c326cc675c68 arm64: dts: rockchip: Fix name for UART pin header on qnap-ts433
3965a283125e dt-bindings: pwm: amlogic: Add a new binding for meson8 pwm types
d397107f4e3a dt-bindings: pwm: amlogic: fix s4 bindings
6d25cc8fd5da dt-bindings: i2c: Remove obsolete i2c.txt
59488a1b3652 dt-bindings: arm: syna: remove unstable remark
1d325ff1ed92 dt-bindings: net: bluetooth: qualcomm: Fix bouncing @codeaurora
9f1d679268ba dt-bindings: watchdog: drop obsolete brcm,bcm2835-pm-wdt bindings
090fc268fac4 dt-bindings: watchdog: qcom-wdt: Update maintainer to Rajendra Nayak
0451b0796a61 dt-bindings: hwmon: lm75: use common hwmon schema
371142306400 Merge tag 'amlogic-arm64-dt-for-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into soc/dt
0e7fe10bc9e6 Merge tag 'amlogic-arm-dt-for-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into soc/dt
d0cb807cfef4 Merge tag 'omap-for-v6.9/dt-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/dt
3578f1b6dbed Merge tag 'ti-k3-dt-for-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/dt
d68c28418b67 riscv: dts: starfive: jh7110: Add camera subsystem nodes
aa86c303373a arm: dts: marvell: clearfog-gtr-l8: align port numbers with enclosure
ae315320f5d1 arm: dts: marvell: clearfog-gtr-l8: add support for second sfp connector
6330d58dd4fe dt-bindings: soc: renesas: renesas-soc: Add pattern for gray-hawk
1a4325f9d215 Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
6d23cfa8897b Merge tag 'at91-dt-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into soc/dt
7632a364f33e Merge tag 'zynqmp-dt-for-6.9' of https://github.com/Xilinx/linux-xlnx into soc/dt
02eba1b4512a Merge tag 'sgx-for-v6.9-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/dt
c0d63be31667 Merge tag 'imx-dt64-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/dt
0d1bd814646e Merge tag 'imx-dt-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/dt
fcd3ba0ec7e6 Merge tag 'imx-bindings-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/dt
911a0e5da311 Merge tag 'socfpga_dts_updates_for_v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into soc/dt
fec957a967a1 dt-bindings: rng: atmel,at91-trng: add sam9x7 TRNG
f25a9445fef8 dt-bindings: crypto: add sam9x7 in Atmel TDES
8790f16edade dt-bindings: crypto: add sam9x7 in Atmel SHA
44266f1d25b2 dt-bindings: crypto: add sam9x7 in Atmel AES
2b1ebc6d769d Merge tag 'qcom-arm64-for-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/dt
43a56bf3bdaf Merge tag 'sunxi-dt-for-6.9-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into soc/dt
e19434848bd8 Merge tag 'drm-msm-next-2024-02-29' of https://gitlab.freedesktop.org/drm/msm into drm-next
01321d44f1ec dt-bindings: net: brcm,asp-v2.0: Add asp-v2.2
d5a543a359ce dt-bindings: net: brcm,unimac-mdio: Add asp-v2.2
089e8a0b0394 dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT schema
925e183d1d3e Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
c44ea78dc972 dt-bindings: rtc: abx80x: convert to yaml
3a25f24b71ce dt-bindings: at91rm9260-rtt: add sam9x7 compatible
6ae5f27fcef7 dt-bindings: rtc: convert MT7622 RTC to the json-schema
8e6eb376128e dt-bindings: rtc: convert MT2717 RTC to the json-schema
dffd03e7b3c3 Merge branch 'icc-sm7150' into icc-next
f8afb1ebc676 dt-bindings: interconnect: Add Qualcomm SM7150 DT bindings
253a470f5420 dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl compatible
f689de1b40f9 dt-bindings: mfd: dlg,da9063: Make #interrupt-cells required
a029ec8c35c4 Merge tag 'tegra-for-6.9-arm64-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/dt
cbda1f9ca478 Merge tag 'tegra-for-6.9-arm-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/dt
061a7ef8ce88 Merge tag 'tegra-for-6.9-dt-bindings' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/dt
2788cdbbf836 Merge tag 'renesas-dts-for-v6.9-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
af467f28aa2e Merge tag 'renesas-dt-bindings-for-v6.9-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
e422e34ebe7a Merge tag 'v6.9-rockchip-dts32-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
15643f4b8b71 Merge tag 'v6.9-rockchip-dts64-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
3b71bcf355d9 Merge tag 'versatile-dts-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator into soc/dt
d73cece0601b Merge tag 'gemini-dts-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator into soc/dt
d5e822510e6a Merge tag 'mtk-dts64-for-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux into soc/dt
88c6586d8ddc Merge tag 'dt-cleanup-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt into soc/dt
485c27391cf2 Merge tag 'samsung-dt-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/dt
9a55de21e5e8 Merge tag 'samsung-dt64-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/dt
7fe0c3cf50e7 Merge tag 'renesas-dts-for-v6.9-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
a28ccc2c8a1e Merge tag 'renesas-dt-bindings-for-v6.9-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
3a1d10b8a7ea dt-bindings: pinctrl: at91: add sam9x7
25fa45a7091a arm64: dts: st: add video encoder support to stm32mp255
374df3f7a69d arm64: dts: st: add video decoder support to stm32mp255
f1523e3d07c3 dt-bindings: gpio: nomadik: add optional reset property
7c456af0e520 dt-bindings: gpio: nomadik: add mobileye,eyeq5-gpio compatible
6412671654fb dt-bindings: gpio: nomadik: add optional ngpios property
33796ff4220d dt-bindings: gpio: nomadik: convert into yaml format
e5443d45c0ec ARM: dts: stm32: enable crypto accelerator on stm32mp135f-dk
fdf13e6831f2 ARM: dts: stm32: enable CRC on stm32mp135f-dk
b5c98471fd1a ARM: dts: stm32: add CRC on stm32mp131
f454b7a85920 dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add bindings
e03c12f18d62 ARM: dts: add stm32f769-disco-mb1166-reva09
690f4c3b681a ARM: dts: stm32: add display support on stm32f769-disco
4cb81b91ac87 ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f769-disco
82d1ed24df95 ARM: dts: stm32: add DSI support on stm32f769
c8114c09da2c dt-bindings: mfd: stm32f7: Add binding definition for DSI
363d4a9715e5 dt-bindings: nt35510: document 'port' property
9059c18b6d10 dt-bindings: iio: gyroscope: bosch,bmg160: add spi-max-frequency
ebcb39d7a66e dt-bindings: iio: adc: imx93: drop the 4th interrupt
2f1ec66e6c94 dt-bindings: iio: adc: drop redundant type from label
d24619ffe43c dt-bindings: iio: ti,tmp117: add optional label property
633fffb7c377 dt-bindings: iio: magnetometer: Add Voltafield AF8133J
a36a9e62abdf dt-bindings: vendor-prefix: Add prefix for Voltafield
2ef6443e1743 dt-bindings: iio: light: vishay,veml6075: make vdd-supply required
c9c055c5470f dt-bindings: iio: adc: adding support for PAC193X
a288cab1e5a6 dt-bindings: iio: hmc425a: add entry for LTC6373
43172d694644 dt-bindings: iio: hmc425a: add conditional GPIO array size constraints
42707bcbabe0 dt-bindings: iio: humidity: hdc20x0: add optional interrupts property
49676274cbd7 dt-bindings: iio: ti,tmp117: add vcc supply binding
6dafe28e7298 dt-bindings: mmc: fsl-imx-mmc: Document the required clocks
620fcff9d53c spi: dt-bindings: atmel,at91rm9200-spi: remove 9x60 compatible from list
22502bd8725d dt-bindings: mmc: fsl-imx-esdhc: add default and 100mhz state
a3da0bec1dd6 arm64: dts: rockchip: Add basic support for QNAP TS-433
e5d58e2bc9d5 dt-bindings: arm: rockchip: Add QNAP TS-433
78b9bf1a6128 arm64: dts: rockchip: add Haikou baseboard with RK3588-Q7 SoM
2ffa10c5e5ad arm64: dts: rockchip: add RK3588-Q7 (Tiger) SoM
7009dfbb88d7 dt-bindings: arm: rockchip: Add Theobroma-Systems RK3588 Q7 with baseboard
2516daa7bde5 arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from rk3588 i2s
fc876128d301 dt-bindings: net: ethernet-controller: drop redundant type from label
13ab34ef0793 arm64: dts: rockchip: fix reset-names for rk356x i2s2 controller
883bb3a0ffc9 arm64: dts: rockchip: add missing interrupt-names for rk356x vdpu
eec8be52f681 arm64: dts: rockchip: add clock to vo1-grf syscon on rk3588
103ec967103c dt-bindings: net: dsa: realtek: add reset controller
3018a826c97d dt-bindings: net: dsa: realtek: reset-gpios is not required
6dc9f167486c dt-bindings: arm: rockchip: Add Toybrick TB-RK3588X
a181bc600877 arm64: dts: rockchip: Add devicetree support for TB-RK3588X board
cc35d14ce704 ARM: dts: rockchip: Wifi improvements for Sonoff iHost
d3e564c6f34a ARM: dts: rockchip: mmc aliases for Sonoff iHost
ca5df862ea65 arm64: dts: rockchip: adjust vendor on orangepi rk3399 board
ed51c83e418c arm64: dts: rockchip: adjust vendor on Banana Pi R2 Pro board
cff456e5f266 dt-bindings: arm: rockchip: Correct vendor for Banana Pi R2 Pro
3522950a8c39 dt-bindings: arm: rockchip: Correct vendor for Orange Pi RK3399 board
82a17c8827d1 arm64: dts: rockchip: Add HDMI0 PHY to rk3588
e66d1e81aed1 arm64: dts: armada-ap807: update thermal compatible
1d32f2a19cc3 arm64: dts: marvell: reorder crypto interrupts on Armada SoCs
35290ca22165 arm64: dts: ac5: add mmc node and clock
f5ba7df64a26 arm: dts: marvell: clearfog-gtr: add missing pinctrl for all used gpios
a64c072c8b1d arm: dts: marvell: clearfog-gtr: sort pinctrl nodes alphabetically
57a80269cb6c arm: dts: marvell: clearfog-gtr: add board-specific compatible strings
9f7d319ef30b arm: dts: marvell: clearfog: add pro variant compatible in legacy dts
ee29a2404550 dt-bindings: marvell: a38x: add solidrun armada 385 clearfog gtr boards
a94644e247d1 dt-bindings: marvell: a38x: add kobol helios-4 board
977f211a8ee3 dt-bindings: marvell: a38x: add solidrun armada 388 clearfog boards
6fe97bf74341 dt-bindings: marvell: a38x: convert soc compatibles to yaml
313957b8c112 Merge branch 'v6.9-shared/clkids' into v6.9-armsoc/dts64
e0f54133c394 dt-bindings: clock: rk3588: add missing PCLK_VO1GRF
e32d677022ca dt-bindings: clock: rk3588: drop CLK_NR_CLKS
4b58a7ccfd97 Merge tag 'mt76-for-kvalo-2024-02-22' of https://github.com/nbd168/wireless
479c5ca5c8ae dt-bindings: arm: amlogic: add Neil, Martin and Jerome as maintainers
39d812837cdd dt-bindings: arm: amlogic: remove unstable remark
54469d99a2af dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo CV1800B and SG2002 support
f4bffe85d2e7 dt-bindings: arm: qcom,coresight-tpdm: Rename qcom,dsb-element-size
7c2c6922effb dt-bindings: memory-controller: st,stm32: add MP25 support
b3f6be88f1f5 Merge 6.8-rc6 into tty-next
f4288db518a8 dt-bindings: net: cdns,macb: add sam9x7 ethernet interface
5315d5ea1db7 dt-bindings: i2c: at91: Add sam9x7 compatible string
b99dd7ccd5b8 dt-bindings: i2c: imx-lpi2c: add i.MX95 LPI2C
d377e1b8336c Convert some regulator drivers to GPIO descriptors
d5220c4662fe dt-bindings: auxdisplay: Add Maxim MAX6958/6959
2f25ffe9d998 dt-bindings: arm-smmu: Document SM8650 GPU SMMU
b4c3aaf580d9 dt-bindings: arm-smmu: fix SM8[45]50 GPU SMMU if condition
0abc1ff2be4e dt-bindings: display/msm/gmu: Document Adreno 750 GMU
ec4f0c02c1ec dt-bindings: display/msm: gpu: Allow multiple digits for patchid
49915776f063 dt-bindings: lcdif: Do not require power-domains for i.MX6ULL
a2a81ebc850d dt-bindings: timer: Add support for cadence TTC PWM
0a54c5eb5a02 Merge tag 'renesas-pinctrl-for-v6.9-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into devel
f12177200edc dt-bindings: interrupt-controller: Add starfive,jh8100-intc
99b3211ce73c regulator: dt-bindings: gpio-regulator: Fix "gpios-states" and "states" array bounds
ca5cca640867 ARM: dts: omap4-panda-common: Enable powering off the device
6b4a8eca637d ARM: dts: omap-embt2ws: system-power-controller for bt200
87c4cebd8708 ARM: dts: omap: Switch over to https:// url
80adf5afe7f6 ARM: dts: ti: omap: add missing abb_{mpu,ivahd,dspeve,gpu} unit addresses for dra7 SoC
a446d52725b5 ARM: dts: ti: omap: add missing sys_32k_ck unit address for dra7 SoC
4d96b742cb3e ARM: dts: ti: omap: add missing phy_gmii_sel unit address for dra7 SoC
7f22c5d06f8d dt-bindings: net: dp83822: support configuring RMII master/slave mode
5a411c0575cc ARM: dts: omap3: Update clksel clocks to use reg instead of ti,bit-shift
43768eba3fa4 ARM: dts: am3: Update clksel clocks to use reg instead of ti,bit-shift
0f8d14846135 Merge v6.8-rc6 into drm-next
5ac99b57e27a dt-bindings: mtd: brcmnand: Add ecc strap property
d973f6e60329 dt-bindings: mtd: brcmnand: Add WP pin connection property
e8cf96a62e99 dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
4284b95c3a7d dt-bindings: mtd: st,stm32: add MP25 support
5ffc0c6588e1 dt-bindings: mtd: update references from partition.txt to mtd.yaml
079feabfa500 arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3
77aac4df148c arm64: dts: add description for solidrun am642 som and evaluation board
bab419b95c2c dt-bindings: arm: ti: Add bindings for SolidRun AM642 HummingBoard-T
bc85817742eb dt-bindings: mtd: spi-nor: add optional interrupts property
201ac0128678 dt-bindings: pwm: opencores: Add compatible for StarFive JH8100
c0aae9685a91 dt-bindings: riscv: cpus: reg matches hart ID
8e0b9c610742 dt-bindings: bus: imx-weim: convert to YAML
c622150ed65c Merge v6.8-rc6 into usb-next
09994ac519e2 arm64: dts: imx8mm-kontron-bl-osm-s: Fix Ethernet PHY compatible
c8b82b8dd480 arm64: dts: imx8-apalis-v1.1: Remove reset-names from ethernet-phy
20cdb2916423 ARM: dts: nxp: imx: fix weim node name
064185347fff ARM: dts: nxp: imx6ul: fix touchscreen node name
42a236fd930d ARM: dts: nxp: imx6ul: xnur-gpio -> xnur-gpios
d9725dc952ee ARM: dts: imx6ul: Remove fsl,anatop from usbotg1
6cc27853e1c4 ARM: dts: imx6ull: fix pinctrl node name
c23b15b18c81 ARM: dts: imx1-apf9328: Fix Ethernet node name
7c8b8cf4dd15 ARM: dts: imx28-evk: Use 'eeprom' as the node name
102744f8003d ARM: dts: ls1021a: Enable usb3-lpm-capable for usb3 node
4822eab2af53 Merge branch 'icc-cleanup' into icc-next
0b20018b1dbc dt-bindings: mtd: ubi-volume: allow UBI volumes to provide NVMEM
5d1f49b1b6b0 dt-bindings: mtd: add basic bindings for UBI
9a35e12f4b1a dt-bindings: hwmon: reference common hwmon schema
3d36f23ac624 dt-bindings: hwmon: lltc,ltc4286: use common hwmon schema
798f72d666b8 dt-bindings: hwmon: adi,adm1275: use common hwmon schema
809baabdec34 dt-bindings: hwmon: ti,ina2xx: use common hwmon schema
42d06958b709 dt-bindings: hwmon: add common properties
f567e7a0ce93 regulator: dt-bindings: promote infineon buck converters to their own binding
b1715c2bbc33 dt-bindings: hwmon/pmbus: ti,lm25066: document regulators
0c5601d53cce dt-bindings: hwmon: nuvoton,nct6775: Add compatible value for NCT6799
fb5eada36609 dt-bindings: trivial-devices: add Astera Labs PT5161L
7d3134823476 dt-bindings: vendor-prefixes: add asteralabs
c75f1a591ccd dt-bindings: hwmon: Add Amphenol ChipCap 2
737f7b7c7c23 dt-bindings: vendor-prefixes: add Amphenol
380e45011084 dt-bindings: Add MPQ8785 voltage regulator device
adb144c788f3 dt-bindings: clock: exynos850: Add CMU_CPUCLK0 and CMU_CPUCL1
77ced3f45487 dt-bindings: arm: add UNI-T UTi260B
521023b8972b dt-bindings: vendor-prefixes: add UNI-T
10a08d63eb50 arm64: dts: imx8mp-evk: Fix hdmi@3d node
96099eef1a2c arm64: dts: imx93-var-som: Remove phy-supply from eqos
0ee187cdb35f Merge tag 'iio-for-6.9a' of http://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
9aa0ba8c3e6a arm64: dts: imx8mp-phyboard-pollux: Disable pull-up for CD GPIO
195bcec93c44 arm64: dts: imx8mp-phyboard-pollux: Reduce drive strength for eqos tx lines
adb0eb622cec arm64: dts: imx8mp-phyboard-pollux: Set debug uart muxing to 0x140
8032acfdf1a8 arm64: dts: imx8mp-phyboard-pollux: Add and update rtc devicetree node
9ffab265f1ac arm64: dts: imx8mm-evk: Add spdif sound card support
3f1b2e8d9e29 arm64: dts: mba8xx: Add missing #interrupt-cells
dd5af1f60a28 arm64: dts: imx8mp: Set SPI NOR to max 40 MHz on Data Modul i.MX8M Plus eDM SBC
f461418b3107 ARM: dts: imx6dl-yapp4: Move the internal switch PHYs under the switch node
dbaddd2cc383 ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address
6a28d56cd75a arm64: dts: imx8mn: tqma8mqnl-mba8mx: Add USB DR overlay
68f02dd7e55f arm64: dts: imx8mq: tqma8mq-mba8mx: Add missing USB vbus supply
06e63f07db24 arm64: dts: freescale: imx8mm/imx8mq: mba8mx: Use PCIe clock generator
65f27cc9ca1b arm64: dts: imx8mn-beacon: Remove unnecessary clock configuration
ec091103f662 arm64: dts: imx8mn: Slow default video_pll clock rate
f3ed68d12445 arm64: dts: imx8mp-beacon: Configure multiple queues on eqos
825a35212289 arm64: dts: imx8mp-beacon: Enable Bluetooth
e32a570a61aa ARM: dts: imx6ul: Set macaddress location in ocotp
48b05a3282bd arm64: dts: freescale: minor whitespace cleanup
4b0cf920e774 arm64: dts: allwinner: h616: Add thermal sensor and zones
d0665f60cec0 ARM: dts: sun8i: Open FETA40i-C regulator aldo1
f0c099b60ae3 arm64: dts: allwinner: h616: Add Sipeed Longan SoM 3H and Pi 3H board support
01ae6c03a880 dt-bindings: arm: sunxi: Add Sipeed Longan Module 3H and Longan Pi 3H
c763b1cf0ca7 arm64: dts: allwinner: h616: minor whitespace cleanup
fba9e58bbd03 arm64: dts: allwinner: use capital "OR" for multiple licenses in SPDX
c6b7cf5d4b69 arm64: dts: allwinner: Transpeed 8K618-T: add WiFi nodes
13d73fcac8c9 arm64: dts: allwinner: h616: Add 32K fanout pin
05bdbb1eb3fd arm64: dts: allwinner: Add Jide Remix Mini PC support
0df51b232403 dt-bindings: arm: sunxi: document Remix Mini PC name
898b36322bb2 dt-bindings: vendor-prefixes: add Jide
70e735bb236e arm64: dts: allwinner: h616: Add SPDIF device node
10969c04cb6e arm64: dts: allwinner: h616: Add DMA controller and DMA channels
c5182cdc0aa8 arm64: dts: allwinner: h6: Add RX DMA channel for SPDIF
e31d5ca612d6 dt-bindings: sram: narrow regex for unit address to hex numbers
013b1096017d ARM: dts: microchip: sama7g5: add sama7g5 compatible
782f527e1b30 ARM: dts: microchip: sam9x60: align dmas to the opening '<'
d08950521775 ARM: dts: microchip: sama7g5: align dmas to the opening '<'
c9cdb533541e ARM: dts: microchip: sama7g54_curiosity: Add initial device tree of the board
28a13f689e75 ARM: dts: microchip: sama7g5: Add flexcom 10 node
57fb3296fc2d ASoC: dt-bindings: microchip: add sam9x7
81a8f19d991d ASoC: dt-bindings: atmel-classd: add sam9x7 compatible
c1e8427eb3df dt-bindings: ARM: at91: Document Microchip SAMA7G54 Curiosity
708077cf30a4 arm64: tegra: Remove Jetson Orin NX and Jetson Orin Nano DTSI
14b1c490371e arm64: tegra: Add audio support for Jetson Orin NX and Jetson Orin Nano
5bdc0a8fed68 arm64: tegra: Define missing IO ports
8ff1bf770a0c arm64: tegra: Move AHUB ports to SoC DTSI
9fd53de0ed30 arm64: tegra: Add USB Type-C controller for Jetson AGX Xavier
6c9a92242095 arm64: tegra: Add USB device support for Jetson AGX Xavier
495a87da7a47 arm64: tegra: Add current monitors for Jetson Xavier
426c1ddbd76b arm64: tegra: Add AXI configuration for Tegra234 MGBE
134b7a20eea2 dt-bindings: mfd: Convert atmel-flexcom to json-schema
7268c6969288 dt-bindings: mfd: cros-ec: Add properties for GPIO controller
a5c0c33c25f1 dt-bindings: mfd: ti,twl: Document system-power-controller
507cf9210c91 dt-bindings: net: wireless: qcom: Update maintainers
a9219f105d93 dt-bindings: mfd: syscon: Add ti,am654-serdes-ctrl compatible
37c3dbbbca5d dt-bindings: mfd: syscon: Add ti,j784s4-pcie-ctrl compatible
ef9712ce90c9 dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
fc3911fb624f dt-bindings: mfd: qcom,tcsr: Add compatibles for QCM2290 and SM6115
bcc7a549de96 dt-bindings: mfd: iqs62x: Do not override firmware-name $ref
e3889bfdf9d5 dt-bindings: media: rkisp1: Add i.MX8MP ISP to compatible
e7d16b884c9d dt-bindings: timer: add Ralink SoCs system tick counter
f4535baea464 dt-bindings: PCI: qcom,pcie-sa8775p: Move SA8775p to dedicated schema
169fa31aecaa dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema
9a6e22b46113 dt-bindings: PCI: qcom,pcie-sc8180x: Move SC8180X to dedicated schema
e114fb24a186 dt-bindings: PCI: qcom,pcie-sc8280xp: Move SC8280XP to dedicated schema
88e9e05efe99 dt-bindings: PCI: qcom,pcie-sm8350: Move SM8350 to dedicated schema
977832dca6ab dt-bindings: PCI: qcom,pcie-sm8150: Move SM8150 to dedicated schema
53908f6ff54c dt-bindings: PCI: qcom,pcie-sm8250: Move SM8250 to dedicated schema
96931e6b08ab dt-bindings: PCI: qcom,pcie-sm8450: Move SM8450 to dedicated schema
3c9f28bcffc2 dt-bindings: PCI: qcom,pcie-sm8550: Move SM8550 to dedicated schema
c2f1d4a9447a arm64: dts: renesas: rzg2l-smarc: Enable DU and link with DSI
b39f9a0e920d arm64: dts: renesas: r9a07g054: Add DU node
3ecd2f1980c9 arm64: dts: renesas: r9a07g044: Add DU node
93d319ea783c arm64: dts: lx2160a: Fix DTS for full PL011 UART
8365edf2f65e arm64: dts: ls1088a: Add the PME interrupt for PCIe EP node
084a47a95058 arm64: dts: imx8qm: add i2c1 for imx8qm-mek board
d84b45a3c712 arm64: dts: imx8qm: add i2c4 and i2c4_lpcg node
9d3bb1c53622 ASoC: Revert "ASoC: dt-bindings: Update example for enabling USB offload on SM8250"
7ada2cb724f2 riscv: dts: add resets property for uart node
a034d20d33af riscv: dts: add reset generator for Sophgo SG2042 SoC
b312f7c28451 ARM: dts: imx53-qsb: add support for the HDMI expander
65d763356aad arm64: dts: imx8mp: Enable SAI audio on Data Modul i.MX8M Plus eDM SBC
c3b757a52529 arm64: dts: imx8: Fix lpuart DMA channel order
a9c570888e1c arm64: dts: freescale: imx8-ss-dma: Fix edma3's location
1880684dfc18 arm64: dts: imx8dxl update edma0 information
95a51114540e arm64: dts: imx8dxl: add fsl-dma.h dt-binding header file
87cc839ce871 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
595539769055 dt-bindings: vendor-prefixes: Add missing prefixes used in compatibles
2b8f61f2af78 dt-bindings: display: convert Atmel's HLCDC to DT schema
d4e9fb508b98 dt-bindings: display/msm: Document MDSS on X1E80100
26ae54a934e7 dt-bindings: display/msm: Document the DPU for X1E80100
eec4611e4fa5 dt-bindings: arm-smmu: Document SM8650 GPU SMMU
011fc2593f52 dt-bindings: arm-smmu: Fix SM8[45]50 GPU SMMU 'if' condition
f45f80911a1e ARM: tegra: Add device-tree for LG Optimus 4X HD (P880)
c99ab6147bdd ARM: tegra: Add device-tree for LG Optimus Vu (P895)
9668ead0c4a9 ARM: tegra: nexus7: Add missing clock binding into sound node
1a7c7ca1209d dt-bindings: arm: tegra: Add LG Optimus Vu P895 and Optimus 4X P880
55fa85648879 arm64: dts: Add gpio_intc node for Amlogic-T7 SoCs
3040579f9058 dt-bindings: interrupt-controller: Add support for Amlogic-T7 SoCs
ac30a4ade02e dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update interrupts
cf713971ea71 dt-bindings: arm-smmu: Add QCM2290 GPU SMMU
cfbcf932a683 arm64: dts: renesas: gray-hawk-single: Add QSPI FLASH support
7b0d1d64e101 arm64: dts: renesas: r8a779h0: Add RPC node
cf8ea631a9d7 arm64: dts: renesas: r8a779h0: Add DMA support
44de0122e321 arm64: dts: renesas: gray-hawk-single: Add eMMC support
697c226a4355 arm64: dts: renesas: r8a779h0: Add SD/MMC node
bc3ce3810946 ARM: dts: renesas: r8a7778: Add missing reg-names to sound node
59d2898af1c8 arm64: dts: renesas: rzg2ul-smarc: Enable CRU, CSI support
e4684cc943fe arm64: dts: renesas: gray-hawk-single: Add Ethernet support
08896ba8e650 arm64: dts: renesas: r8a779h0: Add Ethernet-AVB support
fe2d22e4ae91 arm64: dts: renesas: r8a779g0: Correct avb[01] reg sizes
4c2e92819772 arm64: dts: renesas: r8a779a0: Correct avb[01] reg sizes
d857aea85b27 arm64: dts: renesas: r9a08g045: Add PSCI support
ac45f97b1f9c arm64: dts: renesas: rzg3s-smarc-som: Guard Ethernet IRQ GPIO hogs
aef97a58051b arm64: dts: renesas: r9a08g045: Add missing interrupts to IRQC node
68b5a3b20687 arm64: dts: renesas: rzg2l: Add missing interrupts to IRQC nodes
5a4108c215f6 arm64: dts: renesas: r8a779h0: Add CA76 operating points
bd25260cfef9 arm64: dts: renesas: r8a779h0: Add CPU core clocks
291552f30777 arm64: dts: renesas: r8a779h0: Add CPUIdle support
20170eff3c40 arm64: dts: renesas: r8a779h0: Add secondary CA76 CPU cores
4c3851d7302a arm64: dts: renesas: r8a779h0: Add L3 cache controller
149125c48481 arm64: dts: renesas: r8a779h0: Add GPIO nodes
e6842397bea1 arm64: dts: renesas: gray-hawk-single: Add I2C0 and EEPROMs
4ab7a0fae505 arm64: dts: renesas: r8a779h0: Add I2C nodes
4f678406736f arm64: dts: renesas: ulcb-kf: Adapt sound 5v regulator to schematics
ab5123a5fcbb arm64: dts: renesas: ulcb-kf: Adapt 1.8V HDMI regulator to schematics
36bd3f79100c arm64: dts: renesas: ulcb-kf: Add regulators for PCIe ch1
d79c233e5296 arm64: dts: renesas: gray-hawk-single: Add serial console pin control
adb055f45503 arm64: dts: renesas: r8a779h0: Add pinctrl device node
393149daa9ec dt-bindings: net: wireless: mt76: allow all 4 interrupts for MT7981
abc93201d108 dt-bindings: net: wireless: mt76: add interrupts description for MT7986
6ff46183ee46 dt-bindings: memory: renesas,rpc-if: Document R-Car V4M support
caaf33bab010 dt-bindings: reset: mobileye,eyeq5-reset: add bindings
d627a28b5d6f dt-bindings: clock: mobileye,eyeq5-clk: add bindings
ebd3bcd073ce dt-bindings: clock: ast2600: Add FSI clock
d19d06cdbb21 dt-bindings: reset: mediatek: add MT7988 infracfg reset IDs
f907dd749888 dt-bindings: clock: mediatek: convert SSUSBSYS to the json-schema clock
77f559281267 dt-bindings: clock: mediatek: convert PCIESYS to the json-schema clock
5776acd8f40b dt-bindings: clock: mediatek: convert hifsys to the json-schema clock
2b71a4051c65 dt-bindings: arm: realview: Spelling s/ARM 11/Arm11/, s/Cortex A-/Cortex-A/
d5d9be3159cd ARM: dts: integrator: Fix up VGA connector
e7ff0fa9dc10 ARM: dts: versatile: Fix up VGA connector
5cc0ca358e86 ARM: dts: arm: realview: Fix development chip ROM compatible value
17690d898c6b arm64: dts: ti: k3-am62p: Add Wave5 Video Encoder/Decoder Node
1a04d9e2ea04 arm64: dts: ti: k3-j721s2-main: Add Wave5 Video Encoder/Decoder Node
037f82133c88 arm64: dts: ti: k3-j784s4: Add Wave5 Video Encoder/Decoder Node
b9b4934fd72d arm64: dts: ti: k3-am69-sk: Add support for OSPI flash
54bdd26cd110 arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board
5ddb529be866 arm64: dts: ti: k3-am62p: Add nodes for CSI-RX
2bc64591456d arm64: dts: ti: k3-am62p: Add DMASS1 for CSI
fb6e8cb37b07 arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS
4a664d32a079 arm64: dts: ti: k3-j722s-evm: Enable OSPI NOR support
0a3c08b6205b arm64: dts: ti: k3-j722s-evm: Enable CPSW3G RGMII1
6d9068d2f3e7 arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in serdes_ln_ctrl
8f04b7849578 arm64: dts: ti: k3-j721e: Fix mux-reg-masks in hbmc_mux
c3982938ea86 dt-bindings: display: renesas,rzg2l-du: Document RZ/V2L DU bindings
62d59754ec63 dt-bindings: display: Document Renesas RZ/G2L DU bindings
b9138e8af159 arm64: tegra: Use consistent SD/MMC aliases on Tegra234
dcff839661ba arm64: dts: amlogic: add fbx8am DT overlays
0d16b6bd5803 ARM: dts: gemini: Fix switch node names on Vitesse switches
81e1d1cfd2f9 ARM: dts: gemini: Map reset keys to KEY_RESTART
915ebb1bf1e0 ARM: dts: gemini: Fix wiligear compatible strings
d8869f38c863 ARM: dts: gemini: Fix switch node names in the DIR-685
4466332a360b ASoC: dt-bindings: qcom,wsa8840: Add reset-gpios for shared line
8d8332ce62c5 dt-bindings: reset: sophgo: support SG2042
357d5bbac5af ASoC: Intel: avs: Fixes and new platforms support
ed4851e1d924 regulator: dt-bindings: qcom,usb-vbus-regulator: add support for PM4125
bcf5ae8600f6 regulator: dt-bindings: qcom,usb-vbus-regulator: add support for PM4125
90ad8fbfa7f9 Merge tag 'memory-controller-drv-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
6a8fb7b89e73 arm64: dts: qcom: sm6115: fix USB PHY configuration
0dc3ecab7183 Merge tag 'linux-can-next-for-6.9-20240220' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
f923d17647b5 MIPS: mobileye: Add EPM5 device tree
885d1e731299 MIPS: mobileye: Add EyeQ5 dtsi
7fb9ce7c1dde dt-bindings: mips: Add bindings for Mobileye SoCs
e3797e6a3708 dt-bindings: mips: cpu: Add I-Class I6500 Multiprocessor Core
9a705909b63d dt-bindings: mips: cpus: Sort the entries
e0340332869b dt-bindings: Add vendor prefix for Mobileye Vision Technologies Ltd.
011bf078c7bc dt-bindings: pinctrl: renesas,pfc: Document R-Car V4M support
49888873d596 dt-bindings: net: fec: add iommus property
80733980e6ba dt-bindings: iio: adc: ti-ads1298: Add bindings
26a3005ca5c0 dt-bindings: iio: pressure: honeywell,hsc030pa.yaml add spi props
d64846638639 dt-bindings: adc: axi-adc: update bindings for backend framework
a3fc6ec1428b dt-bindings: adc: ad9467: add new io-backend property
c0d436471a5f regulator: Merge up v6.8-rc5
52dcafce5828 dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM6150 compatible
66f7b7966dfc arm64: dts: ti: Add common1 register space for AM62A SoC
6b911cea73bb arm64: dts: ti: Add common1 register space for AM62x SoC
bb6e999b30ab arm64: dts: ti: Add common1 register space for AM65x SoC
2a98a4ff884d arm64: dts: mt8195-cherry-tomato: change watchdog reset boot flow
b5c66885729f dt-bindings: display: simple: Add boe,bp082wx1-100 8.2" panel
0b9a359a81b7 dt-bindings: display: ti,am65x-dss: Add support for common1 region
0033e16adcd4 dt-bindings: renesas: Document preferred compatible naming
1771fa16d31e dt-bindings: ata: convert MediaTek controller to the json-schema
127ae13f4e5e arm64: dts: mt7986: add port@5 as CPU port
57f255ff84ed arm64: dts: mt7622: add port@5 as CPU port
1e471beb8eea ARM: dts: meson8b: fix &hwrng node compatible string
320da6153b8a ARM: dts: meson8: fix &hwrng node compatible string
9625cfa0c727 ARM: dts: meson: fix bus node names
f496b04c1652 arm64: dts: amlogic: add fbx8am board
686e2be425fd dt-bindings: arm: amlogic: add fbx8am binding
48371b0670ac dt-bindings: vendor-prefixes: add freebox
471f9b9dd5e2 arm64: dts: amlogic: replace underscores in node names
6e0fb3cc9b68 arm64: dts: ti: k3-am642-evm: add overlay for ICSSG1 2nd port
7526121625ee dt-bindings: interconnect: qcom,rpmh: Fix bouncing @codeaurora address
fcda7c3e7ef7 Merge 6.8-rc5 into usb-next
670cbcdfbb09 arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet support
cea3277e3b5e arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes
eb0aea3a7c5a Merge 6.8-rc5 into tty-next
c07c11c8be59 arm64: dts: ti: k3-am6*: Add bootph-all property in MMC node
59d465b82cb4 arm64: dts: ti: k3-am6*: Fix bus-width property in MMC nodes
16af8c673aff arm64: dts: ti: k3-am6*: Fix ti,clkbuf-sel property in MMC nodes
87f154491e63 arm64: dts: ti: k3-am6*: Remove DLL properties for soft PHYs
722bd88c8fab arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC
18c8263c1ec1 arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC
73f1cbbcb198 arm64: dts: ti: k3-am62a7-sk: Enable eMMC support
973681d9002a arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
4430a5c5a0ec arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
be340f86aaf1 arm64: dts: sm8650: Add msi-map-mask for PCIe nodes
49cf8bb8b63f arm64: dts: qcom: replace underscores in node names
8f9d0aa368d0 ARM: dts: qcom: samsung-matisse-common: Add UART
ce30f2d31d9c ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 LTE (SM-T535)
afbdd6233c4a ARM: dts: qcom: samsung-matisse-common: Add initial common device tree
6a80ca4b242a dt-bindings: arm: qcom: Add Samsung Galaxy Tab 4 10.1 LTE
3cef33d6916c dt-bindings: soc: qcom: qcom,saw2: add msm8226 l2 compatible
e4d2d663cf96 arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in wkup_uart0
d43ac341179d arm64: dts: ti: k3-j721s2-common-proc-board: Remove Pinmux for CTS and RTS in wkup_uart0
80e20b3b69c9 arm64: dts: ti: k3-j7200-common-proc-board: Remove clock-frequency from mcu_uart0
35877fcaea3a arm64: dts: ti: k3-j7200-common-proc-board: Modify Pinmux for wkup_uart0 and mcu_uart0
cac67785c0a6 arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219
b1d7814ca372 arm64: dts: ti: k3-j784s4-main: Add CSI2RX capture nodes
b6b2d86e2411 arm64: dts: ti: k3-j721s2-main: Add CSI2RX capture nodes
58403c60add6 arm64: dts: ti: k3-j721e-main: Add CSI2RX capture nodes
4796014c5f92 arm64: dts: ti: k3-j721e-sk: Model CSI2RX connector mux
b599ef1ba8ff arm64: dts: ti: k3-am69-sk: Enable camera peripherals
248c870c7bd6 arm64: dts: ti: k3-am68-sk-base-board: Enable camera peripherals
a5f6b550f77b arm64: dts: ti: k3-j784s4-evm: Enable camera peripherals
f70c4ae50ecf arm64: dts: ti: k3-j721s2-common-proc-board: Enable camera peripherals
4141c6b09a96 dt-bindings: i3c: drop "master" node name suffix
f3ca3a16bd19 dt-bindings: timer: nxp,sysctr-timer: support i.MX95
19b1a141c8dd dt-bindings: usb: qcom,pmic-typec: add support for the PMI632 block
15c348192cc2 dt-bindings: regulator: qcom,usb-vbus-regulator: add support for PMI632
3c201cdbc89a dt-bindings: iio: humidity: hdc3020: add interrupt bindings in example
0fc77339f456 dt-bindings: iio: afe: voltage-divider: Add io-channel-cells
7adf6f669393 dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1
bd37e5428ced dt-bindings: iio: frequency: add admfm2000
f6c7124a3d91 dt-bindings: usb/ti,am62-usb.yaml: Add PHY2 register space
3102faf7d698 dt-bindings: usb: microchip,usb5744: Remove peer-hub as requirement
d403cb0d5128 arm64: dts: qcom: qcm6490-fairphone-fp5: Add PMIC GLINK
7ab947b60396 dt-bindings: usb: dwc3: drop 'snps,host-vbus-glitches-quirk'
e007ca0c7920 ASoC: dt-bindings: Update example for enabling USB offload on SM8250
14bd5c629408 ASoC: dt-bindings: Add Q6USB backend
86b2f37571d9 arm64: dts: ti: Add reserved memory for watchdog
0ffb30594139 arm64: dts: qcom: pm4125: define USB-C related blocks
437f7c2c748a arm64: dts: qcom: sa8540p-ride: disable pcie2a node
ddc97b021a4f arm64: dts: qcom: sc7280: add slimbus DT node
174b19d0a453 dt-bindings: display: ltk500hd1829: add variant compatible for ltk101b4029w
9990fd362767 dt-bindings: display: panel-lvds: Add compatible for admatec 9904370 panel
3a9936a295c2 dt-bindings: vendor-prefixes: add prefix for admatec GmbH
11b2a690403f arm64: dts: qcom: sc7280: Add capacity and DPC properties
23437543023d ARM: dts: qcom: ipq8064: drop 'regulator' property from SAW2 devices
cabc075cf325 ARM: dts: qcom: ipq4019: drop 'regulator' property from SAW2 devices
484c003d94ab ARM: dts: qcom: msm8974: drop 'regulator' property from SAW2 device
6445cb8886be ARM: dts: qcom: apq8084: drop 'regulator' property from SAW2 device
98ba5545146c ARM: dts: qcom: msm8960: declare SAW2 regulators
b54dea12770f ARM: dts: qcom: apq8064: declare SAW2 regulators
4dce2cf9f83d ARM: dts: qcom: ipq8064: rename SAW nodes to power-manager
5b13a9611268 ARM: dts: qcom: ipq4019: rename SAW nodes to power-manager
0ec0f547bc86 ARM: dts: qcom: msm8974: rename SAW nodes to power-manager
9c6828f9c895 ARM: dts: qcom: msm8960: rename SAW nodes to power-manager
d5acf25ed148 ARM: dts: qcom: apq8084: rename SAW nodes to power-manager
643db1cecca9 ARM: dts: qcom: apq8064: rename SAW nodes to power-manager
4de620145e88 ARM: dts: qcom: ipq8064: use SoC-specific compatibles for SAW2 devices
c44fb47e47a5 ARM: dts: qcom: ipq4019: use SoC-specific compatibles for SAW2 devices
5e99522aa387 ARM: dts: qcom: msm8960: use SoC-specific compatibles for SAW2 devices
75a6d010f715 ARM: dts: qcom: msm8974: use new compat string for L2 SAW2 unit
9eb4395e3cbc ARM: dts: qcom: apq8084: use new compat string for L2 SAW2 unit
0cc21b045573 arm64: dts: qcom: pmi632: Add PBS client and use in LPG node
adaff156bd89 arm64: dts: qcom: sm8550: Use GIC-ITS for PCIe0 and PCIe1
567a4e2c1bfd arm64: dts: qcom: sm8150: correct PCIe wake-gpios
aff4851c71af arm64: dts: qcom: sdm845-db845c: correct PCIe wake-gpios
d12e2e81b378 dt-bindings: soc: qcom: qcom,saw2: define optional regulator node
87cb0efb080c dt-bindings: soc: qcom: qcom,saw2: add missing compatible strings
78779d5162e9 dt-bindings: soc: qcom: merge qcom,saw2.txt into qcom,spm.yaml
90689200835c arm64: dts: qcom: sm7225-fairphone-fp4: Enable display and GPU
49fc8baa3dd8 arm64: dts: qcom: sm6350: Remove "disabled" state of GMU
3bb88ee4bafc dt-bindings: clk: qcom: drop the SC7180 Modem subsystem clock controller
08488eb0c95c arm64: dts: qcom: msm8916-samsung-fortuna/rossa: Add fuel gauge
9230383364ef arm64: dts: qcom: sm6350: Add interconnect for MDSS
93d1070a237b dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
09c2905a6449 dt-bindings: renesas,rcar-dmac: Add r8a779h0 support
8500691f667d dt-bindings: dma: convert MediaTek High-Speed controller to the json-schema
7b382eea018b arm64: tegra: Enable cros-ec-spi as wake source
73f09474de21 ARM: tegra: Enable cros-ec-spi as wake source
9c3c23577ad9 dt-bindings: tegra: pmc: Update scratch as an optional aperture
296aea7e0f2a dt-bindings: display: panel: Add Himax HX83112A
5b0ce634f06d dt-bindings: phy: Add Rockchip HDMI/eDP Combo PHY schema
01f41446bb7f Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
87dd58b7c6ca dt-bindings: mmc: renesas,sdhi: Document R-Car V4M support
ec136bb18fcc arm64: dts: ti: Add support for TI J722S Evaluation Module
4dd9e11aa40f arm64: dts: ti: Introduce J722S family of SoCs
1339c374a4c1 dt-bindings: arm: ti: Add bindings for J722S SoCs
723c10f0bd63 arm64: dts: ti: iot2050: Support IOT2050-SM variant
4a95da5a5df9 arm64: dts: ti: iot2050: Annotate LED nodes
a2119b7f92bd arm64: dts: ti: iot2050: Factor out DP related bits
a3f672abd86f arm64: dts: ti: iot2050: Factor out enabling of USB3 support
0f7fd425cef9 arm64: dts: ti: iot2050: Factor out arduino connector bits
326a69a3e459 arm64: dts: ti: iot2050: Disable R5 lockstep for all PG2 boards
9f6227cced13 dt-bindings: arm: ti: Add binding for Siemens IOT2050 SM variant
4c8ad6e37e97 arm64: dts: ti: k3-am62-main: disable usb lpm
58003d5a29e5 arm64: dts: ti: verdin-am62: Set VDD CORE minimum voltage to 0.75V
09148e5825bc arm64: dts: ti: k3-am62-wakeup: Configure ti-sysc for wkup_uart0
8d7152a47403 arm64: dts: ti: am62-phyboard-lyra: Add overlay to enable a GPIO fan
16c636f5b152 arm64: dts: ti: k3-j721e-sk: fix PMIC interrupt number
2932b4306805 arm64: dts: ti: k3-am69-sk: fix PMIC interrupt number
f6c375e9f85d arm64: dts: ti: verdin-am62: add support for Verdin USB1 interface
309045be68da arm64: dts: ti: Add DT overlay for PCIe + USB3.0 SERDES personality card
2979217a850f arm64: dts: ti: Add DT overlay for PCIe + USB2.0 SERDES personality card
b70ff6a5d411 dt-bindings: w1: UART 1-Wire bus
21e00d907bfb dt-bindings: serial: allow onewire as child node
1f162c88f711 dt-bindings: pwm: mediatek,mt2712: add compatible for MT7988
b69225cd6653 dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema
4fc4f31db241 dt-bindings: pxa-pwm: Convert to YAML
61f4ac7c5c90 ARM: dts: vexpress: Set stdout-path to serial0 in the chosen node
199bf4b635e6 arm64: dts: mediatek: Replace deprecated extcon-usb-gpio id-gpio/vbus-gpio properties
73d46717fb3d ARM: dts: qcom: msm8226: Add watchdog node
01815a93d9ab dt-bindings: auxdisplay: hit,hd44780: use defines for GPIO flags
41e657a00f9c dt-bindings: auxdisplay: adjust example indentation and use generic node names
81b0dd090434 arm64: dts: qcom: msm8916-samsung-fortuna/rossa: Add initial device trees
3fa556edfd69 arm64: dts: qcom: sm8550: Switch UFS from opp-table-hz to opp-v2
8761bb9477f3 arm64: dts: qcom: sc8180x: describe all PCI MSI interrupts
3419b50ca541 arm64: dts: qcom: minor whitespace cleanup
1a30651d27f6 arm64: dts: qcom: ssm7125-xiaomi: drop incorrect UFS phy max current
8f644a3c370b arm64: dts: qcom: x1e80100-crd: add sound card
22e29ff5c4c3 arm64: dts: x1e80100: correct DMIC2 and DMIC3 pin config node names
b32ccff427b3 arm64: dts: sm8650: correct DMIC2 and DMIC3 pin config node names
8b41c24a5900 arm64: dts: sm8550: correct DMIC2 and DMIC3 pin config node names
d0bad83ec278 arm64: dts: sm8450: correct DMIC2 and DMIC3 pin config node names
736ebb0686f6 arm64: dts: sc8280xp: correct DMIC2 and DMIC3 pin config node names
33ef3b7fb778 dt-bindings: can: tcan4x5x: Document the wakeup-source flag
11322433ed0f dt-bindings: net: dp83826: support TX data voltage tuning
a745442704dd ARM: dts: stm32: lxa-tac: reduce RGMII interface drive strength
bdbd2fbe2a1f arm64: dts: mediatek: replace underscores in node names
bb7b4de1613f pmdomain: Merge branch dt into next
20b8bae8b8eb arm64: dts: ti: k3-am62a: Make the main_conf node a simple-bus
e42f80bc5bcf arm64: dts: ti: k3-am62: Make the main_conf node a simple-bus
8ba7dd15abdd arm64: dts: ti: k3-j7200: Make the FSS node a simple-bus
42ed47d60a80 arm64: dts: ti: k3-j721s2: Convert serdes_ln_ctrl node into reg-mux
bf6f8e6f98e5 arm64: dts: ti: k3-j721s2: Convert usb_serdes_mux node into reg-mux
0167a788d9c5 arm64: dts: ti: k3-j721e: Convert usb_serdes_mux node into reg-mux
124c59a52517 arm64: dts: ti: k3-j721e: Convert serdes_ln_ctrl node into reg-mux
ebb5990bd126 arm64: dts: ti: k3-j7200: Convert usb_serdes_mux node into reg-mux
c0c92c3b24bd arm64: dts: ti: k3-j7200: Convert serdes_ln_ctrl node into reg-mux
8c7e27a256ed arm64: dts: ti: k3-am64: Convert serdes_ln_ctrl node into reg-mux
ecaaf99dee6f arm64: dts: mediatek: mt8186: Add missing xhci clock to usb controllers
546dd2b71775 arm64: dts: mediatek: mt8186: Add missing clocks to ssusb power domains
845392fb2a8c ARM: dts: qcom: msm8960: expressatt: Add mXT224S touchscreen
a5fc0fcda8d3 ARM: dts: qcom: msm8960: Add gsbi3 node
e5357a45e304 ARM: dts: qcom: msm8226: Add CPU and SAW/ACC nodes
df98c13b52f1 ARM: dts: qcom: msm8226: Sort and clean up nodes
4250f1c8ff79 ARM: dts: qcom: msm8974: correct qfprom node size
7d8cff577be7 dt-bindings: arm: qcom,ids: Add IDs for SM8475 family
ee8caed03c87 arm64: dts: qcom: sdm845: Enable cros-ec-spi as wake source
6eef1cbc79c9 arm64: dts: qcom: sc7280: Enable cros-ec-spi as wake source
097f3128d091 arm64: dts: qcom: sc7180: Enable cros-ec-spi as wake source
1a1c9101358c arm64: dts: qcom: sdm845: Use the Low Power Island CX/MX for SLPI
292108e317ec arm64: dts: qcom: msm8996: Define UFS UniPro clock limits
71aab956985a arm64: dts: qcom: qcs6490-rb3gen2: Declare GCC clocks protected
5a7b32324b50 arm64: dts: qcom: sc8280xp-pmics: Define adc for temp-alarms
c7cdefde3890 arm64: dts: qcom: sc8280xp-crd: Add PMIC die-temp vadc channels
fc4657cf641c dt-bindings: net: qca,ar9331: convert to DT schema
f8930a53d1df arm64: dts: rockchip: Add USB3.0 to Indiedroid Nova
5e1a3b5538e5 arm64: dts: rockchip: adjust phy-handle name on rock-pi-e
67a655c02d0c arm64: dts: rockchip: fix rk3399 hdmi ports node
1ce4f570403a arm64: dts: rockchip: fix rk3328 hdmi ports node
fe75fb3e4156 ARM: dts: rockchip: fix rk322x hdmi ports node
d8715fea4366 ARM: dts: rockchip: fix rk3288 hdmi ports node
3693fdfce256 dt-bindings: display: rockchip,dw-hdmi: add power-domains property
a3f511793cc1 dt-bindings: display: rockchip: rockchip,dw-hdmi: remove port property
fdad3ea0d962 arm64: dts: rockchip: remove redundant cd-gpios from rk3588 sdmmc nodes
1619cbd3e975 arm64: dts: rockchip: add rs485 support on uart5 of px30-ringneck-haikou
2134fa3eaa7f arm64: dts: rockchip: add rs485 support on uart2 of rk3399-puma-haikou
7a4285c5d69e arm64: dts: rockchip: Add Powkiddy RGB10MAX3
b9b257004011 dt-bindings: arm: rockchip: Add Powkiddy RGB10MAX3
a3adfa889806 arm64: dts: rockchip: Update powkiddy rk2023 dtsi for RGB10MAX3
8c24e7309a68 dt-bindings: display: rocktech,jh057n00900: Document panel rotation
46ed672258f7 dt-bindings: display: Add Powkiddy RGB10MAX3 panel
01125f93dff3 dt-bindings: soc: rockchip: add rk3588 USB3 syscon
f12733bf8794 dt-bindings: soc: rockchip: add clock to RK3588 VO grf
94e3c5a3f928 docs: dt: writing-schema: document expectations on example DTS
fe91d6f4b5e3 docs: dt: writing-schema: explain additional/unevaluatedProperties
4a3d3359c02d docs: dt: writing-schema: clarify that schema should describe hardware
d91bf686801b dt-bindings: use capital "OR" for multiple licenses in SPDX
496c29b2e9a6 dt-bindings: vendor-prefixes: add smartrg
24ffa3c14c93 dt-bindings: misc: qcom,fastrpc: Compute callbacks can be DMA coherent
0723544f32df dt-bindings: soc: renesas: Preserve the order of SoCs based on their part numbers
a6d969083d23 clk: renesas: r8a779g0: Correct PFC/GPIO parent clocks
1c22386104aa ASoC: dt-bindings: fsl,imx-asrc: convert to YAML
0a4520722599 dt-bindings: timer: renesas: ostm: Document RZ/Five SoC
82515ffc20b0 dt-bindings: mmc: fsl-imx-esdhc: add iommus property
54b4d099b066 dt-bindings: mmc: fsl-imx-esdhc: add i.MX95 compatible string
878060d5ab93 dt-bindings: power: rpmpd: Add MSM8974 power domains
ba7f2dd56d71 arm64: dts: amlogic: t7: minor whitespace cleanup
0e3777330164 Merge tag 'renesas-pinctrl-for-v6.9-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into devel
2b637c08d90d arm64: dts: amlogic: axg: initialize default SoC capacitance
56b8815ee298 arm64: dts: amlogic: axg: move cpu cooling-cells to common dtsi
38e9d49495a7 arch: arm64: dts: meson: a1: add assigned-clocks for usb node
04303030d8a7 arm64: dts: amlogic: meson-g12-common: Set the rates of the clocks for the NPU
96f1514933cd arm64: dts: amlogic: add reset controller for Amlogic C3 SoC
b6cee0d8e50c dt-bindings: i2c: mux: i2c-demux-pinctrl: Define "i2c-parent" constraints
cbcbd116c3bb dt-bindings: i2c: mux: i2c-demux-pinctrl: Drop i2c-mux.yaml reference
d21de1b0f205 dt-bindings: can: fsl,flexcan: add i.MX95 compatible string
18dd617a729c ASoC: dt-bindings: cs35l45: Add interrupts
d649337cab0d ASoC: dt-bindings: qcom,sm8250: Allow up to 8 codec DAIs
168cf4050131 arm64: dts: fsd: Add fifosize for UART in Device Tree
c49f54ab8258 arm64: dts: exynos: gs101: minor whitespace cleanup
761c7555e3a6 arm64: dts: mediatek: mt7622: add missing "device_type" to memory nodes
feb82cd75ca1 arm64: dts: mediatek: mt7986: reorder nodes
afeb2b683c6a arm64: dts: mediatek: mt7986: reorder properties
1f41c46b7784 arm64: dts: mediatek: Add Acelink EW-7886CAX
a9e4cb01cbbd dt-bindings: arm64: dts: mediatek: Add Acelink EW-7886CAX access point
a0d0e301bacb dt-bindings: vendor-prefixes: add acelink
6355f4d21fe2 arm64: dts: mediatek: Introduce the MT8395 Radxa NIO 12L board
ad8297de07f0 dt-bindings: arm64: mediatek: Add MT8395 Radxa NIO 12L board compatible
c878dc2878b8 arm64: dts: mediatek: mt8186: Add video decoder device nodes
86ae11dcbfb0 arm64: dts: mediatek: mt8195: Add MTU3 nodes and correctly describe USB
a1bccd014f43 arm64: dts: mediatek: Add MT8186 Magneton Chromebooks
f06a044c7c87 arm64: dts: mediatek: Add MT8186 Steelix platform based Rusty
3d00e9da10ee arm64: dts: mediatek: Introduce MT8186 Steelix
2047c128ed63 arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool
0526f7bc6fb8 dt-bindings: arm: mediatek: Add MT8186 Magneton Chromebooks
089e49677706 dt-bindings: arm: mediatek: Add MT8186 Rusty Chromebook
f9d037124e77 dt-bindings: arm: mediatek: Add MT8186 Steelix Chromebook
f5956f4a6314 dt-bindings: arm: mediatek: Add MT8186 Tentacruel / Tentacool Chromebooks
38bba08bb5f5 dt-bindings: arm: mediatek: Sort entries by SoC then board compatibles
ae447c85bffd arm64: dts: mediatek: mt8186: Add jpgenc node
2ee45888f0f1 dt-bindings: media: mediatek-jpeg-encoder: change max iommus count
9dd1d78b9108 arm64: dts: mediatek: mt8186: Add venc node
928e533f64ce arm64: dts: mediatek: mt8186: fix VENC power domain clocks
10ccafc6dfc8 dt-bindings: media: mtk-vcodec-encoder: add compatible for mt8186
a26c81acaef4 arm64: dts: mediatek: mt8192: fix vencoder clock name
6d5ecd0c0bf1 dt-bindings: media: mtk-vcodec-encoder: fix non-vp8 clock name
44858bf6309d arm64: dts: mediatek: Add socinfo efuses to MT8173/83/96/92/95 SoCs
87674b38b34a arm64: dts: mediatek: mt8195: Enable cros-ec-spi as wake source
a5e0493deb44 arm64: dts: mediatek: mt8192: Enable cros-ec-spi as wake source
d8de0db07270 arm64: dts: mediatek: mt8183: Enable cros-ec-spi as wake source
e62bf57bf4ce arm64: dts: mediatek: mt8173: Enable cros-ec-spi as wake source
80f419da8e71 arm64: dts: mediatek: mt7988: add clock controllers
0da54052e647 arm64: dts: mediatek: Add initial MT7988A and BPI-R4
17df9b07965f dt-bindings: arm64: mediatek: Add MT7988A and BPI-R4
58b0724c52ef arm64: dts: mediatek: Add initial MT7981B and Xiaomi AX3000T
f2654823e7da dt-bindings: arm64: mediatek: Add MT7981B and Xiaomi AX3000T
ec60c59a2f5a arm64: dts: mediatek: mt8192-asurada: Remove CrosEC base detection node
4cc812e03139 arm64: dts: mediatek: mt7986: add "#reset-cells" to infracfg
a70fe7a32743 arm64: dts: mediatek: mt7986: drop "#clock-cells" from PWM
08e6a51e82bf arm64: dts: mediatek: mt7986: fix SPI nodename
0ce82b652753 arm64: dts: mediatek: mt7986: fix SPI bus width properties
1654679b7b86 arm64: dts: mediatek: mt7986: drop crypto's unneeded/invalid clock name
0db4b3814808 arm64: dts: mediatek: mt7986: fix reference to PWM in fan node
e14ff64a492a arm64: dts: mt8183: Move CrosEC base detection node to kukui-based DTs
5af22a48d387 dt-bindings: net: qcom,ethqos: add binding doc for safety IRQ for sa8775p
f0efaf410576 dt-bindings: arm: qcom,coresight-tpdm: Add support for TPDM CMB MSR register
a31e6ce97f3b dt-bindings: arm: qcom,coresight-tpdm: Add support for CMB element size
42aa700e6b6a Merge tag 'v6.8-rc4' into gpio/for-next
28ff43a9c5cf dt-bindings: hwmon: Add LTC4282 bindings
946976867e95 dt-bindings: hwmon: ina2xx: Describe ina260 chip
60a5255306fa dt-bindings: hwmon: ina2xx: Describe #io-channel-cells property
ccda6b1eb4cb dt-bindings: hwmon: ina2xx: Add label property
29abc2d8cf78 dt-bindings: display: msm: sm8650-mdss: Add missing explicit "additionalProperties"
ca193aa48798 dt-bindings: msm: qcom, mdss: Include ommited fam-b compatible
fb87bba01a93 dt-bindings: dsi-controller-main: Document missing msm8976 compatible
6e32138572e8 dt-bindings: net: Document Qcom QCA807x PHY package
d65891d631e7 dt-bindings: net: document ethernet PHY package nodes
05327165c680 arm64: dts: qcom: qrb4210-rb2: enable USB-C port handling
c48cf2ca774b arm64: dts: qcom: sm6115: drop pipe clock selection
0529c70be68e arm64: dts: qcom: pmi632: define USB-C related blocks
8f3c2d458408 arm64: dts: qcom: qcs6490-rb3gen2: Correct the voltage setting for vph_pwr
f077c9e8cdcc arm64: dts: qcom: qcm6490-idp: Correct the voltage setting for vph_pwr
ed36b9e79976 dt-bindings/perf: Add Arm CoreSight PMU
6bea5f945518 dt-bindings: pinctrl: cy8c95x0: Update gpio-reserved-ranges
ff6ea0429974 dt-bindings: pinctrl: nvidia,tegra234-pinmux: Restructure common schema
f8a5525e9f69 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
b64c0f80d53a spi: get rid of some legacy macros
adfae82db04a spi: dt-bindings: samsung: add google,gs101-spi compatible
7d4159bca342 dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema
84465d53e06e dt-bindings: mfd: dlg,da9063: Sort child devices
a5d5c9ca95f6 dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
9491d890e23c dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
bf94a53ad831 dt-bindings: mfd: dlg,da9063: Update watchdog child node
5d2f1ff23c1f dt-bindings: mfd: da9062: Update watchdog description
6d63119dedee dt-bindings: soc: qcom: qcom,pmic-glink: document QCM6490 compatible
eadfdbf7cfd7 dt-bindings: i2c: renesas,rcar-i2c: Add r8a779h0 support
506140c4b36b dt-bindings: i2c: pca954x: Add custom properties for MAX7357
a3cf64f59235 arm64: dts: exynos: gs101: enable i2c bus 12 on gs101-oriole
66fd6a721305 arm64: dts: exynos: gs101: define USI12 with I2C configuration
bc3a8ffe73f6 arm64: dts: exynos: gs101: enable cmu-peric1 clock controller
85f5d68af4a0 Merge tag 'samsung-dt-bindings-clk-6.9-3' into next/dt64
eff597e8d6d7 Merge branch '20240131-ufs-phy-clock-v3-3-58a49d2f4605@linaro.org' into clk-for-6.9
9d58463252f8 Merge branch '20240125-msm8953-mdss-reset-v2-1-fd7824559426@z3ntu.xyz' into clk-for-6.9
53156f9a9b8b dt-bindings: samsung: exynos-sysreg: gs101-peric0/1 require a clock
f0fc02f810bc Merge tag 'samsung-dt-bindings-clk-6.9-3' into next/clk
3a17e325742d dt-bindings: clock: google,gs101-clock: add PERIC1 clock management unit
f8f976624cd6 ASoC: dt-bindings: atmel,asoc-wm8904: Convert to json-schema
e07e6605bd92 ARM: dts: samsung: exynos5420-galaxy-tab-common: add wifi node
833d20d41eff dt-bindings: phy: add mediatek MIPI CD-PHY module v0.5
0aff1be67191 dt-bindings: phy: cadence-torrent: Add a separate compatible for TI J7200
61354e32b738 dt-bindings: phy: cadence-torrent: Add optional input reference clock for PLL1
0ed441cb60fc Merge drm/drm-next into drm-misc-next
fa4e28b76a28 dt-bindings: phy: qmp-ufs: Fix PHY clocks
edf14e92f825 dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
db56af9d1adc dt-bindings: mmp-dma: convert to YAML
69f5e9afcf9a arm64: dts: qcom: sc8280xp: Introduce additional tsens instances
d34aa18b328e arm64: dts: qcom: sm8550-hdk: correct WCD9385 route and port mapping
c5ac3bf2b9e9 arm64: dts: qcom: sm8650: Fix UFS PHY clocks
960dc14fb417 arm64: dts: qcom: sm8550: Fix UFS PHY clocks
5b487a71e59a arm64: dts: qcom: sm8350: Fix UFS PHY clocks
1019d3b3dd76 arm64: dts: qcom: sc8280xp: Fix UFS PHY clocks
d909cc2c57f0 arm64: dts: qcom: sc8180x: Fix UFS PHY clocks
32798a824479 Merge branch '20240131-ufs-phy-clock-v3-3-58a49d2f4605@linaro.org' into HEAD
647fc2ed0999 dt-bindings: trivial-devices: sort entries alphanumerically
d87ada5ab8a5 arm64: dts: qcom: sm8250: Fix UFS PHY clocks
71ea2327fa6f arm64: dts: qcom: sm8150: Fix UFS PHY clocks
64da7648e2cd arm64: dts: qcom: sm6350: Fix UFS PHY clocks
fd0f61fefaf5 arm64: dts: qcom: sm6125: Fix UFS PHY clocks
4d7ec8559332 arm64: dts: qcom: sm6115: Fix UFS PHY clocks
1b77533e4915 arm64: dts: qcom: sdm845: Fix UFS PHY clocks
18872b4ddd5f arm64: dts: qcom: msm8998: Fix UFS PHY clocks
9a197a6489bc arm64: dts: qcom: msm8996: Fix UFS PHY clocks
1c92660aee2a dt-bindings: clock: qcom: Add missing UFS QREF clocks
a20d2718cc23 arm64: dts: qcom: ipq8074: add clock-frequency to MDIO node
6ed4e54f3d0a arm64: dts: qcom: qrb2210-rb1: disable cluster power domains
1816222d14d0 arm64: dts: qcom: msm8953: Add GPU
289d949a2fa0 arm64: dts: qcom: msm8953: Add GPU IOMMU
d8789c7d4887 arm64: dts: qcom: msm8953: add reset for display subsystem
e3e73e0578cb Merge branch '20240125-msm8953-mdss-reset-v2-1-fd7824559426@z3ntu.xyz' into arm64-for-6.9
6beb0be6d4fc dt-bindings: clock: gcc-msm8953: add more resets
f84a5b88e932 arm64: dts: qcom: sm8650-mtp: add Audio sound card node
92c1bbcc400a arm64: dts: qcom: sm8650-qrd: add Audio nodes
b0e0830701c8 arm64: dts: qcom: sm8650: Add dma-coherent property
d16840039a98 arm64: dts: qcom: sm8550: Add dma-coherent property
f515a57656b3 arm64: dts: qcom: sm8650-qrd: add PM8010 regulators
03371084ea86 arm64: dts: qcom: sm8650-mtp: add PM8010 regulators
a5d205597cdb arm64: dts: qcom: ipq6018: add thermal zones
a536a392c199 arm64: dts: qcom: ipq6018: add tsens node
93475982136a arm64: dts: qcom: sm8550-mtp: add correct analogue microphones
94d226438171 arm64: dts: qcom: sm8550-qrd: add correct analogue microphones
da9e6dd17060 arm64: dts: qcom: sm8550-mtp: correct WCD9385 TX port mapping
19f3548ab2ee arm64: dts: qcom: sm8550-qrd: correct WCD9385 TX port mapping
70387c1a6e20 arm64: dts: qcom: sm6350: Add tsens thermal zones
14a45c7e6691 arm64: dts: qcom: sm6115: declare VLS CLAMP register for USB3 PHY
62ceca9a978f arm64: dts: qcom: qcm2290: declare VLS CLAMP register for USB3 PHY
1243c8cd7c3d arm64: dts: qcom: msm8998: declare VLS CLAMP register for USB3 PHY
41b532e3d8fb arm64: dts: qcom: sc7280: Update domain-idle-states for cluster sleep
9067770d28da arm64: dts: qcom: sdm630-nile: Enable and configure PM660L WLED
59950318f199 dt-bindings: arm: qcom: drop the superfluous device compatibility schema
5906b6dbb4b8 arm64: dts: qcom: sm8650: add missing qlink_logging reserved memory for mpss
1a5594201259 arm64: dts: qcom: ipq9574: Enable Inline Crypto Engine for MMC
6c5dcfe50eeb arm64: dts: qcom: x1e80100-crd: add WSA8845 speakers
641aa52f01a1 arm64: dts: qcom: x1e80100-crd: add WCD9385 Audio Codec
adad71a77e32 arm64: dts: qcom: x1e80100: add Soundwire controllers
fcb540f3e31d arm64: dts: qcom: x1e80100: add ADSP audio codec macros
fe7149ac0fe1 arm64: dts: qcom: x1e80100: add LPASS LPI pin controller
89656eaec676 arm64: dts: qcom: x1e80100: add ADSP GPR
a24c8ba00dac dt-bindings: remoteproc: qcom,sm8550-pas: document the SM8650 PAS
552c8b9c51bd riscv: dts: microchip: add specific compatible for mpfs pdma
0359a2873d27 arm64: dts: qcom: ipq6018: add QUP5 I2C node
2109082a047e arm64: dts: qcom: x1e80100-qcp: Fix supplies for LDOs 3E and 2J
ad5e70a893a6 arm64: dts: qcom: x1e80100-qcp: Enable more support
70e1e5caf55a arm64: dts: qcom: x1e80100-crd: Enable more support
e7f823deb502 arm64: dts: qcom: x1e80100: Add display nodes
09888df4cabf arm64: dts: qcom: x1e80100: Add PCIe nodes
113e1447c4b7 arm64: dts: qcom: x1e80100: Add USB nodes
d042016c875e arm64: dts: qcom: x1e80100: Add TCSR node
1e12a915f76a arm64: dts: qcom: x1e80100: Add ADSP/CDSP remoteproc nodes
21784a99d799 arm64: dts: qcom: x1e80100: Add QMP AOSS node
adac34e54b92 arm64: dts: qcom: x1e80100: Add SMP2P nodes
f6ae972c7d7a arm64: dts: qcom: x1e80100: Add IPCC node
f858f5571e59 Merge branch '20240202-x1e80100-clock-controllers-v4-5-7fb08c861c7c@linaro.org' into arm64-for-6.9
16f9c84b0c9a Merge branch '20240202-x1e80100-clock-controllers-v4-5-7fb08c861c7c@linaro.org' into clk-for-6.9
77ff05b89311 dt-bindings: clock: qcom: Document the X1E80100 Camera Clock Controller
9b09558a4d02 dt-bindings: clock: qcom: Document the X1E80100 TCSR Clock Controller
009188ad89c1 dt-bindings: clock: qcom: Document the X1E80100 GPU Clock Controller
619f14d3ee00 dt-bindings: clock: qcom: Document the X1E80100 Display Clock Controller
5c691ea9dfde dt-bindings: clock: Drop the SM8650 DISPCC dedicated schema
fd99a9349fc8 dt-bindings: soc: qcom: qcom,pmic-glink: document X1E80100 compatible
3de725e88fb0 arm64: dts: qcom: sa8775p: Add new memory map updates to SA8775P
62872aebbbd8 dt-bindings: soc: imx: add missing clock and power-domains to imx8mp-hdmi-blk-ctrl
4ff28e3e2d94 ASoC: dt-bindings: atmel,sam9x5-wm8731: Convert to json-schema
906cab843596 riscv: dts: microchip: add missing CAN bus clocks
70bee5f22413 dt-bindings: can: mpfs: add missing required clock
91d53111ca13 dt-bindings: clock: mpfs: add more MSSPLL output definitions
7564dfecdf9e Revert "media: ov08x40: Reduce start streaming time"
230eabe62cac arm64: dts: ti: iot2050*: Clarify GPL-2.0 as GPL-2.0-only
81c25598663e arm64: dts: ti: phycore*: Add MIT license along with GPL-2.0
49ad241d7ba0 arm64: dts: ti: beagle*: Add MIT license along with GPL-2.0
af13011bc32a arm64: dts: ti: k3-serdes: Add MIT license along with GPL-2.0
97f615d94c52 arm64: dts: ti: k3-pinctrl: Add MIT license along with GPL-2.0
fb7c92cfa0d7 arm64: dts: ti: k3-j784s4: Add MIT license along with GPL-2.0
ef720a09d820 arm64: dts: ti: k3-j721s2: Add MIT license along with GPL-2.0
b5d3132ac896 arm64: dts: ti: k3-j721e: Add MIT license along with GPL-2.0
a08b6e3c500d arm64: dts: ti: k3-j7200: Add MIT license along with GPL-2.0
67b92cb4a9b8 arm64: dts: ti: k3-am65: Add MIT license along with GPL-2.0
4270ef124316 arm64: dts: ti: k3-am64: Add MIT license along with GPL-2.0
6bbb88ff7998 arm64: dts: ti: k3-am62p: Add MIT license along with GPL-2.0
0ffeaa9662f1 arm64: dts: ti: k3-am625: Add MIT license along with GPL-2.0
5db4fd731c54 arm64: dts: ti: k3-am62a7: Add MIT license along with GPL-2.0
99e9047746eb arm64: dts: ti: Use https for urls
3fa55a728a3d arm64: dts: imx8mn-evk: Add PDM micphone sound card support
8d8a62fd968d arm64: dts: imx8mm-evk: Add PDM micphone sound card support
151935e24c16 arm64: dts: imx8qm: add smmu stream id information
7ca27214673d arm64: dts: imx8qm: add smmu node
b9f9b709c278 arm64: dts: imx8dxl-evk: add flexcan2 and flecan3
f42aa20f9119 arm64: dts: imx8dxl-evk: add i2c3 and its children nodes
93d6366b8356 arm64: dts: imx8dxl: update flexcan[1-3] interrupt number
c5d90c61def2 arm64: dts: imx8mp-phyboard-pollux-rdk: add etml panel support
16c8d47dc262 arm64: dts: imx8mn-rve-gateway: remove redundant company name
b08765c243bb dt-bindings: arm: fsl: remove redundant company name
65cffffa0551 ARM: dts: samsung: exynos5420-galaxy-tab: decrease available memory
d01b22a61768 dt-bindings: ata: atmel: remove at91 compact flash documentation
d242043d9d60 arm64: dts: renesas: gray-hawk-single: Enable watchdog timer
2e8d8e405f93 arm64: dts: renesas: r8a779h0: Add RWDT node
35665cd38eb8 arm64: dts: renesas: Improve TMU interrupt descriptions
6c5ee3279bcd ARM: dts: renesas: Improve TMU interrupt descriptions
78e358d25cba ARM: dts: imx6ull-dhcom: Remove /omit-if-no-ref/ from node usdhc1-pwrseq
f53c235dce4f arm64: dts: freescale: imx8qm: add apalis eval v1.2 carrier board
c6a20bf4953d dt-bindings: arm: fsl: add imx8qm apalis eval v1.2 carrier board
4a2797e6299b dt-bindings: display: imx: add binding for i.MX8MP HDMI TX
46daefc82714 arm64: dts: exynos: Add SPI nodes for Exynos850
864d0966e626 ARM: dts: imx: Add support for Apalis Evaluation Board v1.2
ab38fa94e38c dt-bindings: arm: fsl: Add toradex,apalis_imx6q-eval-v1.2 board
79c6446e27a7 ARM: dts: imx6: skov: add aliases for all ethernet nodes
00cba1b18156 arm64: dts: imx93: Add phyBOARD-Segin-i.MX93 support
ee42eae10f7a dt-bindings: arm: fsl: Add phyBOARD-Segin-i.MX93
1dcb02c43ac3 arm64: dts: imx8mp: Enable PCIe to Data Modul i.MX8M Plus eDM SBC
c35148dd66cc dt-bindings: firmware: xilinx: Describe soc-nvmem subnode
e4d158a009f2 arm64: dts: ls1012a: fix DWC3 USB VBUS glitch issue
2cc69dbdcc3b arm64: dts: ls1012a: add gpio for i2c bus recovery
86f029cb9916 arm64: dts: ls1012a: add big-endian property for PCIe nodes
1344dd97c94d arm64: dts: ls1012a: correct the size of dcfg block
eebf4e8a4de5 arm64: dts: ti: k3-j7200: use ti,j7200-padconf compatible
b2c927e92eb5 arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and wakeup R5FSS nodes
1ed877819eca arm64: dts: ti: k3-am69-sk: remove assigned-clock-parents for unused VP
b2e13a92bcd3 dt-bindings: drm/bridge: ti-sn65dsi86: Fix bouncing @codeaurora address
5aafe0eb29a5 dt-bindings: mux: restrict node name suffixes
959645b1cb6f ARM: dts: keystone: Replace http urls with https
9c307f485cc5 arm64: dts: ti: k3-am62a7-sk: Add HDMI support
33aa21cb5f84 arm64: dts: ti: k3-am62a-main: Add node for Display SubSystem (DSS)
e197413922a3 arm64: dts: ti: phycore-am64: Add ADC
cbb614f03fe0 arm64: dts: ti: k3-j784s4: Fix power domain for VTM node
4979495296af arm64: dts: ti: k3-j721s2: Fix power domain for VTM node
66f98925474a arm64: dts: ti: k3-am62p5-sk: Enable CPSW MDIO node
8af95677c0a4 arm64: dts: ti: k3-j7200: Add support for multiple CAN instances
3416ecb8c84b arm64: dts: ti: k3-j7200-som-p0: Add support for CAN instance 0 in main domain
b190cdb39a78 arm64: dts: ti: k3-j7200: Add support for CAN nodes
049925dbe4ef arm64: dts: ti: verdin-am62: mallow: add TPM device
d18d4a279eac arm64: dts: ti: k3-am64: Remove PCIe endpoint node
45e8e613d391 arm64: dts: ti: k3-am65: Remove PCIe endpoint nodes
9482566d8484 arm64: dts: ti: k3-j7200: Remove PCIe endpoint node
f2db5b44a21b arm64: dts: ti: k3-j7200: Enable PCIe nodes at the board level
1b1b2953ae47 arm64: dts: ti: k3-j721s2-som-p0: Do not split single items
1ab381b19847 arm64: dts: ti: k3-j721e-som-p0: Do not split single items
3bbf314c8e51 arm64: dts: ti: k3-j721e-sk: Do not split single items
9982ca1fa62d arm64: dts: ti: k3-j721e-beagleboneai64: Do not split single items
685e4624960e arm64: dts: ti: k3-j7200-som-p0: Do not split single items
bb743de0d3fe arm64: dts: ti: k3-am69-sk: Do not split single items
6081c21a3e9b arm64: dts: ti: k3-am68-sk-som: Do not split single items
7aebe586ccdc arm64: dts: ti: k3-am654-base-board: Do not split single items
756750059f96 arm64: dts: ti: iot2050: Do not split single items
83cac2593e26 arm64: dts: ti: k3-am642-sk: Do not split single items
c266381d0608 arm64: dts: ti: k3-am642-evm: Do not split single items
ff6e034104fc arm64: dts: ti: k3-am642-phyboard-electra: Add TPM support
986edbf094b5 arm64: dts: ti: Disable clock output of the ethernet PHY
140c5468b668 arm64: dts: ti: Add phase tags for memory node on J784S4 EVM and AM69 SK
fb6ffd10b764 arm64: dts: ti: k3-am625-beagleplay: Use the builtin mdio bus
abed090f1e99 arm64: dts: ti: k3-am625-beagleplay: Add boot phase tags for USB0
0424a17ecb7a arm64: dts: ti: k3-am625-sk: Add boot phase tags for USB0
ac8143f3b013 dt-bindings: mtd: avoid automatically select from mtd.yaml
828b9467f60f media: dt-bindings: techwell,tw9900: Fix port schema ref
2b2619e4c6c5 dt-bindings: display: imx: add binding for i.MX8MP HDMI PVI
141f2102cc12 ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1 aliases to fix hctosys
ffe7dc298435 arm64: dts: imx93: drop "master" I3C node name suffix
99af7a0dae65 ARM: dts: imx6dl: Add support for Sielaff i.MX6 Solo board
ff6929d462c4 dt-bindings: arm: fsl: Add Sielaff i.MX6 Solo board
d3413ad34a12 arm64: dts: freescale: tqma9352: Update I2C eeprom compatible
ad2d1ba26a13 arm64: dts: imx8mp: reparent MEDIA_MIPI_PHY1_REF to CLK_24M
3b589ade448f dt-bindings: gpio: pca9570: Add label property
11eb3d98d38b dt-bindings: gpio: mvebu: Fix "unevaluatedProperties" to be false
9c0a4b40a3ac ARM: dts: imx6ul: Add missing #thermal-sensor-cells to tempmon
fee43501308a arm64: dts: imx8mp-verdin: Label ldo5 and link to usdhc2
b8d7d5f3690b arm64: dts: imx93-var-som: Add Variscite VAR-SOM-MX93
188a8bb94d35 dt-bindings: arm: fsl: Add VAR-SOM-MX93 with Symphony
fecb422bac6a arm64: dts: ls1046a: Remove big-endian from thermal
78343d7acd50 ARM: dts: imx6sl-tolino-shine2hd: fix touchscreen rotation
e57037e98946 ARM: dts: imx6ull-dhcor: Remove 900MHz operating point
31d9e29f0d8e Merge tag 'drm-misc-next-2024-01-11' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
e6d71526460e dt-bindings: misc: xlnx,sd-fec: convert bindings to yaml
01b5de94aa82 Merge 6.8-rc3 into tty-next
7030aa5067b6 Merge 6.8-rc3 into usb-next
5f856030cc8b arm64: dts: rockchip: Add devicetree for Pine64 PineTab2
c87344c32c61 dt-bindings: arm64: rockchip: Add Pine64 PineTab2
6944e5df2f35 arm64: dts: rockchip: Add Touch to Anbernic RG-ARC D
9a90efccd7ee ARM: dts: microchip: gardena-smart-gateway: Use DMA for USART3
9a2b5d99e0ff ARM: dts: microchip: at91sam9x5ek: Use DMA for DBGU serial port
7051d52cf5b9 arm64: dts: imx8mp-venice-gw71xx: add TPM device
4ecbc5946cc5 arm64: dts: imx8mm-venice-gw71xx: add TPM device
3c805459dfd7 arm64: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS
af9118771e3c arm64: dts: imx8mm-venice-gw7901: add TPM device
bcc4aff9ee00 arm64: dts: imx8mm-venice-gw7901: add digital I/O direction control GPIO's
6ea0c6a49b64 ARM: dts: imx7-tqma7: Fix PMIC v33 rail voltage range
2482c75bff8e ARM: dts: imx7-mba7: Add missing vcc supply to i2c devices
4d19ec066c6b ARM: dts: imx7-tqma7: Add missing vcc supply to i2c eeproms
fda2672c8e68 ARM: dts: imx7d-mba7: Remove USB OTG related properties on USB node
f71b70123d20 ARM: dts: imx7-tqma7: rename node for SE97BTP
56382af8168e ARM: dts: imx7-tqma7: mark system data eeprom as read-only
59c9c040a0db ARM: dts: imx7-tqma7: remove superfluous status property
ac9f05a3b8ee ARM: dts: imx7-tqma7: restrict usdhc interface modes
54b93adb1393 ARM: dts: imx7-mba7: restrict usdhc interface modes
6980af2d9f17 ARM: dts: imx7-tqma7: Fix iomuxc node names
efad19cdde77 ARM: dts: imx7-mba7: Fix iomuxc node names
fe330835b74e ARM: dts: imx7-tqma7: fix EEPROM compatible for SE97BTP
77f6e05fdfa1 ARM: dts: imx7-mba7: Add i2c bus recovery
8f9993282d52 ARM: dts: imx7-tqma7: Add i2c bus recovery
4065cdaa82bd ARM: dts: imx7-mba7: Add SPI1_SS0 as chip select 3
10cde7452d93 ARM: dts: imx7-mba7: Add RTC aliases
67c6d0e81520 ARM: dts: imx7-mba7: Enable SNVS power key
2ccae767cb74 ARM: dts: imx7-mba7: Mark gpio-buttons as wakeup-source
235e861d016e ARM: dts: imx7[d]-mba7: hog Mini PCIe signals
cd553893ac90 ARM: dts: imx7[d]-mba7: disable PCIe interface
2faa76d25aef ARM: dts: imx7[d]-mba7: disable USB OC on USB host and USB OTG2
f9152233518d ARM: dts: imx7[d]-mba7: Move ethernet PHY reset into PHY node
0d8f0cba144c ARM: dts: imx7-tqma7/mba7: convert fsl,pins to uint32-matrix
c09e630c5912 arm64: dts: qcom: qcm6490-idp: Include PM7250B
edd0bc8b8d0b arm64: dts: qcom: sm8650: Use GIC-ITS for PCIe0 and PCIe1
4fe52e68f13c arm64: dts: qcom: qcm6490-idp: Add definition for three LEDs
cc592e051541 arm64: dts: qcom: sm8650-qrd: add USB-C Altmode Support
b789944a89fc arm64: dts: qcom: sm8550-qrd: enable Touchscreen
200b0b3875ef dt-bindings: clock: qcom: Fix @codeaurora email in Q6SSTOP
5eaa8712fb96 dt-bindings: visionox-rm69299: Update maintainers
ae0b823f0536 dt-bindings: gpio: renesas,rcar-gpio: Add r8a779h0 support
d4458c6492e6 dt-bindings: net: ti: Update maintainers list
a3fa7f3f82f7 dt-bindings: net: ipq4019-mdio: document now supported clock-frequency
9c3280cd3020 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
19adc3b90590 Merge branch '20240201204421.16992-2-quic_amelende@quicinc.com' into drivers-for-6.9
b5c560279d08 dt-bindings: soc: qcom: Add qcom,pbs bindings
08d014730db7 regulator: dt-bindings: microchip,mcp16502: convert to YAML
bdef327947f5 arm64: dts: intel: agilex5: drop "master" I3C node name suffix
1c0d4ea255ee media: ov08x40: Reduce start streaming time
7d92af412d2e arm64: dts: exynos: Add PDMA node for Exynos850
1868ee800d4c arm64: dts: exynos: gs101: use correct clocks for usi_uart
5d5769f28954 arm64: dts: exynos: gs101: use correct clocks for usi8
dc00c7274ea6 dt-bindings: net: dsa: Add KSZ8567 switch support
58475bd50ec5 media: arm64: dts: st: add video encoder support to stm32mp255
380408454fb2 media: arm64: dts: st: add video decoder support to stm32mp255
4eea1b53e82e media: dt-bindings: media: Document STM32MP25 VDEC & VENC video codecs
39ecce7ee54a arm64: dts: imx8qxp: add GPU nodes
b206b48e8a91 arm64: dts: imx8qm: Correct edma3 power-domains and interrupt numbers
7a74326b4893 arm64: dts: imx8qm: Align edma3 power-domains resources indentation
0be926d25dbc arm64: dts: imx8qxp: mba8xx: Add analog audio output on MBa8Xx
43aab34e5e0c arm64: dts: imx8qxp: Add mclkout clock gates
8c7666d283be arm64: dts: imx8qxp: Add audio SAI nodes
a12fa3d0c150 arm64: dts: imx8qxp: Add audio clock mux node
6c44f7583fd5 arm64: dts: imx8qxp: Add ACM input clock gates
cf7ea553fe5a arm64: dts: freescale: add initial device tree for TQMa8Xx
98de130e34e4 dt-bindings: arm: add TQMa8Xx boards
dc089f5f4bb0 arm64: dts: imx: add imx8dxp support
a5a40554f207 dt-bindings: net: qcom,ipa: do not override firmware-name $ref
927f00767ef5 arm64: dts: imx8mm-kontron: Refactor devicetree for OSM-S module and board
dc0c1bca1831 arm64: dts: imx8mm-kontron: Add I2C EEPROM on OSM-S Kontron i.MX8MM
071edd561a01 arm64: dts: imx8mm-kontron: Remove useless trickle-diode-disable from RTC node
bc9a25d78a35 arm64: dts: imx8mm-kontron: Disable uneffective PUE bit in SDIO IOMUX
48e6dc42724c arm64: dts: imx8mm-kontron: Fix OSM-S devicetrees to match latest hardware
1749a50ca797 arm64: dts: imx8mm-kontron: Fix interrupt for RTC on OSM-S i.MX8MM module
6985d8cd5c40 arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals on BL board
688fff06ac4e arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals on BL OSM-S board
4b8efdb73a46 arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals on BL board
123efe05e212 arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals on BL OSM-S board
9f02292756b9 arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on SL/BL i.MX8MM
928dc77f0003 arm64: dts: imx8mm-kontron: Disable pullups for I2C signals on OSM-S i.MX8MM
c2b4ecb58452 dt-bindings: fpga: Convert fpga-region binding to yaml
85d6c583d5f5 MAINTAINERS: Drop my "+dt" sub-address
0f6ed4032e99 dt-bindings: timer: renesas,tmu: Document input capture interrupt
05c9f46083ba arm64: dts: renesas: r9a07g043u: Add CSI and CRU nodes
aa403cfc2a6c arm64: dts: renesas: Add Gray Hawk Single board support
82a8a0a3e608 arm64: dts: renesas: Add Renesas R8A779H0 SoC support
356004f72bd0 Merge tag 'renesas-r8a779h0-dt-binding-defs-tag' into renesas-dts-for-v6.9
1200029387ce arm64: dts: renesas: rzg3s-smarc-som: Enable the watchdog interface
d58eb8846937 arm64: dts: renesas: r9a08g045: Add watchdog node
b1de14ce277c arm64: dts: renesas: r8a779g0: Add missing SCIF_CLK2
fe98cda6e099 dt-bindings: soc: renesas: Document R-Car V4M Gray Hawk Single
bcdc951ea508 dt-bindings: reset: renesas,rst: Document R-Car V4M support
55647b66aba2 pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
fc9d9f1cfef8 dt-bindings: interconnect: Remove bogus interconnect nodes
47509af4504a soundwire/SOF: add SoundWire Interface support for
f521b204bcd2 dt-bindings: interconnect: Add Qualcomm MSM8909 DT bindings
72ececa06e31 riscv: dts: starfive: beaglev-starlight: Setup phy reset gpio
0279da4a6715 riscv: dts: starfive: visionfive-v1: Setup ethernet phy
19f7725fe372 riscv: dts: starfive: jh7100-common: Setup pinmux and enable gmac
d05053a8b239 riscv: dts: starfive: jh7100: Add sysmain and gmac DT nodes
921e5e1327ef dt-bindings: net: starfive,jh7110-dwmac: Add JH7100 SoC compatible
7020ebc26757 dt-bindings: clock: Add R8A779H0 V4M CPG Core Clock Definitions
35d633af4efc dt-bindings: clock: renesas,cpg-mssr: Document R-Car V4M support
1de76ced2497 dt-bindings: soc: xilinx: Add support for KV260 CC
c9aeb5c33863 dt-bindings: soc: xilinx: Add support for K26 rev2 SOMs
e36f379d8c82 dt-bindings: pinctr: pinctrl-zynq: Fix compatible string
c7a574ba2a6c dt-bindings: pinctrl: nuvoton,npcm845: Drop redundant type for "slew-rate"
da1b37add707 dt-bindings: pinctrl: Unify "input-debounce" schema
234d836b6a1a dt-bindings: input: document Goodix Berlin Touchscreen IC
8df2aa5a1297 arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S
5c09bd2b6ce1 arm64: dts: qcom: sm7125-xiaomi-common: Add UFS nodes
5c38e796a3a1 arm64: dts: qcom: sc7180: Add UFS nodes
307cdcc3f9c2 dt-bindings: arm: qcom: Add Xiaomi Redmi Note 9S
d9eda103eb64 ARM: dts: qcom: apq8026-lg-lenok: Add vibrator support
2590e420cf2c ARM: dts: qcom: msm8960: expressatt: Add gpio-keys
9d906fe262e0 arm64: dts: qcom: sda660-ifc6560: enable USB 3.0 PHY
6b10b59bd1db arm64: dts: qcom: sdm630: add USB QMP PHY support
329fb714e840 arm64: dts: qcom: sc8280xp: camss: Add CAMSS block definition
ca14c11bb9a4 arm64: dts: qcom: sc8280xp: camss: Add CCI definitions
5ce7895c7b2b dt-bindings: clock: qcom: Allow VDD_GFX supply to GX
3a9a9247f661 arm64: dts: qcom: sa8295p-adp: Enable GPU
08f93d65d530 arm64: dts: qcom: sa8295p-adp: add max20411
1129eea99cc1 arm64: dts: qcom: sa8540p: Drop gfx.lvl as power-domain for gpucc
14bc12ecdfe3 dt-bindings: interrupt-controller: convert MediaTek sysirq to the json-schema
77a4323bd64f dt-bindings: dma: allwinner,sun50i-a64-dma: Add compatible for H616
82bf0037e8d8 dt-bindings: power: Add r8a779h0 SYSC power domain definitions
d98d5e6ce56e dt-bindings: power: renesas,rcar-sysc: Document R-Car V4M support
5ee26dab625b dt-bindings: bus: Document Broadcom GISB arbiter 74165 compatible
c6234d82a072 arm64: dts: broadcom: bcmbca: bcm4908: drop invalid switch cells
bc4ef25abdc1 arm64: dts: broadcom: bcmbca: bcm4908: use NVMEM layout for Asus GT-AC5300
b6e08822ed8c arm64: dts: renesas: r8a779g2: Add White Hawk Single support
7e3862db4c62 arm64: dts: renesas: Add Renesas R8A779G2 SoC support
51fc2376ba1d arm64: dts: renesas: white-hawk: Factor out common parts
a248c1746935 arm64: dts: renesas: white-hawk-cpu: Factor out common parts
fdea5d785497 arm64: dts: renesas: white-hawk: Add SoC name to top-level comment
a77e323e0dc2 arm64: dts: renesas: white-hawk: Drop SoC parts from sub boards
3e8f05b2b81d arm64: dts: renesas: white-hawk-cpu: Restore sort order
e90ffb9d53b7 arm64: dts: renesas: r8a779g0: Add standalone White Hawk CPU support
eccddc31dfa9 arm64: dts: renesas: ulcb-kf: Add node for GNSS
3d3e628e12d6 arm64: dts: renesas: ulcb-kf: Drop duplicate 3.3v regulators
bf721e67a7fb Merge drm/drm-next into drm-misc-next
351548ba8841 dt-bindings: soc: renesas: Document R-Car V4H White Hawk Single
ad352af0d46f dt-bindings: nfc: ti,trf7970a: fix usage example
d4d212c5cf34 dt-bindings: display: panel-simple: add ETML1010G3DRA
6aee668021fc arm64: dts: qcom: sm7225-fairphone-fp4: Switch firmware ext to .mbn
aa54779772ae arm64: dts: qcom: rename PM2250 to PM4125
dbcb19ed3275 arm64: dts: qcom: qcm6490-fairphone-fp5: Add PMIC GLINK
dc376fa4a27c arm64: dts: qcom: sdm845-oneplus-common: improve DAI node naming
048423deb9a5 arm64: dts: qcom: qcm6490-fairphone-fp5: Add missing reserved-memory
b4d0c1c61afa arm64: dts: qcom: sc7280: Add static properties to cryptobam
f3f780c01899 arm64: dts: qcom: sa8775p: enable safety IRQ
fd61cbbd53a9 dt-bindings: clock: qcom,gcc-sm8150: Add gcc video resets for sm8150
30e2fa95b585 dt-bindings: arm: qcom,ids: add SoC ID for QCM8550 and QCS8550
27f4e6aa609c dt-bindings: Add reference to rs485.yaml
5e11848e4c98 dt-bindings: serial: renesas,hscif: Document r8a779h0 bindings
c7aaa6160c61 dt-bindings: serial: fsl-lpuart: support i.MX95
3ee8c19304d9 dt-bindings: serial: samsung: do not allow reg-io-width for gs101
d70fdb79f945 arm64: dts: qcom: apq8016-sbc-d3-camera: Use more generic node names
95830229bcb5 ARM: dts: qcom: msm8960: drop 2nd clock frequency from timer
4f433e3e9a04 ARM: dts: qcom: ipq4019-ap.dk01.1: align flash node with bindings
39065990752b ARM: dts: qcom: ipq4019-ap.dk01.1: use existing labels for nodes
a6106c8748a7 arm64: dts: qcom: split PCIe interrupt-names entries per lines
f1ac2340280d arm64: dts: qcom: sm8650: describe all PCI MSI interrupts
653638c9dceb arm64: dts: qcom: sm8550: describe all PCI MSI interrupts
90840a974369 arm64: dts: qcom: sm8450: describe all PCI MSI interrupts
c681c8ad796c arm64: dts: qcom: sm8350: describe all PCI MSI interrupts
9186fa649278 arm64: dts: qcom: sm8250: describe all PCI MSI interrupts
a2e5b5e27b91 arm64: dts: qcom: sm8150: describe all PCI MSI interrupts
ed0b4f3e69ba ARM: dts: qcom: msm8926-htc-memul: Add rmtfs memory node
3556e0895e7a dt-bindings: usb: dwc3: Add snps,host-vbus-glitches-quirk avoid vbus glitch
75bae0c78ef3 dt-bindings: usb: usb-nop-xceiv: Repurpose vbus-regulator
20e5fb946959 dt-bindings: usb: mtu3: Add MT8195 MTU3 ip-sleep support
0145e6824861 dt-bindings: usb: Clean-up "usb-phy" constraints
eb9bdcaff280 dt-bindings: usb: add common Type-C USB Switch schema
a67690a90fb9 dt-bindings: usb: Add Marvell ac5
59434babb8e4 arm64: dts: qcom: sm8450: Add missing interconnects to serial
6b60607aa5cc dt-bindings: usb: Introduce ITE IT5205 Alt. Mode Passive MUX
fe0ce9c54778 dt-bindings: pinctrl: amlogic: narrow regex for unit address to hex numbers
8c58779baca1 dt-bindings: qcom: Document new msm8916-samsung devices
1438aadecf94 arm64: dts: qcom: sm8450-hdk: correct AMIC4 and AMIC5 microphones
b4d502118ad4 arm64: dts: qcom: sm8150: add necessary ref clock to PCIe
018a13d36a57 arm64: dts: qcom: sdm630: Hook up GPU cooling device
2b51fa0934c8 arm64: dts: qcom: sm8550: Hook up GPU cooling device
15018cdc0470 arm64: dts: qcom: sm8450: Hook up GPU cooling device
f5906fc26422 arm64: dts: qcom: sm8350: Hook up GPU cooling device
9df3c73a8511 arm64: dts: qcom: sm8250: Hook up GPU cooling device
257e0300ca3a arm64: dts: qcom: sm8150: Hook up GPU cooling device
b16301e27866 arm64: dts: qcom: sm6115: Mark GPU @ 125C critical
ccc769ffd9fa arm64: dts: qcom: sm6115: Hook up GPU cooling device
cf4e80b514f2 arm64: dts: qcom: sdm845: Hook up GPU cooling device
6ddaa894ac00 arm64: dts: qcom: sc8180x: Hook up GPU cooling device
1a13cc6e08c9 arm64: dts: qcom: msm8939: Hook up GPU cooling device
04962e8ee80d arm64: dts: qcom: msm8916: Hook up GPU cooling device
de58665d5a86 arm64: dts: qcom: x1e80100: Flush RSC sleep & wake votes
5792135ff692 arm64: dts: qcom: x1e80100: Add missing system-wide PSCI power domain
7dddf3cf2c2d dt-bindings: soc/qcom: Add size constraints on "qcom,rpm-msg-ram"
f3e26b603762 arm64: dts: qcom: Add missing interrupts for qcs404/ipq5332
d2eb087d6a3f arm64: dts: qcom: Fix hs_phy_irq for SDM670/SDM845/SM6350
e912f5a885bc arm64: dts: qcom: Fix hs_phy_irq for non-QUSB2 targets
cc58f6b02229 arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
ed2747597b2e arm64: dts: qcom: sm8550: add support for the SM8550-HDK board
0beb12a79761 dt-bindings: arm: qcom: Document the HDK8550 board
1182dc50de01 dt-bindings: net: Document QCA808x PHYs
8869fe2b8c59 dt-bindings: net: phy: Document LED inactive high impedance mode
8a5d470f446f dt-bindings: net: phy: Make LED active-low property common
ee170c770dce ASoC: dt-bindings: audio-graph-port: Drop type from "clocks"
52dc7498eed1 ASoC: dt-bindings: samsung,tm2: Correct "audio-codec" constraints
2294f77ec0a5 ARM: dts: sti: minor whitespace cleanup around '='
e8f034522bd8 arm64: dts: exynos: gs101: sysreg_peric0 needs a clock
d7849025c947 ARM: dts: da850: add MMD SDIO interrupts
f831c925b07a ARM: dts: marvell: dove-cubox: fix si5351 node names
70e16db126d5 arm: dts: marvell: Fix maxium->maxim typo in brownstone dts
29fba2976ec3 dt-bindings: crypto: ice: Document SC7180 inline crypto engine
3d331a17e8c9 dt-bindings: qcom-qce: Add compatible for SM6350
4fd1499f0d02 arm64: dts: ti: k3-am654-main: Add device tree entry for SGX GPU
459e64009a83 ARM: dts: DRA7xx: Add device tree entry for SGX GPU
33828a263695 ARM: dts: AM437x: Add device tree entry for SGX GPU
b812a94b3a14 ARM: dts: AM33xx: Add device tree entry for SGX GPU
a43b7f4412c3 ARM: dts: omap5: Add device tree entry for SGX GPU
26a571cb3312 ARM: dts: omap4: Add device tree entry for SGX GPU
0590991057c3 ARM: dts: omap3: Add device tree entry for SGX GPU
6cfc912186fd dt-bindings: gpu: Add PowerVR Series5 SGX GPUs
ecd5e84cb911 dt-bindings: gpu: Rename img,powervr to img,powervr-rogue
674fba836cdb arm64: dts: rockchip: fix nanopc-t6 sdmmc regulator
33b030710624 arm64: dts: rockchip: remove duplicate SPI aliases for helios64
7c0fd87b35a8 arm64: dts: rockchip: add spi controller aliases on rk3399
774db835de8a arm64: dts: rockchip: Add support for NanoPi R6C
245ed9f66edb arm64: dts: rockchip: Add support for NanoPi R6S
7ed25d8d0d24 dt-bindings: arm: rockchip: Add NanoPi R6 series boards
4fc6e0686faf arm64: dts: rockchip: Increase maximum frequency of SPI flash for ROCK Pi 4A/B/C
47aafd8512e1 arm64: dts: rockchip: add sdmmc card detect to the nanopc-t6
5bdf0ecf003d arm64: dts: rockchip: Add cache information to the SoC dtsi for RK3399
3d67b6c2a2af ARM: dts: rockchip: Enable HDMI output for XPI-3128
8ac6f9cf696a ARM: dts: rockchip: Add HDMI node for RK3128
06cbcacf56ad ARM: dts: rockchip: Add display subsystem for RK3128
9a9dc5b9e06a arm64: dts: rockchip: add rfkill node for M.2 Key E WiFi on rock-5b
c7f1c6bb420a arm64: dts: rockchip: enable NanoPC-T6 MiniPCIe power
9604142e6a0d arm64: dts: rockchip: Add LED_GREEN for edgeble-neu6a
cbd461ded362 arm64: dts: rockchip: Add Edgeble NCM6A-IO USB2
051aa218e679 arm64: dts: rockchip: Add Edgeble NCM6A-IO M.2 B-Key, E-Key
e24b6c90f78b arm64: dts: rockchip: Add Edgeble NCM6A-IO M.2 M-Key
c04566174738 arm64: dts: rockchip: Add Edgeble NCM6A-IO 2.5G ETH
1696541973b9 arm64: dts: rockchip: Add vdd_cpu_big reg to rk3588-edgeble-ncm6
fed4b47f48ac arm64: dts: rockchip: Add Edgeble NCM6A WiFi6 Overlay
648060033a16 arm64: dts: rockchip: Add common DT for edgeble-neu6b-io
14b26b2835cb arm64: dts: rockchip: Add edgeble-neu6a-common DT
8360c7a53f95 arm64: dts: rockchip: Drop edgeble-neu6b dcdc-reg4 regulator-init-microvolt
e497dc0158dd arm64: dts: rockchip: add missing definition of pmu io domains 1 and 2 on ringneck
f1cb710d9302 arm64: dts: rockchip: add Anbernic RG-ARC S and RG-ARC D
351c26e7934f dt-bindings: arm: rockchip: Add Anbernic RG-Arc
294dd835c5d0 arm64: dts: rockchip: Move device specific properties
e8f6b6072ce6 dt-bindings: soc: rockchip: Add rk3588 hdptxphy syscon
663d347eb7a7 ARM: dts: stm32: fix DSI peripheral clock on stm32mp15 boards
6e307e6bd72d dt-bindings: memory-controllers: narrow regex for unit address to hex numbers
ef93727c9def spi: dt-bindings: samsung: Add Exynos850 SPI
c714a4c1273b ARM: dts: qcom: use defines for interrupts
7f37d45ff70d ARM: dts: qcom: apq8026-samsung-matissewifi: Configure touch keys
cf76727f86a3 ARM: dts: stm32: lxa-tac: drive powerboard lines as open-drain
19fee3189355 dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100 QMP PCIe PHYs
899bb26cef2c dt-bindings: iio: adc: rtq6056: add support for the whole RTQ6056 family
09065a127e3c dt-bindings: input: melfas,mms114: add MMS252 compatible
ef76ae751c3c dt-bindings: phy: qcom,msm8998-qmp-usb3-phy: support SDM660
97fd9e67ede2 dt-bindings: phy: qcom,msm8998-qmp-usb3-phy: add TCSR registers
25bfbe442a13 dt-bindings: phy: qcom,msm8998-qmp-usb3-phy: support USB-C data
6ec985dff442 dt-bindings: phy: qcom,msm8998-qmp-usb3-phy: split from sc8280xp PHY schema
8b41b5f06d8a arm64: dts: exynos: gs101: enable eeprom on gs101-oriole
eb43c96a2716 arm64: dts: exynos: gs101: define USI8 with I2C configuration
688d19a4c1d5 arm64: dts: exynos: gs101: update USI UART to use peric0 clocks
c8631c01c9d5 arm64: dts: exynos: gs101: enable cmu-peric0 clock controller
7f078f4efe48 arm64: dts: exynos: gs101: remove reg-io-width from serial
dfa299ac5670 arm64: dts: exynos: gs101: define Multi Core Timer (MCT) node
dd8d6cdb498f dt-bindings: clock: tesla,fsd: Fix spelling mistake
2a50cd8b4cad Merge tag 'samsung-dt-bindings-clk-6.9-2' into next/clk
1308a1709db2 dt-bindings: clock: exynos850: Add PDMA clocks
5f252cf1954d dt-bindings: clock: google,gs101-clock: add PERIC0 clock management unit
b7045107b13d dt-bindings: phy: Add QMP UFS PHY compatible for SC7180
806828c18886 arm64: dts: qcom: sc8180x: Add RPMh sleep stats
8bfa57f18d67 arm64: dts: qcom: sc8180x: Shrink aoss_qmp register space size
39124f597a6a arm64: dts: qcom: sc8180x: Add missing CPU<->MDP_CFG path
076044c5542f arm64: dts: qcom: sc8180x: Require LOW_SVS vote for MMCX if DISPCC is on
76f855a9dca6 arm64: dts: qcom: sc8180x: Don't hold MDP core clock at FMAX
37f3285d146b arm64: dts: qcom: sc8180x: Fix eDP PHY power-domains
5e5b25b16167 arm64: dts: qcom: sc8180x: Add missing CPU off state
a971a001fe6a arm64: dts: qcom: sc8180x: Fix up big CPU idle state entry latency
d43c023044f1 arm64: dts: qcom: sc8180x: Hook up VDD_CX as GCC parent domain
0a90e0fc5c4b dt-bindings: clock: gcc-sc8180x: Add the missing CX power domain
7d930fbfa6d1 riscv: dts: starfive: jh7110: Add PWM node and pins configuration
98729d5d619d riscv: dts: starfive: jh7100: Add PWM node and pins configuration
2613a64bdc5e dt-bindings: spi: nxp-fspi: support i.MX93 and i.MX95
36d4b81404af dt-bindings: spi: fsl-lpspi: support i.MX95 LPSPI
3ff4d525b9f7 ASoC: dt-bindings: fsl-sai: Support Rx-only SAI
fc98068e41fe ASoC: dt-bindings: fsl-sai: Add power-domains
7e4487f7e723 ASoC: Support SAI and MICFIL on i.MX95 platform
170639843215 dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add spi bus
e06b0404e4ef dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add pressure-triplet
cb500c9133ee dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml improvements
0c9fbdab661d dt-bindings: iio: light: as73211: add support for as7331
668faa4c00b6 ARM: dts: qcom: ipq4019: correct clock order in DWC3 node
01f571222843 ARM: dts: qcom: sdx65: correct clock order in DWC3 node
f0606dbf1b06 ARM: dts: qcom: ipq8064: drop unused reset-names from DWC3 node
638f430aa2c5 arm64: dts: qcom: qcm6490-fairphone-fp5: Enable venus node
2bf14ff2de89 arm64: dts: qcom: sc7280: Move video-firmware to chrome-common
e694053a2504 arm64: dts: qcom: x1e80100: drop qcom,drv-count
ae0bc4781d25 arm64: dts: qcom: sc7280: Add additional MSI interrupts
fbc40e8570be dt-bindings: pwm: Add bindings for OpenCores PWM Controller
f86a5abc5095 ASoC: codecs: add support for WCD939x Codec
0023860e3cd8 dt-bindings: Add DPS310 as trivial device
4d5cba356b2e docs: dt: submitting-patches: add commit subject prefix in reversed format
86c6d04414f3 docs: dt: submitting-patches: drop outdated points to TXT format
20fea215870b dt-bindings: Turn on undocumented compatible checks
c15bd0d0ea0d arm64: zynqmp: Align usb clock nodes with binding
506404184883 arm64: zynqmp: Comment all smmu entries
702fb0df1a8d arm64: zynqmp: Rename i2c?-gpio to i2c?-gpio-grp
8dae08d3ef0c arm64: zynqmp: Disable Tri-state for MIO38 Pin
08cee7c9acca arm64: zynqmp: Remove incorrect comment from kv260s
c28bc39bcbe4 arm64: zynqmp: Introduce u-boot options node with bootscr-address
346b5266ae26 arm64: zynqmp: Fix comment to be aligned with board name.
69a088e616d5 arm64: zynqmp: Update ECAM size to discover up to 256 buses
c78a834d7d85 arm64: zynqmp: Describe assigned-clocks for uarts
aab3209386cd arm64: zynqmp: Setup default si570 frequency to 156.25MHz
70d8c607c90e arm64: zynqmp: Add resets property for CAN nodes
1e662bbad32e arm64: zynqmp: Add an OP-TEE node to the device tree
b97de3d1f0f1 arm64: zynqmp: Add output-enable pins to SOMs
5149181eb2a0 arm64: zynqmp: Rename zynqmp-power node to power-management
4bbdddd5f137 dt-bindings: firmware: xilinx: Sort node names (clock-controller)
bbe26a5d3a74 dt-bindings: firmware: xilinx: Describe missing child nodes
3bb58ba1f178 dt-bindings: firmware: xilinx: Fix versal-fpga node name
552578beff16 dt-bindings: firmware: versal: add versal-net compatible string
a1e42c2d1feb dt-bindings: timer: exynos4210-mct: Add google,gs101-mct compatible
793923947260 dt-bindings: i2c: exynos5: add google,gs101-hsi2c compatible
e40d0f28e904 ARM: dts: samsung: exynos4412-p4note: add accelerometer and gyro to p4note
b0f7ebf9ebb5 ARM: dts: samsung: exynos5800-peach: Enable cros-ec-spi as wake source
7fb70f62fdc1 ARM: dts: samsung: exynos5420-peach: Enable cros-ec-spi as wake source
69ffe89c1f09 ARM: dts: samsung: exynos5422-odroidxu3: disable thermal polling
efc6740c2555 arm64: dts: renesas: r8a779g0: Restore sort order
4d29837048f1 ARM: dts: renesas: r8a73a4: Fix thermal parent clock
b3b5e2c31a6a ARM: dts: renesas: r8a73a4: Add cp clock
0355cc519d58 ARM: dts: renesas: r8a73a4: Fix external clocks and clock rate
c7faddebe0f9 arm64: dts: renesas: rzg3s-smarc: Add gpio keys
cf58f575cc98 dt-bindings: regulator: Convert ti,tps65132 to YAML
fc588d5d53ae ASoC: dt-bindings: Do not override firmware-name $ref
81002cf24ea5 ASoC: dt-bindings: document WCD939x Audio Codec
f47aa77e7a94 ASoC: dt-bindings: qcom,wcd938x: move out common properties
d7f07526a034 ASoC: dt-bindings: fsl,micfil: Add compatible string for i.MX95 platform
e4fa9d184d78 ASoC: dt-bindings: fsl,sai: Add compatible string for i.MX95 platform
6d65dad20b03 dt-bindings: input: touchscreen: goodix: clarify irq-gpios misleading text
1f08757666ca dt-bindings: input: silead,gsl1680: do not override firmware-name $ref
ffc68c88254b dt-bindings: display: panel: Add Novatek NT36672E LCD DSI
22dafcaa7945 dt-bindings: display: panel: Add BOE TH101MB31IG002-28A panel
29e394c3abcd dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
c378224488e5 dt-bindings: display: Add SSD133x OLED controllers
d4d009fba537 dt-bindings: display: ssd132x: Add vendor prefix to width and height
b74c86bcffbc dt-bindings: display: ssd1307fb: Add vendor prefix to width and height
140b66753a95 dt-bindings: panel: lvds: Append edt,etml0700z9ndha in panel-lvds

git-subtree-dir: dts/upstream
git-subtree-split: 7e08733c96c84eb323f47e9b248c924e2ac6272a
---
This moves OF_UPSTREAM to be tracking the v6.9 release and is for the
-next branch. To test these changes yourself locally, either use my
"WIP/14May2024-next" branch or run:
./dts/update-dts-subtree.sh pull v6.9-dts
yourself locally. I intend to wait a few days to apply this to -next, to
give people time to test.

Cc: Adam Ford <aford173@gmail.com>
Cc: Apurva Nandan <a-nandan@ti.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Bryan Brattlof <bb@ti.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Christian Hewitt <christianshewitt@gmail.com>
Cc: "Cogent Embedded, Inc." <source@cogentembedded.com>
Cc: Dave Purdy <david.c.purdy@gmail.com>
Cc: Evgeni Dobrev <evgeni@studio-punkt.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jason Cooper <u-boot@lakedaemon.net>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Luka Perkov <luka@openwrt.org>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
Cc: Michael Walle <michael@walle.cc>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Siddarth Gore <gores@marvell.com>
Cc: Simon Guinot <simon.guinot@sequanux.org>
Cc: Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>
Cc: Stefan Roese <sr@denx.de>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tony Dinh <mibodhi@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vyacheslav Bocharov <adeep@lexina.in>
Cc: Wadim Egorov <w.egorov@phytec.de>
Cc: Walter Schweizer <swwa@users.sourceforge.net>
Cc: u-boot-amlogic@groups.io
Cc: u-boot-qcom@groups.io

 Bindings/Makefile                             |    3 -
 Bindings/arm/amlogic.yaml                     |   15 +-
 Bindings/arm/arm,realview.yaml                |    6 +-
 Bindings/arm/atmel-at91.yaml                  |    6 +
 Bindings/arm/fsl.yaml                         |   41 +-
 Bindings/arm/marvell/armada-38x.txt           |   27 -
 Bindings/arm/marvell/armada-38x.yaml          |   70 +
 Bindings/arm/mediatek.yaml                    |  198 +-
 Bindings/arm/mediatek/mediatek,hifsys.txt     |   26 -
 Bindings/arm/mediatek/mediatek,pciesys.txt    |   25 -
 Bindings/arm/mediatek/mediatek,ssusbsys.txt   |   25 -
 Bindings/arm/msm/qcom,saw2.txt                |   58 -
 Bindings/arm/qcom,coresight-tpdm.yaml         |   40 +-
 Bindings/arm/qcom.yaml                        |   58 +-
 Bindings/arm/rockchip.yaml                    |   71 +-
 Bindings/arm/sunxi.yaml                       |   12 +
 Bindings/arm/syna.txt                         |   12 -
 Bindings/arm/tegra.yaml                       |    8 +
 Bindings/arm/tegra/nvidia,tegra186-pmc.yaml   |   58 +-
 Bindings/arm/ti/k3.yaml                       |   14 +
 Bindings/ata/ahci-mtk.txt                     |   51 -
 Bindings/ata/atmel-at91_cf.txt                |   19 -
 Bindings/ata/mediatek,mtk-ahci.yaml           |   98 +
 Bindings/auxdisplay/arm,versatile-lcd.yaml    |    4 +-
 Bindings/auxdisplay/gpio-7-segment.yaml       |   55 +
 Bindings/auxdisplay/hit,hd44780.yaml          |   68 +-
 Bindings/auxdisplay/holtek,ht16k33.yaml       |   54 +-
 Bindings/auxdisplay/img,ascii-lcd.yaml        |    4 +-
 Bindings/auxdisplay/maxim,max6959.yaml        |   44 +
 Bindings/bus/brcm,gisb-arb.yaml               |    1 +
 Bindings/bus/imx-weim.txt                     |  117 -
 Bindings/clock/google,gs101-clock.yaml        |   28 +-
 Bindings/clock/keystone-gate.txt              |    2 -
 Bindings/clock/keystone-pll.txt               |    2 -
 Bindings/clock/mediatek,mt2701-hifsys.yaml    |   50 +
 Bindings/clock/mediatek,mt7622-pciesys.yaml   |   45 +
 Bindings/clock/mediatek,mt7622-ssusbsys.yaml  |   45 +
 Bindings/clock/mobileye,eyeq5-clk.yaml        |   51 +
 Bindings/clock/qcom,gcc-sc8180x.yaml          |    7 +
 Bindings/clock/qcom,gpucc.yaml                |    9 +
 Bindings/clock/qcom,q6sstopcc.yaml            |    2 +-
 Bindings/clock/qcom,sc7180-mss.yaml           |   61 -
 Bindings/clock/qcom,sm8450-camcc.yaml         |    2 +
 Bindings/clock/qcom,sm8450-gpucc.yaml         |    2 +
 Bindings/clock/qcom,sm8550-dispcc.yaml        |    7 +-
 Bindings/clock/qcom,sm8550-tcsr.yaml          |    1 +
 Bindings/clock/qcom,sm8650-dispcc.yaml        |  106 -
 Bindings/clock/renesas,cpg-mssr.yaml          |    1 +
 Bindings/clock/samsung,exynos850-clock.yaml   |   42 +
 Bindings/clock/tesla,fsd-clock.yaml           |    2 +-
 Bindings/clock/ti/adpll.txt                   |    2 -
 Bindings/clock/ti/apll.txt                    |    2 -
 Bindings/clock/ti/autoidle.txt                |    2 -
 Bindings/clock/ti/clockdomain.txt             |    2 -
 Bindings/clock/ti/composite.txt               |    2 -
 Bindings/clock/ti/divider.txt                 |    2 -
 Bindings/clock/ti/dpll.txt                    |    2 -
 Bindings/clock/ti/fapll.txt                   |    2 -
 Bindings/clock/ti/fixed-factor-clock.txt      |    2 -
 Bindings/clock/ti/gate.txt                    |    2 -
 Bindings/clock/ti/interface.txt               |    2 -
 Bindings/clock/ti/mux.txt                     |    2 -
 Bindings/crypto/atmel,at91sam9g46-aes.yaml    |    6 +-
 Bindings/crypto/atmel,at91sam9g46-sha.yaml    |    6 +-
 Bindings/crypto/atmel,at91sam9g46-tdes.yaml   |    6 +-
 .../crypto/qcom,inline-crypto-engine.yaml     |    1 +
 Bindings/crypto/qcom-qce.yaml                 |    1 +
 .../atmel/atmel,hlcdc-display-controller.yaml |   63 +
 Bindings/display/atmel/hlcdc-dc.txt           |   75 -
 .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    |  102 +
 Bindings/display/bridge/ti,sn65dsi86.yaml     |    2 +-
 Bindings/display/fsl,lcdif.yaml               |    8 +-
 Bindings/display/imx/fsl,imx8mp-hdmi-pvi.yaml |   84 +
 Bindings/display/msm/dsi-controller-main.yaml |    2 +
 Bindings/display/msm/gmu.yaml                 |    1 +
 Bindings/display/msm/gpu.yaml                 |    6 +-
 Bindings/display/msm/qcom,mdss.yaml           |    1 +
 Bindings/display/msm/qcom,sm8150-mdss.yaml    |    9 +
 Bindings/display/msm/qcom,sm8650-dpu.yaml     |    4 +-
 Bindings/display/msm/qcom,sm8650-mdss.yaml    |    4 +
 Bindings/display/msm/qcom,x1e80100-mdss.yaml  |  251 ++
 .../display/panel/boe,th101mb31ig002-28a.yaml |   58 +
 Bindings/display/panel/himax,hx83112a.yaml    |   74 +
 .../display/panel/leadtek,ltk500hd1829.yaml   |    4 +-
 Bindings/display/panel/novatek,nt35510.yaml   |    5 +-
 Bindings/display/panel/novatek,nt36672e.yaml  |   66 +
 Bindings/display/panel/panel-lvds.yaml        |    4 +
 Bindings/display/panel/panel-simple.yaml      |    4 +
 .../display/panel/rocktech,jh057n00900.yaml   |    3 +
 Bindings/display/panel/visionox,r66451.yaml   |    2 +-
 Bindings/display/panel/visionox,rm69299.yaml  |    3 +-
 Bindings/display/renesas,rzg2l-du.yaml        |  126 +
 .../display/rockchip/rockchip,dw-hdmi.yaml    |   33 +-
 Bindings/display/solomon,ssd1307fb.yaml       |   20 +-
 Bindings/display/solomon,ssd132x.yaml         |   12 +-
 Bindings/display/solomon,ssd133x.yaml         |   45 +
 Bindings/display/ti/ti,am65x-dss.yaml         |    7 +-
 Bindings/dma/allwinner,sun50i-a64-dma.yaml    |   12 +-
 Bindings/dma/fsl,edma.yaml                    |    2 +
 Bindings/dma/fsl,imx-sdma.yaml                |    3 +-
 Bindings/dma/marvell,mmp-dma.yaml             |   72 +
 Bindings/dma/mediatek,mt7622-hsdma.yaml       |   63 +
 Bindings/dma/mmp-dma.txt                      |   81 -
 Bindings/dma/mtk-hsdma.txt                    |   33 -
 Bindings/dma/renesas,rcar-dmac.yaml           |    1 +
 Bindings/dts-coding-style.rst                 |    2 +
 Bindings/eeprom/at24.yaml                     |    5 +-
 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml |   96 +-
 Bindings/fpga/fpga-region.txt                 |  479 ----
 Bindings/fpga/fpga-region.yaml                |  358 +++
 Bindings/fpga/xlnx,versal-fpga.yaml           |    2 +-
 Bindings/gpio/aspeed,ast2400-gpio.yaml        |  148 +
 Bindings/gpio/gateworks,pld-gpio.txt          |    3 +-
 Bindings/gpio/gpio-aspeed.txt                 |   39 -
 Bindings/gpio/gpio-mvebu.yaml                 |    2 +-
 Bindings/gpio/gpio-nmk.txt                    |   31 -
 Bindings/gpio/gpio-pca9570.yaml               |    3 +
 Bindings/gpio/mrvl-gpio.yaml                  |    2 +-
 Bindings/gpio/renesas,rcar-gpio.yaml          |    1 +
 Bindings/gpio/st,nomadik-gpio.yaml            |   95 +
 ...mg,powervr.yaml => img,powervr-rogue.yaml} |    4 +-
 Bindings/gpu/img,powervr-sgx.yaml             |  138 +
 Bindings/hwmon/adi,adm1177.yaml               |    5 +-
 Bindings/hwmon/adi,adm1275.yaml               |    7 +-
 Bindings/hwmon/adi,ltc2945.yaml               |    5 +-
 Bindings/hwmon/adi,ltc4282.yaml               |  159 ++
 Bindings/hwmon/amphenol,chipcap2.yaml         |   77 +
 Bindings/hwmon/aspeed,g6-pwm-tach.yaml        |   71 +
 Bindings/hwmon/fan-common.yaml                |   79 +
 Bindings/hwmon/hwmon-common.yaml              |   19 +
 Bindings/hwmon/lltc,ltc4151.yaml              |    5 +-
 Bindings/hwmon/lltc,ltc4286.yaml              |    9 +-
 Bindings/hwmon/lm75.yaml                      |    3 +-
 Bindings/hwmon/nuvoton,nct6775.yaml           |    1 +
 Bindings/hwmon/pmbus/infineon,tda38640.yaml   |   28 +
 Bindings/hwmon/pmbus/ti,lm25066.yaml          |   17 +-
 Bindings/hwmon/ti,ina2xx.yaml                 |   11 +-
 Bindings/hwmon/ti,tmp513.yaml                 |    5 +-
 Bindings/hwmon/ti,tps23861.yaml               |    5 +-
 Bindings/i2c/atmel,at91sam-i2c.yaml           |    4 +-
 Bindings/i2c/i2c-demux-pinctrl.yaml           |    3 +-
 Bindings/i2c/i2c-exynos5.yaml                 |    1 +
 Bindings/i2c/i2c-imx-lpi2c.yaml               |    1 +
 Bindings/i2c/i2c-mpc.yaml                     |    2 +-
 Bindings/i2c/i2c-mux-pca954x.yaml             |   30 +
 Bindings/i2c/i2c-pxa.yaml                     |    2 +-
 Bindings/i2c/i2c.txt                          |  151 -
 Bindings/i2c/nvidia,tegra186-bpmp-i2c.yaml    |    3 +-
 Bindings/i2c/qcom,i2c-cci.yaml                |    2 +-
 Bindings/i2c/renesas,rcar-i2c.yaml            |    1 +
 Bindings/i2c/st,nomadik-i2c.yaml              |   49 +-
 Bindings/i3c/aspeed,ast2600-i3c.yaml          |    2 +-
 Bindings/i3c/cdns,i3c-master.yaml             |    2 +-
 Bindings/i3c/i3c.yaml                         |    6 +-
 Bindings/i3c/mipi-i3c-hci.yaml                |    2 +-
 Bindings/i3c/silvaco,i3c-master.yaml          |    2 +-
 Bindings/i3c/snps,dw-i3c-master.yaml          |    2 +-
 Bindings/iio/adc/adc.yaml                     |    1 -
 Bindings/iio/adc/adi,ad9467.yaml              |    4 +
 Bindings/iio/adc/adi,axi-adc.yaml             |    8 +-
 Bindings/iio/adc/microchip,pac1934.yaml       |  120 +
 Bindings/iio/adc/nxp,imx93-adc.yaml           |    4 +-
 Bindings/iio/adc/qcom,spmi-vadc.yaml          |    1 -
 Bindings/iio/adc/richtek,rtq6056.yaml         |    9 +-
 Bindings/iio/adc/ti,ads1298.yaml              |   80 +
 Bindings/iio/afe/voltage-divider.yaml         |   11 +
 Bindings/iio/amplifiers/adi,hmc425a.yaml      |   47 +-
 Bindings/iio/frequency/adi,admfm2000.yaml     |  127 +
 Bindings/iio/gyroscope/bosch,bmg160.yaml      |    8 +-
 Bindings/iio/health/maxim,max30102.yaml       |    2 +-
 Bindings/iio/humidity/ti,hdc2010.yaml         |    3 +
 Bindings/iio/humidity/ti,hdc3020.yaml         |    3 +
 Bindings/iio/imu/st,lsm6dsx.yaml              |    4 +-
 Bindings/iio/light/ams,as73211.yaml           |    7 +-
 Bindings/iio/light/vishay,veml6075.yaml       |    1 +
 .../iio/magnetometer/voltafield,af8133j.yaml  |   60 +
 Bindings/iio/pressure/honeywell,hsc030pa.yaml |    3 +
 .../iio/pressure/honeywell,mprls0025pa.yaml   |   98 +-
 Bindings/iio/temperature/ti,tmp117.yaml       |    8 +
 .../input/allwinner,sun4i-a10-lradc-keys.yaml |    1 -
 Bindings/input/atmel,captouch.txt             |   36 -
 Bindings/input/atmel,captouch.yaml            |   59 +
 Bindings/input/da9062-onkey.txt               |   47 -
 Bindings/input/dlg,da9062-onkey.yaml          |   38 +
 Bindings/input/samsung,s3c6410-keypad.yaml    |  121 +
 Bindings/input/samsung-keypad.txt             |   77 -
 .../input/touchscreen/fsl,imx6ul-tsc.yaml     |   97 +
 Bindings/input/touchscreen/goodix,gt9916.yaml |   95 +
 Bindings/input/touchscreen/goodix.yaml        |    5 +-
 .../input/touchscreen/imagis,ist3038c.yaml    |   21 +-
 Bindings/input/touchscreen/imx6ul_tsc.txt     |   38 -
 Bindings/input/touchscreen/melfas,mms114.yaml |    6 +-
 .../input/touchscreen/silead,gsl1680.yaml     |    2 +-
 Bindings/interconnect/qcom,rpm.yaml           |    3 +
 Bindings/interconnect/qcom,rpmh.yaml          |    2 +-
 Bindings/interconnect/qcom,sm7150-rpmh.yaml   |   84 +
 .../amlogic,meson-gpio-intc.yaml              |    1 +
 Bindings/interrupt-controller/atmel,aic.txt   |   43 -
 Bindings/interrupt-controller/atmel,aic.yaml  |   89 +
 Bindings/interrupt-controller/fsl,intmux.yaml |    3 +
 .../mediatek,mt6577-sysirq.yaml               |   85 +
 .../interrupt-controller/mediatek,sysirq.txt  |   44 -
 .../renesas,rzg2l-irqc.yaml                   |   44 +-
 .../starfive,jh8100-intc.yaml                 |   61 +
 Bindings/iommu/arm,smmu.yaml                  |   20 +-
 Bindings/leds/backlight/kinetic,ktd2801.yaml  |   46 +
 Bindings/leds/backlight/qcom-wled.yaml        |    4 +-
 Bindings/leds/common.yaml                     |   12 +
 Bindings/leds/leds-bcm63138.yaml              |    4 -
 Bindings/leds/leds-bcm6328.yaml               |    4 -
 Bindings/leds/leds-bcm6358.txt                |    2 -
 Bindings/leds/leds-pwm-multicolor.yaml        |    4 +-
 Bindings/leds/leds-pwm.yaml                   |    5 -
 Bindings/leds/leds-qcom-lpg.yaml              |  102 +-
 Bindings/leds/onnn,ncp5623.yaml               |   96 +
 Bindings/mailbox/fsl,mu.yaml                  |   58 +-
 Bindings/media/i2c/techwell,tw9900.yaml       |    2 +-
 Bindings/media/mediatek,vcodec-encoder.yaml   |   31 +-
 Bindings/media/mediatek-jpeg-encoder.yaml     |    3 +-
 Bindings/media/rockchip-isp1.yaml             |   37 +-
 Bindings/media/st,stm32mp25-video-codec.yaml  |   49 +
 .../fsl/fsl,imx-weim-peripherals.yaml         |   31 +
 .../memory-controllers/fsl/fsl,imx-weim.yaml  |  204 ++
 .../mc-peripheral-props.yaml                  |    1 +
 .../nvidia,tegra20-emc.yaml                   |    2 +-
 .../memory-controllers/renesas,rpc-if.yaml    |    1 +
 .../memory-controllers/st,stm32-fmc2-ebi.yaml |    7 +-
 Bindings/mfd/atmel,hlcdc.yaml                 |   99 +
 Bindings/mfd/atmel,sama5d2-flexcom.yaml       |   99 +
 Bindings/mfd/atmel-flexcom.txt                |   64 -
 Bindings/mfd/atmel-hlcdc.txt                  |   56 -
 Bindings/mfd/da9062.txt                       |  124 -
 Bindings/mfd/dlg,da9063.yaml                  |  251 +-
 Bindings/mfd/google,cros-ec.yaml              |    7 +
 Bindings/mfd/iqs62x.yaml                      |    2 +-
 Bindings/mfd/qcom,tcsr.yaml                   |    2 +
 Bindings/mfd/syscon.yaml                      |    3 +
 Bindings/mfd/ti,twl.yaml                      |    2 +
 Bindings/mips/cpus.yaml                       |   13 +-
 Bindings/mips/mobileye.yaml                   |   32 +
 Bindings/misc/qcom,fastrpc.yaml               |    2 +
 Bindings/misc/xlnx,sd-fec.txt                 |   58 -
 Bindings/misc/xlnx,sd-fec.yaml                |  140 +
 Bindings/mmc/fsl-imx-esdhc.yaml               |   11 +-
 Bindings/mmc/fsl-imx-mmc.yaml                 |   12 +
 Bindings/mmc/hi3798cv200-dw-mshc.txt          |   40 -
 .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml    |   97 +
 Bindings/mmc/renesas,sdhi.yaml                |    1 +
 Bindings/mmc/snps,dwcmshc-sdhci.yaml          |    2 +
 Bindings/mtd/atmel-nand.txt                   |    1 +
 Bindings/mtd/brcm,brcmnand.yaml               |   44 +-
 Bindings/mtd/davinci-nand.txt                 |    2 +-
 Bindings/mtd/flctl-nand.txt                   |    2 +-
 Bindings/mtd/fsl-upm-nand.txt                 |    2 +-
 Bindings/mtd/gpio-control-nand.txt            |    2 +-
 Bindings/mtd/gpmi-nand.yaml                   |    2 +-
 Bindings/mtd/hisi504-nand.txt                 |    2 +-
 Bindings/mtd/jedec,spi-nor.yaml               |    3 +
 Bindings/mtd/mtd.yaml                         |    2 +
 Bindings/mtd/nvidia-tegra20-nand.txt          |    2 +-
 Bindings/mtd/orion-nand.txt                   |    2 +-
 Bindings/mtd/partitions/linux,ubi.yaml        |   75 +
 Bindings/mtd/partitions/ubi-volume.yaml       |   40 +
 Bindings/mtd/samsung-s3c2410.txt              |    2 +-
 Bindings/mtd/st,stm32-fmc2-nand.yaml          |   25 +-
 Bindings/mux/mux-controller.yaml              |    2 +-
 .../net/bluetooth/qualcomm-bluetooth.yaml     |    8 +-
 Bindings/net/brcm,asp-v2.0.yaml               |    4 +
 Bindings/net/brcm,unimac-mdio.yaml            |    1 +
 Bindings/net/can/fsl,flexcan.yaml             |    3 +
 Bindings/net/can/microchip,mpfs-can.yaml      |    6 +-
 Bindings/net/can/tcan4x5x.txt                 |    3 +
 Bindings/net/can/xilinx,can.yaml              |    5 +
 Bindings/net/cdns,macb.yaml                   |    5 +
 Bindings/net/dsa/ar9331.txt                   |  147 -
 Bindings/net/dsa/microchip,ksz.yaml           |    1 +
 Bindings/net/dsa/qca,ar9331.yaml              |  161 ++
 Bindings/net/dsa/realtek.yaml                 |    4 +-
 Bindings/net/ethernet-controller.yaml         |    1 -
 Bindings/net/ethernet-phy-package.yaml        |   52 +
 Bindings/net/fsl,fec.yaml                     |    3 +
 Bindings/net/mediatek,net.yaml                |   22 +-
 Bindings/net/nfc/ti,trf7970a.yaml             |    2 +-
 Bindings/net/qca,qca808x.yaml                 |   54 +
 Bindings/net/qcom,ethqos.yaml                 |    9 +-
 Bindings/net/qcom,ipa.yaml                    |    2 +-
 Bindings/net/qcom,ipq4019-mdio.yaml           |   15 +
 Bindings/net/qcom,qca807x.yaml                |  184 ++
 Bindings/net/renesas,etheravb.yaml            |    1 +
 Bindings/net/snps,dwmac.yaml                  |   17 +-
 Bindings/net/starfive,jh7110-dwmac.yaml       |   72 +-
 Bindings/net/ti,cpsw-switch.yaml              |    5 +-
 Bindings/net/ti,dp83822.yaml                  |   34 +
 Bindings/net/ti,k3-am654-cpsw-nuss.yaml       |    5 +-
 Bindings/net/ti,k3-am654-cpts.yaml            |    5 +-
 Bindings/net/wireless/mediatek,mt76.yaml      |   33 +-
 Bindings/net/wireless/qcom,ath10k.yaml        |    1 +
 Bindings/net/wireless/qcom,ath11k-pci.yaml    |    1 +
 Bindings/net/wireless/qcom,ath11k.yaml        |    1 +
 Bindings/nvmem/layouts/fixed-cell.yaml        |   22 +-
 Bindings/nvmem/nvmem-provider.yaml            |   18 +
 Bindings/nvmem/xlnx,zynqmp-nvmem.txt          |   46 -
 Bindings/nvmem/xlnx,zynqmp-nvmem.yaml         |   42 +
 Bindings/opp/opp-v2-base.yaml                 |    2 -
 Bindings/pci/fsl,imx6q-pcie-common.yaml       |   17 +-
 Bindings/pci/fsl,imx6q-pcie-ep.yaml           |   46 +-
 Bindings/pci/fsl,imx6q-pcie.yaml              |   49 +-
 Bindings/pci/qcom,pcie-common.yaml            |  100 +
 Bindings/pci/qcom,pcie-sa8775p.yaml           |  166 ++
 Bindings/pci/qcom,pcie-sc7280.yaml            |  166 ++
 Bindings/pci/qcom,pcie-sc8180x.yaml           |  170 ++
 Bindings/pci/qcom,pcie-sc8280xp.yaml          |  180 ++
 Bindings/pci/qcom,pcie-sm8150.yaml            |  158 +
 Bindings/pci/qcom,pcie-sm8250.yaml            |  173 ++
 Bindings/pci/qcom,pcie-sm8350.yaml            |  184 ++
 Bindings/pci/qcom,pcie-sm8450.yaml            |  178 ++
 Bindings/pci/qcom,pcie-sm8550.yaml            |  171 ++
 Bindings/pci/qcom,pcie-x1e80100.yaml          |  165 ++
 Bindings/pci/qcom,pcie.yaml                   |  378 +--
 Bindings/perf/arm,coresight-pmu.yaml          |   39 +
 .../perf/starfive,jh8100-starlink-pmu.yaml    |   46 +
 Bindings/phy/mediatek,mt8365-csi-rx.yaml      |   79 +
 Bindings/phy/phy-cadence-torrent.yaml         |   11 +-
 Bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml   |  184 ++
 Bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml  |    6 +
 Bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml   |   48 +-
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |   22 -
 Bindings/phy/rockchip,rk3588-hdptx-phy.yaml   |   91 +
 .../pinctrl/amlogic,meson-pinctrl-a1.yaml     |    2 +-
 .../amlogic,meson-pinctrl-g12a-aobus.yaml     |    2 +-
 .../amlogic,meson-pinctrl-g12a-periphs.yaml   |    2 +-
 .../pinctrl/amlogic,meson8-pinctrl-aobus.yaml |    2 +-
 .../pinctrl/amlogic,meson8-pinctrl-cbus.yaml  |    2 +-
 Bindings/pinctrl/atmel,at91-pinctrl.txt       |    2 +
 Bindings/pinctrl/awinic,aw9523-pinctrl.yaml   |  139 +
 Bindings/pinctrl/cirrus,madera.yaml           |    3 +-
 Bindings/pinctrl/cypress,cy8c95x0.yaml        |   24 +-
 Bindings/pinctrl/fsl,imx6ul-pinctrl.txt       |   37 -
 Bindings/pinctrl/fsl,imx6ul-pinctrl.yaml      |  116 +
 Bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml  |  242 ++
 Bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml |    2 -
 Bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml |    3 +-
 .../pinctrl/nvidia,tegra234-pinmux-aon.yaml   |    7 +-
 .../nvidia,tegra234-pinmux-common.yaml        |   84 +-
 Bindings/pinctrl/nvidia,tegra234-pinmux.yaml  |    7 +-
 Bindings/pinctrl/pincfg-node.yaml             |    2 +-
 Bindings/pinctrl/qcom,sm4450-tlmm.yaml        |    2 +-
 Bindings/pinctrl/renesas,pfc.yaml             |    1 +
 Bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   |    2 +
 ...nq-pinctrl.yaml => xlnx,pinctrl-zynq.yaml} |    6 +-
 Bindings/power/qcom,rpmpd.yaml                |    2 +
 Bindings/power/renesas,rcar-sysc.yaml         |    1 +
 Bindings/power/wakeup-source.txt              |    2 +-
 Bindings/pwm/atmel,hlcdc-pwm.yaml             |   35 +
 Bindings/pwm/atmel-hlcdc-pwm.txt              |   29 -
 Bindings/pwm/marvell,pxa-pwm.yaml             |   51 +
 Bindings/pwm/mediatek,mt2712-pwm.yaml         |    1 +
 Bindings/pwm/mediatek,pwm-disp.yaml           |    3 +
 Bindings/pwm/opencores,pwm.yaml               |   56 +
 Bindings/pwm/pwm-amlogic.yaml                 |  115 +-
 Bindings/pwm/pxa-pwm.txt                      |   30 -
 Bindings/regulator/gpio-regulator.yaml        |    4 +-
 Bindings/regulator/infineon,ir38060.yaml      |   45 +
 Bindings/regulator/mcp16502-regulator.txt     |  144 -
 Bindings/regulator/microchip,mcp16502.yaml    |  180 ++
 .../regulator/qcom,usb-vbus-regulator.yaml    |   11 +-
 Bindings/regulator/ti,tps65132.yaml           |   84 +
 Bindings/regulator/tps65132-regulator.txt     |   46 -
 Bindings/remoteproc/mtk,scp.yaml              |    4 +-
 Bindings/remoteproc/qcom,glink-rpm-edge.yaml  |    1 -
 Bindings/remoteproc/qcom,qcs404-pas.yaml      |    2 +-
 Bindings/remoteproc/qcom,sc7180-pas.yaml      |    2 +-
 Bindings/remoteproc/qcom,sc7280-wpss-pil.yaml |    2 +-
 Bindings/remoteproc/qcom,sc8180x-pas.yaml     |    2 +-
 Bindings/remoteproc/qcom,sm6115-pas.yaml      |    2 +-
 Bindings/remoteproc/qcom,sm6350-pas.yaml      |    2 +-
 Bindings/remoteproc/qcom,sm6375-pas.yaml      |    2 +-
 Bindings/remoteproc/qcom,sm8150-pas.yaml      |    2 +-
 Bindings/remoteproc/qcom,sm8350-pas.yaml      |    2 +-
 Bindings/remoteproc/qcom,sm8550-pas.yaml      |   51 +-
 Bindings/remoteproc/qcom,wcnss-pil.yaml       |    2 +-
 Bindings/remoteproc/ti,davinci-rproc.txt      |    3 -
 Bindings/reset/mobileye,eyeq5-reset.yaml      |   43 +
 Bindings/reset/renesas,rst.yaml               |    1 +
 Bindings/reset/sophgo,sg2042-reset.yaml       |   35 +
 Bindings/riscv/cpus.yaml                      |   10 +-
 Bindings/riscv/extensions.yaml                |    7 +
 Bindings/rng/atmel,at91-trng.yaml             |    4 +
 Bindings/rtc/abracon,abx80x.txt               |   31 -
 Bindings/rtc/abracon,abx80x.yaml              |   98 +
 Bindings/rtc/atmel,at91sam9260-rtt.yaml       |    4 +-
 Bindings/rtc/mediatek,mt2712-rtc.yaml         |   39 +
 Bindings/rtc/mediatek,mt7622-rtc.yaml         |   52 +
 Bindings/rtc/rtc-mt2712.txt                   |   14 -
 Bindings/rtc/rtc-mt7622.txt                   |   21 -
 Bindings/rtc/sa1100-rtc.yaml                  |    2 +-
 Bindings/rtc/xlnx,zynqmp-rtc.yaml             |   11 +-
 Bindings/serial/atmel,at91-usart.yaml         |    2 +-
 Bindings/serial/cdns,uart.yaml                |    1 +
 Bindings/serial/fsl-lpuart.yaml               |    1 +
 Bindings/serial/renesas,hscif.yaml            |    1 +
 Bindings/serial/samsung_uart.yaml             |    2 +
 Bindings/serial/serial.yaml                   |    2 +-
 Bindings/serial/st,asc.yaml                   |   55 +
 Bindings/serial/st,stm32-uart.yaml            |    3 +
 Bindings/serial/st-asc.txt                    |   18 -
 Bindings/soc/fsl/fsl,layerscape-dcfg.yaml     |    2 +-
 Bindings/soc/fsl/fsl,layerscape-scfg.yaml     |    2 +-
 Bindings/soc/imx/fsl,imx-anatop.yaml          |  128 +
 Bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml      |   18 +-
 .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |   22 +-
 Bindings/soc/qcom/qcom,pbs.yaml               |   46 +
 Bindings/soc/qcom/qcom,pmic-glink.yaml        |    3 +
 Bindings/soc/qcom/qcom,rpm-master-stats.yaml  |    2 +
 .../qcom/{qcom,spm.yaml => qcom,saw2.yaml}    |   46 +-
 Bindings/soc/renesas/renesas-soc.yaml         |   73 +
 Bindings/soc/renesas/renesas.yaml             |   25 +-
 Bindings/soc/rockchip/grf.yaml                |   23 +
 .../soc/samsung/samsung,exynos-sysreg.yaml    |    2 +
 Bindings/soc/xilinx/xilinx.yaml               |   70 +-
 Bindings/sound/atmel,asoc-wm8904.yaml         |   84 +
 Bindings/sound/atmel,sam9x5-wm8731-audio.yaml |   76 +
 Bindings/sound/atmel,sama5d2-classd.yaml      |    7 +-
 Bindings/sound/atmel-sam9x5-wm8731-audio.txt  |   35 -
 Bindings/sound/atmel-wm8904.txt               |   55 -
 Bindings/sound/audio-graph-port.yaml          |    2 +-
 Bindings/sound/cirrus,cs35l45.yaml            |    3 +
 Bindings/sound/cirrus,cs42l43.yaml            |   11 +-
 Bindings/sound/cs4341.txt                     |    2 +-
 Bindings/sound/everest,es8326.yaml            |    8 +-
 Bindings/sound/fsl,asrc.txt                   |   80 -
 Bindings/sound/fsl,easrc.yaml                 |    4 +-
 Bindings/sound/fsl,imx-asrc.yaml              |  162 ++
 Bindings/sound/fsl,micfil.yaml                |   14 +-
 Bindings/sound/fsl,sai.yaml                   |    6 +
 Bindings/sound/infineon,peb2466.yaml          |    2 +-
 Bindings/sound/microchip,sama7g5-i2smcc.yaml  |   11 +-
 Bindings/sound/qcom,q6usb.yaml                |   55 +
 Bindings/sound/qcom,sm8250.yaml               |    2 +-
 Bindings/sound/qcom,wcd938x.yaml              |   81 +-
 Bindings/sound/qcom,wcd939x-sdw.yaml          |   69 +
 Bindings/sound/qcom,wcd939x.yaml              |   96 +
 Bindings/sound/qcom,wcd93xx-common.yaml       |   95 +
 Bindings/sound/qcom,wsa8840.yaml              |   11 +-
 Bindings/sound/realtek,rt1015.yaml            |   41 +
 Bindings/sound/rt1015.txt                     |   23 -
 Bindings/sound/rt5645.txt                     |    6 +
 Bindings/sound/samsung,tm2.yaml               |    7 +-
 Bindings/spi/atmel,at91rm9200-spi.yaml        |    1 -
 Bindings/spi/samsung,spi.yaml                 |    4 +-
 Bindings/spi/spi-controller.yaml              |   27 +
 Bindings/spi/spi-fsl-lpspi.yaml               |    1 +
 Bindings/spi/spi-nxp-fspi.yaml                |   18 +-
 .../allwinner,sun4i-a10-system-control.yaml   |    2 +-
 Bindings/submitting-patches.rst               |   23 +-
 .../thermal/allwinner,sun8i-a83t-ths.yaml     |   34 +-
 Bindings/thermal/da9062-thermal.txt           |   36 -
 Bindings/thermal/dlg,da9062-thermal.yaml      |   35 +
 Bindings/thermal/qoriq-thermal.yaml           |    3 +-
 Bindings/thermal/rcar-gen3-thermal.yaml       |    2 +
 Bindings/thermal/thermal-zones.yaml           |    2 -
 Bindings/timer/arm,arch_timer_mmio.yaml       |    2 +-
 Bindings/timer/cdns,ttc.yaml                  |   22 +-
 Bindings/timer/mediatek,mtk-timer.txt         |   48 -
 Bindings/timer/mediatek,timer.yaml            |   84 +
 Bindings/timer/mrvl,mmp-timer.yaml            |    2 +-
 Bindings/timer/nxp,sysctr-timer.yaml          |    4 +-
 Bindings/timer/ralink,cevt-systick.yaml       |   38 +
 Bindings/timer/renesas,ostm.yaml              |    2 +-
 Bindings/timer/renesas,tmu.yaml               |   18 +-
 Bindings/timer/samsung,exynos4210-mct.yaml    |    2 +
 Bindings/tpm/tcg,tpm_tis-spi.yaml             |    1 +
 Bindings/trivial-devices.yaml                 |   87 +-
 Bindings/ufs/qcom,ufs.yaml                    |   38 +-
 Bindings/usb/analogix,anx7411.yaml            |   13 -
 Bindings/usb/ci-hdrc-usb2.yaml                |    2 +-
 Bindings/usb/cypress,hx3.yaml                 |    2 +-
 Bindings/usb/fcs,fsa4480.yaml                 |   12 +-
 Bindings/usb/generic-ehci.yaml                |    1 +
 Bindings/usb/gpio-sbu-mux.yaml                |   12 +-
 Bindings/usb/hisilicon,hi3798mv200-dwc3.yaml  |   99 +
 Bindings/usb/ite,it5205.yaml                  |   72 +
 Bindings/usb/mediatek,mtu3.yaml               |    5 +-
 Bindings/usb/microchip,usb5744.yaml           |    2 -
 Bindings/usb/nxp,ptn36502.yaml                |   12 +-
 Bindings/usb/nxp,ptn5110.yaml                 |    6 +-
 Bindings/usb/onnn,nb7vpq904m.yaml             |   13 +-
 Bindings/usb/qcom,dwc3.yaml                   |    2 +-
 Bindings/usb/qcom,pmic-typec.yaml             |   46 +-
 Bindings/usb/qcom,wcd939x-usbss.yaml          |   12 +-
 Bindings/usb/realtek,rts5411.yaml             |   55 +
 Bindings/usb/ti,am62-usb.yaml                 |    8 +-
 Bindings/usb/ti,usb8020b.yaml                 |   69 +
 Bindings/usb/usb-nop-xceiv.yaml               |   11 +-
 Bindings/usb/usb-switch.yaml                  |   67 +
 Bindings/usb/usb.yaml                         |    2 +
 Bindings/vendor-prefixes.yaml                 |   45 +
 Bindings/w1/w1-uart.yaml                      |   59 +
 Bindings/watchdog/arm,sp805.yaml              |    5 +
 Bindings/watchdog/atmel,sama5d4-wdt.yaml      |   12 +-
 Bindings/watchdog/brcm,bcm2835-pm-wdog.txt    |   18 -
 Bindings/watchdog/qcom-wdt.yaml               |    2 +-
 Bindings/watchdog/renesas,wdt.yaml            |    1 +
 Bindings/watchdog/sprd,sp9860-wdt.yaml        |   64 +
 Bindings/watchdog/sprd-wdt.txt                |   19 -
 Bindings/watchdog/starfive,jh7100-wdt.yaml    |   40 +-
 Bindings/writing-schema.rst                   |   30 +-
 include/dt-bindings/arm/qcom,ids.h            |    5 +
 include/dt-bindings/clock/ast2600-clock.h     |    1 +
 include/dt-bindings/clock/exynos850.h         |   56 +
 include/dt-bindings/clock/google,gs101.h      |  129 +
 .../dt-bindings/clock/microchip,mpfs-clock.h  |    5 +
 .../dt-bindings/clock/mobileye,eyeq5-clk.h    |   22 +
 include/dt-bindings/clock/qcom,gcc-msm8953.h  |    4 +
 include/dt-bindings/clock/qcom,gcc-sc8180x.h  |    2 +
 include/dt-bindings/clock/qcom,gcc-sm8150.h   |    3 +
 .../dt-bindings/clock/qcom,x1e80100-camcc.h   |  135 +
 .../dt-bindings/clock/qcom,x1e80100-dispcc.h  |   98 +
 .../dt-bindings/clock/qcom,x1e80100-gpucc.h   |   41 +
 .../dt-bindings/clock/qcom,x1e80100-tcsr.h    |   23 +
 include/dt-bindings/clock/r8a779g0-cpg-mssr.h |    1 +
 .../clock/renesas,r8a779h0-cpg-mssr.h         |   96 +
 .../dt-bindings/clock/rockchip,rk3588-cru.h   |    3 +-
 include/dt-bindings/input/linux-event-codes.h |    1 +
 .../dt-bindings/interconnect/qcom,msm8909.h   |   93 +
 .../interconnect/qcom,sm7150-rpmh.h           |  150 +
 .../interconnect/qcom,x1e80100-rpmh.h         |   24 -
 include/dt-bindings/leds/common.h             |    4 +
 include/dt-bindings/mfd/stm32f7-rcc.h         |    1 +
 include/dt-bindings/power/amlogic,c3-pwrc.h   |    2 +-
 include/dt-bindings/power/qcom-rpmpd.h        |    7 +
 .../dt-bindings/power/renesas,r8a779h0-sysc.h |   49 +
 .../reset/mediatek,mt7988-resets.h            |    6 +
 .../dt-bindings/reset/qcom,x1e80100-gpucc.h   |   19 +
 .../dt-bindings/reset/sophgo,sg2042-reset.h   |   87 +
 src/arc/axc003.dtsi                           |    4 +-
 src/arc/hsdk.dts                              |    1 -
 src/arc/vdk_axs10x_mb.dtsi                    |    2 +-
 src/arm/allwinner/sun8i-r40-feta40i.dtsi      |    7 +
 src/arm/amlogic/meson.dtsi                    |    6 +-
 src/arm/amlogic/meson8.dtsi                   |    1 -
 src/arm/amlogic/meson8b.dtsi                  |    1 -
 src/arm/arm/arm-realview-pb1176.dts           |    2 +-
 src/arm/arm/integratorap-im-pd1.dts           |    3 +-
 src/arm/arm/versatile-ab.dts                  |    3 +-
 src/arm/arm/vexpress-v2p-ca9.dts              |    4 +-
 src/arm/broadcom/bcm47622.dtsi                |   14 +
 src/arm/broadcom/bcm63138.dtsi                |    7 +-
 src/arm/broadcom/bcm63148.dtsi                |   14 +
 src/arm/broadcom/bcm63178.dtsi                |   14 +
 src/arm/broadcom/bcm6756.dtsi                 |   14 +
 src/arm/broadcom/bcm6846.dtsi                 |   14 +
 src/arm/broadcom/bcm6855.dtsi                 |   14 +
 src/arm/broadcom/bcm6878.dtsi                 |   14 +
 src/arm/broadcom/bcm947622.dts                |   10 +
 src/arm/broadcom/bcm963138.dts                |   10 +
 src/arm/broadcom/bcm963138dvt.dts             |   14 +-
 src/arm/broadcom/bcm963148.dts                |   10 +
 src/arm/broadcom/bcm963178.dts                |   10 +
 src/arm/broadcom/bcm96756.dts                 |   10 +
 src/arm/broadcom/bcm96846.dts                 |   10 +
 src/arm/broadcom/bcm96855.dts                 |   10 +
 src/arm/broadcom/bcm96878.dts                 |   10 +
 src/arm/gemini/gemini-dlink-dir-685.dts       |   30 +-
 src/arm/gemini/gemini-dlink-dns-313.dts       |    4 +-
 src/arm/gemini/gemini-sl93512r.dts            |   16 +-
 src/arm/gemini/gemini-sq201.dts               |   16 +-
 src/arm/gemini/gemini-wbd111.dts              |    6 +-
 src/arm/gemini/gemini-wbd222.dts              |    6 +-
 .../marvell/armada-385-clearfog-gtr-l8.dts    |   38 +-
 .../marvell/armada-385-clearfog-gtr-s4.dts    |    2 +
 src/arm/marvell/armada-385-clearfog-gtr.dtsi  |   84 +-
 src/arm/marvell/armada-388-clearfog.dts       |    5 +-
 src/arm/marvell/dove-cubox.dts                |    4 +-
 src/arm/marvell/mmp2-brownstone.dts           |    2 +-
 src/arm/microchip/at91-sama7g54_curiosity.dts |  482 ++++
 src/arm/microchip/at91-sama7g5ek.dts          |    8 +-
 .../at91sam9g25-gardena-smart-gateway.dts     |    2 +
 src/arm/microchip/at91sam9x5ek.dtsi           |    2 +
 src/arm/microchip/sam9x60.dtsi                |   64 +-
 src/arm/microchip/sama7g5.dtsi                |   56 +-
 src/arm/nvidia/tegra124-nyan.dtsi             |    1 +
 src/arm/nvidia/tegra124-venice2.dts           |    1 +
 .../tegra30-asus-nexus7-grouper-common.dtsi   |    3 +
 src/arm/nvidia/tegra30-lg-p880.dts            |  489 ++++
 src/arm/nvidia/tegra30-lg-p895.dts            |  496 ++++
 src/arm/nvidia/tegra30-lg-x3.dtsi             | 1812 ++++++++++++
 src/arm/nxp/imx/imx1-apf9328.dts              |    2 +-
 src/arm/nxp/imx/imx1.dtsi                     |    2 +-
 src/arm/nxp/imx/imx27.dtsi                    |    2 +-
 src/arm/nxp/imx/imx31.dtsi                    |    2 +-
 src/arm/nxp/imx/imx35.dtsi                    |    2 +-
 src/arm/nxp/imx/imx51.dtsi                    |    2 +-
 src/arm/nxp/imx/imx53-qsb-hdmi.dtso           |   87 +
 src/arm/nxp/imx/imx6dl-sielaff.dts            |  533 ++++
 src/arm/nxp/imx/imx6dl-yapp4-common.dtsi      |   25 +-
 src/arm/nxp/imx/imx6q-apalis-eval-v1.2.dts    |  200 ++
 src/arm/nxp/imx/imx6q-apalis-eval.dts         |  108 +-
 src/arm/nxp/imx/imx6q-apalis-eval.dtsi        |  120 +
 src/arm/nxp/imx/imx6qdl-hummingboard.dtsi     |    7 +-
 src/arm/nxp/imx/imx6qdl-hummingboard2.dtsi    |    5 +
 src/arm/nxp/imx/imx6qdl-skov-cpu.dtsi         |   10 +-
 src/arm/nxp/imx/imx6qdl.dtsi                  |    2 +-
 src/arm/nxp/imx/imx6sl-tolino-shine2hd.dts    |    6 +-
 src/arm/nxp/imx/imx6sl.dtsi                   |    2 +-
 src/arm/nxp/imx/imx6sx.dtsi                   |    2 +-
 src/arm/nxp/imx/imx6ul-14x14-evk.dtsi         |    2 +-
 src/arm/nxp/imx/imx6ul-geam.dts               |    2 +-
 .../nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi    |    2 +-
 src/arm/nxp/imx/imx6ul.dtsi                   |   18 +-
 .../nxp/imx/imx6ull-dhcom-som-cfg-sdcard.dtsi |    4 +-
 src/arm/nxp/imx/imx6ull-dhcom-som.dtsi        |    4 +-
 src/arm/nxp/imx/imx6ull-dhcor-som.dtsi        |    7 +-
 src/arm/nxp/imx/imx6ull-tarragon-common.dtsi  |    1 +
 src/arm/nxp/imx/imx6ull.dtsi                  |    2 +-
 src/arm/nxp/imx/imx7-mba7.dtsi                |  325 ++-
 src/arm/nxp/imx/imx7-tqma7.dtsi               |  144 +-
 src/arm/nxp/imx/imx7d-mba7.dts                |   94 +-
 src/arm/nxp/imx/imx7s-warp.dts                |    1 +
 src/arm/nxp/ls/ls1021a.dtsi                   |    2 +
 src/arm/nxp/mxs/imx28-evk.dts                 |    2 +-
 src/arm/qcom/qcom-apq8026-lg-lenok.dts        |   38 +
 .../qcom-apq8026-samsung-matisse-wifi.dts     |  452 +--
 src/arm/qcom/qcom-apq8064.dtsi                |   70 +-
 src/arm/qcom/qcom-apq8084.dtsi                |   13 +-
 src/arm/qcom/qcom-ipq4019-ap.dk01.1.dtsi      |  138 +-
 src/arm/qcom/qcom-ipq4019.dtsi                |   35 +-
 src/arm/qcom/qcom-ipq8064.dtsi                |   12 +-
 .../qcom-msm8226-samsung-matisse-common.dtsi  |  457 +++
 src/arm/qcom/qcom-msm8226.dtsi                |  736 +++--
 src/arm/qcom/qcom-msm8660.dtsi                |   17 +-
 src/arm/qcom/qcom-msm8926-htc-memul.dts       |   15 +-
 .../qcom/qcom-msm8926-samsung-matisselte.dts  |   37 +
 src/arm/qcom/qcom-msm8960-pins.dtsi           |   21 +
 .../qcom/qcom-msm8960-samsung-expressatt.dts  |   71 +-
 src/arm/qcom/qcom-msm8960.dtsi                |   48 +-
 src/arm/qcom/qcom-msm8974.dtsi                |   33 +-
 src/arm/qcom/qcom-sdx55.dtsi                  |   32 +-
 src/arm/qcom/qcom-sdx65.dtsi                  |   48 +-
 src/arm/renesas/r8a73a4-ape6evm.dts           |   12 +
 src/arm/renesas/r8a73a4.dtsi                  |   23 +-
 src/arm/renesas/r8a7740.dtsi                  |    2 +
 src/arm/renesas/r8a7778.dtsi                  |   11 +-
 src/arm/renesas/r8a7779.dtsi                  |    9 +-
 src/arm/rockchip/rk3128-xpi-3128.dts          |   29 +
 src/arm/rockchip/rk3128.dtsi                  |   60 +
 src/arm/rockchip/rk322x.dtsi                  |   16 +-
 src/arm/rockchip/rk3288.dtsi                  |   16 +-
 src/arm/rockchip/rv1126-sonoff-ihost.dtsi     |   10 +-
 src/arm/samsung/exynos4412-i9300.dts          |    2 +-
 src/arm/samsung/exynos4412-i9305.dts          |    2 +-
 src/arm/samsung/exynos4412-n710x.dts          |    2 +-
 src/arm/samsung/exynos4412-p4note.dtsi        |   53 +-
 .../samsung/exynos5420-galaxy-tab-common.dtsi |   34 +-
 src/arm/samsung/exynos5420-peach-pit.dts      |    1 +
 .../samsung/exynos5422-odroidxu3-common.dtsi  |   16 +-
 src/arm/samsung/exynos5800-peach-pi.dts       |    1 +
 src/arm/st/stih407-pinctrl.dtsi               |    8 +-
 src/arm/st/stm32f769-disco-mb1166-reva09.dts  |   13 +
 src/arm/st/stm32f769-disco.dts                |   70 +-
 src/arm/st/stm32f769.dtsi                     |   20 +
 src/arm/st/stm32mp131.dtsi                    |    7 +
 src/arm/st/stm32mp135f-dk.dts                 |    8 +
 src/arm/st/stm32mp157.dtsi                    |    2 +-
 src/arm/st/stm32mp157a-dk1-scmi.dts           |    2 +-
 src/arm/st/stm32mp157c-dk2-scmi.dts           |    2 +-
 src/arm/st/stm32mp157c-ed1-scmi.dts           |    2 +-
 src/arm/st/stm32mp157c-ev1-scmi.dts           |    2 +-
 src/arm/st/stm32mp157c-lxa-tac-gen2.dts       |    2 +-
 src/arm/st/stm32mp15xc-lxa-tac.dtsi           |    6 +-
 src/arm/ti/davinci/da850.dtsi                 |    4 +-
 src/arm/ti/keystone/keystone-clocks.dtsi      |    2 +-
 src/arm/ti/keystone/keystone-k2e-clocks.dtsi  |    2 +-
 src/arm/ti/keystone/keystone-k2e-evm.dts      |    2 +-
 src/arm/ti/keystone/keystone-k2e-netcp.dtsi   |    2 +-
 src/arm/ti/keystone/keystone-k2e.dtsi         |    2 +-
 src/arm/ti/keystone/keystone-k2g-evm.dts      |    2 +-
 src/arm/ti/keystone/keystone-k2g-ice.dts      |    2 +-
 src/arm/ti/keystone/keystone-k2g-netcp.dtsi   |    2 +-
 src/arm/ti/keystone/keystone-k2g.dtsi         |    2 +-
 src/arm/ti/keystone/keystone-k2hk-clocks.dtsi |    2 +-
 src/arm/ti/keystone/keystone-k2hk-evm.dts     |    2 +-
 src/arm/ti/keystone/keystone-k2hk-netcp.dtsi  |    2 +-
 src/arm/ti/keystone/keystone-k2hk.dtsi        |    2 +-
 src/arm/ti/keystone/keystone-k2l-clocks.dtsi  |    2 +-
 src/arm/ti/keystone/keystone-k2l-evm.dts      |    2 +-
 src/arm/ti/keystone/keystone-k2l-netcp.dtsi   |    2 +-
 src/arm/ti/keystone/keystone-k2l.dtsi         |    2 +-
 src/arm/ti/keystone/keystone.dtsi             |    2 +-
 src/arm/ti/omap/am335x-baltos-ir2110.dts      |    2 +-
 src/arm/ti/omap/am335x-baltos-ir3220.dts      |    2 +-
 src/arm/ti/omap/am335x-baltos-ir5221.dts      |    2 +-
 src/arm/ti/omap/am335x-baltos-leds.dtsi       |    2 +-
 src/arm/ti/omap/am335x-baltos.dtsi            |    2 +-
 src/arm/ti/omap/am335x-base0033.dts           |    2 +-
 src/arm/ti/omap/am335x-bone-common.dtsi       |    4 +-
 src/arm/ti/omap/am335x-cm-t335.dts            |    2 +-
 src/arm/ti/omap/am335x-evmsk.dts              |    2 +-
 src/arm/ti/omap/am335x-guardian.dts           |    4 +-
 src/arm/ti/omap/am335x-icev2.dts              |    2 +-
 src/arm/ti/omap/am335x-igep0033.dtsi          |    2 +-
 src/arm/ti/omap/am335x-myirtech-myc.dtsi      |    2 +-
 src/arm/ti/omap/am335x-myirtech-myd.dts       |    2 +-
 src/arm/ti/omap/am335x-nano.dts               |    2 +-
 src/arm/ti/omap/am335x-netcan-plus-1xx.dts    |    2 +-
 src/arm/ti/omap/am335x-netcom-plus-2xx.dts    |    2 +-
 src/arm/ti/omap/am335x-netcom-plus-8xx.dts    |    2 +-
 src/arm/ti/omap/am335x-pdu001.dts             |    2 +-
 .../am335x-sancloud-bbe-extended-wifi.dts     |    2 +-
 src/arm/ti/omap/am335x-sancloud-bbe-lite.dts  |    2 +-
 src/arm/ti/omap/am335x-sbc-t335.dts           |    2 +-
 src/arm/ti/omap/am335x-sl50.dts               |    3 +-
 src/arm/ti/omap/am33xx-clocks.dtsi            |   39 +-
 src/arm/ti/omap/am33xx.dtsi                   |    9 +-
 src/arm/ti/omap/am3517.dtsi                   |   11 +-
 src/arm/ti/omap/am35xx-clocks.dtsi            |   18 +-
 src/arm/ti/omap/am4372.dtsi                   |    6 +
 src/arm/ti/omap/am437x-cm-t43.dts             |    2 +-
 src/arm/ti/omap/am437x-sbc-t43.dts            |    2 +-
 src/arm/ti/omap/am5729-beagleboneai.dts       |    2 +-
 src/arm/ti/omap/am57xx-cl-som-am57x.dts       |    2 +-
 src/arm/ti/omap/am57xx-sbc-am57x.dts          |    2 +-
 src/arm/ti/omap/compulab-sb-som.dtsi          |    2 +-
 src/arm/ti/omap/dra7-l4.dtsi                  |    2 +-
 src/arm/ti/omap/dra7.dtsi                     |   17 +-
 src/arm/ti/omap/dra74x-p.dtsi                 |    2 +-
 src/arm/ti/omap/dra7xx-clocks.dtsi            |    2 +-
 src/arm/ti/omap/omap3430es1-clocks.dtsi       |   52 +-
 src/arm/ti/omap/omap34xx-omap36xx-clocks.dtsi |   86 +-
 src/arm/ti/omap/omap34xx.dtsi                 |   11 +-
 ...map36xx-am35xx-omap3430es2plus-clocks.dtsi |   28 +-
 src/arm/ti/omap/omap36xx-clocks.dtsi          |    7 +-
 .../omap/omap36xx-omap3430es2plus-clocks.dtsi |   46 +-
 src/arm/ti/omap/omap36xx.dtsi                 |    9 +-
 src/arm/ti/omap/omap3xxx-clocks.dtsi          |  510 ++--
 src/arm/ti/omap/omap4-epson-embt2ws.dts       |    1 +
 src/arm/ti/omap/omap4-panda-common.dtsi       |    1 +
 src/arm/ti/omap/omap4-sdp.dts                 |    2 +-
 src/arm/ti/omap/omap4.dtsi                    |    9 +-
 src/arm/ti/omap/omap5-igep0050.dts            |    2 +-
 src/arm/ti/omap/omap5.dtsi                    |    9 +-
 src/arm/ti/omap/twl4030.dtsi                  |    2 +-
 src/arm/ti/omap/twl6030.dtsi                  |    4 +-
 src/arm64/allwinner/sun50i-h6-beelink-gs1.dts |    2 +
 src/arm64/allwinner/sun50i-h6-tanix.dtsi      |    2 +
 src/arm64/allwinner/sun50i-h6.dtsi            |    7 +-
 .../sun50i-h616-bigtreetech-cb1-manta.dts     |    2 +-
 .../sun50i-h616-bigtreetech-cb1.dtsi          |    4 +-
 .../allwinner/sun50i-h616-bigtreetech-pi.dts  |    2 +-
 src/arm64/allwinner/sun50i-h616.dtsi          |  155 +
 .../sun50i-h618-longan-module-3h.dtsi         |   75 +
 .../allwinner/sun50i-h618-longanpi-3h.dts     |  144 +
 .../sun50i-h618-transpeed-8k618-t.dts         |   23 +
 .../allwinner/sun50i-h64-remix-mini-pc.dts    |  356 +++
 src/arm64/amlogic/amlogic-c3.dtsi             |    7 +
 src/arm64/amlogic/amlogic-t7.dtsi             |   12 +-
 src/arm64/amlogic/meson-a1-ad402.dts          |    2 +-
 src/arm64/amlogic/meson-a1.dtsi               |    2 +
 .../meson-axg-jethome-jethub-j1xx.dtsi        |   30 +-
 src/arm64/amlogic/meson-axg-s400.dts          |   16 +-
 src/arm64/amlogic/meson-axg.dtsi              |    8 +
 src/arm64/amlogic/meson-g12-common.dtsi       |    3 +
 src/arm64/amlogic/meson-g12a-fbx8am-brcm.dtso |   31 +
 .../amlogic/meson-g12a-fbx8am-realtek.dtso    |   21 +
 src/arm64/amlogic/meson-g12a-fbx8am.dts       |  462 +++
 src/arm64/amlogic/meson-g12a-radxa-zero.dts   |   12 +-
 src/arm64/amlogic/meson-g12a-sei510.dts       |   14 +-
 src/arm64/amlogic/meson-g12a-u200.dts         |   16 +-
 src/arm64/amlogic/meson-g12a-x96-max.dts      |   14 +-
 src/arm64/amlogic/meson-g12b-odroid-n2.dtsi   |    2 +-
 src/arm64/amlogic/meson-g12b-odroid.dtsi      |   20 +-
 src/arm64/amlogic/meson-g12b-w400.dtsi        |   10 +-
 src/arm64/amlogic/meson-gx-libretech-pc.dtsi  |   12 +-
 src/arm64/amlogic/meson-gx-p23x-q20x.dtsi     |    8 +-
 src/arm64/amlogic/meson-gxbb-nexbox-a95x.dts  |    6 +-
 src/arm64/amlogic/meson-gxbb-odroidc2.dts     |    8 +-
 src/arm64/amlogic/meson-gxbb-p200.dts         |    4 +-
 src/arm64/amlogic/meson-gxbb-p20x.dtsi        |    6 +-
 src/arm64/amlogic/meson-gxbb-vega-s95.dtsi    |    8 +-
 src/arm64/amlogic/meson-gxbb-wetek.dtsi       |    8 +-
 .../amlogic/meson-gxl-s805x-libretech-ac.dts  |    8 +-
 src/arm64/amlogic/meson-gxl-s805x-p241.dts    |    8 +-
 .../meson-gxl-s905w-jethome-jethub-j80.dts    |    8 +-
 .../meson-gxl-s905x-hwacom-amazetv.dts        |    6 +-
 .../meson-gxl-s905x-libretech-cc-v2.dts       |   12 +-
 .../amlogic/meson-gxl-s905x-libretech-cc.dts  |    6 +-
 .../amlogic/meson-gxl-s905x-nexbox-a95x.dts   |    6 +-
 src/arm64/amlogic/meson-gxl-s905x-p212.dtsi   |    8 +-
 src/arm64/amlogic/meson-gxm-khadas-vim2.dts   |    8 +-
 .../amlogic/meson-gxm-s912-libretech-pc.dts   |    2 +-
 src/arm64/amlogic/meson-khadas-vim3.dtsi      |   16 +-
 .../amlogic/meson-libretech-cottonwood.dtsi   |    6 +-
 src/arm64/amlogic/meson-sm1-ac2xx.dtsi        |   10 +-
 src/arm64/amlogic/meson-sm1-bananapi.dtsi     |   14 +-
 src/arm64/amlogic/meson-sm1-odroid-hc4.dts    |    4 +-
 src/arm64/amlogic/meson-sm1-odroid.dtsi       |   20 +-
 src/arm64/amlogic/meson-sm1-sei610.dts        |   12 +-
 .../bcmbca/bcm4906-netgear-r8000p.dts         |    5 +
 .../bcmbca/bcm4906-tplink-archer-c2300-v1.dts |    5 +
 .../bcmbca/bcm4908-asus-gt-ac5300.dts         |   19 +-
 src/arm64/broadcom/bcmbca/bcm4908.dtsi        |    7 +-
 src/arm64/broadcom/bcmbca/bcm4912.dtsi        |   14 +
 src/arm64/broadcom/bcmbca/bcm63146.dtsi       |   14 +
 src/arm64/broadcom/bcmbca/bcm63158.dtsi       |   14 +
 src/arm64/broadcom/bcmbca/bcm6813.dtsi        |   14 +
 src/arm64/broadcom/bcmbca/bcm6856.dtsi        |   14 +
 src/arm64/broadcom/bcmbca/bcm6858.dtsi        |   14 +
 src/arm64/broadcom/bcmbca/bcm94908.dts        |   10 +
 src/arm64/broadcom/bcmbca/bcm94912.dts        |   10 +
 src/arm64/broadcom/bcmbca/bcm963146.dts       |   10 +
 src/arm64/broadcom/bcmbca/bcm963158.dts       |   10 +
 src/arm64/broadcom/bcmbca/bcm96813.dts        |   10 +
 src/arm64/broadcom/bcmbca/bcm96856.dts        |   10 +
 src/arm64/broadcom/bcmbca/bcm96858.dts        |   10 +
 src/arm64/exynos/exynos850.dtsi               |   64 +
 src/arm64/exynos/google/gs101-oriole.dts      |   24 +
 src/arm64/exynos/google/gs101-pinctrl.dtsi    |    2 +-
 src/arm64/exynos/google/gs101.dtsi            |  131 +-
 src/arm64/freescale/fsl-ls1012a.dtsi          |   10 +-
 src/arm64/freescale/fsl-ls1046a.dtsi          |    1 -
 src/arm64/freescale/fsl-ls1088a.dtsi          |    6 +
 src/arm64/freescale/fsl-lx2160a.dtsi          |   32 +-
 .../freescale/imx8-apalis-eval-v1.1.dtsi      |   26 +
 .../freescale/imx8-apalis-eval-v1.2.dtsi      |  124 +
 src/arm64/freescale/imx8-apalis-eval.dtsi     |   22 -
 src/arm64/freescale/imx8-apalis-v1.1.dtsi     |    1 -
 src/arm64/freescale/imx8-ss-audio.dtsi        |  330 +++
 src/arm64/freescale/imx8-ss-conn.dtsi         |   16 +-
 src/arm64/freescale/imx8-ss-dma.dtsi          |  103 +-
 src/arm64/freescale/imx8-ss-gpu0.dtsi         |   27 +
 src/arm64/freescale/imx8-ss-lsio.dtsi         |   16 +-
 src/arm64/freescale/imx8dxl-evk.dts           |  101 +
 src/arm64/freescale/imx8dxl-ss-adma.dtsi      |   77 +
 src/arm64/freescale/imx8dxl.dtsi              |    1 +
 .../freescale/imx8dxp-tqma8xdp-mba8xx.dts     |   16 +
 src/arm64/freescale/imx8dxp-tqma8xdp.dtsi     |   24 +
 src/arm64/freescale/imx8dxp.dtsi              |   24 +
 src/arm64/freescale/imx8mm-evk.dtsi           |   69 +
 .../freescale/imx8mm-kontron-bl-osm-s.dts     |  294 +-
 src/arm64/freescale/imx8mm-kontron-bl.dts     |   38 +-
 src/arm64/freescale/imx8mm-kontron-osm-s.dtsi |  567 +++-
 src/arm64/freescale/imx8mm-kontron-sl.dtsi    |    4 +-
 .../freescale/imx8mm-tqma8mqml-mba8mx.dts     |   14 +-
 src/arm64/freescale/imx8mm-venice-gw71xx.dtsi |   40 +-
 src/arm64/freescale/imx8mm-venice-gw7901.dts  |   14 +-
 src/arm64/freescale/imx8mn-beacon-kit.dts     |    2 -
 src/arm64/freescale/imx8mn-evk.dtsi           |   36 +
 src/arm64/freescale/imx8mn-rve-gateway.dts    |    2 +-
 .../imx8mn-tqma8mqnl-mba8mx-usbotg.dtso       |   64 +
 .../freescale/imx8mn-tqma8mqnl-mba8mx.dts     |    5 +-
 src/arm64/freescale/imx8mn.dtsi               |    2 +-
 src/arm64/freescale/imx8mp-beacon-som.dtsi    |   71 +
 .../freescale/imx8mp-data-modul-edm-sbc.dts   |   82 +-
 src/arm64/freescale/imx8mp-evk.dts            |   33 +-
 .../freescale/imx8mp-phyboard-pollux-rdk.dts  |  107 +-
 src/arm64/freescale/imx8mp-phycore-som.dtsi   |    1 -
 src/arm64/freescale/imx8mp-venice-gw71xx.dtsi |   10 +-
 src/arm64/freescale/imx8mp-venice-gw72xx.dtsi |    2 +-
 src/arm64/freescale/imx8mp-venice-gw73xx.dtsi |    2 +-
 src/arm64/freescale/imx8mp-verdin.dtsi        |    3 +-
 src/arm64/freescale/imx8mp.dtsi               |   12 +-
 src/arm64/freescale/imx8mq-tqma8mq-mba8mx.dts |   24 +-
 .../freescale/imx8qm-apalis-eval-v1.2.dts     |   16 +
 src/arm64/freescale/imx8qm-apalis-eval.dts    |    2 +-
 .../imx8qm-apalis-v1.1-eval-v1.2.dts          |   26 +
 .../freescale/imx8qm-apalis-v1.1-eval.dts     |    2 +-
 src/arm64/freescale/imx8qm-mek.dts            |   26 +
 src/arm64/freescale/imx8qm-ss-conn.dtsi       |    5 +
 src/arm64/freescale/imx8qm-ss-dma.dtsi        |   63 +-
 src/arm64/freescale/imx8qm.dtsi               |   41 +
 .../freescale/imx8qxp-tqma8xqp-mba8xx.dts     |   16 +
 src/arm64/freescale/imx8qxp-tqma8xqp.dtsi     |   14 +
 src/arm64/freescale/imx8qxp.dtsi              |    8 +
 src/arm64/freescale/imx8ulp-evk.dts           |    2 +-
 src/arm64/freescale/imx93-phyboard-segin.dts  |  117 +
 src/arm64/freescale/imx93-phycore-som.dtsi    |  126 +
 src/arm64/freescale/imx93-tqma9352.dtsi       |    4 +-
 .../freescale/imx93-var-som-symphony.dts      |  351 +++
 src/arm64/freescale/imx93-var-som.dtsi        |  110 +
 src/arm64/freescale/imx93.dtsi                |    4 +-
 src/arm64/freescale/mba8mx.dtsi               |   21 +-
 src/arm64/freescale/mba8xx.dtsi               |  554 ++++
 src/arm64/freescale/tqma8xx.dtsi              |  265 ++
 src/arm64/intel/socfpga_agilex5.dtsi          |    4 +-
 src/arm64/marvell/ac5-98dx25xx.dtsi           |   31 +-
 src/arm64/marvell/ac5-98dx35xx-rd.dts         |    4 +
 src/arm64/marvell/armada-37xx.dtsi            |   10 +-
 src/arm64/marvell/armada-ap807.dtsi           |    3 +
 src/arm64/marvell/armada-cp11x.dtsi           |   10 +-
 src/arm64/mediatek/mt2712-evb.dts             |   12 +-
 src/arm64/mediatek/mt2712e.dtsi               |    5 +-
 src/arm64/mediatek/mt6797.dtsi                |    8 +-
 .../mediatek/mt7622-bananapi-bpi-r64.dts      |   13 +
 src/arm64/mediatek/mt7622-rfb1.dts            |   25 +
 src/arm64/mediatek/mt7622.dtsi                |   34 +-
 src/arm64/mediatek/mt7981b-xiaomi-ax3000t.dts |   15 +
 src/arm64/mediatek/mt7981b.dtsi               |  105 +
 .../mediatek/mt7986a-acelink-ew-7886cax.dts   |  173 ++
 .../mt7986a-bananapi-bpi-r3-nand.dtso         |    2 +-
 .../mediatek/mt7986a-bananapi-bpi-r3.dts      |    8 +-
 src/arm64/mediatek/mt7986a-rfb.dts            |   31 +-
 src/arm64/mediatek/mt7986a.dtsi               |  176 +-
 src/arm64/mediatek/mt7986b-rfb.dts            |   31 +-
 .../mediatek/mt7988a-bananapi-bpi-r4.dts      |   11 +
 src/arm64/mediatek/mt7988a.dtsi               |  136 +
 src/arm64/mediatek/mt8173-elm-hana-rev7.dts   |    2 +-
 src/arm64/mediatek/mt8173-elm.dtsi            |    3 +-
 src/arm64/mediatek/mt8173-evb.dts             |    2 +-
 src/arm64/mediatek/mt8173.dtsi                |   19 +-
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   |    3 +-
 src/arm64/mediatek/mt8183-kukui-kakadu.dtsi   |    4 +
 src/arm64/mediatek/mt8183-kukui-kodama.dtsi   |    4 +
 src/arm64/mediatek/mt8183-kukui-krane.dtsi    |    4 +
 src/arm64/mediatek/mt8183-kukui.dtsi          |    6 +-
 src/arm64/mediatek/mt8183-pumpkin.dts         |    2 +-
 src/arm64/mediatek/mt8183.dtsi                |   12 +-
 src/arm64/mediatek/mt8186-corsola-krabby.dtsi |  129 +
 .../mt8186-corsola-magneton-sku393216.dts     |   39 +
 .../mt8186-corsola-magneton-sku393217.dts     |   39 +
 .../mt8186-corsola-magneton-sku393218.dts     |   26 +
 .../mt8186-corsola-rusty-sku196608.dts        |   26 +
 .../mt8186-corsola-steelix-sku131072.dts      |   18 +
 .../mt8186-corsola-steelix-sku131073.dts      |   18 +
 .../mediatek/mt8186-corsola-steelix.dtsi      |  199 ++
 .../mt8186-corsola-tentacool-sku327681.dts    |   57 +
 .../mt8186-corsola-tentacool-sku327683.dts    |   24 +
 .../mt8186-corsola-tentacruel-sku262144.dts   |   44 +
 .../mt8186-corsola-tentacruel-sku262148.dts   |   26 +
 src/arm64/mediatek/mt8186-corsola.dtsi        | 1681 +++++++++++
 src/arm64/mediatek/mt8186.dtsi                |   93 +-
 src/arm64/mediatek/mt8192-asurada.dtsi        |   11 +-
 src/arm64/mediatek/mt8192.dtsi                |   11 +-
 .../mediatek/mt8195-cherry-tomato-r1.dts      |    4 +
 .../mediatek/mt8195-cherry-tomato-r2.dts      |    4 +
 .../mediatek/mt8195-cherry-tomato-r3.dts      |    4 +
 src/arm64/mediatek/mt8195-cherry.dtsi         |   63 +-
 src/arm64/mediatek/mt8195-demo.dts            |   18 +-
 src/arm64/mediatek/mt8195-evb.dts             |   12 +
 src/arm64/mediatek/mt8195.dtsi                |  133 +-
 src/arm64/mediatek/mt8395-genio-1200-evk.dts  |   17 +-
 src/arm64/mediatek/mt8395-radxa-nio-12l.dts   |  825 ++++++
 src/arm64/nvidia/tegra132-norrin.dts          |    1 +
 src/arm64/nvidia/tegra194-p2888.dtsi          |   50 +
 src/arm64/nvidia/tegra194-p2972-0000.dts      |   51 +-
 src/arm64/nvidia/tegra194-p3668.dtsi          |   27 +
 src/arm64/nvidia/tegra234-p3701.dtsi          | 1953 +------------
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts |    1 -
 src/arm64/nvidia/tegra234-p3767-0000.dtsi     |   14 -
 src/arm64/nvidia/tegra234-p3767-0005.dtsi     |   14 -
 src/arm64/nvidia/tegra234-p3767.dtsi          |   86 +
 .../nvidia/tegra234-p3768-0000+p3767-0000.dts |    7 +-
 .../nvidia/tegra234-p3768-0000+p3767-0005.dts |   12 +-
 src/arm64/nvidia/tegra234-sim-vdk.dts         |    1 -
 src/arm64/nvidia/tegra234.dtsi                | 2544 +++++++++++++++--
 .../qcom/apq8016-sbc-d3-camera-mezzanine.dts  |    8 +-
 src/arm64/qcom/ipq5332.dtsi                   |    8 +-
 src/arm64/qcom/ipq6018.dtsi                   |  159 ++
 src/arm64/qcom/ipq8074.dtsi                   |   16 +
 src/arm64/qcom/ipq9574.dtsi                   |   12 +-
 src/arm64/qcom/msm8216-samsung-fortuna3g.dts  |   11 +
 .../qcom/msm8916-samsung-fortuna-common.dtsi  |  203 ++
 .../qcom/msm8916-samsung-gprimeltecan.dts     |   27 +
 .../qcom/msm8916-samsung-grandprimelte.dts    |   16 +
 .../qcom/msm8916-samsung-rossa-common.dtsi    |   16 +
 src/arm64/qcom/msm8916-samsung-rossa.dts      |   16 +
 src/arm64/qcom/msm8916.dtsi                   |    9 +
 src/arm64/qcom/msm8939.dtsi                   |   11 +-
 src/arm64/qcom/msm8953.dtsi                   |  155 +-
 .../qcom/msm8994-msft-lumia-octagon.dtsi      |    2 +-
 .../qcom/msm8994-sony-xperia-kitakami.dtsi    |    2 +-
 src/arm64/qcom/msm8994.dtsi                   |    4 +-
 src/arm64/qcom/msm8996.dtsi                   |   18 +-
 src/arm64/qcom/msm8998.dtsi                   |   26 +-
 src/arm64/qcom/{pm2250.dtsi => pm4125.dtsi}   |   38 +-
 src/arm64/qcom/pm6150.dtsi                    |   46 +
 src/arm64/qcom/pmi632.dtsi                    |   39 +
 src/arm64/qcom/qcm2290.dtsi                   |    7 +
 src/arm64/qcom/qcm6490-fairphone-fp5.dts      |   56 +-
 src/arm64/qcom/qcm6490-idp.dts                |   39 +-
 src/arm64/qcom/qcs404.dtsi                    |   16 +
 src/arm64/qcom/qcs6490-rb3gen2.dts            |   23 +-
 src/arm64/qcom/qrb2210-rb1.dts                |   96 +-
 src/arm64/qcom/qrb4210-rb2.dts                |   50 +-
 src/arm64/qcom/sa8155p-adp.dts                |   30 +-
 src/arm64/qcom/sa8295p-adp.dts                |   68 +
 src/arm64/qcom/sa8540p-ride.dts               |    4 +-
 src/arm64/qcom/sa8540p.dtsi                   |    3 +
 src/arm64/qcom/sa8775p.dtsi                   |  119 +-
 src/arm64/qcom/sc7180-trogdor.dtsi            |    3 +
 src/arm64/qcom/sc7180.dtsi                    |   86 +-
 src/arm64/qcom/sc7280-chrome-common.dtsi      |   28 +
 src/arm64/qcom/sc7280-herobrine.dtsi          |    1 +
 src/arm64/qcom/sc7280-idp-ec-h1.dtsi          |    1 +
 src/arm64/qcom/sc7280.dtsi                    |  129 +-
 src/arm64/qcom/sc8180x.dtsi                   |  143 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |   39 +-
 src/arm64/qcom/sc8280xp-pmics.dtsi            |   39 +-
 src/arm64/qcom/sc8280xp.dtsi                  |  612 +++-
 src/arm64/qcom/sda660-inforce-ifc6560.dts     |    5 +
 src/arm64/qcom/sdm450-motorola-ali.dts        |    2 +-
 src/arm64/qcom/sdm450.dtsi                    |   14 +
 src/arm64/qcom/sdm630-sony-xperia-nile.dtsi   |   16 +
 src/arm64/qcom/sdm630.dtsi                    |   62 +-
 src/arm64/qcom/sdm632.dtsi                    |    8 +
 src/arm64/qcom/sdm660-xiaomi-lavender.dts     |    6 +
 src/arm64/qcom/sdm670.dtsi                    |   14 +-
 src/arm64/qcom/sdm845-cheza.dtsi              |    1 +
 src/arm64/qcom/sdm845-db845c.dts              |    2 +-
 src/arm64/qcom/sdm845-oneplus-common.dtsi     |    8 +-
 src/arm64/qcom/sdm845-shift-axolotl.dts       |    2 +-
 src/arm64/qcom/sdm845.dtsi                    |   63 +-
 src/arm64/qcom/sm4450.dtsi                    |    2 +-
 src/arm64/qcom/sm6115.dtsi                    |   95 +-
 src/arm64/qcom/sm6125.dtsi                    |   17 +-
 src/arm64/qcom/sm6350.dtsi                    |  601 +++-
 src/arm64/qcom/sm6375.dtsi                    |   14 +-
 src/arm64/qcom/sm7125-xiaomi-common.dtsi      |   26 +
 src/arm64/qcom/sm7125-xiaomi-curtana.dts      |   16 +
 src/arm64/qcom/sm7225-fairphone-fp4.dts       |   61 +-
 src/arm64/qcom/sm8150.dtsi                    |  115 +-
 .../qcom/sm8250-xiaomi-elish-common.dtsi      |    3 +-
 src/arm64/qcom/sm8250.dtsi                    |  113 +-
 src/arm64/qcom/sm8350.dtsi                    |   87 +-
 src/arm64/qcom/sm8450-hdk.dts                 |    6 +-
 src/arm64/qcom/sm8450.dtsi                    |   97 +-
 src/arm64/qcom/sm8550-hdk.dts                 | 1306 +++++++++
 src/arm64/qcom/sm8550-mtp.dts                 |   11 +-
 src/arm64/qcom/sm8550-qrd.dts                 |   53 +-
 src/arm64/qcom/sm8550.dtsi                    |  187 +-
 src/arm64/qcom/sm8650-mtp.dts                 |  155 +
 src/arm64/qcom/sm8650-qrd.dts                 |  439 ++-
 src/arm64/qcom/sm8650.dtsi                    |   81 +-
 src/arm64/qcom/x1e80100-crd.dts               |  450 +++
 src/arm64/qcom/x1e80100-qcp.dts               |  175 +-
 src/arm64/qcom/x1e80100.dtsi                  | 1781 +++++++++++-
 src/arm64/renesas/r8a774a1.dtsi               |   11 +-
 src/arm64/renesas/r8a774b1.dtsi               |   11 +-
 src/arm64/renesas/r8a774c0.dtsi               |   11 +-
 src/arm64/renesas/r8a774e1.dtsi               |   11 +-
 src/arm64/renesas/r8a77951.dtsi               |   11 +-
 src/arm64/renesas/r8a77960.dtsi               |   11 +-
 src/arm64/renesas/r8a77961.dtsi               |   11 +-
 src/arm64/renesas/r8a77965.dtsi               |   11 +-
 src/arm64/renesas/r8a77970.dtsi               |   11 +-
 src/arm64/renesas/r8a77980.dtsi               |   17 +-
 src/arm64/renesas/r8a77990.dtsi               |   11 +-
 src/arm64/renesas/r8a77995.dtsi               |   11 +-
 src/arm64/renesas/r8a779a0.dtsi               |   21 +-
 src/arm64/renesas/r8a779f0.dtsi               |   17 +-
 src/arm64/renesas/r8a779g0-white-hawk-cpu.dts |   13 +
 .../renesas/r8a779g0-white-hawk-cpu.dtsi      |  368 +--
 src/arm64/renesas/r8a779g0-white-hawk.dts     |   58 +-
 src/arm64/renesas/r8a779g0.dtsi               |  105 +-
 .../renesas/r8a779g2-white-hawk-single.dts    |   26 +
 src/arm64/renesas/r8a779g2.dtsi               |   12 +
 .../renesas/r8a779h0-gray-hawk-single.dts     |  230 ++
 src/arm64/renesas/r8a779h0.dtsi               |  664 +++++
 src/arm64/renesas/r9a07g043u.dtsi             |   81 +-
 .../r9a07g043u11-smarc-cru-csi-ov5645.dtso    |   21 +
 src/arm64/renesas/r9a07g044.dtsi              |   68 +-
 src/arm64/renesas/r9a07g054.dtsi              |   69 +-
 src/arm64/renesas/r9a08g045.dtsi              |   27 +-
 src/arm64/renesas/rzg2l-smarc.dtsi            |   14 +-
 src/arm64/renesas/rzg2lc-smarc.dtsi           |   14 +-
 src/arm64/renesas/rzg3s-smarc-som.dtsi        |    9 +
 src/arm64/renesas/rzg3s-smarc.dtsi            |   53 +
 src/arm64/renesas/ulcb-kf.dtsi                |   75 +-
 src/arm64/renesas/white-hawk-common.dtsi      |   65 +
 src/arm64/renesas/white-hawk-cpu-common.dtsi  |  375 +++
 ...k-csi-dsi.dtsi => white-hawk-csi-dsi.dtsi} |    2 +-
 ...ethernet.dtsi => white-hawk-ethernet.dtsi} |    2 +-
 src/arm64/rockchip/px30-ringneck-haikou.dts   |    1 +
 src/arm64/rockchip/px30-ringneck.dtsi         |    6 +
 src/arm64/rockchip/rk3328-rock-pi-e.dts       |    4 +-
 src/arm64/rockchip/rk3328.dtsi                |   11 +-
 src/arm64/rockchip/rk3399-gru-scarlet.dtsi    |    3 +-
 src/arm64/rockchip/rk3399-kobol-helios64.dts  |    5 +-
 src/arm64/rockchip/rk3399-orangepi.dts        |    2 +-
 src/arm64/rockchip/rk3399-pinebook-pro.dts    |    1 -
 src/arm64/rockchip/rk3399-puma-haikou.dts     |    5 +-
 src/arm64/rockchip/rk3399-puma.dtsi           |   53 +-
 src/arm64/rockchip/rk3399-rock-pi-4a.dts      |    2 +-
 src/arm64/rockchip/rk3399-rock-pi-4b.dts      |    2 +-
 src/arm64/rockchip/rk3399-rock-pi-4c.dts      |    2 +-
 src/arm64/rockchip/rk3399.dtsi                |   82 +-
 .../rockchip/rk3566-anbernic-rg-arc-d.dts     |   60 +
 .../rockchip/rk3566-anbernic-rg-arc-s.dts     |   19 +
 .../rockchip/rk3566-anbernic-rg-arc.dtsi      |  237 ++
 .../rockchip/rk3566-anbernic-rg353x.dtsi      |   74 +
 src/arm64/rockchip/rk3566-anbernic-rg503.dts  |   74 +
 src/arm64/rockchip/rk3566-anbernic-rgxx3.dtsi |   74 -
 src/arm64/rockchip/rk3566-lubancat-1.dts      |    1 -
 src/arm64/rockchip/rk3566-pinetab2-v0.1.dts   |   28 +
 src/arm64/rockchip/rk3566-pinetab2-v2.0.dts   |   48 +
 src/arm64/rockchip/rk3566-pinetab2.dtsi       |  943 ++++++
 .../rockchip/rk3566-powkiddy-rgb10max3.dts    |   87 +
 src/arm64/rockchip/rk3566-powkiddy-rgb30.dts  |   18 +
 src/arm64/rockchip/rk3566-powkiddy-rk2023.dts |   18 +
 .../rockchip/rk3566-powkiddy-rk2023.dtsi      |   18 +-
 src/arm64/rockchip/rk3568-bpi-r2-pro.dts      |    8 +-
 src/arm64/rockchip/rk3568-lubancat-2.dts      |    1 -
 src/arm64/rockchip/rk3568-qnap-ts433.dts      |   86 +
 src/arm64/rockchip/rk356x.dtsi                |    3 +-
 src/arm64/rockchip/rk3588-coolpi-cm5.dtsi     |    4 +-
 .../rockchip/rk3588-edgeble-neu6a-common.dtsi |  466 +++
 .../rockchip/rk3588-edgeble-neu6a-io.dts      |   10 +-
 .../rockchip/rk3588-edgeble-neu6a-io.dtsi     |  232 ++
 .../rockchip/rk3588-edgeble-neu6a-wifi.dtso   |   56 +
 src/arm64/rockchip/rk3588-edgeble-neu6a.dtsi  |   25 +-
 .../rockchip/rk3588-edgeble-neu6b-io.dts      |   76 +-
 src/arm64/rockchip/rk3588-edgeble-neu6b.dtsi  |  383 +--
 src/arm64/rockchip/rk3588-nanopc-t6.dts       |   31 +-
 src/arm64/rockchip/rk3588-orangepi-5-plus.dts |    4 +-
 src/arm64/rockchip/rk3588-quartzpro64.dts     |    2 +-
 src/arm64/rockchip/rk3588-rock-5b.dts         |    8 +-
 src/arm64/rockchip/rk3588-tiger-haikou.dts    |  266 ++
 src/arm64/rockchip/rk3588-tiger.dtsi          |  690 +++++
 src/arm64/rockchip/rk3588-toybrick-x0.dts     |  688 +++++
 .../rockchip/rk3588s-indiedroid-nova.dts      |    8 +
 src/arm64/rockchip/rk3588s-nanopi-r6c.dts     |   14 +
 src/arm64/rockchip/rk3588s-nanopi-r6s.dts     |  764 +++++
 src/arm64/rockchip/rk3588s-rock-5a.dts        |    1 -
 src/arm64/rockchip/rk3588s.dtsi               |   24 +-
 src/arm64/st/stm32mp251.dtsi                  |   12 +
 src/arm64/st/stm32mp255.dtsi                  |   17 +
 src/arm64/tesla/fsd.dtsi                      |    2 +
 src/arm64/ti/k3-am62-lp-sk.dts                |    4 +-
 src/arm64/ti/k3-am62-main.dtsi                |   30 +-
 src/arm64/ti/k3-am62-mcu.dtsi                 |    4 +-
 src/arm64/ti/k3-am62-phycore-som.dtsi         |    5 +-
 src/arm64/ti/k3-am62-thermal.dtsi             |    5 +-
 src/arm64/ti/k3-am62-verdin-dahlia.dtsi       |    1 -
 src/arm64/ti/k3-am62-verdin-dev.dtsi          |    1 -
 src/arm64/ti/k3-am62-verdin-mallow.dtsi       |   10 +
 src/arm64/ti/k3-am62-verdin-wifi.dtsi         |    1 -
 src/arm64/ti/k3-am62-verdin.dtsi              |   59 +-
 src/arm64/ti/k3-am62-wakeup.dtsi              |   38 +-
 src/arm64/ti/k3-am62.dtsi                     |    4 +-
 .../ti/k3-am625-beagleplay-csi2-ov5640.dtso   |    4 +-
 .../k3-am625-beagleplay-csi2-tevi-ov5640.dtso |    4 +-
 src/arm64/ti/k3-am625-beagleplay.dts          |   54 +-
 src/arm64/ti/k3-am625-phyboard-lyra-rdk.dts   |    6 +-
 src/arm64/ti/k3-am625-sk.dts                  |    4 +-
 src/arm64/ti/k3-am625.dtsi                    |    4 +-
 src/arm64/ti/k3-am62a-main.dtsi               |   80 +-
 src/arm64/ti/k3-am62a-mcu.dtsi                |    4 +-
 src/arm64/ti/k3-am62a-thermal.dtsi            |    5 +-
 src/arm64/ti/k3-am62a-wakeup.dtsi             |    4 +-
 src/arm64/ti/k3-am62a.dtsi                    |    4 +-
 src/arm64/ti/k3-am62a7-sk.dts                 |  123 +-
 src/arm64/ti/k3-am62a7.dtsi                   |    4 +-
 src/arm64/ti/k3-am62p-main.dtsi               |  154 +-
 src/arm64/ti/k3-am62p-mcu.dtsi                |    6 +-
 src/arm64/ti/k3-am62p-thermal.dtsi            |    5 +-
 src/arm64/ti/k3-am62p-wakeup.dtsi             |    5 +-
 src/arm64/ti/k3-am62p.dtsi                    |    6 +-
 src/arm64/ti/k3-am62p5-sk.dts                 |   11 +-
 src/arm64/ti/k3-am62p5.dtsi                   |    4 +-
 .../ti/k3-am62x-phyboard-lyra-gpio-fan.dtso   |   50 +
 src/arm64/ti/k3-am62x-sk-common.dtsi          |    8 +-
 src/arm64/ti/k3-am62x-sk-csi2-imx219.dtso     |    4 +-
 src/arm64/ti/k3-am62x-sk-csi2-ov5640.dtso     |    4 +-
 .../ti/k3-am62x-sk-csi2-tevi-ov5640.dtso      |    4 +-
 src/arm64/ti/k3-am62x-sk-hdmi-audio.dtso      |    4 +-
 src/arm64/ti/k3-am64-main.dtsi                |   69 +-
 src/arm64/ti/k3-am64-mcu.dtsi                 |    4 +-
 src/arm64/ti/k3-am64-phycore-som.dtsi         |   13 +-
 src/arm64/ti/k3-am64-thermal.dtsi             |    5 +-
 src/arm64/ti/k3-am64.dtsi                     |    4 +-
 .../ti/k3-am642-evm-icssg1-dualemac.dtso      |   79 +
 src/arm64/ti/k3-am642-evm.dts                 |  119 +-
 .../ti/k3-am642-hummingboard-t-pcie.dtso      |   45 +
 .../ti/k3-am642-hummingboard-t-usb3.dtso      |   44 +
 src/arm64/ti/k3-am642-hummingboard-t.dts      |  292 ++
 .../ti/k3-am642-phyboard-electra-rdk.dts      |   30 +-
 src/arm64/ti/k3-am642-sk.dts                  |   14 +-
 src/arm64/ti/k3-am642-sr-som.dtsi             |  594 ++++
 src/arm64/ti/k3-am642-tqma64xxl-mbax4xxl.dts  |    1 -
 src/arm64/ti/k3-am642.dtsi                    |    4 +-
 .../ti/k3-am65-iot2050-arduino-connector.dtsi |  768 +++++
 src/arm64/ti/k3-am65-iot2050-common-pg1.dtsi  |    7 +-
 src/arm64/ti/k3-am65-iot2050-common-pg2.dtsi  |   27 +-
 src/arm64/ti/k3-am65-iot2050-common.dtsi      |  887 +-----
 src/arm64/ti/k3-am65-iot2050-dp.dtsi          |   98 +
 src/arm64/ti/k3-am65-iot2050-usb3.dtsi        |   27 +
 src/arm64/ti/k3-am65-main.dtsi                |   44 +-
 src/arm64/ti/k3-am65-mcu.dtsi                 |    4 +-
 src/arm64/ti/k3-am65-wakeup.dtsi              |    4 +-
 src/arm64/ti/k3-am65.dtsi                     |    4 +-
 src/arm64/ti/k3-am652.dtsi                    |    4 +-
 .../ti/k3-am6528-iot2050-basic-common.dtsi    |    8 +-
 src/arm64/ti/k3-am6528-iot2050-basic-pg2.dts  |    4 +-
 src/arm64/ti/k3-am6528-iot2050-basic.dts      |    7 +-
 ...am654-base-board-rocktech-rk101-panel.dtso |    4 +-
 src/arm64/ti/k3-am654-base-board.dts          |    8 +-
 src/arm64/ti/k3-am654-icssg2.dtso             |    4 +-
 src/arm64/ti/k3-am654-idk.dtso                |    4 +-
 src/arm64/ti/k3-am654-industrial-thermal.dtsi |    5 +-
 src/arm64/ti/k3-am654-pcie-usb2.dtso          |   59 +
 src/arm64/ti/k3-am654-pcie-usb3.dtso          |   61 +
 src/arm64/ti/k3-am654.dtsi                    |    4 +-
 .../ti/k3-am6548-iot2050-advanced-common.dtsi |    2 +-
 .../ti/k3-am6548-iot2050-advanced-m2.dts      |   22 +-
 .../ti/k3-am6548-iot2050-advanced-pg2.dts     |   12 +-
 .../ti/k3-am6548-iot2050-advanced-sm.dts      |  189 ++
 src/arm64/ti/k3-am6548-iot2050-advanced.dts   |    3 +-
 src/arm64/ti/k3-am68-sk-base-board.dts        |   54 +-
 src/arm64/ti/k3-am68-sk-som.dtsi              |   20 +-
 src/arm64/ti/k3-am69-sk.dts                   |  253 +-
 src/arm64/ti/k3-j7200-common-proc-board.dts   |  109 +-
 .../ti/k3-j7200-evm-quad-port-eth-exp.dtso    |    4 +-
 src/arm64/ti/k3-j7200-main.dtsi               |  315 +-
 src/arm64/ti/k3-j7200-mcu-wakeup.dtsi         |   57 +-
 src/arm64/ti/k3-j7200-som-p0.dtsi             |   47 +-
 src/arm64/ti/k3-j7200-thermal.dtsi            |    5 +-
 src/arm64/ti/k3-j7200.dtsi                    |    4 +-
 src/arm64/ti/k3-j721e-beagleboneai64.dts      |   26 +-
 src/arm64/ti/k3-j721e-common-proc-board.dts   |    4 +-
 src/arm64/ti/k3-j721e-evm-gesi-exp-board.dtso |    4 +-
 src/arm64/ti/k3-j721e-evm-pcie0-ep.dtso       |    4 +-
 .../ti/k3-j721e-evm-quad-port-eth-exp.dtso    |    4 +-
 src/arm64/ti/k3-j721e-main.dtsi               |  149 +-
 src/arm64/ti/k3-j721e-mcu-wakeup.dtsi         |    8 +-
 .../ti/k3-j721e-sk-csi2-dual-imx219.dtso      |  165 ++
 src/arm64/ti/k3-j721e-sk.dts                  |   45 +-
 src/arm64/ti/k3-j721e-som-p0.dtsi             |   22 +-
 src/arm64/ti/k3-j721e-thermal.dtsi            |    5 +-
 src/arm64/ti/k3-j721e.dtsi                    |    4 +-
 src/arm64/ti/k3-j721s2-common-proc-board.dts  |   31 +-
 .../ti/k3-j721s2-evm-gesi-exp-board.dtso      |    4 +-
 src/arm64/ti/k3-j721s2-evm-pcie1-ep.dtso      |    4 +-
 src/arm64/ti/k3-j721s2-main.dtsi              |  143 +-
 src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi        |    6 +-
 src/arm64/ti/k3-j721s2-som-p0.dtsi            |   20 +-
 src/arm64/ti/k3-j721s2-thermal.dtsi           |    5 +-
 src/arm64/ti/k3-j721s2.dtsi                   |    4 +-
 src/arm64/ti/k3-j722s-evm.dts                 |  383 +++
 src/arm64/ti/k3-j722s.dtsi                    |   89 +
 src/arm64/ti/k3-j784s4-evm.dts                |   32 +-
 src/arm64/ti/k3-j784s4-main.dtsi              |  215 +-
 src/arm64/ti/k3-j784s4-mcu-wakeup.dtsi        |    6 +-
 src/arm64/ti/k3-j784s4-thermal.dtsi           |    5 +-
 src/arm64/ti/k3-j784s4.dtsi                   |    6 +-
 src/arm64/ti/k3-pinctrl.h                     |    7 +-
 src/arm64/ti/k3-serdes.h                      |    4 +-
 src/arm64/xilinx/zynqmp-clk-ccf.dtsi          |   16 +-
 src/arm64/xilinx/zynqmp-sck-kv-g-revA.dtso    |   36 +-
 src/arm64/xilinx/zynqmp-sck-kv-g-revB.dtso    |   37 +-
 src/arm64/xilinx/zynqmp-zc1751-xm015-dc1.dts  |    2 +-
 src/arm64/xilinx/zynqmp-zc1751-xm016-dc2.dts  |    2 +-
 src/arm64/xilinx/zynqmp-zc1751-xm019-dc5.dts  |    4 +-
 src/arm64/xilinx/zynqmp-zcu100-revC.dts       |    2 +-
 src/arm64/xilinx/zynqmp-zcu102-revA.dts       |    6 +-
 src/arm64/xilinx/zynqmp-zcu104-revA.dts       |    2 +-
 src/arm64/xilinx/zynqmp-zcu104-revC.dts       |    2 +-
 src/arm64/xilinx/zynqmp-zcu106-revA.dts       |    6 +-
 src/arm64/xilinx/zynqmp-zcu111-revA.dts       |    4 +-
 src/arm64/xilinx/zynqmp-zcu1275-revA.dts      |    2 +-
 src/arm64/xilinx/zynqmp.dtsi                  |   85 +-
 src/loongarch/loongson-2k1000.dtsi            |    7 +
 src/loongarch/loongson-2k2000-ref.dts         |   33 +
 src/loongarch/loongson-2k2000.dtsi            |   24 +-
 src/mips/mobileye/eyeq5-epm5.dts              |   23 +
 src/mips/mobileye/eyeq5-fixed-clocks.dtsi     |  292 ++
 src/mips/mobileye/eyeq5.dtsi                  |  124 +
 src/mips/ralink/mt7621.dtsi                   |   47 +
 src/powerpc/akebono.dts                       |    6 +-
 src/riscv/microchip/mpfs.dtsi                 |    6 +-
 src/riscv/renesas/r9a07g043f.dtsi             |    8 +-
 src/riscv/sophgo/sg2042.dtsi                  |    9 +
 .../starfive/jh7100-beaglev-starlight.dts     |   11 +
 src/riscv/starfive/jh7100-common.dtsi         |  108 +
 .../jh7100-starfive-visionfive-v1.dts         |   22 +-
 src/riscv/starfive/jh7100.dtsi                |   49 +
 .../jh7110-starfive-visionfive-2.dtsi         |   71 +
 src/riscv/starfive/jh7110.dtsi                |   76 +
 1276 files changed, 55515 insertions(+), 12702 deletions(-)
 delete mode 100644 Bindings/arm/marvell/armada-38x.txt
 create mode 100644 Bindings/arm/marvell/armada-38x.yaml
 delete mode 100644 Bindings/arm/mediatek/mediatek,hifsys.txt
 delete mode 100644 Bindings/arm/mediatek/mediatek,pciesys.txt
 delete mode 100644 Bindings/arm/mediatek/mediatek,ssusbsys.txt
 delete mode 100644 Bindings/arm/msm/qcom,saw2.txt
 delete mode 100644 Bindings/ata/ahci-mtk.txt
 delete mode 100644 Bindings/ata/atmel-at91_cf.txt
 create mode 100644 Bindings/ata/mediatek,mtk-ahci.yaml
 create mode 100644 Bindings/auxdisplay/gpio-7-segment.yaml
 create mode 100644 Bindings/auxdisplay/maxim,max6959.yaml
 delete mode 100644 Bindings/bus/imx-weim.txt
 create mode 100644 Bindings/clock/mediatek,mt2701-hifsys.yaml
 create mode 100644 Bindings/clock/mediatek,mt7622-pciesys.yaml
 create mode 100644 Bindings/clock/mediatek,mt7622-ssusbsys.yaml
 create mode 100644 Bindings/clock/mobileye,eyeq5-clk.yaml
 delete mode 100644 Bindings/clock/qcom,sc7180-mss.yaml
 delete mode 100644 Bindings/clock/qcom,sm8650-dispcc.yaml
 create mode 100644 Bindings/display/atmel/atmel,hlcdc-display-controller.yaml
 delete mode 100644 Bindings/display/atmel/hlcdc-dc.txt
 create mode 100644 Bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
 create mode 100644 Bindings/display/imx/fsl,imx8mp-hdmi-pvi.yaml
 create mode 100644 Bindings/display/msm/qcom,x1e80100-mdss.yaml
 create mode 100644 Bindings/display/panel/boe,th101mb31ig002-28a.yaml
 create mode 100644 Bindings/display/panel/himax,hx83112a.yaml
 create mode 100644 Bindings/display/panel/novatek,nt36672e.yaml
 create mode 100644 Bindings/display/renesas,rzg2l-du.yaml
 create mode 100644 Bindings/display/solomon,ssd133x.yaml
 create mode 100644 Bindings/dma/marvell,mmp-dma.yaml
 create mode 100644 Bindings/dma/mediatek,mt7622-hsdma.yaml
 delete mode 100644 Bindings/dma/mmp-dma.txt
 delete mode 100644 Bindings/dma/mtk-hsdma.txt
 delete mode 100644 Bindings/fpga/fpga-region.txt
 create mode 100644 Bindings/fpga/fpga-region.yaml
 create mode 100644 Bindings/gpio/aspeed,ast2400-gpio.yaml
 delete mode 100644 Bindings/gpio/gpio-aspeed.txt
 delete mode 100644 Bindings/gpio/gpio-nmk.txt
 create mode 100644 Bindings/gpio/st,nomadik-gpio.yaml
 rename Bindings/gpu/{img,powervr.yaml => img,powervr-rogue.yaml} (91%)
 create mode 100644 Bindings/gpu/img,powervr-sgx.yaml
 create mode 100644 Bindings/hwmon/adi,ltc4282.yaml
 create mode 100644 Bindings/hwmon/amphenol,chipcap2.yaml
 create mode 100644 Bindings/hwmon/aspeed,g6-pwm-tach.yaml
 create mode 100644 Bindings/hwmon/fan-common.yaml
 create mode 100644 Bindings/hwmon/hwmon-common.yaml
 delete mode 100644 Bindings/i2c/i2c.txt
 create mode 100644 Bindings/iio/adc/microchip,pac1934.yaml
 create mode 100644 Bindings/iio/adc/ti,ads1298.yaml
 create mode 100644 Bindings/iio/frequency/adi,admfm2000.yaml
 create mode 100644 Bindings/iio/magnetometer/voltafield,af8133j.yaml
 delete mode 100644 Bindings/input/atmel,captouch.txt
 create mode 100644 Bindings/input/atmel,captouch.yaml
 delete mode 100644 Bindings/input/da9062-onkey.txt
 create mode 100644 Bindings/input/dlg,da9062-onkey.yaml
 create mode 100644 Bindings/input/samsung,s3c6410-keypad.yaml
 delete mode 100644 Bindings/input/samsung-keypad.txt
 create mode 100644 Bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
 create mode 100644 Bindings/input/touchscreen/goodix,gt9916.yaml
 delete mode 100644 Bindings/input/touchscreen/imx6ul_tsc.txt
 create mode 100644 Bindings/interconnect/qcom,sm7150-rpmh.yaml
 delete mode 100644 Bindings/interrupt-controller/atmel,aic.txt
 create mode 100644 Bindings/interrupt-controller/atmel,aic.yaml
 create mode 100644 Bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
 delete mode 100644 Bindings/interrupt-controller/mediatek,sysirq.txt
 create mode 100644 Bindings/interrupt-controller/starfive,jh8100-intc.yaml
 create mode 100644 Bindings/leds/backlight/kinetic,ktd2801.yaml
 create mode 100644 Bindings/leds/onnn,ncp5623.yaml
 create mode 100644 Bindings/media/st,stm32mp25-video-codec.yaml
 create mode 100644 Bindings/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml
 create mode 100644 Bindings/memory-controllers/fsl/fsl,imx-weim.yaml
 create mode 100644 Bindings/mfd/atmel,hlcdc.yaml
 create mode 100644 Bindings/mfd/atmel,sama5d2-flexcom.yaml
 delete mode 100644 Bindings/mfd/atmel-flexcom.txt
 delete mode 100644 Bindings/mfd/atmel-hlcdc.txt
 delete mode 100644 Bindings/mfd/da9062.txt
 create mode 100644 Bindings/mips/mobileye.yaml
 delete mode 100644 Bindings/misc/xlnx,sd-fec.txt
 create mode 100644 Bindings/misc/xlnx,sd-fec.yaml
 delete mode 100644 Bindings/mmc/hi3798cv200-dw-mshc.txt
 create mode 100644 Bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
 create mode 100644 Bindings/mtd/partitions/linux,ubi.yaml
 create mode 100644 Bindings/mtd/partitions/ubi-volume.yaml
 delete mode 100644 Bindings/net/dsa/ar9331.txt
 create mode 100644 Bindings/net/dsa/qca,ar9331.yaml
 create mode 100644 Bindings/net/ethernet-phy-package.yaml
 create mode 100644 Bindings/net/qca,qca808x.yaml
 create mode 100644 Bindings/net/qcom,qca807x.yaml
 create mode 100644 Bindings/nvmem/nvmem-provider.yaml
 delete mode 100644 Bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Bindings/nvmem/xlnx,zynqmp-nvmem.yaml
 create mode 100644 Bindings/pci/qcom,pcie-common.yaml
 create mode 100644 Bindings/pci/qcom,pcie-sa8775p.yaml
 create mode 100644 Bindings/pci/qcom,pcie-sc7280.yaml
 create mode 100644 Bindings/pci/qcom,pcie-sc8180x.yaml
 create mode 100644 Bindings/pci/qcom,pcie-sc8280xp.yaml
 create mode 100644 Bindings/pci/qcom,pcie-sm8150.yaml
 create mode 100644 Bindings/pci/qcom,pcie-sm8250.yaml
 create mode 100644 Bindings/pci/qcom,pcie-sm8350.yaml
 create mode 100644 Bindings/pci/qcom,pcie-sm8450.yaml
 create mode 100644 Bindings/pci/qcom,pcie-sm8550.yaml
 create mode 100644 Bindings/pci/qcom,pcie-x1e80100.yaml
 create mode 100644 Bindings/perf/arm,coresight-pmu.yaml
 create mode 100644 Bindings/perf/starfive,jh8100-starlink-pmu.yaml
 create mode 100644 Bindings/phy/mediatek,mt8365-csi-rx.yaml
 create mode 100644 Bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml
 create mode 100644 Bindings/phy/rockchip,rk3588-hdptx-phy.yaml
 create mode 100644 Bindings/pinctrl/awinic,aw9523-pinctrl.yaml
 delete mode 100644 Bindings/pinctrl/fsl,imx6ul-pinctrl.txt
 create mode 100644 Bindings/pinctrl/fsl,imx6ul-pinctrl.yaml
 create mode 100644 Bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
 rename Bindings/pinctrl/{xlnx,zynq-pinctrl.yaml => xlnx,pinctrl-zynq.yaml} (98%)
 create mode 100644 Bindings/pwm/atmel,hlcdc-pwm.yaml
 delete mode 100644 Bindings/pwm/atmel-hlcdc-pwm.txt
 create mode 100644 Bindings/pwm/marvell,pxa-pwm.yaml
 create mode 100644 Bindings/pwm/opencores,pwm.yaml
 delete mode 100644 Bindings/pwm/pxa-pwm.txt
 create mode 100644 Bindings/regulator/infineon,ir38060.yaml
 delete mode 100644 Bindings/regulator/mcp16502-regulator.txt
 create mode 100644 Bindings/regulator/microchip,mcp16502.yaml
 create mode 100644 Bindings/regulator/ti,tps65132.yaml
 delete mode 100644 Bindings/regulator/tps65132-regulator.txt
 create mode 100644 Bindings/reset/mobileye,eyeq5-reset.yaml
 create mode 100644 Bindings/reset/sophgo,sg2042-reset.yaml
 delete mode 100644 Bindings/rtc/abracon,abx80x.txt
 create mode 100644 Bindings/rtc/abracon,abx80x.yaml
 create mode 100644 Bindings/rtc/mediatek,mt2712-rtc.yaml
 create mode 100644 Bindings/rtc/mediatek,mt7622-rtc.yaml
 delete mode 100644 Bindings/rtc/rtc-mt2712.txt
 delete mode 100644 Bindings/rtc/rtc-mt7622.txt
 create mode 100644 Bindings/serial/st,asc.yaml
 delete mode 100644 Bindings/serial/st-asc.txt
 create mode 100644 Bindings/soc/imx/fsl,imx-anatop.yaml
 create mode 100644 Bindings/soc/qcom/qcom,pbs.yaml
 rename Bindings/soc/qcom/{qcom,spm.yaml => qcom,saw2.yaml} (53%)
 create mode 100644 Bindings/soc/renesas/renesas-soc.yaml
 create mode 100644 Bindings/sound/atmel,asoc-wm8904.yaml
 create mode 100644 Bindings/sound/atmel,sam9x5-wm8731-audio.yaml
 delete mode 100644 Bindings/sound/atmel-sam9x5-wm8731-audio.txt
 delete mode 100644 Bindings/sound/atmel-wm8904.txt
 delete mode 100644 Bindings/sound/fsl,asrc.txt
 create mode 100644 Bindings/sound/fsl,imx-asrc.yaml
 create mode 100644 Bindings/sound/qcom,q6usb.yaml
 create mode 100644 Bindings/sound/qcom,wcd939x-sdw.yaml
 create mode 100644 Bindings/sound/qcom,wcd939x.yaml
 create mode 100644 Bindings/sound/qcom,wcd93xx-common.yaml
 create mode 100644 Bindings/sound/realtek,rt1015.yaml
 delete mode 100644 Bindings/sound/rt1015.txt
 delete mode 100644 Bindings/thermal/da9062-thermal.txt
 create mode 100644 Bindings/thermal/dlg,da9062-thermal.yaml
 delete mode 100644 Bindings/timer/mediatek,mtk-timer.txt
 create mode 100644 Bindings/timer/mediatek,timer.yaml
 create mode 100644 Bindings/timer/ralink,cevt-systick.yaml
 create mode 100644 Bindings/usb/hisilicon,hi3798mv200-dwc3.yaml
 create mode 100644 Bindings/usb/ite,it5205.yaml
 create mode 100644 Bindings/usb/ti,usb8020b.yaml
 create mode 100644 Bindings/usb/usb-switch.yaml
 create mode 100644 Bindings/w1/w1-uart.yaml
 delete mode 100644 Bindings/watchdog/brcm,bcm2835-pm-wdog.txt
 create mode 100644 Bindings/watchdog/sprd,sp9860-wdt.yaml
 delete mode 100644 Bindings/watchdog/sprd-wdt.txt
 create mode 100644 include/dt-bindings/clock/mobileye,eyeq5-clk.h
 create mode 100644 include/dt-bindings/clock/qcom,x1e80100-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,x1e80100-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,x1e80100-gpucc.h
 create mode 100644 include/dt-bindings/clock/qcom,x1e80100-tcsr.h
 create mode 100644 include/dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8909.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
 create mode 100644 include/dt-bindings/power/renesas,r8a779h0-sysc.h
 create mode 100644 include/dt-bindings/reset/qcom,x1e80100-gpucc.h
 create mode 100644 include/dt-bindings/reset/sophgo,sg2042-reset.h
 create mode 100644 src/arm/microchip/at91-sama7g54_curiosity.dts
 create mode 100644 src/arm/nvidia/tegra30-lg-p880.dts
 create mode 100644 src/arm/nvidia/tegra30-lg-p895.dts
 create mode 100644 src/arm/nvidia/tegra30-lg-x3.dtsi
 create mode 100644 src/arm/nxp/imx/imx53-qsb-hdmi.dtso
 create mode 100644 src/arm/nxp/imx/imx6dl-sielaff.dts
 create mode 100644 src/arm/nxp/imx/imx6q-apalis-eval-v1.2.dts
 create mode 100644 src/arm/nxp/imx/imx6q-apalis-eval.dtsi
 create mode 100644 src/arm/qcom/qcom-msm8226-samsung-matisse-common.dtsi
 create mode 100644 src/arm/qcom/qcom-msm8926-samsung-matisselte.dts
 create mode 100644 src/arm/qcom/qcom-msm8960-pins.dtsi
 create mode 100644 src/arm/st/stm32f769-disco-mb1166-reva09.dts
 create mode 100644 src/arm/st/stm32f769.dtsi
 create mode 100644 src/arm64/allwinner/sun50i-h618-longan-module-3h.dtsi
 create mode 100644 src/arm64/allwinner/sun50i-h618-longanpi-3h.dts
 create mode 100644 src/arm64/allwinner/sun50i-h64-remix-mini-pc.dts
 create mode 100644 src/arm64/amlogic/meson-g12a-fbx8am-brcm.dtso
 create mode 100644 src/arm64/amlogic/meson-g12a-fbx8am-realtek.dtso
 create mode 100644 src/arm64/amlogic/meson-g12a-fbx8am.dts
 create mode 100644 src/arm64/freescale/imx8-apalis-eval-v1.1.dtsi
 create mode 100644 src/arm64/freescale/imx8-apalis-eval-v1.2.dtsi
 create mode 100644 src/arm64/freescale/imx8-ss-gpu0.dtsi
 create mode 100644 src/arm64/freescale/imx8dxp-tqma8xdp-mba8xx.dts
 create mode 100644 src/arm64/freescale/imx8dxp-tqma8xdp.dtsi
 create mode 100644 src/arm64/freescale/imx8dxp.dtsi
 create mode 100644 src/arm64/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso
 create mode 100644 src/arm64/freescale/imx8qm-apalis-eval-v1.2.dts
 create mode 100644 src/arm64/freescale/imx8qm-apalis-v1.1-eval-v1.2.dts
 create mode 100644 src/arm64/freescale/imx8qxp-tqma8xqp-mba8xx.dts
 create mode 100644 src/arm64/freescale/imx8qxp-tqma8xqp.dtsi
 create mode 100644 src/arm64/freescale/imx93-phyboard-segin.dts
 create mode 100644 src/arm64/freescale/imx93-phycore-som.dtsi
 create mode 100644 src/arm64/freescale/imx93-var-som-symphony.dts
 create mode 100644 src/arm64/freescale/imx93-var-som.dtsi
 create mode 100644 src/arm64/freescale/mba8xx.dtsi
 create mode 100644 src/arm64/freescale/tqma8xx.dtsi
 create mode 100644 src/arm64/mediatek/mt7981b-xiaomi-ax3000t.dts
 create mode 100644 src/arm64/mediatek/mt7981b.dtsi
 create mode 100644 src/arm64/mediatek/mt7986a-acelink-ew-7886cax.dts
 create mode 100644 src/arm64/mediatek/mt7988a-bananapi-bpi-r4.dts
 create mode 100644 src/arm64/mediatek/mt7988a.dtsi
 create mode 100644 src/arm64/mediatek/mt8186-corsola-krabby.dtsi
 create mode 100644 src/arm64/mediatek/mt8186-corsola-magneton-sku393216.dts
 create mode 100644 src/arm64/mediatek/mt8186-corsola-magneton-sku393217.dts
 create mode 100644 src/arm64/mediatek/mt8186-corsola-magneton-sku393218.dts
 create mode 100644 src/arm64/mediatek/mt8186-corsola-rusty-sku196608.dts
 create mode 100644 src/arm64/mediatek/mt8186-corsola-steelix-sku131072.dts
 create mode 100644 src/arm64/mediatek/mt8186-corsola-steelix-sku131073.dts
 create mode 100644 src/arm64/mediatek/mt8186-corsola-steelix.dtsi
 create mode 100644 src/arm64/mediatek/mt8186-corsola-tentacool-sku327681.dts
 create mode 100644 src/arm64/mediatek/mt8186-corsola-tentacool-sku327683.dts
 create mode 100644 src/arm64/mediatek/mt8186-corsola-tentacruel-sku262144.dts
 create mode 100644 src/arm64/mediatek/mt8186-corsola-tentacruel-sku262148.dts
 create mode 100644 src/arm64/mediatek/mt8186-corsola.dtsi
 create mode 100644 src/arm64/mediatek/mt8395-radxa-nio-12l.dts
 delete mode 100644 src/arm64/nvidia/tegra234-p3767-0000.dtsi
 delete mode 100644 src/arm64/nvidia/tegra234-p3767-0005.dtsi
 create mode 100644 src/arm64/qcom/msm8216-samsung-fortuna3g.dts
 create mode 100644 src/arm64/qcom/msm8916-samsung-fortuna-common.dtsi
 create mode 100644 src/arm64/qcom/msm8916-samsung-gprimeltecan.dts
 create mode 100644 src/arm64/qcom/msm8916-samsung-grandprimelte.dts
 create mode 100644 src/arm64/qcom/msm8916-samsung-rossa-common.dtsi
 create mode 100644 src/arm64/qcom/msm8916-samsung-rossa.dts
 rename src/arm64/qcom/{pm2250.dtsi => pm4125.dtsi} (56%)
 create mode 100644 src/arm64/qcom/sdm450.dtsi
 create mode 100644 src/arm64/qcom/sm7125-xiaomi-curtana.dts
 create mode 100644 src/arm64/qcom/sm8550-hdk.dts
 create mode 100644 src/arm64/renesas/r8a779g0-white-hawk-cpu.dts
 create mode 100644 src/arm64/renesas/r8a779g2-white-hawk-single.dts
 create mode 100644 src/arm64/renesas/r8a779g2.dtsi
 create mode 100644 src/arm64/renesas/r8a779h0-gray-hawk-single.dts
 create mode 100644 src/arm64/renesas/r8a779h0.dtsi
 create mode 100644 src/arm64/renesas/r9a07g043u11-smarc-cru-csi-ov5645.dtso
 create mode 100644 src/arm64/renesas/white-hawk-common.dtsi
 create mode 100644 src/arm64/renesas/white-hawk-cpu-common.dtsi
 rename src/arm64/renesas/{r8a779g0-white-hawk-csi-dsi.dtsi => white-hawk-csi-dsi.dtsi} (97%)
 rename src/arm64/renesas/{r8a779g0-white-hawk-ethernet.dtsi => white-hawk-ethernet.dtsi} (76%)
 create mode 100644 src/arm64/rockchip/rk3566-anbernic-rg-arc-d.dts
 create mode 100644 src/arm64/rockchip/rk3566-anbernic-rg-arc-s.dts
 create mode 100644 src/arm64/rockchip/rk3566-anbernic-rg-arc.dtsi
 create mode 100644 src/arm64/rockchip/rk3566-pinetab2-v0.1.dts
 create mode 100644 src/arm64/rockchip/rk3566-pinetab2-v2.0.dts
 create mode 100644 src/arm64/rockchip/rk3566-pinetab2.dtsi
 create mode 100644 src/arm64/rockchip/rk3566-powkiddy-rgb10max3.dts
 create mode 100644 src/arm64/rockchip/rk3568-qnap-ts433.dts
 create mode 100644 src/arm64/rockchip/rk3588-edgeble-neu6a-common.dtsi
 create mode 100644 src/arm64/rockchip/rk3588-edgeble-neu6a-io.dtsi
 create mode 100644 src/arm64/rockchip/rk3588-edgeble-neu6a-wifi.dtso
 create mode 100644 src/arm64/rockchip/rk3588-tiger-haikou.dts
 create mode 100644 src/arm64/rockchip/rk3588-tiger.dtsi
 create mode 100644 src/arm64/rockchip/rk3588-toybrick-x0.dts
 create mode 100644 src/arm64/rockchip/rk3588s-nanopi-r6c.dts
 create mode 100644 src/arm64/rockchip/rk3588s-nanopi-r6s.dts
 create mode 100644 src/arm64/ti/k3-am62x-phyboard-lyra-gpio-fan.dtso
 create mode 100644 src/arm64/ti/k3-am642-evm-icssg1-dualemac.dtso
 create mode 100644 src/arm64/ti/k3-am642-hummingboard-t-pcie.dtso
 create mode 100644 src/arm64/ti/k3-am642-hummingboard-t-usb3.dtso
 create mode 100644 src/arm64/ti/k3-am642-hummingboard-t.dts
 create mode 100644 src/arm64/ti/k3-am642-sr-som.dtsi
 create mode 100644 src/arm64/ti/k3-am65-iot2050-arduino-connector.dtsi
 create mode 100644 src/arm64/ti/k3-am65-iot2050-dp.dtsi
 create mode 100644 src/arm64/ti/k3-am65-iot2050-usb3.dtsi
 create mode 100644 src/arm64/ti/k3-am654-pcie-usb2.dtso
 create mode 100644 src/arm64/ti/k3-am654-pcie-usb3.dtso
 create mode 100644 src/arm64/ti/k3-am6548-iot2050-advanced-sm.dts
 create mode 100644 src/arm64/ti/k3-j721e-sk-csi2-dual-imx219.dtso
 create mode 100644 src/arm64/ti/k3-j722s-evm.dts
 create mode 100644 src/arm64/ti/k3-j722s.dtsi
 create mode 100644 src/mips/mobileye/eyeq5-epm5.dts
 create mode 100644 src/mips/mobileye/eyeq5-fixed-clocks.dtsi
 create mode 100644 src/mips/mobileye/eyeq5.dtsi


