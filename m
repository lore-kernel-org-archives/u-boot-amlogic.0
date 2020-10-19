Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by mx.groups.io with SMTP id smtpd.web09.6409.1603143197940927632
 for <u-boot-amlogic@groups.io>;
 Mon, 19 Oct 2020 14:33:18 -0700
Date: Mon, 19 Oct 2020 23:33:10 +0200
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] video: dw-mipi-dsi: driver-specific configuration of phy timings
Message-ID: <20201019233310.66d08c2f@crub>
In-Reply-To: <20201002091609.1023621-1-narmstrong@baylibre.com>
References: <20201002091609.1023621-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: yannick.fertre@st.com, patrick.delaunay@st.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Fri,  2 Oct 2020 11:16:08 +0200
Neil Armstrong narmstrong@baylibre.com wrote:
...
> ---
>  drivers/video/dw_mipi_dsi.c | 17 +++++++++++------
>  include/mipi_dsi.h          | 16 ++++++++++++++++
>  2 files changed, 27 insertions(+), 6 deletions(-)

applied to u-boot-video/master, thanks!

--
Anatolij
