Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E87B10F997D
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 20:30:38 +0000 (UTC)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.116012.1775680229205824134
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Apr 2026 13:30:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=X+sW+MkX;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.178, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1775680225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOuZz7lvQndsIyML4zQVJ7hX8vwExcnhjD2pWkXMGLI=;
	b=X+sW+MkX1/nTFI9ea57Ua4MNzQr+0Br7azfy1LbRBvZlxrusZ4oZU2mhl+vgaoBDRQgXX3
	P6zL2jCg6pKwavx8EDKOZBjfR06+NNiIr8e58hXwOB/1HqEYQNa9PGWCn72EWOmpJKjY+y
	Fv8HJkz40ZDWj+v0u0Mz0JSFsDfEOmscn/tGlzve1AaFuc0vuO7dnv5Xcd0/4uhEqIFXLa
	MQQO8KKN8N8yaKhALYINZ6wGLQJ/omIO2xgDY2F/LJNmTj/4ZRJYVk6MuCg7Es3+I8SwEc
	ZhPe0RQi4ZV3aaRIx3dovdOZdGOExcCzelQkvpfJIISpJvLj/k2YreKxBcZ4fg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Apr 2026 20:30:14 +0000
Subject: [PATCH 3/4] configs: libretech-ac_defconfig: enable EFI Capsule on
 Disk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-b4-amlogic-sysreset-capsules-v1-3-6f3386eb5124@postmarketos.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=771;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=lsFAb6WIU7UkZswT3Jl47z04z/J3OIDZgcTSN4HJH+0=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp1rrbSrCcFAV0YaVQlBgRtE6P0w3VtTtd3YJVH
 nMKV/J9leeJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCada62wAKCRCEr8vQ14ma
 AyrYEACEGSjRzeSVas4JjmoTsEe0KV6w6Ln1yiAsxmKFzrT7noVxs0sr8sbJB0kfOZMkZ2eVtwY
 cuzGlNkj5yDpO6ytNS2Q0SkPUKfo9Y5fC7SUm0LUYNfVQ/mB1or4bGQtxbuqrnR0C//MeCNxVGE
 DJUJAEJ0Jctd1FQnxdaXHfojvQ2xB2vQwbqKvL7/svTwVr9typRuY8pCpGxIm/Xqs9xsCqW6Dhf
 oYnEp2PVnZPOY8YYyxsTu7BkWA4y8UbFXDK2EM1TDFxXqq5ztY2m7mhHLygyVBliSZnMwouZTuk
 WhOkQ2Od6R0/wEyzTKRA242R95tClhNNwA+qOM0Q6BWKvm3Ed9ieOn46u19L+7nnuoInqO7d/NQ
 l7gQk6lWd5xECEjJ/sjXy+VGw5lkvtC+TSo1MuQKk2aEJ/6ON+boQ5JWb5qG2wa/RrDoAIHv8ZM
 oy+OJIRjC6e8g8/STntuh93pt4IDgJfx3SExiXawkFDM7ebYk8vx0kh4XuqupXyO9vBDJriQb5F
 suUy/3efYcBhEOmDo+2uVAb6itK9bRcuiJvUTIeOyqSkLw6Sp3T0YApiDqUWDO4BjnO7LNEUDk7
 jPsgUVEAr5w3bZL0cXJePKWYlNQNJZbu6s28z/zHcLU8OwO+M77e8N1daF4TtOEP/++N0j92nN0
 ARiJnFYrnMMb1lA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Apr 2026 20:30:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2956

Everything is already in place for EFI capsule updates, so enabling
Capsule on Disk is fairly trivial. This allows updating U-Boot on SPI
flash from Linux using fwupd's Capsule support.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 configs/libretech-ac_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 1a67ca734b8..17d54655017 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -23,6 +23,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y

-- 
2.53.0


