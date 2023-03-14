Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.3714.1678781196445749860
 for <u-boot-amlogic@groups.io>;
 Tue, 14 Mar 2023 01:06:36 -0700
Received: by mail-wr1-f52.google.com with SMTP id q16so13446181wrw.2
        for <u-boot-amlogic@groups.io>; Tue, 14 Mar 2023 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781195;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtNDw6octgm2t5ZbUuUD2QpYhf/lF2G6diH3f36e6Xk=;
        b=oXGWNajgnenG4oUI9WU75jIiEHqaR9gvnBE2ef4BEVE7X/qcHXjcHTnGUerVntcAvM
         7ZNiLM9wAjsoyhMEQZL+rH7stO9UT/KGAA25nrlFMFnqy7pvosu6spZ2gGtl36Otm1TF
         NTavYCQ89zvwOX7Q+myRT/dxkmLWQVDtcws/848MvlQKlYL6ytIS8xP/3jBMS9nWuecn
         elrfoXq4guDnjHkaKgh2MpGjDSYu+KgPlYQmqs8BO6mkvV1KjQMqbJcA68Wribf0pBfP
         Nlu6QBX16xFfYPgZ7TB9MYavV9JqR+vt07WoFo/nB/E6klheHvh1ZOFxVlbovP+mCfu6
         2meQ==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230307-u-boot-cm4-v1-0-43f5a393cd37@linaro.org>
References: <20230307-u-boot-cm4-v1-0-43f5a393cd37@linaro.org>
Subject: Re: [PATCH 0/2] ARM: meson: Add initial support for BPI-CM4 module with BPI-CM4IO baseboard
Message-Id: <167878119433.3431120.903785814142298687.b4-ty@linaro.org>
Date: Tue, 14 Mar 2023 09:06:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Tue, 07 Mar 2023 09:20:23 +0100, Neil Armstrong wrote:
> Add support for both the BananaPi BPI-CM4 module and the BananaPi
> baseboard which is compatible with the RaspberryPi CM4IO baseboard.
> 
> The BananaPi BPI-CM4 module follows the CM4 specifications at [1],
> but with a single HDMI port and a single DSI output.
> 
> The current CM4IO baseboard DT should work fine on the Raspberry CM4
> baseboard and other derivatives baseboards, but proper DT should
> be written for other baseboards.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/2] ARM: dts: import initial DT for BPI-CM4 module with BPI-CM4IO baseboard
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/384bfe31c8d77b69542e3bf76f823a42329847aa
[2/2] ARM: meson: Add initial support for BPI-CM4 module with BPI-CM4IO baseboard
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/cc073f6c2241ff8adf2fc2869bd1a6fcf379a172

-- 
Neil

