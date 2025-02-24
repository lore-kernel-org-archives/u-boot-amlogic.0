Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0041C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 19:55:38 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.99951.1740426934797154888
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Feb 2025 11:55:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=qUOEp/eW;
 spf=pass (domain: linaro.org, ip: 209.85.128.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so46037515e9.1
        for <u-boot-amlogic@groups.io>; Mon, 24 Feb 2025 11:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740426933; x=1741031733; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsjwVIyW0RklY+BkHj7XeSOdzz3X+VS3AebK9Z13sXg=;
        b=qUOEp/eWuLZnpW/GrPEmSOQalQTLbqZSCupwqW3GQ4tcg0q+LZSNLSs2ja/UXZyFu5
         FSXwxYChdWOY2q22omztrpmysaGUBUN8wf4Ispvz/kzx9JI7i+rpErslYojbx/rpHhuR
         ZgQVFudJDpZcesq+F4BV/aa7cal0OPOmMkSoo44AnlO9tsCesN8bt07qenOilr/zclSj
         IGEaK8bLscbv54QbQbH9B1kdnb+E2K5B/7nIxajvpl+6FXXBlvhaapiBia6dq/HPb4jc
         Sr4mihpiT0sbPIxqJPLzTcjHl2k7eMksJAxT3FEw29GXsBpegCrjO+tV7HQ25+KpFBwE
         qbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740426933; x=1741031733;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsjwVIyW0RklY+BkHj7XeSOdzz3X+VS3AebK9Z13sXg=;
        b=i3XG4HzRf69IiIBf2TxYzPp466oVuD4coPnEZEsc+ON2WRY15LYBtZwfB/gZHYeO3s
         zj7KngZjCG5uBm6kjiRRbPLUM5ddcEtNpIJOsvMB3QALxunajUNJseIh8czHGgNOQklV
         KPf2TdSjqjbtkgzND4u94efJPTf6Wc/yQD+hw1YPQX1bLG7LgO8Myb4dcc/JXYAXfliT
         lKzRdACuGGxhDXC0QbcQXc/6LISay5823MbLjrrBT5f5yQ1NXgZaMPZHnYTJ89LcKQmR
         lq1gOv1j9vyb6GkrLB0+dnE7sZsUj5WEHf8X2O1uH1bsfQczv8xgNbA3spCKDh69+tW5
         5NNA==
X-Forwarded-Encrypted: i=1; AJvYcCUBy+QL+/tw9COKO5fZjB5JkAHMQCaquy8PTxHRxzzDfnn+yCoBgEZTIug03c6bwcn5Fw9vZOnuu24WsYYkbQ==@groups.io
X-Gm-Message-State: AOJu0Yx3UiJhsJaAqJv4vMm/k13Ho9nwBDZuehJibe1U8/WZRVTWa/M9
	zjUiqMCydGFwxp7RtUxsroDrCyz4Et0gFV/8ts1IsiUiqb6crBfNiLkqnlqNMU7Cr9kbV7+0H9P
	h
X-Gm-Gg: ASbGnctTRKvn+Jk/DX1gkuAQkG3YfFsbI/0WGX3PznRiUstjo8TDMSNDbjps8hCOa8K
	iBEFblsdIa55ENYSlYsxfsweSa+HB2XOGtk9C61+BnImJtU0ZOBan7U5bBBwznWEOY+qTm46YPf
	Z9bpl36/O+sqeggITkswErpB8IIUOX9Yjow38IXoX7pDl+EfYJaTfwKcjCGLF7+J7j+hoOMyoxq
	2dmKnwviqvnh5qFm28ezaxkFje8Lcq88FYE2KgCVQAV3LYYD4tvuCtAfQl5YSlfzonH8nZBPWS5
	qaXYGbRM1zIB16MMd32e0AVV1OQrygB/If5ooxOqt5JWf4c=
X-Google-Smtp-Source: AGHT+IH8369Zb5qEoDqgPCff4afkwCWfcJRTJMmuYFh8yKBMnpemj8ycrWRgOb4bYT5bmEApqzZJ2A==
X-Received: by 2002:a05:6000:1f87:b0:38f:3224:660b with SMTP id ffacd0b85a97d-38f7079aae3mr10337419f8f.22.1740426933176;
        Mon, 24 Feb 2025 11:55:33 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d58f3sm32417836f8f.73.2025.02.24.11.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:55:32 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Baltaz=C3=A1r_Radics?= <baltazar.radics@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
In-Reply-To: <20250110111335.9221-1-baltazar.radics@gmail.com>
References: <20250110111335.9221-1-baltazar.radics@gmail.com>
Subject: Re: [PATCH v2] board: odroid-n2: Update docs for signing
Message-Id: <174042693241.751150.12654581157570837012.b4-ty@linaro.org>
Date: Mon, 24 Feb 2025 20:55:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Feb 2025 19:55:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2626

Hi,

On Fri, 10 Jan 2025 12:11:24 +0100, Baltazár Radics wrote:
> The previous instructions resulted in a bootloader that wouldn't fit in
> an MBR gap. I have updated the docs based on upstream's build process.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] board: odroid-n2: Update docs for signing
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a2f995ec5c0cfa4876ad98fefb8603b24d96efad

-- 
Neil


