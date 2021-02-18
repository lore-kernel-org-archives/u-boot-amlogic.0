Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web08.4576.1613640485239254178
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Feb 2021 01:28:06 -0800
Received: by mail-wm1-f50.google.com with SMTP id o82so2269613wme.1
        for <u-boot-amlogic@groups.io>; Thu, 18 Feb 2021 01:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GqOsUKIE7Rlt3zo5QLkuWr9v+vaTmAstxq1+EtEYIYg=;
        b=PM/0GMBuDNr0+nnEVdTsyhCaNZw+fwtFEZe4/Wgv1X0xpyr2S2Lrrt0PrIJgEtd8fQ
         yPKV4X5Xu20cVl8FjdMPiwpNJCNKb40NLPTv3XlYIZNOxZsahpsEY0f1lYaohddcKurv
         8X2i9onwYBkDllEyKv/nrS5MxPoF7EST8xDiFwhm6cBji1ndvV40umciHzjcn8kVZ0Eq
         NGD+KJb65HxGwdq5RuxqDJRTPkYWAs91l7OUyW/UZpmfj0CPlBOEApjFgGya9SRdsoV+
         VNl9rwl8XdTHMmlYg2nvdCQqtJX5FhDvId1FR3aQ7XCawVn/jveEIktK0pAWi4oLsx21
         z9TQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v6 5/5] test: add a simple test for the adc-keys button driver
References: <20210211084757.22759-1-m.szyprowski@samsung.com>
 <CGME20210211084807eucas1p2e9e5d1fe99d98130649d97ebcd82d854@eucas1p2.samsung.com>
 <20210211084757.22759-6-m.szyprowski@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <5966856b-8b18-0400-d0d3-e94fabb31f94@baylibre.com>
Date: Thu, 18 Feb 2021 10:28:01 +0100
MIME-Version: 1.0
In-Reply-To: <20210211084757.22759-6-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Marek,

On 11/02/2021 09:47, Marek Szyprowski wrote:
> Add adc-keys device to the sandbox/test.dts and connect it to the channel
> #3 of the sandbox_adc driver. The default values sampled by sandbox_adc
> driver determines that button3 and button4 are released and button5 is
> pressed.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/sandbox/dts/test.dts | 24 ++++++++++++++++++-
>  configs/sandbox_defconfig |  1 +
>  test/dm/button.c          | 50 +++++++++++++++++++++++++++++++++++++--
>  3 files changed, 72 insertions(+), 3 deletions(-)
> 

[...]

Everything is reviewed, can you re-send with the missing "linux,code" ? and I'll push it.

Neil
