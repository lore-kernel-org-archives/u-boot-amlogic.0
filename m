Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C4AC27C77
	for <webhook@archiver.kernel.org>; Wed, 12 Jun 2024 14:37:47 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web10.366.1718136580071962014
 for <u-boot-amlogic@groups.io>;
 Tue, 11 Jun 2024 13:09:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=d60s77XH;
 spf=pass (domain: chromium.org, ip: 209.85.219.54, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b05e504bceso35787276d6.2
        for <u-boot-amlogic@groups.io>; Tue, 11 Jun 2024 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718136579; x=1718741379; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tko77FxFECfapW6ub6Nfpp7SBXNLb1hOK7jOJ5eNWjA=;
        b=d60s77XHvAx3t0+7UHOrKalWCieA9sWFT5VUJO2KZr7D3wiCEe38WY6VA/IYbkg61+
         4fQlLdzs8z9/6PX55TrR4NsRIho++EC8+J/rZxCu07G0+J7SsfoqfinYKkhfvGZYMbKQ
         tXHwWPgLHir5DYzMX6BXiFJG/vvdJNabNKGNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136579; x=1718741379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tko77FxFECfapW6ub6Nfpp7SBXNLb1hOK7jOJ5eNWjA=;
        b=MCB3EzFe5UMe5B0A1DYgvlhYDF06iht/rsvQz01FomSHpRZwWr3RqJRYX8xl1eTBfl
         fEFgcdYhCRtjKPRMF7Z5LGPVI+5qbCepygq1+ZH2CkMefV7cMuZg+ep/mREV5Dk61tdf
         QRkHE+gwzZ82shG7wDAOF2gOfTMkO3YXQ2rFeEXuZI6OFr0+CD6ConISiq9TBkxPpgC8
         B6fa0fzKBN2oqdabrqs1VSpzQVJ3e6SXllo5pJlcvzokPf7ulKaBAPqr9/ZM5W8NwoWI
         1XjWDUkeOlVyi2/NmQpDjPCc4oplrEp5IuCbVGk6Ow1+Wh/WRcwyIHihg0r6jNQmynFY
         7VtA==
X-Forwarded-Encrypted: i=1; AJvYcCUppkc+tUpSK2SfimWssEcGkNY4cuTODU2yPedlYPtb26P+LImBGnpyETwlOrKEcbKWai49FGoagAUqMShzgmGxzSqAcLQZXwo=
X-Gm-Message-State: AOJu0YyspdJ5gv7pp7xaMWbMO6j6LUkqKkUQGiZ9Mbi+0YwkRP30xjBz
	03nvcJldQ1mJsNYc/zuf8e6znSG+T3DT/h6cp0V32kEa1HWSqDw/6kZD0Kn7bq7DhuHsHnfesQB
	d4kul0nXJ4sweOrfo11Qvmeypk69TKiGANUbi
X-Google-Smtp-Source: AGHT+IG4qQvS5Dc2vHuRfyLzXkIQARykQC4lUbyYX5EWR11HOv3CxtWKrfQqIPPawT5B9B5p/3qXRomDrjQmiwOnJnk=
X-Received: by 2002:a05:6214:5d8c:b0:6b0:737f:5348 with SMTP id
 6a1803df08f44-6b0737f5600mr84698436d6.29.1718136579027; Tue, 11 Jun 2024
 13:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240611200156.2245525-1-sjg@chromium.org>
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 14:09:28 -0600
Message-ID: <CAFLszTiF=JdWuDsunut1WAKUOPKaH-PTjLvRoRBtEy07SXQAOw@mail.gmail.com>
Subject: Re: [PATCH 00/42] labgrid: Provide an integration with Labgrid
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
	Alexander Gendin <agendin@matrox.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, 
	Allen Martin <amartin@nvidia.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
	Andre Przywara <andre.przywara@arm.com>, Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
	Andrew Davis <afd@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
	Caleb Connolly <caleb.connolly@linaro.org>, 
	Christian Taedcke <christian.taedcke@weidmueller.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, 
	Francis Laniel <francis.laniel@amarulasolutions.com>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
	Lukas Funke <lukas.funke@weidmueller.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
	Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Marek Vasut <marex@denx.de>, Martyn Welch <martyn.welch@collabora.com>, 
	=?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Neha Malcom Francis <n-francis@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, 
	Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
	Peter Robinson <pbrobinson@gmail.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
	Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
	Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Trevor Woerner <twoerner@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, u-boot-amlogic@groups.io
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 12 Jun 2024 14:37:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2293

Hi,

On Tue, 11 Jun 2024 at 14:02, Simon Glass <sjg@chromium.org> wrote:
>
> Labgrid provides access to a hardware lab in an automated way. It is
> possible to boot U-Boot on boards in the lab without physically touching
> them. It relies on relays, USB UARTs and SD muxes, among other things.
>
> By way of background, about 4 years ago I wrong a thing called Labman[1]
> which allowed my lab of about 30 devices to be operated remotely, using
> tbot for the console and build integration. While it worked OK and I
> used it for many bisects, I didn't take it any further.
>
> It turns out that there was already an existing program, called Labgrid,
> which I did not know about at time (thank you Tom for telling me). It is
> more rounded than Labman and has a number of advantages:
>
> - does not need udev rules, mostly
> - has several existing users who rely on it
> - supports multiple machines exporting their devices
>
> It lacks a 'lab check' feature and a few other things, but these can be
> remedied.
>
> On and off over the past several weeks I have been experimenting with
> Labgrid. I have managed to create an initial U-Boot integration (this
> series) by adding various features to Labgrid[2] and the U-Boot test
> hooks.
>
> I hope that this might inspire others to set up boards and run tests
> automatically, rather than relying on infrequent, manual test. Perhaps
> it may even be possible to have a number of labs available.
>
> Included in the integration are a number of simple scripts which make it
> easy to connect to boards and run tests:
>
> ub-int <target>
>     Build and boot on a target, starting an interactive session
>
> ub-cli <target>
>     Build and boot on a target, ensure U-Boot starts and provide an interactive
>     session from there
>
> ub-smoke <target>
>     Smoke test U-Boot to check that it boots to a prompt on a target
>
> ub-bisect
>     Bisect a git tree to locate a failure on a particular target
>
> ub-pyt <target> <testspec>
>     Run U-Boot pytests on a target
>
> Some of these help to provide the same tbot[4] workflow which I have
> relied on for several years, albeit much simpler versions.
>
> The goal here is to create some sort of script which can collect
> patches from the mailing list, apply them and test them on a selection
> of boards. I suspect that script already exists, so please let me know
> what you suggest.
>
> I hope you find this interesting and take a look!
>
> [1] https://github.com/sjg20/u-boot/tree/lab6a
> [2] https://github.com/labgrid-project/labgrid/pull/1411
> [3] https://github.com/sjg20/uboot-test-hooks/tree/labgrid
> [4] https://tbot.tools/index.html
>
>
> Simon Glass (42):
>   trace: Update test to tolerate different trace-cmd version
>   binman: efi: Correct entry docs
>   binman: Regenerate nxp docs
>   binman: ti: Regenerate entry docs
>   binman: Update the entrydocs header
>   buildman: Make mrproper an argument to _reconfigure()
>   buildman: Make mrproper an argument to _config_and_build()
>   buildman: Make mrproper an argument to run_commit()
>   buildman: Avoid rebuilding when --mrproper is used
>   buildman: Add a flag to force mrproper on failure
>   buildman: Retry the build for current source
>   buildman: Add a way to limit the number of buildmans
>   dm: core: Enhance comments on bind_drivers_pass()
>   initcall: Correct use of relocation offset
>   am33xx: Provide a function to set up the debug UART
>   sunxi: Mark scp as optional
>   google: Disable TPMv2 on most Chromebooks
>   meson: Correct driver declaration for meson_axg_gpio
>   test: Allow signaling that U-Boot is ready
>   test: Make bootstd init run only on sandbox
>   test: Use a constant for the test timeout
>   test: Pass stderr to stdout
>   test: Release board after tests complete
>   log: Allow tests to pass with CONFIG_LOGF_FUNC_PAD set
>   test: Allow connecting to a running board
>   test: Decode exceptions only with sandbox
>   test: Avoid failing skipped tests
>   test: dm: Show failing driver name
>   test: Check help output
>   test: Create a common function to get the config
>   test: Introduce the concept of a role
>   test: Move the receive code into a function
>   test: Separate out the exception handling
>   test: Detect dead connections
>   test: Tidy up remaining exceptions
>   test: Introduce lab mode
>   test: Improve handling of sending commands
>   test: Fix mulptiplex_log typo
>   test: Avoid double echo when starting up
>   test: Try to shut down the lab console gracefully
>   test: Add a section for closing the connection
>   CI: Allow running tests on sjg lab
>
>  .gitlab-ci.yml                                | 151 +++++++++++++++++
>  arch/arm/dts/sunxi-u-boot.dtsi                |   1 +
>  arch/arm/mach-omap2/am33xx/board.c            |  18 +-
>  configs/chromebook_link64_defconfig           |   1 +
>  configs/chromebook_link_defconfig             |   1 +
>  configs/chromebook_samus_defconfig            |   1 +
>  configs/chromebook_samus_tpl_defconfig        |   1 +
>  configs/nyan-big_defconfig                    |   4 +-
>  configs/snow_defconfig                        |   1 +
>  drivers/core/lists.c                          |  16 ++
>  drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c |   2 +-
>  drivers/pinctrl/meson/pinctrl-meson-axg.c     |   4 +-
>  drivers/pinctrl/meson/pinctrl-meson-axg.h     |   2 +-
>  drivers/pinctrl/meson/pinctrl-meson-g12a.c    |   4 +-
>  lib/initcall.c                                |   6 +-
>  test/py/conftest.py                           |  86 ++++++++--
>  test/py/tests/test_dm.py                      |   5 +-
>  test/py/tests/test_help.py                    |   6 +-
>  test/py/tests/test_log.py                     |  11 +-
>  test/py/tests/test_trace.py                   |   6 +-
>  test/py/tests/test_ut.py                      |   1 +
>  test/py/u_boot_console_base.py                | 154 ++++++++++++------
>  test/py/u_boot_console_exec_attach.py         |  31 +++-
>  test/py/u_boot_console_sandbox.py             |   2 +-
>  test/py/u_boot_spawn.py                       | 123 ++++++++++++--
>  test/test-main.c                              |  16 +-
>  tools/binman/entries.rst                      | 115 +++++++++----
>  tools/binman/entry.py                         |   2 +-
>  tools/binman/etype/efi_capsule.py             |  40 ++---
>  tools/binman/etype/efi_empty_capsule.py       |  22 +--
>  tools/binman/etype/ti_secure.py               |  45 ++---
>  tools/buildman/builder.py                     |  18 +-
>  tools/buildman/builderthread.py               |  44 +++--
>  tools/buildman/buildman.rst                   |   8 +-
>  tools/buildman/cmdline.py                     |   6 +-
>  tools/buildman/control.py                     | 141 +++++++++++++++-
>  tools/buildman/pyproject.toml                 |   6 +-
>  tools/buildman/test.py                        | 121 ++++++++++++++
>  tools/u_boot_pylib/terminal.py                |   7 +-
>  39 files changed, 1003 insertions(+), 226 deletions(-)
>
> --
> 2.34.1
>

Here is an example run (scroll to the right):

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/21081

Regards,
Simon

