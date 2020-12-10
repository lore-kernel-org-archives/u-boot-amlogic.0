Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web08.5925.1607560007233619288
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Dec 2020 16:26:47 -0800
Received: by mail-wm1-f65.google.com with SMTP id g25so1831147wmh.1
        for <u-boot-amlogic@groups.io>; Wed, 09 Dec 2020 16:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:from:in-reply-to:references:date:message-id
         :subject:to:cc;
        bh=H2LBJ1L15PQpERSinzNd/Kowg1PBEwSvqx5TLADtFZk=;
        b=mnIoNtQ2gs/LxbBH0za+LXXqUAoZy4Av3T1U5RbJ1kuZ2LcFazEV4ReKjL50AEB+dh
         OA50a5DpDxFJG/YIoS+wpFmLX+cUiVLIFZJCFOYEGJAGARbHPV2VBnMQcLEXD+zdW9N1
         wubMAVWY3++/PFvS6qnPjGYqWo8aDTApZPW7M=
MIME-Version: 1.0
Sender: Simon Glass <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20201128174958.5.I538f3f84e07991a9886f3c697ed0ac238b827a6b@changeid>
References: <20201128174958.5.I538f3f84e07991a9886f3c697ed0ac238b827a6b@changeid>
 <20201129005011.2104545-1-sjg@chromium.org>
Date: Wed, 9 Dec 2020 16:26:41 -0800
Message-ID: <CAPnjgZ3+uKSTYgxOdMYkhXWgdomtxEz+fqRMaPKZ6AzFjDmC5A@mail.gmail.com>
Subject: Re: [PATCH 05/11] dm: Drop uses of dev_set_of_offset()
Content-Type: text/plain; charset="UTF-8"
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Icenowy Zheng <icenowy@aosc.io>, Jagan Teki <jagan@amarulasolutions.com>, Marek Vasut <marex@denx.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Neil Armstrong <narmstrong@baylibre.com>, Pavel Herrmann <morpheus.ibis@gmail.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

The need for this can be avoided by passing the correct node to the
device_bind() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/gpio/mt7621_gpio.c            | 3 +--
 drivers/gpio/s5p_gpio.c               | 4 +---
 drivers/gpio/sunxi_gpio.c             | 3 +--
 drivers/gpio/tegra186_gpio.c          | 3 +--
 drivers/gpio/tegra_gpio.c             | 5 ++---
 drivers/pinctrl/meson/pinctrl-meson.c | 1 -
 6 files changed, 6 insertions(+), 13 deletions(-)

Applied to u-boot-dm, thanks!
