Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.9880.1695892228570822027
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Sep 2023 02:10:28 -0700
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-32164a6af64so11120200f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 28 Sep 2023 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695892227; x=1696497027; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAMydH/tQ51DRsUCVRz38C46XiLnit1vjjpp185ESRk=;
        b=wDiYZb0TcXmwP/pHcJLE5em8J3kHwNLS3JKHnelpIT0Nl62L0xmEPDBD4e2mLNePR6
         XzUH16XEDUelIVsHkvF+FMyXO6op2bjvBXVR4p2LrLgsEBlaOFIH+JuXF5/dsP6yIMof
         ol1niSkhbDy9XVLV7ajJQNupVUBAaGSQ7Q8/GXc4AbdziDXw1WgHTpwhCWzeC7gS9hV0
         MC7EynICozuVOe6LF/Nja1l4dBeOMTuRuZJxVIFXLGUhNr33p8vUEEIwHu93VOl0yJ+Q
         3k109Ne5fh5h+/NMMySF3vIfG4v/IrUV8AQFvtzgBMW05Tvv92l4sOlY2HfmnMb+knrB
         hi7Q==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: Re: [RFT PATCH 0/2] mmc: meson-gx: improve MMC reliabilty
Date: Thu, 28 Sep 2023 11:10:22 +0200
Message-Id: <169589209464.3562671.339060253310710013.b4-ty@linaro.org>
In-Reply-To: <20230915160130.352099-1-jbrunet@baylibre.com>
References: <20230915160130.352099-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Fri, 15 Sep 2023 18:01:28 +0200, Jerome Brunet wrote:
> Amlogic MMC on the GX (and later) SoCs has been problematic for years,
> especially with u-boot.
> 
> Linux has been fairly stable for a few years. It is using a fixed phase
> setting with Core = 180, Tx = 0 and Rx = 0 (the latter cannot be set
> starting from the v3 MMC IPs)
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/2] mmc: meson-gx: clean up and align on Linux settings
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/1f505e80e20918bcd388ccff6b33d749fbf31945
[2/2] mmc: meson-gx: set 270 core phase during the identification
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/100f9e63762e02a65a441d7dd6a2923b62824c8a

This triggered the following build https://gitlab.com/superna9999/amlogic-u-boot-autotest/-/pipelines/1019397571
which will produce ready-to-boot binaries on most of the supported platforms
in https://github.com/LibreELEC/amlogic-boot-fip FIP repo.

-- 
Neil
