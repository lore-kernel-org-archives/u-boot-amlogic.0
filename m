Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.23066.1659946737525160032
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Aug 2022 01:18:58 -0700
Received: by mail-wr1-f51.google.com with SMTP id p10so9960451wru.8
        for <u-boot-amlogic@groups.io>; Mon, 08 Aug 2022 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Qt/OmKYkAwOUhxoKA8E7h/0M8t96qxwR9Rz6xnwM5qM=;
        b=W2rpgQyTOdOGfFStentzktqqlp8oSAAFmYFcNXkXa97U0v6MwD9585kVh23Q2c9PBk
         vb4EABw52eA9IQ5QxHI1IUeYuo3PlOfp0n29/mHajcO4pwHqlieyLb+l9uoNEgOMX2jz
         CtWEdCBMfTt/lJLniZK7vCgJjGQyRnLKGlXM44UsO7hYuPsjhOh5Mjh/OwChEHI4XEA9
         2DvBMSyu5kyoHQcxCz0xwffxYMmcCNDzZfXqq80Dvz6u+DBcVipX8JQn8FBJ9tEuphze
         7D22B1yo4notbxgNsMxT5zS5UfaOkRUU92eDACQ0WNvJ5h2STf1+I4JAiczSgllgAiR/
         5lyQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: Re: [PATCH] ARM: meson: fixup error on efuse commands return
Date: Mon,  8 Aug 2022 10:18:54 +0200
Message-Id: <165994672950.162096.5161911654978846106.b4-ty@baylibre.com>
In-Reply-To: <20220804144138.33809-1-jbrunet@baylibre.com>
References: <20220804144138.33809-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Thu, 4 Aug 2022 16:41:38 +0200, Jerome Brunet wrote:
> All `sm efuseread/efusewrite` commands exit with an error, even if the fuse
> have actually been dealt with correctly.
> 
> This is because the smc call return the size it actually processed but this
> result is checked against 0.
> 
> Return failure in do_efuse_read/write if the return value of
> meson_sm_read/write_efuse() is not the requested size.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/1] ARM: meson: fixup error on efuse commands return
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/3145e0d0ff0837647351f2ca261b4cde779f83e0

-- 
Neil
