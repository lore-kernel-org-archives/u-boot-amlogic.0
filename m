Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by mx.groups.io with SMTP id smtpd.web11.17574.1591959326508639966
 for <u-boot-amlogic@groups.io>;
 Fri, 12 Jun 2020 03:55:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1591959322;
	bh=S1DyK1kvYqkthJC9qIul72cNv1Vcgjz+gFRAz3r5eBU=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=T8e16XZsVBbYu9ApICWlRkoROi5MXUo6TdDDwGoSkKvL5f+TIztFo1vadhYm+xTcu
	 /DQHKRu9MIZ/yZiZBQqTqINDKFdSL8WHFYrmVbmYqaETtigHdQiALDuTnw9T1++pVp
	 KDHPxDyxaL45+F2RVOBh8Cepr5rnQdYrX/425xyQ=
Subject: Re: [PATCH 1/2] board: amlogic: move boards doc into doc/board/amlogic
References: <20200611132841.6546-1-narmstrong@baylibre.com>
 <20200611132841.6546-2-narmstrong@baylibre.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <71d6a971-0ed9-2389-8412-41c5525ccd20@gmx.de>
Date: Fri, 12 Jun 2020 12:55:12 +0200
MIME-Version: 1.0
In-Reply-To: <20200611132841.6546-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, trini@konsulko.com, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, b.galvani@gmail.com
List-ID: <u-boot-amlogic@groups.io>

On 6/11/20 3:28 PM, Neil Armstrong wrote:
> Move the natural text Amlogic board README files to doc/board/amlogic
> into reStructuredText and :
> - add reStructuredText markup for bash code
> - fix secondary titles markup
> - move board support into global support matrix
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks for moving this to the HTML documentation.

Please, add an SPDX license identifier to each file, e.g.
.. SPDX-License-Identifier: GPL-2.0+

make htmldocs shows no problems

Best regards

Heinrich
