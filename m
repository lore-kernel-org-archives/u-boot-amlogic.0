Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86726D44162
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 14:17:00 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web11.22162.1732025816282079334
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Nov 2024 06:16:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=DJdOoYbL;
 spf=pass (domain: baylibre.com, ip: 209.85.167.48, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539eb97f26aso5949889e87.2
        for <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 06:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732025814; x=1732630614; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO6iMguNjFQi8RqwLwvlRTkqCtsJPLcli0cjF+ohy0Y=;
        b=DJdOoYbLyymD5DvHd10tzjV1Cr+RW3qs7AGBDW+e7KmfkrgxRPnHWn0TlBsG8Fy9iO
         OUxU7CaLFIuZCb44Hw/CvyGGmkkYIqVo+eC8kkm2jADUkHdgg9TDGrvEZEq0p3UpFLKP
         7qyAY4A7plcYJDcGOtoAr6Ki7rcbjKn9QeqFp+kke9kCn0omumQUgeGfVpSsRDLs6wSG
         Ub4YCm9lHYWO89ZDkaHuRL7Hv5+sp9tLqi9iPiVYqkdo/s6j16R3IKap7BO/pUBlur/G
         mL5X3ED29nJOFNlqm6uvdCAoib0w8nLt2239bjPK4QoQCF0Ir+4IC3ZCWatAsT9InOFI
         WuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732025814; x=1732630614;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xO6iMguNjFQi8RqwLwvlRTkqCtsJPLcli0cjF+ohy0Y=;
        b=IP5zsjFjP28EwzCeQWRrlBYpgf38F+ORkjFjsUCW0xMTAc3y9inFg+UbsiLaSLIuvH
         eXqbjTPYqtFNYnGL6AXBiQKztiNvH8ngI9xyya/vVJc0//Rf8cnyG5EnFOu0TelhgELB
         PF0S96nSGP/V1wJfqLIKHY7N0fjW/PAjjkygp66wg42Xsy2tQjmfrNxgPUd66ZjrsBXM
         TdzKCkOe5YCgmcy2yIqSgawMo2gMCzS1N8hPJHeJ6NKvp2KQw02PC4rJ1sZoJouRHqWN
         MEiszrDmhXBMpU0FyuM3ayAIsojFi3KMtbala18UWiRWmSZBNKVbFcsnQIUCNIECxbpn
         u2ug==
X-Forwarded-Encrypted: i=1; AJvYcCWKRvw6l1go1+gH06FgMIfnIFWuuIQ1+4JbAg4LefjhmCV/fOFbpi3mKvN8vYjAf3UyCDse89nP7/gEN3QJBQ==@groups.io
X-Gm-Message-State: AOJu0Yy4MQhdzTGKkJslgt2EhXyikLowneifoHJ2I02adheVvQZxnh60
	xBIMNY/0Eo+lXQRHBl1mr5LDzUoBwCFiCABPncplyoHZ7LNQeqCGpgESpC4YETCCt6WLD5ghNRl
	u
X-Google-Smtp-Source: AGHT+IFcuTEClhFjjR+ehJtthKvZ8dHlri+0w579n68GJW31iFZCj9AAYLrYHDHX2WAtU1uSIYTJug==
X-Received: by 2002:a05:6512:130e:b0:539:f807:ada5 with SMTP id 2adb3069b0e04-53dab2941e0mr8476101e87.3.1732025814132;
        Tue, 19 Nov 2024 06:16:54 -0800 (PST)
Received: from [192.168.2.170] ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2946a3sm195147695e9.35.2024.11.19.06.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:16:53 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io
In-Reply-To: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
Message-Id: <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
Date: Tue, 19 Nov 2024 15:16:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 14:17:00 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2573

Hi,

On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
> Actually bootmethod android only support android boot image version 4
> and with AB image, some old platform wtill use android boot image
> version 2 with AB or without AB slot.
> 
> This patchset add support of both version 2 and non-AB slot images.
> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/5] bootstd: android: add support of bootimage v2
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee992e90bbe84278db20d29159e3eedfe0d
[2/5] bootstd: android: add non-A/B image support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e7bd3665366ca2704d1142d3f16f22c36
[3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773b2df5e4cabbaec57a0f2e7f212dbf823
[4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e58717f2f33ef0dbb422026ef71938f2265aa
[5/5] bootstd: Add test for Android boot image v2
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35a33146f887948d34130229388280844a

--
Mattijs

