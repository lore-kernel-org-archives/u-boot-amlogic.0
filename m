Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web08.1324.1610699222586752167
 for <u-boot-amlogic@groups.io>;
 Fri, 15 Jan 2021 00:27:02 -0800
Received: by mail-wr1-f54.google.com with SMTP id q18so8367407wrn.1
        for <u-boot-amlogic@groups.io>; Fri, 15 Jan 2021 00:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a/FNIPyBhWvnqcbnBQ5+h9S41TmQNW9qAR3yroiB9u4=;
        b=dogaukcmUXTwg1jrt2DaSgrzo9plDJ1rm8iPqk4fS4YhHTH9VF+uCIPIwpJiNhmhtd
         Tpn+E55vD07H8OhAxtnMxN5P3Pm1kkSqafoGUONGDHlW/HMlTfPb/OSI1ZwWxtZLBc3P
         OFmZMZURzRFhEr7licJn63zY/4mKTytqaGKHjFTEL+/nurhbg4e7Rf6lPnNMKptMRgXz
         ZxWbZ6J+wWpzp3dS1XvPY3vctx/QAM38tIllmHUuiGq05LEpVzX/5O+POZEip35Y9Y13
         ZoHLkrAL9G7bXDWdm70czl3a57YDK+i1bqharSwo5yFPrVqVego0Xt6geI//AiS6vEaS
         p9Kg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] video: meson: add HDMI fail-save FullHD option
References: <20210115081139.567155-1-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <ecf81b01-ca3f-a38b-2bcc-f9ed64b1b2e9@baylibre.com>
Date: Fri, 15 Jan 2021 09:26:59 +0100
MIME-Version: 1.0
In-Reply-To: <20210115081139.567155-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, m.szyprowski@samsung.com, jh80.chung@samsung.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 15/01/2021 09:11, Artem Lapkin wrote:
> add VIDEO_MESON_HDMI_FAIL_SAVE_FULL_HD configuration option
> 
> ABOUT:
> 
> Force setup FullHD display mode, if proper timing cant readed.
> from display! Its happens for some 4K display, which send
> unsupported high timings, but same time can works as FullHD!
> Also its will be useful for suspended or disconnected displays.

Thanks ! It was in my TODO list....

> 
> NOTE: this option disabled by default
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  drivers/video/meson/Kconfig     | 10 ++++++++++
>  drivers/video/meson/meson_vpu.c | 19 +++++++++++++++++--
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/meson/Kconfig b/drivers/video/meson/Kconfig
> index 0c9ddeb8..55d67700 100644
> --- a/drivers/video/meson/Kconfig
> +++ b/drivers/video/meson/Kconfig
> @@ -10,3 +10,13 @@ config VIDEO_MESON
>  	select DISPLAY
>  	help
>  	  Enable Amlogic Meson Video Processing Unit video support.
> +
> +config VIDEO_MESON_HDMI_FAIL_SAVE_FULL_HD
> +	bool "Enable HDMI fail-save FullHD mode"
> +	depends on VIDEO_MESON
> +	default n
> +	help
> +	  Force setup FullHD display mode, if proper timing cant readed.
> +	  from display! Its happens for some 4K display, which send
> +	  unsupported high timings, but same time can works as FullHD!
> +	  Also its will be useful for suspended or disconnected displays

I don't think it's necessary to have an option for that.

> diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
> index 4868839f..af677a45 100644
> --- a/drivers/video/meson/meson_vpu.c
> +++ b/drivers/video/meson/meson_vpu.c
> @@ -52,8 +52,23 @@ static int meson_vpu_setup_mode(struct udevice *dev, struct udevice *disp)
>  	if (disp) {
>  		ret = display_read_timing(disp, &timing);
>  		if (ret) {
> -			debug("%s: Failed to read timings\n", __func__);
> -			goto cvbs;
> +			if (IS_ENABLED(CONFIG_VIDEO_MESON_HDMI_FAIL_SAVE_FULL_HD)) {
> +				printf("DISPLAY: setup failsave FullHD mode\n");
> +				timing.pixelclock.typ = 148500000;
> +				timing.hactive.typ = 1920;
> +				timing.hfront_porch.typ = 88;
> +				timing.hback_porch.typ = 148;
> +				timing.hsync_len.typ = 44;
> +				timing.vactive.typ = 1080;
> +				timing.vfront_porch.typ = 4;
> +				timing.vback_porch.typ = 36;
> +				timing.vsync_len.typ = 5;
> +				timing.flags = 10;
> +				timing.hdmi_monitor = true;
> +			} else {
> +				debug("%s: Failed to read timings\n", __func__);
> +				goto cvbs;


So, 1080p is not a good idea for DVI screens, only for HDMI displays.
And I don't think it's the right place, since when I will add support for DSI output,
it won't work.

So it should go in the meson_dw_hdmi, but you'll need to add a read_timing() callback instead
of the read_edid, that would do the same as display_read_timing() but return a fallback mode if
edid_get_timing_validate() fails.

You could get the info about HDMI or DVI in timing->hdmi_monitor, then you should return 1024x768 for DVI and
1080p for HDMI displays, but you'll need to fix the edid_get_timing_validate to check for HDMI stuff before
validating the timings.

Neil

> +			}
>  		}
>  
>  		uc_priv->xsize = timing.hactive.typ;
> 

