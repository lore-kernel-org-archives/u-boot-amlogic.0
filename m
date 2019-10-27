Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web10.75.1572196022416734081
 for <u-boot-amlogic@groups.io>;
 Sun, 27 Oct 2019 10:07:02 -0700
Date: Sun, 27 Oct 2019 18:06:53 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 23/30] video: meson: Drop unnecessary header includes
Message-ID: <20191027180653.4e826d50@crub>
In-Reply-To: <20191027155410.187957-23-sjg@chromium.org>
References: <20191027155410.187957-1-sjg@chromium.org>
	<20191027155410.187957-23-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Sun, 27 Oct 2019 09:54:03 -0600
Simon Glass sjg@chromium.org wrote:

> These files should not be included in meson header files. Drop them and
> tidy up the affected C files.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Anatolij Gustschin <agust@denx.de>
