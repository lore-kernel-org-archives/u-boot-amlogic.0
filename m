Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C800CA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 19:59:24 +0000 (UTC)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
 by mx.groups.io with SMTP id smtpd.web10.28923.1757534357984530106
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Sep 2025 12:59:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=LX8l9u23;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.183, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757534356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=alfZQAzlc+9CWEwnvOj7sX8gQ3/Qa2UBW5LeXZ+merQ=;
	b=LX8l9u23WMtPXipzXnDmDYoQnSj5i+8sRkofbyGfvjmRzoiIdif1QfLHya43+451WjaTlx
	pYpEOodsM+RglymehxTaZPD7vyzBtG/4gOa1UKYq3V6n+VwIsRjBhWOpUSkLGboYkhyQFR
	jvrqJlIHeV5iV0m4B3XJ5nkHGnl8wp3NgtEalAgOFIohijPMldwscIrIHv382wZr2aieVk
	ClOlZrZTbOpjDscvtkjc7UveK65EoeJmmyCKu/rVRmRDMqGKJGKC8zI2ez7hW3//jTcWNO
	okgZXM8r9QgB2UbO6GNmkRVpvUmoYWpEMXfZ11umbKg2Rqm025U5WU5VbSTdGg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 19:59:13 +0000
Message-Id: <DCPDXJU52MN9.3VBOPIOMXNYLL@postmarketos.org>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>, "Ferass El Hafidi"
 <funderscore@postmarketos.org>, "Tom Rini" <trini@konsulko.com>, "Peng Fan"
 <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>, "Beniamino
 Galvani" <b.galvani@gmail.com>
Subject: Re: [PATCH RFC 9/9] doc: board: amlogic: add u-boot-spl
 documentation
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>, "Neil Armstrong"
 <neil.armstrong@linaro.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-9-37395d9ff5af@postmarketos.org>
 <12661062-d02e-41aa-aa57-d83c05688d7f@linaro.org>
 <e639a9b1-a745-4099-b9e7-2a7fc411e1f9@gmx.de>
In-Reply-To: <e639a9b1-a745-4099-b9e7-2a7fc411e1f9@gmx.de>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 19:59:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2776

On Wed Sep 10, 2025 at 7:42 PM UTC, Heinrich Schuchardt wrote:
> <...>
>>> +Building a bl30_new.bin binary
>>> +------------------------------
>>> +
>>> +``bl30_new.bin`` has both ``bl30.bin`` and ``bl301.bin`` binary blobs
>>> +bundled. The former is the proper system control processor firmware=20
>>> and the
>>> +latter is a "plug-in" for board-specific DVFS/suspend-resume=20
>>> parameters. For
>>> +more info you may wish to read this page: `Pre-Generated FIP File=20
>>> Repo`_.
>>> +
>>> +To build using the FIP file repo, simply issue the following commands:
>>> +
>>> +.. code-block:: bash
>>> +
>>> +=C2=A0=C2=A0=C2=A0 $ cd amlogic-boot-fip/your_board
>
> Where do you get this source tree from? It is not contained in TF-A.
>

From the amlogic-boot-fip repository, which is documented in the
"Pre-Generated FIP File Repo" page linked above this command.

> Best regards
>
> Heinrich
>

Thanks.

