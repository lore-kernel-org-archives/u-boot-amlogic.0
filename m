Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22764C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:03:52 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.8664.1746774229611074416
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:03:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SE/0ftoz;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: linux.amoon@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30a89c31ae7so2420570a91.2
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746774229; x=1747379029; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEokt0TRyCHVnQ7y9GjVFIukHf6MhdOKWOz0q4o1/Zw=;
        b=SE/0ftozPIDf1uEUrWpCFUbbm0IZTHXASctdrKwtETZ5ytbt5JXMr2QWPx1a53lkHg
         avc/ebNahmXTQ4nBN/OAZbltFZgQWtDQJDohbEynUkBAPX1xGLnt+8+ifhVL8fozSTok
         h5eF+yUFdGKUu1UwHWbaZpXIVyOIYl/4eryvIKMEDj69BNltrNdd6flrLCBpYNsvGHd7
         Y80MN7zHTYo+NYCEx8DvCptdCF1JCI3YpS9Eq++E5d7n9D0DxU1fzH6JzPG4ly1DXX/X
         ZnsBNDlu3pBUrDBHIANXuDehODajzrb+679lMItCUQoMmlKYnzoIRtmx3hdLILIsrWKR
         72xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774229; x=1747379029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEokt0TRyCHVnQ7y9GjVFIukHf6MhdOKWOz0q4o1/Zw=;
        b=RkZgIT+Mwi/5eK7PaT2N4LB3qUUnE00XrPpU4ptEj2DszkDSEx/Jf6DZFhtEMOapRf
         TI6gi+yp9eHhnAnoiNr5RsK5uZwv5Toe3AqpwtrgUn46LjPkBv02EPeaeyOivytkX5Og
         uai15BgUoFrX010Evy09ydGzuB8QiJ0N0VihvidFgCBO5r6D7IzpvvtBMnIRBpAEYZRZ
         IG8d/9hw2DCHOJ4haCQbxFeI1Nqk/bjNxwLx0XV5GwdmMou3SzyO8QhGrNSkM/flte9K
         JsQNlcYDPiK6yN0AZBqQ5GVbyF2GV930xnjQGVY7FxGNxA5EGHiHGG/ps28OgHxq+n9t
         +Kgw==
X-Forwarded-Encrypted: i=1; AJvYcCVzK2lR/ia3W2Xsf4U/PFl/8Mu1/LSHN7WbzgXa+C6vpIBA8tx6AlhljQ8hpHjGHDWeAupez10/bNPsF/0cBQ==@groups.io
X-Gm-Message-State: AOJu0YwKKfONdWi9tMEo5vAi4oTgbJZ9QPFtRlTnfz/6mY6DnhQKsBEm
	YyDx3C7Q9bh++6HikVcGbNAy0jdYZ6y8aw3ZHCFSl2TV3tMsD9KE
X-Gm-Gg: ASbGncsOl2uYBGaary9oryknFPj+Jc7H9ZgtilMpB2W0b/EwpAs2UmyKg/wwpdqB9rC
	sa+/+ezds9O19Pi3SAkdk6OLu2sn58vawuFkT6aqdkO9ZG+2LAU2h/5Ch0dsv/jh+owdOgWBdst
	koBREBUrSKYZ55M8YaArFWtJO9kOGNcEE+s05STSZejAOxjKlZ878tlBBCBCqXG/BUAMMh9BgcV
	fhj7TgErq1UpNg2ojTsJBKQoha/Bw9EL8GuKNn9+8+5uogELo8Qej6N1CzPv+WVxSA+hakCuNDl
	hmcZ06iJjQ9KNYGmF4f/bXiG+hOYSa6vsKK2tejL1S8C0ZYgGhQeu+nFxPHGEz0=
X-Google-Smtp-Source: AGHT+IGtDIGa7erq+FCqWgARoRXzzpiRJ71/MVkLrZ4GkA7Tx4KoT1AgXL9RIQBXqQjNq64CFcNFFw==
X-Received: by 2002:a17:90b:41:b0:309:cf0b:cb37 with SMTP id 98e67ed59e1d1-30c3cafd29amr4129796a91.7.1746774228990;
        Fri, 09 May 2025 00:03:48 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 00:03:48 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
	Marek Vasut <marex@denx.de>,
	Michal Simek <michal.simek@amd.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	u-boot@lists.denx.de (open list),
	u-boot-amlogic@groups.io (open list:P200)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Wayne Schroeder <raz@chewies.net>
Subject: [RFC v1 4/7] configs: odorid-n2: Enable Oboard HUB driver
Date: Fri,  9 May 2025 12:32:09 +0530
Message-ID: <20250509070258.5077-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509070258.5077-1-linux.amoon@gmail.com>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:03:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2679

Enable the onboard USB HUB driver to power the
USB_HUB_GL853G-OHG on the Odroid N2 and Odroid N2-pluss.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/odroid-n2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index a8cbaee3c96..1bf687c1e6d 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
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


