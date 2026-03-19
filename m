Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BFC109319D
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 09:16:26 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6474.1773954231163946108
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Mar 2026 14:03:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=bmLIGal5;
 spf=pass (domain: linaro.org, ip: 209.85.208.48, mailfrom: casey.connolly@linaro.org)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-668d9dba217so300274a12.3
        for <u-boot-amlogic@groups.io>; Thu, 19 Mar 2026 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773954229; x=1774559029; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ta7Tj8NqXyER4Q7mkz0A0OEdacbDVtJaec0R0jQ3J34=;
        b=bmLIGal5WEYEcrW6L11TYGs8MiG0YnkQzoWHLj019oX1lHhK8hrXoe396YN+7XKJdd
         n1Z3av0mwCJlPQmmRNklWl1pyUuA0fuWyGq7QrhzFpfsnY0kCLtQ9XXdTbDRmRsDgflv
         5+d0dYG6pn4RyVGDx2PTlM37rnAbzyWEc0ouYQKOVstUW2ovYdRaBugbejDb/GRde0OI
         GfdBzQb95xmZXQcrB8m+vnD2HVb1ENhO6xt9IXgpFfvrLaMzic/2HrxaRM3a69QRMsZL
         RmE7W5YLM0CbhSerAANs8WnIPqM0SFVdG6QErH9Bw9PPEtal1cWoUP1hv4tkiMzChQrc
         XjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773954229; x=1774559029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ta7Tj8NqXyER4Q7mkz0A0OEdacbDVtJaec0R0jQ3J34=;
        b=DzxpzGKO7ZJ7LDo32TTXsPQff0EMs9ApZS3IXAwPPR3fGlrjXU/1vwlQ5OUaSIMwKD
         GY+FjpSKn2KV2n7aTKmud51l2/31VjsYdMhKX1rwxrp+rNchhb71LtOki8OLVBNG78XR
         o66E44EDQBjwWtHPfUbH0cppwMRRHunTWWIWzcjfIwQrTHa4umA9YkbGdNehNZv4/Tyu
         8hswO7HD3WilH8IV4mdHvK2zIdfPlgUM3oHWyxNdNLWUUivXef7EaoYCpn9yN2xH9FaD
         iXcrPTPknTQZOLSWaA6Fp3rLjVc+BOFey1u2PvJnjzr5QG7368L5bQADww5j3pd/EpN6
         O1sg==
X-Forwarded-Encrypted: i=1; AJvYcCXOM0O4rSqKJooSeDoNvwjwAjNVn8y34qzShyzESW1i8JjfETk43LknsBhIbC/8zPY6et5cSED/bNA/BIgT0g==@groups.io
X-Gm-Message-State: AOJu0YxJhK2wbSvYncHljU1T58/pxKFvOv7N9x/4oXFsx19zd6kf/lPM
	ObcWpKoxoQ/sDPUJ9pcPIDpj34pUl9K3ZRWk9QqyQjMRf5S7ONDFyTgvkjRO324kSfdIxOxEX+4
	apLokQhk=
X-Gm-Gg: ATEYQzweHlr5IDPdIfGmLO1T+SZxPQH1g/9EHP+3qmW4RZS6iHA6gSdK8ZmXYHipZPp
	3Y2looZT3dLwWy2vBVKFxub2PrQrB+7YQ6YiXnvJBSbz/h4NSAl+ji4QjMCC/IBgPZMyChbhEWw
	cfIiCmdN396sCs0Yyoz35kanDzhvZNxqnMhyslg4uhKJeRsa+uUkw4TwaCHNfifW84M4zOmxzh8
	wL7wJQ8fRpKheEv8sAvzuZ9klCnJqxGeLHZaVSsS8uUPUujm/B6VmL5y6D0vBTLyJBYyCrOkzGQ
	73d7pP6bIZrnuUVJD8ld1rWMFaOof3NfD4kXTqOc+rpObNDTae1CSmCH+QcAyFmU9xgijuFS2Vv
	SM4JXnLd2SMRlic7Mt/4Y6z7MALbBLaIb8khdAom+TUchfZ8oJeDI3DAvoVSPd0mln1h8JIGte9
	XcFMg5aybLdKzC0lh7BheCXcYgE5qrWd+Js5UhBXFyeQWGj+bglBbknL+Cut83fWBL8vZbj4RnL
	gK+1g==
X-Received: by 2002:a05:600c:1d15:b0:485:2ce2:4c75 with SMTP id 5b1f17b1804b1-486febbc648mr7851015e9.1.1773953853998;
        Thu, 19 Mar 2026 13:57:33 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de. [79.195.221.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:57:33 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:32 +0100
Subject: [PATCH RFC 10/40] compat: add linux/regmap.h symlink
MIME-Version: 1.0
Message-Id: <20260319-casey-ccf-upstream-v1-10-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=517;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=NdKEp6PPPnqzQwS5HXhBfSnvR7crR5H9OW0VElgSIaM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yXzROgpafHf79v4zv5Bw8Z/S98/5VzOC7rQUPXAvL
 tp+6te0jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCR0w8YGToquDZ/PDqRe45c
 AKvO4XWncx7y55c7eKxw/XLu2TPus/wM/2M2SzBK1mvPUpByT2089qHwyc2WT2s05rTJMzNrF/+
 9FQ0A
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Mar 2026 09:16:26 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2926

Add a symlink to the Linux regmap.h path so that drivers ported from
Linux don't all need additional changes to include the U-Boot specific
path.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/linux/regmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
new file mode 120000
index 000000000000..8a3780b5cebd
--- /dev/null
+++ b/include/linux/regmap.h
@@ -0,0 +1 @@
+../regmap.h
\ No newline at end of file

-- 
2.51.0


