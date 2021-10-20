Received: from mx.msync.work (mx.msync.work [95.217.35.189])
 by mx.groups.io with SMTP id smtpd.web12.379.1634747551659948852
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Oct 2021 09:32:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1634747548; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7VZ+xzXDZ88uBWlzLgLLw4qH0Xn/vPp5jrU0sONiYZ8=;
	b=G9JL1ReWDR1t2qozW+5UKX0K32tABcZeMjQzbc8g7D3x7PzbXGbPm52lSaQT8L2ZLw+LFt
	Z59ietWpwCHYrJ3Gio8CIfQ7w62estPpi1clKvf+hEGzN4csT7rtEv1XlrAW6E2nYjmj2g
	lFCYnlY54POJKOPCojPDZQLE9Hp2iTCVgvkOiViNJdscI/NpaeQ1crTBwrogCHbDQ96qNB
	6fBSuc3KNbx2AxLiS3AQ1zUNZRENS2Sy5i3JDZo4BGwMN+zY7Diz1JFaXtldwZvB9wQkYA
	xk5SUIkXbwrLMQ1gJubTY7NoM03R1JArHfLR+GLAs3Z0IiqLj+ZZohV3NFDv4A==
Subject: Re: [PATCH] ARM: amlogic: add sm efuse write support and cmd for read/write efuse
References: <20211005120002.1147482-1-adeep@lexina.in>
 <38d6e917-d367-ee5c-58a1-1e6201005e41@baylibre.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Message-ID: <a3f6429f-839f-806b-e6d5-f67681047a6c@lexina.in>
Date: Wed, 20 Oct 2021 19:32:25 +0300
MIME-Version: 1.0
In-Reply-To: <38d6e917-d367-ee5c-58a1-1e6201005e41@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Great, thanks.

20.10.2021 17:23, Neil Armstrong wroute:
> On 05/10/2021 14:00, Vyacheslav Bocharov wrote:

> 
> These should be aligned with tabs
Damn, that's my regular mistake.
