Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.2664.1665135524069300112
 for <u-boot-amlogic@groups.io>;
 Fri, 07 Oct 2022 02:38:44 -0700
Received: by mail-wr1-f52.google.com with SMTP id a3so6477827wrt.0
        for <u-boot-amlogic@groups.io>; Fri, 07 Oct 2022 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hdk1fsXI4jiBc5/neSRY6TnId8pIZ9EPHdkJRqBa8gM=;
        b=kO3o6uS0DyeGerfGwL7HFD1zoR93Q7E5hVzAi7/N0vNcyKCgbgw4sc1fLJSYbZObCa
         TFQkqvnhRw3D/deAdp98jIihgtWt5tCwLsE3wzxe+kmiwBBIiQd8mYdlTHIgm5es3iM3
         2uFJVjmkD2/gnbC06AqgnK9i7HHTfAQDxnLeuw8l3iX9Z9bBZba0Db0dhQxEpXTc8RD5
         0R4I2ZAthUvki1j7Psn6JUSuR7j+M3ndLlXN41Xi1CCWrUuxrehMB5IXy2MOUh0UV316
         6kcJoNBKQhwGAkviCJHgB4IUwRHygqOU2QfxZTTVtRSdiu/IW44mw+igB1AS0JpMJnaN
         CBzw==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Date: Fri, 07 Oct 2022 11:38:22 +0200
Subject: [PATCH v2 1/2] usb: gadget: fastboot: detach usb on reboot commands
MIME-Version: 1.0
Message-Id: <20220728-reset-usb-controller-v2-1-ef7657ce78b1@baylibre.com>
References: <20220728-reset-usb-controller-v2-0-ef7657ce78b1@baylibre.com>
In-Reply-To: <20220728-reset-usb-controller-v2-0-ef7657ce78b1@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Christian Hewitt <christianshewitt@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

When host issues "fastboot reboot fastboot", it's expected that the
board drops the USB connection before resetting.

On some boards, such as Khadas VIM3L and SEI610, this is not the case.

We observe the following error:
$ fastboot reboot fastboot
Rebooting into fastboot                            OKAY [  0.004s]
fastboot: error: Failed to boot into userspace fastboot; one or more components might be unbootable.

This does not happen when we use the RST button on the board.
It can be reproduced in linux with:
  # echo b > /proc/sysrq-trigger

In this case, we hit a undefined hardware behavior, where D+ and D-
are in an unknown state. Therefore the host can't detect usb
disconnection.

Make sure we always call usb_gadget_release() when a "fastboot reboot"
command is issued.

Note: usb_gadget_release() should be called before g_dnl_unregister()
because g_dnl_unregister() triggers a complete() call on each
endpoint (thus calling do_reset()).

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 cmd/fastboot.c                  | 2 +-
 drivers/usb/gadget/f_fastboot.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index dd223b1554da..b498e4b22bb3 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -83,9 +83,9 @@ static int do_fastboot_usb(int argc, char *const argv[],
 	ret = CMD_RET_SUCCESS;
 
 exit:
+	usb_gadget_release(controller_index);
 	g_dnl_unregister();
 	g_dnl_clear_detach();
-	usb_gadget_release(controller_index);
 
 	return ret;
 #else
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index d0e92c7a071f..07b1681c8a9a 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -544,6 +544,7 @@ static void rx_handler_command(struct usb_ep *ep, struct usb_request *req)
 		case FASTBOOT_COMMAND_REBOOT_FASTBOOTD:
 		case FASTBOOT_COMMAND_REBOOT_RECOVERY:
 			fastboot_func->in_req->complete = compl_do_reset;
+			g_dnl_trigger_detach();
 			break;
 #if CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT)
 		case FASTBOOT_COMMAND_ACMD:

-- 
b4 0.11.0-dev-5166b
