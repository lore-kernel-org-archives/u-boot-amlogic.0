Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [91.207.212.93])
 by mx.groups.io with SMTP id smtpd.web12.1322.1593790628702240771
 for <u-boot-amlogic@groups.io>;
 Fri, 03 Jul 2020 08:37:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=0yiwjy2iBqQaZyObcGaxND/wd2pRuBbUwDIYk5pFWrI=;
 b=U2SVJVLYJohnBXHeEiwLdKaNrEVWYv0SUSa5hcivPAzVFH4HOCeHBGp8FBr3xPWjOAN8
 3gfIQC+teuKdWIACXO2IuNH1HQWkYdJWQZlySLfZ7V8Qi8AR3SZ0IExApDVtQpCIpN4x
 /cyXW6h9OZ3OrHjdKl3nSPFWbZpmpyWF3jloL1H+BFh/ezV3yCEB1Nx2XD2VLWTT9GFO
 4oAby7Q6B5LwDMR7cx/1ML8r+HM3M8XaSk+gcYLgqrswwJ4CcK81HRsg61/YUdKYuCjM
 Ih4ylXIg5RYdD9saU4Yaw4e7W+NL2LwMjvl/GPWxevdOmLhDaDAzhBmGOo6O3mXObfN8 IQ== 
From: Patrick Delaunay <patrick.delaunay@st.com>
Subject: [PATCH v3 7/7] arm: meson: change trace level for phy errors managed by uclass
Date: Fri, 3 Jul 2020 17:36:46 +0200
Message-ID: <20200703153646.28533-8-patrick.delaunay@st.com>
In-Reply-To: <20200703153646.28533-1-patrick.delaunay@st.com>
References: <20200703153646.28533-1-patrick.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrick Delaunay <patrick.delaunay@st.com>, Neil Armstrong <narmstrong@baylibre.com>, Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io, U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
List-ID: <u-boot-amlogic@groups.io>

As the error message is now displayed by generic phy functions,
the pr_err can be change to pr_debug.

Signed-off-by: Patrick Delaunay <patrick.delaunay@st.com>
---

Changes in v3:
- add update for mach-meson board-gx: new generic_phy API usage

 arch/arm/mach-meson/board-gx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
index c4cc11f1de..b4fde46fcb 100644
--- a/arch/arm/mach-meson/board-gx.c
+++ b/arch/arm/mach-meson/board-gx.c
@@ -196,8 +196,8 @@ int board_usb_init(int index, enum usb_init_type init)
 	for (i = 0; i < 2; i++) {
 		ret = generic_phy_init(&usb_phys[i]);
 		if (ret) {
-			pr_err("Can't init USB PHY%d for %s\n",
-			       i, ofnode_get_name(dwc2_node));
+			pr_debug("Can't init USB PHY%d for %s\n",
+				 i, ofnode_get_name(dwc2_node));
 			return ret;
 		}
 	}
@@ -205,8 +205,8 @@ int board_usb_init(int index, enum usb_init_type init)
 	for (i = 0; i < 2; i++) {
 		ret = generic_phy_power_on(&usb_phys[i]);
 		if (ret) {
-			pr_err("Can't power USB PHY%d for %s\n",
-			       i, ofnode_get_name(dwc2_node));
+			pr_debug("Can't power USB PHY%d for %s\n",
+				 i, ofnode_get_name(dwc2_node));
 			return ret;
 		}
 	}
-- 
2.17.1

