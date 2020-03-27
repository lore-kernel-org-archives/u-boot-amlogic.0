Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by mx.groups.io with SMTP id smtpd.web12.14174.1585322564024269720
 for <u-boot-amlogic@groups.io>;
 Fri, 27 Mar 2020 08:22:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1585322559;
	bh=KU/XYucKRb511+Qw1N4kWDJxNGJmTamnOLSzYoA7wy8=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=cSPLveopq4tBq1UqtUcRXGYJDr0sptIULSJL6jhPZepgWvJ96pYOjOfjFr4XuA9zS
	 KYPusDxMTkyIWuuap0BsG96BHZr5++BSWpKnapgwNlbsTCtp1/M+ALjHLQGmsJ3fV6
	 4MVMnGGmGf2QQZEkuEe4agWpoIlfhXXTL1R2uks4=
Subject: Re: [PATCH 0/2] drivers/rng: add Amlogic hardware RNG driver
References: <20200304011738.33763-1-xypron.glpk@gmx.de>
 <dfa16733-ff13-54f6-86ef-36396cdd0df4@baylibre.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <6fc20382-b12e-d28a-b543-2bc6cb177749@gmx.de>
Date: Fri, 27 Mar 2020 16:22:33 +0100
MIME-Version: 1.0
In-Reply-To: <dfa16733-ff13-54f6-86ef-36396cdd0df4@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 3/27/20 2:30 PM, Neil Armstrong wrote:
> On 04/03/2020 02:17, Heinrich Schuchardt wrote:
>> The first patch simplifies the Kconfig for hardware RNG drivers and ena=
bles
>> the Sandbox RNG driver for all Sandbox instances.
>>
>> The second introduces a hardware random number generator driver for Aml=
ogic
>> SOCs. This second patch had been sent before but the preceding patch wa=
s
>> missing.
>>
>> Heinrich Schuchardt (2):
>>    drivers/rng: simplify Kconfig
>>    drivers/rng: add Amlogic hardware RNG driver
>>
>>   configs/sandbox64_defconfig |   1 -
>>   configs/sandbox_defconfig   |   1 -
>>   drivers/rng/Kconfig         |  17 ++++-
>>   drivers/rng/Makefile        |   1 +
>>   drivers/rng/meson-rng.c     | 120 +++++++++++++++++++++++++++++++++++=
+
>>   5 files changed, 136 insertions(+), 4 deletions(-)
>>   create mode 100644 drivers/rng/meson-rng.c
>>
>> --
>> 2.25.1
>>
>
> Hi Sughosh,
>
> Should I take this series in my tree ?
>
> Neil
>

Hello Neil,

the two patches have been merged with bc40eb278b0c14b99055 with the
efi-2020-04-rc4-3 pull request.

Best regards

Heinrich

