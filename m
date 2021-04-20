Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.7732.1618908150174434696
 for <u-boot-amlogic@groups.io>;
 Tue, 20 Apr 2021 01:42:31 -0700
Received: by mail-wr1-f50.google.com with SMTP id x7so36685855wrw.10
        for <u-boot-amlogic@groups.io>; Tue, 20 Apr 2021 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d0tbSHZstsvQJkea7ktGC8CIaznscjoQyr8+6/1ALGU=;
        b=sxDB8bhsEL5frHCEVls+xOXXpSe5RPVp1cHNvJVNHla8DQkKY7GVUPlixPgM4yPZIq
         FO8MYUBaD2MMopLfK6U7y8DkHQ2sdz7YXy4EzBZgLjy/SBAbIO/fEDz9Tw58XalOWQ+a
         RTao+qOMi6QJSzSreS2t7+7n/14Eac9XCHeh0mOM02ZrlmTzR/WQw4/x56q3SBAFH7AP
         8YRLrokxSpvOSiIvG2SiTN4H/dMPuzJPGkRxo1J1A9UgRn6VO3KVEXBjpcuMXnetlM9t
         4/RVplahpHLhxTSRK6Hr2kdQGOy1c5EEqVMsDQe98d8j3llcomQgBrL7sic9GY3GQPkH
         exOg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/2] reset: fix reset_get_by_index_nodev index handling
Date: Tue, 20 Apr 2021 10:42:24 +0200
Message-Id: <20210420084226.2996654-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: sjg@chromium.org
Cc: jagan@amarulasolutions.com, u-boot@lists.denx.de, trini@konsulko.com, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

A regression weas detected on Amlogic G12A/G12B SoCs, where HDMI output was disable
even when Linux was booting.

Bisect reports 139e4a1cbe ("drivers: reset: Add a managed API to get reset controllers from the DT")
as the offending commit.

But the error is in ea9dc35aab ("reset: Get the RESET by index without device") where a spurius "> 0"
was added to the index handling.

But the dm_test_reset_base() test did not catch it.

The first commit extends the test to catch the regression, and the second patch fixes the regression.

Neil Armstrong (2):
  test: reset: Extend base reset test to catch error
  reset: fix reset_get_by_index_nodev index handling

 arch/sandbox/dts/test.dts    |  4 ++--
 drivers/reset/reset-uclass.c |  2 +-
 test/dm/reset.c              | 39 +++++++++++++++++++++++++++++++-----
 3 files changed, 37 insertions(+), 8 deletions(-)

-- 
2.25.1

