Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web09.13998.1619625044221758274
 for <u-boot-amlogic@groups.io>;
 Wed, 28 Apr 2021 08:50:44 -0700
Received: by mail-wr1-f43.google.com with SMTP id m9so50847516wrx.3
        for <u-boot-amlogic@groups.io>; Wed, 28 Apr 2021 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Uel8cI22BAaiXI8bvCXZagf21WYsn2sSBWt+MSb7Ai0=;
        b=av2/bsZCjjHGItdBvz6kegD0RATGk3ZOpdWnDOehYEIZgJ3iA7//PQ+lOmGdTx12az
         BuYwrd6//G2mvmT944wpOZ1XWTDU0BvrZ7qkoSVHSNcs2S3jifVkyA2Xp7FOz8wc+id5
         i6jr6pnOqpROHtRpEZI+tv9IwtMDbCBjilYe3CRtkV/TT98eSMrebdKJl2lZT44+oApY
         6ly1gqFsSoup2DFn93CjEwKSF+67a9I9RKky21o1QL3wdZam8YimhIYX5waNejuwKw2H
         WfN6Kf6pWzc3u/A7XuxuLO36a8CAbuPucCz8vM84NuzmSRiJeyJjC6i/OCp6Gx1sEisd
         ApjA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20210428
Reply-To: narmstrong@baylibre.com
Message-ID: <bfecf72a-6bbd-abd0-9ac9-cc3d7cb0715c@baylibre.com>
Date: Wed, 28 Apr 2021 17:50:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

A single patch to fix boot on (at least) Odroid-C4, where the MDIO bus reset used random
sleep values instead of the proper pdata values.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/7337

Thanks,
Neil

The following changes since commit 79b0f08d6af498e6fda8cd257d62e2095764410c:

  configs: Resync with savedefconfig (2021-04-27 08:28:38 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20210428

for you to fetch changes up to 98b8204626ac2837e927e79d3dfe77246e506c02:

  net: designware: fix PHY reset with DM_MDIO (2021-04-28 17:45:26 +0200)

----------------------------------------------------------------
- net: designware: fix PHY reset with DM_MDIO, fixing boot of (at least) Odroid-C4

----------------------------------------------------------------
Neil Armstrong (1):
      net: designware: fix PHY reset with DM_MDIO

 drivers/net/designware.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)
