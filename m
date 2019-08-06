Received: by mail-wr1-f68.google.com with SMTP id r1so88341018wrl.7
        for <u-boot-amlogic@groups.io>; Tue, 06 Aug 2019 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SrVJPSVmJ8RBdn6+eR/X3fFxbY+g7iqT90bsSB9lKjA=;
        b=h/k/TPbQs0MDS1c51bD0XWiCdgWuV3NpX8/TZ9OoVORYCMog/+YaVq/+oubKZAMX4x
         CMyzKcrE5B2kXsiFC2kHN4yhd7akLnadkYbR+D1eaZby8CZDx2ulF1bYbgeAMZIRqdvu
         t3x2mBihJTiXEqmWFVehIxFCxsDHtt7YygPE4I0P1X6+P80kYo6kiSL4yAu4TDSYQcsM
         i/zKEnn5Cfp+yP2ubSi8EmrVAVh6tz5dphZ8seQt5lyvR6saH/nZG5U5MONDKztQQq3a
         3Toqf2GRJM57buV/k2PYgHpr2GCtW0dUd7d9eJdTgKdy5MLZVAy54HEnU/Mxu4vXMbU/
         Gehg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 3/7] arm: meson: add sm cmd to retrieve SoC serial
Date: Tue,  6 Aug 2019 17:43:15 +0200
Message-Id: <20190806154319.10505-4-narmstrong@baylibre.com>
In-Reply-To: <20190806154319.10505-1-narmstrong@baylibre.com>
References: <20190806154319.10505-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jbrunet@baylibre.com, glaroque@baylibre.com, khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Secure Monitor offers multiple services, like returning the
SoC unique serial number, already used to generate an unique MAC
address.

This adds a new, Amlogic specific, "sm" cmd with a "serial" subcommand
to write the SoC unique serial to memory.

This "cm" command will be extended in further patches.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/sm.c | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index 05b7f0bdf2..99fa17d9a8 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -77,3 +77,51 @@ int meson_sm_get_serial(void *buffer, size_t size)
 
 	return 0;
 }
+
+static int do_sm_serial(cmd_tbl_t *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	ulong address;
+	int ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	address = simple_strtoul(argv[1], NULL, 0);
+
+	ret = meson_sm_get_serial((void *)address, SM_CHIP_ID_SIZE);
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+static cmd_tbl_t cmd_sm_sub[] = {
+	U_BOOT_CMD_MKENT(serial, 2, 1, do_sm_serial, "", ""),
+};
+
+static int do_sm(cmd_tbl_t *cmdtp, int flag, int argc,
+		 char *const argv[])
+{
+	cmd_tbl_t *c;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	/* Strip off leading 'sm' command argument */
+	argc--;
+	argv++;
+
+	c = find_cmd_tbl(argv[0], &cmd_sm_sub[0], ARRAY_SIZE(cmd_sm_sub));
+
+	if (c)
+		return c->cmd(cmdtp, flag, argc, argv);
+	else
+		return CMD_RET_USAGE;
+}
+
+U_BOOT_CMD(
+	sm, 5, 0, do_sm,
+	"Secure Monitor Control",
+	"serial <address> - read chip unique id to memory address"
+);
-- 
2.22.0

