Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web08.5324.1663921580269880939
 for <u-boot-amlogic@groups.io>;
 Fri, 23 Sep 2022 01:26:20 -0700
Received: by mail-wr1-f44.google.com with SMTP id g3so19177399wrq.13
        for <u-boot-amlogic@groups.io>; Fri, 23 Sep 2022 01:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=E0J6y09kHtYUBBVG3sQbqA8UaGcsG6VCjHiMUHn67nk=;
        b=BkfrAhGz+lzFxcatZ6ydPAbDo5z3RFtxeqAYrc/sttbVAU9u/g+aTbGA5vB1+cU7Td
         eFVVxHt+a5+WVwbZgkZx/iMYltkbYiawMyAu49rGqxx5h/c5JamYw/e7wt0dcOQPn4I7
         kAPWcdTKNBa6nyCzLRGwZqQyIB9DASBVd+o7sHjukT/ZyKAJEfWs7N2rxLYr+17n61im
         6LeO/GfiSumxhBt0l0shrKZVwZmXKcr256u3e02k+wMjPB2p/OIn2kxb3V3d59exvUTc
         Ju4UsDw7MpSltIIYA86NaScOmiOvX3P5agYT/jP1jM87+YqjJ1+kQDKqPVHJdzY7TLEx
         ZswA==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: Re: [PATCH] arm: amlogic: add setbrg op to serial device
Date: Fri, 23 Sep 2022 08:26:15 +0000
Message-Id: <166392153671.2115490.16053236998737488950.b4-ty@linaro.org>
In-Reply-To: <20220918161701.572814-1-e.tomell@gmail.com>
References: <20220918161701.572814-1-e.tomell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Edoardo Tomelleri <e.tomell@gmail.com>, u-boot-amlogic <u-boot-amlogic@groups.io>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Sun, 18 Sep 2022 18:17:01 +0200, Edoardo Tomelleri wrote:
> Implement setbrg in amlogic/meson serial device with driver model
> similar to how the meson_uart.c driver does it in Linux. Also
> configure (probe) the serial device with the new reg5 register.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/1] arm: amlogic: add setbrg op to serial device
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7802c3ac52ab44c5243b3ef328ab406de47a2364

-- 
Neil
