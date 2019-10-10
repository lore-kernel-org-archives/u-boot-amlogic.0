Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by mx.groups.io with SMTP id smtpd.web10.1242.1570732093301914602
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Oct 2019 11:28:13 -0700
Date: Thu, 10 Oct 2019 20:28:10 +0200
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [U-Boot] [PATCH 8/8] configs: sei510: enable Video Display support
Message-ID: <20191010202810.33826925@crub>
In-Reply-To: <20190830120928.23890-9-narmstrong@baylibre.com>
References: <20190830120928.23890-1-narmstrong@baylibre.com>
	<20190830120928.23890-9-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On Fri, 30 Aug 2019 14:09:28 +0200
Neil Armstrong narmstrong@baylibre.com wrote:

> Add the necessary config options to support BMP display over HDMI,
> and add a preboot command to load the BMP file from a predefined
> eMMC partition.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Anatolij Gustschin <agust@denx.de>

--
Anatolij
