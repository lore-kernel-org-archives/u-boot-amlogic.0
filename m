Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web11.2581.1570740493722428100
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Oct 2019 13:48:14 -0700
Date: Thu, 10 Oct 2019 22:48:10 +0200
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 4/8] video: meson: sync with linux drm-misc tree
Message-ID: <20191010224810.5ee129fa@crub>
In-Reply-To: <20190830120928.23890-5-narmstrong@baylibre.com>
References: <20190830120928.23890-1-narmstrong@baylibre.com>
	<20190830120928.23890-5-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On Fri, 30 Aug 2019 14:09:24 +0200
Neil Armstrong narmstrong@baylibre.com wrote:

> Synchronize the Amlogic Meson Video driver back with the latest
> DRM misc tree, adding G12A platform support, from the latest commit:
> 528a25d040bc ("drm: meson: use match data to detect vpu compatibility")
> 
> The sync includes the following changes from Linux adapted to U-Boot:
> - Add support for VIC alternate timings
> - Switch PLL to 5.94GHz base for 297Mhz pixel clock
> - Add registers for G12A SoC
> - Add G12A Support for VPP setup
> - Add G12A Support for VIU setup
> - Add G12A support for OSD1 Plane
> - Add G12A support for plane handling in CRTC driver
> - Add G12A support for CVBS Encoder
> - Add G12A Video Clock setup
> - Add G12A support for the DW-HDMI Glue
> - fix G12A HDMI PLL settings for 4K60 1000/1001 variations
> - fix primary plane disabling
> - fix G12A primary plane disabling
> - mask value when writing bits relaxed
> - crtc: drv: vpp: viu: venc: use proper macros instead of magic constants
> - global clean-up
> - add macro used to enable HDMI PLL
> - venc: set the correct macrovision max amplitude value
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Anatolij Gustschin <agust@denx.de>

--
Anatolij
