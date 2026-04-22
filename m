Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D56AF9B5E3
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 08:36:31 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.76110.1776846987038961282
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 01:36:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=qjxTI4Xd;
 spf=pass (domain: linaro.org, ip: 209.85.128.43, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488d2079582so60233555e9.2
        for <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 01:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776846985; x=1777451785; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jz4qrRMyBsylfJ/s/qiOcgXr+HmpyhfgN0lrMTstmbQ=;
        b=qjxTI4Xd0vSZHkKRUnQrstwUxLK8l4+DuJU4uL1EydLZNsRBD2Rh3xGXg+bbEXVrCW
         wP5ERzeFsDc+PyM4LeLzOlZnjfecaWpaKx4CopnisXOD3AydkuBHFFg1fFjaeVvIa9nJ
         PEWLldmZF6duJr4l+OzKZMWkcmtwP9r39gt/i1vvgXrsjAl5JSN8aCJKlMoQOs30FN4M
         GEQ7VQwDXCxMyWYrs4YKDpbqSBoV0VUoQJg4nX7POyBLimbpbzlHFKiuPvh0tkFO7iH/
         x0x+4r1fEk59Fw0CCi62UBSvt7ftUHRkYfa6We9LsVaAovroRCyJRT8Z+SHZWZcLviZf
         NqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776846985; x=1777451785;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jz4qrRMyBsylfJ/s/qiOcgXr+HmpyhfgN0lrMTstmbQ=;
        b=Y6Hexvj9whurm9LYkjJo21oETcuiYgaA68EF9a6cwlkieDncXZ4wAZqWXScBmpzMiH
         QRuw/p2ks0PdeV+Zi82uNrW+TqZttl96J87X57Ky9SYbk0MZsgYgskOfDfig40029D7i
         9pBYfQHbO4wSQ0RnYp7O/9ngCAzcLxe/O6kBsRJ2FgCkkJeRN4d9AZIzE9hOpDpJRDST
         XFnPVs4WuTR5kkMEgIVFq/pwT8ig2OmGde+STRpbvEkAHe999XqHA1t17GwvIzXnM5Rf
         MS2kdhqwhY0CD9yaR43GPG00FFFc8cJNlVfNN+fXZ2//72TJFV4d6LxVUQmUIpT4gF4X
         H3Bw==
X-Gm-Message-State: AOJu0YwB7H0OkhNsUfYvvzB5a+Ouw0dEy9mQ7Tq/ATyZsOJcAYuaALwO
	YQ2NlWvWzDIqJU+DPpRQFJneTE5htV2ReliAkYEPQvNNNP3+C/++cUe22oE6ru6Rrq3VXWBZxPc
	4hzgEP+8=
X-Gm-Gg: AeBDievcxHkbWF1rTTR3phGvar4nQJwoJMN2Rl+A/WUAXyzvO59kd8ydHxqazksahMr
	Ie/1gr2Yuoi9lsiAEZSVdVfBrrfyGh76G/jGvSNMbafnYtDM7j2xmc7B6okkLxAS6r8tCecD6Vw
	flznCyrDDV0pT2gFM8e05G8H/ffEE7QnEp+Da0wQ6PYDKZI3K7hGhPcpo0e5CItfEkq0u/ZmmE9
	LTQA6Ajzw6rSFst0fb7gv6lsHQc4637v6lYGZ5Xx7+VdRPIY4/52Uu9jSHQMeXKWrTFVDBAu38E
	sjqFuMOSQ2hkGuvtW6Os8DgTPe1Kp/kVLN6wN/B1osp7Ncl7bDvB/2WPido5NjDiPFDZzRCd2Wm
	q1+S+GlvfZ/BW5X/+hrLoGYr8JfrQ3w7qFCJ7Qpq+M/3p57wkiks1I8NQ/2JTWQCLTuaGlMsNTQ
	56PkCsjLOO3xAeLfnbcw/uFiR/3fkKUSD5DEIjPIwik26vi2ZXfO+pgLnAHeLKrCgO2+yTTvYa6
	M03YKnJmsvX8OvsfQ==
X-Received: by 2002:a05:600c:1d19:b0:48a:525b:e157 with SMTP id 5b1f17b1804b1-48a525be257mr141443195e9.13.1776846982727;
        Wed, 22 Apr 2026 01:36:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:7d92:9cde:4eb2:46d7? ([2a01:e0a:106d:1080:7d92:9cde:4eb2:46d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10019bsm442144685e9.4.2026.04.22.01.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 01:36:22 -0700 (PDT)
Message-ID: <9a187a8f-068a-4889-90a4-cba4c2f06328@linaro.org>
Date: Wed, 22 Apr 2026 10:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] Enable EFI Capsule on Disk on Libre Computer LePotato
 & LaFrite
To: u-boot-amlogic@groups.io, funderscore@postmarketos.org,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
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
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 08:36:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2965

On 4/8/26 22:30, Ferass El Hafidi via groups.io wrote:
> Mostly everything is already in place to enable EFI capsules and in particular
> EFI capsule on disk.
> 
> First, switch all Amlogic boards to use SYSRESET. EFI Capsule on Disk
> functionality expects sysreset to be present. As the current reset_cpu()
> function in board-common.c is basically only doing PSCI reset on U-Boot
> proper, we can replace it with sysreset's PSCI support, which works just
> fine for that purpose provided BL31 is running (SPL stays on an
> SoC-specific reset_cpu() which does for(;;);, as the overhead for
> sysreset is too high and we don't have PSCI yet at that point).
> 
> Then we can enable capsule on disk. LaFrite has Capsule updates enabled
> already, so it is simply a matter of enabling CoD. LePotato does not
> have Capsule updates enabled by default, however it can be easily enabled
> and setup to update u-boot on eMMC/SD.
> 
> With Capsule on Disk setup, it becomes possible to update U-Boot directly
> from Linux, without having to worry about manually using `flashprog`
> (for SPI flash) or `dd` (for eMMC/SD). Instead, thanks to CoD, updates
> can be handled by `fwupd` and applied upon next EFI boot.
> 
> To test:
> 
>   * build U-Boot as usual
> 
>   * in that running U-Boot, run: `efidebug capsule esrt` to get the GUID
>     -OR-
>     run the following in your tree:
> 	tools/mkeficapsule guidgen path_to_devicetree_here U_BOOT_MESON_MMC
> 	                                   (or U_BOOT_MESON_SPI on LaFrite)
> 
>   * proceed with the following guide to create a capsule file:
>     https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#enabling-uefi-capsule-update-feature
> 
>   * generate a .cab file suitable for fwupd using `mkcab`:
>     https://gitlab.postmarketos.org/tauchgang/tauchgang-ci/-/tree/main/mkcab
> 	mkcab u-boot-libretech-cc.capsule GUID-GOES-HERE libretech-cc "LePotato" 2026.04
>     (as of writing, the README.md suggests this is for Qualcomm only. It
>      actually does nothing that is Qualcomm-specific, and works on any
>      board that supports Capsule on Disk and fwupd)
> 
>   * on the board itself, boot to Linux via EFI, install fwupd, copy the resulting
>     .cab file, and run as root:
> 	fwupdtool --force install u-boot-libretech-cc.cab
> 
>   * reboot, make sure you boot over EFI, else the capsule update will not
>     start
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
> Ferass El Hafidi (4):
>        arm: mach-meson: move reset_cpu to spl only
>        arm: meson: enable SYSRESET_PSCI
>        configs: libretech-ac_defconfig: enable EFI Capsule on Disk
>        configs: libretech-cc_defconfig: enable EFI Capsule on Disk
> 
>   arch/arm/mach-meson/Kconfig        |  2 ++
>   arch/arm/mach-meson/board-common.c | 14 --------------
>   arch/arm/mach-meson/spl.c          | 10 ++++++++++
>   configs/libretech-ac_defconfig     |  1 +
>   configs/libretech-cc_defconfig     |  4 ++++
>   5 files changed, 17 insertions(+), 14 deletions(-)
> ---
> base-commit: 4dc4080805fac1b1ed7606ce3bc8fb44a6d59d5e
> change-id: 20260408-b4-amlogic-sysreset-capsules-8f5962defafb
> 
> Best regards,

Got the following failure in CI:

    aarch64:  +   sei510
+
+WARNING: unmet direct dependencies detected for SYSRESET_PSCI
+  Depends on [n]: SYSRESET [=y] && ARM_PSCI_FW [=n]
+  Selected by [y]:
+  - MESON64_COMMON [=y] && ARM [=y] && ARCH_MESON [=y]
+drivers/sysreset/sysreset_psci.c: In function 'psci_sysreset_request':
+drivers/sysreset/sysreset_psci.c:21:17: error: implicit declaration of function 'psci_sys_reset' [-Werror=implicit-function-declaration]
+   21 |                 psci_sys_reset(type);
+      |                 ^~~~~~~~~~~~~~
+drivers/sysreset/sysreset_psci.c:24:17: error: implicit declaration of function 'psci_sys_poweroff' [-Werror=implicit-function-declaration]
+   24 |                 psci_sys_poweroff();
+      |                 ^~~~~~~~~~~~~~~~~
+cc1: all warnings being treated as errors
+make[3]: *** [scripts/Makefile.build:271: drivers/sysreset/sysreset_psci.o] Error 1
+make[2]: *** [scripts/Makefile.build:492: drivers/sysreset] Error 2
+make[1]: *** [Makefile:2205: drivers] Error 2
+make: *** [Makefile:189: __sub-make] Error 2
    aarch64:  +   sei610
+
+WARNING: unmet direct dependencies detected for SYSRESET_PSCI
+  Depends on [n]: SYSRESET [=y] && ARM_PSCI_FW [=n]
+  Selected by [y]:
+  - MESON64_COMMON [=y] && ARM [=y] && ARCH_MESON [=y]
+drivers/sysreset/sysreset_psci.c: In function 'psci_sysreset_request':
+drivers/sysreset/sysreset_psci.c:21:17: error: implicit declaration of function 'psci_sys_reset' [-Werror=implicit-function-declaration]
+   21 |                 psci_sys_reset(type);
+      |                 ^~~~~~~~~~~~~~
+drivers/sysreset/sysreset_psci.c:24:17: error: implicit declaration of function 'psci_sys_poweroff' [-Werror=implicit-function-declaration]
+   24 |                 psci_sys_poweroff();
+      |                 ^~~~~~~~~~~~~~~~~

Could you fix it ?

Neil

