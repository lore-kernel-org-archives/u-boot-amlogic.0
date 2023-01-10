Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.103561.1673358128579125451
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Jan 2023 05:42:08 -0800
Received: by mail-wm1-f49.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso9951036wms.5
        for <u-boot-amlogic@groups.io>; Tue, 10 Jan 2023 05:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQtjEP/taWIm9R7efQ5kUkfaTC2q13uBQODds65NNr8=;
        b=gFqdJJLgITvRAQkmQU8TmNOFoHuGbBVAJta7keqnyJEK3iFRIMH1NNBFg3U7PYg/Fj
         6GKOfvCgJtPqnPlGBOQWNIC7DomRz/CA3JBojOlVu3zMpZCpVu4GLmSKLX9Kdm/HdSEM
         5lDVFnqXzeWJBDnmw/cfr1zHDIDIghH2QuUCAL2nEZHdYyHJt0ExvZc03MFCuBhvygtf
         wC7mJavCRaf+N9M/UkGDou5YQXN8abm71UlY8i91TFTVbICjk9moE2irlF2uBwrkdTvm
         wsiHyPmPHN+b03c9jXpG/RYTpNhBz9KHea79FoJrIHbLZIcYxBau1Lhqr14nM8HQscn4
         5ksA==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v4 3/5] doc/usage: cmd: documentation for meson/sm command
In-Reply-To: <20230110105650.54580-4-avromanov@sberdevices.ru>
References: <20230110105650.54580-1-avromanov@sberdevices.ru>
 <20230110105650.54580-4-avromanov@sberdevices.ru>
Date: Tue, 10 Jan 2023 14:42:05 +0100
Message-ID: <878ria8q1e.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Alexey Romanov <avromanov@sberdevices.ru>, narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

On Tue, Jan 10, 2023 at 13:56, Alexey Romanov <avromanov@sberdevices.ru> wrote:

> Added docs for Meson Security Monitor command.
>
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  doc/usage/cmd/sm.rst | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  doc/usage/index.rst  |  1 +
>  2 files changed, 45 insertions(+)
>  create mode 100644 doc/usage/cmd/sm.rst
>
> diff --git a/doc/usage/cmd/sm.rst b/doc/usage/cmd/sm.rst
> new file mode 100644
> index 00000000000..c41227f4b3b
> --- /dev/null
> +++ b/doc/usage/cmd/sm.rst
> @@ -0,0 +1,44 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +sm command
> +==========
> +
> +Synopis
> +-------
> +
> +::
> +
> +    sm serial <address>
> +    sm reboot_reason [name]
> +    sm efuseread <offset> <size> <address>
> +    sm efusewrite <offset> <size> <address>
> +    sm efusedump <offset> <size>
> +
> +Description
> +-----------
> +
> +The sm command is used to request services from the secure monitor. User
> +can call secure monitor to request special TEE function, for example chip
> +serial number info, reboot reason, etc.
> +
> +sm serial
> +  Retrieve chip unique serial number from sm and write it to memory on
> +  appropriate address.
> +
> +sm reboot_reason
> +  Print reboot reason to the console, if parameter [name] isn't specified.
> +  If parameter specified, set reboot reason string to environment variable
> +  with this name.
> +
> +sm efuseread
> +  Read <size> bytes starting from <offset> from efuse memory bank and write
> +  result to the address <address>.
> +
> +sm efusewrite
> +  Write into efuse memory bank, starting from <offset>, the <size> bytes
> +  of data, located at address <address>.
> +
> +Configuration
> +-------------
> +
> +To use the sm command you must specify CONFIG_CMD_MESON=y
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index 770418434ad..e34b98dae24 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -61,6 +61,7 @@ Shell commands
>     cmd/true
>     cmd/ums
>     cmd/wdt
> +   cmd/sm
>  
>  Booting OS
>  ----------
> -- 
> 2.25.1
