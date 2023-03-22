Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.39494.1679482004922857428
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Mar 2023 03:46:45 -0700
Received: by mail-wm1-f51.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so12704868wmb.2
        for <u-boot-amlogic@groups.io>; Wed, 22 Mar 2023 03:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679482003;
        h=content-transfer-encoding:organization:content-language:cc:to
         :reply-to:subject:from:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YaJI/a4HO+ouefrY9uCjRIPcsLZXvc5QIlWm3BOir8k=;
        b=LivBJs61EKPZ3plrgE1e/uuz1SEMq5VDNMUX1QUIAoSrGbxH9dlDGSOh7O1IXVgX8p
         9GAQmBpU51C7kVjPQ0uIH7UhX9gfEOnRtXtHjSvDlcKcAYUWPNVBvYV/OwHDuJqSykyB
         FTe2PbPvnDdBiLbVYzjYPOiGwZS9rlQciE7VPVhRDvlQOmszxF3D1HdLWYhEZicWw00G
         v7vgk/PvDaYEzcMJka4q/jE8IjYTCX0Z+fqB6q0MWIv0RQqpEdIMcUkLT2ACQBVtT9XC
         CderY4m+WAO68SBZ69wh34VVpsJ8X2OL2DWlxWjE8awP2SoNEIEQdXVnxK6QFhGTFvQ7
         CcSA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <1f1304e3-9f03-0420-c9d0-d36338f413d0@linaro.org>
Date: Wed, 22 Mar 2023 11:46:42 +0100
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20230131
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>


Hi Tom,

A single change to enable the odroid-go-ultra PMIC regulator at boot.

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/15691

Thanks,
Neil

The following changes since commit 88e08fc5f6e508eac46cd1dfb0379b11ae032c0a:

   Prepare v2023.04-rc4 (2023-03-13 20:52:48 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20230322

for you to fetch changes up to de58694f0d5431627d7389f50a6b2034a682ba24:

   ARM: meson: odroid-go-ultra: setup PMIC regulators are board init (2023-03-14 09:03:16 +0100)

----------------------------------------------------------------
- odroid-go-ultra: setup PMIC regulators at board init

----------------------------------------------------------------
Neil Armstrong (1):
       ARM: meson: odroid-go-ultra: setup PMIC regulators are board init

  .../arm/dts/meson-g12b-odroid-go-ultra-u-boot.dtsi |  8 ++++++++
  board/amlogic/odroid-go-ultra/MAINTAINERS          |  7 +++++++
  board/amlogic/odroid-go-ultra/Makefile             |  5 +++++
  board/amlogic/odroid-go-ultra/odroid-go-ultra.c    | 22 ++++++++++++++++++++++
  configs/odroid-go-ultra_defconfig                  |  4 ++--
  5 files changed, 44 insertions(+), 2 deletions(-)
  create mode 100644 board/amlogic/odroid-go-ultra/MAINTAINERS
  create mode 100644 board/amlogic/odroid-go-ultra/Makefile
  create mode 100644 board/amlogic/odroid-go-ultra/odroid-go-ultra.c
