Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEC1C5DF6D
	for <webhook@archiver.kernel.org>; Sun, 16 Aug 2026 17:41:20 +0000 (UTC)
Received: from mta1.migadu.com (mta1.migadu.com [95.215.58.148])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14065.1786902079226606107
 for <u-boot-amlogic@groups.io>;
 Sun, 16 Aug 2026 10:41:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=MzGEOej9;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.148, mailfrom: funderscore@postmarketos.org)
X-Envelope-To: u-boot-amlogic@groups.io
DKIM-Signature: a=rsa-sha256; bh=OouZnqtWLN392ZXy0dWjGUa0Y71HitU+N6QOpi8QraE=;
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786902077; v=1; x=1787506877;
 b=MzGEOej9ortdJD8GruzCHMmLcSkABtCvoNvKo0Ugahk0EttMowBUF4lNU9qSJRTEC71gRyyx
 Vg7JyXQdvZ+h1NbI/BCrpR3QNjzQnJSZU1Adu8AzS5Qdj43+qwA77A286CLxD7LXhh/wRtk3n2C
 r9+KmNziLK6hMnuCJjy1t2zjZb7EHjwBRaEkcbcX6dgzf2zYp40kSv7cimRiCSsdoqRy0ifUdvM
 QUO+20Y9foRsN26o/pKhBbWsoJlTep5TSBdT+RzxkoAHklpELjiGdOxH/PZZsfhU3CqxNvs3OwA
 +GmDT81Hd9usB16NmttTR8rE/O1u3NAI2YJV9OwUahCuw==
X-Envelope-To: u-boot-amlogic@groups.io
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by smtp.migadu.com with ESMTPS id 04c5a10196b62a0a;
	Sun, 16 Aug 2026 17:41:17 +0000
X-Migadu-Flow: FLOW_OUT
MIME-Version: 1.0
Date: Sun, 16 Aug 2026 17:41:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Message-ID: <d7a85b8f6f65f7caabb45ebaff5380335030bb2f@postmarketos.org>
TLS-Required: No
Subject: Re: [PATCH 1/4] serial: meson: add Amlogic S4 UART support
To: "Lucas Tanure" <tanure@linux.com>, u-boot-amlogic@groups.io,
 u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org
In-Reply-To: <e8d19994-1236-4984-be2a-058cc317d10b@linux.com>
References: <20260806101809.72526-1-tanure@linux.com>
 <20260806101809.72526-2-tanure@linux.com>
 <tjk4ry.249pxi1g19ygb@postmarketos.org>
 <e8d19994-1236-4984-be2a-058cc317d10b@linux.com>
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 16 Aug 2026 17:41:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3024

(didn't mean for this to be off-list sorry about that)

On Sun, 16 Aug 2026 10:42, Lucas Tanure <tanure@linux.com mailto:tanure@l=
=3D
inux.com > wrote:
>On 10/08/2026 15:01, Ferass El Hafidi wrote:
>> On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io"=3DC2=3DA0
>> <tanure=3D3Dlinux.com@groups.io mailto:linux.com@groups.io > wrote:
>>> The S4-generation UART (S4, T7, ...) derives its baud rate from the
>>> 24 MHz crystal divided by 2, selected via the XTAL_DIV2 bit in the
>>> baud rate register, while older SoCs divide the crystal by 3. Add the
>>> "amlogic,meson-s4-uart" compatible with driver data selecting the
>>> div-by-2 scheme, matching the Linux driver (meson_s4_uart_data) and
>>> the configuration the vendor BL2 programs on T7 hardware.
>>>
>>> Older SoCs keep the existing div-by-3 behaviour: Linux also uses
>>> div-by-2 on G12A, but both modes work there and switching would risk
>>> regressing boards that have shipped with div-by-3 for years.
>>>
>>> Also drain the transmitter before changing the baud rate so in-flight
>>> characters are not garbled, as the Linux driver does.
>>>
>>> Assisted-by: Claude:claude-fable-5
>>=3DC2=3DA0
>> As I understand it, LLM-assisted patches are not welcome in U-Boot rig=
=3D
ht
>> now: https://lore.kernel.org/u-boot/20260515220758.GM1858239@bill-the-=
=3D
cat/
>>=3DC2=3DA0
>> AFAIK there isn't an official AI policy yet, but it seems the concensu=
=3D
s
>> on that matter is currently "please don't". Sorry.
>
>Ok, I will drop this line.
>

Please do not drop this line. I appreciate the transparency towards your
use of AI. I would wait for someone more knowlegable about AI use
discussions to reply.

Best regards,
Ferass

