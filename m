Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web10.1094.1570731353483618130
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Oct 2019 11:15:54 -0700
Date: Thu, 10 Oct 2019 20:15:50 +0200
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 3/8] video: meson: remove power domain get
Message-ID: <20191010201550.364b7b3a@crub>
In-Reply-To: <20190830120928.23890-4-narmstrong@baylibre.com>
References: <20190830120928.23890-1-narmstrong@baylibre.com>
	<20190830120928.23890-4-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, jh80.chung@samsung.com, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On Fri, 30 Aug 2019 14:09:23 +0200
Neil Armstrong narmstrong@baylibre.com wrote:

> Remove getting and enabling the node power domain since it's now handled
> by the dm core directly.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Anatolij Gustschin <agust@denx.de>

--
Anatolij
