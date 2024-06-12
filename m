Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E306CC2BA15
	for <webhook@archiver.kernel.org>; Wed, 12 Jun 2024 14:37:47 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.4995.1718172550097667082
 for <u-boot-amlogic@groups.io>;
 Tue, 11 Jun 2024 23:09:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=WNzcOPEJ;
 spf=pass (domain: linaro.org, ip: 209.85.216.51, mailfrom: ilias.apalodimas@linaro.org)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c2ccff8f0aso3940324a91.0
        for <u-boot-amlogic@groups.io>; Tue, 11 Jun 2024 23:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718172549; x=1718777349; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OjOb54Va8/R94/e6Jm9Kb7VQxeHfUpxTZ8mJGId4JU0=;
        b=WNzcOPEJiAOEi3yziGcJ3UU12BDewNkGRrSlbQH1vPasXzc6J3IdDiAqfjLLS85ffg
         7I/35UjMsbVHBmEwCWQEh9jwOeo8BHszmj1v3nrLp5YZGQa3rX2U+Etd4pnj62yyfpAA
         hto5X7GPlEuJW5bjzYyIBuBl3ymf8Pc5krafnMbgD+bfPXB/FYtop8+wCZbRSpHAFSJN
         7NdBN3XB7Q9z80GKN2keYvsmElyq1ZLCk+Rkpfxd6g2xMbDIJNMEuGha5G7mNC9CANq+
         oCQE8ZZFUFe/uGP42GcKknrFxL2rGuPWlABqz5TCp2Pc75IYEt3hhtZJuybqUDOUZ5ot
         JiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718172549; x=1718777349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjOb54Va8/R94/e6Jm9Kb7VQxeHfUpxTZ8mJGId4JU0=;
        b=ZThp+7+bG5VTWtLJ3yPLKwcuH10jXgEatQapq2QfGBJdTat0PfkKwYci4ibIVN0jw/
         0Hx0B1M84r8SUDWX7yDmvelxynRGImwXJr8UUqV8YihDutmfa1Lsh1fbJKULiPvgkZmd
         An44OoUqQlY8orGH1KVYS1hxZDvQ2Mi+oO0j+HBJ079C7p9WO/ChFDA8geuhysz7YCQp
         x4XQinWXTwzjGm2RP0W38po8aeTPsPzv2+UkdAuME3tzZh/cr+wwWvtI1bEq2Q8KMBJK
         FqFvkwgCbMOeWrhfRpprvbeo1CWTnecUSat5ldKpKOISTh6NldY5zRbq+QVBeBGB4uCb
         60fg==
X-Forwarded-Encrypted: i=1; AJvYcCUQI0eji3DuwVsqg7sv9KZ2+bCKHaZcVkvZdMOPE07Ts21AeZ92XJF7aUhZ9e679266GiRYn6PNsU0shuL5rOAL+zqGL6DKfd4=
X-Gm-Message-State: AOJu0YxNc2GCxtRbzKNYv3GFuGscqPurpgjJ21DAAjtMbAReo3fzHXpF
	mEtTGimkKbhRz5G1vqj/jiDfnOsq3s9ObnTA1QelGQQvdpQUKyKvXO7pwTkumNTa9VjOgYl9flz
	URl7o5RwQQh25oibXbv/Oz55AGCAKuSQGmMocig==
X-Google-Smtp-Source: AGHT+IHqVOwo/X7Rt+CtAR/zAIoyem+PJkJ+AEYrX1Lpd9Aqx3Wfs+3SFqLNJ614FZ4w9KJCItKvTgWombNynpVWlpQ=
X-Received: by 2002:a17:90b:30c2:b0:2c2:7dd5:eb3c with SMTP id
 98e67ed59e1d1-2c4a771995cmr839787a91.44.1718172549410; Tue, 11 Jun 2024
 23:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240611200156.2245525-1-sjg@chromium.org>
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 12 Jun 2024 09:08:32 +0300
Message-ID: <CAC_iWjKAaWnphnBUi6YTRMn1EthbX5mZtjh78YXyxWoXqmJcGw@mail.gmail.com>
Subject: Re: [PATCH 00/42] labgrid: Provide an integration with Labgrid
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
	AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Gendin <agendin@matrox.com>, 
	Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Allen Martin <amartin@nvidia.com>, 
	Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, Andrew Davis <afd@ti.com>, 
	Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Christian Taedcke <christian.taedcke@weidmueller.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, 
	Francis Laniel <francis.laniel@amarulasolutions.com>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Leo Yu-Chi Liang <ycliang@andestech.com>, Lukas Funke <lukas.funke@weidmueller.com>, 
	Manorit Chawdhry <m-chawdhry@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
	Martyn Welch <martyn.welch@collabora.com>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2294

Hi Simon

On Tue, 11 Jun 2024 at 23:02, Simon Glass <sjg@chromium.org> wrote:
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

Thanks this is interesting!
I only got cc'ed on the cover letter and I'll slowly have a look on
the rest. A naive question -- I saw you did integrate this on gitlab
with your internal lab. How secure is this? Could we schedule weekly
builds that run on various remote labs and get results on actual
hardware? Or do we have to rely on users for that ?

Thanks
/Ilias

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

