Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DF1C53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 15:31:03 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14016.1785252655926447610
 for <u-boot-amlogic@groups.io>;
 Tue, 28 Jul 2026 08:30:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=I6zFW8Jk;
 spf=pass (domain: linaro.org, ip: 209.85.221.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so2807075f8f.2
        for <u-boot-amlogic@groups.io>; Tue, 28 Jul 2026 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785252654; x=1785857454; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cRwCdResiJWYLvhdUvtsJnkcLCeSZq60+p9PwBTFB3w=;
        b=I6zFW8Jk/w+1QQLFeetwSFR/UJYkgrmA65EjQ+elfc6JqZLf50EmfiFsz7wcFwnJNT
         7QP+X2j9/+RXTAswo8f/Nlv1dYJJJxW0/bTBnTiiJnvPOMj+lIx/mLoOGdxTYXFaBy1E
         EGwoBgouH2wuODUL93hqZOCpWcyIPd09qtJmLoVrNi61u9CUSUltYKiDRElvofrW9md+
         Yyc+7wgJURvZvi49tToh5tUZlFLxrydMCq14WxDpqzzurcfb2FPniVBxj5D+O1B5ttDe
         UC9bVzFwv+1399cLQxqlz1osflQuYaIJuibmOh+Rmxd1Um0nkWJT/kyftNr8L3pikcbS
         SA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785252654; x=1785857454;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cRwCdResiJWYLvhdUvtsJnkcLCeSZq60+p9PwBTFB3w=;
        b=VtJ7ID1MfMX14y40YPg41yp2pNHTMJiF2bpgXP6AVPoWMnOaP7n7Bh7cn39IXJLSKo
         tiNBxbbJFQzzH8XBuvUo+wisUa1Dx4XIIOFdJdKwkoh4JSa4bas/U0BAdc1b22PWMaJG
         toQE91Xi54oCW6WVr0DVeBIAf6X4zvD03XxmVL3Gp5dlHdgyXjknF9uLm8WR7edmPPqE
         6Q5OTs6+VzdFr5JH6aVmB+6PTMqcNCCAGWuVQhzO9k8CUbmP8LcAhyYwWGDKyzeuTwGA
         ea8HJpM2/fG8DRIEoq9ZQaG56vxy2L80dyI+WN2Ef2y4+kksNtUscdBlPAuoQF/q6Dk4
         6+4w==
X-Forwarded-Encrypted: i=1; AHgh+Rq801VKhWHCKTn14A4LIoGEBb+/OAWTb6KjX3nzLyP8sHOPoBJaAx8Tk6Gg2bWVcbYRJwLGqQv7xrhUZFqpTg==@groups.io
X-Gm-Message-State: AOJu0YwhOuVlYZTGgH4Fa+embguTf72Dr26u1/Q/VqJoirkegxIft9Zi
	itwX076hvxFy/fMKGRpwiPhAVkLd0KMDtc/80BqcG/UQxG6A95UGjYWFRLlG/M3aIBc=
X-Gm-Gg: AR+sD12nahqtQFT52/a+7Na/G20cOJGOkuAnHOLvS7po2Shsy73LGHhsRrr3fe7I0bd
	xIbhXc1hNSKn88ZQR+k/DAaERyBovlWh0TIWEmEcQUghDIRF5FbUbtmu2PJDaa3k53QYBkmw9PG
	hjb0gxN3EzT9uAsGLZyFzucOk0+lty0AlpMu4pWfx462byKILJuqy4TTroaUdkeErUgCHPXuc14
	AUGyFDjifu58vSOjsMwbIFMu1thIVqnA6fee94pYbz7pW8UKIIU+Spr11NRX+AIRbh0BE585sSN
	KVTaAITlD8/zO+agyJ7YdSK3pBX4pDqBYA1hPEkoymclwmAUPURkQKUkygBJDEJk3qxxd3xpG4C
	lXXxTsS/2P9phsx2y9NQEUgZNGEUnyGb09wV7FQDqWEKnH9D2eC6qq+rqRovABnFaT7PLcGh7SL
	0pEaVM6W57LR7AVSuZFC0b3y0MMGyE0SBcXiesQYFYFfRPa+rChOTfzhqmJA==
X-Received: by 2002:a05:6000:438a:b0:47f:83b3:2cb2 with SMTP id ffacd0b85a97d-47fb1f35833mr3358606f8f.57.1785252653503;
        Tue, 28 Jul 2026 08:30:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6843:9af3:9745:9034? ([2a01:e0a:106d:1080:6843:9af3:9745:9034])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531afsm65919794f8f.24.2026.07.28.08.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 08:30:52 -0700 (PDT)
Message-ID: <d7cc44ae-cbb0-4108-9f48-f5a3cd0fa2fa@linaro.org>
Date: Tue, 28 Jul 2026 17:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 00/36] clk: port Linux Common Clock Framework to U-Boot
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sumit Garg <sumit.garg@kernel.org>, Paul Barker <paul@pbarker.dev>,
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com,
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Michal Simek <michal.simek@amd.com>, Liviu Dudau <liviu.dudau@foss.arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Mario Six <mario.six@gdsys.cc>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Andre Przywara <andre.przywara@arm.com>, Thierry Reding
 <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Yao Zi <me@ziyao.cc>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
