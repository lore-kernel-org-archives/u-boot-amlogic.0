Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.1390.1679337618504393091
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 11:40:18 -0700
Received: by mail-ed1-f47.google.com with SMTP id eg48so50488027edb.13
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679337617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3nex+dYLNCBBtJyKwdMGEzfFF0tvSiT7XPExuf7eSRE=;
        b=HGjf8anoWagidMceSvk2B1/HzTzLfNLdSaut8o4ZJuYHO9mrgokiJ9bw+xaXns/mUI
         KxGlZmBIhVih5wQx6Mk4hqisfQjOX3QuazbatOgY12GwPWtqkeuAzJ6FVpjwAStc1ggx
         v/yDut3RKRtcQm7g7xjCloqoAwX89yr36Mfqs=
MIME-Version: 1.0
References: <20230320114609.930145-1-christianshewitt@gmail.com> <20230320114609.930145-30-christianshewitt@gmail.com>
In-Reply-To: <20230320114609.930145-30-christianshewitt@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Mar 2023 07:40:05 +1300
Message-ID: <CAPnjgZ1HW1x3CJ27icDifh4+hjUJjpwCM--FtatzJhrWjkEueA@mail.gmail.com>
Subject: Re: [PATCH 29/33] doc: boards: amlogic: update documentation for WeTek Core2
Content-Type: text/plain; charset="UTF-8"
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

Hi Christian,

On Tue, 21 Mar 2023 at 06:05, Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> Improve documentation.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  doc/board/amlogic/wetek-core2.rst | 83 +++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 36 deletions(-)

This should really move to binman. Would you like to take a look?

I sent a patch for this a while ago but it needs something to review
and try out.

https://patchwork.ozlabs.org/project/uboot/patch/20220110031413.1970836-39-sjg@chromium.org/

I am happy to do more on it as needed.

Regards.

Simon
