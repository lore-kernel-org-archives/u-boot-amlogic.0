Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5FDCA6015
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:20 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14492.1791463574548546638
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Oct 2026 05:46:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=pGrZ8LPZ;
 spf=pass (domain: linaro.org, ip: 209.85.221.47, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c02782159so1938752f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791463573; x=1792068373; darn=groups.io;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XBTS/Yew51B1t/ABTG19pLNt9RRmu3ZhQpoaK55Evv4=;
        b=pGrZ8LPZjaqRi9Thx0bMZfAZE5FeAL+YSQjRG2buD9L114J+O7MRu4e3q0OD7rnUI+
         gdomqPuvBsmBlPUDY1/GyaEXLUWQskcESa6LOtrW9LuqmUZ+G5ydp1ga6XaGuXcbJI4I
         mTb6GWQNoKY6wBslIDrQ//ajt6VHC0YAex9/3PsGCQg3id3OonzKnJUXWbQSi9Rg5WjP
         vKKmgwm6+0P1+CEBdal+FNiHyVOIBpmBjSk0P2ZAcgK6oUtIfrJbamyf9+dxsDkCLGbV
         IeqU+IApXGCSCr3ivEpINLcZc8JIEUOSbCUGWeFbmu09o70wa/VzpEKkr5ihZhZLoSF+
         +0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463573; x=1792068373;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBTS/Yew51B1t/ABTG19pLNt9RRmu3ZhQpoaK55Evv4=;
        b=z6WgGP9FgVJ0XbpqkXwmSfZOvAlCIoeAlrtT/h/wm3Wh1ZHa/kL7jIRU7nWP8fwUiI
         MvIwnCtKiXrmYwEvDefPohCH68B742op5jANUnYCYXvDPyB3QFn1dicGyhTReb/YT6om
         v1Cv24hDsQoyqpuD6BJfbVgDPHdmYBpCskmi+C4gGQQXb1Echz/DIWwmqAUqHTQ2LMB+
         XohUAEPjjvhMvXTEogoT/TibA2AJwa9yXT40pET40M6CWRVNqJN0irTwp0lKzKiK25Dx
         XyrFTsgs5FWq2BshPMeszrQTt6+9odVIaHTpYu8mJM8mMiJKggY9d9znt+xmyFtOgzkQ
         A2uQ==
X-Gm-Message-State: AFq9FYIEBKvNXKU/fyG27d3hm7mBtk0tmAOSUI1rF+BsFGgz00SZjH/H
	tHuga0efP2U3SSsSIcYV9dzuhzGdFGQcFWIOKvb6bKbvWpstxJcqTqSqmY5jmHSeuHU=
X-Gm-Gg: AYBFou07wzk3m0jESLEb1n5ZPa9raOcBCO/vEtHKLoZ1puTLF4Hy9ggffTDNCcseOuw
	Tl8ZEEoN7+uTyq3HtVsZDGYTggfXO6G3WF1jlG714OWDfR50fVqiLHMa5refqHDqKWgKXJ36+Wx
	jsOnFxJUSnTDtefVPnKKl3kRCfLmCcAFAZuy095xQfr7YwrxPAnJItvLxYz1oMAFm+60sqTytAR
	zfSXgyeIkPQElANF0RyY7FxWpSfcIYJIO4gsvAcaiC+UVVuNPdAeHE9UUtkT6fuXMS45QKUy0kS
	DNANc5eFYbugReYqk/2tNojXDSQXvmbiOApI8PXXg6BhQiw6T9uXLy7h6SrNQBAtsKILKr/+FWW
	lc06fPgWYkbB/9q+9396r9912ebKvOFbgok50wiBCs60ORMYTxpukIDHOuR4cZmFqFaJb7u/mjA
	9hw+TqPmO14za+9TDx+k0Dz3jC2/yRi8eAKpH80ZvJLteWzMNsTvZ8Bsr/UPH3oB6/b/YBNc2Sx
	ihW/fVqaKLduE6e8Pt1
X-Received: by 2002:a5d:6092:0:b0:487:91e:d8ed with SMTP id ffacd0b85a97d-48c72707e41mr7981719f8f.2.1791463571972;
        Thu, 08 Oct 2026 05:46:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:46:11 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260817163438.1893025-1-sanderson@brivo.com>
References: <20260817163438.1893025-1-sanderson@brivo.com>
Subject: Re: [PATCH] serial: meson: Add s4 support
Message-Id: <179146357137.183177.8701598122673179908.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 12:46:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3119

Hi,

On Mon, 17 Aug 2026 12:34:36 -0400, Sean Anderson wrote:
> No new features, just a different compatible.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] serial: meson: Add s4 support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/5bbec48b820f79c79c82fcaf1d7c3a25f080abb2

-- 
Neil


