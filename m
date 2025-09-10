Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732F9CA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 07:03:08 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.11318.1757487787610754676
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Sep 2025 00:03:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=kJi8Dki6;
 spf=pass (domain: linaro.org, ip: 209.85.221.42, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so3641974f8f.2
        for <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757487786; x=1758092586; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Um4mbIBpBor6xjVylODbway0xPglGJRf3Ehub4y+HTQ=;
        b=kJi8Dki6nHlwz+CaA9TyDgIEAXJBdNGRmliz0+uDd8BdVQWn5tx7BM7g4I9wu92wDS
         tF0E9jE7Zbz+/QnaNjILJoZdBd6UIjds2uZS19Vf1tjqArEpAHMBLBfqyrLPcOt59YPH
         GYM61Feo4Q863tek7orqSbpGn+ud4FFp7bZwUFf8tv4+djvzNbbSubt2HZGTzjps4XlF
         SLcG0DsYpkEumwIdF644ML5ncBSzg7IH2zqaGs0ffnZHG5nuUI+NjA6gLJ6ecTGYlWYK
         O/FvDB58M2T5wVjOTwTU0yKhDFVAC8tLuFOSTgZCgo9or5brwZSq1wPxAsKSjlaoRGOt
         BX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757487786; x=1758092586;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Um4mbIBpBor6xjVylODbway0xPglGJRf3Ehub4y+HTQ=;
        b=Qc6j8xgQ1RAaTV/NLd/R2VcVBSzjJP8wADSJAzBjjIgF57q/0WKFtIHwco05fIRpiE
         c7bjZ8enCEoTcVOEkL2Rln6BODlMRipEmO+JmB3YZtUY9viMrZ/LToqSyYj4i8CP/K5a
         7tziOhf+lmA4GqbjzohhO5s+I73RScXKgEilyxtIdFc4aJDHO00Nc4zaRmvieHEUCC/m
         yGgpuOcNBuyEZVF39WRmzL8MqLGT+p7cDmHuzFu+Q1sWFDgFSPk71Fyxn0oCrEw7Efee
         2EdgXbDxrjIsZhzs9bhrcOOpm1w/LgXzk+NUhs4lIm4RW9gLHVcgqzf91iBp/yr10g3J
         HJPg==
X-Forwarded-Encrypted: i=1; AJvYcCUfL13qRe71B/sAxFOwf7MwKj1yKb5xO+xx7wBEW42NLjzMELegitZrHkguYG+S5sDeeNQY7wYIHH6DGB3e6Q==@groups.io
X-Gm-Message-State: AOJu0Ywu53+z6FL6feMSZuXgS/ZceT1j4npg27TDmYEdKdSDlHdhBu4I
	DAKCfiUBtneoVP+6Jzg4fQn5+NmTxodBpYcw4IruirpM+kR8wwJ1asxSOffdbDrM2GjvIjEjBUK
	LaZ7rp6s=
X-Gm-Gg: ASbGncuO0z/bjwILjfHwIyZkBhHUtI0lkP9pVpRHHWOtmcUwhDPlUAGbjlS4L3hqzhW
	GdAAGYNSbtJJQC/cvNMIdHa6+qPkCFtAdUi1jEHzO8pTK5XYnOLIbrMtyGjeUS38V7h33eEsYGR
	2/ic97zc5VF66suX5YEpS6YkJGeA2pCmUTd0TVQUPGNUgVlzuvA3qv/ece8tHCLii9k3wGb4RTf
	VRtRMYlJu1uCDVnKXH3FOim1I4A0zx09h1Aa9bMbyLPrYWjP5lEE68SEH6yTAR2DtVgyJDkafpE
	wb3h4ugFmb2cz8QmAM97kVGSJAfvZl1zKRs81ElzWY3r3gPiXcOz1wRwNK8x9bLSssdiHR7EiJR
	x5pht527SNVP9pgXjwjzUi4i7RxQx9Hx9AlFBzpqHoH9FnAgUf39L2ByZDBWlApw9n3gmP+4buL
	wjHt7NxXtxvQ==
X-Google-Smtp-Source: AGHT+IFKQA5ZXG7UX01mOjeiJmp4dpx3VYKO3DNZdLLLwO4Qe1HYbS88Q/wxwcOmVMLRjWPQerwatQ==
X-Received: by 2002:a05:6000:230c:b0:3d0:64c1:1a40 with SMTP id ffacd0b85a97d-3e64374116cmr11500435f8f.46.1757487785858;
        Wed, 10 Sep 2025 00:03:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:29d1:7c56:69a9:30b2? ([2a01:e0a:3d9:2080:29d1:7c56:69a9:30b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f188sm5499000f8f.48.2025.09.10.00.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 00:03:05 -0700 (PDT)
Message-ID: <12661062-d02e-41aa-aa57-d83c05688d7f@linaro.org>
Date: Wed, 10 Sep 2025 09:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 9/9] doc: board: amlogic: add u-boot-spl documentation
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-9-37395d9ff5af@postmarketos.org>
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
In-Reply-To: <20250907-spl-gx-v1-9-37395d9ff5af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 07:03:08 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2762

On 07/09/2025 16:36, Ferass El Hafidi wrote:
> Add building and usage instructions for SPL.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   doc/board/amlogic/index.rst             |  1 +
>   doc/board/amlogic/pre-generated-fip.rst |  9 ++++
>   doc/board/amlogic/spl.rst               | 77 +++++++++++++++++++++++++++++++++
>   3 files changed, 87 insertions(+)
> 
> diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
> index dcd935224ac0280a77455e3475a610fd81cfb80d..23380ac33f2b06efff7d4741ce2967d75671ca13 100644
> --- a/doc/board/amlogic/index.rst
> +++ b/doc/board/amlogic/index.rst
> @@ -78,6 +78,7 @@ Boot Documentation
>   
>      boot-flow
>      pre-generated-fip
> +   spl
>   
>   Board Documentation
>   -------------------
> diff --git a/doc/board/amlogic/pre-generated-fip.rst b/doc/board/amlogic/pre-generated-fip.rst
> index 6a43d776d43f35cbffc7ba9e72bf05dd719f6387..d820bd09115952d4fca2b9e7d7b5a9e30bd11430 100644
> --- a/doc/board/amlogic/pre-generated-fip.rst
> +++ b/doc/board/amlogic/pre-generated-fip.rst
> @@ -98,6 +98,13 @@ The repo also provides the following files used with GXBB boards:
>   The repo also supports the open-source 'gxlimg' signing tool that can be used to sign
>   U-Boot binaries for GXL/GXM/G12A/G12B/SM1 boards: https://github.com/repk/gxlimg
>   
> +The following binaries can be replaced with open-source implementations:
> +
> +- bl2.bin (GXBB and GXL only)
> +- bl31.img (GXBB, GXL, AXG and G12A only)
> +
> +Refer to `Experimental U-Boot SPL Support`_ if you wish to replace them.
> +
>   Licensing
>   ---------
>   
> @@ -129,3 +136,5 @@ clarified. The current Amlogic distribution licence is below:
>       // THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>       // (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>       // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> +
> +.. _`Experimental U-Boot SPL Support`: spl.rst
> diff --git a/doc/board/amlogic/spl.rst b/doc/board/amlogic/spl.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..39d50e3da87d71f62cec1903c441c334bf7020e8
> --- /dev/null
> +++ b/doc/board/amlogic/spl.rst
> @@ -0,0 +1,77 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Experimental U-Boot SPL Support
> +===============================
> +
> +There's some experimental support for some Amlogic SoCs, in U-Boot SPL.  It
> +replaces the proprietary bl2.bin blob used for DRAM init.  Currently Meson GX
> +SoCs (GXBB, GXL) are supported.
> +
> +A subset of Amlogic boards have SPL enabled.  These boards have been tested and
> +known to work to an extent.
> +
> +
> +Building Arm Trusted Firmware (TF-A)
> +------------------------------------
> +
> +This U-Boot SPL port requires the BL31 stage of mainline Arm Trusted
> +Firmware-A firmware. It provides an open source implementation of secure
> +software for Armv8-A. Build it with:
> +
> +.. code-block:: bash
> +
> +    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
> +    $ cd trusted-firmware-a
> +    $ make CROSS_COMPILE=aarch64-linux-gnu- PLAT=your_soc DEBUG=1
> +
> +Replace ``your_soc`` with the SoC target you wish to build for. For GXBB it's
> +``gxbb`` and for GXL it's ``gxl``.
> +
> +
> +Building a bl30_new.bin binary
> +------------------------------
> +
> +``bl30_new.bin`` has both ``bl30.bin`` and ``bl301.bin`` binary blobs
> +bundled. The former is the proper system control processor firmware and the
> +latter is a "plug-in" for board-specific DVFS/suspend-resume parameters. For
> +more info you may wish to read this page: `Pre-Generated FIP File Repo`_.
> +
> +To build using the FIP file repo, simply issue the following commands:
> +
> +.. code-block:: bash
> +
> +    $ cd amlogic-boot-fip/your_board
> +    $ make bl30_new.bin
> +
> +
> +.. _`Pre-Generated FIP File Repo`: pre-generated-fip.rst
> +
> +
> +U-Boot compilation
> +------------------
> +
> +U-Boot SPL is not enabled by default, instead there are config fragments that
> +can be used to enable it, with per-board configuration:
> +
> +- ``spl-libretech-cc-1gb.config``: 1 GB LePotato board
> +- ``spl-libretech-cc-2gb.config``: 2 GB LePotato board
> +- ``spl-odroid-c2.config``: ODROID-C2
> +- ``spl-videostrong-kii-pro.config``: Videostrong KII Pro
> +
> +Pick one of them then:
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=aarch64-linux-gnu-
> +    $ export BL31=path/to/tf-a/bl31.bin                 # Upstream TF-A BL31 binary
> +    $ export SCP=path/to/bl30_new.bin                   # bl30_new.bin binary
> +    $ make <yourboardname>_defconfig spl-<yourboardname>.config
> +    $ make
> +
> +Write to SD:
> +
> +.. code-block:: bash
> +
> +    $ DEV=/dev/boot_device
> +    $ dd if=u-boot-meson-with-spl.bin of=$DEV conv=fsync,notrunc bs=512 seek=1
> +
> 

It's very nice :-)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

