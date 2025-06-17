Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E04C71136
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 08:32:10 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.13687.1750149125999263710
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Jun 2025 01:32:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=njHS+lTF;
 spf=pass (domain: linaro.org, ip: 209.85.128.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-453066fad06so40316125e9.2
        for <u-boot-amlogic@groups.io>; Tue, 17 Jun 2025 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750149124; x=1750753924; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5e8UgkFbIFWIUQBRkWuZBxSGuwk7wSwa+a3JS6rHS0=;
        b=njHS+lTFLxrgbjIjmqQCvuW4AQNUQHpopkruh/WWzM8LflW+xb74z+qa46L+9OdTiI
         a9BYqzBR+farTWIasmHB9etzvMpHLih/P0nqsY69KHTmxKba571mq1zLXRNfC0wDY0n7
         Vmd6vf0/q0Fd9XujH27sbSN4zalcx17MBMdF65pImBPFqimBoZSVs6R0rrnn9LgQmFIH
         B7nmmL4YdVSIVXvPQE1AQeE7dYPTwRGh+4mFBazeo1ORtjOqPZWveDoAZ49/oUifJwXu
         0LfogJ9gKUAOjxNdKKTHQ9fF7pHh5VlRdA7lfQXRo+k6Oern9Gc9VgelLnuQ2I7eD9ke
         /p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750149124; x=1750753924;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q5e8UgkFbIFWIUQBRkWuZBxSGuwk7wSwa+a3JS6rHS0=;
        b=XkwC4ERTT7FfJgJ2Hq3r6S+MKGWJC19DYt8NmETY1W46fLHn5si6vd0ijFoSlp/R9i
         XV+eodxjLvWj70I6FWEEbmDNDZGEFzFF20antPL6EaXooPoWLnY1zRvAMCIxRA1VoQSZ
         qUQNepSaC1qePRL9Mmd/E7i0u5hdFBYNypshDKsn7p2o5mH86kKEwpWu90jgN7kN2iFN
         VeGh1AP0zEYHtECiAfYNP+F0nTk+1aZlvZlSGe9lorOYfzgaLC6/GbeURY675gcfQjos
         G2+y5i0EA930KckIhbFeyR+kF6iylbBNn6sp0j+hnjPhGpU/I65KSGU/LEr5fAFQFN6D
         i3bA==
X-Forwarded-Encrypted: i=1; AJvYcCUbrZw03xu4sK94vJWooqUt5qcL9sN/MkMQY7IP3dzjqoz5+D6oM7I+zBkI4f+49V2Js+bXiZwp6EfYKacOAA==@groups.io
X-Gm-Message-State: AOJu0YwN06nSfe0WtG64gcgSv3hvQS1RuMa3FsQRWD2Kceu9SvjUm0yl
	4Q5rmbqPoEYHweHcGDs7WA+fxLg+qOEn0LkSeI0ZeiV/kfbzL2TOc82sVW9rJagS7jw=
X-Gm-Gg: ASbGncuYQqqDFuViLrAUP2t2RPS2a0rjoqCM8eC2aWyuPoCEBamKC5mw4uRzZlEp12u
	mbj7y7uWrpkKVrFGb1yjOb5PiGZb/sLxIBPPXBiV0e6+bLY/idLH4XpmgYgSdp3NJ78oyUa1mHi
	4X5dmT5dWIBrEUK1/x5PE/mHFwHtF6U0JId4vYD4216fVbkPpJbDL0NxKczWTyaKhVJJLSiqPcW
	xTy6LLlhPcgNgV54M6GDDycvsgf19olDAIZIMkQLKici3lInqKP94hpmWsSFDMPIS3rW+6f5jSd
	DJ1CX5g46sLkty9kcSbNT9tdt6nijpyqm0PY0/1ecYuDASWN7XgOv8nlMy9jeYuMPQctH/DLcGo
	ZYiIFUXysm3/t/gyrJ1zEK2eHPvMazleKtn0Ae6U=
X-Google-Smtp-Source: AGHT+IEDq0I7JXxNk3z1+9cwpMaGJRj4S5TGFD8z9iqrr/48AMDKDX4UcIAWBl/wYe5ViB0av7tbiQ==
X-Received: by 2002:a05:600c:1ca1:b0:453:84a:8cf1 with SMTP id 5b1f17b1804b1-4533cac6479mr96977885e9.33.1750149124315;
        Tue, 17 Jun 2025 01:32:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3819:3250:4f73:db31? ([2a01:e0a:3d9:2080:3819:3250:4f73:db31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e16b425sm165904285e9.34.2025.06.17.01.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 01:32:03 -0700 (PDT)
Message-ID: <85c6a4c0-400d-433c-bcf3-e089f15f0c1c@linaro.org>
Date: Tue, 17 Jun 2025 10:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/6] pci: pcie_dw_meson: Use
 dw_pcie_link_set_max_link_width()
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, John Crispin <john@phrozen.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io
References: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
 <20250617081641.8385-2-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20250617081641.8385-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Jun 2025 08:32:09 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2710

On 17/06/2025 10:16, Marek Vasut wrote:
> Use dw_pcie_link_set_max_link_width() instead of local implementation
> of the same functionality. This does change the behavior slightly, as
> the dw_pcie_link_set_max_link_width() implementation also programs the
> LNKCAP register MLW, this should however be correct and is now aligned
> with Linux kernel behavior.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot-amlogic@groups.io
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.denx.de
> ---
>   drivers/pci/pcie_dw_meson.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie_dw_meson.c b/drivers/pci/pcie_dw_meson.c
> index bb78e7874b1..483b07ce078 100644
> --- a/drivers/pci/pcie_dw_meson.c
> +++ b/drivers/pci/pcie_dw_meson.c
> @@ -115,13 +115,9 @@ static void meson_pcie_configure(struct meson_pcie *priv)
>   	val &= ~PORT_LINK_FAST_LINK_MODE;
>   	val |= PORT_LINK_DLL_LINK_EN;
>   	val &= ~PORT_LINK_MODE_MASK;
> -	val |= PORT_LINK_MODE_1_LANES;
>   	writel(val, priv->dw.dbi_base + PCIE_PORT_LINK_CONTROL);
>   
> -	val = readl(priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> -	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> -	val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
> -	writel(val, priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	dw_pcie_link_set_max_link_width(&priv->dw, 1);

This also changes PCI_EXP_LNKCAP but I guess it's also done like this
on Linux when calling dw_pcie_host_init.

I'll need to test it, but AFAIK it looks fine:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

>   
>   	dw_pcie_dbi_write_enable(&priv->dw, false);
>   }


