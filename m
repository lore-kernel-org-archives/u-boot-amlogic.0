Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.14088.1696509470925784935
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Oct 2023 05:37:51 -0700
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4064867903cso8566135e9.2
        for <u-boot-amlogic@groups.io>; Thu, 05 Oct 2023 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696509469; x=1697114269; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vILP50vAWqz1sGV49ycYMK1044oT2WQWquY6fd4VE8=;
        b=c5+opRxXLFe7B71HR/QAdbNYxfL+nbkAs7crap+3uwdcR417K2xpxvIT9iUurId4CO
         mXW0rEISFJ+0YrIBJvw24JFPWgWH/ujIv8jB7WbdHJZYXjJkYYRXAUecTdhfg5LWGWNb
         RNGk/hix2FksFAX39j0hnHszgKHUmIwwVCntRDae5iJcb6TlWUVIcMsFU6t6KXTJbWXF
         7S/7Kf2SzJzcDuXWrRKMBL69ibFvz1SMlGmv22DYuoX4pfnuEY1ahWvcLDxh3oo2lc8f
         P1dwOI5IznmiJGPWcKl/sUsVEZMMwNj4XUPTey9+FSLZXjaC8hGB0qQquD10YtFBAsv6
         DfFg==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 0/8] Support USB for Meson A1
Date: Thu,  5 Oct 2023 14:37:46 +0200
Message-Id: <169650945649.3912260.17461050766538864431.b4-ty@linaro.org>
In-Reply-To: <20231005085434.74755-1-avromanov@salutedevices.com>
References: <20231005085434.74755-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sjg@google.com, lukma@denx.de, marex@denx.de, Neil Armstrong <neil.armstrong@linaro.org>, Alexey Romanov <avromanov@salutedevices.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Thu, 5 Oct 2023 11:54:21 +0300, Alexey Romanov wrote:
> This patchset adds USB stack support for Amlogic A1 SoC's
> series. Made reset / phy / dwc3 drivers more flexible and
> added support for A1 board.
> 
> V2:
> 
> - Made power domain for PHY optional.
> - Add missing CLKID_USB_PHY gate.
> - Drop patch with USB stack initialization in board-a1.c.
> Instead of, enable CONFIG_DM_USB_GADGET for AD401 board.
> - Support A1 in g12a_child_pre_probe/post_remove functions
> in dwc3 driver.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/8] dt-bindings: reset: add Meson A1 reset bindings
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/fccbc810551a7e1c821ac23d5e8fd27c12ded1b2
[2/8] reset: add support for Amlogic A1 family
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/29ad8b0401dc9a75a15077f2a38363659091580e
[3/8] phy: get rid of raw hex values
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/11572764d44783870cc61ac2f0435bd555222ef6
[4/8] phy: move clk enable/disable in init/exit
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ac7f5b2f768d298fe84ab36d363853748ae23243
[5/8] phy: support Amlogic A1 family
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/66defb628f658df97e426ab13dc620b9bf6277ab
[6/8] a1: clk: Add missing USB_PHY_IN and USB_PHY gates
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/84b0d40f3adb03074a80a58e4e655b422bce40ce
[7/8] dwc3: add support for Amlogic A1 family
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8a4781ff2e51d5831b7d236a327c5fb13849b689
[8/8] ad401: enable USB stack
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/686a98392fc1beaf544c8cf65f48b781a56a5148

-- 
Neil
