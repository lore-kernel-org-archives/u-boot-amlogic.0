Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD41109319C
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 09:16:26 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6392.1773954159928690571
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Mar 2026 14:02:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=k29X1bCu;
 spf=pass (domain: linaro.org, ip: 209.85.208.170, mailfrom: casey.connolly@linaro.org)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a76ba6a78so7783551fa.0
        for <u-boot-amlogic@groups.io>; Thu, 19 Mar 2026 14:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773954158; x=1774558958; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ySESJfourxrh2m62qey3M/YF6AEV8fxCE1YjUIBwGs=;
        b=k29X1bCu6t/6V8oxyuWWvQQ4oyQp51fFLut4j33aWcUXnmeVAQUaX+SVruUCkfJdUR
         Te1SlHfg8HQayvIqJeB6NHPsWHvD8F8Hi2AJkueuWtBkZ4E8KcbHwBCdYumeW2T6kURQ
         fSo2M3kV5qAMhpicE+Hb35uMrRCV9BJpgxRajh6scrPgFXlUrE3Rjx3+18auVdICZJ+F
         JJL1qix/IySAcDLsMmtZTCzpinYbHCViUJViRt1yde5x2Gtuuj9h6JrrrN8Hf2AApjQ9
         qDcbkB3r4ZKyegC4svjYnCbok48L4hmLvzlduvlpzbSWblMGTJ+3KyNxnbGRO3VsVwoW
         mRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773954158; x=1774558958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4ySESJfourxrh2m62qey3M/YF6AEV8fxCE1YjUIBwGs=;
        b=Gi8CgyO+btv+fMZrCzS8RfbfQmkPEvJrvqn3EDfy0BOuovBgZmFSW2t5h6L+z5JLVx
         1uaG51deYcY0aB2hm6JI6g0DKvrwPBgGrTnnQWCDkmkdIzrMhC0aiU/XJr/PWjH3OKNn
         yco3LqSytF1d5k5FJ074pALeEMUIFtmdLtLxtR9argr759HQCAzc6O+WCtjdKBFB5teS
         qx01K7+SLC5KFFtCCrzAGRG7yhw/Mm5vGIQEgH9iFDqzPnjZ6yqcpUugzY1ziQERFnHB
         NG94noalTinS0T6ipofXm+xlTfnlXfAkj621ya4yUpFn1y/T497FysTZq8uS2mHbJZv0
         1y1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU3dJn/j5U/QXFl5IgvleMAiivf8jVZ+adr6NdCipEYGyQ97uYnKnadgD36giYN3c9DAgTrqtkwVC4YWFZLA==@groups.io
X-Gm-Message-State: AOJu0YzsiDHGvyczhW7Xra8JPlVCWJTUtIKDLFuUN5IRToKJDLuHLiE3
	UgnXgXv8rMM7Bn/S78D+ojAh+sFt5rD2MDRH5k0Gny4dFJZLTSudR5+oW83RgBcboX4zO3Y1og4
	O4vCkj6I=
X-Gm-Gg: ATEYQzyVTdErWAueE+ZUxDQS3e8qp7zcyt/LtJ/6BWf1U/g3i7A3mVjUOvXYgmqvFbz
	WQkMLB9g8/t82o5AvIv9SRYVi91M8YZ2qQqWmk77HR3jAwtaez9plWgN+4Iflu8ssuNA+ChGOh4
	LAJXn7NG2OnZjOjIhZyiheJC4mPVD/YPZ6mScj0mkU6Xgz+daY27q0HeBVJ/GZ8eCpwVfQYjyFI
	8Rkl9WXbbvzRKqBTY1UzGTDzATgZqV4Zip0NGtBKTemY9qiGmCngNopZQTdX2cKZLGR9/dWh3DJ
	q3yPq+jgRd1yDCa9ipjLuXhWtq59tYQ1hW0Tg96RL4KVjiJgMW323GWX/2TvMFAn6bB3tgUBkjb
	e6aTCN1W+xRgfirHTP3bhZ11vTo9LDejSAcpemXYZVYLbq4JqEbp7aCMKOpTtkQyMkdATxjHnpa
	IBr+uLDsj9ABPFfKRBDLVfZb/Pj/tvYz2Mt+5nmJFwJqBFDMzUbz6GZyg4jPT9ZL0bZoI=
