Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web10.9411.1608627401526644684
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Dec 2020 00:56:42 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201222085639euoutp027abe5746279450697c54e94a1f561398~S-hjVy76n0056600566euoutp02j
	for <u-boot-amlogic@groups.io>; Tue, 22 Dec 2020 08:56:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201222085639euoutp027abe5746279450697c54e94a1f561398~S-hjVy76n0056600566euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608627399;
	bh=o3oRQgy84pGZQHmcfx24s54l/T55xXFJm08YfQYT5x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKEpKMPsaDsL2NOFv7phlcN0dReb3q+YvsYSBxF2vJA3GNmqAgMN+ySfvf38n1nsf
	 1mP48laUmBihpeia8s9PgPRUw2rjTHSmZ8hmrOdjm2CCQPW2kXuDxk2SbOGtLADtQ2
	 ONzwXitl//Dme2ImEjKaNIlMATffvBWnZ5BiFpsE=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 1/3] dt-bindings: input: adc-keys bindings documentation
Date: Tue, 22 Dec 2020 09:56:31 +0100
Message-Id: <20201222085633.10194-2-m.szyprowski@samsung.com>
In-Reply-To: <20201222085633.10194-1-m.szyprowski@samsung.com>
References: <20201222085633.10194-1-m.szyprowski@samsung.com>
	<CGME20201222085638eucas1p14d9d9da136593a12fea0140c403095c4@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Dump adc-keys bindings documentation from Linux kernel source tree v5.10.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 doc/device-tree-bindings/input/adc-keys.txt | 49 +++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 doc/device-tree-bindings/input/adc-keys.txt

diff --git a/doc/device-tree-bindings/input/adc-keys.txt b/doc/device-tree-bindings/input/adc-keys.txt
new file mode 100644
index 0000000000..e551814629
--- /dev/null
+++ b/doc/device-tree-bindings/input/adc-keys.txt
@@ -0,0 +1,49 @@
+ADC attached resistor ladder buttons
+------------------------------------
+
+Required properties:
+ - compatible: "adc-keys"
+ - io-channels: Phandle to an ADC channel
+ - io-channel-names = "buttons";
+ - keyup-threshold-microvolt: Voltage at which all the keys are considered up.
+
+Optional properties:
+	- poll-interval: Poll interval time in milliseconds
+	- autorepeat: Boolean, Enable auto repeat feature of Linux input
+	  subsystem.
+
+Each button (key) is represented as a sub-node of "adc-keys":
+
+Required subnode-properties:
+	- label: Descriptive name of the key.
+	- linux,code: Keycode to emit.
+	- press-threshold-microvolt: Voltage ADC input when this key is pressed.
+
+Example:
+
+#include <dt-bindings/input/input.h>
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&lradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <2000000>;
+
+		button-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			press-threshold-microvolt = <1500000>;
+		};
+
+		button-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			press-threshold-microvolt = <1000000>;
+		};
+
+		button-enter {
+			label = "Enter";
+			linux,code = <KEY_ENTER>;
+			press-threshold-microvolt = <500000>;
+		};
+	};
-- 
2.17.1

