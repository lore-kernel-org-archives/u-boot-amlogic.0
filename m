Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0F6C3ABC3
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 12:01:52 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.7338.1746619306087544052
 for <u-boot-amlogic@groups.io>;
 Wed, 07 May 2025 05:01:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=L+PiOFmF;
 spf=pass (domain: linaro.org, ip: 209.85.128.48, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-441ab63a415so68467975e9.3
        for <u-boot-amlogic@groups.io>; Wed, 07 May 2025 05:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746619304; x=1747224104; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/EZs/5P3xPz8a1FS8ijckX7N7lrxVsTDArOdHFDVOU=;
        b=L+PiOFmFsAyJKLBzzIMf4gXoiooV7Dx08Ijuu60FqrUZaRoeFE60cH/Xo/iSGiNMxM
         KY3BNHKzz7fEHRqeUbYjP8gHZ0dKfvtPDiqeYx+tjCaUSJQDd9WHgQsnetI+P5lICJZn
         omlrpK7GrOqd3X19JsART8k8m0DLUb94THCn0PtWmN2GQ0+vmN70GEL8zWgbU+PCDc+m
         bhdEDd2GmgHj1jo+BAuPd0n+GKqwElcqgVmNwg/hinkMc/RctJzaw3FpNLJHQAafB+P7
         jtRr4rftN3YPelsvVf3ChTDWRSoVmX+mDepzYQHWnei/zb7BtWQ9F70DUY6FUFfPJXRo
         RpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746619304; x=1747224104;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5/EZs/5P3xPz8a1FS8ijckX7N7lrxVsTDArOdHFDVOU=;
        b=sfEwMbOY7RFSqFNa/sihF0RRQPy3bzhpI2h2mXPQh7xqnZZp5bDGRx3I2ujBK8mfQM
         2TG6cge9m2jCFwBXx/DVgFKovsxeSE6zONfSClHW18flyq7+C/98yzC3eaYv1f+V8RXu
         FuxL+sra/iSYFokEoEXuzld4JGxoGRAsH6fZNqtkx/s792P3RmmWcX4z8hLWdXr8qld6
         jL0QkA/WlC0nRmvuwhG9Ds5TTwj9d+qHku5yiW9UqIMq6XY0fwb2Zq2PmjHIOxULGnUY
         KHedV0YQS6QAMRlNTHToXZojemf0XESmqi3PT4t3h6bLVqdIEWcDgAonXGiGgVWrtYwY
         VOKA==
X-Forwarded-Encrypted: i=1; AJvYcCXdXhw7NXkq6evILrqTIbjHh4Vtkz1P0QhrX/5dRzQfzA2JjHG+HNSWdolUbzLf2zaCrc32B/84uPfslFkkcA==@groups.io
X-Gm-Message-State: AOJu0YwlewKFGndxdpQB9eHBRv/ad6IDomaX+BG1nfQIM/uWXQO3o77e
	Pza5hFvXyjDBibchFkjp5w8cbvOueYBeHF52BgYkghwPb/ZH5zWOU2slysZmMhxfAfc9NL6pDua
	4
X-Gm-Gg: ASbGncuSGFEqK3Pch74P/vW24euzI0Wp3mppLMWyVyb4G/ly6RSeV5SS8Z9sjhoINnh
	BM7vJkgGqmGsRiYgR90ZyXkPhAEzrhRzP0hKDJeDs065RPRs000gqOE7WS6JQdLTgKV5lAOysnm
	lFaHjqLKUKbhvECfnjk5Cw52OS2BjSigdMmRWiS2lkwRVO+HzfhSJdXO4T/BRkDZVNc3shsQwHR
	akz9tpzj8hZjzRc6C92rim5PD9JrWbFmpmJCl0Ch6sQY8qy5Gi1HltvJ3em/KWCnNZIULtFTG4+
	WhiJMc2ELZ71HwcHXhr+hlLFVj1EbIqi+3qPIoxA9fDbtGl86kfMStzfOsYgMT+Xm1Bfom3/zfN
	BearpzNxr9XtadD/i5w==
X-Google-Smtp-Source: AGHT+IEm9H6jOdRU5tvuHDlvV9wm5h68WGhM78RvTo/EH/a9N5+wvGGtt8QPEz87ONNk1Kif6Dl5ZA==
X-Received: by 2002:a05:600c:1e24:b0:43d:745a:5a50 with SMTP id 5b1f17b1804b1-441d44c7d80mr23917915e9.19.1746619304392;
        Wed, 07 May 2025 05:01:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:784f:3312:6406:12a9? ([2a01:e0a:3d9:2080:784f:3312:6406:12a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d441559dsm29877735e9.34.2025.05.07.05.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 05:01:43 -0700 (PDT)
Message-ID: <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
Date: Wed, 7 May 2025 14:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: Odroid n2+ usb broken on reboot
To: Wayne Schroeder <raz@chewies.net>
Cc: u-boot@lists.denx.de, "u-boot-amlogic@groups.io"
 <u-boot-amlogic@groups.io>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
 <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
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
In-Reply-To: <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 07 May 2025 12:01:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2670

On 05/05/2025 15:12, Wayne Schroeder wrote:
> If I add the usb reset command, it works reliably at reboot, but it
> does not work on a fresh power-up with that change.

OK this means there's a dangling resource, Does USB always work within
U-Boot or it breaks U-Boot and Linux in those cases ?

> 
> 
> On Mon, May 5, 2025 at 2:07 AM <neil.armstrong@linaro.org> wrote:
> 
>> I think it's a very long term issue, USB lacks a proper reset at probe on
>> warm reset, does USB still work from U-Boot after the reboot ?
>>


