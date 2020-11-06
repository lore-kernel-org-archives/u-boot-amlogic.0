Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web09.9952.1604658075123885733
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 02:21:15 -0800
Received: by mail-wr1-f66.google.com with SMTP id x7so741704wrl.3
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 02:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5tIzDVttp2fG4+nSL8CxyVprVyKaWLZCvSajnoT46Mw=;
        b=achW33Vxnw8sA/nzMXbiFFwXHHff+Gcfsn6Sp0/JroJZy3ZUruqmqdEHjPgp3Qxz/6
         QIkH8zpMQHMtky/eqBxp3sQOK5vBoHFfW1MUbilSwHrTL0r/cjeFbAEgfLeUB3/kT7dn
         JWjSQJ3O1/n1wQSMSUZJpye8Eq8dNbTwdd2mx6oVr2LK5V3ocOvvtGcco09ipAjjNFBJ
         gzKky2nb5+N1KKDlfc3UcZq8PKzpPz2rotkewWrf9mhMeZwD2pMrgm7cMGPRQpiam09d
         Ufvsbygv8FcagTM9GxUEqBiAMVwVdbnlEg23ws5LPe95Sie+iHRClGTttAe46T/mWzIH
         HsvA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/4] power: domain: meson-ee-pwrc: add support for the Meson AXG SoCs
Date: Fri,  6 Nov 2020 11:19:00 +0100
Message-Id: <20201106101901.2472557-4-narmstrong@baylibre.com>
In-Reply-To: <20201106101901.2472557-1-narmstrong@baylibre.com>
References: <20201106101901.2472557-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

This syncs with the linux meson-ee-pwrc driver from Linux 5.10-rc1.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/power/domain/meson-ee-pwrc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/power/domain/meson-ee-pwrc.c b/drivers/power/domain/meson-ee-pwrc.c
index dfedddd950..fa1ee93837 100644
--- a/drivers/power/domain/meson-ee-pwrc.c
+++ b/drivers/power/domain/meson-ee-pwrc.c
@@ -13,6 +13,7 @@
 #include <syscon.h>
 #include <reset.h>
 #include <clk.h>
+#include <dt-bindings/power/meson-axg-power.h>
 #include <dt-bindings/power/meson-g12a-power.h>
 #include <dt-bindings/power/meson-gxbb-power.h>
 #include <dt-bindings/power/meson-sm1-power.h>
@@ -127,6 +128,11 @@ static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_vpu[] = {
 	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
 };
 
+static struct meson_ee_pwrc_mem_domain axg_pwrc_mem_vpu[] = {
+	VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
+	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
+};
+
 static struct meson_ee_pwrc_mem_domain gxbb_pwrc_mem_vpu[] = {
 	VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
 	VPU_MEMPD(HHI_VPU_MEM_PD_REG1),
@@ -166,6 +172,10 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_ge2d[] = {
 	{ HHI_MEM_PD_REG0, GENMASK(25, 18) },
 };
 
+static struct meson_ee_pwrc_mem_domain axg_pwrc_mem_audio[] = {
+	{ HHI_MEM_PD_REG0, GENMASK(5, 4) },
+};
+
 static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
 	{ HHI_MEM_PD_REG0, GENMASK(5, 4) },
 	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(1, 0) },
@@ -213,6 +223,13 @@ static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
 	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", g12a_pwrc_mem_eth),
 };
 
+static struct meson_ee_pwrc_domain_desc axg_pwrc_domains[] = {
+	[PWRC_AXG_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, axg_pwrc_mem_vpu,
+			pwrc_ee_get_power, 5, 2),
+	[PWRC_AXG_ETHERNET_MEM_ID] = MEM_PD("ETH", g12a_pwrc_mem_eth),
+	[PWRC_AXG_AUDIO_ID] = MEM_PD("AUDIO", axg_pwrc_mem_audio),
+};
+
 static struct meson_ee_pwrc_domain_desc gxbb_pwrc_domains[] = {
 	[PWRC_GXBB_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, gxbb_pwrc_mem_vpu,
 			pwrc_ee_get_power, 12, 2),
@@ -382,6 +399,11 @@ static struct meson_ee_pwrc_domain_data meson_ee_g12a_pwrc_data = {
 	.domains = g12a_pwrc_domains,
 };
 
+static struct meson_ee_pwrc_domain_data meson_ee_axg_pwrc_data = {
+	.count = ARRAY_SIZE(axg_pwrc_domains),
+	.domains = axg_pwrc_domains,
+};
+
 static struct meson_ee_pwrc_domain_data meson_ee_gxbb_pwrc_data = {
 	.count = ARRAY_SIZE(gxbb_pwrc_domains),
 	.domains = gxbb_pwrc_domains,
@@ -401,6 +423,10 @@ static const struct udevice_id meson_ee_pwrc_ids[] = {
 		.compatible = "amlogic,meson-gxbb-pwrc",
 		.data = (unsigned long)&meson_ee_gxbb_pwrc_data,
 	},
+	{
+		.compatible = "amlogic,meson-axg-pwrc",
+		.data = (unsigned long)&meson_ee_axg_pwrc_data,
+	},
 	{
 		.compatible = "amlogic,meson-sm1-pwrc",
 		.data = (unsigned long)&meson_ee_sm1_pwrc_data,
-- 
2.25.1