References: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 28 Jul 2026 15:31:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3013

Hi,

On 7/20/26 18:40, Casey Connolly wrote:
> This series introduces support for the Linux Common Clock framework in
> U-Boot, when enabled it replaces UCLASS_CLK entirely, instead offering
> the typical clock provider API from Linux. This has the significant
> advantage of allowing one "udevice" to provide an arbitrary number
> of clocks without the need to populate U-Boot driver model with dummy
> devices.
> 
> Historically, U-Boots clock support has focused on being small and
> simple, allowing platforms to configure the clocks they need to boot.
> But as we support more modern SoCs it's become clear that the existing
> API doesn't scale as we need to be able to calculate clock rates, handle
> reparenting, and other more complicated configurations. Rather than
> trying to re-invent the wheel here (which would likely never leave us
> with a truly satisfactory solution) adopting the Linux API solves a
> whole host of problems in U-Boot.
> 
> With the Linux CCF, complicated Linux clock drivers can now be adopted
> with relative ease rather than having to painfully rewrite them to work
> in U-Boots limited clock model. This also drastically simplifies the
> bringup process for new platforms.
> 
> To offer an example, the DSI PHY devices on most Qualcomm platforms
> have their own VCO, PLL, dividers, and muxes which are programmed
> based on the pixel clock of the display, if it's using D-phy or
> C-phy, display stream compression, etc. This isn't directly modelled
> in devicetree though since the PHY clock outputs are routed into the
> "dispcc" block which is what the DSI controller itself sees. Modelling
> the relationship between the pixel/byte clocks in dispcc and their
> parents in the phy must be handled by the clock framework and though
> assigned-clock-parents, something that U-Boots existing clock framework
> simply doesn't support. Additionally, dual-DSI panels are even more
> annoying since both sets of pixel/byte clocks are sourced from only one
> of the PHYs.
> 
> U-Boot did already have some very limited support for "CCF", however
> this is essentially just using the driver model to maintain the clock
> tree and registering a device for each clock. This simply doesn't
> scale well for the huge number of clocks on modern platforms and still
> requires significant effort to port drivers from Linux.
> 
> There is one notable limitation with the full CCF port, since it
> requires the entire clock tree to be modelled before it can actually
> manage any clocks it isn't feasible to run pre-relocation making it
> unsuitable for platforms that require clocks at this point. My hope is
> that we can continue to reduce the complexity of U-Boots pre-relocation
> stage to mitigate this issue, but since some platforms are already using
> CONFIG_SKIP_EARLY_DM I hope this won't be a blocking issue.
> 
> When it comes to U-Boot SPL, it likely doesn't make sense to expect to
> use CCF in that environment. Since the scope of SPL is so much smaller
> it should still be acceptable to use UCLASS_CLK here and only build with
> CCF for full U-Boot images.
> 
> -- Overview --
> 
> This series contains a few preparatory patches to align U-Boots
> existing clock API with upstream and rename clk_ops to clk_ops_uboot to
> differentiate UCLASS_CLK ops.
> 
> The generic CCF mux/div/fixed clock drivers are in drivers/clk/ccf along
> with the CCF core.
> 
> Sandbox also gets CCF_FULL support for the purposes of testing.
> 
> Lastly, the Qualcomm clock drivers from Linux are ported over with
> minimal changes to enable CCF support on the SM8650 platform, this will
> be expanded in the future to other Qualcomm platforms. This demonstrates
> the ease of porting Linux drivers and acts as a template that others
> can follow.
> 
> -- Architecture --
> 
> The CCF port is fairly straightforward, clk-uclass.c has some its common
> API split out into clk-common.c which either calls into clk-uclass or
> ccf/clk.c based on the configuration. To keep things simple, CLK_UCLASS
> is completely unsupported when CCF is enabled, by not building
> clk-uclass.c we don't provide any support for non-CCF clocks and they
> won't show up in the device model at runtime.
> 
> Devices that provide clocks can be of any uclass, they will be probed
> via ofnode lookup and should register their clocks with CCF (via the
> typical clk_register helpers) during probe.
> 
> Clock consumers still work the same way, although internal API
> differences may require changes to some drivers such as the UFS fixes in
> this series. Notably it may be necessary to actually call clk_set_rate()
> with a suitable rate, I think it's safe to say these calls being
> missing and relying on the clock driver to pick a suitable rate is a bug
> regardless of CCF.
> 
> -- Merging and maintenance --
> 
> Given the scope and complexity of this change and that it's entirely
> opt-in, I'm hopeful that we can focus on issues that are important to
> solve before this can be merged, and focus on improving any rough edges
> after the fact. This will also make it easier for others to try it out
> and investigate using CCF_FULL for their platforms.
> 
> In the short-medium term I'm happy to maintain this port and help others
> who are interested in using it. However I very much invite anyone with
> an interest in this to co-maintain it or take it over in the future.
> 
> I previously sent an RFC for this which can be found below, it has gone
> through some significant rework since then and quite a bit of testing
> locally as I've used this as the basis for Qualcomm display bringup.
> 
> https://lore.kernel.org/u-boot/20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org/
> 
> ---
> Casey Connolly (36):
>        clk: move U-Boot CCF to clk/uccf
>        clk: rename clk_ops to clk_ops_uboot
>        clk: move fixed clocks to clk/basic
>        clk: make clk_set_rate() return signed long
>        clk: make clk_get_parent_rate return signed long
>        clk: compat: add clk (un)prepare and associated functions
>        dm: ofnode: fix parse_phandle_with_args API
>        clk: import full CCF from Linux
>        clk: move clock flags to common clk-provider.h
>        clk/ccf: adapt clk-conf for U-Boot
>        clk/ccf: adapt CCF core for U-Boot
>        clk/ccf: adapt CCF generic clocks for U-Boot
>        clk: split clk-uclass.c into clk-common.c
>        clk/common: add CCF_FULL support
>        clk/ccf: optimise orphan clock handling
>        clk/ccf: debug log enable/disable calls
>        cmd/clk: add CCF_FULL support
>        doc: describe Common Clock Framework
>        clk/sandbox: add a CCF_FULL port of clk_sandbox
>        clk: sandbox: fix set_rate and move to clk/basic
>        clk/ccf: add CCF_FULL port of clk_sandbox
>        test: dm: adjust clk tests for CCF_FULL
>        configs: add sandbox CCF_FULL defconfig
>        CI: add sandbox64_ccf_full
>        MAINTAINERS: add entry for CCF port
>        clk/qcom: move existing clock drivers to clk/qcom/basic
>        clk/qcom: drop in Linux Qualcomm CCF drivers
>        clk/qcom/ccf: drop in Linux rpmh clock driver
>        clk/qcom/ccf: add sm8650 GCC, dispcc and tcsrcc.
>        clk/qcom/ccf: add uboot common code
>        clk/qcom/ccf: adapt common, gdsc, and reset code for U-Boot
>        clk/qcom/ccf: adapt clocks for U-Boot
>        clk/qcom/ccf: adapt sm8650 clock drivers for U-Boot
>        ufs: qcom: use clk_prepare_enable_bulk()
>        qcom_sm8650_defconfig: enable CCF_FULL
>        ufs: qcom: fix core clk max rate setting

