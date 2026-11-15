Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1872.1794715107284372684
 for <u-boot-amlogic@groups.io>;
 Sat, 14 Nov 2026 19:58:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20260515 header.b=mTJm1XRc;
 spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: devnull+iav.iav.lv@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 564A443DDD;
	Sun, 15 Nov 2026 03:50:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794714634;
	b=DOdgY6YGTQK1IQWkgLljRzBRlka+RtypWnz3jJcstJmpp7cnKdYFywShKWnNtRyRWo4m
	 7lmryN0Ci7d28G4waUZvea1LmHqQ4wsIDQlaOmcLdrV/NGS122iDGy3a25zmbDFAY5Ti3
	 xMs01Y72SmkPqEqd/Y38HBQQGCH6ByDlZM8uzwDjQo3tOhFhC+GznjYRrmsEL5D88Zc5j
	 0oHoiS84pkn6QAPrN7dDzY0Upeh6DRGQkK7L5KDu4OsWfWioRUGIYyOLUGHo5PNisKm/U
	 lTr2/kEtPB4noY4oxpxFynQzU8zm/4l5XQjbsdevuHKdR3elZ74/tvcSh2pLD42UEHA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794714634;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=tG0BbysG7C8Nd5wCC17HBgXM//q7ZYVBbLOWnuDg/aQ=;
	b=c6xvwyk2YbBorgj983A/J8+plkKdVNdCT7Vh8pIegID/OHyHFM2sV+NJhegaa0vHlTjD
	 jP6jCLyRZ+gv/02iol27MpIiaLh6jgmEflZfk2P3B9XtYk374dvdoMSaWWpNEruWzCXWr
	 fyKmEtKXxXJ3iv8t7MrPdGjtV44svuZdo3q8JbhvrithRJchiUnQBt8g20ppT29afFqxu
	 SayDFxwWRhYucVtWEGL4yn8Rr9hT1H6X2YapZd9vib6jqH7BOXyNv+ppDDvfLqxu104cH
	 AuQ4YXJynBXvhFKNtE+OUs7C+wtTl0UmV+BeW+cLFIwcffFiNYwkdXEeo9Ctub6B/aA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C34171F000C4;
	Sun, 15 Nov 2026 03:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794714634;
	bh=tG0BbysG7C8Nd5wCC17HBgXM//q7ZYVBbLOWnuDg/aQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=mTJm1XRcSK2oWc/F5DyWndKbYPR8ZJrBx+32dptKzyhCURIWiGwGJOeGcWbgmJGOB
	 +BI9KEmzdG64kn9Em+uizbuPoa9CsIDdfmzAsoAN+wEV/cHHA3HOCWo1UrgLKL1QGy
	 FAu8NSdj8I3wCGgTfl9urTuYposjemt2bI7C8PH6Cp6cwMKH37z9HmU+ceyjUVFRzS
	 TjnAgmVV3Y9Co2JNrx67S3CNXQEQpSKZomnImLatSxtfmi8EFTVPIMQblGjdD10bG/
	 hhdKAACC8/U91Iv72jLKJGqSfo0CMQBn0Bi8a7DIBg2v878KB46MRmDiiEAFlncjB7
	 TJy0a/ka7JAJg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4385649F59;
	Sun, 15 Nov 2026 03:50:33 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Subject: [PATCH 0/3] arm: meson: odroid-c4/hc4: Wake-on-LAN from suspend
Date: Sun, 15 Nov 2026 03:50:29 +0000
Message-Id: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAUs+WoC/x3MwQpAQBCA4VfRnE0ZLOVV5LAYTLGrnUJt3t3m+
 B3+P4JyEFbosgiBL1HxLoHyDKbNupVR5mQoi7IhIoNjjQerd6jTibff0dY0c2NbLkwFKTsDL/L
 8y3543w99hJQ7YgAAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=1f4rcOl0WM800WyLDxnBIBr8IxSjl/eCc4sHv9kkPzM=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFk/ddiuS96ttw9rPKzyclf40SWzXmvxdnk55F86nLng1
 oFbp6ubOkpZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBEAhcy/FNbrSm6/fGTqy9V
 p29wPagU+Zi3vYM30XTCpbdxB+9Nby5gZPj13uGZi4RO2p+/4iVhGko7lFU8Zx085/h/yaMjZyq
 3f+MCAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Wed, 25 Nov 2026 12:52:09 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3155

The BL301 that Hardkernel builds for ODROID-C4/HC4 wakes the board on
the Ethernet PHY only after the AP has sent SCPI SET_USR_DATA for client
7 with a non-zero value. Neither mainline U-Boot nor Linux sends it, so
a magic packet does not wake these boards from deep suspend.

This series sends 0 or 1 from the DTB fixup, following wakeup-source on
the PHY node of the DTB the OS boots with [1].

Tested on ODROID-HC4 (U-Boot chainloaded from SPI, BL301 built from
Hardkernel's odroidg12-v2015.01 with unrelated RTC alarm changes, Linux
7.4-rc2): with wakeup-source a magic packet wakes the board from deep
suspend 3/3; without it the packet does not and the RTC alarm does.
fdt boardsetup sends the expected value with the property present,
absent, and with the MAC disabled.

Client 7 is an extension of this BL301, so the option is enabled per
board, for C4 and HC4. The N2 BL301 has the same client, but I could
not test it, nor C4. The G12 device trees have no MHU node, hence a bare
helper rather than a DM mailbox driver; I can rework it if preferred.

[1] https://lore.kernel.org/r/20261109-hc4-phy-wakeup-v1-1-d98784ecac88@iav.lv

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Igor Velkov (3):
      arm: meson: g12a: send SCPI user data to the SCP firmware
      board: amlogic: odroid-n2: tell BL301 whether to wake on LAN
      configs: odroid-c4, odroid-hc4: enable Wake-on-LAN from suspend

 arch/arm/include/asm/arch-meson/scpi.h | 17 +++++++++++
 arch/arm/mach-meson/Kconfig            |  9 ++++++
 arch/arm/mach-meson/Makefile           |  1 +
 arch/arm/mach-meson/scpi-g12a.c        | 55 ++++++++++++++++++++++++++++++++++
 board/amlogic/odroid-n2/odroid-n2.c    | 31 +++++++++++++++++++
 configs/odroid-c4_defconfig            |  1 +
 configs/odroid-hc4_defconfig           |  1 +
 doc/board/amlogic/odroid-c4.rst        |  9 ++++++
 doc/board/amlogic/odroid-hc4.rst       |  9 ++++++
 9 files changed, 133 insertions(+)
---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20261115-b4-meson-scp-wol-a41de6a7e053

Best regards,
-- 
Igor Velkov <iav@iav.lv>


