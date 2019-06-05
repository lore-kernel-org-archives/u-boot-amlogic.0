Received: by mail-wr1-f68.google.com with SMTP id n4so13374226wrw.13
        for <u-boot-amlogic@groups.io>; Wed, 05 Jun 2019 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OVhlJNaHgcV1PxtWmMz4vh6GiM4/b+EQsYNRbDhs3po=;
        b=zKTseZnrLbnLEcHJ5dfUTVge8hFp+Ph5dGeeZFvYn8YyizKNI5Houb/4kHxVp4nc53
         TvzJUoJ3JvUMQZ3+WfNjd4TwO8cn8Npy0/AT/B2rlOW9RNPjBzD/QWebM0WinSaLloD+
         2L45z4eCYM5BzoT4h9bcUZGCevfCr5XCJosNvpbvJlUegIl5If7w9F9mI2EeAoM0/zsV
         lk5WxUZ0BpuGMM3cxN2Dfh9oH1xQBkMdbTOdZMRSi1aps2DzivLUErdIPNT4TikVpfWZ
         CJvd/qnEr0WJlhJXClRn6tfgjewdlilfWaRC7Saekm5B+hT/ZrbeTpVjHERgEqG3Xapr
         tYyg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/4] pinctrl: meson: add support for pinmux status
References: <20190604090454.18245-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <3f154dd6-57bc-e4e9-72db-aec15de4930f@baylibre.com>
Date: Wed, 5 Jun 2019 11:04:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190604090454.18245-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 04/06/2019 11:04, Neil Armstrong wrote:
> In order to support the "pinmux status" command, fix the GX pinctrl
> drivers and add the necessary functions callbacks.
> 
> Neil Armstrong (4):
>   pinctrl: meson-gx: fix GPIO_TEST_N and GPIOCLK_ groups
>   pinctrl: meson: add common function to get pins name
>   pinctrl: meson-gx: add support for getting pinmux status
>   pinctrl: meson-axg: add support for getting pinmux status
> 
>  drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c | 48 +++++++++++++++++++
>  drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c  | 44 +++++++++++++++++
>  drivers/pinctrl/meson/pinctrl-meson-gxbb.c    |  7 ++-
>  drivers/pinctrl/meson/pinctrl-meson-gxl.c     |  6 ++-
>  drivers/pinctrl/meson/pinctrl-meson.c         | 24 ++++++++++
>  drivers/pinctrl/meson/pinctrl-meson.h         |  3 ++
>  6 files changed, 128 insertions(+), 4 deletions(-)
> 

Applied to u-boot-amlogic
