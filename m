Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1934.1794715107285431897
 for <u-boot-amlogic@groups.io>;
 Sat, 14 Nov 2026 19:58:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20260515 header.b=NFJi9MAD;
 spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: devnull+iav.iav.lv@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3528D43E50;
	Sun, 15 Nov 2026 03:50:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794714635;
	b=ucjNnZO5DSauf44uAXCWA9gbnozUpozH41ARBV8FA16+wPsDbsml626cIQwRtFfL7WME
	 MIyqDQEdmenCMHRqbj7+KmZmQ4aNimnWufInwMSWX3yLE+BT64+uzSf2TW9TdMzDSd1fP
	 pZwZGwPZRqIG9L304F6UjWfDwpeO//Xchcy4XBVg+Xdlhdimu3Eg3uvSDKGFsBiaXZImo
	 viDpaWEyfuszvn3UJAQGBHzGb011ZrWyaownuSz0e/i8jA9y0ZBMvCHjcYDWMhIP7Gz5U
	 UAnczL50TdB/ohfPweX5upH4eyF5gaaLi5R+KKbJwSg5x7Vu7sT42Gwm+rQ/K6ghVGw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794714635;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/os7nt/UzbSihdCul5QdcXZqGl8vTtLAgCfB3B5yknY=;
	b=nZlIW4Tft1h5TfGg+zQ0bmn2bkszBiMe5tzmYtnt7QTFhT9HJb9YcfRW1SRKX2VJD0gy
	 eDXf4r/hRrP6UOq1t7jfyVfgitonGKo6W+HXJM+u/0kojtNXmPJz8XUTnpTQ8Ao9Cr9lD
	 jqsuVgSKHGdqbEPqPiyKI7NYS6hrKg1FUMVgUyRISPzd7nLQb28EbrEGfWWqkfL2V5w2C
	 F0gkgoCEQN40fCgM7zEsZSaRx5/ARIeB9JMx7sy6/MCYRBl7P44n0BYq/otUIYq3nRV2v
	 qDtUpbCb7jup1I4jiaC/Pv9os5dNcP0pZqHfRSNFLVy3XqKxPyd7x5uh+YyPBEEaz+w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D1FBA1F000C5;
	Sun, 15 Nov 2026 03:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794714635;
	bh=/os7nt/UzbSihdCul5QdcXZqGl8vTtLAgCfB3B5yknY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NFJi9MADD4vuqctFNWr1t4LxYKe6b8/P1bZqDp0ufZgouZF8J12DY+zLAiVsSxHgF
	 CTeVet8SMrTGmPQYXhBw50oxFjvSZYKcwTkDx/pGKcNTO4Jh/zydlsCAqzaU4aWp8T
	 a2PC0KP/5PiBnEnGUtj3lcpb0DCrMVCWZBI7sLKKgGkz+LNefW3WjrI51H9usckII/
	 QzLdzMKq7xiWHu7DbL7mWZRRS+a+lo/ykC107XmIRelSs6Gz2lOfpUS0BPw9cFzm8U
	 tcwKxAKyLN3Fbq44SbOITJn/UDFsc+3hBQShLS9fFLgv+94yhrA/+5UVIdalKp3czU
	 1kkP8SVgih6zA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5E56349F30;
	Sun, 15 Nov 2026 03:50:33 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sun, 15 Nov 2026 03:50:30 +0000
Subject: [PATCH 1/3] arm: meson: g12a: send SCPI user data to the SCP firmware
MIME-Version: 1.0
Message-Id: <20261115-b4-meson-scp-wol-v1-1-80c3e9f4deda@iav.lv>
References: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
In-Reply-To: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4345; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=2Gdr08FRW63F0qHBRAEK5BDd5GdXqVBzC6URzhNj9gE=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFk/ddhf8qVUxUz+8v1sh5CgHffPsxnzMzN4VbRZy5luL
 86QO3qvo5SFQYyLQVZMkWXCIY1bGUuu/vX3MH8AM4eVCWQIAxenAExE/QbDP4PIiWp9125OZehk
 fHUx/W/sDreykphZf/zcb5715k5cHsTIcGl1PrPm8Y78NWsz/m20LL9x79z/K5svLuiTq7rvsO1
 wNQcA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Wed, 25 Nov 2026 12:52:10 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3157

From: Igor Velkov <iav@iav.lv>

The BL30 firmware on G12A boards takes settings from the AP through
the SCPI SET_USR_DATA command on the MHU mailbox. Mainline Linux does
not send this command, so U-Boot has to, before it starts the OS.

