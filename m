Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.27425.1685614364421096686
 for <u-boot-amlogic@groups.io>;
 Thu, 01 Jun 2023 03:12:44 -0700
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-30af0aa4812so673320f8f.1
        for <u-boot-amlogic@groups.io>; Thu, 01 Jun 2023 03:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614363; x=1688206363;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJKMiC+93dIit4FeHmor/5plzJ6hPYyfEMy8vZnqHeo=;
        b=jCFvlmGca9gC3HlxpClZPaYeXjRFJ8eXiL3J6xHbvYqUe2YMTyVvcl5suC0D0W4uQ4
         Q1aBgGI4lZ8bw3zIh6lepdtt/TBqFEQAYWVfvPEynO/RPLjNr4iez6oKQvMw3dB+oWd7
         jld6Tfpo8k0hTl1OYJwV1FbhhMz9yL/1EV404zoWF7hRydk6qDAcn9HUPQn5/iw3JBiN
         5Fm4lOXz4AlTBAb2Mawbi48XWJf1V0htRfvkzjwRshGenAwBWHJ8wVmV7KCiQjZKWgu+
         L7lQ9esYLvtTVAVeOS/qunKPNhJ++JptYSyJRRAoTYVCx3KLUSH1KmiXxCzhG5Tfwpsi
         tClA==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230531093156.29240-1-avromanov@sberdevices.ru>
References: <20230531093156.29240-1-avromanov@sberdevices.ru>
Subject: Re: [PATCH v2 0/3] Meson Secure PWRC Driver
Message-Id: <168561436226.3476897.12102323577915471336.b4-ty@linaro.org>
Date: Thu, 01 Jun 2023 12:12:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jh80.chung@samsung.com, Alexey Romanov <avromanov@sberdevices.ru>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Wed, 31 May 2023 12:31:53 +0300, Alexey Romanov wrote:
> This patch set adds support (driver and sm functions) for working with
> power domain controller using secure monitor for Amlogic A1-series.
> Additionally, in the future, the driver can be used for other Amlgoic
> SoC series, such as S4.
> 
> Changes v1 -> v2:
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/3] arch/arm: meson: sm: introduce power domain functions
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/9b5844975f3bcf4bc16858d32e12ce7a2832f8fd
[2/3] dt-bindings: power: add Meson A1 PWRC bindings
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/6dc3373d71ecccf81ad2270c68ccaaaf5ff09929
[3/3] drivers: meson: introduce secure power controller driver
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a1fd9cb41fb1fda2283a089f9c97e5eed4d4940a

-- 
Neil

