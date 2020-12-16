Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web08.11232.1608137437648292941
 for <u-boot-amlogic@groups.io>;
 Wed, 16 Dec 2020 08:50:38 -0800
Received: by mail-wm1-f51.google.com with SMTP id k10so3015782wmi.3
        for <u-boot-amlogic@groups.io>; Wed, 16 Dec 2020 08:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DIVjh/yWjYg/IoXkbzYKe9CERbVqk/ae/zM6egCguDQ=;
        b=wnhwaNeYjJuMHjMNytEFITlu1TMyZr4B9GfpVsf+IsiYjbYKIqmnTeojN50MU+gWnG
         fgOx2OiDHThzO69qo/fG/ASbBk1+xEnQbU9QLBBHw3yT6pGBmjispN9kmEuS8hWu8ekq
         pV/0lP55qXP6uJHAxqW9ieUIjOVmS9GAlikarR9MqQzLf54MnkV9t1wV3kmlLsegqr5k
         1j4xAu/5hFCCaiO6/lWGeZYH67o+IqNflDWXzCE0D8XlIttVmu0YzcCHZBRC7nbgA6T3
         AD4YuEFw6JJ7ss9F9i0YzfTuDpzpWyiKHCy4CkZFDALufsu3iKlhKnSoRgARTUUe8qGO
         KxYw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/3] board: amlogic: add WeTek Core2 support
References: <20201215123214.18661-1-christianshewitt@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <b2c42807-a756-e05e-6824-124e9ade4a11@baylibre.com>
Date: Wed, 16 Dec 2020 17:50:33 +0100
MIME-Version: 1.0
In-Reply-To: <20201215123214.18661-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Christian Hewitt <christianshewitt@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 15/12/2020 13:32, Christian Hewitt wrote:
> This patchset adds support for the WeTek Core2 box which is based on the
> Amlogic S912 (GXM) SoC. Patches are based on u-boot-amlogic-next branch
> in the custodians tree.
> 
> Christian Hewitt (3):
>   ARM: dts: import WeTek Core2 DTs from Linux 5.10
>   boards: amlogic: add WeTek Core2 support
>   boards: amlogic: update documentation for WeTek Core2
> 
>  arch/arm/dts/Makefile                         |   1 +
>  arch/arm/dts/meson-gx-p23x-q20x.dtsi          | 324 ++++++++++++++++++
>  .../arm/dts/meson-gxm-wetek-core2-u-boot.dtsi |   7 +
>  arch/arm/dts/meson-gxm-wetek-core2.dts        |  87 +++++
>  configs/wetek-core2_defconfig                 |  70 ++++
>  doc/board/amlogic/index.rst                   |   3 +-
>  doc/board/amlogic/wetek-core2.rst             |  90 +++++
>  7 files changed, 581 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/meson-gx-p23x-q20x.dtsi
>  create mode 100644 arch/arm/dts/meson-gxm-wetek-core2-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-gxm-wetek-core2.dts
>  create mode 100644 configs/wetek-core2_defconfig
>  create mode 100644 doc/board/amlogic/wetek-core2.rst
> 

Applying to u-boot-amlogic-next
