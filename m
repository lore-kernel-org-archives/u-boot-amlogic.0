Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24222C3DA5D
	for <webhook@archiver.kernel.org>; Mon, 22 Jul 2024 10:07:54 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web11.1937.1721328560878439540
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Jul 2024 11:49:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=eQSfL7Ra;
 spf=pass (domain: konsulko.com, ip: 209.85.210.48, mailfrom: trini@konsulko.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70361745053so520158a34.0
        for <u-boot-amlogic@groups.io>; Thu, 18 Jul 2024 11:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1721328560; x=1721933360; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LyxfK/L0uOajW2ouDOo9Iiow/0Cd9eqA3oKMR68dNeg=;
        b=eQSfL7RavKF6VTxHFB76Jsv1aCNlGd2XyYyL6cvOEwlPzuEaukmjfy+cCl8jPNYXba
         dQKGdm2D1t9m9KybgurfjRihF8Ofzw8O/j0AHPejLlO+8O+02H33qeJ+qKOizuFNK9dV
         Z5E6+XYZUrnRBOvmUntUevPgCixbjUF54douA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721328560; x=1721933360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyxfK/L0uOajW2ouDOo9Iiow/0Cd9eqA3oKMR68dNeg=;
        b=RaQywRFJlo0A2pgiWSnumOUtzllxPpwGjCea7kzjU5e2kzg9z+gJyGjRekaD3BI1De
         g813n2vmS62+cq/CMnrg1ir5sVM9pMWu0fU0LyT4s9l3MnajM6JUbvE/UTj8kUewVxAb
         C0sZSWxGKvQ6oWFOemPLCDH3kqVNbJcmTNxa7mYA/zPT6pG8vnSAtDSafYNddWD9Xoyy
         uZagKc3drL41TIJt1BhPDu4ouSWQDfO+5fX2Q7Jv/AhPykmpGs9MKh+YQKX/+zmHpNS1
         EEuJ2//hP+XoZEhgUP6UeBiWj0xlxSyVYKzFvedzmBzHUrEPr5goFrZDMiu7W3+/DV8D
         TsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCI4neAP4lor+BhnXYtRcRywbBcM7mTz5E+Ur+XVDG1YIgdbtDbYiW42bEkmVVPfcqLNvrs5T7oKr7c+979DrwmFDxVrKHcck=
X-Gm-Message-State: AOJu0YwA2Z0YfEX98tKAoUtZFSx28MRlAZFC3ef976GAmMxLDtQoYCgX
	mzKCwP3HucK9squ0/jg+VdBB65rZkgFz2j514Gcg1qKmn3YcAIutjiQXAEvkjSE=
X-Google-Smtp-Source: AGHT+IFsCWkXYsKKEjvGunt9iPUrg40TxmO2U7ViDfx3bNKY825g687YJu2TT/mL376ROAayG5fSaA==
X-Received: by 2002:a05:6830:2b07:b0:703:6c9d:cb81 with SMTP id 46e09a7af769-708ea066710mr1653401a34.3.1721328559217;
        Thu, 18 Jul 2024 11:49:19 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net (fixed-189-203-103-45.totalplay.net. [189.203.103.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708e78de157sm532557a34.62.2024.07.18.11.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 11:49:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "Cogent Embedded, Inc." <source@cogentembedded.com>,
	"Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
	Adam Ford <aford173@gmail.com>,
	Akash Gajjar <gajjar04akash@gmail.com>,
	Alexandre Vicenzi <linux@alxd.me>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Andrew Davis <afd@ti.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Banglang Huang <banglang.huang@foxmail.com>,
	Ben Schneider <ben@bens.haus>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Bryan Brattlof <bb@ti.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Christopher Obbard <chris.obbard@collabora.com>,
	Dave Purdy <david.c.purdy@gmail.com>,
	David Bauer <mail@david-bauer.net>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Evgeni Dobrev <evgeni@studio-punkt.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Fabio Estevm <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Hai Pham <hai.pham.ud@renesas.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Jason Cooper <u-boot@lakedaemon.net>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Clark <inindev@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jonathan Humphreys <j-humphreys@ti.com>,
	Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
	Joseph Chen <chenjh@rock-chips.com>,
	Joshua Riek <jjriek@verizon.net>,
	Kever Yang <kever.yang@rock-chips.com>,
	Klaus Goger <klaus.goger@cherry.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Levin Du <djw@t-chip.com.cn>,
	Loic Devulder <ldevulder@suse.com>,
	Luka Perkov <luka@openwrt.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Manorit Chawdhry <m-chawdhry@ti.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Michael Walle <michael@walle.cc>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nick Xie <nick@khadas.com>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Otavio Salvador <otavio@ossystems.com.br>,
	Paul Barker <paul.barker.ct@bp.renesas.com>,
	Peng Fan <peng.fan@nxp.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Ramon Fried <rfried.dev@gmail.com>,
	Robert Nelson <robertcnelson@gmail.com>,
	Sam Day <me@samcday.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Sebastian Kropatsch <seb-dev@mail.de>,
	Siddarth Gore <gores@marvell.com>,
	Simon Glass <sjg@chromium.org>,
	Simon Guinot <simon.guinot@sequanux.org>,
	Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
	Stefan Roese <sr@denx.de>,
	Sumit Garg <sumit.garg@linaro.org>,
	Suniel Mahesh <sunil@amarulasolutions.com>,
	Teresa Remmet <t.remmet@phytec.de>,
	Tianling Shen <cnsztl@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Tim Lunn <tim@feathertop.org>,
	Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
	Tony Dinh <mibodhi@gmail.com>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Viacheslav Bocharov <adeep@lexina.in>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Wadim Egorov <w.egorov@phytec.de>,
	Walter Schweizer <swwa@users.sourceforge.net>,
	Xiaobo Tian <peterwillcn@gmail.com>,
	u-boot-amlogic@groups.io,
	u-boot-qcom@groups.io
Subject: [PATCH 1/1] Squashed 'dts/upstream/' changes from 7e08733c96c8..20e0f0897ea2
Date: Thu, 18 Jul 2024 12:49:12 -0600
Message-Id: <20240718184912.2759784-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 22 Jul 2024 10:07:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2359

20e0f0897ea2 Merge tag 'v6.10-dts-raw'
9881d733059f Merge tag 'v6.10-rc7-dts-raw'
63c31204aa11 Merge tag 'sunxi-fixes-for-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into arm/fixes
23e9298c3dde Merge tag 'qcom-drivers-fixes-for-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
a5f0db70c762 Merge tag 'qcom-arm64-fixes-for-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
fc4d96ea6760 Revert "dt-bindings: cache: qcom,llcc: correct QDU1000 reg entries"
46fc6e869a85 Merge tag 'arm-fixes-6.10-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
383b8c948357 Merge tag 'v6.10-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes
1ff5952edb57 Merge tag 'v6.10-rc6-dts-raw'
0ca968fa0d3f Merge tag 'net-6.10-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
10fcf51ad7e0 Merge tag 'riscv-dt-fixes-for-v6.10-rc5+' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into arm/fixes
268d5cb92800 arm64: dts: rockchip: Add sound-dai-cells for RK3368
dd58f1b3fe58 arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi 4B
2e2d3a545342 Merge tag 'pinctrl-v6.10-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
e0c9ccf9429c Merge tag 'v6.10-rc5-dts-raw'
a3aee09ae954 Merge tag 'i2c-for-6.10-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
ac8de69b9a05 Merge branch 'scripting'
f887908e49ad Patch git-filter-branch to split state file
1ff8cba394ac Import git-filter-branch
1f73d9f38a31 dt-bindings: net: fman: remove ptp-timer from required list
aa50e7a5738c Merge tag 'arm-fixes-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
a905c57aa59d Merge tag 'dmaengine-fix-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine
033afe44d815 arm64: dts: qcom: qdu1000: Fix LLCC reg property
ac6085ba7cd5 arm64: dts: qcom: sm6115: add iommu for sdhc_1
8f31c6e16d9b dt-bindings: i2c: google,cros-ec-i2c-tunnel: correct path to i2c-controller schema
ecc33037d047 dt-bindings: i2c: atmel,at91sam: correct path to i2c-controller schema
b16dfe4648c8 Merge tag 'riscv-sophgo-dt-fixes-for-v6.10-rc4' of https://github.com/sophgo/linux into arm/fixes
f85451ad2ae3 Merge tag 'imx-fixes-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
4d2c25ce06fb arm64: dts: rockchip: fix PMIC interrupt pin on ROCK Pi E
41a24700d4d1 riscv: dts: starfive: Set EMMC vqmmc maximum voltage to 3.3V on JH7110 boards
6eaa11b25a95 riscv: dts: sophgo: disable write-protection for milkv duo
2095629696ec arm64: dts: rockchip: make poweroff(8) work on Radxa ROCK 5A
0f13320af297 Revert "arm64: dts: rockchip: remove redundant cd-gpios from rk3588 sdmmc nodes"
0620546b6733 ARM: dts: rockchip: rk3066a: add #sound-dai-cells to hdmi node
4611b52d5bfe arm64: dts: rockchip: Fix the value of `dlg,jack-det-rate` mismatch on rk3399-gru
bbbfd7e077bb dt-bindings: pinctrl: qcom,pmic-gpio: drop pm8008
9accaa155f11 Merge tag 'v6.10-rc4-dts-raw'
2013523900d1 arm64: dts: imx8qm-mek: fix gpio number for reg_usdhc2_vmmc
0ae20e9e959c arm64: dts: qcom: x1e80100-crd: fix DAI used for headset recording
0b659e2170b6 arm64: dts: qcom: x1e80100-crd: fix WCD audio codec TX port mapping
8382a880d3c3 Merge tag 'usb-6.10-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
dcabd676f1a3 Merge tag 'char-misc-6.10-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
cc13bb40d1a6 arm64: dts: freescale: imx8mm-verdin: enable hysteresis on slow input pin
7f72250809b5 arm64: dts: imx93-11x11-evk: Remove the 'no-sdio' property
d874a607615a arm64: dts: freescale: imx8mp-venice-gw73xx-2x: fix BT shutdown GPIO
4eb33c524819 arm: dts: imx53-qsb-hdmi: Disable panel instead of deleting node
78d14f0ab675 arm64: dts: imx8mp: Fix TC9595 input clock on DH i.MX8M Plus DHCOM SoM
4e86701872de Merge tag 'net-6.10-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
981b77cd0427 dt-bindings: dma: fsl-edma: fix dma-channels constraints
18988f4d5d2a Merge tag 'v6.10-rc3-dts-raw'
7da36558a7ef Merge tag 'for-linus-2024060801' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
88d1360549bb arm64: dts: rockchip: set correct pwm0 pinctrl on rk3588-tiger
11452c600e6a Merge tag 'iio-fixes-for-6.10a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus
084aa7375145 arm64: dts: qcom: sc8280xp-crd: use external pull up for touch reset
0e6bf883e88f arm64: dts: qcom: sc8280xp-x13s: fix touchscreen power on
e614df5979b3 dt-bindings: net: dp8386x: Add MIT license along with GPL-2.0
f7c56b502493 dt-bindings: HID: i2c-hid: elan: add 'no-reset-on-power-off' property
1978b946690b dt-bindings: HID: i2c-hid: elan: add Elan eKTH5015M
5495c8832594 dt-bindings: HID: i2c-hid: add dedicated Ilitek ILI2901 schema
9e26c6d54d11 input: Add support for "Do Not Disturb"
37570b57104f input: Add event code for accessibility key
cdef8a0e7a60 arm64: dts: qcom: x1e80100: Fix PCIe 6a reg offsets and add MHI
3f139ae589c4 Merge tag 'devicetree-fixes-for-6.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
7cf2ce6b6ba4 arm64: dts: qcom: sa8775p: Correct IRQ number of EL2 non-secure physical timer
f2fbbacd60a4 dt-bindings: usb: realtek,rts5411: Add missing "additionalProperties" on child nodes
164ee20c8b58 Merge tag 'v6.10-rc2-dts-raw'
48b74b73a14e LoongArch: Fix GMAC's phy-mode definitions in dts
087d672b4efd arm64: dts: freescale: imx8mm-verdin: Fix GPU speed
80fffb23d496 Merge tag 'net-6.10-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
54dda23c281e dt-bindings: arm: stm32: st,mlahb: Drop spurious "reg" property from example
2c63db1445be dt-bindings: arm: sunxi: Fix incorrect '-' usage
1d5708f86ae5 arm64: dts: allwinner: Fix PMIC interrupt number
6c601b11ba2a riscv: dts: canaan: Disable I/O devices unless used
92348c3ef236 riscv: dts: canaan: Clean up serial aliases
5d83fd10a397 dt-bindings: net: pse-pd: ti,tps23881: Fix missing "additionalProperties" constraints
6b2fa7b7cc40 dt-bindings: net: pse-pd: microchip,pd692x0: Fix missing "additionalProperties" constraints
50cb397e5cfd arm64: dts: rockchip: Rename LED related pinctrl nodes on rk3308-rock-pi-s
c9ccb008ab27 arm64: dts: rockchip: Fix SD NAND and eMMC init on rk3308-rock-pi-s
8e6eda922a09 arm64: dts: rockchip: Fix rk3308 codec@ff560000 reset-names
7f489c4cf57b arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage on Quartz64 Model B
299c3b3c66d9 arm64: dts: qcom: sc8280xp: Set status = "reserved" on PSHOLD
2b6c08b1583d dt-bindings: iio: dac: fix ad354xr output range
9f79d4c15d08 Merge tag 'v6.10-rc1-dts-raw'
fd0f921ffa6c arm64: dts: qcom: x1e80100-*: Allocate some CMA buffers
26c71714bb61 arm64: dts: qcom: sc8180x: Fix LLCC reg property again
2092f8f48d57 Merge tag 'rtc-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
07e14840ad5b Merge tag 'input-for-v6.10-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
13ccd59b5258 Merge tag 'sound-fix-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
37a1f7e6722d Merge tag 'char-misc-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
7ff78d0eda0d Merge tag 'tty-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
c5041b729865 Merge tag 'usb-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
1c57e8db82e7 Merge tag 'leds-next-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds
fd47bd25ce86 Merge tag 'mfd-next-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
00ece62bff8b dt-bindings: input: touchscreen: edt-ft5x06: Document FT5452 and FT8719 support
6f66f547411e Merge tag 'loongarch-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson
abd7af883f03 Merge tag 'phy-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
640e500cce85 Merge tag 'dmaengine-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine
b9fd3a8c4565 Merge tag 'mailbox-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox
b33f557e1d90 Merge tag 'rproc-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux
db01c383a7ce Merge tag 'pci-v6.10-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
0df9e98310e7 ASoC: dt-bindings: stm32: Ensure compatible pattern matches whole string
d8db35c82ce1 Merge tag 'soc-dt-late-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
f8e08c751522 Merge tag 'mips_6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
9caaf0aa30d4 Merge tag 'i2c-for-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
6ab09d9cca9e Merge tag 'pinctrl-v6.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
9325c648da25 dt-bindings: mailbox: qcom-ipcc: Document the SDX75 IPCC
8bf6a8f1f802 dt-bindings: mailbox: qcom: Add MSM8974 APCS compatible
2e132b836729 dt-bindings: mailbox: arm,mhuv3: Add bindings
74b961ca5252 Merge tag 'for-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply
71ece5053ab1 Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
2d9444bc11e2 Merge tag 'kbuild-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
d27b169f2113 Merge tag 'iommu-updates-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
0d52486eadc9 Merge tag 'random-6.10-rc1-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random
92ca6dd0a585 Merge tag 'net-6.10-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
d9138c3c1217 Merge tag 'devicetree-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
993251900df7 dt-bindings: net: ti: Update maintainers list
6fedb16407e2 Merge tag 'powerpc-6.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
5f1b352c20a8 dt-bindings: net: qcom: ethernet: Allow dma-coherent
a87254134e0a Merge branches 'clk-microchip', 'clk-samsung' and 'clk-qcom' into clk-next
e11cd4900b3c Merge branches 'clk-counted', 'clk-imx', 'clk-amlogic', 'clk-binding' and 'clk-rockchip' into clk-next
0dd8b4fc25ba Merge branches 'clk-stm', 'clk-renesas', 'clk-scmi' and 'clk-allwinner' into clk-next
6f21c834494e Merge branches 'clk-cleanup', 'clk-airoha', 'clk-mediatek', 'clk-sophgo' and 'clk-loongson' into clk-next
2fa059a4cd10 Merge tag 'platform-drivers-x86-v6.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
0202c4f79771 Merge tag 'mtd/for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
8cb25a01f0ea Merge tag 'mmc-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
074ab5a279da Merge tag 'media/v6.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
b1541fce9b3b dt-bindings: PCI: rockchip,rk3399-pcie: Add missing maxItems to ep-gpios
c358ed679396 Merge tag 'sound-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
06ae5fd04d8f Merge tag 'drm-next-2024-05-15' of https://gitlab.freedesktop.org/drm/kernel
fd0e36fa021c dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H compatible
fa14cdcce968 dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4H compatible
b69670b0bb47 dt-bindings: PCI: layerscape-pci: Convert to YAML format
cca86ffd0a16 dt-bindings: PCI: mediatek,mt7621-pcie: Switch from deprecated pci-bus.yaml
ae64917a411a dt-bindings: PCI: host-bridges: Switch from deprecated pci-bus.yaml
1201fe875e92 dt-bindings: PCI: mediatek,mt7621: Add missing child node reg
ba00158ae744 dt-bindings: PCI: cdns,cdns-pcie-host: Drop redundant msi-parent and pci-bus.yaml
5b6552bfdc78 dt-bindings: PCI: ti,am65: Fix remaining binding warnings
d7e666da2887 Merge tag 'net-next-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
2d9531926675 Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
db5eb37c03e9 Merge tag 'ata-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
5a032ee2fc23 Merge tag 'gpio-updates-for-v6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
ccc224839058 Merge tag 'pwm/for-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux
775802858417 Merge tag 'hwmon-for-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
fdde6e57ef72 Merge tag 'spi-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
99645799c95b Merge tag 'regulator-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
1eaaff2bbf2a Merge tag 'pm-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
ab29be69f525 Merge tag 'thermal-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
4075f17dbd78 Merge tag 'sh-for-v6.10-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux
757f8a19300b Merge tag 'irq-core-2024-05-12' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
dab08a165fab Merge tag 'timers-core-2024-05-12' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
feef09f5a21f dt-bindings: net: bluetooth: Add MediaTek MT7921S SDIO Bluetooth
76d9d779fa78 dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT binding
17441a5c4e4e LoongArch: dts: Add new supported device nodes to Loongson-2K2000
1f7ba0207e26 LoongArch: dts: Add new supported device nodes to Loongson-2K0500
a48765b239a2 LoongArch: dts: Remove "disabled" state of clock controller node
7773d8323bfe dt-bindings: net: renesas,rzn1-gmac: Document RZ/N1 GMAC support
ca2a5ced698c Merge tag 'v6.10-p1' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
505e43f254ef Merge branch 'pm-cpufreq'
76f483e4cfc6 Merge tag 'tpmdd-next-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
b1df36fb36a6 Merge tag 'soc-drivers-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
fd1841fda6fd Merge tag 'soc-dt-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
36770442d6b0 dt-bindings: display: panel: constrain 'reg' in DSI panels
813c5f459022 dt-bindings: display: panel: constrain 'reg' in SPI panels
41038ea2e4ff dt-bindings: display: samsung,ams495qa01: add missing SPI properties ref
10a89c799c00 Merge branches 'arm/renesas', 'arm/smmu', 'x86/amd', 'core' and 'x86/vt-d' into next
8910725cb527 dt-bindings: mfd: Use full path to other schemas
3b040755ae18 dt-bindings: mfd: Convert lp873x.txt to json-schema
296f112623fd dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node
a5a854afbee2 dt-bindings: mfd: allwinner,sun6i-a31-prcm: Use hyphens in node names
90a90b23d03b dt-bindings: mfd: qcom: pm8xxx: Add pm8901 compatible
da7f08aacdf2 dt-bindings: mfd: qcom,spmi-pmic: Add pbs to SPMI device types
966ad7078eaa dt-bindings: mfd: syscon: Add ti,am62p-cpsw-mac-efuse compatible
c4b18ab23407 dt-bindings: mfd: qcom,tcsr: Add compatible for SDX75
c3d99b909e44 dt-bindings: mfd: Add ROHM BD71879
9384afa70b33 dt-bindings: mfd: syscon: Add missing simple syscon compatibles
960f32f46fea dt-bindings: mfd: Add ROHM BD71828 system-power-controller property
cf10554091fd dt-bindings: mfd: twl: Convert trivial subdevices to json-schema
9715f4656242 Merge branches 'ib-mfd-misc-pinctrl-regulator-6.10', 'ib-mfd-pinctrl-regulator-6.10' and 'ib-mfd-regulator-6.10' into ibs-for-mfd-merged
ac7a1ec8dbb7 dt-bindings: usb: qcom,dwc3: fix interrupt max items
1b6db377e73b dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2H(P) SoC
4d0b690a0f3e Merge 6.9-rc7 into usb-next
3842450e242a Merge tag 'drm-msm-next-2024-05-07' of https://gitlab.freedesktop.org/drm/msm into drm-next
5896b040800b kbuild: use $(src) instead of $(srctree)/$(src) for source directory
73f4d08d8786 dt-bindings: tpm: Add st,st33ktpm2xi2c
620cdf951609 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
cadca550c946 regulator: dt-bindings: Add Allwinner D1 system LDOs
95cb4a04aa59 Merge tag 'wireless-next-2024-05-08' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
934735047002 dt-bindings: net: ipq4019-mdio: add IPQ9574 compatible
95ceac809a55 Merge tag 'riscv-dt-for-v6.10-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into soc/dt-late
680612099c31 dt-bindings: Use full path to other schemas
a2ec1b583d96 dt-bindings: spmi: Deprecate qcom,bus-id
3ef3f7c10b00 dt-bindings: spmi: Add X1E80100 SPMI PMIC ARB schema
af55caf92fae dt-bindings: spmi: hisilicon,hisi-spmi-controller: clean up example
8282c49f66a5 dt-bindings: spmi: hisilicon,hisi-spmi-controller: fix binding references
62c077472f2a Merge 6.9-rc7 into char-misc-testing
6f7bdf23be5b dt-bindings: PCI: qcom,pcie-sm8350: Drop redundant 'oneOf' sub-schema
37b24b375144 Merge tag 'qcom-arm64-for-6.10-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/dt
0bde68085fa9 Merge tag 'qcom-drivers-for-6.10-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/drivers
998c25c937aa dt-bindings: clocks: stm32mp25: add access-controllers description
30e9fba2158e riscv: dts: microchip: add pac1934 power-monitor to icicle
d6ee54e20abf RISC-V: add Milkv Mars board devicetree
0aa7d6d24f60 riscv: dts: thead: Fix node ordering in TH1520 device tree
6ee47d28e440 powerpc: Fix typos
3ba1815ef20a powerpc: dts: fsl: rename ifc node name to be memory-controller
7efff94fbf26 powerpc: dts: mpc85xx: remove "simple-bus" compatible from ifc node
9fe4ad7ce766 powerpc: dts: p1010rdb: fix INTx interrupt issue on P1010RDB-PB
6ebf39aa9455 powerpc: dts: add power management nodes to FSL chips
348344a5d65e Merge tag 'aspeed-6.10-devicetree' of git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc into soc/dt-late
e86f1cd5ef14 Merge tag 'amlogic-arm64-dt-for-v6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into soc/dt-late
7f9e5732c146 Merge tag 'samsung-dt64-6.10-2' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/dt
5695f8055c0c Merge tag 'v6.10-rockchip-dts64-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
b97bd45a8d97 Merge tag 'mvebu-dt64-6.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into soc/dt
5a9c9a32c3c7 dt-bindings: remoteproc: qcom,sdm845-adsp-pil: Fix qcom,halt-regs definition
d5164a7c22ad dt-bindings: remoteproc: qcom,sc7280-wpss-pil: Fix qcom,halt-regs definition
71bd8853612b dt-bindings: remoteproc: qcom,qcs404-cdsp-pil: Fix qcom,halt-regs definition
ba8d7136770b dt-bindings: remoteproc: qcom,msm8996-mss-pil: allow glink-edge on msm8996
62ef31a80421 dt-bindings: remoteproc: qcom,smd-edge: Mark qcom,ipc as deprecated
65fc362c2702 scsi: ufs: dt-bindings: exynos: Add gs101 compatible
f534b450c173 Merge back thermal cotntrol material for v6.10.
2d917790ebaa Merge tag 'samsung-pinctrl-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung into devel
8cf62b598531 regulator: new API for voltage reference supplies
ac173748045d dt-bindings: i2c: qcom-cci: Document sc8280xp compatible
6995b93c7587 dt-bindings: i2c: renesas,riic: Document R9A09G057 support
bfc00943afd2 dt-bindings: i2c: nxp,pnx-i2c: Convert to dtschema
85f529cada6f arm64: dts: marvell: espressobin-ultra: fix Ethernet Switch unit address
2f63c4b78fa1 arm64: dts: marvell: turris-mox: drop unneeded flash address/size-cells
5d8b59675398 arm64: dts: marvell: eDPU: drop redundant address/size-cells
272ed9c5b8fa dt-bindings: usb: dwc3: Add QDU1000 compatible
551f2d4471d9 dt-bindings: serial: brcm,bcm2835-aux-uart: convert to dtschema
b8768b797e66 arm64: zynqmp: Add resets property for UART nodes
82c86607462f dt-bindings: serial: cdns,uart: Add optional reset property
19f5c04825b2 dt-bindings: phy: qcom,usb-snps-femto-v2: use correct fallback for sc8180x
19ad6c854263 dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: fix msm899[68] power-domains
e6a7e5a9a0b3 dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: fix x1e80100-gen3x2 schema
2a3660ab6d73 dt-bindings: phy: qcom,qmp-usb: Add QDU1000 USB3 PHY
ae178787ba63 dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for QDU1000
c328437b7928 Merge tag 'iio-for-6.10b-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
96777d6c711d dt-bindings: clock: fixed: Define a preferred node name
f43b579bac3d arm64: dts: qcom: pm6150: correct USB VBUS regulator compatible
6dfc7e3a678d dt-bindings: PCI: microchip: increase number of items in ranges property
6f960acf6e33 Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
52f68a03a074 dt-bindings: Drop unnecessary quotes on keys
88c8e5011c36 dt-bindings: interrupt-controller: mediatek,mt6577-sysirq: Drop unnecessary quotes
07ae92f214f1 dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
744856737968 dt-bindings: mmc: renesas,sdhi: Group single const value items into an enum list
ea9a34aa0d78 arm64: dts: rockchip: add rk3588 pcie and php IOMMUs
8634bf1c11e4 arm64: dts: rockchip: enable onboard spi flash for rock-3a
afe1cedc2442 arm64: dts: rockchip: add USB-C support to rk3588s-orangepi-5
f66647cd8ff8 arm64: dts: rockchip: Enable GPU on Orange Pi 5
4fba41bce2ab arm64: dts: rockchip: enable GPU on khadas-edge2
7570dc9fb6bb arm64: dts: rockchip: Add USB3 on Edgeble NCM6A-IO board
8b4785e613c3 arm64: dts: rockchip: Support poweroff on Edgeble Neural Compute Module
d96268ba01d4 arm64: dts: rockchip: Add Radxa ROCK 3C
6ef83cfb7ada dt-bindings: arm: rockchip: add Radxa ROCK 3C
d7dd131cd82a Merge tag 'ath-next-20240502' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath
93b4a866bf35 dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
7335736c9d78 arm64: dts: exynos: gs101: specify empty clocks for remaining pinctrl
dca8a5f1a090 arm64: dts: exynos: gs101: specify bus clock for pinctrl_hsi2
498c9adc4cc2 arm64: dts: exynos: gs101: specify bus clock for pinctrl_peric[01]
a31c51d6eabf arm64: dts: exynos: gs101: specify bus clock for pinctrl (far) alive
115f542562dc dt-bindings: mfd: Add rk816 binding
4b2fb80b9d70 dt-bindings: pinctrl: qcom,pmic-gpio: Fix "comptaible" typo for PMIH0108
0c39b3c5118f dt-bindings: pinctrl: mediatek: mt7622: add "antsel" function
204d57f69a78 dt-bindings: pinctrl: mediatek: mt7622: fix array properties
9cdad5a31765 dt-bindings: nvmem: Add compatible for SC8280XP
99e9e4f0f8ef dt-bindings: nvmem: qcom,spmi-sdam: update maintainer
c63963f91c46 dt-bindings: nvmem: Add compatible for sm8450, sm8550 and sm8650
f89ebb9f08f8 Merge tag 'coresight-next-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
9c567dfe1e7c spi: dt-bindings: ti,qspi: convert to dtschema
f51f7fbfe068 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
374788ecd661 Merge tag 'ti-k3-dt-for-v6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/dt
8ea799a75295 Merge tag 'ti-keystone-dt-for-v6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/dt
d583b2d29084 Merge tag 'riscv-sophgo-dt-for-v6.10' of https://github.com/sophgo/linux into soc/dt
226f8a9f0d52 arm64: dts: Add/fix /memory node unit-addresses
22b584d29caf dt-bindings: kbuild: Add separate target/dependency for processed-schema.json
4e6a6fa12d6f sh: j2: Drop incorrect SPI controller spi-max-frequency property
bdcb00f4f3b3 ARM: dts: aspeed: Add ASRock E3C256D4I BMC
aac0710a73b4 dt-bindings: arm: aspeed: document ASRock E3C256D4I
b80c8c18fac4 dt-bindings: trivial-devices: add isil,isl69269
cb1c41ce59ca arm64: dts: qcom: qcs404: fix bluetooth device address
d0ae260a2e22 dt-bindings: soc: qcom,wcnss: fix bluetooth address example
7503e9a214fc arm64: dts: qcom: sc8280xp-x13s: enable USB MP and fingerprint reader
817ddd5ea9f8 arm64: dts: qcom: sc8280xp: Add USB DWC3 Multiport controller
b3fba1efeb88 dt-bindings: pwm: snps,dw-apb-timers: Do not require pwm-cells twice
50e8b723b671 dt-bindings: pwm: mediatek,pwm-disp: Do not require pwm-cells twice
8bef6380e735 dt-bindings: pwm: mediatek,mt2712: Do not require pwm-cells twice
d9933a0695f9 dt-bindings: pwm: marvell,pxa: Do not require pwm-cells twice
51bdf5ce1163 dt-bindings: pwm: google,cros-ec: Do not require pwm-cells twice
3d9506504c8c dt-bindings: pwm: bcm2835: Do not require pwm-cells twice
534bc64cdedb ARM: dts: aspeed: x4tf: Add dts for asus x4tf project
6fbe3fdaf9f0 dt-bindings: arm: aspeed: add ASUS X4TF board
c82854e88202 ARM: dts: aspeed: Remove Facebook Cloudripper dts
fd75393bdcb1 ARM: dts: aspeed: drop unused ref_voltage ADC property
8754892d5b75 ARM: dts: aspeed: harma: correct Mellanox multi-host property
8e9cc6c20b82 ARM: dts: aspeed: yosemitev2: correct Mellanox multi-host property
e2c78475b613 ARM: dts: aspeed: yosemite4: correct Mellanox multi-host property
c541062fa469 ARM: dts: aspeed: greatlakes: correct Mellanox multi-host property
34bf4cdbef99 ARM: dts: aspeed: Modify I2C bus configuration
d8f2250514be ARM: dts: aspeed: Disable unused ADC channels for Asrock X570D4U BMC
2901b8ca961c ARM: dts: aspeed: Modify GPIO table for Asrock X570D4U BMC
88064efed3fa ARM: dts: aspeed: yosemite4: set bus13 frequency to 100k
5ef12a481212 ARM: dts: Aspeed: Bonnell: Fix NVMe LED labels
3fc453c1db53 ARM: dts: aspeed: yosemite4: Enable ipmb device for OCP debug card
bcfaf623d0d2 ARM: dts: aspeed: ahe50dc: Update lm25066 regulator name
8234174b4319 ARM: dts: aspeed: Add vendor prefixes to lm25066 compat strings
ff5b5d4f8608 ARM: dts: aspeed: asrock: Use MAC address from FRU EEPROM
4cd1834171b1 ARM: dts: aspeed: system1: IBM System1 BMC board
f78504173b45 dt-bindings: arm: aspeed: add IBM system1-bmc
fe7af5d377d3 ARM: dts: aspeed: FSI interrupt support
868c28fb73db ARM: dts: aspeed: Harma: Modify GPIO line name
4c844ce58341 ARM: dts: aspeed: Harma: Add retimer device
fa2c17701347 ARM: dts: aspeed: Harma: Revise node name
2c56352a6e8c ARM: dts: aspeed: Harma: Add ltc4286 device
f3f20436ebf5 ARM: dts: aspeed: Harma: Add NIC Fru device
c65f4bd47989 ARM: dts: aspeed: Harma: Revise max31790 address
7f91e0534cac ARM: dts: aspeed: Harma: Add PDB temperature
77648c84705d ARM: dts: aspeed: Harma: Add spi-gpio
a3814da132d2 ARM: dts: aspeed: Harma: Add cpu power good line name
a4d3dcdc6972 ARM: dts: aspeed: Harma: Remove Vuart
644d0c7be99d ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
e3db91e58704 ARM: dts: aspeed: Harma: Revise SGPIO line name.
fb4379aba520 ARM: dts: aspeed: minerva: add sgpio line name
0f636550db24 ARM: dts: aspeed: minerva: add gpio line name
c081df13fef5 ARM: dts: aspeed: minerva: Add led-fan-fault gpio
9d8afce52cc1 ARM: dts: aspeed: minerva: add fan rpm controller
cf8bbd25181f ARM: dts: aspeed: minerva: add bus labels and aliases
3c1b4cf53f8a ARM: dts: aspeed: minerva: correct the address of eeprom
eb9d7ba9327b ARM: dts: aspeed: minerva: Add temperature sensor
d76b93442ef4 ARM: dts: aspeed: minerva: Enable power monitor device
646c9c05f278 ARM: dts: aspeed: minerva: Change sgpio use
741d60b7c317 ARM: dts: aspeed: minerva: Modify mac3 setting
2424cc717af4 ARM: dts: aspeed: minerva: Revise the name of DTS
088aed05938b ARM: dts: aspeed: Harma: Add Meta Harma (AST2600) BMC
218a89911b36 dt-bindings: arm: aspeed: add Meta Harma board
7ffe6470af68 ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
f53f1d892e04 dt-bindings: arm: aspeed: add Asrock X570D4U board
29b44948f246 ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC
28c22e1158f6 dt-bindings: arm: aspeed: document ASRock SPC621D8HM3
5b07006d0544 dt-bindings: net: snps, dwmac: remove tx-sched-sp property
d641f9b08e97 riscv: dts: starfive: add Milkv Mars board device tree
0481c0695137 riscv: dts: starfive: introduce a common board dtsi for jh7110 based boards
73f68262699b riscv: dts: starfive: visionfive 2: add "disable-wp" for tfcard
07708df1edd7 riscv: dts: starfive: visionfive 2: add tf cd-gpios
69db0d9798f7 riscv: dts: starfive: visionfive 2: use cpus label for timebase freq
cf6fa1279f6f riscv: dts: starfive: visionfive 2: update sound and codec dt node name
5ab1511c1599 dt-bindings: riscv: starfive: add Milkv Mars board
5965246fe186 riscv: dts: starfive: add 'cpus' label to jh7110 and jh7100 soc dtsi
5bdc176b24a8 arm64: dts: exynos: gs101: enable ufs, phy on oriole & define ufs regulator
1dfec606a1c1 arm64: dts: exynos: gs101: Add ufs and ufs-phy dt nodes
7596e4636938 arm64: dts: exynos: gs101: Add the hsi2 sysreg node
6f1e47732d9c dt-bindings: hwmon: Add infineon xdp710 driver bindings
c68d8da7c295 dt-bindings: usb: samsung,exynos-dwc3: add gs101 compatible
ccc8d79a51ac dt-bindings: pwm: mediatek,pwm-disp: add compatible for mt8365 SoC
c3ae8f8609b7 dt-bindings: remoteproc: mediatek: Support MT8188 dual-core SCP
dd64a9b5d3ba ASoC: doc: dapm: various improvements
a1c502ef408b dt-bindings: power: supply: max8903: specify flt-gpios as input
758561486cca spi: dt-bindings: airoha: Add YAML schema for SNFI controller
e8cc1fcce923 Merge tag 'arm-soc/for-6.10/devicetree-arm64' of https://github.com/Broadcom/stblinux into soc/dt
fd27491e295c Merge tag 'arm-soc/for-6.10/devicetree' of https://github.com/Broadcom/stblinux into soc/dt
c8a3fe7c83a8 Merge tag 'fpga-for-6.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
518d1470b29f ASoC: dt-bindings: tegra30-i2s: convert to dt schema
c31e41137854 Merge tag 'scmi-updates-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into soc/drivers
6ef92eb988f4 Merge tag 'memory-controller-drv-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
ab79838ecc1a Merge tag 'qcom-drivers-for-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/drivers
b0cbed6b585b Merge tag 'stm32-bus-firewall-for-v6.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32 into soc/drivers
8cd266d248da arm64: dts: ti: k3-am625-beagleplay: Fix Ethernet PHY RESET GPIOs
98ccfd6398ba dt-bindings: adc: axi-adc: add clocks property
36809262c854 dt-bindings: iio: imu: add icm42686 inside inv_icm42600
9c909a6abc5d arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add USB-C
47c139a551cc arm64: dts: ti: k3-j784s4: Add main esm address range
093094153bf0 arm64: dts: ti: k3-j721s2: Add main esm address range
9f0082edafc1 arm64: dts: ti: k3-am62-verdin-dahlia: support sleep-moci
28db01d2495d arm64: dts: ti: k3-am62-verdin: replace sleep-moci hog with regulator
8ff208c87e5b arm64: dts: ti: k3-j722s-evm: Enable UHS support for MMCSD
b8d07395e608 arm64: dts: ti: k3-j784s4-main: Enable support for UHS mode
6c24472d05a2 arm64: dts: ti: k3-j721s2-main: Enable support for SDR104 speed mode
f1149a5b0e32 arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards
750a79223c4c arm64: dts: ti: k3-am65-main: Remove unused properties in sdhci nodes
15229953d1b5 arm64: dts: ti: k3-am65-main: Fix sdhci node properties
81b47c119091 arm64: dts: ti: am64-phyboard-electra: Add overlay to enable a GPIO fan
689d2e3193ee arm64: dts: ti: k3-am62a-main: Add Wave5 Video Encoder/Decoder Node
a6f7715e22a2 arm64: dts: ti: k3-am69-sk: Fix UART pin type and macro type
196bfc4b149d arm64: dts: ti: k3-j784s4-evm: Fix UART pin type and macro type
e29fa5eebabf arm64: dts: ti: k3-am62a: Disable USB LPM
28771bff0163 arm64: dts: ti: k3-am62p: add the USB sub-system
397d6e54c93b arm64: dts: ti: k3-am62/a: use sub-node for USB_PHY_CTRL registers
19f2147e2d4a arm64: dts: ti: k3-am62*: Add PHY2 region to USB wrapper node
dc5081fa31f4 arm64: dts: ti: iot2050: Add icssg-prueth nodes for PG1 devices
5bce68cd3ed7 arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add Audio Codec
6b093f16cd8c Merge v6.9-rc6 into drm-next
fcd3b733403c arm64: dts: qcom: sm8650: Fix GPU cx_mem size
0017da720656 dt-bindings: soc: google: exynos-sysreg: add dedicated hsi2 sysreg compatible
0a6165f2f813 arm64: dts: exynos: gs101-oriole: enable USB on this board
7de232618ba7 arm64: dts: exynos: gs101: add USB & USB-phy nodes
16041c95ecb1 arm64: dts: exynos: gs101: enable cmu-hsi2 clock controller
9066b47c5392 dt-bindings: pinctrl: samsung: google,gs101-pinctrl needs a clock
5f29245d5c50 Merge branch 'for-v6.10/clk-gs101-bindings' into next/clk
fff3ee6f2556 arm64: dts: exynos: gs101: enable cmu-hsi0 clock controller
168cc32bbc08 Merge branch 'for-v6.10/clk-gs101-bindings' into next/dt64
fc4c7d259d85 dt-bindings: clock: google,gs101-clock: add HSI2 clock management unit
0a148e2d01ad Merge tag 'microchip-dt64-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into soc/dt
242a9f969df3 Merge tag 'dt-cleanup-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt into soc/dt
764054cefbec Merge tag 'dt64-cleanup-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt into soc/dt
03af24450b05 Merge tag 'imx-dt64-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/dt
cefd253be3d5 Merge tag 'imx-dt-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/dt
fa182fa40b43 Merge tag 'imx-bindings-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/dt
d9807f0ca418 ASoC: Merge up fixes
e8d36c696111 regulator: dt-bindings: fixed-regulator: Add a preferred node name
58e931983da2 Merge tag 'qcom-arm64-for-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/dt
4dd78879de18 Merge tag 'qcom-arm32-for-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/dt
086c3411f16b Merge tag 'sunxi-dt-for-6.10-2' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into soc/dt
53da8c9d0e3f Merge tag 'tegra-for-6.10-arm64-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/dt
1acd19fd83d8 Merge tag 'tegra-for-6.10-arm-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/dt
788dcee7a235 Merge tag 'tegra-for-6.10-dt-bindings' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/dt
d38eb9fd4c47 media: dt-bindings: media: i2c: Rename ov8856.yaml
a82fcd597ba3 dt-bindings: media: Add bindings for bcm2835-unicam
2b803146783c Merge tag 'sunxi-dt-for-6.10-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into soc/dt
afa61e2abc7e Merge tag 'renesas-dts-for-v6.10-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
bfe91094022a Merge tag 'renesas-pinctrl-for-v6.10-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into devel
1dcf8839ed11 Merge tag 'v6.10-rockchip-dts64-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
2d528063c0dd Merge tag 'stm32-dt-for-v6.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32 into soc/dt
ff55dd2aa9f3 Merge tag 'hisi-arm64-dt-for-6.10' of https://github.com/hisilicon/linux-hisi into soc/dt
4e0f50e92cba Merge tag 'samsung-dt64-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/dt
4c8b8d6276c2 Merge tag 'samsung-dt-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/dt
50686674cb6c Merge tag 'omap-for-v6.10/dt-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/dt
ab3a6233162a arm/arm64: dts: Drop "arm,armv8-pmuv3" compatible usage
50c7906394c4 Merge tag 'renesas-dts-for-v6.10-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
2184251713ad Merge tag 'renesas-dt-bindings-for-v6.10-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
8c1b616ea391 dt-bindings: hwmon: adm1275: add adm1281
c3e6844640bc dt-bindings: hwmon: pmbus: adp1050: add bindings
3eb515b4f7c5 dt-bindings: hwmon: ibm,p8-occ-hwmon: move to trivial devices
92146dcf5fba dt-bindings: hwmon: stts751: convert to dtschema
84925db754f7 dt-bindings: hwmon: pwm-fan: drop text file
7b6608685581 dt-bindings: hwmon: ibmpowernv: convert to dtschema
1ab44a73ebd9 dt-bindings: hwmon: as370: convert to dtschema
bc45c32fc67e dt-bindings: hwmon: max6650: convert to dtschema
c2400866fc0d dt-bindings: hwmon: lm87: convert to dtschema
f14761db4a7c dt-bindings: hwmon: adc128d818: convert to dtschema
5f0241b4484d ARM: dts: imx6ul-pico: Use #pwm-cells = <3> for imx27-pwm device
3a5c80f6a4b5 ARM: dts: imx6ul-kontron-bl-common: Use #pwm-cells = <3> for imx27-pwm device
894db90901de ARM: dts: imx6ul-kontron-bl-43: Use #pwm-cells = <3> for imx27-pwm device
4261e3018fb5 ARM: dts: imx6ul-isiot: Use #pwm-cells = <3> for imx27-pwm device
2b6204343342 ARM: dts: imx6ul-imx6ull-opos6uldev: Use #pwm-cells = <3> for imx27-pwm device
82341566c04e ARM: dts: imx6ul-geam: Use #pwm-cells = <3> for imx27-pwm device
8e966ce66d8c ARM: dts: imx6ul-ccimx6ulsbcpro: Use #pwm-cells = <3> for imx27-pwm device
865e89e03fae ARM: dts: imx6ul-14x14-evk: Use #pwm-cells = <3> for imx27-pwm device
3d0a1fbee307 ARM: dts: imx6sx-softing-vining-2000: Use #pwm-cells = <3> for imx27-pwm device
d9d78c59fa41 ARM: dts: imx6sx-sdb: Use #pwm-cells = <3> for imx27-pwm device
1f88e558e51e ARM: dts: imx6sx-nitrogen6sx: Use #pwm-cells = <3> for imx27-pwm device
61ee876baae2 ARM: dts: imx6sll-evk: Use #pwm-cells = <3> for imx27-pwm device
c6958e718629 ARM: dts: imx6sl-evk: Use #pwm-cells = <3> for imx27-pwm device
e927cd402da0 ARM: dts: imx6q-var-dt6customboard: Use #pwm-cells = <3> for imx27-pwm device
a91e17423db9 ARM: dts: imx6q-prti6q: Use #pwm-cells = <3> for imx27-pwm device
0fdfb7444f91 ARM: dts: imx6q-pistachio: Use #pwm-cells = <3> for imx27-pwm device
de30519f0ce8 ARM: dts: imx6q-novena: Use #pwm-cells = <3> for imx27-pwm device
398e92a2b4ff ARM: dts: imx6q-kp: Use #pwm-cells = <3> for imx27-pwm device
122b61c34ac0 ARM: dts: imx6qdl-skov-cpu: Use #pwm-cells = <3> for imx27-pwm device
cee66abc40b2 ARM: dts: imx6qdl-savageboard: Use #pwm-cells = <3> for imx27-pwm device
94b2d4f76971 ARM: dts: imx6qdl-sabresd: Use #pwm-cells = <3> for imx27-pwm device
c8211f5a745b ARM: dts: imx6qdl-sabrelite: Use #pwm-cells = <3> for imx27-pwm device
4fc475ec0bfe ARM: dts: imx6qdl-sabreauto: Use #pwm-cells = <3> for imx27-pwm device
817d1417ba5f ARM: dts: imx6qdl-phytec-mira: Use #pwm-cells = <3> for imx27-pwm device
5b7034957cac ARM: dts: imx6qdl-nitrogen6x: Use #pwm-cells = <3> for imx27-pwm device
f0374cc2f386 ARM: dts: imx6qdl-nitrogen6_som2: Use #pwm-cells = <3> for imx27-pwm device
e2ba7ce78c3a ARM: dts: imx6qdl-nitrogen6_max: Use #pwm-cells = <3> for imx27-pwm device
6444e7b54264 ARM: dts: imx6qdl-nit6xlite: Use #pwm-cells = <3> for imx27-pwm device
34b05463f110 ARM: dts: imx6qdl-icore: Use #pwm-cells = <3> for imx27-pwm device
b6c1a9a0e786 ARM: dts: imx6qdl-gw5904: Use #pwm-cells = <3> for imx27-pwm device
567c0237038e ARM: dts: imx6qdl-gw5903: Use #pwm-cells = <3> for imx27-pwm device
3b97532650ae ARM: dts: imx6qdl-gw560x: Use #pwm-cells = <3> for imx27-pwm device
09b7e1fce9c0 ARM: dts: imx6qdl-gw54xx: Use #pwm-cells = <3> for imx27-pwm device
9d9c6be33f54 ARM: dts: imx6qdl-gw53xx: Use #pwm-cells = <3> for imx27-pwm device
01dc8030008c ARM: dts: imx6qdl-gw52xx: Use #pwm-cells = <3> for imx27-pwm device
442e9e2cd489 ARM: dts: imx6qdl-emcon: Use #pwm-cells = <3> for imx27-pwm device
4273ffc9b390 ARM: dts: imx6qdl-cubox-i: Use #pwm-cells = <3> for imx27-pwm device
6dc80d53ff06 ARM: dts: imx6qdl-aristainetos2: Use #pwm-cells = <3> for imx27-pwm device
771488ed93f3 ARM: dts: imx6qdl-apf6dev: Use #pwm-cells = <3> for imx27-pwm devices
a7a73f9e83b5 ARM: dts: imx6q-bosch-acc: Use #pwm-cells = <3> for imx27-pwm device
9b9357a17bcb ARM: dts: imx6q-ba16: Use #pwm-cells = <3> for imx27-pwm device
5bf9cc646738 ARM: dts: imx6dl-mamoj: Use #pwm-cells = <3> for imx27-pwm device
f135970e648f ARM: dts: imx6dl-aristainetos_7: Use #pwm-cells = <3> for imx27-pwm device
03a4cdebe838 ARM: dts: imx6dl-aristainetos_4: Use #pwm-cells = <3> for imx27-pwm device
743acc4b1e34 ARM: dts: imx53-tqma: Use #pwm-cells = <3> for imx27-pwm devices
92ea86f237ec ARM: dts: imx53-kp: Drop redundant settings in pwm nodes
6e6f0fe28f34 ARM: dts: imx53-ppd: Use #pwm-cells = <3> for imx27-pwm device
5727c6338d4c ARM: dts: imx53-m53evk: Use #pwm-cells = <3> for imx27-pwm device
f2cae0965dd3 ARM: dts: imx51-ts4800: Use #pwm-cells = <3> for imx27-pwm device
4541c38d4c60 arm64: dts: allwinner: h700: Add RG35XX-H DTS
daa5943c303a arm64: dts: allwinner: h700: Add RG35XX-Plus DTS
10cc453d0430 arm64: dts: allwinner: h700: Add RG35XX 2024 DTS
722c84ed33e6 dt-bindings: arm: sunxi: document Anbernic RG35XX handheld gaming device variants
e788464ef24b dt-bindings: rng: Add vmgenid support
75f2af2ca0ae dt-bindings: pwm: at91: Add sam9x7 compatible strings list
3353f9a8a5bc arm: dts: bcm2711: Describe Ethernet LEDs
3d50bf87d377 arm64: tegra: Add Tegra Security Engine DT nodes
7b08ed2620d2 arm64: tegra: Correct Tegra132 I2C alias
9627bea4c92a arm64: dts: allwinner: h616: Add NMI device node
91f842070ca8 ARM: tegra: tegra20-ac97: Replace deprecated "gpio" suffix
e8b0f9515b41 dt-bindings: display: tegra: Allow dma-coherent on Tegra194 and later
491f6ad2e547 ARM: tegra: paz00: Add emc-tables for ram-code 1
5ce17d4855f4 dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM4450 compatibles
c90ac68e2be2 dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a779h0 support
b0a13ac425b3 dt-bindings: crypto: starfive: Restore sort order
e8a597329b91 dt-bindings: gpio: brcmstb: add gpio-ranges
45e5187d9fa1 Merge tag 'mediatek-drm-next-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux into drm-next
e1a940d29d46 ASoC: dt-bindings: fsl,ssi: Convert to YAML
f2c94311aed5 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
84b998c95492 dt-bindings: clock: renesas,rzg2l-cpg: Update #power-domain-cells = <1> for RZ/G3S
b552f8f18bfc dt-bindings: clock: r9a08g045-cpg: Add power domain IDs
0c0d1f342539 dt-bindings: clock: r9a07g054-cpg: Add power domain IDs
ae25d8155ea7 dt-bindings: clock: r9a07g044-cpg: Add power domain IDs
ac3c38d1a01e dt-bindings: clock: r9a07g043-cpg: Add power domain IDs
fe6a602e4ebf arm64: dts: st: correct masks for GIC PPI interrupts on stm32mp25
9e5a000a4104 arm64: dts: st: add spi3 / spi8 properties on stm32mp257f-ev1
4aeaef4d0e11 arm64: dts: st: add spi3/spi8 pins for stm32mp25
67ba1036313a arm64: dts: st: add all 8 spi nodes on stm32mp251
9c54638973a4 arm64: dts: st: add i2c2 / i2c8 properties on stm32mp257f-ev1
8b31f6abad0e arm64: dts: st: add i2c2/i2c8 pins for stm32mp25
5e4a8c073dca arm64: dts: st: add all 8 i2c nodes on stm32mp251
64999979f7da arm64: dts: st: add rcc support for STM32MP25
1669707ddf84 ARM: dts: stm32: enable display support on stm32mp135f-dk board
346b593975d0 ARM: dts: stm32: add LTDC pinctrl on STM32MP13x SoC family
24aa5bae642e ARM: dts: stm32: add LTDC support for STM32MP13x SoC family
4d6a8bd0c624 dt-bindings: display: simple: allow panel-common properties
33f5c9c9fb56 ARM: dts: stm32: add PWR regulators support on stm32mp131
d6faa3bf1bb7 media: dt-bindings: add access-controllers to STM32MP25 video codecs
b16594d4ebce ARM: dts: stm32: add heartbeat led for stm32mp157c-ed1
493c81145d01 ARM: dts: stm32: move can3 node from stm32f746 to stm32f769
c17556a78124 ARM: dts: stm32: put ETZPC as an access controller for STM32MP13x boards
e4e32345cbfc ARM: dts: stm32: add ETZPC as a system bus for STM32MP13x boards
75b51ac3298b ARM: dts: stm32: put ETZPC as an access controller for STM32MP15x boards
2a5199568715 ARM: dts: stm32: add ETZPC as a system bus for STM32MP15x boards
86502fa8c41b arm64: dts: st: add RIFSC as an access controller for STM32MP25x boards
f062a015f4f5 arm64: dts: ti: k3-j784s4: Use exact ranges for FSS node
0c0e03ec224e arm64: dts: ti: k3-j721e: Use exact ranges for FSS node
f00e6260851d arm64: dts: ti: k3-j7200: Use exact ranges for FSS node
2b5965048af3 arm64: dts: ti: k3-am65: Use exact ranges for FSS node
67b4c30577d2 arm64: dts: ti: k3-am65: Move SerDes mux nodes under the control node
3358adf6b793 arm64: dts: ti: k3-am65: Add full compatible to SerDes control nodes
535a3c9fbc39 arm64: dts: imx93-11x11-evk: add RTC PCF2131 support
0eb52fbf2b5b dt-bindings: dma: fsl-edma: allow 'power-domains' property
d1b04584c784 dt-bindings: dma: fsl-edma: remove 'clocks' from required
b0f652da2c1a dt-bindings: fsl-imx-sdma: Add I2C peripheral types ID
db50dffed6e0 dt-bindings: fsl-dma: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible string
cc846cc8c9a3 dt-bindings: dma: Drop unused QCom hidma binding
5f63f6393d95 dt-bindings: clock: google,gs101-clock: add HSI0 clock management unit
d3de8c521ca4 arm64: dts: imx93-11x11-evk: add reset gpios for ethernet PHYs
71803901715e arm64: dts: imx93-11x11-evk: add sleep pinctrl for sdhc2
e785de3e57da arm64: dts: imx93-11x11-evk: add different usdhc pinctrl for different timing usage
42b4ea4a24dc arm64: dts: imx93-11x11-evk: add sleep pinctrl for eqos and fec
3c1a4d062690 arm64: dts: imx93-11x11-evk: update resource table address
b9bfb20ead6b arm64: dts: imx93: add nvmem property for eqos
b2feecd51432 arm64: dts: imx93: add nvmem property for fec1
5f69da62e7ef arm64: dts: imx93: assign usdhc[1..3] root clock to 400MHz
181b3041bbb7 arm64: dts: imx93: add dma support for lpspi[1..8]
4c954fbede67 arm64: dts: imx93: add dma support for lpi2c[1..8]
175c3328f64f arm64: dts: imx93: use FSL_EDMA_RX for rx channel
313d19f58e75 arm64: dts: freescale: ls1028a: Add standard PCI device compatible strings to ENETC
1d8c51469b41 arm64: dts: freescale: ls1028a: Fix embedded PCI interrupt mapping
1f7d8fa2f7e0 arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960 and sai[0,1,4,5]
15aedc871fe4 arm64: dts: imx8mp: Align both CSI2 pixel clock
4442cdcc4fc8 ARM: dts: imx6ull-tarragon: Reduce SPI clock for QCA7000
b0d57263bdf2 ARM: dts: nxp: imx6qdl: fix esai clock warning when do dtb_check
57fdf0a64275 ARM: dts: nxp: imx6sx: fix esai related warning when do dtb_check
6df4426dd76b ARM: dts: BCM5301X: Conform to DTS Coding Style on ASUS RT-AC3100 & AC88U
c426fd6da616 ARM: dts: BCM5301X: Add DT for ASUS RT-AC5300
b2a89f7efb01 ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
a932bc9ff274 dt-bindings: arm: bcm: add bindings for ASUS RT-AC5300
1255f9086006 dt-bindings: arm: bcm: add bindings for ASUS RT-AC3200
31dbca206286 ARM: dts: bcm2835: Add Unicam CSI nodes
7dcc70cf239d media: dt-bindings: nxp,imx8-jpeg: Add clocks entries
dbfa282670db ARM: dts: aspeed: Add vendor prefixes to lm25066 compat strings
e4599b879ecc arm64: dts: cavium: thunder2-99xx: drop redundant reg-names
76ec00bedfda arm64: dts: amazon: alpine-v3: correct gic unit addresses
c4f94cdc07e6 arm64: dts: amazon: alpine-v3: drop cache nodes unit addresses
ebdc05f0329b arm64: dts: amazon: alpine-v3: add missing io-fabric unit addresses
ad5e68116954 arm64: dts: amazon: alpine-v2: move non-MMIO node out of soc
29e19d50851c arm64: dts: amazon: alpine-v2: add missing io-fabric unit addresses
ce0b227a6574 arm64: dts: apm: shadowcat: move non-MMIO node out of soc
27c326261c5b arm64: dts: apm: storm: move non-MMIO node out of soc
d9a81ed4a976 arm64: dts: cavium: correct unit addresses
8c4332bb1675 arm64: dts: cavium: move non-MMIO node out of soc
e9269e3c4077 arm64: dts: realtek: rtc16xx: add missing unit address to soc node
724eaba44818 arm64: dts: realtek: rtd139x: add missing unit address to soc node
52adc8d0a8c1 arm64: dts: realtek: rtd129x: add missing unit address to soc node
089cadb46086 arm64: dts: uniphier: ld20-global: drop audio codec port unit address
c8128ae212de arm64: dts: uniphier: ld20-global: use generic node name for audio-codec
5cf76606fda2 arm64: dts: uniphier: ld11-global: drop audio codec port unit address
93e079a0d13a arm64: dts: uniphier: ld11-global: use generic node name for audio-codec
41365adca496 arm64: dts: sharkl3: add missing unit addresses
54ef9a80a93a arm64: dts: whale2: add missing ap-apb unit address
9791da4e0389 arm64: dts: sc9860: move GIC to soc node
ce02ab2f5b45 arm64: dts: sc9860: move GPIO keys to board
92205bb23cdd arm64: dts: sc9860: add missing aon-prediv unit address
10256f562a49 Merge tag 'iio-for-6.10a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
3d013af73b39 dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport
ec09e3a30b9f dt-bindings: usb: Add bindings for multiport properties on DWC3 controller
cde9be1559bf ASoC: dt-bindings: renesas: Fix R-Car Gen4 SoC-specific compatibles
f6b925bcd3bc ASoC: dt-bindings: tegra20-ac97: convert to dt schema
d7ddd18e6ec7 dt-bindings: usb: uhci: convert to dt schema
e61b74add0c7 dt-bindings: usb: qcom,pmic-typec: update example to follow connector schema
135af74d5147 dt-bindings: clock: qcom,hfpll: Convert to YAML
d91a413d181d dt-bindings: watchdog: aspeed,ast2400-wdt: Convert to DT schema
1c22fce3413a dt-bindings: irq: sun7i-nmi: Add binding for the H616 NMI controller
b95bd2d7176e dt-bindings: interrupt-controller: renesas,irqc: Add r8a779g0 support
193d3b2a0a98 arm64: dts: rockchip: add dual-role usb3 hosts to rk3588 Tiger-Haikou
4843cec40923 arm64: dts: rockchip: add usb-id extcon on rk3588 tiger
56f3031edf22 arm64: dts: rockchip: fix comment for upper usb3 port
b574cbafae97 arm64: dts: rockchip: fix pcie-refclk frequency on rk3588 tiger
cb2b6d1d19ed arm64: dts: rockchip: correct gpio_pwrctrl1 typos on rk3588(s) boards
c1af4a1c01a7 dt-bindings: display: bridge: tc358775: Add support for tc358765
2f5f0d103f6e dt-bindings: display: bridge: tc358775: Add data-lanes
98f090f0b5fe dt-bindings: display: bridge: tc358775: make stby gpio optional
064e9e5ce2f1 arm64: dts: rockchip: Correct the model names for Pine64 boards
237ad7104aec dt-bindings: arm: rockchip: Correct the descriptions for Pine64 boards
d427a11542bc arm64: dts: rockchip: Add ArmSom Sige7 board
0eba211d362e dt-bindings: arm: rockchip: Add ArmSoM Sige7
c2f903162038 dt-bindings: vendor-prefixes: add ArmSoM
76a89655ae74 arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar
f8314a4fbc00 arm64: dts: rockchip: move uart2 pinmux to dtsi on rk3588-tiger
79943532fa1d arm64: dts: rockchip: Add USB-C Support for rk3588s-indiedroid-nova
e7af62a934e8 arm64: dts: rockchip: correct the model name for Radxa ROCK 3A
82aeee87f2b1 dt-bindings: arm: rockchip: correct the model name for Radxa ROCK 3A
03003583b4be arm64: dts: rockchip: Correct the model names for Radxa ROCK 5 boards
15e69ac796bd dt-bindings: arm: rockchip: Correct the descriptions for Radxa boards
9072fb708188 ARM: dts: qcom: msm8974: Add DTS for Samsung Galaxy S5 China (kltechn)
d69fe87f0860 ARM: dts: qcom: msm8974-klte-common: Pin WiFi board type
68af5e61e7c9 ARM: dts: qcom: msm8974: Split out common part of samsung-klte
594567bc46d5 dt-bindings: arm: qcom: Add Samsung Galaxy S5 China (kltechn)
bbd47e34ab5f Merge 6.9-rc5 into usb-next
c9ee8fc981cc Merge 6.9-rc5 into tty-next
4f761a6b1012 dt-bindings: thermal: loongson,ls2k-thermal: Fix incorrect compatible definition
a553f548d1cd dt-bindings: thermal: loongson,ls2k-thermal: Add Loongson-2K0500 compatible
288af1f42e2b dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT8188
57c07263aa4d dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT8186
6698b27c6dea dt-bindings: thermal: amlogic: add support for A1 thermal sensor
3776c6969512 dt-bindings: thermal: convert st,stih407-thermal to DT schema
bcd66b45dd34 dt-bindings: thermal: lmh: Add QCM2290 compatible
ce86f3e9490e riscv: dts: sophgo: add reserved memory node for CV1800B
846b04d066ea arm64: dts: amlogic: Add Amlogic T7 reset controller
39f26adbfa16 arm64: dts: renesas: r8a779h0: Link IOMMU consumers
d14870f832b7 arm64: dts: renesas: r8a779h0: Add IPMMU nodes
c114bd646dce arm64: dts: renesas: r8a779h0: Add INTC-EX node
67b0516ceda5 arm64: dts: renesas: r8a779h0: Add MSIOF nodes
bc619ae30078 dt-bindings: display: bridge: add sam9x75-lvds binding
dca3302106bf Merge drm/drm-next into drm-misc-next
7ce6e2097034 ASoC: dt-bindings: mt2701-wm8960: Convert to dtschema
da00fbc40e0f dt-bindings: kbuild: Split targets out to separate rules
69656e8d2d76 dt-bindings: kbuild: Simplify examples target patsubst
4e5b1058f5ef arm64: dts: st: Add interrupt parent to pinctrl on stm32mp251
fb49b549917e arm64: dts: st: Add exti1 and exti2 nodes on stm32mp251
484a80c84c86 ARM: dts: stm32: List exti parent interrupts on stm32mp131
05eba090e415 ARM: dts: stm32: List exti parent interrupts on stm32mp151
4d2f464d5eae dt-bindings: interrupt-controller: stm32-exti: Add irq mapping to parent
e59c511bbde3 dt-bindings: display: msm: sm6350-mdss: document DP controller subnode
5065723fb8b8 dt-bindings: display: msm: dp-controller: document SM6350 compatible
b9fef5367089 arm64: dts: qcom: qrb4210-rb1: add firmware-name qualifier to WiFi node
0bdead1f85d4 arm64: dts: qcom: qrb2210-rb1: add firmware-name qualifier to WiFi node
b86228aea8a3 dt-bindings: clock: support i.MX95 Display Master CSR module
e39d9c9fec9f dt-bindings: clock: support i.MX95 BLK CTL module
b47570e09314 dt-bindings: clock: add i.MX95 clock header
8a5fb2310d54 media: dt-bindings: i2c: use absolute path to other schema
970ad453bd0b media: dt-bindings: sony,imx290: Allow props from video-interface-devices
9662a8f02c4f dt-bindings: display: panel: Add Raydium RM69380
c69d47a5e76a dt-bindings: panel-simple-dsi: add Khadas TS050 V2 panel
22deef8e4842 arm64: dts: renesas: rzg3s-smarc-som: Enable eMMC by default
623a1025d410 riscv: dts: renesas: rzfive-smarc-som: Drop deleting interrupt properties from ETH0/1 nodes
874db36b90ff arm64: dts: renesas: r9a07g043: Move interrupt-parent property to common DTSI
0e066368fa42 riscv: dts: renesas: r9a07g043f: Add IRQC node to RZ/Five SoC DTSI
050fde68cb8e arm64: dts: freescale: imx8m[mp]-verdin: Update audio card name
03a997c520c4 arm64: dts: imx8mp: Enable HDMI on TQMa8MPxL/MBa8MPxL
4e5ac2e78d9b arm64: dts: imx8ulp: add caam jr
0395ab5e9103 ARM: dts: imx6: exchange fallback and specific compatible string
7cf7d11c97e8 arm64: dts: imx8mp-msc-sm2s: Add i2c{1,6} sda-/scl-gpios
c299857e7675 arm64: dts: imx8mp-msc-sm2s: correct i2c{1..6} pad drive strength
231306f6ad3a arm64: dts: imx8-ss-img: Remove JPEG clock-names
f813facbaa87 arm64: dts: freescale: imx8mm-verdin-dahlia: support sleep-moci
acab386ccefb arm64: dts: freescale: imx8mm-verdin: replace sleep-moci hog with regulator
63dc0e6ae76e arm64: dts: freescale: imx8mp-verdin-dahlia: support sleep-moci
9ccc8468709f arm64: dts: freescale: imx8mp-verdin: replace sleep-moci hog with regulator
a9571e00d3b3 Backmerge tag 'v6.9-rc5' into drm-next
df08f4f212a6 arm64: dts: imx8mn-var-som-symphony: drop redundant status from typec
d5da00ac49ef arm64: dts: imx8mm-var-som-symphony: drop redundant status from typec
737b4984fa47 arm64: dts: imx8mp-debix-som-a-bmb-08: Remove 'phy-supply' from eqos
8ff9a66b6479 arm64: dts: debix-a: Disable i2c2 in base .dts
4277d554b60b arm64: dts: imx8mm-evk: Describe the OV5640 supplies
ded973496d04 arm64: dts: imx8mn-evk: Describe the OV5640 supplies
ddde68a91a43 arm64: dts: imx8mn-evk: Fix ADV7535 dt-schema warnings
22d0352ce7a2 arm64: dts: imx8m/qxp: Pass the tcpci compatible
1f4e0bb83c90 arm64: dts: imx8mm/n remove clock-names property from usb controller node
a1e2d847e35f arm64: dts: imx93-11x11-evk: enable usb and typec nodes
2b1e53353f62 arm64: dts: imx93: add usb nodes
ef3c85188e47 arm64: dts: imx8ulp-evk: enable usb nodes and add ptn5150 nodes
6e96829c4bf3 arm64: dts: imx8ulp: add usb nodes
3f9d11d6fb6d ARM: dts: imx6: remove fsl,anatop property from usb controller node
6c316ffa4077 dt-bindings: usb: usbmisc-imx: add fsl,imx8ulp-usbmisc compatible
372c4db7e6dd ARM: dts: imx27-phytec: Add USB support
635ce5bbaaed dt-bindings: arm: fsl: Add Colibri iMX8DX
b445678b1931 dt-bindings: arm: fsl: remove reduntant toradex,colibri-imx8x
8488eb1462dd arm64: dts: freescale: Add Toradex Colibri iMX8DX
972adfe63fb1 arm64: dts: freescale: Add i.MX8DX dtsi
ad6fdd80ee3b arm64: dts: ls1028a: sl28: split variant 3/ads2 carrier
a9ce8b591785 Merge tag 'drm-misc-next-2024-04-19' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
dd3a144eda21 ASoC: PCM6240: New driver
9a99a6316892 riscv: dts: sophgo: use real clock for sdhci
c840ff2e18af arm64: dts: allwinner: Add Tanix TX1 support
b2e0faa8a675 dt-bindings: arm: sunxi: document Tanix TX1 name
792162cae91c arm64: dts: qcom: ipq6018: Add PCIe bridge node
3fa9637a2947 arm64: dts: qcom: ipq8074: Add PCIe bridge node
efa4c08d038f arm64: dts: qcom: msm8996: Add PCIe bridge node
ad5da98437f7 arm64: dts: qcom: sc8180x: Add PCIe bridge node
674f6d7f54ca arm64: dts: qcom: qcs404: Add PCIe bridge node
20e81d93a236 arm64: dts: qcom: sc7280: Add PCIe bridge node
5a5a8af96f18 arm64: dts: qcom: msm8998: Add PCIe bridge node
289c55880aee arm64: dts: qcom: sc8280xp: Add PCIe bridge node
7025014034f2 arm64: dts: qcom: sa8775p: Add PCIe bridge node
43321683cb9a arm64: dts: qcom: sm8650: Add PCIe bridge node
8f495de80b7a arm64: dts: qcom: sm8550: Add PCIe bridge node
614fb1ab653a arm64: dts: qcom: sm8450: Add PCIe bridge node
d92455378183 arm64: dts: qcom: sm8350: Add PCIe bridge node
827a7e42477f arm64: dts: qcom: sm8150: Add PCIe bridge node
53242571d01a arm64: dts: qcom: sdm845: Add PCIe bridge node
af9c05149646 arm64: dts: qcom: sm8250: Add PCIe bridge node
e5500772de61 arm64: dts: qcom: sdm845-db845c: make pcie0_3p3v_dual always-on
b3515c2998df ARM: dts: qcom: sdx55: Add PCIe bridge node
cce6533a5cbd ARM: dts: qcom: apq8064: Add PCIe bridge node
2b3b05d1c9c9 ARM: dts: qcom: ipq4019: Add PCIe bridge node
63cf887a7580 ARM: dts: qcom: ipq8064: Add PCIe bridge node
b4ee17574c35 arm64: dts: qcom: sm8450: Update SNPS Phy parameters for QRD platform
22648e1bee56 arm64: dts: qcom: sc8280xp: Fill in EAS properties
f2bd2e49960f arm64: dts: qcom: sm8650: Add three missing fastrpc-compute-cb nodes
e856db61a40f arm64: dts: qcom: sm8650-qrd: enable GPU
35f100996e20 arm64: dts: qcom: sm8650: add GPU nodes
a8ead17a3d36 arm64: dts: qcom: pm6150l: add Light Pulse Generator device node
9cc74d26a17e arm64: dts: qcom: msm8916/39-samsung-a2015: Add connector for MUIC
02e733071f05 arm64: dts: qcom: sm8250-xiaomi-elish: set pm8150b_vbus regulator-min-microamp and regulator-max-microamp
6c1a75a420ef arm64: dts: qcom: sm8650: remove useless enablement of mdss_mdp
4ce5797e3436 arm64: dts: qcom: sdx75: add unit address to soc node
9258093861eb arm64: dts: qcom: sm6350: Add DisplayPort controller
90a500593abc arm64: dts: qcom: qcs6490-rb3gen2: Enable various remoteprocs
bfd0381c5a70 arm64: dts: qcom: qcm6490-idp: Enable various remoteprocs
de9c4e5e8b56 ASoc: dt-bindings: PCM6240: Add initial DT binding
fd8694bdb0b9 spi: dt-bindings: armada-3700: convert to dtschema
c78c899c96cb ASoC: dt-bindings: nau8821: Add delay control for ADC
7b3c910a7d6d arm64: dts: qcom: sc8180x-lenovo-flex-5g: add USB-C orientation GPIOs
708d770a5a70 arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add USB-C orientation GPIOs
9e442cc8cb3c arm64: dts: qcom: sm8450-hdk: add USB-C orientation GPIO
0a661711b1ef arm64: dts: qcom: sm8350-hdk: add USB-C orientation GPIO
77c5e3ad588e dt-bindings: soc: qcom: pmic-glink: allow orientation-gpios
1aefd03e59f6 arm64: dts: qcom: qcm6490-fairphone-fp5: Add USB-C orientation GPIO
2ceae1539ae0 arm64: dts: qcom: qcm6490-idp: Name the regulators
d9102d3b2e3b arm64: dts: qcom: sa8155p-adp: lower min volt for L13C regulator
8a715b91a1c7 arm64: dts: qcom: x1e80100-qcp: Add data-lanes and link-frequencies to DP3
6bd780421531 arm64: dts: qcom: x1e80100-crd: Add data-lanes and link-frequencies to DP3
ea5e16fd9a8f arm64: dts: qcom: x1e80100: Drop the link-frequencies from mdss_dp3_in
62eb2be767ab dt-bindings: iio: dac: add docs for AD9739A
d03d8d312e65 dt-bindings: iio: dac: add docs for AXI DAC IP
7cba578ebc5b dt-bindings: iio: adc: Add GPADC for Allwinner H616
9c6368e9206d dt-bindings: firmware: Support SCMI pinctrl protocol
b90eb90ea59b dt-bindings: display: add #sound-dai-cells property to rockchip inno hdmi
e60c6ed27ba8 dt-bindings: display: add #sound-dai-cells property to rockchip rk3066 hdmi
9184fbd7f9c0 dt-bindings: display: add #sound-dai-cells property to rockchip dw hdmi
2447c9c646f9 media: dt-bindings: nxp,imx8-isi: Refuse port@1 for single pipeline models
8f23b15184a2 arm64: dts: hisilicon: hi6220: correct tsensor unit addresses
c74ffcb584df arm64: dts: hisilicon: hi6220-hikey: drop unit addresses from fixed regulators
ea691e292404 arm64: dts: hisilicon: hi6220-hikey: add missing port@0 reg
ab6c144490e2 arm64: dts: hisilicon: hip07: correct unit addresses
46ce6c6b3ced arm64: dts: hisilicon: hip07: move non-MMIO node out of soc
0f4e57316446 arm64: dts: allwinner: h616: enable DVFS for all boards
3eab0acf4dc6 arm64: dts: allwinner: h616: Add CPU OPPs table
4451e3f41280 dt-bindings: opp: Describe H616 OPPs and opp-supported-hw
80780ee52ad0 dt-bindings: net: pse-pd: Add bindings for TPS23881 PSE controller
39f7f40b60e2 dt-bindings: net: pse-pd: Add bindings for PD692x0 PSE controller
e1d12a2e6d7b dt-bindings: net: pse-pd: Add another way of describing several PSE PIs
0fab9829ac44 dt-bindings: panel: Add LG SW43408 MIPI-DSI panel
ca2684c1c09a ASoC: dt-bindings: tegra20-das: Convert to schema
fffcea9cfd96 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
10901064860d dt-bindings: net: wireless: ath11k: add ieee80211-freq-limit property
3b3e27060fa4 dt-bindings: iommu: Add Qualcomm TBU
7fb1e0c3b046 dt-bindings: input: qcom,pm8xxx-vib: add new SPMI vibrator module
4d9de260623d dt-bindings: rtc: convert trivial devices into dtschema
5b5dad161413 dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema
5e83626c68b1 dt-bindings: rtc: pxa-rtc: convert to dtschema
2e201b1cc9a9 dt-bindings: display: simple: Document support for Innolux G121XCE-L01
f8cb949a406d dt-bindings: pinctrl: qcom,pmic-mpp: add support for PM8901
b595893b51c4 ARM: dts: BCM5301X: remove earlycon on ASUS RT-AC3100 and ASUS RT-AC88U
6dd340cd11ca ARM: dts: BCM5301X: remove duplicate compatible on ASUS RT-AC3100 & AC88U
624473a5acb2 ARM: dts: BCM5301X: provide address for SoC MACs on ASUS RT-AC3100 & AC88U
7890a8b5ff01 ARM: dts: BCM5301X: use color and function on ASUS RT-AC3100 and RT-AC88U
22b146adfde1 spi: renesas,sh-msiof: Add r8a779h0 support
7ba9de6ac529 ASoC: dt-bindings: fsl-esai: Add ref: dai-common.yaml
c67e24d41931 ASoC: dt-bindings: fsl-esai: Remove 'fsl,*' from required list
7ea6e214feb6 dt-bindings: net: nxp,dwmac-imx: allow nvmem cells property
77270e20c8ca Add bridged amplifiers to cs42l43
88bd2ae39b93 dt-bindings: rtc: Add Epson RX8111
fdd26ceb0ac4 dt-bindings: remoteproc: Add Tightly Coupled Memory (TCM) bindings
d1a1f0026e6f dt-bindings: timer: renesas,tmu: Add R-Car V4M support
029854351396 dt-bindings: timer: renesas,cmt: Add R-Car V4M support
66a2a0d705dd ASoC: dt-bindings: mt8186: Document audio-routing and dai-link subnode
7620d2403dce ASoC: dt-bindings: mt8192: Document audio-routing and dai-link subnode
47c9a52cce50 ASoC: dt-bindings: mt8195: Document audio-routing and dai-link subnode
3bf78bb5cc88 dt-bindings: arm: qcom,coresight-tpda: fix indentation in the example
53869a4bf3ee dt-bindings: arm: qcom,coresight-tpda: drop redundant type from ports
8c7997fd282d arm64: dts: qcom: Add SM8550 Xperia 1 V
3b5767aa3c6b arm64: dts: qcom: sm8550: Mark DWC3 as dma-coherent
a9ff394b4128 arm64: dts: qcom: sm8550: Add missing DWC3 quirks
433ab5edb4df arm64: dts: qcom: sm8550: Mark APPS SMMU as dma-coherent
833ee79f0fa1 arm64: dts: qcom: sm8550: Mark QUPs and GPI dma-coherent
8bf4246f2516 dt-bindings: arm: qcom: Add Xperia 1 V
793d53285155 ASoC: dt-bindings: fsl-asoc-card: Add compatbile string for wm8904 codec
29c05c4fef59 ARM: dts: sun5i: Add PocketBook 614 Plus support
02911b69b54c dt-bindings: arm: sunxi: Add PocketBook 614 Plus
c3bc81c454e7 arm64: dts: allwinner: h616: Fix I2C0 pins
9dbf17fb46ed arm64: dts: allwinner: a64: Run GPU at 432 MHz
065337b68a65 arm: dts: allwinner: drop underscore in node names
11e006da2c2b arm64: dts: allwinner: Orange Pi: delete node by phandle
142edd589c5c arm64: dts: allwinner: drop underscore in node names
42cbbd959064 arm64: dts: allwinner: Pine H64: correctly remove reg_gmac_3v3
b819040dd5fd arm64: dts: allwinner: pinephone: add multicolor LED node
ccb22b1e8596 arm64: dts: allwinner: pinephone: Retain LEDs state in suspend
3ec5c145b84f dt-bindings: firmware: arm,scmi: Update examples for protocol@13
fc1542cb9848 riscv: dts: starfive: visionfive 2: Remove non-existing I2S hardware
849cce26716d riscv: dts: starfive: visionfive 2: Remove non-existing TDM hardware
c8eb0c3a74ec dt-bindings: leds: Add LED_FUNCTION_FNLOCK
2e58ac425d2a dt-bindings: mtd: fixed-partition: Add binman compatibles
7260163a815f dt-bindings: mtd: fixed-partitions: Add alignment properties
fe3814a394e7 arm64: dts: renesas: s4sk: Fix ethernet0 alias
e23a71d01d46 mips: dts: ralink: mt7621: reorder the attributes of the root node
24b391a21bdc mips: dts: ralink: mt7621: reorder pci?_phy attributes
4ae4e7293603 mips: dts: ralink: mt7621: reorder pcie node attributes and children
3f3dfc4236a2 mips: dts: ralink: mt7621: reorder ethernet node attributes and kids
bfb4c4833169 mips: dts: ralink: mt7621: reorder gic node attributes
1f0f3bc19c21 mips: dts: ralink: mt7621: reorder mmc node attributes
a5e2998183bb mips: dts: ralink: mt7621: move pinctrl and sort its children
6f444a119795 mips: dts: ralink: mt7621: reorder spi0 node attributes
fca30a7535b1 mips: dts: ralink: mt7621: reorder i2c node attributes
a540f9b8ec03 mips: dts: ralink: mt7621: reorder gpio node attributes
0835fe77afc5 mips: dts: ralink: mt7621: reorder sysc node attributes
e07a025b5975 mips: dts: ralink: mt7621: reorder mmc regulator attributes
2dcf68a0bcf7 mips: dts: ralink: mt7621: reorder cpuintc node attributes
ca0c18c23fa8 mips: dts: ralink: mt7621: reorder cpu node attributes
053249b6d5ec ASoC: dt-bindings: renesas,rsnd: add missing renesas,rcar_sound-gen4
1d87f8890aa8 ASoC: dt-bindings: renesas: add R8A779H0 V4M
f4d04690315a ASoC: dt-bindings: fsl-asoc-card: Document fsl,imx25-pdk-sgtl5000
55ae66772efa dt-bindings: iio: imu: add icm42688 inside inv_icm42600
fdfa8d1b35b9 dt-bindings: iio: imu: mpu6050: Improve i2c-gate disallow list
8ba514ee5b82 dt-bindings: phy: rockchip,pcie3-phy: add rockchip,rx-common-refclk-mode
440bd54eb270 arm64: dts: hisilicon: hip06: correct unit addresses
5741ae4cfabd arm64: dts: hisilicon: hip06: move non-MMIO node out of soc
5615c8589bf6 arm64: dts: hisilicon: hip05-d02: correct local-bus unit addresses
1c584edd5307 arm64: dts: hisilicon: hip05: move non-MMIO node out of soc
69456ffa148e dt-bindings: serial: fsl-linflexuart: add compatible for S32G3
671a5f693eb0 dt-bindings: PCI: ti,j721e-pci-host: Add support for J722S SoC
4f2091cdb0b3 dt-bindings: PCI: rcar-pci-host: Add missing IOMMU properties
507490f1d073 dt-bindings: PCI: ti,j721e-pci-host: Add device-id for TI's J784S4 SoC
402af187821d arm64: dts: rockchip: add lower USB3 port to rock-5b
c233f1327b04 arm64: dts: rockchip: add upper USB3 port to rock-5a
b8109b201486 arm64: dts: rockchip: add USB3 to rk3588-evb1
c7ed588e14f7 arm64: dts: rockchip: add USB3 DRD controllers on rk3588
5110caca9865 arm64: dts: rockchip: add USBDP phys on rk3588
f6835a60a8a2 arm64: dts: rockchip: reorder usb2phy properties for rk3588
5a3e46384924 arm64: dts: rockchip: fix usb2phy nodename for rk3588
ca27a06eb38e arm64: dts: add support for A5 based Amlogic AV400
2868f52a63b2 arm64: dts: add support for A4 based Amlogic BA400
1323400c1680 dt-bindings: serial: amlogic,meson-uart: Add compatible string for A4
951cf87f261f dt-bindings: arm: amlogic: add A5 support
4d21ea87f93a dt-bindings: arm: amlogic: add A4 support
3230ebde1f40 arm64: dts: meson: fix S4 power-controller node
42d59356df34 dt-bindings: phy: add rockchip usbdp combo phy document
2b5e4f248bf1 dt-bindings: phy: mediatek,mt7988-xfi-tphy: add new bindings
f0ba52b92b91 dt-bindings: leds: leds-qcom-lpg: Add support for PMI8950 PWM
9d3514916b43 dt-bindings: leds: Add LED_FUNCTION_SPEED_* for link speed on LAN/WAN
da14d6d29c69 dt-bindings: leds: Add LED_FUNCTION_MOBILE for mobile network
18a65e58e997 dt-bindings: leds: qcom-lpg: Document PM6150L compatible
aff549a2c519 dt-bindings: leds: pca963x: Convert text bindings to YAML
8a42a5a7094a dt-bindings: pinctrl: qcom,pmic-gpio: Allow gpio-hog nodes
4d88755d4f02 dt-bindings: pinctrl: mediatek: mt7622: add "gpio-ranges" property
58a4d54d07ea dt-bindings: crypto: Add Tegra Security Engine
9875df0acad4 dt-bindings: clocks: stm32mp25: add description of all parents
f79ff26e4bd9 arm64: dts: qcom: sc7180: Fix UFS PHY clocks
0f1da974f0c6 ASoC: dt-bindings: imx-audio-spdif: convert to YAML
969d92103dca Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
720c248f51d0 arm64: dts: rockchip: Add RTC to Khadas Edge 2
f766df51c087 arm64: dts: rockchip: Add UART9 (bluetooth) to Khadas Edge 2
8f965606dbf4 dt-bindings: usb: mtk-xhci: add compatible for MT7988
c0fe192cdc06 riscv: dts: sophgo: cv18xx: Add i2c devices
38d466fa7c5f riscv: dts: sophgo: cv18xx: Add spi devices
6f3a52a619b6 riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
be0d967b9b51 dt-bindings: clock: loongson2: Add Loongson-2K2000 compatible
d7fd32f4c1c5 dt-bindings: clock: loongson2: Add Loongson-2K0500 compatible
1b502771fcfe dt-bindings: clock: Add Loongson-2K expand clock index
d43c45938c89 riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
54a73d7ee90b dt-bindings: clock: sophgo: Add clock controller of SG2000 series SoC
4ddda6ec89e3 Merge tag 'drm-misc-next-2024-04-10' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
59f5b90f6022 dt-bindings: clock: airoha: add EN7581 binding
af199d083c8c spi: dt-bindings: cdns,qspi-nor: make cdns,fifo-depth optional
f30a682bbd33 spi: dt-bindings: cdns,qspi-nor: add mobileye,eyeq5-ospi compatible
37f288f24b0c spi: dt-bindings: cdns,qspi-nor: sort compatibles alphabetically
15d4829cc09c media: dt-bindings: ovti,ov2680: Document link-frequencies
44205d76c574 media: dt-bindings: ovti,ov2680: Fix the power supply names
ea8981faa277 arm64: dts: amlogic: meson-g12b-bananapi-cm4: add support for MNT Reform2 with CM4 adaper
5a1cbb4c0781 arm64: meson: khadas-vim3l: add TS050 DSI panel overlay
33dcd812c5a2 arm64: meson: g12-common: add the MIPI DSI nodes
ac04088b017d dt-bindings: arm: amlogic: Document the MNT Reform 2 CM4 adapter with a BPI-CM4 Module
dcee52585ed7 arm64: dts: rockchip: Add SFC to Khadas Edge 2
e7a0bbef632c arm64: dts: rockchip: Add saradc and adc buttons to Khadas Edge 2 and enable tsadc
92bc0044a770 arm64: dts: rockchip: Add ir receiver and leds to Khadas Edge 2
0fb94e0aab08 arm64: dts: rockchip: USB2, USB3 Host, PCIe2 to Khadas Edge 2
682be859d514 arm64: dts: rockchip: Add TF card to Khadas Edge 2
5fcf64705741 arm64: dts: rockchip: Add PMIC to Khadas Edge 2
7251ac880143 arm64: dts: rockchip: Add cpu regulators and vcc5v0_sys to Khadas Edge 2
e5703403d444 arm64: dts: rockchip: Add GameForce Chi
f2f6ff697daf dt-bindings: arm: rockchip: Add GameForce Chi
9a13e1d1b045 arm64: dts: rockchip: Correct model name for Powkiddy RK3566 Devices
960030a2a423 arm64: dts: rockchip: Add chasis-type for Powkiddy rk3566 devices
2c8eed296597 arm64: dts: rockchip: Correct model name for Anbernic RGxx3 Devices
1e85e8b5fdd1 arm64: dts: rockchip: Add optional node for chasis-type on Anbernic rgxx3
f2045fdbf661 arm64: dts: rockchip: Add additional properties for WiFi on Anbernic rgxx3
7b7e52f7abec ARM: dts: ti: omap: minor whitespace cleanup
b2fa1da44ce6 ARM: dts: dra7: Use clksel binding for CTRL_CORE_SMA_SW_0
26f6b88d1c9c ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_USB
bc435f2521cf ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_PER
caea03c338a4 ARM: dts: dra7: Use clksel binding for CM_CLKSEL_ABE_PLL_SYS
b7ba991cfdff ARM: dts: dra7: Use clksel binding for CM_CLKSEL_CORE
b8006e1af631 ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_EVE
fb6f236fa294 ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_GMAC
4d8ea002f614 ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_DRR
6d2b77fb6552 ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_GPU
abc35a440788 ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_IVA
bfcc3d449bb0 ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_DSP
308034a287af ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_CORE
428865b1e3c5 dt-bindings: reset: Define reset id used for HDMI Receiver
c826f12bdc1b dt-bindings: clock: rockchip: add USB480M_PHY mux
ac4fa51b0cf0 arm64: dts: rockchip: add Forlinx OK3588-C
6574fa6fb27f arm64: dts: rockchip: add Forlinx FET3588-C
6f20b7acc1dd dt-bindings: arm: rockchip: add Forlinx FET3588-C
c4a169d1a625 arm64: dts: rockchip: add Protonic MECSBC device-tree
a93d3a42ff73 dt-bindings: arm: rockchip: Add Protonic MECSBC board
bbf7c16f2f12 arm64: dts: rockchip: Fix ordering of nodes on rk3588s
7479504631b5 arm64: dts: ti: k3-j722s-evm: Enable eMMC support
c0c36b4c066f arm64: dts: ti: k3-{am62p,j722s}: Disable ethernet by default
467ac7adf4a7 arm64: dts: ti: k3-am642-phyboard-electra-rdk: Increase CAN max bitrate
3f507980dba5 arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Increase CAN max bitrate
f1fcbddf5d12 arm64: dts: ti: k3-am625-verdin: add PCIe reset gpio hog
e08660f3cd03 arm64: dts: ti: verdin-am62: mallow: fix GPIOs pinctrl
7f53b6864a72 arm64: dts: ti: k3-j784s4: Remove UART baud rate selection
edfda3254cd2 arm64: dts: ti: k3-j721s2: Remove UART baud rate selection
6e3f0965c6f9 arm64: dts: ti: k3-j721e: Remove UART baud rate selection
da60eaaca57a arm64: dts: ti: k3-j7200: Remove UART baud rate selection
05c6b5e8d050 arm64: dts: ti: k3-am64: Remove UART baud rate selection
c77a507ba6c8 arm64: dts: ti: k3-am65: Remove UART baud rate selection
cbd99ec0ded5 arm64: dts: ti: k3-am62-lp-sk: Remove tps65219 power-button
e4161af885fa arm64: dts: ti: k3-am625-beagleplay: Use mmc-pwrseq for wl18xx enable
ca4dbece3a24 arm64: dts: ti: verdin-am62: use SD1 CD as GPIO
dc34c139bc92 arm64: dts: ti: verdin-am62: Set memory size to 2gb
7dc3b6bf42eb arm64: dts: ti: verdin-am62: dahlia: fix audio clock
7ca6e3df2bee arm64: dts: ti: k3-am62p5-sk: minor whitespace cleanup
eab9ad4caead dt-bindings: arm: keystone: Remove ti,system-reboot-controller property
b6c265f5abae ARM: dts: ti: keystone: k2g: Remove ti,system-reboot-controller property
02d2c9f2c78b ASoC: dt-bindings: davinci-mcbsp: Add the 'ti,T1-framing-{rx/tx}' flags
a6d98f230b5f ASoC: dt-bindings: davinci-mcbsp: Add optional clock
384c2199a306 ASoC: dt-bindings: davinci-mcbsp: convert McBSP bindings to yaml schema
806eefcc02c3 dt-bindings: usb: hx3: Remove unneeded dr_mode
044e76ba8b8f dt-bindings: usb: Document the Microchip USB2514 hub
a49e9178a25e ARM: dts: qcom: msm8974-sony-shinano: Enable vibrator
ee7b6792f91d dt-bindings: serial: actions,owl-uart: convert to dtschema
176615d68b88 dt-bindings: serial: renesas,scif: Document r8a779h0 bindings
47316d6bba31 dt-bindings: net: rockchip-dwmac: use rgmii-id in example
293b58a3ce33 dt-bindings: net: Add support for AM65x SR1.0 in ICSSG
160476e49bd1 arm64: dts: renesas: rzg3s-smarc-som: Fix Ethernet aliases
11942cf0a649 Add support for QCM6490 and QCS6490
3e98916b42d5 arm64: dts: microchip: sparx5_pcb135: drop duplicated NOR flash
0cb64a6bd6df arm64: dts: microchip: sparx5_pcb134: drop duplicated NOR flash
5d7bc7bf7e93 arm64: dts: microchip: sparx5_pcb135: drop LED unit addresses
96af4c5f9543 arm64: dts: microchip: sparx5_pcb134: drop LED unit addresses
5cb4acc257b1 arm64: dts: microchip: sparx5_pcb135: align I2C mux node name with bindings
745050595c9d arm64: dts: microchip: sparx5_pcb134: align I2C mux node name with bindings
0bd7966aaaea arm64: dts: microchip: sparx5_pcb135: add missing I2C mux unit addresses
4c1d314d61f6 arm64: dts: microchip: sparx5_pcb134: add missing I2C mux unit addresses
bed9ce9bfe43 arm64: dts: microchip: sparx5: correct serdes unit address
b72c3e846fca arm64: dts: microchip: sparx5: fix mdio reg
c540b207970e Merge tag 'phy_dp_modes_6.10' into msm-next-lumag
0f5349678133 media: dt-bindings: media: camss: Add qcom,sc8280xp-camss binding
2b2d6b84ff76 ASoC: dt-bindings: ti,pcm1681: Convert to dtschema
11334704e03b ASoC: dt-bindings: qcom,sm8250: Add QCM6490 snd QCS6490 sound card
6c41e473a90c arm64: dts: renesas: r8a779h0: Add TMU nodes
e98c56d03d81 arm64: dts: renesas: r8a779h0: Add CMT nodes
4198120e44b0 arm64: dts: renesas: gray-hawk-single: Enable nfsroot
1dd5977e6963 ARM: dts: renesas: r9a06g032: Remove duplicate interrupt-parent
8ac906853ada dt-bindings: display: bridge: it6505: Add #sound-dai-cells
b6fe7929eaee arm64: dts: hi3798cv200: add cache info
8c7387ddd437 arm64: dts: hi3798cv200: add GICH, GICV register space and irq
8052d25f7a1e arm64: dts: hi3798cv200: fix the size of GICR
653b19c3d57f ARM: dts: qcom: ipq4019: add QCA8075 PHY Package nodes
8b6be7608248 ARM: dts: qcom: Add support for Motorola Moto G (2013)
db7e98d446e0 dt-bindings: arm: qcom: Add Motorola Moto G (2013)
96445ff22684 ARM: dts: qcom: msm8974: Add empty chosen node
05d778412f76 ARM: dts: qcom: msm8974: Add @0 to memory node name
c9d605588473 Merge tag 'drm-misc-next-2024-04-05' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
fd537281fdba dt-bindings: dma: fsl-edma: add fsl,imx8ulp-edma compatible string
cce5941e9ba4 dt-bindings: dma: snps,dw-axi-dmac: Add JH8100 support
738a3b006c67 dt-bindings: dma: snps,dma-spear1340: Fix data{-,_}width schema
c3af3bbb63b1 dt-bindings: iio: temperature: ltc2983: document power supply
53d5f9f34812 dt-bindings: iio: accel: adxl345: Add spi-3wire
e5fa7e7f2c22 dt-bindings: phy: samsung,ufs-phy: Add dedicated gs101-ufs-phy compatible
e64d19cedd58 dt-bindings: phy: qmp-ufs: Fix PHY clocks for SC7180
a438f4ab2395 dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: document PHY AUX clock on SM8[456]50 SoCs
938969719441 dt-bindings: bus: document ETZPC
a8c96305fde1 dt-bindings: bus: document RIFSC
a541c76dbadb dt-bindings: treewide: add access-controllers description
df2238fe396f dt-bindings: document generic access controllers
a95213693fbc dt-bindings: net: wireless: ath10k: describe firmware-name property
4c7df22d3811 dt-bindings: crypto: ti,omap-sham: Convert to dtschema
865b2895e10f Merge tag 'drm-misc-next-2024-03-28' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
cb0a8e76adc4 dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support
42e2e37be646 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
a8384c80c193 arm64: dts: qcom: qcs6490-rb3gen2: Enable UFS
c793db1a5a20 arm64: dts: qcom: sm8150-hdk: enable WiFI support
2ab678b8aee2 arm64: dts: qcom: msm8916-samsung-fortuna: Add PWM backlight
746bfcc05f14 arm64: dts: qcom: msm8916-samsung-fortuna: Add touchscreen
01cd48bf86da ARM: dts: bcm2711-rpi-4-b: Add CAM1 regulator
77679e1b04aa ARM: dts: bcm2711-rpi-cm4-io: Add RTC on I2C0
9ed20c8d8b4e ARM: dts: bcm2711-rpi: Add pinctrl-based multiplexing for I2C0
a22f4cef7a0e ARM: dts: bcm2835-rpi: Move duplicate firmware-clocks to bcm2835-rpi.dtsi
dbab66efd1fe ARM: dts: bcm283x: Drop unneeded properties in the bcm2835-firmware node
a25103cac601 dt-bindings: arm: bcm: raspberrypi,bcm2835-firmware: Add gpio child node
278bc7c104d6 Merge tag 'wireless-next-2024-04-03' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
b22ae3aceedc arm64: dts: qcom: qcs6490-rb3gen2: Enable USB Type-C display
dc9514f67bb8 arm64: dts: qcom: qcs6490-rb3gen2: Introduce USB redriver
182a42f881be arm64: dts: qcom: qcs6490-rb3gen2: Enable adsp and cdsp
551b82528068 arm64: dts: qcom: qcs6490-rb3gen2: Add DP output
62f03e427f89 arm64: dts: qcom: sc7280: Enable MDP turbo mode
b61e56afe560 arm64: dts: qcom: msm8998-yoshino: Enable RGB led
3681c0ef248f arm64: dts: qcom: msm8998-yoshino: fix volume-up key
dedf405d5ac3 arm64: dts: qcom: sdm630-nile: add pinctrl for camera key
10dbe401f578 dt-bindings: arm: qcom: Add Sony Xperia Z3
07d64e367b35 arm64: dts: qcom: apq8016-sbc: correct GPIO LEDs node names
bf07777c8527 arm64: dts: qcom: sm8650: fix usb interrupts properties
95dc0313a7c7 arm64: dts: qcom: msm8916: drop dtbTool-specific compatibles
35284c1fbbda dt-bindings: arm: qcom: drop dtbTool-specific compatibles
7a245b4e6ff3 arm64: dts: qcom: sc7280: Add inline crypto engine
5093b0473559 arm64: dts: qcom: ipq8074: Remove unused gpio from QPIC pins
a3e2ba92004a arm64: dts: qcom: sm8350: Add interconnects to UFS
478e894db4db ARM: dts: n900: set charge current limit to 950mA
7718b663820e ARM: dts: qcom: Add Sony Xperia Z3 smartphone
6e0176b32c37 ARM: dts: qcom: msm8974-sony-castor: Split into shinano-common
a9a358e1a84c arm64: dts: qcom: sc7180: Disable DCC node by default
0242960a306e arm64: dts: qcom: sc7180: Disable pmic pinctrl node on Trogdor
4f095cae545b dt-bindings: net: snps,dwmac: Align 'snps,priority' type definition
3ab6c524a275 arm64: dts: imx8dxl-evk: add lpuart1 and cm40 uart
55a66f541f3d arm64: dts: imx8dxl: update cm40 irq number information
4240cfffe385 arm64: dts: imx8dxl: add lpuart device in cm40 subsystem
b178fe955580 arm64: dts: imx8: add cm40 subsystem dtsi
7951b18254cc arm64: dts: imx8m*-venice-gw7: Fix TPM schema violations
cce04e7de644 ARM: dts: imx6sx-nitrogen6sx: drop incorrect cpu-dai property
0ee2adbc8d13 ARM: dts: imx6qdl-udoo: Enable USB host
596dae841e87 dt-bindings: net: renesas,ethertsn: Create child-node for MDIO bus
b884b5a5c311 arm64: dts: freescale: Add device tree for Emcraft Systems NavQ+ Kit
e0ca88f352a1 dt-bindings: arm: Add Emcraft Systems i.MX8M Plus NavQ+ Kit
9e173e8dfff5 dt-bindings: vendor-prefixes: Add Emcraft Systems
a32d91fda032 arm64: dts: imx8mp-venice-gw73xx: add mac addr for eth1
8655adfd5e96 arm64: dts: imx8mp-venice-gw72xx: add mac addr for eth1
f0a4a8e9c61c arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif0 and sai[4,5]
0bc3cb99ca4f arm64: dts: imx8: fix audio lpcg index
9802e7b606b0 arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery
a2e4ced9999e arm64: dts: broadcom: bcmbca: bcm4908: set brcm,wp-not-connected
ea816d0833c2 ASoC: dt-bindings: fsl-asoc-card: convert to YAML
78eb8a927ea9 ARM: dts: qcom: msm8916: idle-state compatible require the generic idle-state
af397addefe6 ARM: dts: qcom: include cpu in idle-state node names
f94dfb17f9fb arm64: dts: qcom: sc8180x: add dp_p1 register blocks to DP nodes
3a9af9495213 arm64: dts: qcom: sc8180x: Drop flags for mdss irqs
ee838a6c5dcc arm64: dts: qcom: sc8180x: drop legacy property #stream-id-cells
c10c1ac0e013 arm64: dts: S32G3: Introduce device tree for S32G-VNP-RDB3
6eeadc4c7a09 dt-bindings: arm: fsl: add NXP S32G3 board
420e1d4db0ac arm64: dts: sprd: minor whitespace cleanup
afbe017e1c78 arm64: dts: marvell: cn9130-crb: drop unneeded "status"
27c60f14e2ce arm64: dts: marvell: cn9130-crb: drop wrong unit-addresses
0911a225def4 arm64: dts: marvell: cn9130-db: drop wrong unit-addresses
5e5508e3986e arm64: dts: marvell: cn9131-db: drop unneeded flash address/size-cells
cb4ed54644d6 arm64: dts: marvell: cn9130-db: drop unneeded flash address/size-cells
280b88b82731 arm64: dts: marvell: ap80x: fix IOMMU unit address
f9977dce8137 dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G3 support
3719bc71e829 arm64: dts: freescale: verdin-imx8mp: enable Verdin I2C_3_HDMI interface
1af7cdf75167 arm64: dts: renesas: gray-hawk-single: Add second debug serial port
7788ca0900fc arm64: dts: renesas: r8a779h0: Add SCIF nodes
d2623c8e3be6 arm64: dts: renesas: r8a779h0: Add remaining HSCIF nodes
cded804626dc Merge drm/drm-next into drm-misc-next
6eaa264b03cf dt-bindings: ata: ahci-da850: Convert to dtschema
88d79ce3a5e5 ARM: dts: imx7s: Add snvs-poweroff support
4c997ef805f7 arm64: dts: imx93-11x11-evk: add pca9451a support
888dc0cbc2df arm64: dts: imx8mp: Describe CSI2 GPIO expander on i.MX8MP DHCOM PDK3 board
d473ff20ac00 ARM: dts: imx6qdl: Remove LCD.CONTRAST pinctrl from muxing
369c40d7733d ARM: dts: imx6qdl: mba6: Add missing vdd-supply for on-board USB hub
f4dead7a191d dt-bindings: crypto: ice: Document sc7280 inline crypto engine
56dbefd49c8f dt-bindings: crypto: starfive: Add jh8100 support
472dae4a9de8 arm64: dts: rockchip: Add enable-strobe-pulldown to emmc phy on ROCK 4C+
c858fbc533a6 arm64: dts: rockchip: Add enable-strobe-pulldown to emmc phy on ROCK Pi 4
fe10e00484db arm64: dts: rockchip: Enable gpu on Cool Pi 4B
498665cfe799 arm64: dts: rockchip: Enable gpu on Cool Pi CM5
f5221484d5fc dt-bindings: display: mediatek: gamma: Add support for MT8188
e978e9a88df8 dt-bindings: display: mediatek: gamma: Change MT8195 to single enum group
8c20afe51c9b arm64: dts: imx8mp-venice-gw74xx: add ADC rail for VDD_1P0
2327517eda87 dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
afb6facb38e1 arm64: dts: fsl-lx2162a-clearfog: add alias for i2c bus iic6
0de33c4d5d36 arm64: dts: fsl-lx2162a-som: add description for rtc
4d951acac66b arm64: dts: imx8mp-venice-gw74xx-imx219.dtso: fix dt warning
8e39502da89f dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk
0a7a04f0f21f arm64: dts: qcom: pm6150: correct Type-C compatible
040fb0d942d5 dt-bindings: net: airoha,en8811h: Add en8811h
ea44916fae41 dt-bindings: phy: Add QMP UFS PHY comptible for SM8475
ab4139c78dfc dt-bindings: display: Add GameForce Chi Panel
f1fac26a6eb1 dt-bindings: vendor-prefix: Add prefix for GameForce
f45b10058045 dt-bindings: rtc: nxp,lpc1788-rtc: convert to dtschema
80435727b218 dt-bindings: rtc: digicolor-rtc: move to trivial-rtc
3a5cc7be0c7b dt-bindings: rtc: alphascale,asm9260-rtc: convert to dtschema
93c7f99067be dt-bindings: rtc: armada-380-rtc: convert to dtschema
c94bf886da99 dt-bindings: gpio: mpfs: allow gpio-line-names
c8baf5586aad dt-bindings: gpio: mpfs: add coreGPIO support
edc3a8d8ba1f arm64: dts: mba8mx: Simplify DSI connection
41c630a79684 arm64: dts: imx8mp: Add empty DSI output endpoint
a9335ab9220f arm64: dts: imx8mq: Add empty DSI output endpoint
586e5a25a66f arm64: dts: imx8mn: Add empty DSI output endpoint
d3dd47002ba3 arm64: dts: imx8mm: Add empty DSI output endpoint
b0a66bbba940 dt-bindings: arm: fsl: Add Seeed studio NPi based boards
7749c950e2bc ARM: dts: imx6ull: add seeed studio NPi dev board
7943ba91b906 arm64: dts: imx8mp-evk: Add PDM micphone sound card support
06a171a12071 arm64: dts: imx8mp-evk: Add HDMI audio sound card support
2613e0628be4 arm64: dts: imx8mp: Add AUD2HTX device node
dcea262c34c5 arm64: dts: imx8mp: add HDMI display pipeline
0798e51bdfef arm64: dts: imx8mp: add HDMI irqsteer
5589301efbf2 arm64: dts: imx8mp: add HDMI power-domains
9625814a32d8 arm64: dts: imx8qm-mek: add flexspi0 support
dddebc9a4ac6 arm64: dts: imx8qm-mek: add lpspi2 support
4930bc1ea48d arm64: dts: imx8qm-mek: add adc0 support
8eacd31e7a6a ASoC: nau8325: Modify driver code and dtschema.
f1ad0b85186a dt-bindings: net: renesas,etheravb: Add optional MDIO bus node
a5a3c74a517b dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles
1543b9407d26 dt-bindings: phy: qcom,snps-eusb2-repeater: Add compatible for SMB2360
dab9bf513c3c dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
4e40c99fdc79 ASoC: dt-bindings: fsl-sai: allow only one dma-names
5b46a81c6968 ASoC: dt-bindings: fsl,imx-asrc: update max interrupt numbers
445e331ff3bf ASoC: dt-bindings: fsl,imx-asrc/spdif: Add power-domains property
3b1042cca37a ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
51ee560e525e Merge branch 'drivers-for-6.10' onto 'v6.9-rc1'
a35fffea6e63 Merge branch 'arm32-for-6.10' onto 'v6.9-rc1'
d7a604efcfff Merge branch 'arm64-for-6.10' onto 'v6.9-rc1'
327ae5bf1f59 ARM: dts: imx: Add UNI-T UTi260B thermal camera board
306baafa6a09 dt-bindings: iio: dac: ti,dac5571: Add DAC081C081 support
3b48c1d3c266 dt-bindings: iio: health: maxim,max30102: add max30101
8e51b5f81bbc regulator: Merge axp20x changes
92b923457899 arm64: dts: imx93: drop the 4th interrupt for ADC
988c0a839304 arm64: dts: exynos: gs101: define all PERIC USI nodes
8f2d90d346a3 arm64: dts: exynos: gs101: join lines close to 80 chars
f9cf983ea270 arm64: dts: exynos: gs101: move pinctrl-* properties after clocks
45b6f1d37e46 arm64: dts: exynos: gs101: move serial_0 pinctrl-0/names to dtsi
a44ccb984946 arm64: dts: exynos: gs101: reorder pinctrl-* properties
1b8507673dc6 dt-bindings: mfd: x-powers,axp152: Document AXP717
38fcf9ba7bee dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIH0108 and PMD8028 support
0024b304ddf8 dt-bindings: pinctrl: qcom,pmic-gpio: Add PMXR2230 and PM6450 support
d7efce546cb5 dt-bindings: pinctrl: qcom: update functions to match with driver
9148be037372 ARM: dts: imx6: fix IRQ config of RC5T619
16507be93058 ARM: dts: imx6sl: tolino-shine2hd: fix IRQ config of touchscreen
d6440887039f arm64: dts: s32g: add uSDHC node
6aa1628f3dc5 arm64: dts: s32g: add SCMI firmware node
27350b241eaf arm64: dts: rockchip: enable gpu on rk3588-tiger
b71ce0df337d arm64: dts: rockchip: enable gpu on rk3588-jaguar
496e9d7ae24e arm64: dts: rockchip: Enable the GPU on quartzpro64
2ed4a6a8bc1e arm64: dts: rockchip: Enable GPU on rk3588-evb1
3bb62f4be1c6 arm64: dts: rockchip: Enable GPU on rk3588-rock5b
3cd15354ea0c arm64: dts: rockchip: Add rk3588 GPU node
b3e4bfc4243f riscv: dts: sophgo: add sdcard support for milkv duo
5f3996b7ea4d ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500 voice processor
929e424ec8a3 dt-bindings: usb: ci-hdrc-usb2-imx: add compatible and clock-names restriction for imx93
79799e37204e dt-bindings: usb: ci-hdrc-usb2-imx: add restrictions for reg, interrupts, clock and clock-names properties
81199deccd71 dt-bindings: usb: chipidea,usb2-imx: move imx parts to dedicated schema
f5036776ca4c arm64: dts: renesas: r9a07g0{43,44,54}: Update RZ/G2L family compatible
d082f610f125 dt-bindings: usb: renesas,usbhs: Document RZ/G2L family compatible
df34e7029805 dt-bindings: usb: dwc2: Add support for Sophgo CV18XX/SG200X series SoC
afe511c842cf riscv: dts: starfive: Remove PMIC interrupt info for Visionfive 2 board
62bda7500065 arm64: dts: rockchip: add wolfvision pf5 io expander board
2a4fc9a444b8 arm64: dts: rockchip: add wolfvision pf5 mainboard
6647f171f526 dt-bindings: arm: rockchip: add wolfvision pf5 mainboard
d47821a0a35a dt-bindings: add wolfvision vendor prefix
2a0ec4275f4e arm64: dts: rockchip: add the internal audio codec on rk3308
89bd9d5e4595 arm64: dts: rockchip: add i2s_8ch_2 and i2s_8ch_3 to rk3308
abf445165722 ASoC: dt-bindings: Add Rockchip RK3308 internal audio codec
d36a3550564f dt-bindings: usb: qcom,pmic-typec: Add support for the PM7250B PMIC
2bf3077e9cbf ARM: dts: exynos4212-tab3: limit usable memory range
7b222b83561f dt-bindings: clock: samsung,s3c6400-clock: convert to DT Schema
789cf6e0effe arm64: dts: exynos850: Add CPU clocks
b55ecc9e7140 dt-bindings: arm: renesas: Document Renesas RZ/V2H(P) System Controller
9f361e51112e dt-bindings: soc: renesas: Document Renesas RZ/V2H(P) SoC variants
5719a653a110 dt-bindings: clock: r9a07g043-cpg: Annotate RZ/G2UL-only core clocks
7d45be7e768a ARM: dts: renesas: rcar-gen2: Add TMU nodes
dbc57bd145b3 ARM: dts: renesas: rzg1: Add TMU nodes
c3d60a152ae8 ARM: dts: renesas: r8a73a4: Add TMU nodes
2e4c1a66fafa ARM: dts: renesas: r7s72100: Add interrupt-names to SCIF nodes
b4be2647b4e8 arm64: dts: renesas: r8a779h0: Add thermal nodes
345aee5488c1 arm64: dts: renesas: rzg2ul-smarc: Enable PMIC and built-in RTC, GPIO and ONKEY
425305f138c3 arm64: dts: renesas: eagle: Add capture overlay for Function expansion board
188c483e94e5 arm64: dts: amd: use capital "OR" for multiple licenses in SPDX
4dab93ec6c61 dt-bindings: display: atmel,lcdc: convert to dtschema
7463d00b8f15 dt-bindings: display: samsung,exynos5-dp: convert to DT Schema
9b0c1b5a1716 ASoC: dt-bindings: wm8974: Convert to dtschema
1c025f7d15ee dt-bindings: iio: humidity: hdc3020: add reset-gpios
be159891a4ff dt-bindings: iio: adc: add ad7944 ADCs
f6aa2ab198a4 dt-bindings: adc: ad7173: add support for additional models
5a639055d658 dt-bindings: iio: light: Avago APDS9306
ee5a13477d19 dt-bindings: iio: light: adps9300: Update interrupt definitions
691301ccf359 dt-bindings: iio: light: adps9300: Add missing vdd-supply
571d2039cd1c dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas
7bead03d0aba dt-bindings: adc: add AD7173
d6e93a75ded2 dt-bindings: memory-controllers: add Samsung S5Pv210 SoC DMC
55da87105117 ASoC: dt-bindings: fsl-esai: Convert fsl,esai.txt to yaml
eff45c6d35c4 dt-bindings: interrupt-controller: Add RISC-V advanced PLIC
69c7a13d4212 dt-bindings: interrupt-controller: Add RISC-V incoming MSI controller
68d4ea2b8cd9 arm64: dts: juno: fix thermal zone node names
434ab11df259 arm64: dts: qcom: acer-aspire1: Add embedded controller
0797ae7b740c add pmic pca9451a support
54343f31f307 dt-bindings: platform: Add Acer Aspire 1 EC
4c81dc2d23b6 ASoC: dt-bindings: wm8776: Convert to dtschema
2b51560a8ea7 ASoC: dt-bindings: fsl-audmix: Convert fsl,audmix.txt to yaml
5490b8fbf354 ARM: dts: samsung: s5pv210: specify the SPI FIFO depth
1c900dc6bb0b arm64: dts: exynosautov9: specify the SPI FIFO depth
e8db30df09da arm64: dts: exynos5433: specify the SPI FIFO depth
6a732879ab41 ARM: dts: samsung: exynos5420: specify the SPI FIFO depth
0c2483409c87 ARM: dts: samsung: exynos5250: specify the SPI FIFO depth
4c973cc8efc9 ARM: dts: samsung: exynos4: specify the SPI FIFO depth
327544b79bca ARM: dts: samsung: exynos3250: specify the SPI FIFO depth
1b9ae7d233ad ARM: dts: samsung: s5pv210: correct onenand size-cells
4a9e7d085593 ARM: dts: samsung: s5pv210: align onenand node name with bindings
7d94a29a5e01 ARM: dts: samsung: exynos5800-peach-pi: switch to undeprecated DP HPD GPIOs
a2945eda660b ARM: dts: samsung: smdk4412: align keypad node names with dtschema
83cece56e84a ARM: dts: samsung: smdk4412: fix keypad no-autorepeat
29ca51c6ed42 ARM: dts: samsung: exynos4412-origen: fix keypad no-autorepeat
ef68e20c1971 ARM: dts: samsung: smdkv310: fix keypad no-autorepeat
6c72c6cfd3b0 dt-bindings: pinctrl: samsung: drop unused header with register constants
3582d8d1b12b dt-bindings: display: sony, td4353-jdi: allow width-mm and height-mm
aa41927d40d5 dt-bindings: display: novatek, nt36523: define ports
d0a5ed63a9b4 dt-bindings: display: novatek, nt35950: define ports
b18825292b5e dt-bindings: display: panel: add common dual-link schema
b0119d5c5ded dt-bindings: mtd: Add Samsung S5Pv210 OneNAND
a50db9557152 dt-bindings: ata: imx-pata: Convert to dtschema
c60378219a91 dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM7250B compatible
3c442a288b7a regulator: dt-bindings: pca9450: add pca9451a support
0eff9a5ea493 arm64: dts: rockchip: Add cache information to the SoC dtsi for RK356x
ae73daab1bff arm64: dts: rockchip: Add cache information to the SoC dtsi for RK3328
61c45b58ad54 dt-bindings: display: simple: Add POWERTIP PH128800T-006-ZHC01 panel
abe40fd3b82a dt-bindings: ili9881c: Add Startek KD050HDFIA020-C020A support
305c9423fbea arm64: dts: qcom: qcm6490-idp: enable PMIC Volume and Power buttons
f642104215e7 ARM: dts: qcom: msm8974pro-castor: Rename wifi node name
bc29c79df022 ARM: dts: qcom: msm8974pro-castor: Add debounce-interval for keys
de408637e1e8 ARM: dts: qcom: msm8974pro-castor: Remove camera button definitions
0a68603019c1 ARM: dts: qcom: msm8974pro-castor: Add mmc aliases
5974cacdc88e ARM: dts: qcom: msm8974pro-castor: Clean up formatting
d7995795b4c6 arm64: dts: qcom: sm8650: Add missing reserved memory for chipinfo
0cc1a4157b71 arm64: dts: qcom: qrb2210-rb1: enable USB-C port handling
f2e5ede0f26a arm64: dts: qcom: ipq8074: Add QUP UART6 node
337090a813d8 arm64: dts: qcom: x1e80100-qcp: Add repeater nodes
42143270e41c arm64: dts: qcom: x1e80100-crd: Add repeater nodes
e49e3457b223 arm64: dts: qcom: x1e80100: Add dedicated pmic dtsi
43392fe521c7 arm64: dts: qcom: x1e80100: Add SPMI support
509352a15f4e arm64: dts: qcom: pm6150: define USB-C related blocks
39818e89c180 arm64: dts: qcom: sdm632-fairphone-fp3: enable USB-C port handling
cf3fbd0a3e6f arm64: dts: qcom: sm6350: Add Crypto Engine
03971dc4b142 arm64: dts: qcom: sc8280xp: Add missing hs_phy_irq in USB nodes
994ee3be0ac7 arm64: dts: qcom: sc8180x-lenovo-flex-5g: Allow UFS regulators load/mode setting
bf0c74cbaf81 arm64: dts: qcom: sc8180x-lenovo-flex-5g: set touchpad i2c frequency to 1 MHz
1da9c05605df arm64: dts: qcom: sc8180x-lenovo-flex-5g: move pinctrl to appropriate nodes
2139a6179bc6 arm64: dts: qcom: sc8180x-lenovo-flex-5g: set names for i2c hid nodes
5e67d6fe2590 arm64: dts: qcom: sc8180x-lenovo-flex-5g: fix GPU firmware path
29c532902fbe dt-bindings: soc: qcom: qcom,pmic-glink: document QCM6490 compatible
4ef050954490 arm64: dts: qcom: sdm670-google-sargo: add panel
4d57d77db758 arm64: dts: qcom: sm8650: add missing qcom,non-secure-domain property
5beeaab6947e arm64: dts: qcom: sm8550: add missing qcom,non-secure-domain property
6c08285503d5 arm64: dts: qcom: sm8450: add missing qcom,non-secure-domain property
6e81e9a45081 arm64: dts: qcom: qcs6490-rb3gen2: Name the regulators
b51adcfa5e4e arm64: dts: qcom: x1e80100-crd: switch WSA8845 speakers to shared reset-gpio
f56199dc0b4c arm64: dts: qcom: x1e80100: correct SWR1 pack mode
e407c51a9192 arm64: dts: qcom: qcm2290: Add LMH node
78ea7fd8529a arm64: dts: qcom: sc8280xp: Describe TCSR download mode register
ed0e06b772a0 arm64: dts: qcom: sc8280xp: Add PS_HOLD restart
653f5ac8c56d arm64: dts: qcom: sc8280xp: Add QFPROM node
8b113929cba4 arm64: dts: qcom: sm8250-xiaomi-elish: add usb pd negotiation support
ef34967aa707 arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe
5ad7aff41781 arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
c9c36fd3c3e4 arm64: dts: qcom: sc8280xp: Add missing LMH interrupts
9c5ddaa54576 arm64: dts: qcom: qcm6490-idp: add display and panel
b5fbaf38d7c9 dt-bindings: arm: qcom,ids: Add SoC ID for X1E80100
a3d157706fb0 dt-bindings: display: simple: add support for Crystal Clear CMT430B19N00
cf6cd5bc0bde dt-bindings: Add Crystal Clear Technology vendor prefix
111bd9344cc1 dt-bindings: net: wireless: brcm,bcm4329-fmac: Add CYW43439 DT binding
f51fde39203a dt-bindings: display/lvds-codec: add ti,sn65lvds94
d60610231ef6 Merge drm/drm-next into drm-misc-next
4c258740e5ce dt-bindings: gpu: mali-valhall-csf: Add support for Arm Mali CSF GPUs
26231fa0490c dt-bindings: display: panel-simple-dsi: add s6e3fa7 ams559nk06 compat

git-subtree-dir: dts/upstream
git-subtree-split: 20e0f0897ea26981d3127511c150dd56c5296d50
---
This is the result of re-running the sync script, and doing two quick
fixes (accepting the Makefile merge, copying over the kernel v6.10
arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi file rather than merge it
by hand.

Cc: "Cogent Embedded, Inc." <source@cogentembedded.com>
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Akash Gajjar <gajjar04akash@gmail.com>
Cc: Alexandre Vicenzi <linux@alxd.me>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Andrew Davis <afd@ti.com>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Apurva Nandan <a-nandan@ti.com>
Cc: Banglang Huang <banglang.huang@foxmail.com>
Cc: Ben Schneider <ben@bens.haus>
Cc: Beniamino Galvani <b.galvani@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Bryan Brattlof <bb@ti.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Chris Morgan <macromorgan@hotmail.com>
Cc: Christian Hewitt <christianshewitt@gmail.com>
Cc: Christopher Obbard <chris.obbard@collabora.com>
Cc: Dave Purdy <david.c.purdy@gmail.com>
Cc: David Bauer <mail@david-bauer.net>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Evgeni Dobrev <evgeni@studio-punkt.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>
Cc: Fabio Estevm <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Frank Wunderlich <frank-w@public-files.de>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Jason Cooper <u-boot@lakedaemon.net>
Cc: Jayesh Choudhary <j-choudhary@ti.com>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: John Clark <inindev@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Joseph Chen <chenjh@rock-chips.com>
Cc: Joshua Riek <jjriek@verizon.net>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Klaus Goger <klaus.goger@cherry.de>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Levin Du <djw@t-chip.com.cn>
Cc: Loic Devulder <ldevulder@suse.com>
Cc: Luka Perkov <luka@openwrt.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Michael Walle <michael@walle.cc>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nick Xie <nick@khadas.com>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Otavio Salvador <otavio@ossystems.com.br>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Robert Nelson <robertcnelson@gmail.com>
Cc: Sam Day <me@samcday.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Sebastian Kropatsch <seb-dev@mail.de>
Cc: Siddarth Gore <gores@marvell.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Simon Guinot <simon.guinot@sequanux.org>
Cc: Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>
Cc: Stefan Roese <sr@denx.de>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Suniel Mahesh <sunil@amarulasolutions.com>
Cc: Teresa Remmet <t.remmet@phytec.de>
Cc: Tianling Shen <cnsztl@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tim Lunn <tim@feathertop.org>
Cc: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc: Tony Dinh <mibodhi@gmail.com>
Cc: Vaishnav Achath <vaishnav.a@ti.com>
Cc: Viacheslav Bocharov <adeep@lexina.in>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Wadim Egorov <w.egorov@phytec.de>
Cc: Walter Schweizer <swwa@users.sourceforge.net>
Cc: Xiaobo Tian <peterwillcn@gmail.com>
Cc: u-boot-amlogic@groups.io
Cc: u-boot-qcom@groups.io

