Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web11.3985.1578392297801157380
 for <u-boot-amlogic@groups.io>;
 Tue, 07 Jan 2020 02:18:18 -0800
Received: by mail-wm1-f65.google.com with SMTP id a5so18309470wmb.0
        for <u-boot-amlogic@groups.io>; Tue, 07 Jan 2020 02:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kay1g1sfo1Q2paRgME7BmDnzh54meW4KQy9LfOzOEfw=;
        b=mxDtNgaD9AiWmjb2I3jyv9w6+7w4qzdUDwexGvlmZt8LkF2Su6+meFQ+LYB+uFPthS
         4xgXl50/QOzekpGBjJOC828RRxLFAoQx4cq/WD5qtAgx6F2iWFtD5gPa9rCSTjEMZa/u
         ziDdQn8+2ey9bOs1fVVOwXhC1shuHei+dxKE6PwkQYyAlEW6z/OUkj219ndi/e9D0+aM
         ng8ZVgQKj4coE7ANDvqxsGFIMNXwaMV8XeME3RfBZdoYgBSh/kpnMVeLewdgjk6VFHd/
         QYxuOEbo38bDa0GSBAbAmX1pUKJHEVCtetk8adjKHJPxJD7vVBCIDi+MYP7eQCBfSDRJ
         NyuQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] amlogic: add Khadas VIM3L support
References: <1576056054-4458-1-git-send-email-christianshewitt@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <5a62e2fd-e4fc-ac44-c28a-6ddafc5f6ec4@baylibre.com>
Date: Tue, 7 Jan 2020 11:18:15 +0100
MIME-Version: 1.0
In-Reply-To: <1576056054-4458-1-git-send-email-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Christian Hewitt <christianshewitt@gmail.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 11/12/2019 10:20, Christian Hewitt wrote:
> Khadas VIM3L is a new revision of the VIM3 board that swaps the premium
> A311D chip for Amlogic's mid-range S905D3 chip.
> 
> Christian Hewitt (2):
>   ARM: dts: Import Khadas VIM3L DT from Linux 5.5-rc1
>   boards: amlogic: add Khadas VIM3L support
> 
>  arch/arm/dts/Makefile                   |   1 +
>  arch/arm/dts/meson-sm1-khadas-vim3l.dts |  95 +++++++++++++++++++++++
>  board/amlogic/w400/README.khadas-vim3l  | 132 ++++++++++++++++++++++++++++++++
>  configs/khadas-vim3l_defconfig          |  62 +++++++++++++++
>  4 files changed, 290 insertions(+)
>  create mode 100644 arch/arm/dts/meson-sm1-khadas-vim3l.dts
>  create mode 100644 board/amlogic/w400/README.khadas-vim3l
>  create mode 100644 configs/khadas-vim3l_defconfig
> 

Applied to u-boot-amlogic
