Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512DEC44522
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 12:15:21 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7762.1768919767737717320
 for <u-boot-amlogic@groups.io>;
 Tue, 20 Jan 2026 06:36:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=q22luf+h;
 spf=pass (domain: konsulko.com, ip: 209.85.210.171, mailfrom: trini@konsulko.com)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81f3fba4a11so5264178b3a.1
        for <u-boot-amlogic@groups.io>; Tue, 20 Jan 2026 06:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768919767; x=1769524567; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EhlILxjoZhxMoQUOj6XvHJ777HVzpZlsyUcG5/tdTo=;
        b=q22luf+hCWBMpo4SwLkEML/VmQsG+iiFBMS2niNZpwjwveNmcTtcGwQ39JhOei9GL0
         vjLuVeMnBaUqCqk80C9D9i/W6deAAI2SIZ8iHLF3PEA3YfmcGnz7Vf4VTIq60X0m+miy
         tpTc1cpvXdAJ2yxAysIqUEEFgOnID7Bv5fuVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768919767; x=1769524567;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8EhlILxjoZhxMoQUOj6XvHJ777HVzpZlsyUcG5/tdTo=;
        b=NnjrgNUdxwnKAuX9GL8fiZIvZTrBEcYR1DqVwTeT2MNuxB7qkqdBCxJZoQo2K2O6P/
         UeA1TFwDoXFveNKC8T1uWO10DGAUXHWet8JrXoBzQ6s0SC91gmYO2YtboVrA0fzRPgDD
         qGu0Pa+vs3jA/1mNtjossJ1iYQEzW3b9/tPtwsMuIBJqr4S3pF0udZu8uc5zWW7nurc1
         lwTwVvRtQGsgKGIfgw9tWJ5lXnMkB7JiyDo+s4MrDyTt6Y+jvBH20L3Ik8xtaR6yA03O
         K1t65nJzP446fBpCuUGPktzydom7IKmKVcwF/jgD9oCLcgcfSMZAFSRHaa2OaOLbRDLJ
         ff7g==
X-Forwarded-Encrypted: i=1; AJvYcCWrAqTrL6vNirUzT4e6hUipuaA1lmdiIEgki3SOxSpEi2g4JMI3jNaFMrFaOzdipgpFQXrABoHvvovAO8Mdlg==@groups.io
X-Gm-Message-State: AOJu0YwDqJqzUsiYFXXJFunqlY/V/q/KjRrezBH0NhCOzw7w24z+vHHZ
	PFJVsLE5VNfwgu5wdKd1GXOnRPqwhrEVzoQbd4t716te3N4OPx9lIpmQijmW2HOZR36XCjqlp+f
	uVQ8IC+c=
X-Gm-Gg: AY/fxX53fu6/0yvh2j4QPj7NAFBFEtrj3y8Cqu7nx45dk20qcnsNJz9B9zdaFXISuf+
	ziPQ+Bpw41ObzrnaIXFzkXjh+JB6c2RTi/wWH53qDP0xaSKwOUJ9GAYlxEYHE2Npdihf0C+bN/y
	4TMua7pkfzEkPEcCKMBlBT9+UyELLi1KA/B/iEOJYKIUtpOTdyQ8EHeSossMmH8pUEKf4epdv00
	rjB066CMEGFkif05k5g9z7wvDtkctaxRd+mofBKzMEb0mJ+E1LczFYVvB3o0OtftQ3k4zrNW9M+
	Xeai/56BR0oG2GqAxMYo68VBGOJNRTJNXdtSEunscJslbn1z39ZibXXH/ECYbzCltHF28XbeyMx
	yomc4y02yLtrAxteq9VWxmd21uglTdG+YREnA+TKnEN+RaIdmzpuE+/s/e88kv4MIcSG/CFH99S
	91lDTEQkvvInd9g6Mdm+tnS1CXgqSQiyEfyREuk7lEkEQwlancZA7bNa6A9lKn39o67KBrcNr3x
	ZuA+2HrTYHo9wmfHkTQBltSTpKtqJIV86yqZWhbiWFhd3JI
X-Received: by 2002:a05:6820:16ac:b0:661:1ad6:1073 with SMTP id 006d021491bc7-662b00641ffmr687664eaf.52.1768919460968;
        Tue, 20 Jan 2026 06:31:00 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net. [189.203.103.235])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044baf38ffsm8657418fac.5.2026.01.20.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:31:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: neil.armstrong@linaro.org, jonas@kwiboo.se, 
 funderscore@postmarketos.org, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, Robert Marko <robert.marko@sartura.hr>
Cc: luka.perkov@sartura.hr
In-Reply-To: <20260113110806.648534-1-robert.marko@sartura.hr>
References: <20260113110806.648534-1-robert.marko@sartura.hr>
Subject: Re: [PATCH] tools: amlimage: include <inttypes.h>
Message-Id: <176891946008.379251.4344949458921511050.b4-ty@konsulko.com>
Date: Tue, 20 Jan 2026 08:31:00 -0600
MIME-Version: 1.0
X-Mailer: b4 0.14.3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 21 Jan 2026 12:15:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2888

On Tue, 13 Jan 2026 12:07:38 +0100, Robert Marko wrote:

> PRIuN, PRIxN, etc macros are defined in <inttypes.h>, without it being
> included errors like:
> tools/amlimage.c:124:38: error: expected ‘)’ before ‘PRIu8’
> tools/amlimage.c:126:31: error: expected ‘)’ before ‘PRIu32’
> 
> Can be hit depending on the host compiler and HOSTCFLAGS.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tools: amlimage: include <inttypes.h>
      commit: 6f42057c67fad2ad66ed73b9c13347ac7881876f
-- 
Tom



