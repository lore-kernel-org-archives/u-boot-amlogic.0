Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3C1C83000
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 07:51:16 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web11.1917.1751045982371409121
 for <u-boot-amlogic@groups.io>;
 Fri, 27 Jun 2025 10:39:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hlDsNcLC;
 spf=pass (domain: konsulko.com, ip: 209.85.167.173, mailfrom: trini@konsulko.com)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-40b1f402deaso1423993b6e.3
        for <u-boot-amlogic@groups.io>; Fri, 27 Jun 2025 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751045981; x=1751650781; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Agq5U1/p67QVCS48LkgcRMvqYukd5Dt6ruzwVHj2cNc=;
        b=hlDsNcLCNW9Dx+/8cjW44Mnyht/6lMhkEF8U4YVK3i0QURLIr9UYdkwg7x4sqRhmcz
         qdRuXZ3a1GOrXvVGEvRCpy88bCklt+31Oh0rCH1Vkcm1l23KgCPeE/ST4lRJZfbUF07K
         aB/9zZ2anl8+eMEWG7DcFHFAYJSwGYckYsTdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751045981; x=1751650781;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Agq5U1/p67QVCS48LkgcRMvqYukd5Dt6ruzwVHj2cNc=;
        b=JpBjAcZtSe9b79yi4Pd+ki/4pHo8eNs82IVgR6DvIiFtIrmH4M6h3VMnvg5lTxpACl
         VS+S5+P2u3TWAkuzSMkLgwR3ukYW6C+CeM4VsNN4BrlsAWHgHROeXpDMD0LnaOoowpWN
         W7y1QHVwvar/8VatpXegwZW9hB5Turv+hoSDhkLjHxOkmuUxni+GipbTjE48mZMxa1uW
         RNc9AZB/jf2q7ynwusp0N1DTMDk6ADqFlDmLT/8l/Vk30+saoewvQQqZ5J/urMHbVgdX
         4jsO/uhg2Xnci4Km4iewQHHCsPDhUprkFp1vJGFd7vPVT5O2OQ234KEprPAsn05OshAp
         /wKA==
X-Forwarded-Encrypted: i=1; AJvYcCUFO+lrN/l2dTc/hEl7xM4oObPl85tdqUiAuYCFqRe4PzwQg2yawTv2VHIP1PNz7md2Ol/1XU+u0q6uMMK1Nw==@groups.io
X-Gm-Message-State: AOJu0YyNHy0rVzj9MtQqGdnrVW/EButtlP7BCnl0IGfWf5T7bru7zeeE
	+yj8Ng5OQMHhvnRa7WAdFuvRxq/5MfDkrDVJdFw51KKS/vuWMzqZm7PIrfH15fxUXcd+fpB7lDZ
	DMhIG2AE=
X-Gm-Gg: ASbGnctaFm5BBLfcrZC9nhJJG831GtOAu/8IM1EEn/NJtuhoChIdb8kpLHYNAd54t9t
	J4lVyJPxNBYKp7uPF9GDBT0W1QXKuwEhyg9b/BW9pxJ28RnZ5lPXC0gtG+O+TvbM5nnLqM/l2ht
	/VON7pHk61pOiFmHSIhHeQ00mSWcqvbbjIRdmx0+Gc+YpL0tTMxwFYORc0nTpqUMVnIbiySKmde
	tyIcacsDHSckYUd7ouv9K3Y8AwHYfOq28abM9UZ2iEbCEQJoHHSBi6LS/dmzBw9RkOa1yIHHNhe
	6vdbDbHWGrXqLFCr2vUN7Gl5OGDlwHIooye4kP6Pgpxil4dBUoVOJUd+Tc9EZfIDpY8f6z0J47H
	FNwjDzvUFIm4SQc9HvvxNdw==
X-Google-Smtp-Source: AGHT+IHupxBlolOGkNTBwv8JvnjDlYctBYQ3GusvK5B5A7o+Gcy4rJ/RDvoO8E+UsukOCfz0TFjfAw==
X-Received: by 2002:a05:6808:23d2:b0:401:e6f0:a8d4 with SMTP id 5614622812f47-40b33c60e48mr2730306b6e.5.1751045981542;
        Fri, 27 Jun 2025 10:39:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net. [189.203.100.42])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322b5900sm442246b6e.18.2025.06.27.10.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:39:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, John Crispin <john@phrozen.org>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io
In-Reply-To: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
References: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/6] drivers: pci: pcie_dw_common: Add dw_pcie_link_set_max_link_width()
Message-Id: <175104598026.3877702.9668053267112408385.b4-ty@konsulko.com>
Date: Fri, 27 Jun 2025 11:39:40 -0600
MIME-Version: 1.0
X-Mailer: b4 0.14.2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Jun 2025 07:51:16 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2723

On Tue, 17 Jun 2025 10:16:27 +0200, Marek Vasut wrote:

> Add dw_pcie_link_set_max_link_width() implementation ported from Linux kernel
> as of commit 89db0793c9f2 ("PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling").
> This is common code which is already duplicated in multiple drivers.
> 
> 

Applied to u-boot/next, thanks!

[1/6] drivers: pci: pcie_dw_common: Add dw_pcie_link_set_max_link_width()
      commit: 4600b59568339602ef0c95377cc64f561132ebea
[2/6] pci: pcie_dw_meson: Use dw_pcie_link_set_max_link_width()
      commit: a83def86152d24cf22601844fc922593ad42492b
[3/6] pci: pcie_dw_qcom: Use dw_pcie_link_set_max_link_width()
      commit: 579ac25b175ae1c7dc46057022fff7e877b3e5b7
[4/6] pci: pcie_dw_rockchip: Use dw_pcie_link_set_max_link_width()
      commit: 17b5e8acfc93fd21371b694cc9e9951464d49d72
[5/6] pci: pcie-rcar-gen4: Add Renesas R-Car Gen4 DW PCIe controller driver
      commit: be3dd0dc2fd9020fa19cd96ea82753315f4084b0
[6/6] arm64: dts: renesas: r8a779g3: Enable PCIe/NVMe on Retronix R-Car V4H Sparrow Hawk board
      commit: d7c11487902127240be684174334a1b8ccebac03
-- 
Tom



