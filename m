Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11D7C3DA6E
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 09:23:17 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web10.8183.1704878594785708342
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 01:23:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=rfIZJch+;
 spf=pass (domain: linaro.org, ip: 209.85.208.171, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd5c55d6b8so29292271fa.3
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 01:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704878593; x=1705483393; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7euetkwlhFeeKws1d9k9a9R8iStjGpqif1bor8HHpuc=;
        b=rfIZJch+DL+sgtxeuxWJK8poPoRcP6cbj/wNdOSO4CWVc5BXjfcraAvLRQm1lZbvTZ
         TMH0rSrZ0YKywDlMn9eTEgD2z1/qcqOS3x34S1KzqYpyNQr6q5T0GxLR/v/InzLCXmhL
         nmDV/gDEcJSafjSzCLr0BkHVpOR3K389Ef3bS8bltk/wgc6VaTaZcK1ClMB7MAKvMWsm
         XbyLgkQ6OBrGcs1MYQPQMkmj8HvuomjsKsIkf5PSd3rKSG2PxcEtpZaq2YslCPULFaHR
         8QgzOAdUXsB4KfYYAh5mVbgebWFWJCZUvTsriqai504pQHYBHjeeXxoVrNifbGy3KcKU
         BfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704878593; x=1705483393;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7euetkwlhFeeKws1d9k9a9R8iStjGpqif1bor8HHpuc=;
        b=HvgjGwn2xGm3GZHJxj0p/5VIWo+k3yP/GIPNUqNmBOQKGoFXFRRhTx8xWidHMAdaN+
         3K79SHEvzAh5Al1NXERHRneMrQEjy2JTwNT1v2X/8FEL/KAxa/FtmN8vf2nzyY31/Xzm
         BYo7NHeZC8z9da65qqs6XfOSao6po8NDiuGnoOli/i+kAWW6qOJfNoqstPxq/qSROyJF
         sWh/kZbH1hSRF7mpAz4HMXC7g6TQh1Ww0dW1P2Ad4cVMIE/HJiQQR0q8AWYHFtq8BMC1
         icckEqNqCYTK0cCkjjyBFrbtIpq1cO57pSjzA8qbQ/5thb8EEGJ9q8QHGS6N0zX7n91Z
         BYyQ==
X-Gm-Message-State: AOJu0YwvN2dO7Il6BTJKHwxi9m+QRSvZ9hUSHpFs+HzO2bRKNq/Vb8of
	qM0NJkgF/iGDSlVwnWhz6sRZygV9eX4tqtKQdTg+hbDDLqk3U6pD
X-Google-Smtp-Source: AGHT+IGJmEVHRrH8uxTwrFG+BAidpfhw68b0Ed23mzjrl4ZSBKZ5lUD4R0bfqfBPQePrvKu2EO2v5g==
X-Received: by 2002:ac2:4da7:0:b0:50e:b64a:f8ff with SMTP id h7-20020ac24da7000000b0050eb64af8ffmr142513lfe.150.1704878592691;
        Wed, 10 Jan 2024 01:23:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5dee:51de:9349:2adf? ([2a01:e0a:982:cbb0:5dee:51de:9349:2adf])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d5044000000b003371e7113d4sm4411717wrt.24.2024.01.10.01.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 01:23:12 -0800 (PST)
Message-ID: <829ca7ca-0da6-468c-a70c-d0bb35a57fa9@linaro.org>
Date: Wed, 10 Jan 2024 10:23:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] clk: meson: add Hardware Clock measure driver
Content-Language: en-US, fr
To: u-boot-amlogic@groups.io, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <17A1E40D16C3C77A.26427@groups.io>
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
In-Reply-To: <17A1E40D16C3C77A.26427@groups.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 09:23:17 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2055

Hi Sean,

On 18/12/2023 10:47, Neil Armstrong via groups.io wrote:
> Amlogic SoCs embeds an hardware clock measure block, port it
> from Linux and implement it as a UCLK_CLK with only the dump
> op and fail-only xlate.
> 
> Based on the Linux driver introduced in [1].
> 
> [1] commit 2b45ebef39a2 ("soc: amlogic: Add Meson Clock Measure driver").
> 
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Should I take this via the amlogic tree ?

Thanks,
Neil


<snip>


