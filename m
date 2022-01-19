Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web12.7040.1642603634958281582
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Jan 2022 06:47:15 -0800
Received: by mail-wm1-f45.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so5893322wms.3
        for <u-boot-amlogic@groups.io>; Wed, 19 Jan 2022 06:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0HeRYnDkBwDKieeuuRpwgFhqXJHj8tjyEK5YduvfIA=;
        b=S2+KmhGKC5rWnIjv8+QMxddAb04H9p8NlGdzo3yOgC5ITQG7WHdFtXoM/4YJYg78Q0
         7nKicY3phZE2tmI7Sjw2Wh2h/tBX4qKLnvhkSI0x0Tl2TGHgXLuXwVxEQVnsEAPXmcBT
         xQ8vV27mUCVVBl5Sl3KjRMheTO00te4y8z4nYLJd40gm50o3MVThXnD7PYlLKbcmuK9n
         vd7SvBhnn9SjTiRWHINYpVqvCk1Zj6+5C2A7DcPREo/zKp/ewa6JBnRDF1mbblG6Bdrm
         gKn4jhv0GnJZ6L4k/CSVZdJUGJwSfccu/bVEDQbF4g1zdSmRqpVZj5sgJLFbZhZgQwEt
         w0lw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: vim3: configure serial# from ethaddr
Date: Wed, 19 Jan 2022 15:47:11 +0100
Message-Id: <164260361416.1460537.2796215771750762151.b4-ty@baylibre.com>
In-Reply-To: <20220119142400.127342-1-mkorpershoek@baylibre.com>
References: <20220119142400.127342-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Wed, 19 Jan 2022 15:24:00 +0100, Mattijs Korpershoek wrote:
> The Khadas VIM3 and VIM3L boards, which are supported in Android via
> Yukawa [1] need a serial number for usb/fastboot enumeration.
> 
> Whenever the environment does not provide a serial#, use the eth mac
> address as serial#.
> 
> [1] https://source.android.com/setup/build/devices#vim3_and_vim3l_boards
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] board: amlogic: vim3: configure serial# from ethaddr
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/522c51839a6f31d66054c44aeffda00888e731ad

-- 
Neil
