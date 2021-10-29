Received: from mx.msync.work (mx.msync.work [95.217.35.189])
 by mx.groups.io with SMTP id smtpd.web09.6369.1635518999175535992
 for <u-boot-amlogic@groups.io>;
 Fri, 29 Oct 2021 07:50:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1635518996; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rYfPXVHVd44AuJGaCsq8lTsGST7U9Csr6v4+RjCIbPk=;
	b=mYPtYrNcxukzI0lZaYno0L5CDRlfkDRzehjZF6fFc5PWyEa/Q4mwDt6uuIS821yd6fFE9V
	bbOSLxHXlt4QVy/ABvD5JyI6zNfEDIIplX6rjAKRFZnX/Ddpmm5ADunDZUqihKY44DIe6H
	e3Ym5hr1EBrpkXopBBfHPJ7sjH8Stb4cI2ZC9mTkMXKRgQu7QW1F9ftRI4G/7t830qVsSX
	GYiQYkVJOEFr89MjJW6FQDQ8Hj55l6Mh9LbC9kLw48qBUR8WnhrDAl6IdY1An2eqBkoQ+x
	4TYGr3eQQRT+WBqgnVtc2OJvlDf10ZxWsqGz678tH1IdBQbO+irzM8fZxRjR0g==
Message-ID: <42561313-e883-bb7d-282c-20898f616ebd@lexina.in>
Date: Fri, 29 Oct 2021 17:49:58 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: amlogic: add JetHub D1 eth mac generation with manufacturer OUI
References: <20211029070820.3607994-1-adeep@lexina.in>
 <258ebbb5-52a8-686b-b756-0d9180991e7a@baylibre.com>
 <60ce806b-b4fa-67c6-d66d-25fca3a1870c@lexina.in>
 <67c13277-fdf1-9afe-e33e-edfb9129cc9b@baylibre.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
In-Reply-To: <67c13277-fdf1-9afe-e33e-edfb9129cc9b@baylibre.com>
Content-Language: ru
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Fix build warning in misc_init_r jethub-j100.c

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>

---
  board/amlogic/jethub-j100/jethub-j100.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/board/amlogic/jethub-j100/jethub-j100.c 
b/board/amlogic/jethub-j100/jethub-j100.c
index 575bb31573..6a2c4ad4c3 100644
--- a/board/amlogic/jethub-j100/jethub-j100.c
+++ b/board/amlogic/jethub-j100/jethub-j100.c
@@ -13,6 +13,7 @@
  #include <asm/arch/sm.h>
  #include <asm/arch/eth.h>
  #include <asm/arch/mem.h>
+#include <u-boot/crc.h>

  int misc_init_r(void)
  {
--
2.30.2

