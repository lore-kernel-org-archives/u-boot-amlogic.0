Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.35462.1656663568885512962
 for <u-boot-amlogic@groups.io>;
 Fri, 01 Jul 2022 01:19:29 -0700
Received: by mail-wr1-f43.google.com with SMTP id q9so2057396wrd.8
        for <u-boot-amlogic@groups.io>; Fri, 01 Jul 2022 01:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:cc:subject
         :content-language:organization:content-transfer-encoding;
        bh=nDZIyx5eSIoYmwg/hnhkr605SzBCB32d38VjhlXw+zw=;
        b=AmeOrv9lYDnw8wnuZqHJkJlaNXHoQ6HWc5XDyf/QNLt7BSwCPTzoqZB/c5+a7OiHn6
         LgUFqes9VkqPVR5IPdRTz+QSD4FR4e1o22yX93c6gu/aVewv4E1ZAnLMXIrXYZ+ujs9X
         O36YiGsIUnoYCx/rHSP/fJ4qPznpU/LB3uo/XY7HLwM7Go5Nns0Ba/GWcqAPi2pCEB/q
         uyR3Dzai8YQ1NgmkyFJ75ZG+XKx4k46wMpC1oJCjlMw8g154ck5mGYIErveJqzKzAkzT
         YKFo3JkD02B/vvGhjGHIpJkndCH9ZsODDjlwrULHLZn3DDtyXqkaCzrEVuSTVJmUaObQ
         dUiw==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <ecd6f37e-dd37-eeed-d5e4-eb0d107ce9e3@baylibre.com>
Date: Fri, 1 Jul 2022 10:19:25 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [GIT PULL] Please pull u-boot-amlogic-20220701
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>


Hi Tom,

Here's changes for next release:
- search dtb for meson-axg-usb-ctrl on board axg

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/12587

Thanks,
Neil

The following changes since commit 6f00b97d7e5760d92566317dde6c4b9224790827:

   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2022-05-20 22:07:56 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20220701

for you to fetch changes up to fdc55a6ba8309b688c9db6c3cf3f70ad7034c147:

   meson: axg: search dtb for meson-axg-usb-ctrl on board axg (2022-05-23 10:40:01 +0200)

----------------------------------------------------------------
- search dtb for meson-axg-usb-ctrl on board axg

----------------------------------------------------------------
Sergei Antonov (1):
       meson: axg: search dtb for meson-axg-usb-ctrl on board axg

  arch/arm/mach-meson/board-axg.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)
