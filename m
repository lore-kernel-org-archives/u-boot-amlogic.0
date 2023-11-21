Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E382BC61D92
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:46:39 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.40745.1700574392517805158
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Nov 2023 05:46:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=uNx/rijZ;
 spf=pass (domain: linaro.org, ip: 209.85.221.43, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-32d81864e3fso3518878f8f.2
        for <u-boot-amlogic@groups.io>; Tue, 21 Nov 2023 05:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700574391; x=1701179191; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upVedUrQMYJyG4z3BtAvES1f7mfAQOC3h8zjZCXrtO0=;
        b=uNx/rijZHaNq4jSMWvhOG8f2FyQ+cfF/OgTs32lIGq/80ISlDCwmMDhuIpSw3aBCcf
         RkHBX3tzj/Rgs7VqUa2VKyUuIf9Ly4fv37Wn/bJddlvK/sZviXZp41r2lcl29rpxN/ki
         AJOn5x65YR1vynnVLqsLRl1x+S+v4+xf0t6yXIqdklM+5nO/oS5Oo5BYKrjPbr5bKWel
         iPFqgPZ7FjLtWisI/B2GK9jurFguLnK/JQx9FZq3eD5kEeGG5Wa67ERBbd7VlMv/p4dw
         TC4WK8qqGyR5bsUXGurFEAe+BuM2JDDIkpJpNU+gnY4HSMfstTL3dYbilAvo9E1CJ0B5
         TK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700574391; x=1701179191;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=upVedUrQMYJyG4z3BtAvES1f7mfAQOC3h8zjZCXrtO0=;
        b=Lz5dOlp+yeiBZnKYT1wMAFCFT0hm+aDqsq/PkzHpeX8O/zwhTsCHrE0u5uCvz+nZXN
         hryCeMB+3QRKbW8Hh/FmLpGsgTtmkC4aOQqyHHCevTQ2XCfaafMOgFqTTweNy5ny2sHX
         2lJ3g00xAZh827NbENmMDdfMWGiy4k1luTrLjrCN3LieyBoCjtJSwxgxUZoaMdZ88nJ1
         L5fKOOrBS81b/k1TZLFWtw47SDZGwrHvdbEmvsIpP7Pp1TB+fLPrk63sfLtx0A4RJ5Sy
         Pn/vLLVbElvWPZYKxwAbKCOfa7HoJE4IqK8Kmg8KdindwNke4z5QHQEN9SRn7LFxMA3s
         yS2A==
X-Gm-Message-State: AOJu0YxBqE2z66CuMm703eMVLJLcI09MSVoH2ec4Kh/+1rhdTQWkvPZw
	3mXt9l7NwZxeHIbTCb++p0J2na/Z1vC0I8FU00/1yWGQ
X-Google-Smtp-Source: AGHT+IFy36lvwG7wcjthOzwoHxwkOLdmzFrwLyiECQt2KurhqusikLZkbGwfZ9KN8a807iTEUFJl4w==
X-Received: by 2002:a5d:5849:0:b0:332:cb12:16ce with SMTP id i9-20020a5d5849000000b00332cb1216cemr3021208wrf.65.1700574390923;
        Tue, 21 Nov 2023 05:46:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2a39:bc19:20b6:16a? ([2a01:e0a:982:cbb0:2a39:bc19:20b6:16a])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d6d8f000000b00332cb23ccbdsm4605102wrs.81.2023.11.21.05.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 05:46:30 -0800 (PST)
Message-ID: <d59de63c-4d4c-4141-9b4f-9a279da596d4@linaro.org>
Date: Tue, 21 Nov 2023 14:46:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
Content-Language: en-US, fr
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
References: <20231120201609.619598-1-trini@konsulko.com>
 <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
 <20231121131551.GP2513409@bill-the-cat>
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
In-Reply-To: <20231121131551.GP2513409@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 21 Nov 2023 13:46:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1879

On 21/11/2023 14:15, Tom Rini wrote:
> On Tue, Nov 21, 2023 at 10:18:04AM +0100, Neil Armstrong wrote:
>> Hi Tom,
>>
>> On 20/11/2023 21:16, Tom Rini wrote:
>>> Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux can
>>> eventually display this information
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Posting this as this was the easiest platform for me to test some SMBIOS
>>> related patches on and I needed to populate the nodes so I could check
>>> things in dmidecode once Linux was up.
>>
>> Sorry to be late a the party, but can't this be dynamically found from DT's compatible & model ?
>> Since I'll probably need to add this to all boards, it seems like a duplicate of what's already in the DT.
> 
> Part of the "fun" as to why we have the binding here is that while we
> could use the top-level model property, there's not a corresponding one
> for manufacturer. I'm fine ignoring the patch I posted here and having a
> longer discussion about populating SMBIOS more usefully, globally, as I
> think has been suggested a time or two.
> 

I'm ok landing it with the same data as from the vendor.
but couldn't we use the first top-level compatible as default smbios data ?

compatible = "vendor1,board-name", "vendor1,soc-name";

and translate to:


smbios {
	system {
		manufacturer = "vendor1";
		product = "board-name";
	};

	baseboard {
		manufacturer = "vendor1";
		product = "board-name";
	};

	chassis {
		manufacturer = "vendor1";
		product = "board-name";
	};
};

since the vendor name should be already documented in the linux
bindings, same for the board name.
And we would be free to add some custom data in the DT if needed.

Anyway, not sure it's the right place to discuss about that !

Neil

