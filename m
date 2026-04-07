Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B081073CAE
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 12:56:06 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90687.1775591738399611809
 for <u-boot-amlogic@groups.io>;
 Tue, 07 Apr 2026 12:55:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=m2czyFzL;
 spf=pass (domain: konsulko.com, ip: 209.85.161.44, mailfrom: trini@konsulko.com)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-685013eb58fso1425213eaf.3
        for <u-boot-amlogic@groups.io>; Tue, 07 Apr 2026 12:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1775591737; x=1776196537; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU9aHqQN9gp/ACGep7Y7VIJ+H+/wIZZzez+PUyLK1gg=;
        b=m2czyFzLCs0XCBiQO6phlZ+OM3XgrDpzG7hY/UeyWJK+N4AYU8obTrgqL1m2ujjJnZ
         Hmt7ixlid8fAE7qAIOQhYwPsESt28tTaDrKKXSwbHHXsO8wmRpv+3TYMeTKcCqTqQaWa
         X0ZZiUFhtp6h9c1OO59g7ow4lMWShD/aoNV+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775591737; x=1776196537;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TU9aHqQN9gp/ACGep7Y7VIJ+H+/wIZZzez+PUyLK1gg=;
        b=oQOyQTm7rJqm7AaZ3ffkOtrfw3Ay2p6TfJblUPHysn3h4GOmuRsjWrn0ez9xvlq4DV
         vKFPQOfaXIwgvQ7mxnOVnSTj5b9kZr2YUZ28qCBgRnG+RERvlVqHz3VNYaKi/gmeld0m
         KFCD6PCdgxk92wXtICL6KFQ/ofmVhp1TM8kbzfC3gcc8hl5PwkjSOElzz+wvi67dvMqU
         ImLxPka68+g6SOE47d9Bh0EyvNFXrm+7/infTcsdjvueu4FrRwpuH8XThZgKZ/xTkBIR
         NJlUw2MTIrTJLFPwYyvPwUaH8VW+wqaN0XR90mIKtIuymANfraqQdMkKaZbBJx4eg6l+
         tDUw==
X-Forwarded-Encrypted: i=1; AJvYcCVCjv1JbPNP5l85O4k6zSRQZdkrj8COdkoatkhDpht6wQohNZYaUqwDcd+n4Vvl4hgJnOaTSnWwruZCKc7OtQ==@groups.io
X-Gm-Message-State: AOJu0YwIjP1CTJoBK1pR2DpyMcpwpgWzb4L1HyE/DF7nJVNReleoG8L2
	i+DsS1PwyK1/KtxN6BpIdgaVHEi0od0lWFwMG7R+lqD3rv+QRHXCv041ZVyrtfMx2kJwWLE3xZ9
	gpu5DdEM=
X-Gm-Gg: AeBDievq7tKPuu4OeeZmIvfhMexv0SLePdRPrmY3OnkTt1amCDGNqqMy2dgI0hgcR1X
	ifvA7BRU3xaZGOAV0L+Kz6ww9h5ul997VC2QbSyKqTQ1QBSgZ4/QIvsR0B1IDLKDjBIlDC6NaC6
	9MOVvgKrO2M43v5ERGmSX2QplV9DinWeCINyyO77YxnmdhTUrjsLq7uZWHWeB24ibFCXmEfhU3E
	gOTHjvzRpv+GPJzPRaUhJYLVsi3+L4CNnC24Cxrs6Y8asjOO5uBJ+vHTzfy9Y7VruHAaGoNjckE
	XKsug57sw6JvE7DKOXO726VS6GFI85YYDdxoD/SKoI42ejCgEAFGSveip4eSlQZ31KoJe1t6SIl
	KiFHlMgXXUn5jMVD/Bx1MbLd/q8Fa1cD0c7u6iCy+1hdWhnfiV3dw4+ZfkTfkP2JEOcL3diiulT
	U0R6MHp4JO2hlwLPfDv73GheON8SbdeeyqT63RHK9w0tZPtFyU+wCDZ1ju3vX2K8bdjSPyU1aHL
	K2ysU4wwJKYrydi15DyQoqMBa9+zRyaOIwinDCl012NLhA=
X-Received: by 2002:a05:6820:81c4:b0:67d:e836:2e46 with SMTP id 006d021491bc7-6822064327emr10582368eaf.45.1775591420434;
        Tue, 07 Apr 2026 12:50:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net. [189.203.97.235])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:50:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 =?utf-8?q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, u-boot-qcom@groups.io, 
 linux@analog.com
In-Reply-To: <20260323225537.896180-1-trini@konsulko.com>
References: <20260323225537.896180-1-trini@konsulko.com>
Subject: Re: [PATCH] global: Correct duplicate U_BOOT_DRIVER entry names
Message-Id: <177559141859.2108693.17265258152616779822.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:18 -0600
MIME-Version: 1.0
X-Mailer: b4 0.14.3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Apr 2026 12:56:06 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2951

On Mon, 23 Mar 2026 16:55:37 -0600, Tom Rini wrote:

> The U_BOOT_DRIVER macro creates a list of drivers used at link time, and
> all entries here must be unique. This in turn means that all entries in
> the code should also be unique in order to not lead to build failures
> later with unexpected build combinations. Typically, the problem we have
> here is when a driver is obviously based on another driver and didn't
> update this particular field and so while the name field reflects
> something unique the linker entry itself is not. In a few places this
> provides a more suitable string name as well, however.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] global: Correct duplicate U_BOOT_DRIVER entry names
      commit: 8c212d6e2e778b4f294d1d9f85eac9680a66d463
-- 
Tom



