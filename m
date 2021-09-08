Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.10623.1631104339924884951
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Sep 2021 05:32:20 -0700
Received: by mail-wm1-f45.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so1397964wms.4
        for <u-boot-amlogic@groups.io>; Wed, 08 Sep 2021 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkGSXCNIYfCVQ8amCl9paK4c51GF6SIppItIlMLMHzg=;
        b=Zx1wvWDG+Ib4GGvK+1FsfMxaaYonNQ5KXF/NbTY7FYwM2SlXoxdeuQHQ2VAzM6BmeB
         uEWPfcOFSWlQXfZz1A2dECMhXHvDOHDspDohTsN9c4cW3xslX1AEtBvzPZdbYv1E0FEZ
         i3H3ymO78Nh/LUeB2M4kCTM3lB4Y68R0gEvHtpdi6NSbpFUFWjs4PBaC3T95WqdFkQO1
         +U/BsCbvVdbigdmDswJGlCF2hXAA8UPJoxyHtKRrtrscKVFRH/GgXowmMSpa26p3MeEe
         EVfEolv2IFEHyk6mI40FFYyYYAUXewGjZVNSu+dEsEhfCzK3yUf+yFydtRpJNTqZpTqX
         UntQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] pci: pcie_dw_meson: fix usb fail when pci link fails to go up
Date: Wed,  8 Sep 2021 14:32:12 +0200
Message-Id: <20210908123212.382716-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; h=from:subject; bh=1MZY+CrwxrvhU7rQuGe/tdF0RLVoBTlWHbtnPKVQRbI=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhOK01fXiJ32d8A9mpXRceXktD5Ki9qtSwSW5P+G5V OiVM1NiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYTitNQAKCRB33NvayMhJ0WsVEA C7Zze4JRF8/DJ4+TtXfeVKXb5O3VlEJ8/c9ufnvcIanf8oMXmcEEFSaChntG5RBX7n3Ni70Sz1sHG3 rem+c3y+MFacbSNcH4wkJ1lYofg8NijxHpEhdEbW8Aku43Twd5ovejDoFIgYQwqjmdkf1YZrji5mrD zoC2gUoQM6OaOH/QKi/sE+IWsLyYH36vkT3PthhfBLO3xtQHXl6AuNv3lVpq4oRdxOSMCM55/JGMzT 9liIKJfByAZRzxmqrKFxSkhyzsBizeD+/IObg3j0/d+e69EmEfYejkKZY3GmCCFbojzekAKRApnQoe Jt9EYpPAKjncyJ4NFP8WMSNhA7PIZ+4c68kj/uU0SrHJ2yWkjVGCxIEkW3ajh0zBTy9OWS9DJo8bxU IOYOJbJDg/6NF4hnzjHQxlWvawEs2aACkZkCtY0JlIOt2Dt5+vaCcPym0wjB5N5zE8Qub0coUsdU1b 8JjiB29sTFitxh4JRmDO0tsxHeIhTgziJUcG9NqaNl49vbH7qOj7YcatTiRWRPlOJ/4MIwiGgCmRIx zHYBSd+OtZiBeXteU40Wjqx0yHrt0ftwVE5sNNNlJck4uRcgC3/fr+mibPUh1h7r1JjfOx5ODYibIs OeVs2p5OrGB/2Yl7KtNGgrQLJNuXWZGXwUKCAg13fKccKoQNbeADyx627rNA==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Art Nikpal <email2tema@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

On Amlogic A311D, when the PCIe link fails disabling the related clocks
makes USB fail. For an unknown reason, this doesn happen on the S905D3 SoC.

Mimic the Linux behavior by not considering a link failure a probe failure,
and continue even if the PCIe link is down.

Reported-by: Art Nikpal <email2tema@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pci/pcie_dw_meson.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/pcie_dw_meson.c b/drivers/pci/pcie_dw_meson.c
index 0525ecbea6..07da9fa533 100644
--- a/drivers/pci/pcie_dw_meson.c
+++ b/drivers/pci/pcie_dw_meson.c
@@ -319,15 +319,9 @@ static int meson_pcie_init_port(struct udevice *dev)
 
 	pcie_dw_setup_host(&priv->dw);
 
-	ret = meson_pcie_link_up(priv, LINK_SPEED_GEN_2);
-	if (ret < 0)
-		goto err_link_up;
+	meson_pcie_link_up(priv, LINK_SPEED_GEN_2);
 
 	return 0;
-err_link_up:
-	clk_disable(&priv->clk_port);
-	clk_disable(&priv->clk_general);
-	clk_disable(&priv->clk_pclk);
 err_deassert_bulk:
 	reset_assert_bulk(&priv->rsts);
 err_power_off_phy:
-- 
2.25.1

