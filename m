Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by mx.groups.io with SMTP id smtpd.web10.32553.1673131252560067568
 for <u-boot-amlogic@groups.io>;
 Sat, 07 Jan 2023 14:40:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1673131237; bh=/Lq0OkFnAWd7J/Erh2jLzEmHvVbALlxaDwLs0l4Ng8Q=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MCfSitmpg3tDzVnDzjRdNBG6y0xhVF1g2SKJ1q1e8hOXnV1TIWZ6jLL0FTSByvEhq
	 ZssolE96+3eCSlqzeYA6CICf9K4+RjicwA9+b4d2dPsKpQ9R7NtYH6nLIB2dGzDjpw
	 0zmgZo1OELRikcRQCRTLRJG6imczYN6gcEFkzo5ufdVh0MBOBfv2/wETT/Jrx5JLzz
	 cGe7rbA/P174Kmp0+PfRQPEunU6oHxc84v4WGJ6U/jE7AlXJ1pnu0x/JhpP7cNM+EV
	 1lYNw8XeaLCRNHLBMaTepEgfd5gBdeulfqknH7cvyWBgdCObJ9eAlfBsoqg+CGKOkT
	 FX4t90+/No1JQ==
Message-ID: <b03e611b-2150-9bf9-0cb1-b15752ef9ae5@gmx.de>
Date: Sat, 7 Jan 2023 23:40:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 7/9] video: Use VIDEO_DAMAGE for VIDEO_COPY
References: <20230103215004.22646-1-agraf@csgraf.de>
 <20230103215004.22646-8-agraf@csgraf.de>
 <CAPnjgZ1uDNY4T65Q4EdW-xRnFiGhvWcCs=YtcwLCpRbZpTNJQg@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ1uDNY4T65Q4EdW-xRnFiGhvWcCs=YtcwLCpRbZpTNJQg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, Anatolij Gustschin <agust@denx.de>, Da Xue <da@libre.computer>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>, uboot-stm32@st-md-mailman.stormreply.com, u-boot-amlogic@groups.io, Alexander Graf <agraf@csgraf.de>
List-ID: <u-boot-amlogic@groups.io>

On 1/7/23 01:13, Simon Glass wrote:
> Hi Alexander,
>
> On Tue, 3 Jan 2023 at 14:50, Alexander Graf <agraf@csgraf.de> wrote:
>>
>> CONFIG_VIDEO_COPY implemented a range based copying mechanism: If we
>
> range-based
>
>> print a single character, it will always copy the full range of bytes
>> from the top left corner of the character to the lower right onto the
>> uncached frame buffer. This includes pretty much the full line contents
>> of the printed character.
>>
>> Since we now have proper damage tracking, let's make use of that to redu=
ce
>> the amount of data we need to copy. With this patch applied, we will onl=
y
>> copy the tiny rectangle surrounding characters when we print them,
>> speeding up the video console.
>>
>> As a bonus, we remove a lot of code.
>>
>> Signed-off-by: Alexander Graf <agraf@csgraf.de>
>>
>> ---
>>
>> v2 -> v3:
>>
>>    - Rebase
>>    - Make CONFIG_COPY always select VIDEO_DAMAGE
>> ---
>>   drivers/video/Kconfig             |  5 ++
>>   drivers/video/console_normal.c    | 14 +----
>>   drivers/video/console_rotate.c    | 37 ++-----------
>>   drivers/video/console_truetype.c  | 17 +-----
>>   drivers/video/vidconsole-uclass.c | 16 ------
>>   drivers/video/video-uclass.c      | 91 ++++++++-----------------------
>>   drivers/video/video_bmp.c         |  7 ---
>>   include/video.h                   | 37 -------------
>>   include/video_console.h           | 49 -----------------
>>   9 files changed, 37 insertions(+), 236 deletions(-)
>>
>
> This feature needs some tests in test/dm/video.c
>
> For sandbox, I think you will need to allow it to be enabled /
> disabled at runtime, so the some tests can use it and some not?

It should be good enough to enable the feature in one of the sandbox
defconfigs and disable it in another.

Best regards

Heinrich

>
> Regards,
> Simon

