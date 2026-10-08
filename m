Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C702FCA6016
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:20 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14491.1791463573365877816
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Oct 2026 05:46:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=mLHtYIJ0;
 spf=pass (domain: linaro.org, ip: 209.85.128.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a020e65269so22862315e9.2
        for <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791463571; x=1792068371; darn=groups.io;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/r0eZQ+QwOkKC/EpCQ7wf6/3GcygC3j9nEkVwHYoeEc=;
        b=mLHtYIJ08Rp2yhkgYLG8eirT/6y1kFrvF3EeEURwCydS6TjyPp52YQ3TB6hodbM1V4
         O07MC/j9gPe3a9hHWE0WVkzo/DEZWY8Q/WV5R77HVCzW8h56oC2B57RM6mTGPiynliVt
         zsJ5Errilp/RNHlgn2or4UHWK4GCbUMYjMVmxGVtcOhIqhOXl/Qj3oO8Ytnmm8xpR+pH
         VGgQWu02ClUMeG1ou6J71BoM17BKFMSMiDB9H8WGanfwN0IER6gjWhaBjIWOwCKbG5nR
         r7PSQh3mm8TDo+lEvt5BfnHHEKqvTR3I6ThmuYZoN2NUhjGrBA+ubHjeAe3ubi8teXNS
         O01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463571; x=1792068371;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/r0eZQ+QwOkKC/EpCQ7wf6/3GcygC3j9nEkVwHYoeEc=;
        b=mIJUr/Abdfa1WjbZzf8gDzpIpS4Vxer2JOgkDw8RW+pdlFQYbjIrvazpHS18jAFAjU
         ETP4NWf/zZTgX7iY7s2vM8pPwzD7OARi9TIrOXyCfkNQFfodzbeDK5pwSKq6fB3loG9A
         9i0Np3AINz8ObLpWQ/ruVRpN4RcqNp+/7U0QRIJuENUG5xeS+d3AdtrMiyXJ1tgFUjQR
         6GVaXKgTr8SGAgQVZIOMfDGxO0maLstTLDHJJK33+U6TE2ziiCqw7ehG2xpWJxUB/4rn
         MijfmAAiRgKs6pg8fbjugyKMuD5Rp2vdn7WNYhSVAteY6+5X0fOyVxILev3r0DKMHoC5
         cY2A==
X-Gm-Message-State: AFuF++lHzWzXKjG1n7LXR6W/ED1aSiTKcQqQzJvAKqXfzfy87G+hEYL9
	9RUSFQZQn3X3jiZkXHdf4cYwHaywYKwy6YikABc9B0lGSrhePPu9qO7rXHJ6zsnNXAc=
X-Gm-Gg: AYBFou3mEEfnLorAwXUjemz4pyyu6abtY9ctth+94nObisd5m342RP80738vOstEAqx
	lpf0Pe03ojY8YSFMgQxBKszGh25q5knVBCcKSRrpuEJnCyAsRjhgc0GFu/mEAsDpqStOg7wehNe
	Br0p75ar2xlkawVXUZL3l4zzBxSvHrXzw9nWHBu2KZAhNrIr5wdhhmqGCz61u1v4tWPZWplNCIu
	MH8XohCyhgicAFmdURkqz1veIpci83bQpMEmBefJgoIFAW6pR5F31l6OjyJrHy6nyYxGizvT9b5
	JTRP4SWuQXABQtAuD+x/zna4kLnC71r6v+tnw7hK8mbD0y+0e+sLP4Eif9hELs1vFLHq6wCXQ6b
	OIXn6hv+yQx/wc+WJTtlaqAE5/SliQ2o3DcZkKq2dXLRxfKOQ4lHlfJu/mtVo6GM6MLZ/SOMGk8
	sL7c+9Nl37F7Y1A0LC7ti8IY+pXJQ7nqs16xx7VKzJzSrbbeBUxRUJGHgIAmaDJL+ZN3zaIBAu6
	s3+acQc8vxYy6hHUplJ
X-Received: by 2002:a05:600c:a00e:b0:4a0:1a18:b742 with SMTP id 5b1f17b1804b1-4a1800d3de4mr103393365e9.2.1791463571207;
        Thu, 08 Oct 2026 05:46:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:46:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260817163604.1893382-1-sanderson@brivo.com>
References: <20260817163604.1893382-1-sanderson@brivo.com>
Subject: Re: [PATCH] reset: meson: Add s4 support
Message-Id: <179146356917.183177.1543337014834269186.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 12:46:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3118

Hi,

On Mon, 17 Aug 2026 12:35:56 -0400, Sean Anderson wrote:
> Add s4 support. There are no new features, so just define the layout
> info.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] reset: meson: Add s4 support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/fd46e031ba477a76af20b12f25b797d9d5997a2a

-- 
Neil


