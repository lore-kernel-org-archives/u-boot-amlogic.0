Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.5849.1607560067649689249
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Dec 2020 16:27:47 -0800
Received: by mail-wr1-f68.google.com with SMTP id a12so3648952wrv.8
        for <u-boot-amlogic@groups.io>; Wed, 09 Dec 2020 16:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:from:in-reply-to:references:date:message-id
         :subject:to:cc;
        bh=QVgM92hyOMMtKWkW+99PobPreldMLqTTDyusyET3LM0=;
        b=iNl3mCcYcOB1nCPJ2f8iXDtdHBPrsCit4u0+bXFkte8Gq3D+BgLSWmtL5E7YGsjP9d
         nYXy2lt8j+s9E68JqODSbqI5PmM1lYZLY+PmmG+97OtbJliASX3nFwqzd83Iy7bT6ARy
         kw0TM45RH0pu2FaoVu7/dqPV/p4aERc3kMmqE=
MIME-Version: 1.0
Sender: Simon Glass <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20201128174958.1.I65ee0a32775ee9048715428e258b8c28e9382e4f@changeid>
References: <20201128174958.1.I65ee0a32775ee9048715428e258b8c28e9382e4f@changeid>
 <20201129005011.2104545-1-sjg@chromium.org>
Date: Wed, 9 Dec 2020 16:26:47 -0800
Message-ID: <CAPnjgZ1X85BsWa=QKmsiwB0bzNrtjKFvuzCL=z1gVt-gkEo7OA@mail.gmail.com>
Subject: Re: [PATCH 01/11] dm: core: Rename device_bind() to device_bind_offset()
Content-Type: text/plain; charset="UTF-8"
To: Simon Glass <sjg@chromium.org>
Cc: Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Icenowy Zheng <icenowy@aosc.io>, Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Joe Hershberger <joe.hershberger@ni.com>, Lars Povlsen <lars.povlsen@microchip.com>, Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Martin Fuzzey <martin.fuzzey@flowbird.group>, Masahiro Yamada <yamada.masahiro@socionext.com>, Matthias Brugger <mbrugger@suse.com>, Neil Armstrong <narmstrong@baylibre.com>, Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, Robert Beckett <bob.beckett@collabora.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

This function is not necessary anymore, since device_bind_ofnode() does
the same thing and works with both flattree and livetree.

Rename it to indicate that it is special.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/apollolake/spl.c               | 2 +-
 drivers/clk/clk.c                           | 2 +-
 drivers/core/device.c                       | 6 +++---
 drivers/gpio/mt7621_gpio.c                  | 4 ++--
 drivers/gpio/s5p_gpio.c                     | 4 ++--
 drivers/gpio/sunxi_gpio.c                   | 4 ++--
 drivers/gpio/tegra186_gpio.c                | 4 ++--
 drivers/gpio/tegra_gpio.c                   | 5 +++--
 drivers/net/mvpp2.c                         | 2 +-
 drivers/pinctrl/broadcom/pinctrl-bcm283x.c  | 5 +++--
 drivers/pinctrl/meson/pinctrl-meson.c       | 2 +-
 drivers/pinctrl/mscc/pinctrl-jr2.c          | 4 ++--
 drivers/pinctrl/mscc/pinctrl-luton.c        | 4 ++--
 drivers/pinctrl/mscc/pinctrl-ocelot.c       | 4 ++--
 drivers/pinctrl/mscc/pinctrl-serval.c       | 4 ++--
 drivers/pinctrl/mscc/pinctrl-servalt.c      | 4 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 4 ++--
 drivers/power/regulator/Kconfig             | 2 +-
 include/dm/device-internal.h                | 8 ++++----
 include/power/regulator.h                   | 2 +-
 20 files changed, 39 insertions(+), 37 deletions(-)

Applied to u-boot-dm, thanks!
