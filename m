Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web10.10165.1611654674973450219
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Jan 2021 01:51:15 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210126095112euoutp0280d35bbc8aeacb018a807f7557062fcf~dv2LYipfl3202732027euoutp02D
	for <u-boot-amlogic@groups.io>; Tue, 26 Jan 2021 09:51:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210126095112euoutp0280d35bbc8aeacb018a807f7557062fcf~dv2LYipfl3202732027euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1611654672;
	bh=uorCwXOMIezDRs8xJlJ1ODAOP7QSWfnCRowti/qHHig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSew2hhNNUmt6xqdKnE46qIVrdwrMU3/8h7tC0Nm1Myp+/vnGWWvfV6kYbWWyAnIb
	 WmdJz3KLvtncudCofDJiWuJVzYS5Fmzx9N78yXFu3TU/RzGkhuG3XSQtkX5pI+G2Lk
	 HJSPiRjIL/oLeAiIi2pOxXna5L5ep1XS2QRjW8B4=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 1/4] dt-bindings: input: adc-keys bindings documentation
Date: Tue, 26 Jan 2021 10:50:33 +0100
Message-Id: <20210126095036.6429-2-m.szyprowski@samsung.com>
In-Reply-To: <20210126095036.6429-1-m.szyprowski@samsung.com>
References: <20210126095036.6429-1-m.szyprowski@samsung.com>
	<CGME20210126095112eucas1p2d9c00a9d509ac482a08dca1cf35b22de@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Dump adc-keys bindings documentation from Linux kernel source tree from
commit 698dc0cf9447 ("dt-bindings: input: adc-keys: clarify
description").

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 doc/device-tree-bindings/input/adc-keys.txt | 67 +++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 doc/device-tree-bindings/input/adc-keys.txt

diff --git a/doc/device-tree-bindings/input/adc-keys.txt b/doc/device-tree-bindings/input/adc-keys.txt
new file mode 100644
index 0000000000..6c8be6a9ac
--- /dev/null
+++ b/doc/device-tree-bindings/input/adc-keys.txt
@@ -0,0 +1,67 @@
+ADC attached resistor ladder buttons
+------------------------------------
+
+Required properties:
+ - compatible: "adc-keys"
+ - io-channels: Phandle to an ADC channel
+ - io-channel-names = "buttons";
+ - keyup-threshold-microvolt: Voltage above or equal to which all the keys are
+			      considered up.
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
+	- press-threshold-microvolt: voltage above or equal to which this key is
+				     considered pressed.
+
+No two values of press-threshold-microvolt may be the same.
+All values of press-threshold-microvolt must be less than
+keyup-threshold-microvolt.
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
+
++--------------------------------+------------------------+
+| 2.000.000 <= value             | no key pressed         |
++--------------------------------+------------------------+
+| 1.500.000 <= value < 2.000.000 | KEY_VOLUMEUP pressed   |
++--------------------------------+------------------------+
+| 1.000.000 <= value < 1.500.000 | KEY_VOLUMEDOWN pressed |
++--------------------------------+------------------------+
+|   500.000 <= value < 1.000.000 | KEY_ENTER pressed      |
++--------------------------------+------------------------+
+|              value <   500.000 | no key pressed         |
++--------------------------------+------------------------+
-- 
2.17.1

