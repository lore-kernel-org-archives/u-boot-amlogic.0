Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E156C3ABB7
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 07:07:35 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.44919.1746428850455440032
 for <u-boot-amlogic@groups.io>;
 Mon, 05 May 2025 00:07:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=nQxYidPV;
 spf=pass (domain: linaro.org, ip: 209.85.221.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c1efc457bso2661363f8f.2
        for <u-boot-amlogic@groups.io>; Mon, 05 May 2025 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746428849; x=1747033649; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAcvdE2xY/zpD3KTmU7HwvxmS2gSLmyMDAFLT80zCwA=;
        b=nQxYidPVdoavjAXlWsqSkUwBG/Z138Al3TVkwgTgKPgvaLjs4ZhZQydlVD+PmF7Hme
         WjYgGKTi8Ll5CVCDKw8fFO7MyoEfb7hGTTgYvUjicQyWYvGwub8Fz2zevRJ4YfDoUZqj
         kuV+dDF8KxLrIdkaHS34P5sHUZk4ZqnFZLrKXPxhWw6KItZB5cAb7Wm/ByCkhwQFr3oL
         aBqnOotAleHWQKzm2IrEvnDvsECZ5+WK3eiEQEO0r7XVVBbDhIYryTo/qdFKVlyM4JUJ
         8/kgIt8XmdiqVIjoLAAj8ehhdlIsToRNxI4zehpxSqmBQZfQxs4/iiKxNQExGjz13Ept
         rmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746428849; x=1747033649;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BAcvdE2xY/zpD3KTmU7HwvxmS2gSLmyMDAFLT80zCwA=;
        b=O9s/g4Ow8M6ysNaC+bsp0ol5fJ0tZNyM/ciRA+ws9NjgJAO7ZqWUdoDoNfWT95UltM
         uWdzEBh6twRxI1lfzkwt+HhTG+mi9pppX7C2v0z8uWfFXfRAM6FDCA3fbNmIsZHmQ7UC
         SKcEmTLN5zE/zFSLDek1yEg0M5FPUXzFnvSXD2Wlb20j2V9IjwOdkA8HL6nZB1ineWfK
         6JnoviVuOhP3IvIXHg58Ku/8NGK7RHiw3y0pP5yvFYl3otLZF2Czq/FUTLzMAYMjsPP5
         NK16SC91o2Uy/TYha3MOzbMzavvRj73iZ74pjyueC2uXJakTo49fCKWdPYdd4Jt5y5Ha
         li0A==
X-Gm-Message-State: AOJu0YzUuhqBYW036s1N7+CHbccR8yi+mG4cxPi5fsnK6mKV2OnSqw78
	taOuYZvFhXkiHUBj76c1UvBJlY1OcE2Z6e9bG5gXRRYjGUazc2DNY+Tu9GCwPiE=
X-Gm-Gg: ASbGncuonc07wAO1kEL9LaGHOwNOXQOPHRuvdByGHcm53MIw/5Lx3qqQIGqbSFMMTmC
	sN4caIIcUa6Vn6w42faVRkx1mV8Z1FUCHLCp+/tJm1ADm/xy1NCiH+KwwQeJ0O6L+9dr+XuiwZt
	NxQSDmMyg7c/b9f/kF2YzgnmVfgoPSWHaHT6LebLjxtTLp98JjJoB86Uok+QCEPwmEaH3I9YZF3
	i1F9YJ94izxgFGOiz/gUL6yMbvTJsaAi+aehd7vifv/sVo1fEo2ZxwhQNJ3uE0vKn0DBwCubgtO
	4X4/yj/5P4yF0ysTU2TqMgdznLzENXtn34o5BT1xn0RYSNU3YzhqDBbSnKBFwnbxXYq7qoWKs9l
	xjWbAwx+J/1aQPhDLOyfAON01V9A0
X-Google-Smtp-Source: AGHT+IHydklTwgvkH9q6GqOTfYh+FoH8zbjEJ/ifB4D6ubYun8TosSrDO7fZcpMAINEvL9rzwviU+w==
X-Received: by 2002:a05:6000:400e:b0:39a:ca04:3dff with SMTP id ffacd0b85a97d-3a09fdbb907mr4641524f8f.40.1746428848634;
        Mon, 05 May 2025 00:07:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:88d3:1ad7:3ae1:56e3? ([2a01:e0a:3d9:2080:88d3:1ad7:3ae1:56e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b16f00sm9251942f8f.84.2025.05.05.00.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 00:07:28 -0700 (PDT)
Message-ID: <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
Date: Mon, 5 May 2025 09:07:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: Odroid n2+ usb broken on reboot
To: Wayne Schroeder <raz@chewies.net>, u-boot@lists.denx.de
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
Content-Language: en-US, fr
Cc: "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
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
In-Reply-To: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 05 May 2025 07:07:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2667

Hi,

+CC u-boot-amlogic@groups.io
+CC linux-amlogic@lists.infradead.org

On 05/05/2025 00:34, Wayne Schroeder wrote:
> Hello.  I am not sure if this is a bug, or even related to u-boot, but I am
> reporting it here because it was easiest to resolve via a u-boot change.
> 
> I am using u-boot-2025.04 (source) with a mainline linux from Arch Linux
> Arm.
> Linux alarm 6.14.4-1-aarch64-ARCH #1 SMP PREEMPT_DYNAMIC Sat Apr 26
> 13:02:01 MDT 2025 aarch64 GNU/Linux
> 
> On my odroid-n2+, the USB ports work on the first boot after power.  If I
> run shutdown -r now, or hit ctl-alt-del and otherwise reboot the system,
> the usb ports do not function at the next or subsequent boot up.

I think it's a very long term issue, USB lacks a proper reset at probe on
warm reset, does USB still work from U-Boot after the reboot ?

> 
> My apologies if this is not applicable to u-boot because it is a linux
> issue--I am not sure what the source of the issue is, but adjusting the
> u-boot .config after make odroid-n2_defconfig resolved the issue entirely.
> 
> I am booting via extlinux/extlinux.conf and have adjusted my
> CONFIG_BOOTCOMMAND before build to execute a usb reset prior to the
> existing run distro_bootcmd.
> 
> CONFIG_BOOTCOMMAND="usb reset; run distro_bootcmd"

I'm pretty sure there's driver callbacks we should implement to do the
same here, I need to check.

> 
> This has allowed me to reboot the system and successfully have access to
> the USB devices such as my keyboard, mouse, and root file system on USB3
> SSD.
> 
> Thanks!
> 
> Wayne


