Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.9644.1695891880662576199
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Sep 2023 02:04:41 -0700
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40651a72807so3953745e9.1
        for <u-boot-amlogic@groups.io>; Thu, 28 Sep 2023 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695891879; x=1696496679; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C560Nh+KV3R8eIM8i9TQVF4mEeqUj4ionnt9HrBHDDo=;
        b=kfJh+7uEKjPvufCdtFfOnR5wZkAUugTfkvn2rkek8YNZopcRRYsBUzH399S6u9puUo
         ZR07pI8GXxKuzDgPWfmw3xNF70ySWjbxEMY1rEdYf6go0+m9KT2MLI0D3zDiE0G5mUvh
         d5JuNGINl0pR0vBN46BNbs1azwu5aqrQUvKlR9lTNcb98SzVr+Hrq3WAk50PVrun0ivh
         bRnaQJJitlcXPhuZ1gG/A2hUaHg5Z++bpJwtMZs2Uuc3lKPUhLLEVQCUBPTpfuNN67Np
         ZUb244tkCPXRuEV+hUzp5Y7KAVNsLHdQoWFtvbWD+CetzTnTqC8uL2a8RkuHDVmZEvti
         qtvQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <f61de215-b962-452b-b72d-ba4cf354d6f1@linaro.org>
Date: Thu, 28 Sep 2023 11:04:37 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFT PATCH 0/2] mmc: meson-gx: improve MMC reliabilty
References: <20230915160130.352099-1-jbrunet@baylibre.com>
In-Reply-To: <20230915160130.352099-1-jbrunet@baylibre.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 15/09/2023 18:01, Jerome Brunet wrote:
> Amlogic MMC on the GX (and later) SoCs has been problematic for years,
> especially with u-boot.
> 
> Linux has been fairly stable for a few years. It is using a fixed phase
> setting with Core = 180, Tx = 0 and Rx = 0 (the latter cannot be set
> starting from the v3 MMC IPs)
> 
> Still the results were not good with those settings with u-boot, on some
> sm1 based platforms. U-boot then started using a 270 core phase for sm1
> only.  This worked for most sm1 platforms but problems persist on others.
> 
> The proposal with this patchset is to use 270 for the ID phase, 180
> otherwise.  This works well on the platforms I have tested (Libretech's
> boards and VIM3L)
> 
> It would be great if others could test this and report whether this work
> for them or not.
> 
> If the results are good, this might be ported to Linux as well (... but the
> situation is less critical there)
> 
> Jerome Brunet (2):
>    mmc: meson-gx: clean up and align on Linux settings
>    mmc: meson-gx: set 270 core phase during the identification
> 
>   drivers/mmc/meson_gx_mmc.c | 50 ++++++++++++++++++--------------------
>   drivers/mmc/meson_gx_mmc.h |  9 +++++--
>   2 files changed, 31 insertions(+), 28 deletions(-)
> 

I'll apply on my test branch which triggers my autobuilder providing ready-to-boot
binaries for most of the supported platforms:
https://gitlab.com/superna9999/amlogic-u-boot-autotest/-/pipelines

Neil
