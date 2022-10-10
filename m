Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web12.8097.1665418134906565256
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Oct 2022 09:08:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1665418131;
	bh=CglbgEKZh7lR8ZXLZ3a4Sktcbm+ZSxsPhA69WxBEgdw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jtKKp88LvnzZmfoo8+sfEqGtQ4ouLo4Dqk1FfXFTITxPwCcGoJ++B3KXwKZ/ctJSO
	 kRBZc4AMG+3B+BDVF7IsPxOVgwVsWEn1JDyCVY12uLWFTb0q1zWJ2kX8SdvIc09SxC
	 pWTz+wmPEAHhLmImq7EGxyqj4JvYywlCFHGssiwNU5N5zxp8OwiscMwKqCrI+W8xWa
	 4NQaXaMxgj7TbNykLBbgI2ilnAkWackv4pMarX5OzPtsgJuiH5r7pizttc8g42IszL
	 8gl1d9FyhFSaZT3HEl2jBoxcFJqvEw+WVwM3YdFzatzPIO5Zo2xXYNi32lsFRTYXRs
	 D6JYuUA3WRTZw==
Message-ID: <a358e442-056e-054d-23d6-a8d92fe57a70@denx.de>
Date: Mon, 10 Oct 2022 18:08:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] usb: gadget: fastboot: detach usb on reboot commands
References: <20220728-reset-usb-controller-v2-0-ef7657ce78b1@baylibre.com>
 <20220728-reset-usb-controller-v2-1-ef7657ce78b1@baylibre.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20220728-reset-usb-controller-v2-1-ef7657ce78b1@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Christian Hewitt <christianshewitt@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 10/7/22 11:38, Mattijs Korpershoek wrote:
> When host issues "fastboot reboot fastboot", it's expected that the
> board drops the USB connection before resetting.
> 
> On some boards, such as Khadas VIM3L and SEI610, this is not the case.
> 
> We observe the following error:
> $ fastboot reboot fastboot
> Rebooting into fastboot                            OKAY [  0.004s]
> fastboot: error: Failed to boot into userspace fastboot; one or more components might be unbootable.
> 
> This does not happen when we use the RST button on the board.
> It can be reproduced in linux with:
>    # echo b > /proc/sysrq-trigger
> 
> In this case, we hit a undefined hardware behavior, where D+ and D-
> are in an unknown state. Therefore the host can't detect usb
> disconnection.
> 
> Make sure we always call usb_gadget_release() when a "fastboot reboot"
> command is issued.
> 
> Note: usb_gadget_release() should be called before g_dnl_unregister()
> because g_dnl_unregister() triggers a complete() call on each
> endpoint (thus calling do_reset()).

Applied to usb/master , thanks
