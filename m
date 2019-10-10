Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by mx.groups.io with SMTP id smtpd.web10.1194.1570731791952374983
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Oct 2019 11:23:12 -0700
Date: Thu, 10 Oct 2019 20:23:09 +0200
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [U-Boot] [PATCH 6/8] arm: meson: board-g12a: Setup VPU in fdt
Message-ID: <20191010202309.253d88b9@crub>
In-Reply-To: <20190830120928.23890-7-narmstrong@baylibre.com>
References: <20190830120928.23890-1-narmstrong@baylibre.com>
	<20190830120928.23890-7-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On Fri, 30 Aug 2019 14:09:26 +0200
Neil Armstrong narmstrong@baylibre.com wrote:

> If VIDEO_MESON is enabled, we need to setup the fdt for the framebuffer.
> 
> Call meson_vpu_rsv_fb() which reserves the framebuffer memory region for
> EFI, and sets up simple-framebuffer nodes if simplefb support is
> enabled.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Anatolij Gustschin <agust@denx.de>

--
Anatolij
