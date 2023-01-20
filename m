Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.77195.1674228083624674687
 for <u-boot-amlogic@groups.io>;
 Fri, 20 Jan 2023 07:21:51 -0800
Received: by mail-wm1-f46.google.com with SMTP id m15so4357319wms.4
        for <u-boot-amlogic@groups.io>; Fri, 20 Jan 2023 07:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cIHJ6UqvM8K7IzPsVK8Dwhicid852Dhm5f0U37LQ8w=;
        b=nXN1FvuOkq0tyT1uxGrA7gpDh6+qOvhwQ7ITQCOyqimD1G/zMbBJmynNoQda+DIqBZ
         FD8ka4L15HBC7QNcv9VaC6gbvim5aYAX5hcTNYxrJ6GFPDcNgXoXmlEKEQHEU5T8Zkal
         /Hb980/oPDaOrHJOgqAWHoRSxfAuJLeEkYjjVjJKVyCk1nU0+xgaHPplJ0TwycyfeFqI
         n5HaT+wI0vuQeEsQbBVg8m7U0eo0Q8+c9zWhaMy2aI9YLBva1l7F8NH8jyxeqas8pPe2
         gFwhy0hQsTSGJnrEhikpBNzgMqdAPfBKcO7xjN6o2RP6bMAjC/KjiACqCovuc4Riy1T4
         TS9g==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230117-u-boot-usb-gxl-otg-dm-v1-0-2853f6d75b06@linaro.org>
References: <20230117-u-boot-usb-gxl-otg-dm-v1-0-2853f6d75b06@linaro.org>
Subject: Re: [PATCH 0/2] mach-meson: port GXL & AXG dwc2_otg usage to CONFIG_DM_USB_GADGET=y
Message-Id: <167422810944.1545782.3812840441174387290.b4-ty@linaro.org>
Date: Fri, 20 Jan 2023 16:21:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marex@denx.de>, Vyacheslav Bocharov <adeep@lexina.in>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Tue, 17 Jan 2023 10:11:45 +0100, Neil Armstrong wrote:
> This is the port of Mattijs work at [1] for G12A over GXL & AXG.
> 
> It uses the same design and should work as-is, it still needs to be
> be extensively tested over the main GXL & AXG boards.
> 
> [1] https://lore.kernel.org/all/20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com/
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/2] usb: dwc3-meson-gxl: force mode on child add/removal
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/043a9674b64741e02b99e9c5ad2e4ee5a1c841d5
[2/2] ARM: meson: switch AXG & GX dwc2 otg to DM
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e327e2affd302b7fd15b655624fdacb2f0492eab

-- 
Neil
