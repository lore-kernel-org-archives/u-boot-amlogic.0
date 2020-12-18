Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web08.1925.1608312294993989941
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 09:24:55 -0800
Received: by mail-wr1-f43.google.com with SMTP id a12so3060489wrv.8
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 09:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=0wXPssdqIRZccghLGYKpwgSTfgF5VkWRIDqoY1CSzUA=;
        b=bK0ne4fjUrPv9mFxgv4jGa6WlG1pYEsLBG4VOtUCpovGd4fAU/PardmOTkmBLx7hlQ
         vTPHZDB22HswKwGsAd3ihkuNR/x0UWXUpLlTIg8VEMJHOjfoXNbhxMpMAzmt/b/xT2rU
         FoSpvNm7pxGr41sAXY5GMo3Y8osvltx34gbSoGvSzemSuItvrZV7N7aENpQC2qCmPELC
         ZOpNLPCZLqJWmcKFidHGjfiBAdUB4pXUP3f0IgiHhQuBVNXyfP4wTrMhS549u6aHr/QY
         6h/43zZjOZ3CQ7HjlEuLyXimBzcUQOvxt6MrIXcmpWtPLeEB81F0TAHSBri70XnrNcT4
         UmEQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20201218
Reply-To: narmstrong@baylibre.com
Message-ID: <2154a13d-8cee-94ab-f853-c4fdc173233e@baylibre.com>
Date: Fri, 18 Dec 2020 18:24:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

A (hopefully) last PR for 2020 with an one-liner fixing the Odroid-C4 reset when booting over SDCard,
a bug we had in our backlog for a long time !

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/5613

Thanks,
Neil

The following changes since commit a4391365995a00f196373cddd35d99f74a9e62ff:

  configs: Resync with savedefconfig (2020-12-16 10:58:24 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20201218

for you to fetch changes up to 21a1bc6a900c33efe4da4cc1b33efcfa543fd9d0:

  ARM: dts: meson: switch TFLASH_VDD_EN pin to open drain on Odroid-C4 (2020-12-18 11:50:27 +0100)

----------------------------------------------------------------
- fix Odroid-C4 soft-reboot caused by bad setup of SDCard VDD regulator

----------------------------------------------------------------
Marek Szyprowski (1):
      ARM: dts: meson: switch TFLASH_VDD_EN pin to open drain on Odroid-C4

 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)
