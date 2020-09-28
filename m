Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.33037.1601287150636952634
 for <u-boot-amlogic@groups.io>;
 Mon, 28 Sep 2020 02:59:11 -0700
Received: by mail-wm1-f42.google.com with SMTP id e2so512365wme.1
        for <u-boot-amlogic@groups.io>; Mon, 28 Sep 2020 02:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=EPcTWu2OfWiaYyoY/MPM8iGp/BVA7VermD//ZwXt23o=;
        b=ZPxt6juEIoZvJV3tFHPaumJMO7YkVwaGCjzKa8vzKGahaAMfRK+MmO36udlMb7LOcX
         sEVevPOSd3L7ZEt9EwBQegIplgioTpmntQO6N9bKWllVV/zcGgoAX9Z/QpFzkoKh83w4
         R0Na1vPkrkQZfVEH005JczndMHNsgpL4oc3kEZBpK2pMPKXawVSsFY9N3LJXSnl7V5uy
         R5W+iFUmwzE/UozeIlUGNVSj8hw8iMq04wlXOEn/9+U/+/TUWBz9EsTKNIF7wafH0RG0
         kLNa2YdkyUh6GyQ/Xzg0JAMjn6Hk1easzPvepi6As8iJHujDHqwdtcm8p3RaiD1ap6SS
         qlng==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20200928
Reply-To: narmstrong@baylibre.com
Message-ID: <495378f7-8647-0fb2-83ed-5a12465e9196@baylibre.com>
Date: Mon, 28 Sep 2020 11:59:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR fixes Linux EFI KASLR boot on GXL, GXM, G12A, G12B & SM1 based boards.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/4642

Thanks,
Neil

The following changes since commit 1da91d9bcd6e5ef046c1df0d373d0df87b1e8a72:

  Merge https://gitlab.denx.de/u-boot/custodians/u-boot-marvell (2020-09-24 08:34:54 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20200928

for you to fetch changes up to 02d249f99ecb7e398067d91760287c61d35fd34b:

  rng: meson: make core clock optional (2020-09-28 09:38:11 +0200)

----------------------------------------------------------------
- fix RNG driver probe & linux EFI KASLR boot on GXL, GXM, G12A, G12B & SM1 based boards

----------------------------------------------------------------
Neil Armstrong (1):
      rng: meson: make core clock optional

 drivers/rng/meson-rng.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
