Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.8407.1666710982555238714
 for <u-boot-amlogic@groups.io>;
 Tue, 25 Oct 2022 08:16:22 -0700
Received: by mail-wr1-f50.google.com with SMTP id l14so14404670wrw.2
        for <u-boot-amlogic@groups.io>; Tue, 25 Oct 2022 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlhclRXrpi15eP5veKrpsxoPmhuZ9sMxnY9PN21CLSo=;
        b=K3CCs46NYW6swH5+Ru6/aJtLYjyFHpf2ZDucIc7NhHumD6YNIBmhk9AuLcWXtxZbvV
         anRJbDUSyYYR1lxT/aRkPlD/atL4B49eb6l6DQ2L0PzvqbjGX7e81eZdWeA19GtWHYsZ
         TmNKJhJwNE31bTSArzrEiJ5rPmzqnGQdq/20xzAUtc3DsUrAQOyXcrFGn7FKZMSmlFZT
         8jrkfpoNVPomKCCp/3gTVslPoAjk2DMFmR3bJl9lxGhPl9kDf3nhSjZPuAYzXQObnoLe
         +eMJ4Th8R5x83Xvv9wUC03uDE+nhAXiltR5bKbg1OpvPTq3yUMbPB/QIpZopi6egX0Lw
         voLw==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20221025143205.14470-1-christianshewitt@gmail.com>
References: <20221025143205.14470-1-christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: nanopi-k2: readd PHY reset properties
Message-Id: <166671098029.66253.1659888075300795635.b4-ty@linaro.org>
Date: Tue, 25 Oct 2022 17:16:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, linux-amlogic@lists.infradead.org, Christian Hewitt <christianshewitt@gmail.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Tue, 25 Oct 2022 14:32:05 +0000, Christian Hewitt wrote:
> The sync of device-tree/bindings in 11a48a5a18c6 ("Linux 5.6-rc2") causes
> Ethernet to break on some GXBB boards; the PHY seems to need proper reset
> timing to function in u-boot and Linux. Re-add the old PHY reset binding
> for dwmac until we support new bindings in the PHY node. This borrows the
> same fix applied to the Odroid C2 board [0].
> 
> [0] https://lists.denx.de/pipermail/u-boot/2021-April/446658.html
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/1] arm64: dts: meson: nanopi-k2: readd PHY reset properties
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7b70f68977578360d9c47bb25d6d1937075153b4

-- 
Neil
