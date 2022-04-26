Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web11.2747.1650950832951448152
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Apr 2022 22:27:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650950830; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=sSBaDMwHhydAYG3P+twpVDnxs//ASAm1iVY4iP+db+0=;
	b=c1uP3tEYUEso9S0V4vCusU6qCPIci7LV279fsMJQPqyzTojMsALZbiLlOufGkBVnhDGmUO
	xDp3WJAuQxGk3G/7E6nY0zdwc7UpcPPa0h3gPFHmsgO03o1wp4RGpVZ8c27LqGmL7XDkU7
	8ndP5BxSyHHMe2GARM3FCo3iRmwza4vo0y+5ZfyGS2YoNxqBGL978QNoDoMr8BwYbfjTS9
	MoRElytEHcqpUYihBmQJnaphUymrFqecXd0IvpBxzu7nrgwgJkmRGOOFmksEg7WHef5Ek6
	kVrLgqs84GhFPsC1aNvEBNVNVS3e21mRLtrnwRTFy6Ngyjz6L98cO99wAnSpDQ==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH 2/2] doc: boards: amlogic: update jethub d1 specifications
Date: Tue, 26 Apr 2022 08:26:33 +0300
Message-Id: <20220426052633.3027932-2-adeep@lexina.in>
In-Reply-To: <20220426052633.3027932-1-adeep@lexina.in>
References: <20220426052633.3027932-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 doc/board/amlogic/jethub-j100.rst | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub=
-j100.rst
index d54519aaef..8081569bba 100644
--- a/doc/board/amlogic/jethub-j100.rst
+++ b/doc/board/amlogic/jethub-j100.rst
@@ -3,27 +3,31 @@
 U-Boot for JetHub J100
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation
-controller manufactured by JetHome with the following specifications:
+JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a series of home=20
+automation controller manufactured by JetHome with the following=20
+specifications:
=20
  - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
  - no video out
- - 512Mb/1GB DDR3
- - 8/16GB eMMC flash
+ - 512MB/1GB DDR3 or 2GB DDR4 SDRAM
+ - 8/16/32GB eMMC flash
  - 1 x USB 2.0
  - 1 x 10/100Mbps ethernet
- - WiFi / Bluetooth AMPAK AP6255 (Broadcom BCM43455) IEEE
-   802.11a/b/g/n/ac, Bluetooth 4.2.
- - TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output
-   power and Zigbee 3.0 support.
+ - WiFi / Bluetooth one from:
+   - AMPAK AP6255 (Broadcom BCM43455) IEEE 802.11a/b/g/n/ac, Bluetooth 4=
.2
+   - RTL8822CS IEEE 802.11a/b/g/n/ac, Bluetooth 5.0
+   - Amlogic W155S1 WiFi5 IEEE 802.11a/b/g/n/ac, Bluetooth 5.2
  - 2 x gpio LEDS
  - GPIO user Button
+ - DC source with a voltage of 9 to 56 V / Passive POE
+ - DIN Rail Mounting case
+Basic version also has:
+ - TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output
+   power and Zigbee 3.0 support.
  - 1 x 1-Wire
  - 2 x RS-485
  - 4 x dry contact digital GPIO inputs
  - 3 x relay GPIO outputs
- - DC source with a voltage of 9 to 56 V / Passive POE
- - DIN Rail Mounting case
=20
 U-Boot compilation
 ------------------
--=20
2.30.2

