Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.104772.1673360877390671071
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Jan 2023 06:27:57 -0800
Received: by mail-wm1-f46.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so10104030wms.2
        for <u-boot-amlogic@groups.io>; Tue, 10 Jan 2023 06:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzI5m9VUDiU+5SZtQo/S0lkexvYU+0Yha3XR43chx3M=;
        b=tQolkC3zJxmlFRSPJqNmzNTE0dqp0DuAA5h/VNsY3tkpIXasSbGYsi69rsnowKiuKG
         UadJ8GVe4/T0zIIriNxpPBCKGyYnvtcR2tQnbb5zCAPHsGUjET5N6mdqkgACO2djBGk0
         56szDnVB2CJm4CaemZeQKfsvuElYI7AzDAbWu7RjmF5EeIqKnWg7mD0DS0jvRdIoX92p
         AwnYYcngpjqdTW63Tx6MRa95YrKtHzyqlnZoIoibmemg9yL0iRYRoy8+ni+2pGdzC8KN
         RZyLpSXAFSJJfQ88TQWK6/o/zDvmmY9dDK5yFDojjDDSQvFZBGSjmfwSEDaTZ4AUeaUm
         516Q==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20221222093358.204520-1-adeep@lexina.in>
References: <20221222093358.204520-1-adeep@lexina.in>
Subject: Re: [PATCH] board: amlogic: jethub j100: add rescue boot from microSD
Message-Id: <167336087509.1975362.5773554624875702027.b4-ty@linaro.org>
Date: Tue, 10 Jan 2023 15:27:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <neil.armstrong@linaro.org>, Vyacheslav Bocharov <adeep@lexina.in>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Thu, 22 Dec 2022 12:33:58 +0300, Vyacheslav Bocharov wrote:
> The new JetHub D1+ has a microSD slot. Add rescue boot from microSD
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/1] board: amlogic: jethub j100: add rescue boot from microSD
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/559871524a5012fcf1e3c8449322b22d07e4a7a2

-- 
Neil
