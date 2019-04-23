Received: by mail-wm1-f66.google.com with SMTP id y197so17915804wmd.0
        for <u-boot-amlogic@groups.io>; Tue, 23 Apr 2019 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7HpI+8PNxEB74vRi02cMePSmW8TidTasAOnYB+EyFik=;
        b=qaDu1bTxyYFyCnVpsSw04jIjZ+3DW/I+CCcD5ZXdlcExO9cm7QmWpm3hQtrOHyUK61
         XiCJtIVhAbQfscB4Ebyks+YVIJyPVzI0hTb5ICcsP7zmDf1BJ//LFo7QT1A3VqZ6O0OG
         sAVE+cMIx8F8KL2qXZ5/g7nztt1IsaOGmBtOapxlt3zjHpBHCFcsS2pKKT78nsLg6mdb
         L8a0NoQJJtvZupnzr8qj58PbxAL48MnjkilJng6gozX4p3Q07mVSpmXGH1OUz2LmH4ug
         CVD0+7DpsmcsYd+DuOba3sL5vWNofs+dAobgyxEIQqPwOBOKoqEDaT3gc+iARfoRt4/Y
         wiAA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic-q200: fix Khadas VIM2 README
References: <20190410144753.1343-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <bd51344a-fd5f-6f04-bfbf-2ea32208503b@baylibre.com>
Date: Tue, 23 Apr 2019 11:29:36 +0200
MIME-Version: 1.0
In-Reply-To: <20190410144753.1343-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 10/04/2019 16:47, Neil Armstrong wrote:
> The vendor U-boot branch and defconfig was wrong for the
> Khadas VIM2, fix this.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  board/amlogic/q200/README.khadas-vim2 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/board/amlogic/q200/README.khadas-vim2 b/board/amlogic/q200/README.khadas-vim2
> index 578693fd2d..8bcfc296f3 100644
> --- a/board/amlogic/q200/README.khadas-vim2
> +++ b/board/amlogic/q200/README.khadas-vim2
> @@ -48,9 +48,9 @@ the git tree published by the board vendor:
>   > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
>   > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
>   > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
> - > git clone https://github.com/khadas/u-boot -b Vim vim-u-boot
> + > git clone https://github.com/khadas/u-boot -b khadas-vim-v2015.01 vim-u-boot
>   > cd vim-u-boot
> - > make kvim_defconfig
> + > make kvim2_defconfig
>   > make
>   > export FIPDIR=$PWD/fip
>  
> 

Applied to u-boot-amlogic
