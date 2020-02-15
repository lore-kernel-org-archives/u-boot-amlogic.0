Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by mx.groups.io with SMTP id smtpd.web09.3568.1581797463177435383
 for <u-boot-amlogic@groups.io>;
 Sat, 15 Feb 2020 12:11:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1581797460;
	bh=3ZSHKE8HHFuWQeJ/twbxy9jWMlLTMQcc7y4pWVq2IOE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=QQPTDbI05IaFKAPHLgFFPkkD9vmT4FI8mg4uEMLcAmM2KdI70cI6hZLIkSwfWTnQD
	 spxhD8kqDCvZBd/TggskI69+gz8R2mHjlKO/DAwkV2bPWXtTZXCW/Uf6emZIVmT2bi
	 tv942UffcJ67E4I2x2Ma1h2vpYxkaxMGJGuc7wFk=
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] clk: meson-g12a: missing break
Date: Sat, 15 Feb 2020 21:10:54 +0100
Message-Id: <20200215201054.5139-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Lukasz Majewski <lukma@denx.de>
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
List-ID: <u-boot-amlogic@groups.io>

Add missing break for CLKID_PCIE_PLL in switch statement.

Reported by CppCheck.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Fixes: 08e09c263fdf ("clk: meson-g12a: Add PCIE PLL support")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
Looking at the code it seems obvious that something is wrong in commit
08e09c263fdf but I have no board for testing.
=2D--

 drivers/clk/meson/g12a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 686d94ebfe..cada80e6b5 100644
=2D-- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -804,6 +804,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk,=
 unsigned long id)
 		break;
 	case CLKID_PCIE_PLL:
 		rate =3D meson_pcie_pll_get_rate(clk);
+		break;
 	case CLKID_VPU_0:
 		rate =3D meson_div_get_rate(clk, CLKID_VPU_0_DIV);
 		break;
=2D-
2.25.0

