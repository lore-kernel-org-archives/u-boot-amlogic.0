Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27328CDB47E
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 07:42:45 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.276275.1697614961961529778
 for <u-boot-amlogic@groups.io>;
 Wed, 18 Oct 2023 00:42:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FmuKoHl0;
 spf=pass (domain: linaro.org, ip: 209.85.221.50, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-32d9cb5e0fcso4275178f8f.0
        for <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 00:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697614960; x=1698219760; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRTgNSOsXG0F9aLy2A/XE7NkoPOUWrEtgTPGGPgARJc=;
        b=FmuKoHl0dEifoctp6LlOB+o9ge9CEbCh/Lw5Au86CZ42xnB9Wt+i405uQSCWLSQeys
         QtK1C+pXiw/TXeGdIsr4MzP4kgKohq2XdRPaEGzZJonIEK6kYY3WVOVW9L9X0bLHckAx
         EePik3caE8HqgR3xfdTCcF9Bl4KDTsnucE/idPwCsbEhZia6VKZv6VmXMo4S8MQq2OlM
         Nu0apTbJFaKHsSiJrWMIcmoq8+u+2/cPBjU/xDWezlm3WXkoUHhm5RyO20/zZ0JtADYd
         OjsE/62ayUzQFaLdjslgonuB48H9c2eq2CBRLh4Z929xwmmaXVHsrN93OipkKC1PMqRL
         DH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697614960; x=1698219760;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PRTgNSOsXG0F9aLy2A/XE7NkoPOUWrEtgTPGGPgARJc=;
        b=r0NSI09PKQWziWbqQEx0PF5LtsHeymRZmy24CQmtEZNDTmL0Mvoxz0rTf49DDbXWNO
         CykMB3FAxD+vW4T4uJatD4dPnTT2h2lfEBoRIBzqGp4VZI0gDipfN9XIXiLqSk+849kr
         OOJ0D/cmYWZcAYbaWzCRidtzCfY1YXSf5vBEPVxgD01xW5O/GNO8StXYZDH0bBtcRWds
         gsjHYR9n71oppJTFtpFhAynaIJURRharTNSxASkY1LDa5RhQRYWcd/mXPIVxj2TPtFzL
         crqejIUmCW5HmQGevmppkO94Zm2EElpp5qApoZkiL/S6IZzcAqDSvpKOTFJxFHC/seXD
         lIzA==
X-Gm-Message-State: AOJu0YxxtFBl3C3AWuY4DtbF4v9cf/YR/Z/zCbZNx0eLroPrQ1Fihf0+
	ECpz9nHALF344MEcJJhO2AeuOA==
X-Google-Smtp-Source: AGHT+IFiMpUuxGLmnXBwvD/drZlOEpAchJMyhKaL9bfQNVx829Dm25kk6dI8KZmZfEjwb96fX66SSg==
X-Received: by 2002:adf:ec0f:0:b0:317:67bf:3376 with SMTP id x15-20020adfec0f000000b0031767bf3376mr3658884wrn.57.1697614960106;
        Wed, 18 Oct 2023 00:42:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5d8f:701:423:3d05? ([2a01:e0a:982:cbb0:5d8f:701:423:3d05])
        by smtp.gmail.com with ESMTPSA id f4-20020a056000128400b0031c5e9c2ed7sm1457010wrx.92.2023.10.18.00.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 00:42:39 -0700 (PDT)
Message-ID: <d4fa0c3a-a6a1-4c06-8f9e-f59086201069@linaro.org>
Date: Wed, 18 Oct 2023 09:42:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 4/8] clk: amlogic: Move driver and ops structs
Content-Language: en-US, fr
To: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20231017165649.1492-1-ivprusov@sberdevices.ru>
 <20231017165649.1492-5-ivprusov@sberdevices.ru>
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
In-Reply-To: <20231017165649.1492-5-ivprusov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 07:42:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1779

On 17/10/2023 18:56, Igor Prusov wrote:
> Move driver and ops structs to avoid forward declaration after switching
> to dump in clk_ops.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> ---
>   drivers/clk/meson/a1.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index 1075ba7333..e3fa9db7d0 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -601,14 +601,6 @@ static int meson_clk_set_parent(struct clk *clk, struct clk *parent_clk)
>   	return meson_mux_set_parent_by_id(clk, parent_clk->id);
>   }
>   
> -static struct clk_ops meson_clk_ops = {
> -	.disable	= meson_clk_disable,
> -	.enable		= meson_clk_enable,
> -	.get_rate	= meson_clk_get_rate,
> -	.set_rate	= meson_clk_set_rate,
> -	.set_parent	= meson_clk_set_parent,
> -};
> -
>   static int meson_clk_probe(struct udevice *dev)
>   {
>   	struct meson_clk *priv = dev_get_priv(dev);
> @@ -638,15 +630,6 @@ static const struct udevice_id meson_clk_ids[] = {
>   	{ }
>   };
>   
> -U_BOOT_DRIVER(meson_clk) = {
> -	.name		= "meson-clk-a1",
> -	.id		= UCLASS_CLK,
> -	.of_match	= meson_clk_ids,
> -	.priv_auto	= sizeof(struct meson_clk),
> -	.ops		= &meson_clk_ops,
> -	.probe		= meson_clk_probe,
> -};
> -
>   static const char *meson_clk_get_name(struct clk *clk, int id)
>   {
>   	const struct meson_clk_info *info;
> @@ -727,3 +710,20 @@ int soc_clk_dump(void)
>   
>   	return 0;
>   }
> +
> +static struct clk_ops meson_clk_ops = {
> +	.disable	= meson_clk_disable,
> +	.enable		= meson_clk_enable,
> +	.get_rate	= meson_clk_get_rate,
> +	.set_rate	= meson_clk_set_rate,
> +	.set_parent	= meson_clk_set_parent,
> +};
> +
> +U_BOOT_DRIVER(meson_clk) = {
> +	.name		= "meson-clk-a1",
> +	.id		= UCLASS_CLK,
> +	.of_match	= meson_clk_ids,
> +	.priv_auto	= sizeof(struct meson_clk),
> +	.ops		= &meson_clk_ops,
> +	.probe		= meson_clk_probe,
> +};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

