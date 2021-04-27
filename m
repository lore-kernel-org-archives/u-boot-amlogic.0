Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web12.5341.1619509034976105166
 for <u-boot-amlogic@groups.io>;
 Tue, 27 Apr 2021 00:37:15 -0700
Received: by mail-wr1-f54.google.com with SMTP id h4so49341449wrt.12
        for <u-boot-amlogic@groups.io>; Tue, 27 Apr 2021 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+5cuASHzdvlWq/OJcYN22j4E1PevuBzZ/W9UjqjUQ64=;
        b=RJiB00FtoShixectfwMdllwFPumjH5lqe4ZnMCUpHC+8EbrksTvH/hUbeKysvotOgo
         OqbVGaFcBqKgEnpNcY2NlCdo+g4RbzELkWfbAOLbrFGRPZPnAwM+D87MMlKYxZb0f4GD
         uccpmwctM/Pn5tUaGMLNZMBg8W2TGV9QOs1AK5K09c3Xhot7UU3hV3dtH6TtmZ0QpNfW
         cFV5jM2F1WJ4d/cVXX21tVsmzzptxaY/ysiLJ4PwSidvhg8qLint+ilW1Ytn/AwhoG+q
         v9BV3+QHr5S1DRvFOP6JIohSyI8MHzohQdxHUdcpxU0vWk+EZbsrQB2smXDIrAiMIpk6
         TelA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] reset: fix reset_get_by_index_nodev index handling
References: <20210420084226.2996654-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <076e7fbd-94e4-606e-4d00-09c1f98fd7f5@baylibre.com>
Date: Tue, 27 Apr 2021 09:37:11 +0200
MIME-Version: 1.0
In-Reply-To: <20210420084226.2996654-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: sjg@chromium.org, trini@konsulko.com
Cc: jagan@amarulasolutions.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Tom, Simon,

On 20/04/2021 10:42, Neil Armstrong wrote:
> A regression weas detected on Amlogic G12A/G12B SoCs, where HDMI output was disable
> even when Linux was booting.
> 
> Bisect reports 139e4a1cbe ("drivers: reset: Add a managed API to get reset controllers from the DT")
> as the offending commit.
> 
> But the error is in ea9dc35aab ("reset: Get the RESET by index without device") where a spurius "> 0"
> was added to the index handling.
> 
> But the dm_test_reset_base() test did not catch it.
> 
> The first commit extends the test to catch the regression, and the second patch fixes the regression.

So you have any comment on the patch order here ? Should I push the fixed test after the fix ?

Neil

> 
> Neil Armstrong (2):
>   test: reset: Extend base reset test to catch error
>   reset: fix reset_get_by_index_nodev index handling
> 
>  arch/sandbox/dts/test.dts    |  4 ++--
>  drivers/reset/reset-uclass.c |  2 +-
>  test/dm/reset.c              | 39 +++++++++++++++++++++++++++++++-----
>  3 files changed, 37 insertions(+), 8 deletions(-)
> 

