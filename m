Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.6319.1686138489171076362
 for <u-boot-amlogic@groups.io>;
 Wed, 07 Jun 2023 04:48:09 -0700
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f736e0c9a8so31064405e9.2
        for <u-boot-amlogic@groups.io>; Wed, 07 Jun 2023 04:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686138487; x=1688730487;
        h=content-transfer-encoding:organization:content-language:cc:to
         :reply-to:subject:from:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SWGNA5zYMwgctsZUKT0HGnRNlcDTh1f75c4va7h3h1s=;
        b=V/+u/jblqjxi5qNP37pgaA2cVrp/B0VEfdqpZ8SFqKbzaa5H7tkiQgwNQekzouJ2aT
         l7186c3XXjkSg655E/yCoYR4w5zoNrLdCNvG1Uz3HCq6McOlGjH7pQsj7o7Tsg91AYac
         ulSGxP7vQMtL5/cghAzvuIKCGXIeEgaX/eaM8CuG85rRcL0ZbdByU1o2ucazw9zDOEBq
         +Jehuj9lTznUtSs1IcuwxtJmfsbaLDBgcQVP43cobQ9PK+PwttNOkNR7USpsETWr1sDZ
         KORDRWio9uDvmJUm5F5tivV+nldWHcWOICoG/ltV/BJvzqHrFo56fkjMdLZdmr8ypaFi
         05dQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <fc521727-2c12-b75a-0913-1fcc05f5d290@linaro.org>
Date: Wed, 7 Jun 2023 13:48:06 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20230607
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>


Hi Tom,

A single change to to fix the meson_serial_pending logic.

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/16505

Thanks,
Neil

The following changes since commit fadf83c86d7252df2b50ba526ffeea95658cb5b5:

   Merge tag 'ubifixes-for-v2023-07-rc4' of https://source.denx.de/u-boot/custodians/u-boot-ubi (2023-06-06 09:47:17 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20230607

for you to fetch changes up to afa85a2247297d660a63295bfbdd6e24e8e56902:

   serial: meson: fix meson_serial_pending() tx logic (2023-06-07 10:09:20 +0200)

----------------------------------------------------------------
- meson_uart empty logic fix

----------------------------------------------------------------
Mattijs Korpershoek (1):
       serial: meson: fix meson_serial_pending() tx logic

  drivers/serial/serial_meson.c | 5 ++++-
  1 file changed, 4 insertions(+), 1 deletion(-)

