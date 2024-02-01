Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158F9C4828F
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 14:26:32 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web10.16713.1706797588633245392
 for <u-boot-amlogic@groups.io>;
 Thu, 01 Feb 2024 06:26:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=y9u5kLW9;
 spf=pass (domain: linaro.org, ip: 209.85.167.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51124d86022so1589636e87.0
        for <u-boot-amlogic@groups.io>; Thu, 01 Feb 2024 06:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706797587; x=1707402387; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRB9sVSLz6iCTXiN3mGqgGNYZQXjbyFNpsdCIsIGHxQ=;
        b=y9u5kLW9nr2CYA0HmBZ2AGEYQbqhuce2JiSFyeKDqxKAuCoXhFuhEt0ZRvQSJqo22r
         hIpjC+yBEGDB5GWxbkcwvZ/CY2jXDOeYkHufa7NV51Ei11nPenGwPAWbpMXrCMVoYSOV
         Z+Pg+ObbYWLbQJM0PH4ijswrMKbwdNRLIi/ElpgRnsK2Eq81kPtiRkEQbTYw11tMCNZV
         Vx4wwk5kQLNOvkwE9j3ycjSqO/m+VtgIHQthbcqdhYJ0nSgBiR/FwaZucGEIz90feozk
         rtoMy/w+KhttMYGyNfQ8AC8e+GvmZFHOWcGYfu2tjZbN4nyxGTUiKiky+B2SoeIG71KO
         YUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706797587; x=1707402387;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRB9sVSLz6iCTXiN3mGqgGNYZQXjbyFNpsdCIsIGHxQ=;
        b=PB384baLw8NDNcUyqNNo1vyFXfUYbdbeyQMDyXwGcEi5fy/45HPA3Izc/0GOHC9j5H
         3djrkkDW6mRn5osIe1ubGRc2PVsw8b0O36dFWFOFgMbSyyeOMcudNK2TIMoPilOxuIMg
         J2/f1RxK8tM+ZCzDJmwOguTaRGAUUU3wNrN/BKqyqS/GDdnoymluUeph4xFzSRuAOLrV
         We6TsArz8yiNr/+wCF4OiDSg0UosISDIcsjfCCmngn608qURlFj6xGLG9K1ZfG3HO7u6
         KkaCJIcIWXoAsOASxTErM+NdnxM1i7Zxe3AtcNhqUSCxAjtFy5Vm9EF5adKH7HMEVvA1
         TCKw==
X-Gm-Message-State: AOJu0YxRZdIt/fVnLNs+hYoIA0bvR2gxFAZfKU4JuNSTaRUprt2Xgskp
	SKqOBqE8WzM2uDh/ZSkfM8sYfrwfcnEKvFPCXJ7WQPcQNS918deP3Z8xMjLG1hc=
X-Google-Smtp-Source: AGHT+IH/sJnmd+X2ciUoTF1BFFznLYxJL/X3fEvWowESVzXKopWqV3Ove59f7JXb9xMoFOJFrovmvg==
X-Received: by 2002:a05:6512:971:b0:511:2219:78bf with SMTP id v17-20020a056512097100b00511221978bfmr1902342lft.31.1706797586800;
        Thu, 01 Feb 2024 06:26:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV7oOVyhe2jpmJsvyVy9CPhsgTo9sR6Kac1O+FKgIl3LWAL5fJukFXDxeVL4HR8EZs7H14CnH6xWf+wNeuw8TiO+SDpBA==
Received: from ?IPV6:2a01:e0a:982:cbb0:cfdd:eab5:fd8:5436? ([2a01:e0a:982:cbb0:cfdd:eab5:fd8:5436])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040faf3df118sm4688030wmn.32.2024.02.01.06.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:26:26 -0800 (PST)
Message-ID: <bb777d08-1723-44b3-ac69-e55af1218cf2@linaro.org>
Date: Thu, 1 Feb 2024 15:26:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-fixes-20240201
Reply-To: neil.armstrong@linaro.org
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 01 Feb 2024 14:26:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2097

Hi Tom,

Please pull this simple fix avoiding printing the board model twice.

Thanks,
Neil

The following changes since commit 6faba41927bdc8973b59678649ef83c564cc421e:

   Prepare v2024.04-rc1 (2024-01-29 20:53:19 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-fixes-20240201

for you to fetch changes up to 076529725f16f07a5cb2d5feba25d62b5f5a5872:

   ARM: meson: stop printing board model after sysinfo update (2024-01-30 09:35:51 +0100)

----------------------------------------------------------------
- stop printing board model twice after sysinfo update

----------------------------------------------------------------
Neil Armstrong (1):
       ARM: meson: stop printing board model after sysinfo update

  arch/arm/mach-meson/board-info.c | 10 ----------
  1 file changed, 10 deletions(-)

