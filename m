Received: by mail-wr1-f50.google.com with SMTP id h7so18423517wrw.8
        for <u-boot-amlogic@groups.io>; Tue, 10 Sep 2019 04:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:openpgp:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=CsN2hU6lu7yw0UqiKXICqMRgIY1s59tU8Pp8T8u3+5Q=;
        b=0l9MGS1neDZhPaJRjZV4zGEqB6KdFTV7krSscmD8dGLUOd06/3gqGbO5aVpvyUpA4q
         wlIXhQGDvnGKuBjRwSF9OK99S/qk+d8JfPlC5ptLKABeA51O0Y9zy/9jnyY10rsMm4Xz
         MdOaYiEyQXSzah8t/x2NIAsBpsPHeb1Tw8Hp1/k6+zzKXMi+xgbl4U/Hvy2VZO/ASou4
         1P2PVXw3gRU/iAkkPWDExoOe9F4fCb0LjGuK3XOfqDntto2/RCsEeHeVZAXaCOMweseI
         EQ8BzmqL1jkqIK5O8IgEYv/zXkuth/b4jjOALAF2ivn3/xrgqmni2uPJbMCqdcL+8Z/m
         MlIA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20190910
Message-ID: <99fcc772-b283-c888-4747-b89fdf27177d@baylibre.com>
Date: Tue, 10 Sep 2019 13:28:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR simply adds support for dis_u2_susphy_quirk in the xhci-dwc3 driver to fix boot when
a device is plugged only in the OTG capable port for libretech-ac and libretech-cc.

Bin acked me for pushing this fix through my tree.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/642

Thanks,
Neil

The following changes since commit c705fc3b40b88bfbf465448643c91da71426df2f:

  arm: ti: Add missing "=" from previous fix (2019-09-09 10:55:45 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20190910

for you to fetch changes up to b35b8076828d1059c1fcc648ed8c8210ebe6a3dd:

  usb: xhci-dwc3: Add support for dis_u2_susphy_quirk (2019-09-10 10:00:53 +0200)

----------------------------------------------------------------
- Add support for dis_u2_susphy_quirk in the xhci-dwc3 driver to fix boot when
a device is plugged only in the OTG capable port for libretech-ac and libretech-cc

----------------------------------------------------------------
Neil Armstrong (1):
      usb: xhci-dwc3: Add support for dis_u2_susphy_quirk

 drivers/usb/host/xhci-dwc3.c | 3 +++
 1 file changed, 3 insertions(+)
