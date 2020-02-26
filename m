Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by mx.groups.io with SMTP id smtpd.web09.6219.1582713501376112539
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Feb 2020 02:38:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1582713498;
	bh=tgt8wJd+5cmKx3CCqVeWgyE4KtP+bKEhV3g7ddUZi50=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=gWdTiPZGJHHQB/qC6/agV/XISJMnsTiSRB/MdwAdcf/t40YG9sLWuUJRKhspBhf7b
	 kftqCqFHfMBz3NyY0j4ycrTbdYBWZgfiqF16tgO29k6ZBd1ZlAOeVBADH9wxk04ooJ
	 ynEZIxO+9hyvxuIDL7X4jFHXUIjZzImu8zwDNBDI=
Subject: Re: [PATCH 1/1] drivers/rng: add Amlogic hardware RNG driver
References: <20200224222133.972-1-xypron.glpk@gmx.de>
 <bf360136-3bbc-42bd-ddf8-c48557ecd557@baylibre.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <d8e38126-ee7d-2410-0c6b-e801d6cd403b@gmx.de>
Date: Wed, 26 Feb 2020 11:38:05 +0100
MIME-Version: 1.0
In-Reply-To: <bf360136-3bbc-42bd-ddf8-c48557ecd557@baylibre.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>



On 2/26/20 11:19 AM, Neil Armstrong wrote:
> Hi,
>
> Le 24/02/2020 =E0 23:21, Heinrich Schuchardt a =E9crit :
>> Add support for the hardware random number generator of Amlogic SOCs.
>>
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
<snip />
>>
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks for reviewing.

>
> Thanks, looks fine.
>
> I suspect this will help adding EFI RNG data for Linux early random seed=
, right ?

Yes, we need this for the EFI_RNG_PROTOCOL.

>
> Is there a RNG maintainer or should I apply it myself ?


Sughosh is the maintainer for RNG.

