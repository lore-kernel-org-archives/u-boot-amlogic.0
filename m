Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.12217.1679314387687966829
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 05:13:08 -0700
Received: by mail-wm1-f49.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso7370099wmo.0
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 05:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679314386;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VZ0X6jmUNaOvsLyUYKl66gni2Y7ka45Kqotk1h52cKk=;
        b=lee8vGTczavFcLXcoF5bnYVyGEDe13+Xfd+0rADI4WkR093pf8EtBlJP1GXLPhKVnA
         M6hKN2nP4M4JKvHZ4kmbYgT3f/UQzkOH8GErpvHt54BsgBGUWjN2I3mS7Zaku6wA33rP
         p0uKKNcaNdNkyLSd2qrjll+bAmGYIyVy/X/cuSF4C8dcOWDLjcY16mGllPldtlqn37oH
         Iyw2bICDeINcfuWv6rMr2qMJiXu4Dia7ifCSaDyll+ZEhr5LHXIit5V+2lD7t4m6Zl4E
         SW9VL/Bi+2KnEiEm2uGfbyKYTshG+UKJPkQU0r/uRjcUmS2UwufQKrzhzjvjwl1rA0eJ
         G3VQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <5e29634d-0751-5b1b-5bfa-4a85f536f672@linaro.org>
Date: Mon, 20 Mar 2023 13:13:05 +0100
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 30/33] doc: boards: amlogic: add documentation for BananaPi CM4IO
References: <20230320114609.930145-1-christianshewitt@gmail.com>
 <20230320114609.930145-31-christianshewitt@gmail.com>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230320114609.930145-31-christianshewitt@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com, u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 20/03/2023 12:46, Christian Hewitt wrote:
> Add build instructions for the BananaPi BPI-CM4IO carrier board with
> BPI-CM4 module.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   board/amlogic/u200/MAINTAINERS       |   1 -
>   board/amlogic/w400/MAINTAINERS       |   2 +
>   doc/board/amlogic/bananapi-cm4io.rst | 152 +++++++++++++++++++++++++++
>   doc/board/amlogic/index.rst          |   1 +
>   4 files changed, 155 insertions(+), 1 deletion(-)
>   create mode 100644 doc/board/amlogic/bananapi-cm4io.rst
> 

<snip>

> +
> +U-Boot Signing with Pre-Built FIP repo
> +--------------------------------------
> +
> +.. code-block:: bash
> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> +    $ cd amlogic-boot-fip
> +    $ mkdir my-output-dir
> +    $ ./build-fip.sh bananapi-cm4io /path/to/u-boot/u-boot.bin my-output-dir


This should be bananapi-m2s since the same is used, or we should duplicate it for cm4io/cm4.

Neil


<snip>

