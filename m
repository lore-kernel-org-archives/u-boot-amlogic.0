Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4902BC3601E
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 08:40:42 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.6422.1743756033478602978
 for <u-boot-amlogic@groups.io>;
 Fri, 04 Apr 2025 01:40:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=rF9YDyA3;
 spf=pass (domain: linaro.org, ip: 209.85.128.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so11404195e9.0
        for <u-boot-amlogic@groups.io>; Fri, 04 Apr 2025 01:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743756032; x=1744360832; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ILSkJoOKj+XeT2UHR0pMDQfEYLAP0SBkYYIJx1Hsnc=;
        b=rF9YDyA3n4a7Y6yHCT5LbcCP64oDOqt+hgV8wHjw1lWcXXM4m4NywBP/hXRojqI8qE
         8uDNCf7KOK5fL5/7YDWsQRP08Fy9/kJL9wJDlOjoObhCTsHlgfoLTSLCiiSBdeFcIaFa
         tDBk6T4VERHzgmIEyeiTegtn0jdiHKcbTAjiw4HqcfyKbJs6Z3b8Y3YqtcisOkAfPT46
         SW4ppUIkqRYv5xTErA2PudCKM7AHYahrn0429NMgaxBNRYUB/j/DhFnzi6HFnH4g+Kkg
         SMUO4EqDIJ2+BJNVPCXHqO/KBA0W2ztnjGXs83Sv0XBuLYqHb5Rh467j5i84LAyJ2pio
         Z4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743756032; x=1744360832;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ILSkJoOKj+XeT2UHR0pMDQfEYLAP0SBkYYIJx1Hsnc=;
        b=t1MQzMFiBbtF1ydeD3tzt0hQyNQhs8rYpzPQXcndqvFxasNNt7ctvDau9Renu6ouWi
         LfyN/aKAPjRSY0UjoeTmkTuTP+C00rlZ3Yt3q5WHeqF4Rj/BjvJ63Mb9fTs1hnmGOViY
         y3n93ZQLdrh2HfU8VRP83kGRCNSy5twCCNUVg8W2gtMTWgyp9XekWirY2h4Z6T2e3K0q
         I0OkK49Vl6jxDF32ivMkO0lOGECjrmyCB8svp0JqtacFgWGuTqMEyrjAKm8v5yfP24GW
         u11S7ex4a/LrCFSJHtHjhtvGMCKYEzmxMMGmvaR6Z8l6L6ilnxoc1RnQbimPDNZ2CGIM
         PCiw==
X-Gm-Message-State: AOJu0YyTcOrop8JXeqXewtNOrp/R+KzjrZFAgz/Lhs7ccv8zfTRC1gU7
	z98R/O1t6NFUed3YAdwW752ib8fXcfA6hC6rxZLT4kOdrZBRWOId+Yb8yJJSNv3UgJlLnSsLIl4
	A
X-Gm-Gg: ASbGncuzQHMUVCG9EMgQf0jc0BnPvzW9A2ovYvUYrWBckVVmZRu2QNvGo+4KZzFE7yT
	jZGkq/6aRMwRQZKNuozHIBukjRFNsjOhk2EwTkgRdoHNcUTAdOj3rRtDE19F4r6sk065U+UbG/a
	lVNiTnFCb7y/q8sUWaIbsxSQ5lkPWtezc2i1pVa5wUmhHlXWpSuKqKz/41kQAlR73Mb1aFml6GT
	fq/7FSRVwkah6cPWTY8rNycVsv5qlIqXTEj01oOyJskX+s01M8HMUI4jjNmE9Nyt5ZyGTKrmHH1
	hR9/HCvS6As30SXOE5vMLQFEcUs+J+GT/XTwda16aZMIo6HdskodL8xEVbhPuZ5lOZyx/wSHMVb
	l80fqWqRtMwNwK9Czkh0Dgy/RXTe02g==
X-Google-Smtp-Source: AGHT+IGU5jbPZ5HW4NsnxVQQUVK5PxURbOZilt7sN/Ch0Uk05jtSHgQclPw8MEOxbZHMiGI4Tc3LhA==
X-Received: by 2002:a05:600c:4713:b0:43c:e2dd:98ea with SMTP id 5b1f17b1804b1-43ecf9c7731mr16552425e9.22.1743756031764;
        Fri, 04 Apr 2025 01:40:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:19b:8166:6e82:3840? ([2a01:e0a:3d9:2080:19b:8166:6e82:3840])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b1352sm42475745e9.37.2025.04.04.01.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 01:40:31 -0700 (PDT)
Message-ID: <d1de0302-ad3a-44ba-ad1a-73cc1b6f34f1@linaro.org>
Date: Fri, 4 Apr 2025 10:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20250404 into master
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
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 04 Apr 2025 08:40:42 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2649

Hi Tom,

Here's a last minute fix for the libre-computer boards fixing the capsule update feature.

Thanks,
Neil

The following changes since commit 82b69fc4224432d5aefa7ca750d950374cbc7fb2:

   Merge tag 'efi-2025-04-rc6' of https://source.denx.de/u-boot/custodians/u-boot-efi (2025-04-03 07:31:28 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20250404

for you to fetch changes up to c5fd2c7ac7fa4835339ea09ead2884794314c9d8:

   board: libre-computer: check interface before comparing it in set_dfu_alt_info() (2025-04-04 10:37:40 +0200)

----------------------------------------------------------------
- check interface before comparing it in set_dfu_alt_info() to avoid hard crash on capsule update

----------------------------------------------------------------
Neil Armstrong (1):
       board: libre-computer: check interface before comparing it in set_dfu_alt_info()

  board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   | 2 +-
  board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   | 2 +-
  board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c | 2 +-
  3 files changed, 3 insertions(+), 3 deletions(-)

