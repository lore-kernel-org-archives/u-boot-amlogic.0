Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D4BC77B7C
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 08:51:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.web10.1394.1750091007170325236
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Jun 2025 09:23:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=nYP/ZzKH;
 spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: devnull+forbidden405.outlook.com@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1F2EA629C7;
	Mon, 16 Jun 2025 16:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3DB6C4CEF0;
	Mon, 16 Jun 2025 16:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750091005;
	bh=/vG90dHfi1h9BoDnWkDkrBE9RQ4qrezquV5ho656kFc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nYP/ZzKHCG0PGLU9nR4ZOuAmXRWBnbygyL9Djc0gEHimTJ65vu5cJFWOux+xaCski
	 ylaymqpi8mDGHJY7jKePmx9m1DFJsk0DWP8nBPBZVFvdANhXANbBDecH6sdJ98mpDU
	 KACCl4ZbVW0ksUql+0Q85U09JnYPO+R5D1VFlLE8xE/pCzgXqjN5iGlmyhK72XrTOh
	 zLPbvqeQZIM2hv1wjewlj8x8v5q0e5fyYACvv/PNM2yEUa9+rZEemrGzJmkv7ZmFU9
	 B6K0lKfvYh5msIHBOcbvLVZqBHnACFwn86tUyJuj/Cv7iNORY+8tgjNqILkjbyrilg
	 A85bxOeE/zUPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E25C71159;
	Mon, 16 Jun 2025 16:23:25 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 17 Jun 2025 00:23:25 +0800
Subject: [PATCH] pinctrl: meson: support gpio toggle command
MIME-Version: 1.0
Message-Id: <20250617-meson_ppinctrl-v1-1-593aa15f288a@outlook.com>
X-B4-Tracking: v=1; b=H4sIAPxEUGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0Nz3dzU4vy8+IKCzLzkkqIcXVNDY8vkRAOzJAsjCyWgpoKi1LTMCrC
 B0bG1tQAbBW7dYAAAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750091005; l=1668;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=0tgA8LIJQgOLFGBN5dqiTZa7VCU/mclDvr6myN+Iw9E=;
 b=9JNasCTwImUq3/mgCKjD83jCPDU5fSry/Od/09oEtn+5umgI4CvkoztaWe4i06qk/11xezifO
 gtxuCsl/2G1D5z/+PsfzAvUh2UtFwU5zgYnNVUD2sFb2H3zLkZYqKY4
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: forbidden405@outlook.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Jun 2025 08:51:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2718

From: Yang Xiwen <forbidden405@outlook.com>

meson_gpio_get() always assumes gpio is configured to input mode. This
is incorrect and breaks `gpio toggle` command:

gpio: pin aobus-banks2 (gpio 2) value is 0
   Warning: value of pin is still 1

Fix it by adding the logic to handle both input and output mode.

Fixes: 2009a8d03fe5 ("pinctrl: meson: add GPIO support")
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index babf1bccc969..a1f4afd11f94 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -117,8 +117,27 @@ int meson_gpio_get(struct udevice *dev, unsigned int offset)
 	struct meson_pinctrl *priv = dev_get_priv(dev->parent);
 	unsigned int reg, bit;
 	int ret;
+	enum gpio_func_t direction;
+	enum meson_reg_type reg_type;
 
-	ret = meson_gpio_calc_reg_and_bit(dev->parent, offset, REG_IN, &reg,
+	direction = meson_gpio_get_direction(dev, offset);
+
+	switch (direction) {
+	case GPIOF_INPUT:
+		reg_type = REG_IN;
+		break;
+
+	case GPIOF_OUTPUT:
+		reg_type = REG_OUT;
+		break;
+
+	default:
+		reg_type = REG_IN;
+		dev_warn(dev, "Failed to get current direction of Pin %u\n", offset);
+		break;
+	}
+
+	ret = meson_gpio_calc_reg_and_bit(dev->parent, offset, reg_type, &reg,
 					  &bit);
 	if (ret)
 		return ret;

---
base-commit: c5afa1fef49f55146e78d6157470520391c40eca
change-id: 20250617-meson_ppinctrl-5139ca06b828

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>



