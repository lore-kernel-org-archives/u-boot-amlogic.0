Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4238CC3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:03:22 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.8670.1746774196227705842
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:03:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OcKk/QfH;
 spf=pass (domain: gmail.com, ip: 209.85.216.43, mailfrom: linux.amoon@gmail.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-309f3bf23b8so2260382a91.3
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746774196; x=1747378996; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rrnqO1PcmSsEx5X5C4JBpKRne+7TmvU4oiR4j7CnMys=;
        b=OcKk/QfHbxkJHA0r304uG3WZRArA1R5ISCEI7avMLBDrva8cz7IN7HjdXJ/yzbGMOK
         cuvkqE4Sjwtj1qo8UTtKV6ZkakCYMICzeH9O1pnhkzvOqHG5bRyB8bLY6Fpch/T4UwgK
         AuaeY2UbL+pM3l/RwMS8wcndrI6I2gN+VCbD8xJSM3VxHymQig6ONK2303hhh4BC6ZeC
         XIV0GuEnbnRn70EkKJ7+75Hm2JOfhsuwcRwDjyjmo3j/v5FgfyQaD/7w0YiKy60ZXuAB
         mRrZnyWDwmYTZFHoDJST+P/icVp0zFIBfpi72o9zrv62z0KcxhX5FivnwmK3mh18oVub
         MWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774196; x=1747378996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrnqO1PcmSsEx5X5C4JBpKRne+7TmvU4oiR4j7CnMys=;
        b=hL4v3yCibaRvduFOqEhNePoR3DmQbV8GTxeLcDNuXVPNx0dpLUs9T5/gNhHUYgFY6Y
         CGhKyxomQFPLXU2HiVoLpC1j8VOd7U35zDKg82inDmXvKHRT5Vk7rshC3DpqbDmdjPZD
         Yc0i71FWCzEPCrL3i4ZCgKJMEwiH0tkGDlDRi3LKT8MXVc30NjgHt/7WlBvn5Oo3UOgg
         z+Azq1xBcWoFgb2sCz2goH2bUpW5GzOPGlztxKxFQW1nnQEX9bpxLOOrupL2mBBdu31M
         B7pYPiE7wz8CMJnH00jwDkZScS6xavejCnAY0fViPjUWjrmL8Z7ZJnZvJAdPduoOQid2
         tf9w==
X-Forwarded-Encrypted: i=1; AJvYcCU2jXKJAshDR/ElMbhvAXZcC7DJGJwx9nu/27at0UKGohObjtjqztctNEx0ePoexeb/+3s2J35RjCxN/fQrXg==@groups.io
X-Gm-Message-State: AOJu0Yy9/LlnU2VPnkHy6bg25zv6np+JlO1eNqi7iIfXVMQ8DKqUUrDv
	GuMoaWqgF+gk9z/5sVfwy1Es7Q70QAfbZPbn/PIVGvOnXFYgNpNI
X-Gm-Gg: ASbGnctWP2fVQ5OU3e14cqPIhDPu8ZCYPe+kHn9W4i2pr9l7Ndnot6yrqkxVRQYNrtF
	F0t78GCSW9el5bvzBMNGi+skY9PG1yMbLWB7IGeV/fLbI+GxYbUwcloDX2SPVT3fOlq78OihVzn
	zg/WqYyT9pMYmPUrF5XTxuYPaaXhUNFAgZLyLuMAk18xxNcYAuI9sydkJIlooHsPxQiBSK2/OR+
	LgfutKSS2irdxvOMqsFNp7RNfVwlW6VTKsVRdpFqbv1cZRxc4PBUcFNLT7pv3BJHg0wGuWtaxR+
	SW8REXlW1KWm0d0V9836peIhJUKJf869oTEsRxE7Jmlgnqwu1gRf
X-Google-Smtp-Source: AGHT+IHMqI/Ij42tnHEvtNvfyRy0NK3CpXcQbgvVYelys9Z/7cTY9G4V3b5lpwBe43XQjB26yzRj9Q==
X-Received: by 2002:a17:90b:1a89:b0:305:2d68:8d57 with SMTP id 98e67ed59e1d1-30c3cc11062mr3691077a91.5.1746774193508;
        Fri, 09 May 2025 00:03:13 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 00:03:12 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
	Marek Vasut <marex@denx.de>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Michal Simek <michal.simek@amd.com>,
	u-boot@lists.denx.de (open list),
	u-boot-amlogic@groups.io (open list:P200)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Wayne Schroeder <raz@chewies.net>
Subject: [RFC v1 0/7] common: usb_onboard_hub: Add support for Odroid onboard USB hub reset
Date: Fri,  9 May 2025 12:32:05 +0530
Message-ID: <20250509070258.5077-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:03:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2675

Odroid C1+/C2/C4/N2/N2-plus devices have an onboard USB hub
controlled by a reset GPIO pin. Adds changes to the onboard USB hub
driver to perform a proper reset of the USB hub.

Added conditional compilation for I2C initialization based
on CONFIG_DM_I2C for failed to compile.

Thanks
-Anand

Anand Moon (7):
  usb: onboard-hub: Add support for Genesys GL852G hub
  configs: odorid-c2: Enable Onboard HUB driver
  usb: onboard-hub: Add support for Genesys GL853G
  configs: odorid-n2: Enable Oboard HUB driver
  usb: onboard-hub: Add support for VL817 USB hub
  configs: odorid-c4: Enable Oboard HUB driver
  usb: onboard-hub: Add conditional compilation for I2C initialization

 common/usb_onboard_hub.c    | 28 ++++++++++++++++++++++++++++
 configs/odroid-c2_defconfig |  1 +
 configs/odroid-c4_defconfig |  1 +
 configs/odroid-n2_defconfig |  1 +
 4 files changed, 31 insertions(+)


base-commit: 48db49b0977cc1c9c9abf82c0fb704238fcef4fd
-- 
2.49.0


