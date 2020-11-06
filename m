Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.9691.1604655779449378367
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 01:42:59 -0800
Received: by mail-wr1-f66.google.com with SMTP id w14so604392wrs.9
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 01:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=RSsBsGVC0sWl2fB95PWzX5ulegG+qUnAgNNeIAjUVdo=;
        b=Zdb6723Y+2ECFuihpZ5u9JCuN/mU64yjuAeS8JkgqllymPTSA22x3JpUEQDrHDbnmX
         tpOyks1UNAfUPm31AH2spnEXeuqAloa+hnnoVObF0MIf3uEtQq/miK6nVHifaITWxaaW
         vVKqGluwOAq4W9wePZpajgAZaRgZlqv2x6qZQeb5MfXbJVGYoOEuufQG7o/Qpe1pLES7
         1LYm1vOuMoMvuht7+nEPQZin8rWa2KjHY58+dZbEPiUxKJKNwVI4oF8DWrWjvEjdZqtC
         ocOEF+NfYPijFSra0Ny+d7GkR/d7dfToPcqTDRQ700e/o8a5j43aQpSoGznS9UEusJek
         R0pg==
Return-Path: <jbrunet@baylibre.com>
References: <20201106090752.31005-1-jbrunet@baylibre.com>
 <b93c004f-7783-7402-2e65-ed16380ee4bb@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 0/2] arm64: meson: add libretech cc v2 support
In-reply-to: <b93c004f-7783-7402-2e65-ed16380ee4bb@baylibre.com>
Message-ID: <1jwnyyq0rj.fsf@starbuckisacylon.baylibre.com>
Date: Fri, 06 Nov 2020 10:42:56 +0100
MIME-Version: 1.0
Content-Type: text/plain
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Da Xue <da@libre.computer>
List-ID: <u-boot-amlogic@groups.io>


On Fri 06 Nov 2020 at 10:29, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Hi,
>
> On 06/11/2020 10:07, Jerome Brunet wrote:
>> This patchset adds support for the Amlogic based libretech cc v2.
>> Like the v1, this revised platform used the s905x SoC.
>> 
>> Changes since v1:
>> - Move Makefile change to patch #1
>> - Amend documentation for libretech cc v2
>
> Seems you had a patch issue, the following patches are the same as v1

Ugh indeed, sorry about that

>
> Neil
>
>> 
>> Jerome Brunet (2):
>>   arm64: dts: import libretech-cc-v2 from linux v5.10-rc1
>>   arm64: meson: add support for libretech-cc v2
>> 
>>  arch/arm/dts/Makefile                         |   1 +
>>  ...eson-gxl-s905x-libretech-cc-v2-u-boot.dtsi |   7 +
>>  .../dts/meson-gxl-s905x-libretech-cc-v2.dts   | 318 ++++++++++++++++++
>>  configs/libretech-cc_v2_defconfig             |  82 +++++
>>  4 files changed, 408 insertions(+)
>>  create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2-u-boot.dtsi
>>  create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts
>>  create mode 100644 configs/libretech-cc_v2_defconfig
>> 