Add meson_scpi_set_usr_data(), which sends the command on the
low-priority channel and waits for the reply with a timeout.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 arch/arm/include/asm/arch-meson/scpi.h | 17 +++++++++++
 arch/arm/mach-meson/Kconfig            |  9 ++++++
 arch/arm/mach-meson/Makefile           |  1 +
 arch/arm/mach-meson/scpi-g12a.c        | 55 ++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/arch/arm/include/asm/arch-meson/scpi.h b/arch/arm/include/asm/arch-meson/scpi.h
new file mode 100644
index 00000000000..5e9eef1974e
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/scpi.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __MESON_SCPI_H__
+#define __MESON_SCPI_H__
+
+#include <linux/types.h>
+
+/**
+ * meson_scpi_set_usr_data - send SCPI_CMD_SET_USR_DATA to the SCP firmware
+ *
+ * @client: SCPI client id; its meaning is defined by the BL30 firmware
+ * @val: value for the client
+ * Return: 0 once the SCP has replied, -ETIMEDOUT otherwise
+ */
+int meson_scpi_set_usr_data(u8 client, u32 val);
+
+#endif /* __MESON_SCPI_H__ */
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 91d1e8342e0..cf98f4941d9 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -76,6 +76,15 @@ config MESON_S4
 
 endchoice
 
+config MESON_G12A_SCPI
+	bool "Send SCPI messages to the SCP firmware"
+	depends on MESON_G12A
+	help
+	  Send SCPI messages to the BL30 firmware running on the SCP over
+	  the MHU mailbox. Boards use them to pass settings to their BL30
+	  build before starting the OS. If the firmware does not reply, each
+	  message adds up to 200 ms to the boot.
+
 config SYS_SOC
 	default "meson"
 
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 2157c35c2d5..ff9effbbc9e 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -16,5 +16,6 @@ endif
 
 obj-$(CONFIG_MESON_AXG) += board-axg.o
 obj-$(CONFIG_MESON_G12A) += board-g12a.o
+obj-$(CONFIG_MESON_G12A_SCPI) += scpi-g12a.o
 obj-$(CONFIG_MESON_A1) += board-a1.o
 obj-$(CONFIG_MESON_S4) += board-s4.o
diff --git a/arch/arm/mach-meson/scpi-g12a.c b/arch/arm/mach-meson/scpi-g12a.c
new file mode 100644
index 00000000000..ba66167fec0
--- /dev/null
+++ b/arch/arm/mach-meson/scpi-g12a.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SCPI messages to the G12A SCP firmware (BL30) over the MHU mailbox
+ */
+
+#include <errno.h>
+#include <asm/io.h>
+#include <asm/arch/g12a.h>
+#include <asm/arch/scpi.h>
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
+
+/* Low-priority MHU channel: AP to SCP on SET/STAT/CLR_4, replies on _1 */
+#define G12A_MHU_SCP_STAT	(G12A_HIU_BASE + 0x414)
+#define G12A_MHU_SCP_CLR	(G12A_HIU_BASE + 0x418)
+#define G12A_MHU_AP_SET		(G12A_HIU_BASE + 0x434)
+#define G12A_MHU_AP_STAT	(G12A_HIU_BASE + 0x438)
+#define G12A_MHU_AP_CLR		(G12A_HIU_BASE + 0x43c)
+
+/* AP to SCP low-priority payload in the shared SRAM */
+#define G12A_MHU_AP_PAYLOAD	0xfffe7200
+
+#define SCPI_CMD_ID		GENMASK(7, 0)
+#define SCPI_CMD_CLIENT		GENMASK(15, 8)
+#define SCPI_CMD_SIZE		GENMASK(28, 20)
+
+#define SCPI_CMD_SET_USR_DATA	0x20
+
+#define SCPI_TIMEOUT_US		100000
+
+int meson_scpi_set_usr_data(u8 client, u32 val)
+{
+	u32 reg;
+	int ret;
+
+	/* Drop a reply that came late for a request that timed out */
+	writel(~0, G12A_MHU_SCP_CLR);
+	writel(~0, G12A_MHU_AP_CLR);
+	writel(val, G12A_MHU_AP_PAYLOAD);
+	writel(FIELD_PREP(SCPI_CMD_ID, SCPI_CMD_SET_USR_DATA) |
+	       FIELD_PREP(SCPI_CMD_CLIENT, client) |
+	       FIELD_PREP(SCPI_CMD_SIZE, sizeof(val)), G12A_MHU_AP_SET);
+
+	ret = readl_poll_timeout(G12A_MHU_AP_STAT, reg, !reg, SCPI_TIMEOUT_US);
+	if (ret) {
+		/* Do not leave a stale request for the SCP to pick up later */
+		writel(~0, G12A_MHU_AP_CLR);
+		return ret;
+	}
+
+	ret = readl_poll_timeout(G12A_MHU_SCP_STAT, reg, reg, SCPI_TIMEOUT_US);
+	writel(~0, G12A_MHU_SCP_CLR);
+
+	return ret;
+}

-- 
2.43.0


