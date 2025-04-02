Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD90C28B20
	for <webhook@archiver.kernel.org>; Wed,  2 Apr 2025 14:02:30 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.9231.1743602543031105533
 for <u-boot-amlogic@groups.io>;
 Wed, 02 Apr 2025 07:02:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=JKPa56qd;
 spf=pass (domain: linaro.org, ip: 209.85.221.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-391342fc1f6so5952246f8f.1
        for <u-boot-amlogic@groups.io>; Wed, 02 Apr 2025 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743602541; x=1744207341; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2EjKF2FSfjqM7rTlder4uNpxU0vv4gA7MKpUhxpTVE=;
        b=JKPa56qdctQ9Nvs7b2qdql8A0qnAEbvnTpsFAcdbRnmo7vrb+1V8sVLc0CpWBf1riw
         a0DaaVUXwrIbTU0O4QPnZSlvv3XYpIWnb7EIEJgblicfyApH9uriqDGyAE0Br/Hjcyd5
         9VFGLG2xbeJ1kjwdzPpkltHFyBrS+ikyHX9FnTl8IhOkp0OYzPJb/NtQzwf+tTmskSoW
         Ld6IVNSf8YHDbHx4l4RTQxKh9Dr7Gk9ApmGbTrqLo/eQxz8RndkkolPfwUhCZx5XIzoB
         hCCV2LqT51di5tuAku7fEWmrhGj+JoLtAZTP7pFMmopIcoDy0f8mjL+Wd4exqR9lUuB+
         kIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743602541; x=1744207341;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2EjKF2FSfjqM7rTlder4uNpxU0vv4gA7MKpUhxpTVE=;
        b=o/JAjjeXEQi48m2EsPLgEq1xI7lflP4wphQO8gh5Hh1Gh2H+jtST9Re+gWjsxx7mGt
         0lEvw519mR/tVYDke472574xJUgJaCUOReSRg26zT0KhXVTlB0uBqGgHkBNxiEjbA81i
         C1+7D7Aujiw3DMc6JY3A9Z7/rB3euuSIZowHhryKyjpREgUCzBpVG04uIT5NRCzKgypY
         voktQ55Z2LU4DWpCNzN8RIyqLmnCZBc+ZsWp4kLN8bbkjk9rB5XJd8lcUk4R1/5rqe9Y
         60xXC8YrNwSXqTkdcgXpKzuMkTtwfhIcZYjLhZfxkphKzjgj03EidKeMAkCLDKMLFh88
         YPGw==
X-Gm-Message-State: AOJu0YzVg7a0ldk8uXzVsI9exCRPpQS/ruVw58HkMIgIYN53Qtezi8Qs
	exl/YuEj6SJc84RPUm0e8rxp1+OA8gNNJge037ipGvZupju9Q6l7WGn08CR7Lk8=
X-Gm-Gg: ASbGncvw7E7FdRWIO9UXoaaNOK2p3l5pn3N64L3ms3WBxi6Uhj06CIAt2RUz/RYzu9b
	b+fUb80MUKh9QXG35YEfiw6ER9zD+aPYdN+WLocmZHF1YYsEahT78zhie54h6FB/mpV663c0068
	fH+J8RgqFYY+6mHhozoS2p/wTP+eajDK0OGDUz2tSmaDPET+kOR31KltcVZYKHpB6VlAlmMuQYf
	tyqC5RmzwRx9oHUQLEb7+sHs3gz0OiOAV2j1iP2xHz2/trTdAmDoI9j+RJuxmVd61fIQo7+Q1/3
	MVzJImPU1P4ODNp+xEAKrEwBN8RVEEuLt3I0XMpVytvn6UjVZvkwLwk+wG5s2dQjuQ==
X-Google-Smtp-Source: AGHT+IGRXNX6Za2BH6BWwg3DvdIGeQMcaxGt9AwZc/PfTjwQxtC+HqPIcr1JvtECJbY7Z/xPiRFtcw==
X-Received: by 2002:a5d:5983:0:b0:390:ebae:6c18 with SMTP id ffacd0b85a97d-39c120db794mr13270429f8f.12.1743602539985;
        Wed, 02 Apr 2025 07:02:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a433bsm17283130f8f.97.2025.04.02.07.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 07:02:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 02 Apr 2025 16:02:17 +0200
Subject: [PATCH] configs: meson64: move DFU step at the end to give the
 board a chance to boot something on storage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-u-boot-meson64-move-dfu-end-v1-1-68399499ee29@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGhD7WcC/x3MQQqDMBAF0KvIrB1Ig5G2VxEX2vzYWZgpiQZBv
 HuDy7d5J2UkQaZ3c1JCkSwaKx5tQ5/vFBew+GqyxjrTGcs7z6obr8ga+45XLWAfdkb0jPkVXIB
 zvXlSHX4JQY57H8br+gOqRAzvbQAAAA==
X-Change-ID: 20250402-u-boot-meson64-move-dfu-end-eb9f5fe55608
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Tzbr/3SfSeAjPtjhGcXeNaM7p5oxwBH000vypFtPQSg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn7UNrlWXYnX4O0ePETy71q2VHSlGRs9xyCTY8dOBf
 PrxU+TaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+1DawAKCRB33NvayMhJ0eaqD/
 9ZA41PwRMKJj0xMNcZtF7NonClsSc+Efp8TiWioyWeXAooIdNkXIObvHPsa3YyBjsPNuBXtT7z3eqQ
 7h4HDks3Eb5psbnTKqwUg0gWxcHfrSuk3brknmEQ182Qq9iN59txG5yXmtu1fB6G2xXLvm6TQI//Hm
 k8Wm8je3qVfL50pYe3kRG6xfYXA189xeIiLx27PIEID7KvLc3qi+rzPQh9mGjMxQLF6A9HfTququ6F
 LWxGiUud6zudVkKgADHnvbbpWb2QuLbqMsYQkS160Kb20qcr4Bda19DVbMX5d9nnl8qQheSA2y6REs
 I0j4BiNBNvOPnHmdILb94eeMb12h0hGbF4iVQ/LIvUrbyjJtcNnTzIEdfcgxYJ+V00Rt7SpqDikUAV
 GBMTWz+pw+xnPDe8AKnHfukRGnkOubCz6qgDM2mhb5CMRh4thCuuYIP0JNJqUoWoU01LueuvA98/sK
 L++P5UuBj90ShUOZvY7zKYekRLjjVD06tAdxI7aVSSd/KxvqJFL7s7AxrT8PXnvxQZTGcgrEXA/uAF
 jgFIqy5ckPzuuixnqkaRgfE++gABHCuGOyZMFs96/1sMKw0IFsrpZbhrmMpFzdL0wbqxj9tRJE3/N9
 tKBQ2SBKPDGyHTirdQzBtW0zhT19y+A+QpnCG4cJhFqchiO5lAjn60UOXKJA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 02 Apr 2025 14:02:30 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2647

The DFU was set to run at the beginning, but we may want to
boot something over USB, MMC or Ethernet even if booted over
USB, so move the DFU as the final fallback.

This keeps the current Amlogic U-Boot CI working and makes
the default config more generic.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/configs/meson64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index f3275b37a516da6befd41324ddb2a3fe1f36fc83..675df623311f361f3a55971c3894ffbe1d07fee6 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -118,13 +118,13 @@
 #ifndef BOOT_TARGET_DEVICES
 #define BOOT_TARGET_DEVICES(func) \
 	func(ROMUSB, romusb, na)  \
-	func(USB_DFU, usbdfu, na)  \
 	BOOT_TARGET_MMC(func) \
 	BOOT_TARGET_DEVICES_USB(func) \
 	BOOT_TARGET_NVME(func) \
 	BOOT_TARGET_SCSI(func) \
 	BOOT_TARGET_PXE(func) \
-	BOOT_TARGET_DHCP(func)
+	BOOT_TARGET_DHCP(func) \
+	func(USB_DFU, usbdfu, na)
 #endif
 
 #define BOOTM_SIZE		__stringify(0x1700000)

---
base-commit: c17f03a7e93dfbbe5d32f5738274187065d9493f
change-id: 20250402-u-boot-meson64-move-dfu-end-eb9f5fe55608

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


