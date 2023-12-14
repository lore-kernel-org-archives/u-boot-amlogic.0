Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63842C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 14:53:19 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.24241.1702565595223775987
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 06:53:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ye1iQmw8;
 spf=pass (domain: linaro.org, ip: 209.85.208.173, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c9f8faf57bso105392601fa.3
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 06:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702565593; x=1703170393; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skXGbXSIreTR378cHYiM0gsCg47hJf9aYIfMnwZnJOA=;
        b=ye1iQmw8qLcvDOm/mJvwg7YXFEhOpiMdLsD388O0t7Z4FLOyhqBx7XbINpn63G4xEN
         z8lSEFFY+mzItvM0pmSzKgwD/+MFWtJXAt4tp1ddIC5Idpjy5TIHyFOvZlP+xZKA0Dpq
         jIz0N4k+b1/8gtsb7J8RrlepCd9bnPf5P2qkQuHn8hrYOz5fDjHD45oKd9lnBBKiQ7Uv
         AZL2FADofkCTkaaD+loLYhpoFIRoFIcODZ7vFn9HK7op4ru74V//a/bIBj56d5MKx6GF
         ORgJPFwXGu73EO9c7KiEV5JVu11GiiorKW7Ki/8EqF3cVv/YkboYNezRBWXpUaUGsKtc
         7OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702565593; x=1703170393;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=skXGbXSIreTR378cHYiM0gsCg47hJf9aYIfMnwZnJOA=;
        b=dnoU4ePz7lNRCc4yRcnSoPMP4DTGbyfJsFUuQ2Kwx+38y1txPPPfDhwQ2+5ia+ot66
         2kkGrMcW032uY8p7dVb8MmNf/2uQsOo9QrnusBoMygBNMj+AkvieqGJ2y0iPOTH0vuXz
         X6UkIRewLp+mOKdNbxlHkloml11ZpPIwpKxTTO/t4QHjAqZ23832AAiVVKCM+XhY6Klj
         g6LeloJm1DTpn459BIDJnQOldowQilulMuvl5JNEvzOOezsXR6oBCLrKDUumU7vrp6Fl
         mvm1Qn/Xx8ApiUvr95oA8YS38zfSsrugqmjb51srUx/gE+sxl2F8EbkZLKbuPPoiOgsS
         stcQ==
X-Gm-Message-State: AOJu0YyXk7Q/VYLUSHfa8SyZYpEc7JGbyUeohJ3wvIM/s1YDmhCzV4HV
	ViwVNDz6loMddSsFpzpZqglcYA==
X-Google-Smtp-Source: AGHT+IHyaE024GLfsR+Wc4ryyIrZYr/2H4ovYTdMbPruIU33VMS2BT3rzXtgdRHHKojUAmfund7rWA==
X-Received: by 2002:a2e:8e39:0:b0:2cc:41f1:a53c with SMTP id r25-20020a2e8e39000000b002cc41f1a53cmr611359ljk.7.1702565593213;
        Thu, 14 Dec 2023 06:53:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1ec5:7f64:7775:e1e3? ([2a01:e0a:982:cbb0:1ec5:7f64:7775:e1e3])
        by smtp.gmail.com with ESMTPSA id x14-20020adfdd8e000000b0033630da3528sm6670578wrl.25.2023.12.14.06.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 06:53:12 -0800 (PST)
Message-ID: <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
Date: Thu, 14 Dec 2023 15:53:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 14:53:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1926

Hi,

On 14/12/2023 14:50, Sumit Garg wrote:
> Prerquisite

s/Prerquisite/Prerequisite/

> -----------
> 
> This patch series requires devicetree-rebasing git repo to be added as a
> subtree to the main U-boot repo via:
> 
> $ git subtree add --prefix devicetree-rebasing \
>        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>        v6.6-dts --squash

So I think the big question is: when should the subtree be updated ?

Because as we discussed in the previous GH pull request, if a bindings changes
was made in the upstream Linux DT, then the subtree update should wait until
the u-boot support is merged before updating. This could cause a lot of frustration.

And this could cause a lot of regressions, even more if both Linux and U-boot are
not maintained by the same people.

Neil

> 
> Background
> ----------
> 
> This effort started while I was reviewing patch series corresponding to
> Qcom platforms [1] which was about to import modified devicetree source
> files from Linux kernel. I suppose keeping devicetree files sync with
> Linux kernel without any DT bindings schema validation has been a pain
> for U-boot SoC/platform maintainers. There has been past discussions
> about a single DT repo but that hasn't come up and Linux kernel remained
> the place where DT source files as well as bindings are placed and
> maintained.
> 
> However, Linux kernel DT maintainers proposed [2] for U-boot to rather
> use devicetree-rebasing repo [3] which is a forked copy from Linux
> kernel for DT source files as well as bindings. It is tagged at every
> Linux kernel major release or intermideate release candidates. So here I
> have tried to reuse that to bring DT bingings compliance as well as a
> standard way to maintain a regular sync of DT source files with Linux
> kernel.
> 
> In order to maintain devicetree files sync, U-boot will maintains a Git
> subtree for devicetee-rebasing repo as `devicetee-rebasing/` sub-directory.
> It will be regularly updated with every new kernel major release via
> subtree pull as follows::
> 
> $ git subtree pull --prefix devicetree-rebasing \
>        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>        <release-tag> --squash
> 
> The RFC/prototype for this series has been discussed with Linux DT
> maintainers as well as U-boot maintainers here [4]. Now we would like to
> reach out to wider U-boot community to seek feedback.
> 
> [1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
> [2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> [4] https://github.com/u-boot/u-boot/pull/451
> 
> Changes
> -------
> 
> Traditionally, U-boot placed copies of devicetree source files from Linux
> kernel into `arch/<arch>/dts/<name>.dts`, which can be selected via:
>   
> CONFIG_DEFAULT_DEVICE_TREE "<name>"
>   
> SoC/board maintainers are encouraged to migrate to using mirrored copies
> from `devicetree-rebasing/` into `dts/arch/<arch>/<vendor>` via:
>   
> CONFIG_OF_UPSTREAM=y
> CONFIG_DEFAULT_DEVICE_TREE "<vendor>/<name>"
> 
> An example have been shown for Amlogic meson-gxbb SoC and corresponding
> derived boards via patch #7 and #8.
> 
> Devicetree bindings schema checks
> ---------------------------------
> 
> With devicetee-rebasing Git subtree, the devicetree bindings are also
> regularly synced with Linux kernel as `devicetree-rebasing/Bindings/`
> sub-directory. This allows U-boot to run devicetree bindings schema checks
> which will bring compliance to U-boot core/drivers regarding usage of
> devicetree.
> 
> Dependencies
> ------------
> 
> The DT schema project must be installed in order to validate the DT schema
> binding documents and validate DTS files using the DT schema. The DT schema
> project can be installed with pip:
> 
> $ pip3 install dtschema
> 
> Note that 'dtschema' installation requires 'swig' and Python development
> files installed first. On Debian/Ubuntu systems:
> 
> $ apt install swig python3-dev
> 
> Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
> installed. Ensure they are in your PATH (~/.local/bin by default).
> 
> Recommended is also to install yamllint (used by dtschema when present).
> 
> Running checks
> --------------
> 
> In order to perform validation of DTB files, use the ``dtbs_check`` target:
> 
> $ make dtbs_check
> 
> It is also possible to run checks with a subset of matching schema files by
> setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files
> or patterns (partial match of a fixed string). Each file or pattern should
> be separated by ':'.
> 
> $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
> $ make dtbs_check DT_SCHEMA_FILES=/gpio/
> $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
> 
> Sumit Garg (8):
>    Azure CI: Exclude devicetree-rebasing subtree for CONFIG checks
>    Makefile: Add support for DT bindings schema checks
>    scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
>    dts: Add alternative location for upstream DTB builds
>    doc: devicetree: Updates for devicetree-rebasing subtree
>    MAINTAINERS: Add myself as devicetree-rebasing maintainer
>    dts: meson-gxbb: Switch to using upstream DT
>    dts: meson-gxbb: Drop redundant devicetree files
> 
>   .azure-pipelines.yml                    |   3 +-
>   MAINTAINERS                             |   6 +
>   Makefile                                |  20 +-
>   arch/arm/dts/Makefile                   |   8 -
>   arch/arm/dts/meson-gxbb-kii-pro.dts     | 140 ----
>   arch/arm/dts/meson-gxbb-nanopi-k2.dts   | 415 ------------
>   arch/arm/dts/meson-gxbb-odroidc2.dts    | 418 ------------
>   arch/arm/dts/meson-gxbb-p200.dts        | 100 ---
>   arch/arm/dts/meson-gxbb-p201.dts        |  26 -
>   arch/arm/dts/meson-gxbb-p20x.dtsi       | 250 -------
>   arch/arm/dts/meson-gxbb-wetek-hub.dts   |  58 --
>   arch/arm/dts/meson-gxbb-wetek-play2.dts | 119 ----
>   arch/arm/dts/meson-gxbb-wetek.dtsi      | 292 --------
>   arch/arm/dts/meson-gxbb.dtsi            | 856 ------------------------
>   configs/nanopi-k2_defconfig             |   3 +-
>   configs/odroid-c2_defconfig             |   3 +-
>   configs/p200_defconfig                  |   3 +-
>   configs/p201_defconfig                  |   3 +-
>   configs/videostrong-kii-pro_defconfig   |   3 +-
>   configs/wetek-hub_defconfig             |   3 +-
>   configs/wetek-play2_defconfig           |   3 +-
>   doc/develop/devicetree/control.rst      | 108 ++-
>   dts/Kconfig                             |  11 +
>   dts/Makefile                            |  17 +-
>   dts/arch/arm64/Makefile                 |  23 +
>   dts/arch/arm64/amlogic                  |   1 +
>   scripts/Makefile.lib                    |  42 +-
>   27 files changed, 204 insertions(+), 2730 deletions(-)
>   delete mode 100644 arch/arm/dts/meson-gxbb-kii-pro.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-nanopi-k2.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-odroidc2.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-p200.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-p201.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
>   delete mode 100644 arch/arm/dts/meson-gxbb-wetek-hub.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-wetek-play2.dts
>   delete mode 100644 arch/arm/dts/meson-gxbb-wetek.dtsi
>   delete mode 100644 arch/arm/dts/meson-gxbb.dtsi
>   create mode 100644 dts/arch/arm64/Makefile
>   create mode 120000 dts/arch/arm64/amlogic
> 


