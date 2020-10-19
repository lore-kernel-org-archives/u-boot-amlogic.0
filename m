Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web09.6419.1603143226257303570
 for <u-boot-amlogic@groups.io>;
 Mon, 19 Oct 2020 14:33:46 -0700
Date: Mon, 19 Oct 2020 23:33:43 +0200
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 2/2] video: dw-mipi-dsi: permit configuring the escape clock rate
Message-ID: <20201019233343.12281094@crub>
In-Reply-To: <20201002091609.1023621-2-narmstrong@baylibre.com>
References: <20201002091609.1023621-1-narmstrong@baylibre.com>
	<20201002091609.1023621-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: yannick.fertre@st.com, patrick.delaunay@st.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Fri,  2 Oct 2020 11:16:09 +0200
Neil Armstrong narmstrong@baylibre.com wrote:
...
> ---
>  drivers/video/dw_mipi_dsi.c | 20 ++++++++++++++++----
>  include/mipi_dsi.h          |  1 +
>  2 files changed, 17 insertions(+), 4 deletions(-)

applied to u-boot-video/master, thanks!

--
Anatolij
