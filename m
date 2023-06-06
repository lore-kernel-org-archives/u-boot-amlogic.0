Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.565.1686067683460214172
 for <u-boot-amlogic@groups.io>;
 Tue, 06 Jun 2023 09:08:04 -0700
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f6ffc2b314so53662245e9.0
        for <u-boot-amlogic@groups.io>; Tue, 06 Jun 2023 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686067681; x=1688659681;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JswW6qm4n4gV1alhdWK4pPU4IJxG64iUPiwdoiSW7as=;
        b=rCv/GCDpofO/r5AHyxCoKY96zHzlakUB7ydsb8RhT8xYY44bj2AmBrN/l3DRf1YGHE
         ZtZo/ywyOUYzzac1HxeWvB59ALBDshhK9j0M/3lXzOmpkko2pLEWeXto2uCEh22E0mCY
         w0C4YEHT71R/ck8NVDiqvP2hBOF5n391w50g9dboV8BYxlmGaC+/XhIOJ1AepxOXwRSu
         n7v8q7//y5wbjGHIL6fV9mfnO/O6j0xVOqd6vQP6eIIBC/xDk9t851umEnmr6aCWHMhl
         U8aDUru21PO+yOi5beNmDtesUJBA0M1HgP4w3ZzNOjrcrQx3Oj2rFYABmsJEYwqdwqNS
         xXjQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Date: Tue, 06 Jun 2023 18:07:48 +0200
Subject: [PATCH] serial: meson: fix meson_serial_pending() tx logic
MIME-Version: 1.0
Message-Id: <20230606-fix-meson-serial-pending-v1-1-6a54d4a01f76@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

According to the dm_serial_ops documentation, pending() should:
> @return number of waiting characters, 0 for none, -ve on error

And:
> It is acceptable to return 1 if an indeterminant number
> of characters is waiting.

With the current implementation, we have:
* FIFO is full           -> pending() returns 0
* FIFO is partially used -> pending() returns 1
* FIFO is empty          -> pending() returns 1

This is not the same as what the documentation requires.

Moreover, since [1], arm reset now flushes all console devices
(including serial) before the cpu gets reset.
Because of the flawed logic:

  => reset # user calls reset
  flush() is called
  _serial_flush() is called
  ops->pending(dev, false) # never returns false
  # board hangs indefinitely without resetting.

Fix it by using AML_UART_TX_EMPTY instead of AML_UART_TX_FULL.

[1] commit c5f4cdb8eb60 ("console: Use flush() before panic and reset"),

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Tested with:
=> reset # vim3 board no longer hangs
---
 drivers/serial/serial_meson.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
index d026f5a7a8e5..934de2ab2358 100644
--- a/drivers/serial/serial_meson.c
+++ b/drivers/serial/serial_meson.c
@@ -201,7 +201,10 @@ static int meson_serial_pending(struct udevice *dev, bool input)
 
 		return true;
 	} else {
-		return !(status & AML_UART_TX_FULL);
+		if (status & AML_UART_TX_EMPTY)
+			return false;
+
+		return true;
 	}
 }
 

---
base-commit: a1fd9cb41fb1fda2283a089f9c97e5eed4d4940a
change-id: 20230606-fix-meson-serial-pending-890e11467215

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

