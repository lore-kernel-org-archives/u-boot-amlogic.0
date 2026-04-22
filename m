Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396C2F9B5E5
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 08:49:11 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.76438.1776847742689239807
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 01:49:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=r0/M+q6i;
 spf=pass (domain: linaro.org, ip: 209.85.128.43, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso30766355e9.2
        for <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776847741; x=1777452541; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dAQM9W7MIYTk8loJB6VBHwgqVK0O5C+QfLuZ6li2CUI=;
        b=r0/M+q6iazslAKAdMSugpfXBUxofygh4CJsKtrxLtvyNOgKVKhpNsSPiqEy8i2SQet
         Qa+LApQisze6vI0l+uejmyLDdWhc7x8x/fZ7yon02nJCYvQupgAY2PsbKOtxmn60aVYA
         g/ECjjHPSmQu1LSHk4sGHgfA1yHj1Rz/0wZZ8e/Bfcq67MTj0+qZIPzleOS6QZ+IjRda
         pGvs0TloLaBi1KhK1pM+f0DUKMcVxP9iVLFdyXrnzGRpdkTSgUmc4Iypl5LuHKCA75Bq
         Ysohc92OrkQFwVQYVlg/XrQEQTSRkHRd60MdgOdnGpITC8Ke7NAKCC2EsDgohQTjxByI
         sxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776847741; x=1777452541;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAQM9W7MIYTk8loJB6VBHwgqVK0O5C+QfLuZ6li2CUI=;
        b=Jx5QsWqqelFnnwp1oNXGj6ulzcaMl9IVjJN4cfUJJv0VUC0+J4KtakP99J5o6Pn4RF
         AnRIeuOLufNc7ZfGM5WCn8g/8FoBDn4oj/4Mtl8uV2bgKSOBSNeBZwv6e2HchsMkI1ys
         Ok8smB7VmVYQ+S0bmBPnPyN4XxMl7fku4CWyd5Wn0NCuEJ8vVsjO44nYzDd6mGkm9MUf
         wBvq1dPKxqwBG0BemdqAeTuvCRS1GcuGibKR2TB1TbqUsfCnVH5B4ZDPe8Lg0LNZj1p2
         o6FJzAdHoJ7YHLoU+K3jy5eMIjirpNFa+nrBD+4KOY4MO3K5HrtyIVfzyVm0wNx5CaDZ
         5o3g==
X-Gm-Message-State: AOJu0YweeSzUoCWGrZsgDH4zgm5BivTsucc5qYhqDgIFdxhuiFWDSfhE
	YDjHOPPGiP1CzS0+pPLCsEZ9b4+/Qo5HFeUNYh5BhJpaMsdFNr865B+1T/PERUH9W9rpP/Tfn6t
	QogxgGpo=
X-Gm-Gg: AeBDieu7fOlqSvdQAg4yocwbZGnG243GTNZQw019ze4EXFVEz3zod1WcnQ7SYiMhQT5
	Le2/HU/iU0ghCavL2v5VtMK3axISAb5sqs8W9Sa4tFdLCWOTY4OUgzvk6wQQFxXcih7lKCp3q/v
	QKn8f3JCjnwIe+8LLoN7t28iLNdMuknd8qmyayLdJvZ6nd9rZVkIdgzAmHsLQ3harq+fhzbhbX0
	F0wYNrtea9+dtunzhHlnSzfrwBDWpFvpobBsw1mvdGCiabBQGljkOVxrdPm5n9PE+AepwqHYa+X
	/RetPWhCNBrwOpjJ4i20eLj48KuRTcLlf7eo6Y/9qlzwbpenrp1MSd+rTg9OZsJj7IWTkjW/nM2
	fbAks+zKuNDVQsjCpprQXhoe/hBJnD+mHBPNnje8oppP9+8rp78nsSEyJSKaWf2xjsb1VoCYqLh
	CLsDuGaPwUVoZRA1w3jQlDoVPbAOMAXR0/c72DLoW5bmVyRUQanA5AkqxEzorpuviaRA==
X-Received: by 2002:a05:600c:5297:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-488fb74a431mr350427545e9.8.1776847740911;
        Wed, 22 Apr 2026 01:49:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm211755165e9.1.2026.04.22.01.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:49:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 22 Apr 2026 10:48:58 +0200
Subject: [PATCH] clk: meson: do not fail when setting SD_EMMC_x_CLK0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-u-boot-amlogic-test-v1-1-b5790d3c04e0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHmL6GkC/yXMQQqDMBBA0avIrB2IQVLSq4gLE8d0SjWSiSKId
 29sl2/x/wlCiUngWZ2QaGfhuBQ0dQX+NSyBkMdi0Eob1WqNG7oYMw7zJwb2mEkyGjeaZjIP662
 CUq6JJj5+167/Wzb3Jp/vFVzXF5tQyhh3AAAA
X-Change-ID: 20260422-u-boot-amlogic-test-6bd61f679c90
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xV2a21hKp5VhpsmUrUee1s0gQeQIm3eaRsuWK/Q6bcM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp6It7lAy8JvM6kUYnXtUOwT8UkXgyeSXmUPb2+oga
 4Pi2PCuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaeiLewAKCRB33NvayMhJ0StQD/
 4vNa51gCs5StNa3oWuFA6JhdanyO/mKCan8OzJ/OpbHzTsCZEj/6ufhYkC8EUM1U9w4haO8HKLQHpw
 WxkjQF5l+JzEtWGEHqTiplkINCuKKXYqt33puzItjHMnWVHAUbjEVHhRmrDU8VSu1edQc04B8Y/SH+
 rELAKwElOxEHfUPgVT5bdZwkaJh/lEed/n2RaLNKSFEaExi1e4+gb9cpsuTAD9KXK+OMY3+izDpVxc
 1Yrt/jOD4QZypwkAzjNneUvn6TwkinWRO1S3CP0Ot/+IwoUbxcf1qydfz5LSNGtWW3SrWhsDB8HfGY
 ZVcYmk98b3CMO1RBg3bcXUJ83kSRrlNBtNMx3jn4wAtCd7QT52uSIeDvF0V7chMvfq49tWnozFSc4+
 SIpLsS/bCpBlOt2zVSsioKN04L2cr0mvyA3pyhKitltMgHRAoS0Ge5/DUp0DBdS2JOnEiGd2CBUVDu
 L2/uJINu/AGnGlHXlamnxfmMuyz0WMGhwpJA2Z9dI/trUyldLbR0ipj183eq/jTiKU4IUuQHBnmxm7
 RDTObq+Q07zP7TY5fb/L4qtPvS/+YDWHeXzl5Z5svPMgXiQ2JoXi91AkIvL+eGZsyBvCcgletSZ8no
 o4TQ0sBZFDTe436iUrOHlCuaJW45MEKiRprl9SO/q7ZyktIx1YwrJrf6+9bg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 08:49:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2966

Since Linux v7.0, the MMC controllers has the following properties:
  assigned-clocks = <&clkc CLKID_SD_EMMC_x_CLK0>;
  assigned-clock-rates = <24000000>;
Which causes mmc controllers to fail in probe.

Make sure we do not fail until we properly implement rate setup.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/g12a.c | 5 +++++
 drivers/clk/meson/gxbb.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index a7a42b2edb6..f33938e1419 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -946,6 +946,11 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 	case CLKID_HDMI:
 		return meson_clk_set_rate_by_id(clk, CLKID_HDMI_DIV,
 						rate, current_rate);
+	case CLKID_SD_EMMC_A_CLK0:
+	case CLKID_SD_EMMC_B_CLK0:
+	case CLKID_SD_EMMC_C_CLK0:
+		/* TOFIX: implement rate set for MMC clocks */
+		return 0;
 	default:
 		return -ENOENT;
 	}
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 218be45c2cb..bf46f4d50bc 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -900,6 +900,11 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 	case CLKID_HDMI:
 		return meson_clk_set_rate_by_id(clk, CLKID_HDMI_DIV,
 						rate, current_rate);
+	case CLKID_SD_EMMC_A_CLK0:
+	case CLKID_SD_EMMC_B_CLK0:
+	case CLKID_SD_EMMC_C_CLK0:
+		/* TOFIX: implement rate set for MMC clocks */
+		return 0;
 	default:
 		return -ENOENT;
 	}

---
base-commit: 052988aa29bfd506d7ce207fbb3f5374a5dbecbb
change-id: 20260422-u-boot-amlogic-test-6bd61f679c90

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>


