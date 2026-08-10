Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFABC5B56A
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 14:14:21 +0000 (UTC)
Received: from mta1.migadu.com (mta1.migadu.com [95.215.58.218])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30888.1786371253108419043
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Aug 2026 07:14:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=Xu8KJZs5;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.218, mailfrom: funderscore@postmarketos.org)
X-Envelope-To: u-boot-amlogic@groups.io
DKIM-Signature: a=rsa-sha256; bh=9Vq7BOLm8E2zkypRWwgoHhY9ynJDS7GlyVDeVGTFM3k=;
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786371251; v=1; x=1786976051;
 b=Xu8KJZs52enNXCeqblQVW89qR9qQHNP7COnEBlVa3midxsARaIU793vKYoHQajZjNJiuHJpy
 +BBvnbyxsHvTOK77Md4UBh86qzJlnKgAaRWI2lCNZY0RYN7jU6XIohjVTpamj9RBn9towMWtIDB
 YcOKwa5wHEpjolEIW2PrjUzigJW4SzrD2CbOsBrKTKBOqFI7JlNe6GPYGlZ5BzTtUVrDtTWlDT5
 Z8MZQKeJGYjnMQE3+5gemCzQq0l3g0Gc85BeSmIV6MmnTtEhho5N9Km2UfKebmzgfMUyLgAlWJn
 6+3WMZXyM14cvopVQhmN6qS08Esz2Jv6CYU0ARhoXT57Q==
X-Envelope-To: u-boot-amlogic@groups.io
Received: from meli-email.org (160.90.43.132)
	by mta10.migadu.com with ESMTPS id 8cdf74a3979e0ad0;
	Mon, 10 Aug 2026 14:14:11 +0000
Authentication-Results: mta10.migadu.com;
	none
X-Migadu-Scanner: mta10.migadu.com
Date: Mon, 10 Aug 2026 14:12:29 +0000
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, tanure@linux.com, u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org, funderscore@postmasteros.org, u-boot-amlogic@groups.io, Lucas Tanure <tanure@linux.com>
Subject: Re: [PATCH 0/4] Add Amlogic T7 (A311D2) and Khadas VIM4 support
User-Agent: meli/0.8.13
References: <20260806101809.72526-1-tanure@linux.com>
In-Reply-To: <20260806101809.72526-1-tanure@linux.com>
Message-ID: <tjk4vd.es3a7srwhle@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 10 Aug 2026 14:14:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3021

On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io" <tanure=linux.com@groups.io> wrote:
>This series adds initial mainline support for the Amlogic T7 SoC
>family and the Khadas VIM4 board (A311D2):
> - S4-generation UART support
> - the T7 platform code
> - VIM4 board and defconfig
> - VIM4 documentation
>
>Tested on a Khadas VIM4 board, both chainloaded from the vendor U-Boot
>(tftpboot) and cold-booted from an SD card.
>
>Lucas Tanure (4):
>  serial: meson: add Amlogic S4 UART support
>  arm: meson: add Amlogic T7 SoC family support
>  board: amlogic: add Khadas VIM4 support
>  doc: board: amlogic: add Khadas VIM4 documentation
>

You made a typo on my email address, I'm funderscore@postmarketos.org,
not funderscore@postmasteros.org ;) I still received your patchset
though (via u-boot-amlogic/u-boot ML), this is just for future patch
revisions.

Best regards,
Ferass

