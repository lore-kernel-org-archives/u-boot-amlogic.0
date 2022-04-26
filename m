Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web08.2736.1650950810897545213
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Apr 2022 22:26:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650950806; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding; bh=wT4Gzs8xMr0XMPX0myXKxHVvmKTg/ZR5qDesQ/DhUeQ=;
	b=AoDayJnfRGtJUctg5tPyA4+HIeUFPshovWEFXHC7cN4VXRucs64Y50rnHNHiezKN472ZRE
	+PT/SrDD1iaLznWTeLKaxYopkCEfxZmM8cfVxc6fpSqbfraq5DzRtqiSyyU1VwkONmjOpb
	XmGlxDxjDJSC3Ea4kIWF9zcnfjsw8Bj/i6nZtZDYwl/mbFXYFVhISNE8q/VtU5fQQASd+8
	qYnr+ObJZqWdsZC2pgqFZyZGJav5ZXgz3o/Ae2gMb6o8mr3MGHB5YoNrPEk5jjP9KzK++V
	Kb48/FuvB8IEG5E0dmQ1ipYTNJxA8WqpsAWFmUH1nfcdMS14HAdGC4hF4m8ihQ==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH 1/2] doc: boards: amlogic: update documentation for ADC support for AXG
Date: Tue, 26 Apr 2022 08:26:32 +0300
Message-Id: <20220426052633.3027932-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 doc/board/amlogic/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 9ef1440433..9c7fadf2c0 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -55,7 +55,7 @@ This matrix concerns the actual source code version.
 +-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
 | NAND                          | No        | No              | No      =
     | No          | No         | No          | No           |
 +-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
-| ADC                           | **Yes**   | **Yes**         | **Yes** =
     | No          | No         | No          | No           |
+| ADC                           | **Yes**   | **Yes**         | **Yes** =
     | **Yes**     | No         | No          | No           |
 +-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
 | CVBS Output                   | **Yes**   | **Yes**         | **Yes** =
     | *N/A*       | **Yes**    | **Yes**     | **Yes**      |
 +-------------------------------+-----------+-----------------+---------=
-----+-------------+------------+-------------+--------------+
--=20
2.30.2