I tried to apply it to v2026.10-rc1 but it doesn't apply cleanly,
what are the dependencies ?

I'll probably try to port the Linux Amlogic clock drivers with the
CCF FULL, it should probably work 1:1 since we mimic the Linux
behviour with the basic U-Boot clock driver.

Also please share a branch from where to pull the changes for such large
patchsets.

Thanks,
Neil

> 
>   .gitlab-ci.yml                                     |    5 +
>   MAINTAINERS                                        |    7 +
>   arch/arm/cpu/armv7/bcm281xx/clk-core.c             |    8 +-
>   arch/arm/cpu/armv7/bcm281xx/clk-core.h             |   14 +-
>   arch/sandbox/dts/test.dts                          |    4 +-
>   arch/sandbox/include/asm/clk.h                     |    2 +-
>   cmd/clk.c                                          |   21 +-
>   configs/qcom_sm8650_defconfig                      |    1 +
>   configs/sandbox64_ccf_full_defconfig               |    5 +
>   doc/api/clk.rst                                    |   25 +
>   doc/develop/ccf.rst                                |   35 +
>   doc/develop/index.rst                              |    1 +
>   drivers/clk/Kconfig                                |   54 +-
>   drivers/clk/Makefile                               |   21 +-
>   drivers/clk/adi/clk-adi-pll.c                      |    2 +-
>   drivers/clk/adi/clk-shared.c                       |    4 +-
>   drivers/clk/adi/clk.h                              |    2 +-
>   drivers/clk/airoha/clk-airoha.c                    |    4 +-
>   drivers/clk/altera/clk-agilex.c                    |    2 +-
>   drivers/clk/altera/clk-agilex5.c                   |    2 +-
>   drivers/clk/altera/clk-arria10.c                   |    2 +-
>   drivers/clk/altera/clk-mem-n5x.c                   |    2 +-
>   drivers/clk/altera/clk-n5x.c                       |    2 +-
>   drivers/clk/aspeed/clk_ast2500.c                   |    4 +-
>   drivers/clk/aspeed/clk_ast2600.c                   |    4 +-
>   drivers/clk/aspeed/clk_ast2700.c                   |    4 +-
>   drivers/clk/at91/clk-generic.c                     |    4 +-
>   drivers/clk/at91/clk-main.c                        |    8 +-
>   drivers/clk/at91/clk-master.c                      |    8 +-
>   drivers/clk/at91/clk-peripheral.c                  |    6 +-
>   drivers/clk/at91/clk-programmable.c                |    4 +-
>   drivers/clk/at91/clk-sam9x60-pll.c                 |   10 +-
>   drivers/clk/at91/clk-sam9x60-usb.c                 |    4 +-
>   drivers/clk/at91/clk-system.c                      |    2 +-
>   drivers/clk/at91/clk-utmi.c                        |    4 +-
>   drivers/clk/at91/compat.c                          |   30 +-
>   drivers/clk/at91/pmc.c                             |    2 +-
>   drivers/clk/at91/pmc.h                             |    2 +-
>   drivers/clk/at91/sckc.c                            |    4 +-
>   drivers/clk/basic/Makefile                         |    8 +
>   drivers/clk/{ => basic}/clk_fixed_factor.c         |    2 +-
>   drivers/clk/{ => basic}/clk_fixed_rate.c           |    4 +-
>   drivers/clk/{ => basic}/clk_sandbox.c              |   12 +-
>   drivers/clk/ccf/Kconfig                            |    8 +
>   drivers/clk/ccf/Makefile                           |   19 +
>   drivers/clk/ccf/clk-composite.c                    |  495 +++
>   drivers/clk/ccf/clk-conf.c                         |  189 +
>   drivers/clk/ccf/clk-divider.c                      |  663 ++++
>   drivers/clk/ccf/clk-fixed-factor.c                 |  409 +++
>   drivers/clk/ccf/clk-fixed-rate.c                   |  217 ++
>   drivers/clk/ccf/clk-gate.c                         |  260 ++
>   drivers/clk/ccf/clk-mux.c                          |  282 ++
>   drivers/clk/ccf/clk.c                              | 3250 +++++++++++++++++
>   drivers/clk/ccf/clk.h                              |   53 +
>   drivers/clk/ccf/clk_sandbox.c                      |  281 ++
>   drivers/clk/ccf/clk_sandbox_ccf_full.c             |  220 ++
>   drivers/clk/clk-cdce9xx.c                          |    4 +-
>   drivers/clk/clk-common.c                           |  255 ++
>   drivers/clk/clk-common.h                           |   45 +
>   drivers/clk/clk-gpio.c                             |    2 +-
>   drivers/clk/clk-hsdk-cgu.c                         |    4 +-
>   drivers/clk/clk-stub.c                             |    4 +-
>   drivers/clk/clk-uclass.c                           |  202 +-
>   drivers/clk/clk-xlnx-clock-wizard.c                |    4 +-
>   drivers/clk/clk_bcm6345.c                          |    2 +-
>   drivers/clk/clk_boston.c                           |    2 +-
>   drivers/clk/clk_k210.c                             |    8 +-
>   drivers/clk/clk_octeon.c                           |    2 +-
>   drivers/clk/clk_pic32.c                            |    4 +-
>   drivers/clk/clk_sandbox_test.c                     |    2 +-
>   drivers/clk/clk_scmi.c                             |    6 +-
>   drivers/clk/clk_versaclock.c                       |   22 +-
>   drivers/clk/clk_versal.c                           |    4 +-
>   drivers/clk/clk_vexpress_osc.c                     |    4 +-
>   drivers/clk/clk_zynq.c                             |    8 +-
>   drivers/clk/clk_zynqmp.c                           |    6 +-
>   drivers/clk/exynos/clk-exynos7420.c                |    6 +-
>   drivers/clk/exynos/clk-pll.c                       |    4 +-
>   drivers/clk/exynos/clk.h                           |    2 +-
>   drivers/clk/ics8n3qv01.c                           |    4 +-
>   drivers/clk/imx/clk-composite-8m.c                 |    6 +-
>   drivers/clk/imx/clk-composite-93.c                 |    2 +-
>   drivers/clk/imx/clk-fracn-gppll.c                  |    4 +-
>   drivers/clk/imx/clk-gate-93.c                      |    4 +-
>   drivers/clk/imx/clk-gate2.c                        |    4 +-
>   drivers/clk/imx/clk-imx6q.c                        |    2 +-
>   drivers/clk/imx/clk-imx6ul.c                       |    2 +-
>   drivers/clk/imx/clk-imx8.c                         |    4 +-
>   drivers/clk/imx/clk-imx8.h                         |    2 +-
>   drivers/clk/imx/clk-imx8qm.c                       |    2 +-
>   drivers/clk/imx/clk-imx8qxp.c                      |    2 +-
>   drivers/clk/imx/clk-imxrt1020.c                    |    2 +-
>   drivers/clk/imx/clk-imxrt1170.c                    |    4 +-
>   drivers/clk/imx/clk-pfd.c                          |    4 +-
>   drivers/clk/imx/clk-pll14xx.c                      |    8 +-
>   drivers/clk/imx/clk-pllv3.c                        |   18 +-
>   drivers/clk/intel/clk_intel.c                      |    2 +-
>   drivers/clk/mediatek/clk-mtk.c                     |   14 +-
>   drivers/clk/mediatek/clk-mtk.h                     |   10 +-
>   drivers/clk/meson/a1.c                             |    8 +-
>   drivers/clk/meson/axg-ao.c                         |    2 +-
>   drivers/clk/meson/axg.c                            |    2 +-
>   drivers/clk/meson/clk-measure.c                    |    2 +-
>   drivers/clk/meson/g12a-ao.c                        |    2 +-
>   drivers/clk/meson/g12a.c                           |   10 +-
>   drivers/clk/meson/gxbb.c                           |    8 +-
>   drivers/clk/microchip/mpfs_clk_cfg.c               |    4 +-
>   drivers/clk/microchip/mpfs_clk_msspll.c            |    2 +-
>   drivers/clk/microchip/mpfs_clk_periph.c            |    2 +-
>   drivers/clk/mpc83xx_clk.c                          |    2 +-
>   drivers/clk/mtmips/clk-mt7620.c                    |    2 +-
>   drivers/clk/mtmips/clk-mt7621.c                    |    2 +-
>   drivers/clk/mtmips/clk-mt7628.c                    |    2 +-
>   drivers/clk/mvebu/armada-37xx-periph.c             |    4 +-
>   drivers/clk/mvebu/armada-37xx-tbg.c                |    2 +-
>   drivers/clk/nuvoton/clk_npcm.c                     |    4 +-
>   drivers/clk/nuvoton/clk_npcm.h                     |    2 +-
>   drivers/clk/owl/clk_owl.c                          |    6 +-
>   drivers/clk/qcom/Kconfig                           |    1 +
>   drivers/clk/qcom/Makefile                          |   31 +-
>   drivers/clk/qcom/basic/Makefile                    |   28 +
>   drivers/clk/qcom/{ => basic}/clock-apq8016.c       |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-apq8096.c       |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-ipq4019.c       |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-ipq5424.c       |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-ipq9574.c       |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-milos.c         |    4 +-
>   drivers/clk/qcom/{ => basic}/clock-qcm2290.c       |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-qcom.c          |    4 +-
>   drivers/clk/qcom/{ => basic}/clock-qcom.h          |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-qcs404.c        |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-qcs615.c        |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-qcs8300.c       |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-sa8775p.c       |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-sc7280.c        |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-sdm845.c        |    4 +-
>   drivers/clk/qcom/{ => basic}/clock-sm6115.c        |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-sm6125.c        |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-sm6350.c        |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-sm7150.c        |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-sm8150.c        |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-sm8250.c        |    2 +-
>   drivers/clk/qcom/{ => basic}/clock-sm8550.c        |    4 +-
>   drivers/clk/qcom/{ => basic}/clock-sm8650.c        |    4 +-
>   drivers/clk/qcom/{ => basic}/clock-x1e80100.c      |    4 +-
>   drivers/clk/qcom/ccf/Makefile                      |   21 +
>   drivers/clk/qcom/ccf/clk-alpha-pll.c               | 3196 ++++++++++++++++
>   drivers/clk/qcom/ccf/clk-alpha-pll.h               |  251 ++
>   drivers/clk/qcom/ccf/clk-branch.c                  |  203 ++
>   drivers/clk/qcom/ccf/clk-branch.h                  |  125 +
>   drivers/clk/qcom/ccf/clk-rcg.h                     |  217 ++
>   drivers/clk/qcom/ccf/clk-rcg2.c                    | 1765 +++++++++
>   drivers/clk/qcom/ccf/clk-regmap-divider.c          |   90 +
>   drivers/clk/qcom/ccf/clk-regmap-divider.h          |   22 +
>   drivers/clk/qcom/ccf/clk-regmap-mux-div.c          |  232 ++
>   drivers/clk/qcom/ccf/clk-regmap-mux-div.h          |   44 +
>   drivers/clk/qcom/ccf/clk-regmap-mux.c              |   57 +
>   drivers/clk/qcom/ccf/clk-regmap-mux.h              |   23 +
>   drivers/clk/qcom/ccf/clk-regmap-phy-mux.c          |   62 +
>   drivers/clk/qcom/ccf/clk-regmap-phy-mux.h          |   33 +
>   drivers/clk/qcom/ccf/clk-regmap.c                  |  104 +
>   drivers/clk/qcom/ccf/clk-regmap.h                  |   38 +
>   drivers/clk/qcom/ccf/clk-rpmh.c                    | 1030 ++++++
>   drivers/clk/qcom/ccf/common-uboot.c                |  188 +
>   drivers/clk/qcom/ccf/common-uboot.h                |   34 +
>   drivers/clk/qcom/ccf/common.c                      |  248 ++
>   drivers/clk/qcom/ccf/common.h                      |  106 +
>   drivers/clk/qcom/ccf/dispcc-sm8550.c               | 1825 ++++++++++
>   drivers/clk/qcom/ccf/gcc-sm8650.c                  | 3846 ++++++++++++++++++++
>   drivers/clk/qcom/ccf/gdsc.c                        |  545 +++
>   drivers/clk/qcom/ccf/gdsc.h                        |  103 +
>   drivers/clk/qcom/ccf/reset.c                       |  112 +
>   drivers/clk/qcom/ccf/reset.h                       |   29 +
>   drivers/clk/qcom/ccf/tcsrcc-sm8650.c               |  174 +
>   drivers/clk/qcom/clock-sc7180.c                    |    2 +-
>   drivers/clk/renesas/clk-rcar-gen2.c                |    4 +-
>   drivers/clk/renesas/clk-rcar-gen3.c                |    4 +-
>   drivers/clk/renesas/compound-clock.c               |    4 +-
>   drivers/clk/renesas/r8a78000-cpg.c                 |    6 +-
>   drivers/clk/renesas/r9a06g032-clocks.c             |    6 +-
>   drivers/clk/renesas/rcar-gen2-cpg.h                |    2 +-
>   drivers/clk/renesas/rcar-gen3-cpg.h                |    2 +-
>   drivers/clk/renesas/rzg2l-cpg.c                    |    8 +-
>   drivers/clk/rockchip/clk_px30.c                    |   12 +-
>   drivers/clk/rockchip/clk_rk3036.c                  |    4 +-
>   drivers/clk/rockchip/clk_rk3066.c                  |    4 +-
>   drivers/clk/rockchip/clk_rk3128.c                  |    4 +-
>   drivers/clk/rockchip/clk_rk3188.c                  |    4 +-
>   drivers/clk/rockchip/clk_rk322x.c                  |    4 +-
>   drivers/clk/rockchip/clk_rk3288.c                  |    4 +-
>   drivers/clk/rockchip/clk_rk3308.c                  |    4 +-
>   drivers/clk/rockchip/clk_rk3328.c                  |    4 +-
>   drivers/clk/rockchip/clk_rk3368.c                  |    4 +-
>   drivers/clk/rockchip/clk_rk3399.c                  |    8 +-
>   drivers/clk/rockchip/clk_rk3506.c                  |    4 +-
>   drivers/clk/rockchip/clk_rk3528.c                  |   10 +-
>   drivers/clk/rockchip/clk_rk3568.c                  |   14 +-
>   drivers/clk/rockchip/clk_rk3576.c                  |    8 +-
>   drivers/clk/rockchip/clk_rk3588.c                  |   12 +-
>   drivers/clk/rockchip/clk_rv1108.c                  |    4 +-
>   drivers/clk/rockchip/clk_rv1126.c                  |   12 +-
>   drivers/clk/sifive/sifive-prci.c                   |    4 +-
>   drivers/clk/sophgo/clk-cv1800b.c                   |    4 +-
>   drivers/clk/sophgo/clk-ip.c                        |   30 +-
>   drivers/clk/sophgo/clk-ip.h                        |   18 +-
>   drivers/clk/sophgo/clk-pll.c                       |    8 +-
>   drivers/clk/sophgo/clk-pll.h                       |    4 +-
>   drivers/clk/starfive/clk-jh7110-pll.c              |    4 +-
>   drivers/clk/starfive/clk.h                         |    2 +-
>   drivers/clk/stm32/clk-stm32-core.c                 |   22 +-
>   drivers/clk/stm32/clk-stm32-core.h                 |    2 +-
>   drivers/clk/stm32/clk-stm32f.c                     |    4 +-
>   drivers/clk/stm32/clk-stm32h7.c                    |    2 +-
>   drivers/clk/stm32/clk-stm32mp1.c                   |    4 +-
>   drivers/clk/sunxi/clk_sun6i_rtc.c                  |    2 +-
>   drivers/clk/sunxi/clk_sunxi.c                      |    2 +-
>   drivers/clk/tegra/tegra-car-clk.c                  |    4 +-
>   drivers/clk/tegra/tegra186-clk.c                   |    4 +-
>   drivers/clk/thead/clk-th1520-ap.c                  |    8 +-
>   drivers/clk/ti/clk-am3-dpll-x2.c                   |    2 +-
>   drivers/clk/ti/clk-am3-dpll.c                      |    4 +-
>   drivers/clk/ti/clk-ctrl.c                          |    2 +-
>   drivers/clk/ti/clk-divider.c                       |    4 +-
>   drivers/clk/ti/clk-gate.c                          |    2 +-
>   drivers/clk/ti/clk-k3-pll.c                        |    4 +-
>   drivers/clk/ti/clk-k3.c                            |    6 +-
>   drivers/clk/ti/clk-mux.c                           |    4 +-
>   drivers/clk/ti/clk-sci.c                           |    4 +-
>   drivers/clk/uccf/Kconfig                           |   22 +
>   drivers/clk/uccf/Makefile                          |   11 +
>   drivers/clk/{ => uccf}/clk-composite.c             |   20 +-
>   drivers/clk/{ => uccf}/clk-divider.c               |    4 +-
>   drivers/clk/{ => uccf}/clk-fixed-factor.c          |    2 +-
>   drivers/clk/{ => uccf}/clk-gate.c                  |    2 +-
>   drivers/clk/{ => uccf}/clk-mux.c                   |    2 +-
>   drivers/clk/{ => uccf}/clk.c                       |    4 +-
>   .../{clk_sandbox_ccf.c => uccf/clk_sandbox_uccf.c} |   12 +-
>   drivers/clk/uniphier/clk-uniphier-core.c           |    6 +-
>   drivers/core/ofnode.c                              |    4 +-
>   drivers/phy/cadence/phy-cadence-sierra.c           |    2 +-
>   drivers/phy/cadence/phy-cadence-torrent.c          |    2 +-
>   drivers/phy/phy-stm32-usbphyc.c                    |    2 +-
>   drivers/phy/phy-ti-am654.c                         |    2 +-
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |    2 +-
>   drivers/phy/ti/phy-j721e-wiz.c                     |    6 +-
>   drivers/power/domain/imx8mp-hsiomix.c              |    2 +-
>   drivers/ufs/ufs-qcom.c                             |   31 +-
>   include/clk-uclass.h                               |    6 +-
>   include/clk.h                                      |  102 +-
>   include/linux/clk-provider-ccf_full.h              | 1461 ++++++++
>   include/linux/clk-provider-uccf.h                  |  256 ++
>   include/linux/clk-provider.h                       |  253 +-
>   include/linux/clk/clk-conf.h                       |   22 +
>   include/sandbox-clk.h                              |    5 +-
>   test/dm/Makefile                                   |    3 +-
>   test/dm/clk.c                                      |   32 +-
>   test/dm/clk_ccf.c                                  |  117 +-
>   test/test-main.c                                   |    6 +
>   258 files changed, 24032 insertions(+), 997 deletions(-)
> ---
> base-commit: e0ef25054db31fee49d031ac337099b12c67e5b8
> 
> Casey Connolly <casey.connolly@linaro.org>
> 


