Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web08.5674.1616487278542892683
 for <u-boot-amlogic@groups.io>;
 Tue, 23 Mar 2021 01:14:39 -0700
Received: by mail-wr1-f42.google.com with SMTP id 61so19746677wrm.12
        for <u-boot-amlogic@groups.io>; Tue, 23 Mar 2021 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S2Q0StPcREQsUgV974PtLOAP6LwESZhDW3B+26jGDik=;
        b=zqyRM2TlcGpVErjPsxfP0EoPRRQ0R/nRO0ZrxmXyDOp0w6QIR4bO39uUErv6uG203m
         dsM+idStYT/iV1k8yfXJhwaGJmbNdD7X8VgoWkWD7a7aNiMEgmhqUTQ81lfTgCbqIN8E
         qm2DzxfEMaac4Qd2d904LdqXjN8YIhQT8HaGGXi99cX0F2njt94KYdSYJ8DA8OBXQJHy
         Mdc17tN7QcjnQ9bGRLXAo3WJah2itEJNJRxlOH4gaf7yyl+5sw1P2OaLZ2PbKimS/CGe
         zM0XJa2uuuvPYq+Eccc0ntKXnHZXxOi7avP+lqsSHwE7c5tqjgW1fYo1CvVo/2n7eFOq
         AGFg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH RFT 0/4] pci: add common Designware PCIe functions and support Amlogic Meson PCIe controller
References: <CAJivOr7megRMZ+ESqRbRicuJVLC9X7F0DBeFh1bC7g0zdN21bg@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8dc37449-e8fd-c70a-ccbe-9201932e8b92@baylibre.com>
Date: Tue, 23 Mar 2021 09:14:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAJivOr7megRMZ+ESqRbRicuJVLC9X7F0DBeFh1bC7g0zdN21bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Green Wan <green.wan@sifive.com>, U-Boot Mailing List <u-boot@lists.denx.de>, "cc: Lokesh Vutla" <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, shawn.lin@rock-chips.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Green,


On 23/03/2021 05:36, Green Wan wrote:
> Hi Neil,
> 
> pcie_dw_common.* is a good starting point. I'd like to spend time on this. Please add me into the loop. Thanks.

Sure, I'll CC you on the next revision, in the meantime don't hesitate to comment and/or post the changes
needed for sifive.

Neil

> 
> -
> Green

