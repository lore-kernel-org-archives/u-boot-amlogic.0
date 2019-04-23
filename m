Received: by mail-wm1-f66.google.com with SMTP id v14so17916851wmf.2
        for <u-boot-amlogic@groups.io>; Tue, 23 Apr 2019 02:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TyI2cp1kzbcX3e7Ug/dJwYOn/4vDIRRLQ/s0OWPBQ7Y=;
        b=TTlDywFCuJY4KlzTBYb7xndUclsvJ+TBcbRAuoTTGgn+Xfuh8+80Mx4uFg6l6FXWpb
         MmAP/OqaDPfI3rtEO65m0Ptq2RjEg+dE5PsWwrSb4Cyq6dj34iBUJxcytR1VLW73zvVc
         //PYda5TDCoQbXCDpCZ3ix41JbM+eZ/Igaed724pdEblBo5tXMGK4pIv6KP1iky0iVMW
         qa/Id9GqEO/MPM5Ag2mAzGfAqxZJiR4h08hsQZoFVz8lwf4z2zgpbesr4xvcy9Az7ZlY
         jZnTxuJBymxtuDs9ooAeTQU8FH2L0l7rvFuqQk8nXg8K9BWeV5uIye8wLs6zV8jtF32q
         +O4Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] regmap: fix regmap_read_poll_timeout warning about sandbox_timer_add_offset
References: <20190417181714.1281-1-narmstrong@baylibre.com>
 <CAPnjgZ3_XPk=C+SKOP860MHU+TUGrwrrqWLXw4faGhRf6kp6wQ@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <3ba6a4a4-e141-9670-e078-b37524a54a1b@baylibre.com>
Date: Tue, 23 Apr 2019 11:30:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAPnjgZ3_XPk=C+SKOP860MHU+TUGrwrrqWLXw4faGhRf6kp6wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 21/04/2019 21:29, Simon Glass wrote:
> On Wed, 17 Apr 2019 at 11:17, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> When fixing sandbox test for regmap_read_poll_timeout(), the
>> sandbox_timer_add_offset was introduced but only defined in sandbox code
>> thus generating warnings when used out of sandbox :
>>
>> include/regmap.h:289:2: note: in expansion of macro 'regmap_read_poll_timeout_test'
>> regmap_read_poll_timeout_test(map, addr, val, cond, sleep_us, \
>>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/spi/meson_spifc.c:169:8: note: in expansion of macro 'regmap_read_poll_timeout'
>> ret = regmap_read_poll_timeout(spifc->regmap, REG_SLAVE, data,
>>         ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/spi/meson_spifc.c: In function 'meson_spifc_txrx':
>> include/regmap.h:277:4: warning: implicit declaration of function 'sandbox_timer_add_offset' [-Wimplicit-function-declaration]
>>
>> This fix renames the sandbox_timer_add_offset() to a generic timer_test_add_offset()
>> function defined in time.h and renames the implementation and test usages.
>>
>> Cc: Simon Glass <sjg@chromium.org>
>> Reported-by: Tom Rini <trini@konsulko.com>
>> Fixes: df9cf1cc08 ("test: dm: regmap: Fix the long test delay")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  arch/sandbox/include/asm/test.h | 8 --------
>>  board/sandbox/sandbox.c         | 2 +-
>>  drivers/net/sandbox.c           | 2 +-
>>  drivers/timer/sandbox_timer.c   | 2 +-
>>  include/regmap.h                | 2 +-
>>  include/time.h                  | 8 ++++++++
>>  6 files changed, 12 insertions(+), 12 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 

Thanks,
Applied to u-boot-amlogic
