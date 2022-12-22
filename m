Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web11.42259.1671701649015455995
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Dec 2022 01:34:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1671701645; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=VfJOgX52TLintvQiezAmeOI3OOXXGI2pt5oOXWcEESE=;
	b=DR3vFZeGMHfrOlA3+bkAMM8OkNjnUF0+d6m4S0Rih2T5vJ4VPCGctsuj0YvpPHZ7VctHwq
	LkPemEtapgN0EFSRdY/00fCk7/s0xPes5xbQLXviy6YzT3B/DQWpHJFxGTGAl/nyPdri+R
	0t6RViqb9V4v7XN4bIDQ3qxAT0hk8hi/ANmfxFblYFbV7ZgLCTPKvYiZEKBQ17Q5nZt9y+
	yU/VJXOlybsWYkm2iFryJSu/ewzF7lElTETsMEoAFq4wYf1lF7LagqHrv7eFUQzTX3FWLr
	oCxN+nMMjBnzgX6Ju+ihesUA0IbYkhrmF0N+If5JN7YVMQGuQGVTcbE9P2YViA==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH] board: amlogic: jethub j100: add rescue boot from microSD
Date: Thu, 22 Dec 2022 12:33:58 +0300
Message-Id: <20221222093358.204520-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Viacheslav Bocharov <adeep@lexina.in>
List-ID: <u-boot-amlogic@groups.io>

From: Viacheslav Bocharov <adeep@lexina.in>

The new JetHub D1+ has a microSD slot. Add rescue boot from microSD

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 include/configs/jethub.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/jethub.h b/include/configs/jethub.h
index 35f85095ac..e22db4991d 100644
--- a/include/configs/jethub.h
+++ b/include/configs/jethub.h
@@ -12,6 +12,7 @@
 #define BOOTENV_DEV_RESCUE(devtypeu, devtypel, instance) \
 	"bootcmd_rescue=3D" \
 		"if gpio input 10; then " \
+		"run bootcmd_mmc0; " \
 		"run bootcmd_usb0;" \
 		"fi;\0"
 #else
--=20
2.34.1

