Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.5939.1607560007441097998
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Dec 2020 16:26:47 -0800
Received: by mail-wr1-f67.google.com with SMTP id x6so3636290wro.11
        for <u-boot-amlogic@groups.io>; Wed, 09 Dec 2020 16:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:from:in-reply-to:references:date:message-id
         :subject:to:cc;
        bh=Qy8vRc676FSuZf8M2hGaotxY1Tgv6IJJojMPqqAXbCo=;
        b=ENzFc5unFLhLrFQ9o+108A5LXc7qHLwmaRcrpoqm3/fg7Pci3282rVanM0QTj7o08f
         cFLXF34dn1IJ3p+HH6fRNQMLW9OEWgpuOzA6ovbsAiIjs+jQW3cQZWR7RQJyjMCVIa2X
         nkBL9e5BdPqbzl09wl1dkPndm12xy3Rx+eDQA=
MIME-Version: 1.0
Sender: Simon Glass <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20201128174958.4.I07862310b4e40efa2ea158f4f84e0f79dcfec7ed@changeid>
References: <20201128174958.4.I07862310b4e40efa2ea158f4f84e0f79dcfec7ed@changeid>
 <20201129005011.2104545-1-sjg@chromium.org>
Date: Wed, 9 Dec 2020 16:26:42 -0800
Message-ID: <CAPnjgZ2Ncs4sCFnAzcBobn6zkpeYH=7-OGb6jJbJyuLWuLEFXg@mail.gmail.com>
Subject: Re: [PATCH 04/11] dm: Remove uses of device_bind_offset()
Content-Type: text/plain; charset="UTF-8"
To: Simon Glass <sjg@chromium.org>
Cc: Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Icenowy Zheng <icenowy@aosc.io>, Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Joe Hershberger <joe.hershberger@ni.com>, Lars Povlsen <lars.povlsen@microchip.com>, Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Martin Fuzzey <martin.fuzzey@flowbird.group>, Masahiro Yamada <yamada.masahiro@socionext.com>, Matthias Brugger <mbrugger@suse.com>, Neil Armstrong <narmstrong@baylibre.com>, Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, Robert Beckett <bob.beckett@collabora.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

This function is not needed since the standard device_bind() can be used
instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/apollolake/spl.c               |  2 +-
 drivers/clk/at91/compat.c                   | 20 ++++++++------------
 drivers/clk/clk.c                           |  2 +-
 drivers/gpio/mt7621_gpio.c                  |  4 ++--
 drivers/gpio/s5p_gpio.c                     |  4 ++--
 drivers/gpio/sunxi_gpio.c                   |  4 ++--
 drivers/gpio/tegra186_gpio.c                |  4 ++--
 drivers/gpio/tegra_gpio.c                   |  6 +++---
 drivers/net/mvpp2.c                         |  4 ++--
 drivers/pinctrl/broadcom/pinctrl-bcm283x.c  |  5 ++---
 drivers/pinctrl/meson/pinctrl-meson.c       |  4 +++-
 drivers/pinctrl/mscc/pinctrl-jr2.c          |  4 ++--
 drivers/pinctrl/mscc/pinctrl-luton.c        |  4 ++--
 drivers/pinctrl/mscc/pinctrl-ocelot.c       |  4 ++--
 drivers/pinctrl/mscc/pinctrl-serval.c       |  4 ++--
 drivers/pinctrl/mscc/pinctrl-servalt.c      |  4 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c |  8 ++++----
 drivers/power/regulator/Kconfig             |  2 +-
 include/dm/device-internal.h                |  4 ++--
 include/power/regulator.h                   |  2 +-
 20 files changed, 46 insertions(+), 49 deletions(-)

Applied to u-boot-dm, thanks!
