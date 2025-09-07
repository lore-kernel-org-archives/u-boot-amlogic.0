Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD80CAC585
	for <webhook@archiver.kernel.org>; Sun,  7 Sep 2025 14:36:39 +0000 (UTC)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
 by mx.groups.io with SMTP id smtpd.web10.19822.1757255794633060903
 for <u-boot-amlogic@groups.io>;
 Sun, 07 Sep 2025 07:36:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=oax/M4WR;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.181, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757255793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H3oZR+Pte6SydUPb4c/XmU6pUzaBpYwUXhyuYUynkwU=;
	b=oax/M4WRF3xj8LdXWkd3JGGwLJBjFxchXu90Z7ZQj50MsLRcWCHP9OhEq77tlWu+RluGZI
	0inwvltPrGcj5PT06OXqhDYpGdoEhooH6W+hbIr9UafPNELFUuFzka459G5p4y6aQN8pB7
	yFmovbMeY6qzhRKUsXdzDj9PEa8/zoSSSjTMsYnpjZQghlIRBE0/Rv0rgMaF6d0/F6t3UE
	Pv1TowLRftzC++9N1ogV62yQdwd7lx5ERkBDyrjbOx5vRm2nW7fMiRsRRb7MjtcKPPft9R
	oA6RJ5Zo0E9LHZf4mLvStDTJfdmL7jzR/jvFe2ZitmO6DRPY53O21jf+SV/CJQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Sun, 07 Sep 2025 14:36:09 +0000
Subject: [PATCH RFC 3/9] mmc: meson_gx_mmc: don't bail if there is no clock
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20250907-spl-gx-v1-3-37395d9ff5af@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
In-Reply-To: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=ZAqe53vXbc3r6mJD0G2dDahAiGeTIuetSy5hg5sR3mU=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBovZhq8VwigyBR9Ev9X8AlUNcsjmEUGY7e1Zim+
 QdeespNyEGJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaL2YagAKCRCEr8vQ14ma
 Aw1OD/9IKwmcD91DICwg9lxqBYmjEcxSsir0PbygQTeVXWtAcwrotzqakDOPglKSYBA8P5IUtSl
 oKvhGXHO+3hquxDCgUJqSJ3WCWhRKlRWz8JvCuGYXFXeqE2lCiA7h8G+ilen2ELJ1wRjd3+WQnj
 4vk8K/IUCjTCB4gEmt48a4uH1UEv1piVK6CJXhh3NVr0p85ZQ+QvV99pIbqM7bj52sEtSMFrSUr
 G5DsmCtVt5XFDcqt6w7mNdZXKL+o8n1ASIsZeUHCio7YMGtQquyb36ZD6Kb8xMH6VIe56ERi3n6
 Ix/NfkeV8AIgvymYqfpheqM/arGzuKTyqrxlFFBvqFgu2oRhxyN3veUhtIEVEWzQCKjXxqJa9oQ
 t/t2MaU49bgPKJNi6I7gYYhnYAev4bJjOpoijpeIMx2aAWs+b3keJhr4RCteEwDHS1nIGRUjmCX
 3uMoey9GzmImyuiVH+DPzwgrAHTT8ltes7rIqNUtMYfUlJarcR1j4kHnBsasrOzZi8hoftCjpkE
 6qE3/7lLfQWNhBpBPL+6tOKQamadVbQ8CcsfsxIKXFMuCse9KZvZNSMsedAC6qQp75oCNwC6UHm
 zPH01IifQLNBZs7CW4RXyDfMQFQx+Vrvj9FHvb8u5ITuWNZq8/Qcaw8eRDRJX9LWhdan4toGCvh
 0i0O8UmTxD6/vmQ==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 07 Sep 2025 14:36:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2746

The clock driver is too big for U-Boot SPL at the moment.  In the
meantime, continue mmc init even if it is not present.

Signed-off-by: Ferass El=C2=A0Hafidi <funderscore@postmarketos.org>
---
 drivers/mmc/meson_gx_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index a4338f1e29c1da07acb0333be9b75a318cba1334..d83a79fa0894fc6a32c40642e=
bce5f845120efaf 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -332,11 +332,11 @@ static int meson_mmc_probe(struct udevice *dev)
=20
 	/* Enable the clocks feeding the MMC controller */
 	ret =3D clk_get_bulk(dev, &clocks);
-	if (ret)
+	if (ret && ret !=3D -ENOSYS)
 		return ret;
=20
 	ret =3D clk_enable_bulk(&clocks);
-	if (ret)
+	if (ret && ret !=3D -ENOSYS)
 		return ret;
=20
 	cfg->voltages =3D MMC_VDD_33_34 | MMC_VDD_32_33 |

--=20
2.51.0


