Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by mx.groups.io with SMTP id smtpd.web11.102770.1680617542587228338
 for <u-boot-amlogic@groups.io>;
 Tue, 04 Apr 2023 07:12:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1680617540;
	bh=WKHlMbHD1NwpB39cuiK3pQB/0tx/FiFlKbe3sOTJdmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPBYiw3ughIy3xKzkwuzAun16+23gQocX14wX+Y91xFKkXOB3+K3CKudNzG9Y8OKw
	 QyLruw67Y1zx0Zr7MbhlRfpkUMtbrYjMXkv3rUQ0QS6Jvenr5ReJrJB7VDm74vvF39
	 ZSa2LJDSeS8JQmKNJnU4lRb9T1uhXwuljlq5JUEhf70/tYn1OBB2QexiqhhOe2Xb0S
	 L2oucgUmv5Lrdo6fVVhcgEMMYKJPFqYsHlJVvayoLildp3yoFvRd1JPHPrUtcZEPrF
	 3B/F/9JocHQZsD+pvzzIo4r3PbH65SwJbstFCh009FNziRsdEhoR/F4bG0a/FYie5p
	 DxP/9zlLmer7A==
From: Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v4 2/5] configs: rockchip: rock5b-rk3588: enable USB and regulators
Date: Tue,  4 Apr 2023 17:11:52 +0300
Message-Id: <20230404141155.283987-2-eugen.hristev@collabora.com>
In-Reply-To: <20230404141155.283987-1-eugen.hristev@collabora.com>
References: <20230404141155.283987-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, kever.yang@rock-chips.com, neil.armstrong@linaro.org, jagan@edgeble.ai, jonas@kwiboo.se, xdrudis@tinet.cat, anarsoul@gmail.com, Eugen Hristev <eugen.hristev@collabora.com>
List-ID: <u-boot-amlogic@groups.io>

Enable USB command, USB drivers, PHY and regulators, for USB host
operations.

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 configs/rock5b-rk3588_defconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defc=
onfig
index f3026c7ea166..8d76c1eb4d42 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -41,7 +41,9 @@ CONFIG_SPL_STACK_R=3Dy
 CONFIG_SPL_ATF=3Dy
 CONFIG_CMD_GPT=3Dy
 CONFIG_CMD_MMC=3Dy
+CONFIG_CMD_USB=3Dy
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=3Dy
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=3Dy
 CONFIG_OF_LIVE=3Dy
@@ -61,7 +63,9 @@ CONFIG_MMC_SDHCI_SDMA=3Dy
 CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
 CONFIG_ETH_DESIGNWARE=3Dy
 CONFIG_GMAC_ROCKCHIP=3Dy
+CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
 CONFIG_REGULATOR_PWM=3Dy
+CONFIG_DM_REGULATOR_FIXED=3Dy
 CONFIG_PWM_ROCKCHIP=3Dy
 CONFIG_SPL_RAM=3Dy
 CONFIG_BAUDRATE=3D1500000
@@ -69,4 +73,17 @@ CONFIG_DEBUG_UART_SHIFT=3D2
 CONFIG_DEBUG_UART_ANNOUNCE=3Dy
 CONFIG_SYSRESET=3Dy
 # CONFIG_BINMAN_FDT is not set
+CONFIG_USB=3Dy
+CONFIG_USB_EHCI_HCD=3Dy
+CONFIG_USB_EHCI_GENERIC=3Dy
+CONFIG_USB_OHCI_HCD=3Dy
+CONFIG_USB_OHCI_GENERIC=3Dy
+CONFIG_USB_HOST_ETHER=3Dy
+CONFIG_USB_ETHER_ASIX=3Dy
+CONFIG_USB_ETHER_ASIX88179=3Dy
+CONFIG_USB_ETHER_LAN75XX=3Dy
+CONFIG_USB_ETHER_LAN78XX=3Dy
+CONFIG_USB_ETHER_MCS7830=3Dy
+CONFIG_USB_ETHER_RTL8152=3Dy
+CONFIG_USB_ETHER_SMSC95XX=3Dy
 CONFIG_ERRNO_STR=3Dy
--=20
2.34.1

