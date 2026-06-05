Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99F8CD6E6B
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 08:06:21 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3536.1780646777465761435
 for <u-boot-amlogic@groups.io>;
 Fri, 05 Jun 2026 01:06:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=sPoLKhTv;
 spf=pass (domain: linaro.org, ip: 209.85.128.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso13371485e9.1
        for <u-boot-amlogic@groups.io>; Fri, 05 Jun 2026 01:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780646776; x=1781251576; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgcEqEEATw1N8v+XXVmdeOJ1VjVWW/kOYIpBQijdx3Q=;
        b=sPoLKhTvuRmP3vvkli5/2t3I4c4y5UyPNPWixhQTpV6ebCpOdAI9sTJ0R3U/f+ep++
         sOPzP9/lb/S7xUpsQSTniBvS3tvYNGTLpCqE97lH1ufZtjPZX8236wE+FjMHp2VPzh2J
         iZBpv93pG1q22JniSa3XwFL4zG/bvUbt3GJQqTvkRaQ6JC7CpXjIijzrAqiYaDFSaKir
         wbcXXYpVKIaUQovbXeGe+bLIKX1aJpvh0SmUP/xlO/sbAlzsWlUs/0MGhv+XW57z5zMw
         x27MW3SQetZWp6RBl6eDjR8lPTyg7DP0DV91NK6mlF6hQPF68dn3JdnN1vFwwNU34g/t
         zbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780646776; x=1781251576;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgcEqEEATw1N8v+XXVmdeOJ1VjVWW/kOYIpBQijdx3Q=;
        b=D+9iMW7M4uHLw+O7FPDWyFCiRn3lDj/sm2OBDWsRXTI1C9cYtyvL3MVPKyuP7GX3Re
         6Z+++NhHyhHO1xifntqS5uGsfOrQRgSZtm+FDEWrGOqQYaXoCm3XWB5qHjo95Y9wRcQ9
         2wX6zPR2trrnZXYw0wWUA7LiexMbXntOCpei3VyObM/cL6FyElFyDX4jPurdE671oWj0
         gveEznq+MJitdeY+VsE8UAytBShmRRmL1Idw+PUer23hCYpAqkHaagdgb0VOykdQp/Ve
         v6/cPP1IigwC7qGrT7vgt2QnGte21/zQZ97gFjtejGQIwvRHtXYLE5j6EbGXO8jf6Lpt
         cjFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8HPO2G0TMNErecWEpgH0ODHShGgWt0GoNss6/KHjFL4X+pKai3tuOGS5OzWIm0HOfGoe5WEy9NkBFn+1c5AA==@groups.io
X-Gm-Message-State: AOJu0Yy41lWJCxeml4G1XlylV5IgWGKrb98RGA8HOAalvz/xwsnqiI5t
	1pSEst4ASkrLTmC3khoSIyyXaCZ/uYjf6yzl90LWDrDUgOCqltJ5xvAADZziri2nTaA=
X-Gm-Gg: Acq92OFfx+lJY7AhtIQe72ZgrEq5oMxnB+MDr83Gf14CFTXnfOYWESgzODbSM8PmoYL
	F6GHxiJiOHEhz2aiGsuEu4vBIbyB4jMRPxP7TLVIFYHaSYJGSnqaZ59zk5IRJNzCS3ECPMa7EVY
	rPt3xSF6XuPH1WvcS6Yz86hfaeXBuPU/IBMoF9tiFs7w5Fv6+IqAPkDk73+hQ/q76OxGqqIOEVM
	ZYAk5nOpCd6PQXfwqI0sWcvlj+CHGgPRhBvBQm5OXva/fKA02aWpU2vIJgaLkM8OVS5pEwGs7BK
	pva+RqL1+/1P4MEJ0arpQf1SKrS1E1Eg66FVsWHkyTC66JDr03hc+vJCZiDnjfQGUcdbiiKJDUu
	KgOotL9LO7UpDzYoKvTPO6oArXOOnJoI5TAfyj+eswRytyP86Weo2V3ceebhvC/MX1OiBhVFlUG
	1K0uGL++5GljDJ40sb8s5Hy2XIdBG53oSX9O+lvMmksDCUnSisee8eYas+l2lqBWX5ShnjhFpz9
	QhGMEIUZ/kyTQNhSA==
X-Received: by 2002:a05:600c:45c6:b0:490:b1ab:e41a with SMTP id 5b1f17b1804b1-490c260d1f2mr34958175e9.32.1780646774903;
        Fri, 05 Jun 2026 01:06:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b06c:5480:fdc5:c668? ([2a01:e0a:106d:1080:b06c:5480:fdc5:c668])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm122973565e9.7.2026.06.05.01.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 01:06:14 -0700 (PDT)
Message-ID: <4c060578-ab4e-40ba-9f92-5d85fb11e818@linaro.org>
Date: Fri, 5 Jun 2026 10:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 05/11] power: domain: meson-gx-pwrc-vpu: use
 dev_read_phandle_with_args for hhi-sysctrl
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot-amlogic@groups.io
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Casey Connolly
 <casey.connolly@linaro.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Primoz Fiser <primoz.fiser@norik.com>, Yao Zi <me@ziyao.cc>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>
References: <20260604-devapi-v1-0-961aded05ff4@nxp.com>
 <20260604-devapi-v1-5-961aded05ff4@nxp.com>
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
In-Reply-To: <20260604-devapi-v1-5-961aded05ff4@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 05 Jun 2026 08:06:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3004

On 6/4/26 14:20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace the manual ofnode_read_u32() + ofnode_get_by_phandle() sequence
> with a single dev_read_phandle_with_args() call to resolve the
> amlogic,hhi-sysctrl phandle. This is cleaner and avoids the intermediate
> phandle value and ofnode_valid() check.
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/power/domain/meson-gx-pwrc-vpu.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/power/domain/meson-gx-pwrc-vpu.c b/drivers/power/domain/meson-gx-pwrc-vpu.c
> index 325296b0dd7..e08c0fac49a 100644
> --- a/drivers/power/domain/meson-gx-pwrc-vpu.c
> +++ b/drivers/power/domain/meson-gx-pwrc-vpu.c
> @@ -283,24 +283,19 @@ static const struct udevice_id meson_gx_pwrc_vpu_ids[] = {
>   static int meson_gx_pwrc_vpu_probe(struct udevice *dev)
>   {
>   	struct meson_gx_pwrc_vpu_priv *priv = dev_get_priv(dev);
> -	u32 hhi_phandle;
> -	ofnode hhi_node;
> +	struct ofnode_phandle_args args;
>   	int ret;
>   
>   	priv->regmap_ao = syscon_node_to_regmap(dev_ofnode(dev_get_parent(dev)));
>   	if (IS_ERR(priv->regmap_ao))
>   		return PTR_ERR(priv->regmap_ao);
>   
> -	ret = ofnode_read_u32(dev_ofnode(dev), "amlogic,hhi-sysctrl",
> -			      &hhi_phandle);
> +	ret = dev_read_phandle_with_args(dev, "amlogic,hhi-sysctrl", NULL, 0, 0,
> +					 &args);
>   	if (ret)
>   		return ret;
>   
> -	hhi_node = ofnode_get_by_phandle(hhi_phandle);
> -	if (!ofnode_valid(hhi_node))
> -		return -EINVAL;
> -
> -	priv->regmap_hhi = syscon_node_to_regmap(hhi_node);
> +	priv->regmap_hhi = syscon_node_to_regmap(args.node);
>   	if (IS_ERR(priv->regmap_hhi))
>   		return PTR_ERR(priv->regmap_hhi);
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

