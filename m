Received: by mail-wr1-f65.google.com with SMTP id r4so12313094wrq.8
        for <u-boot-amlogic@groups.io>; Fri, 12 Apr 2019 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DL6gMrBkE6Tij8Dru7AraEeX8aemXICmH0j8XEwqHwU=;
        b=LASgFro+60dN8w1yZhjuZOYr/+Mf7a02LxwZkpVo76eF4IO7jH7KRVUiFLy+kSjWRn
         nimOJGEsoe2NlLseJYMt9ZF8qqzSnexf6OWjc3/T5CL1cY6eISILpBXLBTl2HRT2Xf+t
         nn12l4oSR0G5uGVmTOJ/RCAjWPXwla9R890I2YF/q9r1G17X9HUFwoWhcq/+0avA8sAz
         jYtBXqXT9JvSq0JfjQYAjGbrEHWAZOk5deNobFBi1samwBoDZzIy4oUrGZ0HnBmXuH4t
         ArTMtt7XtYiYmoCnCZYfrbKo2A/dtLAQn5ykTeESfCV0Y0zToCjrvuhqiSryHRM8K4P+
         DHVA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] regmap: fix regmap_read_poll_timeout warning about sandbox_timer_add_offset
References: <20190411151204.27316-1-narmstrong@baylibre.com>
 <CAPnjgZ3k_GGivhpUf6DgBJoU6A7pLA1TC=OyTdQmfnT7OsK6Ww@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <4b3bd0e7-a0dc-65a0-e20b-062dfabd8351@baylibre.com>
Date: Fri, 12 Apr 2019 16:56:54 +0200
MIME-Version: 1.0
In-Reply-To: <CAPnjgZ3k_GGivhpUf6DgBJoU6A7pLA1TC=OyTdQmfnT7OsK6Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,


On 12/04/2019 15:09, Simon Glass wrote:
> Hi,
> 
> On Thu, 11 Apr 2019 at 09:12, Neil Armstrong <narmstrong@baylibre.com> wrote:
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
>> This simply adds an empty static inline sandbox_timer_add_offset()
>> implementation that will be dropped by the compiler optimization routines.
>>
>> Cc: Simon Glass <sjg@chromium.org>
>> Reported-by: Tom Rini <trini@konsulko.com>
>> Fixes: df9cf1cc08 ("test: dm: regmap: Fix the long test delay")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  include/regmap.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
> 
> This is OK with me, but I wonder if it would be better to change the code:
> 
> if (IS_ENABLED(CONFIG_SANDBOX) && test_add_time) \
>    sandbox_timer_add_offset(test_add_time); \
> 
> to something like
> 
>    do_test_add_time(test_add_time);
> 
> where do_test_add_time() is defined above as either a sandbox call, or empty?
> 
> The reason I say this is it seems a bit weird to define a function
> called sandbox_... in non-sandbox code.

Yes, but it still seems weird to have empty test code defined in this header.

Can't we use sandbox_state->skip_delays here instead ?

Neil

> 
>> diff --git a/include/regmap.h b/include/regmap.h
>> index 8359c511d2..144cffbcc0 100644
>> --- a/include/regmap.h
>> +++ b/include/regmap.h
>> @@ -239,6 +239,10 @@ int regmap_raw_read_range(struct regmap *map, uint range_num, uint offset,
>>  #define regmap_get(map, type, member, valp) \
>>         regmap_range_get(map, 0, type, member, valp)
>>
>> +#ifndef CONFIG_SANDBOX
>> +static inline void sandbox_timer_add_offset(unsigned long offset) { }
>> +#endif
>> +
>>  /**
>>   * regmap_read_poll_timeout - Poll until a condition is met or a timeout occurs
>>   *
>> --
>> 2.21.0
>>
> 
> Regards,
> Simon
> 

