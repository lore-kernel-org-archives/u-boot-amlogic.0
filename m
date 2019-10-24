Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web10.2437.1571909695969254317
 for <u-boot-amlogic@groups.io>;
 Thu, 24 Oct 2019 02:34:56 -0700
Subject: Re: [PATCH] configs: sei610: khadas-vim3 : disable Gadget support for the DWC3
References: <20191024081540.6229-1-jjhiblot@ti.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <98323b1f-40f2-8719-5d2e-d1f62b5f1904@denx.de>
Date: Thu, 24 Oct 2019 11:28:39 +0200
MIME-Version: 1.0
In-Reply-To: <20191024081540.6229-1-jjhiblot@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jean-Jacques Hiblot <jjhiblot@ti.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de, narmstrong@baylibre.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 10/24/19 10:15 AM, Jean-Jacques Hiblot wrote:
> Those platform use the DWC2 controller for the gadget support and the
> DWC3 for host-only operations.

Applied, thanks.
