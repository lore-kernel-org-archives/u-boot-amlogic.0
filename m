Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CF6E7719D
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 08:55:50 +0000 (UTC)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by mx.groups.io with SMTP id smtpd.web11.7574.1735941554369592444
 for <u-boot-amlogic@groups.io>;
 Fri, 03 Jan 2025 13:59:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kwiboo.se header.s=fe-e1b5cab7be header.b=OCJYyWTW;
 spf=pass (domain: fe-bounces.kwiboo.se, ip: 149.28.215.223, mailfrom: srs0=4402=t4=kwiboo.se=jonas@fe-bounces.kwiboo.se)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1735941553;
 bh=RXY4Yg+Qe2W7aq785JNMAfQWygPoVSoEBRzGIQTm/90=;
 b=OCJYyWTWhqfx9KHZf0r+95MYeWsLHY25aRqWgFSmEUd46h3wUamX2H4TbwGboEFhYmzRzYrfe
 7BC9EVs2WhdUKXazFGphdsMUwRRAtArGFZfZGEPY6kmrFpiURBAtQuHof/305g8V/4JV9bFdo57
 uAIAocv/2k/uw2nxv7Z7syxe+3635LksZB8hjtVYlw3DQmq9rNBevWNjnarm2igXmpW3Y8SEqBM
 ejQlGbUBV19HaMtKbF98r/8+AFTdklkXz4eZ86vyD5y2Yuz5Zl0KLAYBDO/2DbjYbH/pbOMBM5g
 03tUyL/fqzCes8QYhtgm85B88UAGpJoKENMk3At7RGog==
X-ForwardEmail-Version: 0.4.40
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Received: from bionic.. ([78.69.151.207]
 78-69-151-207-no600.tbcn.telia.com) by smtp.forwardemail.net (Forward
 Email) with ESMTPSA (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384); Fri,
 03 Jan 2025 21:59:06 +0000
From: Jonas Karlman <jonas@kwiboo.se>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] tools: mkimage: Add Amlogic Boot Image type
Date: Fri,  3 Jan 2025 21:58:57 +0000
Message-ID: <20250103215904.2590769-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67785dad053722097e3f0ff2
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 06 Jan 2025 08:55:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2600

Add support for creating an Amlogic Boot Image that pass CHK in BL1 on
Amlogic AArch64 SoCs.

The first patch add the new amlimage type. The second patch add a eMMC
relocation workaround that can be used to generate a boot image that can
be booted from both eMMC and SD-card on GXBB.

The amlimage type and the eMMC relocation workaround is loosely based on
my prior work, aml_chksum, a small tool that can write boot image
headers with updated offsets and checksums, see [1].

This has been tested booting a very limited U-Boot SPL on boards with
e.g. S905, S922X, S905X3 and A311D SoCs.

[1] https://github.com/Kwiboo/u-boot/commit/6d0a17632922077a2e64b13ae1a6bdf0024b718f

Jonas Karlman (2):
  tools: mkimage: Add Amlogic Boot Image type
  tools: amlimage: Add support for GXBB eMMC header

 MAINTAINERS                    |   1 +
 boot/image.c                   |   1 +
 include/image.h                |   1 +
 tools/Makefile                 |   1 +
 tools/amlimage-gxbb-relocate.c |  79 +++++++++
 tools/amlimage.c               | 283 +++++++++++++++++++++++++++++++++
 6 files changed, 366 insertions(+)
 create mode 100644 tools/amlimage-gxbb-relocate.c
 create mode 100644 tools/amlimage.c

-- 
2.47.1


