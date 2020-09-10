Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web12.20280.1599740203366224626
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2020 05:16:43 -0700
Received: by mail-wm1-f46.google.com with SMTP id e11so1773314wme.0
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2020 05:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=vV4u/1pn79aNHtYu7ahVxzhpdE5Mo1wYhHq5FSM9SLU=;
        b=l7F1yJidkwJ92bRAGjFZOmK44tq/2kD8cd0L90XHD2BzIte8aUtLqNv0nJvmkpOLRT
         xDJChdig+s3/xx6oeDjI14fpp2hOY2IG6ol0/7T5CgYb0kqp4N2IK3VcwPJ9cr4R5Vf4
         lStN7/9L6k5RAtfJ5q3z4KMycArpZ+NaFADVBxIyyhwPDIhM3RBgJTXi3V5H0lpwYB4J
         olqJnyg4CjSxHSCexqnvHXwZ+i1dN3eGEAC9DPriD309UxrGiweW737DBtdT4vm1ier/
         5x18Tw1EYbAJJ8kMx7e9CtioL64dQj3Cee5gR/dEy6y5nyCdbQrCmZcyW11q8bNbU2in
         iSEQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20200910
Reply-To: narmstrong@baylibre.com
Message-ID: <6544fec4-9f3f-b10d-c427-2a00803384d3@baylibre.com>
Date: Thu, 10 Sep 2020 14:16:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR enables/fixes HDMI output & USB keyboard on Odroid-N2 & Odroid-C4.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/4642

Thanks,
Neil

The following changes since commit a34746b86ecb650679500e0c596fdae38665939f:

  Merge tag 'u-boot-stm32-20200909' of https://gitlab.denx.de/u-boot/custodians/u-boot-stm (2020-09-09 12:59:02 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20200910

for you to fetch changes up to 92f10e61351ddddd730c49c00cdbbd195c838140:

  configs: odroid-c4: update for HDMI output background & USB keyboard (2020-09-10 10:51:36 +0200)

----------------------------------------------------------------
- enables HDMI output & USB keyboard for Odroid-N2
- setups HDMI output background & enables USB keyboard

----------------------------------------------------------------
Anand Moon (2):
      configs: odroid-n2: update for HDMI output & USB keyboard
      configs: odroid-c4: update for HDMI output background & USB keyboard

 configs/odroid-c4_defconfig | 4 ++++
 configs/odroid-n2_defconfig | 9 +++++++++
 2 files changed, 13 insertions(+)
