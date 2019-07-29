Date: Mon, 29 Jul 2019 11:48:33 +0200
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 0/3] video: add support for EDID timings validation
Message-ID: <20190729114833.17589b56@crub>
In-Reply-To: <20190704135208.32104-1-narmstrong@baylibre.com>
References: <20190704135208.32104-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Thu,  4 Jul 2019 15:52:05 +0200
Neil Armstrong narmstrong@baylibre.com wrote:
...
>  common/edid.c                       | 22 +++++++++++++++++++---
>  drivers/video/display-uclass.c      | 15 ++++++++++++++-
>  drivers/video/meson/meson_dw_hdmi.c |  7 +++++++
>  include/display.h                   | 10 ++++++++++
>  include/edid.h                      | 22 ++++++++++++++++++++++
>  5 files changed, 72 insertions(+), 4 deletions(-)

Series applied to u-boot-video/master, thanks!

--
Anatolij