X-Received: by 2002:a05:6000:4203:b0:439:d750:42e3 with SMTP id ffacd0b85a97d-43b6427576fmr1301743f8f.25.1773953817871;
        Thu, 19 Mar 2026 13:56:57 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de. [79.195.221.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:56:57 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:23 +0100
Subject: [PATCH RFC 01/40] vsprintf: add %pOF
MIME-Version: 1.0
Message-Id: <20260319-casey-ccf-upstream-v1-1-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 u-boot-qcom@groups.io, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>, 
 linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jens Reidel <adrian@mainlining.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Nishanth Menon <nm@ti.com>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Sam Day <me@samcday.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Shmuel Leib Melamud <smelamud@redhat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=rEJNtXZP5+H5gwqn8qXTXflA9ZA9fkONh6/nGZHH35Y=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9ybyf+o9MPLX7qcBkkZqeKOVH5zuNuUVy7mxfkCHLq
 aksqLK/o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzknB4jw/pH62KlVzw72OBy
 ppHzpZKQaNukswwLpt48M6vh7cfX+T6MDHPYNuwR1ZOyjLJ5dp656cTlRyziG/ffnVTI8J+9yGK
 fvwwA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Mar 2026 09:16:26 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2929

This prints a full ofnode path.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 lib/vsprintf.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c7340a047b2e..49dc9c38c652 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -25,8 +25,13 @@
 #include <linux/err.h>
 #include <linux/types.h>
 #include <linux/string.h>
 
+/* For %pOF */
+#if CONFIG_IS_ENABLED(OF_CONTROL)
+#include <dm/ofnode.h>
+#endif
+
 /* we use this so that we can do without the ctype library */
 #define is_digit(c)	((c) >= '0' && (c) <= '9')
 
 static int skip_atoi(const char **s)
@@ -437,8 +442,32 @@ static char *uuid_string(char *buf, char *end, u8 *addr, int field_width,
 	return string(buf, end, uuid, field_width, precision, flags);
 }
 #endif
 
+#if CONFIG_IS_ENABLED(OF_CONTROL) && !defined(API_BUILD)
+static char *ofnode_string(char *buf, char *end, ofnode *dp, int field_width,
+				int precision, int flags)
+{
+#define NP_PATH_MAX 64
+	char str[NP_PATH_MAX] = { 0 };
+	const char *err = "...";
+
+	/* If dp == NULL output the string '<NULL>' */
+	if (!dp || !ofnode_valid(*dp))
+		return string(buf, end, NULL, field_width, precision, flags);
+
+	/* Get the path and indicate if it got cut off */
+	if (ofnode_get_path(*dp, str, NP_PATH_MAX)) {
+		str[NP_PATH_MAX - 1] = '\0';
+		char *p = str + min((NP_PATH_MAX - 2) - strlen(err), strlen(str));
+		memcpy(p, err, strlen(err) + 1);
+	}
+
+	return string(buf, end, str, field_width, precision, flags);
+#undef NP_PATH_MAX
+}
+#endif
+
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
  * specifiers.
@@ -472,8 +501,16 @@ static char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 #if CONFIG_IS_ENABLED(EFI_DEVICE_PATH_TO_TEXT) && !defined(API_BUILD)
 	case 'D':
 		return device_path_string(buf, end, ptr, field_width,
 					  precision, flags);
+#endif
+/* Device paths only exist in the EFI context. */
+#if CONFIG_IS_ENABLED(OF_CONTROL) && !defined(API_BUILD)
+	case 'O':
+		if (fmt[1] == 'F')
+			return ofnode_string(buf, end, ptr, field_width,
+					  precision, flags);
+		break;
 #endif
 	case 'a':
 		flags |= SPECIAL | ZEROPAD;
 

-- 
2.51.0


