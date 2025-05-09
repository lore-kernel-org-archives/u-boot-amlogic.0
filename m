Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22040C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:04:12 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.8683.1746774247220597240
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:04:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IsyBHp0R;
 spf=pass (domain: gmail.com, ip: 209.85.216.48, mailfrom: linux.amoon@gmail.com)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30a99cff4feso2196414a91.0
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746774247; x=1747379047; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgMfkdgLqHC+2fPzeFxZ+n2SHAqv1jNZcwm4TeLMFbM=;
        b=IsyBHp0RIEiywSD6QUlLJoHmLnuoRHM4Yor3iE1aA5L6lCgUW6kk6hrzr+Pl29J3l3
         4bIkHojlmX98mm9tp0lPATtB/MO3bWjB4+hlf35bUYGAliTVMUqDUxO+9LbZSBBLPgPB
         Ce3yZsvrTNvRJtJTaC5nTZ0nH1QJjhsCIKNb3CREfpE7uIivEZGZNrfoXee5nMqu/Qc2
         y72ocSxqPYdxR0f7Qx16mqUsW5+xCmzcTc/OR8xmyR7ak4Jt4X/MTG0S/rx5kHFZKoB4
         iknXwwsiBke7HS8EmQAmkHT7zehdKiEFhNVmVNEm+1WYinv/9/M9ByjWbqpBVh8poNsm
         cxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774247; x=1747379047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgMfkdgLqHC+2fPzeFxZ+n2SHAqv1jNZcwm4TeLMFbM=;
        b=VSwAmKk/kQxt9p8tGdufO0GJASKZi9Rwl8rqMz/3EHHTOWploM7YLUtzES1niL6e+F
         qgdFtnncoKpZKIo9JUZLNCQQLDsECesc++Lhb7EdbYCvbPzeZL46jhDuDskLrRi9a7U3
         zo8i8lFU1M4NgUHloJxITZGsNOdUJDUIKhOkaWRLvTGQ/F0Fil0emK/jn8BizkaVrMLH
         zNRFpgwLfZrgEhsmwAH8X6J8a6KSUDIOqKwLdwOlUkf2cLw5IBjw+QtGRiAjSbIL1gm5
         RY5BESGzzIuyLPAKFGgE52TwHEWFAVzHnXVKFvist3/OovSVL1CfOx4/gJi4Wgrs9xWZ
         VHPw==
X-Forwarded-Encrypted: i=1; AJvYcCUHdrXzErtudu8yxQ7mH9DVdX4fsXAgtH2cEa0JER83XMyRbpNrKTFledfkDfzcIEK/o9oaT+8w9fx7WE+ssw==@groups.io
X-Gm-Message-State: AOJu0YxyvJSjmfNCSYNRkUt8mR3IeOQJu9suIwKJU2n2lwYZO7VFUxRR
	ejjYtSV+boIHJO1jROqrVEq/i2uP6X34GMUj+2e6Mjk0Fsd/G94M
X-Gm-Gg: ASbGnctSXak4E3/CPvK0u/2wNgQVDVtiRJC/P0Ts4CaPcJ1lwtlisCv6RaRTiMqHNL/
	Z6lNmp8pjAh6loAvukic5MrGcWv2mMxB284A4a6QITvpot9hZ5YvdElqP8MAVleI4sP+34kYy4m
	v1HQcDQ2vp4DqpFKVMCc91KcPi3ex1ZA8jbQ4TCRw12P8qhSWGIM0s323CqbUitzTil9egyHaaO
	iJMU7SiYq6eA4fCzuupT6YOZpLztUGfkE0R76D0cnmCwuq5x1ItxUH5klNgF5jgU0KZf1uD6xSZ
	EK6rVtA5QGaY7QYNaH8lOvpy9YY7xNqK/veMc2NgvK7hP27GvQmwcymJJ9B1y8Y=
X-Google-Smtp-Source: AGHT+IET/t+zdgixEszpVTnmEhLl0J+ESwCyvCzL6R+qq1qmzFp/UFSD4gRDcfmhjkeIX6LEZBoUkQ==
X-Received: by 2002:a17:90b:4acb:b0:2fa:137f:5c61 with SMTP id 98e67ed59e1d1-30c3cefe24amr4530276a91.12.1746774246628;
        Fri, 09 May 2025 00:04:06 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 00:04:05 -0700 (PDT)
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
Subject: [RFC v1 6/7] configs: odorid-c4: Enable Oboard HUB driver
Date: Fri,  9 May 2025 12:32:11 +0530
Message-ID: <20250509070258.5077-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509070258.5077-1-linux.amoon@gmail.com>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:04:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2681

Enable the onboard USB HUB driver to power the
Via labs VL817 USB 3.1 hub on the Odroid C4.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/odroid-c4_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index cc3d7fc7484..3c5e53828a1 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -64,6 +64,7 @@ CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_DWC3_MESON_G12A=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
 CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
-- 
2.49.0


