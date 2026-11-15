Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1867.1794715080067551525
 for <u-boot-amlogic@groups.io>;
 Sat, 14 Nov 2026 19:58:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20260515 header.b=g8NzVqqI;
 spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: devnull+iav.iav.lv@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BD125612A4;
	Sun, 15 Nov 2026 03:50:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794714634;
	b=Ld6IoGn83Zz7zD5ryZ+Xbg+UXI3A1xqERgWR8oqIfPojvtbGv6JixhxtKSZq7X4ecEzC
	 Wx8yBc4xYhFjgrbEdhosrTyg0XWmB9KCI5TwXjQs71Yc0XeLHgT+4ra7eJGmBTiEsmm/D
	 baxFuj7IMLGkeJXEKUhiMkCH5aFgPRFGNaIgbUp903Jfq/1jq0zIT0Tw10uhm+8uvs+/M
	 u0wRXOFDTV+DT72bVkAtKxEVYg0TxbbvLoavgOJnC7mf/g+UeMH8nEh8LKpmseEo2BlGH
	 aQZP47sle3Me6TE8ZfKOmxgG1edhV7Q6c+Op6T14oafKzIwqD9XNEukqhpsB0kuAUBw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794714634;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5qk9tDHzol00P5yMID0ol1PmjZ9dxwhS0CNKDUDwj0o=;
	b=H4LqvaAQ+XRWTe5DtoRpxbO6viP6PPWfXX38vozTsfpnfICOOQ1eqInDkkWQDvLPUtxz
	 pVdty70jeNJGdKezcRLiXe2/h2qarUy4a49D4Ps2ElnXjlur3xnCqYya9o5XaVUocFVlT
	 pNUqb7jab8UmP22tRtrBSI+EAjNVhwlZyfeuDAA5Fi4t8ls5f/QCG0qN08FkwYtT6I5P0
	 60zu08IlqB5OS0gVSDVJbSQ7Mwr8pAOyfThr21egrTaKYcjf6Y6uWiG6wtGGl1k01v8HZ
	 BZDOLpKyQAw3Z7aTaWAgf1z0UE5TvZd1cSnBWGJfLsjGm920J6c+gRp0okix7SBG/bA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E6CDD1F000C6;
	Sun, 15 Nov 2026 03:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794714634;
	bh=5qk9tDHzol00P5yMID0ol1PmjZ9dxwhS0CNKDUDwj0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=g8NzVqqIXoN/RrL/HzPa85k3KD5ZICyQZykfTvQQr0OJx6/AR/9zKD+7ZWzd/W7iN
	 dqAVRSqq2i7d9bnct0qx5oBaxrcUZEJG5+De6HjpcBu+hOR9Jb9DvkqyI9oyWt2NoK
	 aiCcdqzjxoEGd9lAGBOhGadDgqj49T2K/39+V4o+OlRbtO8DroVTbWuxD5zc4b2esn
	 AnZx8s1wUODaSgUFhyAbfelyfNln296iy1da18cCjASNSAA45mMFes3LIcaeev+1Lf
	 ZwwY6OdtX1yGZHFE4tEmjJtxiQ8dUzZIhqHhkSTCcbocGh6IL5Zub+K5d8jXU8tRnD
	 2JDMzI1oa5HlQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7543B49F5D;
	Sun, 15 Nov 2026 03:50:33 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sun, 15 Nov 2026 03:50:31 +0000
Subject: [PATCH 2/3] board: amlogic: odroid-n2: tell BL301 whether to wake on LAN
MIME-Version: 1.0
Message-Id: <20261115-b4-meson-scp-wol-v1-2-80c3e9f4deda@iav.lv>
References: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
In-Reply-To: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=3fdHEF8KsKvIXWDttHsUdkfsf3IxMKZP/SPsXxR+yF8=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFk/ddgrvZ5c3qqfNlXL84eRfNaWsMXqt990WF07sLU07
 LGV1m+djlIWBjEuBlkxRZYJhzRuZSy5+tffw/wBzBxWJpAhDFycAjAR+WJGhpdMOzQ+TuTJeit5
 O2bTveeTveS/r3a5lbHh5PGCaTppW1gY/scLaTJNu7s/Wun6xicHl7P9cVnl8yF2Wpnsj2pL+2U
 XKxgA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Wed, 25 Nov 2026 12:52:09 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3154

From: Igor Velkov <iav@iav.lv>

Unless SCPI client 7 has been set to a non-zero value, the Hardkernel
BL301 for ODROID-C4/HC4 switches VCCK_B and the 3.3 V rail off in
suspend and does not add the PHY interrupt (GPIOZ_14) to its wake
sources.

With CONFIG_MESON_G12A_SCPI, send 1 when the Ethernet PHY in the device
tree passed to the OS has wakeup-source, and 0 otherwise. BL301 keeps
the last value, so it is sent on every fixup and the last fixup before
the OS starts wins.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 board/amlogic/odroid-n2/odroid-n2.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
index ae953d0e4ba..94aaa6ca9ad 100644
--- a/board/amlogic/odroid-n2/odroid-n2.c
+++ b/board/amlogic/odroid-n2/odroid-n2.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <adc.h>
 #include <env.h>
+#include <fdtdec.h>
 #include <init.h>
 #include <net.h>
 #include <asm/io.h>
@@ -14,6 +15,7 @@
 #include <asm/arch/sm.h>
 #include <asm/arch/eth.h>
 #include <asm/arch/boot.h>
+#include <asm/arch/scpi.h>
 
 #define EFUSE_MAC_OFFSET	20
 #define EFUSE_MAC_SIZE		12
@@ -24,6 +26,9 @@
 #define MESON_SOC_ID_G12B	0x29
 #define MESON_SOC_ID_SM1	0x2b
 
+/* Hardkernel BL301 client: 1 = stay powered in suspend and wake on the PHY */
+#define SCPI_CL_WOL		7
+
 int mmc_get_env_dev(void)
 {
 	if (meson_get_boot_device() == BOOT_DEVICE_EMMC)
@@ -138,3 +143,29 @@ int misc_init_r(void)
 	odroid_detect_variant();
 	return 0;
 }
+
+/*
+ * BL301 keeps the last value sent, so we send one on every fixup: the last
+ * fixup before the OS starts wins.
+ */
+int meson_ft_board_setup(void *blob, struct bd_info *bd)
+{
+	bool wol = false;
+	int node, phy, ret;
+
+	if (!IS_ENABLED(CONFIG_MESON_G12A_SCPI))
+		return 0;
+
+	node = fdt_node_offset_by_compatible(blob, -1,
+					     "amlogic,meson-g12a-dwmac");
+	if (node >= 0 && fdtdec_get_is_enabled(blob, node)) {
+		phy = fdtdec_lookup_phandle(blob, node, "phy-handle");
+		wol = phy >= 0 && fdtdec_get_bool(blob, phy, "wakeup-source");
+	}
+
+	ret = meson_scpi_set_usr_data(SCPI_CL_WOL, wol);
+	if (ret)
+		printf("SCP: setting Wake-on-LAN to %d failed: %d\n", wol, ret);
+
+	return 0;
+}

-- 
2.43.0


