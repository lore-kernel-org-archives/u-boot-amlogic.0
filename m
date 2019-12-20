Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web10.7335.1576836815385729008
 for <u-boot-amlogic@groups.io>;
 Fri, 20 Dec 2019 02:13:35 -0800
Received: by mail-wr1-f68.google.com with SMTP id w15so8878766wru.4
        for <u-boot-amlogic@groups.io>; Fri, 20 Dec 2019 02:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hs6k993moHtpBdoLsBabcE3zMa6+N/hNGanfQ/rcKd4=;
        b=q5NhSY4KVK4LwT4WOMhP+Wf2MDnERR82KPYK6YEVN1fKUFfEAkaay+kLciH5HXMcFm
         OU21lubqt9tw5D+sLTfvdQkSMNLzrfn+I3H6OOkiSBs80nO5jGFb3ir/5L1f8hDGcBaM
         d/k+5KFPxf5H5k2ddmGV/kHBL3Hu5E4/Bx8hg+R7XJEmIxu7N8kB3fCewhk0wO7US4mg
         OmmVV/bQSBOrSYFbhmufx0GNKgrSgN0dShb2/WpX0Fjq1kzdsqGcKR2YMnWywOJGQVBm
         svdsBuSit7mQ0S20cOPTzB3Ljgrpopck5n/T1RYHWhfJ2lR7myqz2Zl8bucwyZTJ+bVE
         wcog==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 5/5] arm64: dts: meson: add libretech-pc support
References: <20191219183620.1423118-1-jbrunet@baylibre.com>
 <20191219183620.1423118-6-jbrunet@baylibre.com>
 <CAGb2v64Wp8ggLUSnhvheOJHeA5-gqL2YfTJv7mu5q=7KMrWV2Q@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <5a0a8d98-7d83-9003-2849-f8328ae7400b@baylibre.com>
Date: Fri, 20 Dec 2019 11:13:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAGb2v64Wp8ggLUSnhvheOJHeA5-gqL2YfTJv7mu5q=7KMrWV2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Chen-Yu Tsai <wens@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 20/12/2019 04:05, Chen-Yu Tsai wrote:
> On Fri, Dec 20, 2019 at 2:37 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>> Add support for the Amlogic based libretech-pc platform.
>> This platform comes with 2 variant, based on the s905d or s912 SoC.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm/dts/Makefile                         |   2 +
>>  arch/arm/dts/meson-gx-libretech-pc.dtsi       | 376 ++++++++++++++++++
>>  .../meson-gxl-s905d-libretech-pc-u-boot.dtsi  |   7 +
>>  arch/arm/dts/meson-gxl-s905d-libretech-pc.dts |  17 +
>>  arch/arm/dts/meson-gxl-s905d.dtsi             |  12 +
>>  arch/arm/dts/meson-gxl.dtsi                   |  35 +-
>>  .../meson-gxm-s912-libretech-pc-u-boot.dtsi   |   7 +
>>  arch/arm/dts/meson-gxm-s912-libretech-pc.dts  |  62 +++
>>  configs/libretech-s905d-pc_defconfig          |  73 ++++
>>  configs/libretech-s912-pc_defconfig           |  73 ++++
>>  10 files changed, 654 insertions(+), 10 deletions(-)
>>  create mode 100644 arch/arm/dts/meson-gx-libretech-pc.dtsi
>>  create mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc-u-boot.dtsi
>>  create mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc.dts
>>  create mode 100644 arch/arm/dts/meson-gxl-s905d.dtsi
>>  create mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc-u-boot.dtsi
>>  create mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc.dts
>>  create mode 100644 configs/libretech-s905d-pc_defconfig
>>  create mode 100644 configs/libretech-s912-pc_defconfig
> 
> May I suggest including the actual model name "AML-S912-PC" in the
> file names? That will make it that much more obvious what these files
> are for, instead of "libretech-pc" which few people have heard of.
> 
> So something like "meson-libretech-aml-s912-pc.dtsi",
> "meson-gxl-s905d-libretech-aml-s912-pc.dts",
> "meson-gxm-s912-libretech-aml-s912-pc.dts",
> "libretech-aml-s912-pc-s905d_defconfig", and
> "libretech-aml-s912-pc-s912_defconfig".
> 
> Same goes for the Linux copy.

It keeps the same scheme as the libretech-ac and libretech-ac DT naming,
please comment the Linux patchset instead of this one.

Neil

> 
> ChenYu
> 

