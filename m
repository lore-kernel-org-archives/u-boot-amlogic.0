Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A783BC54E58
	for <webhook@archiver.kernel.org>; Mon, 25 Mar 2024 08:18:10 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web10.46872.1711354684370192025
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Mar 2024 01:18:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=aSTtiZFf;
 spf=pass (domain: linaro.org, ip: 209.85.208.171, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so60087481fa.0
        for <u-boot-amlogic@groups.io>; Mon, 25 Mar 2024 01:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711354682; x=1711959482; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpU1TGchkARObssVrA2Ds2wyENdX8do6LTTdhbXNoIE=;
        b=aSTtiZFfBGcJnrpfYRUPqthkaComVI2fu5w6O0srtjDS8Jfy57UsWg4Cc4l+GiIZo3
         jOCURL5zmtITJPPe7Xj9BbPoMc8gQvO2k6G1D9I4mdw4vI6+mFVQ8GCICt9kS1z1D4Uz
         FFr4MfbVu+S9OnMZxZReElGPTWpu7xK9Kt1eDc4wxNT68nl4SvP/ye8WPik9S+waSFV+
         NItA02HiSuXmiiGQZ6wt1A8yt7jVASTHExRbfI/p+gxz38YLpfCMs3vKsbCWHhVN1Bx7
         p3omYwrM/NwTytYcc2/Y5wD64EgHhJf+XDjUKi0dQ74y/KB8cYbtzmtgtFF5G+2KR/7U
         6lqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711354682; x=1711959482;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpU1TGchkARObssVrA2Ds2wyENdX8do6LTTdhbXNoIE=;
        b=wE80cG3okAo9+vKOeQQQEtUzVS55X+WTFYXqWsEH/ee+rq5jylhbrcVS8QtuexwJbE
         dZOr/eAobjJasaUBBDwriybKQ+EbcBNHXSHkut9QSSZbTQc7be4hqtLdNzkf7dVwB/TR
         OQ1D45m/gROGBrymxKjZaWilanVYKHANrLS9Xcww6xLpYEJLCYROUSyn+GnuuAOZNWfR
         ZIrsEH3zEYpB2PciXCTD8t8TRI4TcXGyxlSWWfSNCvV7nsZSCe96oOrqFwHh7jOwWmcI
         3Y0DtpqOZjIOs22t8rKSKr5g0n5JIyrvQqZm+UlYPDfhK2eGht4LSl7mNcgc9JJZgf4F
         7NFA==
X-Forwarded-Encrypted: i=1; AJvYcCUVf1FhW8MdSon+433W+4Ph+U82KIXtszrZ9okVp1EK2eFL7J75Y7eoqhHE/d+PiZIqN3jH3alUX2YBJueHAuDts3nWYwaSXx0=
X-Gm-Message-State: AOJu0YwMViDE1vpK+z1wtK6oVTZxiZoghNRprqpqia+n0GjDtKryyaTX
	KtvVK3fQW6CCilpRGz60X6FAgYlK3GUKO/3l8q9+d/zeBuFQ6cB0GMIf+ic7jFFMeRr4sMs0ub2
	HHZk/6g==
X-Google-Smtp-Source: AGHT+IFE//evOrpPeVLu9STIIFbrNqOZ3JFuxhPxB0yZhy6bAjG2sDrFE59CJewkalSV9jtFCPNhkQ==
X-Received: by 2002:a2e:b0d2:0:b0:2d4:37ca:92d1 with SMTP id g18-20020a2eb0d2000000b002d437ca92d1mr3626178ljl.42.1711354682118;
        Mon, 25 Mar 2024 01:18:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb4a000000b0034174566ec4sm8793731wrs.16.2024.03.25.01.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 01:18:01 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, Viacheslav Bocharov <adeep@lexina.in>
In-Reply-To: <20240227065551.580199-1-adeep@lexina.in>
References: <20240227065551.580199-1-adeep@lexina.in>
Subject: Re: [PATCH v1 0/3] board: amlogic: jethubj100: small updates
Message-Id: <171135468114.4115976.5643461187922609574.b4-ty@linaro.org>
Date: Mon, 25 Mar 2024 09:18:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 25 Mar 2024 08:18:10 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2242

Hi,

On Tue, 27 Feb 2024 09:54:03 +0300, Viacheslav Bocharov wrote:
> Update JetHub D1/D1+ board support files.
> 
> Viacheslav Bocharov (3):
>   board: amlogic: jethubj100: fix common config header
>   board: amlogic: jethubj100: update MAINTAINERS
>   board: amlogic: jethubj100: update docs
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/3] board: amlogic: jethubj100: fix common config header
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/803fc9955164e17e8c6d1896ac2770e17c251f11
[2/3] board: amlogic: jethubj100: update MAINTAINERS
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/5e61fedf3424374a065eb23fb48963df2606bb73
[3/3] board: amlogic: jethubj100: update docs
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/2fc5e3c1668cffdb4b894986e98c1ee10f6e9955

-- 
Neil


