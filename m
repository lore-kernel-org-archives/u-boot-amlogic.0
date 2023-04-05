Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.125200.1680683400190381105
 for <u-boot-amlogic@groups.io>;
 Wed, 05 Apr 2023 01:30:00 -0700
Received: by mail-wm1-f48.google.com with SMTP id he13so789690wmb.2
        for <u-boot-amlogic@groups.io>; Wed, 05 Apr 2023 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680683398;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPGOis+/5JDBnip3UZb5NiU71SxCqzfzuLtkksk2dGg=;
        b=E8KxZJx0tLFqrg6AiWpF9bWBE0V5pJPUms7gXHj4uceB+Fhgd6Ovv6qJSO1DqhupBA
         /EUh33unuBom3BZOCWi6aeobHdDAM3Wg8DaJ2Wg0L2CH+uu2pUOkxqIjQ46gR+g/alFM
         yvyRD4PU/Mpe1hHpoWuzqqlrgWYqNhPw7pRV8I1v00QqAqRhcgSjhPyFqZO6LncyfRLz
         Dftsi9mX52KdaQCJ8Ys4zCK9TzgUN/Wnbpub/c2aUS/zJnR+BSTShQ7COUOdbN4G4n9s
         0lKUsF+fAfGokw+j6rfuxAlqdD5+OTYqDaPfC9V0kWVXY0Ea6To1GfbBVfN8JSmkCB+N
         q0kg==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <e3c87efd-4ac1-24a7-503d-71669aae5177@yahoo.com>
References: <e3c87efd-4ac1-24a7-503d-71669aae5177.ref@yahoo.com>
 <e3c87efd-4ac1-24a7-503d-71669aae5177@yahoo.com>
Subject: Re: [PATCHv8 2/3] boards: amlogic: add Beelink GT1 Ultimate defconfig
Message-Id: <168068339783.1444622.14348242716715530240.b4-ty@linaro.org>
Date: Wed, 05 Apr 2023 10:29:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, Karl Chan <exkcmailist@yahoo.com>
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Tue, 28 Mar 2023 04:13:14 +0800, Karl Chan wrote:
> Add configuration for the Beelink GT1 Ultimate board.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[2/3] boards: amlogic: add Beelink GT1 Ultimate defconfig
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/93a997d00b77402dea95bca79e45371b79d07708

-- 
Neil

