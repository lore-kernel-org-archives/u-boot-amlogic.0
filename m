Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.20798.1669212506297732447
 for <u-boot-amlogic@groups.io>;
 Wed, 23 Nov 2022 06:08:26 -0800
Received: by mail-wr1-f53.google.com with SMTP id cl5so29574663wrb.9
        for <u-boot-amlogic@groups.io>; Wed, 23 Nov 2022 06:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:organization:reply-to:content-language:cc
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9mqUWakKZscLjh1f5j8y2u57CFzSYg7Mveb5XFbpBk=;
        b=ki284ijM0lHA5aNa+Id2sLquLGLA5TJ7Lkc8mKhr/pGu8RZkEWCHD6WoCOq7yV0S5P
         siC1Mvmg3667yWROGZ9iMPR7UtLNbsjiam/i6FrWJIGzoAIrUSNU4Dyffl1A/QZhPFCr
         8DSIluI/0D3otHOSn0in1Svu3eioBymJqllSHzHwxhZZvl3uvEhwDQzc+qqywwiAlQxl
         8swNzcM/LzCgh2T9hj6z/9bFuzPqgtmyQFN0THQHmlaN1Suwhl6ds+Za2A4ctHMOfkmK
         WkgWGg+4HJrLcdoz3Pum9BwdRKwbwv36IbGsMZnVs45XFeu1rSWhaI0VwqLcBRGCXtCO
         AyEw==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <816cc05d-fdac-3b03-ce68-e57f45f62ffe@linaro.org>
Date: Wed, 23 Nov 2022 15:08:23 +0100
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20221122
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>


Hi Tom,

Here's changes for next release:
- Implement setbrg op to meson serial device
- Re-add the old PHY reset binding for nanopi-k2

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/14199

Thanks,
Neil

The following changes since commit 536c642ffef545b4b5b02d065a0c1de9785549d7:

   Merge tag 'efi-2023-01-rc2-2' of https://source.denx.de/u-boot/custodians/u-boot-efi (2022-11-22 08:30:53 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20221122

for you to fetch changes up to e0638f1d09b9e9caead4e3909e7dc8aaa41febe1:

   arm64: dts: meson: nanopi-k2: readd PHY reset properties (2022-11-22 18:53:21 +0100)

----------------------------------------------------------------
- Implement setbrg op to meson serial device
- Re-add the old PHY reset binding for nanopi-k2

----------------------------------------------------------------
Christian Hewitt (1):
       arm64: dts: meson: nanopi-k2: readd PHY reset properties

Edoardo Tomelleri (1):
       arm: amlogic: add setbrg op to serial device

  arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi |  7 +++
  drivers/serial/serial_meson.c                 | 70 +++++++++++++++++++++++++++
  include/configs/meson64.h                     |  7 +++
  3 files changed, 84 insertions(+)
