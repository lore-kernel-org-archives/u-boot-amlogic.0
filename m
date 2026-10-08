Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3560CA600C
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:20 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14488.1791463571247432021
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Oct 2026 05:46:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=b46yYX39;
 spf=pass (domain: linaro.org, ip: 209.85.221.48, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-486e70f2457so2351696f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791463569; x=1792068369; darn=groups.io;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4sLId22U1O5OuiQ/PwuY3GwdDe7haOu5JLONqeMvhE=;
        b=b46yYX39pgl24PHjSRFsMJoMGm5HMmWzsyAST5shCFJtrMgKhOVzUKIFA5wzIUKol/
         CPsxIkLoV86x5AvooCn9MHbLYUqBfOeBqIv1qz91f/AOX/iS+ymjTRqmCJvy11ulAjAt
         kelXO4VQN+JGLozHMjv/OPYwQOziFyLRn5SO7mlsX3ekBca9SzzBj5BUdLOz++dVuhd5
         VuGIzBiyJAqiDnQj+Ky6P+gGt8vdY7Kyi7FkiqDcSXH0rspeTXMQ2XlavWC+FmHJ41cp
         TL466dD8NI7r6VWaDNXHx7JfQ5zgmwBRVYaqS8OG2KoPHkYUjspvn3ZOrReWb1GLsHzh
         VxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463569; x=1792068369;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4sLId22U1O5OuiQ/PwuY3GwdDe7haOu5JLONqeMvhE=;
        b=ht0fMmZAe6yuX8gOkxjkWzd5UAAZ7Plt5fH1oUtGMYjxewL7OtWgSVusCj0rIECg5o
         Gy5hSnoA1lOgysl1KQSRikRG2LHxEjuCGcP9YwxOkSOScgfAdp2SJM0FeDVp+Z7GzBoN
         N3EXrEAW3TWXUOo+CLL/WMgp4G7/yBFa7N+UrUpsEHU9qCYX9067SawclK4VePdz+GvH
         /dymOJuMWe/rpNhlnpwoYckM4e1PYwOgxSZJyg4ZL10fTfO/bIZfi2XoN/88992diq4c
         laxiaODIxuX795k2ZJHONx8IracQw5RgG73kKwru2bWRVDovBpUDKpKmc9wXtQ+9nXAI
         /TzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoWUfxEPWCxaBYK7gq9xcFh8k9E2EEjCbNTxJVcDOvUfZvdjLhpZajev5LFM0zuzN0zA65pgdkRORUgiueSQ==@groups.io
X-Gm-Message-State: AFq9FYK5T/KPR4US3ZTIAbgMozJTUo/wK6SymDkHl3t7oczi1+1D1YGw
	aOij45QWqmqNUzx8JggjOUP2dD7ZnWBsTQEM1P/pNmIe8nIXDcWQeRbTuY3U5r5yDnk=
X-Gm-Gg: AYBFou1MUZ3im5prr1lyiFi0AHV5xehZuGWz0GNxfdGHOkeAaF9quOp8BIEU0cyK3w0
	WtUG0uFppJCk+fuRuTF86DWA/ECZzOL3ncJpiJKRlwDfBR/sKLbqMoAFalVl25/ZbV6lZZ7Y0rE
	o9K3WQv/LWMEbOEnSnXD0YxmSQ75t+UzEuv/D+W3my1eiCYP04QvPLYh/g6j3okypfUBZ8SSkBL
	dhQL7+U0HUZ8nPi1GMn8W8MA6z8yfhLX3P95Y5FQL8Cv0NHvlEf3LPimGK5r/PROelqFMkwZeDw
	CymRlcxZpYYyd5OEvZbTQzCNBJXhyCA8+hfaAfqoPoWCFAqW1BPcNHnClnQDlDYJPwQ7Ff+P+lO
	6bjw05F4XM1t2XxyFRLKqXl9IbcccytQfvhMud0iWpnBi9tfCZTNjV+3SzYBfUEZaKSBu/VO7Wo
	obH2K6elbDjcZCvlE8o3VbNo48aWGXDbODZnSHMKn3oUTKf1trXiwwNZ4Rll6KZ98Jnk5p5ebrJ
	jCANXreL+L4owG6oHVdYcPIqZZGrrg=
X-Received: by 2002:adf:e186:0:b0:48c:6d9d:9f90 with SMTP id ffacd0b85a97d-48c7288acdbmr11069958f8f.26.1791463569031;
        Thu, 08 Oct 2026 05:46:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:46:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io, 
 Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260817163048.1892107-1-sanderson@brivo.com>
References: <20260817163048.1892107-1-sanderson@brivo.com>
Subject: Re: [PATCH] watchdog: meson_gxbb: Add support for s4/t7 SoCs
Message-Id: <179146356780.183177.7943400413025163091.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 12:46:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3117

Hi,

On Mon, 17 Aug 2026 12:30:46 -0400, Sean Anderson wrote:
> These SoCs have an almost identical watchdog to other meson SoCs, except
> the reset bit has moved. Add a new compatible and driver data.
> 
> This commit is based off of Linux commits 55908e388b5da ("watchdog: Add
> a new struct for Amlogic-GXBB driver") and 8c776a0401f1d ("watchdog: Add
> support for Amlogic-T7 SoCs")
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] watchdog: meson_gxbb: Add support for s4/t7 SoCs
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4242282e4ec21438dad1a99b0555840b47f04d72

-- 
Neil


