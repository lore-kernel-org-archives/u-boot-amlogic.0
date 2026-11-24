Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8806.1795482367259702200
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Nov 2026 17:06:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=@iav.lv header.s=zoho header.b=A+8MZpPS;
 spf=pass (domain: iav.lv, ip: 136.143.169.17, mailfrom: iav@iav.lv)
ARC-Seal: i=1; a=rsa-sha256; t=1795481454; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XZUDVLZct9IUW71Vkn+PfS2ck7COYA/tSH8i4RmmUBwckLWfNAFjvGVdsY27wk0cAM59BtHCIe7gM7EAgdUMzRzzV1yh959VTHOFalUHr14i7GhG5ti1a8e5dXg60tOKpZKlCObBuM2qLH6h1wFUcTmrnVN+Z5J7VLH8/iO3mY0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1795481454; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mxT05VqyukIDokXGm8VYfF89ihF/CJ0MjOJ9YBKhDRU=; 
	b=OPjcVrZUxvrHjjJT5gzdVhGriXPHRBbNs9xH+wFjaKkvQEW+wdxy7Bd1R83oNVRQlnViHPHGKNowtaDnrQmRjQ5DGuqiYXXVSKzyjs4HxmUtp1/m1Ho7eRBVi7d2gz9xFZEB6XyzVuV6Bx8eSMerwpLkJLYgvmWSSkmxYYt7IYA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=A+8MZpPSwWuEItjTMNssZYsq+5qq6JZC75j7Xg9+M15Q44pFZjZl1AZHCBcqPypAZJONGrzRXmwiLmYBaSAB3p6zFv7/zTHxbs/NlOUsfbkQd2YFBwShP3bLV49X7OQU3f34jxnyZbaHL8+Y960Wqcyf2/rHSg6pedoSwkIKTik=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=mxT05VqyukIDokXGm8VYfF89ihF/CJ0MjOJ9YBKhDRU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1795481451939592.8120667281482;
	Tue, 24 Nov 2026 01:50:51 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Sean Anderson <sanderson@brivo.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Nick Xie <nick@khadas.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] mmc: meson: Parse devicetree properties
Date: Tue, 24 Nov 2026 02:50:00 +0200
Message-ID: <20261124-re-sean-meson-fmax-1@iav.lv>
In-Reply-To: <20260824132518.522252-1-sanderson@brivo.com>
References: <20260824132518.522252-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Wed, 25 Nov 2026 12:52:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3158

Hi Sean,

With this patch max-frequency from the DT overrides the 40 MHz cap from
8fa0db145f6 ("mmc: meson_gx_mmc: reduce maximum frequency"). 47 arm64
Amlogic DTs set max-frequency above 40 MHz, so their eMMC now runs HS52
at 52 MHz and SD at 50 MHz.

Neil, could the v2027.01 release notes mention this, so a board that
needs the old cap knows to set max-frequency in its -u-boot.dtsi?

--
Igor Velkov
