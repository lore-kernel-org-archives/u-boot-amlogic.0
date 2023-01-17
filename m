Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.191901.1673944064708590512
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Jan 2023 00:27:45 -0800
Received: by mail-wm1-f53.google.com with SMTP id o17-20020a05600c511100b003db021ef437so2435740wms.4
        for <u-boot-amlogic@groups.io>; Tue, 17 Jan 2023 00:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78M7lgqerfkyhzxhUZFYxcjqhLFuB/IN18RhUW2NMXE=;
        b=QkDURjN80n+hUtEimrsUwu4J+k0mjrJioMQqdFom6JVsIBCQYoii2Z046K4rLwadWK
         wtuda4xW/FOCW4iJGdQ9GCJ+WxfwMr42czATQ2rQ6yIJ3riESwM4wEEuT8RCVIt/NmQL
         0EmY+TIs75K8v0dTXNaKOkVQq3ejonNYEEnd04deOUzd6GCEkbuACxyV2lp0MBm+lDhS
         TuvIVOJL4+aS0lvHYTI1MBOVK+aUXX3fqvwNtdsy5eB9ry3qUb3qZy4mv7qi4NMqlxLd
         vt3pQIatRRYRv/4ec4dwlSvBeM26HeOu36iTd/cFfXDAs6bA5G4TphmXKjx8mFyus3H1
         SlkQ==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com>
References: <20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com>
Subject: Re: [PATCH 0/2] mach-meson: port dwc2_otg usage to CONFIG_DM_USB_GADGET=y
Message-Id: <167394406218.3770632.15275014837641153833.b4-ty@linaro.org>
Date: Tue, 17 Jan 2023 09:27:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Christian Hewitt <christianshewitt@gmail.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Wed, 23 Nov 2022 16:42:48 +0100, Mattijs Korpershoek wrote:
> While working on some USB bugs on the VIM3L board, we stumbled upon the fact
> that mach-meson still uses legacy board_usb_*() functions instead of using DM [1]
> 
> This series aim to switch the g12a based boards to use CONFIG_DM_USB_GADGET and
> removes the board_usb_*() logic.
> 
> * The first patch adds mode switching in the dwc3-meson-g12a glue driver whenever
>   the dwc2 otg driver is probed()/removed().
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/2] usb: dwc3-meson-g12a: force mode on child add/removal
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/fd083842d719cf13d64b0ec061d3c7be98be91a2
[2/2] ARM: meson: g12a: switch dwc2 otg to DM
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/b96640cbfb319071aea7915cfa2f7aefe08bbc08

-- 
Neil
