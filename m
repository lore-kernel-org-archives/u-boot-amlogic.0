Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2795CDB47E
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 07:43:34 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.276285.1697615013268633792
 for <u-boot-amlogic@groups.io>;
 Wed, 18 Oct 2023 00:43:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=RIGZi1b+;
 spf=pass (domain: linaro.org, ip: 209.85.221.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-323ef9a8b59so5999499f8f.3
        for <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697615011; x=1698219811; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0vCf29nLDwhqFZbNKESsa8maKdStWsuI7dK+fyv8HM=;
        b=RIGZi1b+4RuipxP4Cl3R/YCWUmaMIcz52KQzszZOopbeq7xJifCZADQ/lYVu2XqXo+
         wjmQ4gOPfduXI4VDwPcJKtGM6GboAkIzX0UBFnhy2t+u+mAbxn7SQWc4XoBytsTZk6WR
         n6OJAZVtbwOECU1j6odLmQ8+eulvcnKzEJ0rb1fdjx3HLcq/yMysL6p5r3cf31yhk8l5
         V5bvRuT8gMa/nGY/DMVnhoNT9LSuGst9dBbzlt2DrnyrCtGIZl50R6gUOhaHgKdQpHT1
         +9KRwB/eO/ksg49nwc6qhaRii/BkJADJ5xkBxYFBgv8AkPrpzOd28Cl8T4WQvrTJUHoD
         kP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697615011; x=1698219811;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i0vCf29nLDwhqFZbNKESsa8maKdStWsuI7dK+fyv8HM=;
        b=nCHWDuAKUug6MURVj3uQ9bb8UNvfNw3zFLmFnCmOEknVvW9Q8b6lo931wyDTeXYe5D
         BWp0XoUyjA/oULtJM4tmS/Q5tr92xG6rQ0WolpBHwYqgWUZfN/t8up9AoFhADf2Z3yCJ
         d5dkPf/Pv5SuvHM2soG25nZvvENBtOeDB/PsKvV+HL20fpOm2JM2oEx3a9lk511iidkO
         tKxtzIMg3F9TV1958Hi0tvYXq0Rebf84sg+ParsA+4g2prUyq+TdM6pmAMbtqRuK+KaF
         tg9kF0Lm0Wb3CcrVUtETvCBj52d9NjeY9z8AkYIQv8e4CTBzTTn1ur6StlYPQa6Gx9ec
         dpgA==
X-Gm-Message-State: AOJu0YwF5JF2UZGiK7TTcikxIOrTb/i/Qm+PV4Rf/s0T5++Oknjn0V/Q
	QGLG8UOcfxlNsTuERPP6tymAkA==
X-Google-Smtp-Source: AGHT+IGUGZp1xd2h62gSe7PHhS+N9Sy5XgZABjdi0pGyFp31gW/ywAhxeyKHoHICJL0fbHnebjtQXQ==
X-Received: by 2002:adf:e691:0:b0:31a:d9bc:47a2 with SMTP id r17-20020adfe691000000b0031ad9bc47a2mr3825023wrm.53.1697615011648;
        Wed, 18 Oct 2023 00:43:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5d8f:701:423:3d05? ([2a01:e0a:982:cbb0:5d8f:701:423:3d05])
        by smtp.gmail.com with ESMTPSA id f4-20020a056000128400b0031c5e9c2ed7sm1457010wrx.92.2023.10.18.00.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 00:43:31 -0700 (PDT)
Message-ID: <ca225ffe-c524-4312-8a65-30e0c36c4ae7@linaro.org>
Date: Wed, 18 Oct 2023 09:43:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/2] serial: amlogic: Add UART compatible for A1 board
Content-Language: en-US, fr
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
References: <20231017213211.121550-1-ivprusov@salutedevices.com>
 <20231017213211.121550-2-ivprusov@salutedevices.com>
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
In-Reply-To: <20231017213211.121550-2-ivprusov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 18 Oct 2023 07:43:34 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1780

On 17/10/2023 23:32, Igor Prusov wrote:
> Add additional compatible to allow using serial driver with A1 board.
> After compatible change in DTS [1], serial_meson driver should still be
> able to work with console device.
> 
> [1] https://lore.kernel.org/all/20230705181833.16137-8-ddrokosov@sberdevices.ru/
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>   drivers/serial/serial_meson.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
> index 934de2ab23..be5f380f85 100644
> --- a/drivers/serial/serial_meson.c
> +++ b/drivers/serial/serial_meson.c
> @@ -232,6 +232,7 @@ static const struct dm_serial_ops meson_serial_ops = {
>   static const struct udevice_id meson_serial_ids[] = {
>   	{ .compatible = "amlogic,meson-uart" },
>   	{ .compatible = "amlogic,meson-gx-uart" },
> +	{ .compatible = "amlogic,meson-a1-uart" },
>   	{ }
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

