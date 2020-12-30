Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by mx.groups.io with SMTP id smtpd.web09.5658.1609330248355600922
 for <u-boot-amlogic@groups.io>;
 Wed, 30 Dec 2020 04:10:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1609330244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxWDlSF33iL4vAKxI9QmIRS3MN0QekL0wwKT/KhbiwA=;
	b=J/SlwiaEO4WXaIQ3pd3v64vAaZ1nxLn34Q1yJadVwLSD0cBjn9AxGG9xj0E5bcExQ3TuTy
	FcmVHc8rDtG1W+vqN0W9Q4nICMawLNUakyeVYfrKRUAtfDdMCOtfdl2MUYixfEluOs+kWR
	WNMUY/SGhtdoFTL7wetRzCVnfRGguEY=
MIME-Version: 1.0
Date: Wed, 30 Dec 2020 13:10:42 +0100
From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] usb: xhci: Use only 32-bit accesses in nvme_writeq/nvme_readq
In-Reply-To: <CAEUhbmW6w0QoCP6+uRzLxbgWtMwPNkF2whtuf=Y-429QKnT3Xg@mail.gmail.com>
References: <77ac8cb333048b92600e8781b609251f2399790d.1609270634.git.stefan@agner.ch>
 <CAEUhbmW6w0QoCP6+uRzLxbgWtMwPNkF2whtuf=Y-429QKnT3Xg@mail.gmail.com>
Message-ID: <b27b3dde55ef5a46a939e4a0f177da6e@agner.ch>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, U-Boot Mailing List <u-boot@lists.denx.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Zhikang Zhang <zhikang.zhang@nxp.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Matthias Brugger <mbrugger@suse.com>, Marek Vasut <marex@denx.de>
List-ID: <u-boot-amlogic@groups.io>

On 2020-12-30 02:36, Bin Meng wrote:
> Hi Stefan,
> 
> On Wed, Dec 30, 2020 at 3:37 AM Stefan Agner <stefan@agner.ch> wrote:
> 
> The tag is wrong. Should be nvme:

Thanks for pointing out. Will send a v2.

FWIW, the send to amlogic ML was accidentially.

--
Stefan

> 
>>
>> There might be hardware configurations where 64-bit data accesses
>> to NVMe registers are not supported properly.  This patch removes
>> the readq/writeq so always two 32-bit accesses are used to read/write
>> 64-bit NVMe registers, similarly as it is done in Linux kernel.
>>
>> This patch fixes operation of NVMe devices on RPi4 Broadcom
>> BCM2711 SoC based board, where the VL805 USB XHCI controller is
>> connected to the PCIe Root Complex, which is attached to the system
>> through the SCB bridge.
>>
>> Even though the architecture is 64-bit the PCIe BAR is 32-bit and likely
>> the 64-bit wide register accesses initiated by the CPU are not properly
>> translated to a sequence of 32-bit PCIe accesses.
>> nvme_readq(), for example, always returns same value in upper and lower
>> 32-bits, e.g. 0x3c033fff3c033fff which lead to NVMe devices to fail
>> probing.
>>
>> This fix is analogous to commit 8e2ab05000ab ("usb: xhci: Use only
>> 32-bit accesses in xhci_writeq/xhci_readq").
>>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Zhikang Zhang <zhikang.zhang@nxp.com>
>> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>> Cc: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>
>>  drivers/nvme/nvme.h | 8 --------
>>  1 file changed, 8 deletions(-)
>>
> 
> Otherwise, LGTM:
> 
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

