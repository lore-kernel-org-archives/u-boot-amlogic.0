Received: by mail-wr1-f47.google.com with SMTP id y19so2504263wrd.3
        for <u-boot-amlogic@groups.io>; Wed, 28 Aug 2019 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:openpgp:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=lxWxEPtDqbQeUvrQyNiZ6o8AphK1Atau+hD5Ur2F7oQ=;
        b=NLLbEx1NccHyoDFt5b8oYs7/IO5xzSHfDhtBke42PH/Na8hUpA5734iRHc2JMp3Ylx
         mB5kijY40tcRxAoukp0aG6Vu/wfJGPShh5mX6UxxWncBdrO5EaTxhJEbyUYMMWERY1NX
         PbUs654lQo1AhG7FaHEsz5cVJTdxukJmwD6NWQzo3AicUFqVqwQURcyBnkZCWg9MKEzA
         eyyBHAj2T4+mdw7s5P9o3zsV81VjW98L4AI3OFrIIKRFYbLGD3ZSfzpdhyzcMh5iVn5S
         /beC2JCFXphnyvZWuZOP2XyrHtycbu15o8XrrwZSYb0uPZOt+KvLffzvBucrgWGEIOlt
         9OQQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20190828
Message-ID: <328a6134-2e7e-78a2-19fa-47c58e62d069@baylibre.com>
Date: Wed, 28 Aug 2019 15:20:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR simply adds a missing compatible enabling the G12B clock controller.

The CI jobs passed at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/568

Thanks,
Neil

The following changes since commit e4b8dd9b34021241cd05d5cc9d24b4ae34657830:

  Merge https://gitlab.denx.de/u-boot/custodians/u-boot-mpc85xx (2019-08-27 07:11:37 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20190828

for you to fetch changes up to d0e8c4ad513c0df492cc90bdc59f272687e90b32:

  clk: meson-g12b: add compatible (2019-08-28 10:14:31 +0200)

----------------------------------------------------------------
- add missing g12b clock driver compatible, fixing odroid-n2 usb support

----------------------------------------------------------------
Mark Kettenis (1):
      clk: meson-g12b: add compatible

 drivers/clk/meson/g12a.c | 1 +
 1 file changed, 1 insertion(+)
