Received: by mail-wm1-f66.google.com with SMTP id e8so4146311wme.1
        for <u-boot-amlogic@groups.io>; Wed, 28 Aug 2019 00:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Fe1A6kGS1E91hBv15V+iBP99pahwAVNxhqdoLazsOkE=;
        b=SIZrTCE5S95MTOZsfgLfzE0KvWAyqzL3dWRcbYTqlRoPntJQYTY9YA5glo7ZRhf123
         uqRHaaHtIl0jgufPup3vu8tCVJxa+nSfSfPhpGRwiwlDicW5NQgIBi/7fGbvQCg+vn8r
         0mPCarVog9eSEGCFhG/O5KBehn7pA9YiDjAli9uYfDASGX/U9DVr+fHS0rZE9eSbPEIl
         NZQsm0ttiacB/gZRgtmH7JnNutgZJExnGN8F1fy3D/xQV776QTS+Ck2G3acHReDFgz2Z
         qYWH65dy+gHW9Y1O2yLqjyku7D3gv6ZIEG/r/rObcU74DgXxLxNlrMAwTNIfG6zhHU6s
         accQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] clk: meson-g12b: add compatible
References: <20190827210628.88908-1-kettenis@openbsd.org>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <1891831b-99c2-fc78-541a-05a6feb35400@baylibre.com>
Date: Wed, 28 Aug 2019 09:23:57 +0200
MIME-Version: 1.0
In-Reply-To: <20190827210628.88908-1-kettenis@openbsd.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Mark,

On 27/08/2019 23:06, Mark Kettenis wrote:
> The G12B clock controller is almost identical to the G12A and
> so far the differences don't matter.  Adding the G12B compatible
> makes USB work on the Odroid-N2.

Indeed I forgot this when syncing with linux DTB,
Applying and sending right now, thanks !

Neil

> 
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  drivers/clk/meson/g12a.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 112326e553..43dac1aa37 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -405,6 +405,7 @@ static struct clk_ops meson_clk_ops = {
>  
>  static const struct udevice_id meson_clk_ids[] = {
>  	{ .compatible = "amlogic,g12a-clkc" },
> +	{ .compatible = "amlogic,g12b-clkc" },
>  	{ }
>  };
>  
> 

