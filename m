Received: by mail-wr1-f68.google.com with SMTP id z1so2134426wru.13
        for <u-boot-amlogic@groups.io>; Thu, 04 Jul 2019 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wUU2AuLEObUjRP0sqUmuIGe78nLlTFgdSB53koOVZoY=;
        b=nHVZHK6XG4PNSwgnyYp7HUa9JBq0VwdI1G76xso5+DJYVz743oVcg3qh2A39gysvwc
         YaN6nzej8L+DUEttjbQrlegXweSc8NtevPkyRA5TRDS4mLR31ZuWdnDykjkA8e9L52K8
         QEiaCMuxi9POvLDdcje9+N2CQ11usbpm7g7lFmDerBteHyVrs4k5XJ4PN688Gv9KY4Va
         e37W8AfVVcaUIADpbBQg5udp5d+hfj70QjwIrJFGS3q5SOyIXM1cz821f0yDpq+GvA/t
         wVVJdcqVNB2IgsVw2cfAP7AsNNszohkx/SDY2mGart3i9uMi6Y6AnVs9it0KQI7AijOA
         aaRg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/3] amlogic: add unique MAC address generatio
References: <20190612094908.24858-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8f17a72f-588f-5bee-f344-7a4fcc84dee2@baylibre.com>
Date: Thu, 4 Jul 2019 16:03:16 +0200
MIME-Version: 1.0
In-Reply-To: <20190612094908.24858-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 12/06/2019 11:49, Neil Armstrong wrote:
> This patchset adds support for generating an unique MAC address per-SoC,
> and enables it on the q200 (VIM2) and P212 (libretech-cc, khadas-vim, libretech-ac)
> based boards.
> 
> Neil Armstrong (3):
>   ARM: meson: sm: Add secure monitor calls to retrieve SoC serial number
>   ARM: meson: add unique MAC address generation
>   board: amlogic: Generate unique MAC address for Q200 and P212 based
>     boards
> 
>  arch/arm/include/asm/arch-meson/eth.h |  3 +++
>  arch/arm/include/asm/arch-meson/sm.h  |  4 ++++
>  arch/arm/mach-meson/board-common.c    | 31 +++++++++++++++++++++++++++
>  arch/arm/mach-meson/sm.c              | 24 +++++++++++++++++++++
>  board/amlogic/p212/p212.c             |  2 ++
>  board/amlogic/q200/q200.c             |  2 ++
>  6 files changed, 66 insertions(+)
> 

Applied to u-boot-amlogic

Neil
