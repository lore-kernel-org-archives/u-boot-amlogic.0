Received: from mx.msync.work (mx.msync.work [95.217.65.204])
 by mx.groups.io with SMTP id smtpd.web12.8127.1632121711746048008
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Sep 2021 00:08:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1632121705; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:
	 disposition-notification-to; bh=pWL+umKgURR9OHOJTzBs0Zi9nt8Rw99qHZegj4IYpvY=;
	b=kU+n6cn8tljA4EdiHBXHXS8NU2PhiTadNIC+2ZhKzZ5S2qRXW66CEDYc6URapAnVG0LPqA
	oIzc4e4U2hXRAw93tvkT0uc7K8k2Ecnbejs6AkQHq1erXlwRqX05gWJfQYByy0v1xc10OI
	fIAqmEyAUIuJpJHC+Ya/hcFcL0hzmOpJaJDrrLkTpWfDOT35AiBw9UIloT/HWHNy+gbYKk
	RYT96fNR0pdrIiQNIvhGeEVLCZhB4ydhPW8DedQhdxRg3qiaI2U2D77DRo5ca0jKLEm2Gb
	fbLsMuNr0rLArc94IrpwGDsPgoLHvwgKql81XlJ0QzY1kzlp/2VSEooRbh6xtw==
Subject: Re: [PATCH v2 3/3] ARM: amlogic: add JetHub D1/H1 docs
References: <20210919155216.4000369-1-adeep@lexina.in>
 <20210919155216.4000369-4-adeep@lexina.in>
 <0226ea58-cf5d-45d9-9df5-d41541fdd259@baylibre.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Message-ID: <6a049ffd-bdfc-15be-d73a-49041bf27d00@lexina.in>
Date: Mon, 20 Sep 2021 10:08:24 +0300
MIME-Version: 1.0
In-Reply-To: <0226ea58-cf5d-45d9-9df5-d41541fdd259@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com
List-ID: <u-boot-amlogic@groups.io>

20.09.2021 09:46, Neil Armstrong wrote:
> Hi,
> 

> I got the error:
> 
> Warning, treated as error:
> /home/narmstrong/projects/amlogic/u-boot-upstream/doc/board/amlogic/jethub-j100.rst:16:Block quote ends without a blank line; unexpected unindent.
> 
Weird, patman doesn't show this problem. Which tool is checking this?

Thanks.
