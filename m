Received: by mail-wm1-f65.google.com with SMTP id q16so11852042wmj.3
        for <u-boot-amlogic@groups.io>; Fri, 12 Apr 2019 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8tYBR253RWJGYVvp8PYyfW9TmeVUjnSn5DRr9zxDTX4=;
        b=0sHXzPNZxjs1JhmpiGoNXxvBDAOJrzJu/+bbRWhTov5bwaYAtdbm9pAit2gBSHD4M/
         gKNxV2ePN4rzakmwVIkiTGC8PRc5D9sz9f3vhGWqHzQmKIi+nsyQ50w8AFsISz+SUgUm
         qLyAEhnpsD+eh/2U71vdb+UTAUL9a4Skdx7azOJKRfmovwGAx5tjP8HHcAlEB/qUjSoR
         xyIJqSSlUegyxkJGKJM2x7Lk8hNzlyU6ISyUaxUqNDFjiYWhIXNvI9ELgGawyvd3VEHI
         2dgnHjhZuczmC5m+JsZoQT6ywIWbY/vph4gFn57KCk6v0xWmckpqU4VNIbT1z0tBM73N
         ljzg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] regmap: fix regmap_read_poll_timeout warning about sandbox_timer_add_offset
From: "Neil Armstrong" <narmstrong@baylibre.com>
References: <20190411151204.27316-1-narmstrong@baylibre.com>
 <CAPnjgZ3k_GGivhpUf6DgBJoU6A7pLA1TC=OyTdQmfnT7OsK6Ww@mail.gmail.com>
 <4b3bd0e7-a0dc-65a0-e20b-062dfabd8351@baylibre.com>
Message-ID: <f32c1716-4e9b-a15c-81e8-7b2268107b21@baylibre.com>
Date: Fri, 12 Apr 2019 17:52:50 +0200
MIME-Version: 1.0
In-Reply-To: <4b3bd0e7-a0dc-65a0-e20b-062dfabd8351@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 12/04/2019 16:56, Neil Armstrong wrote:
> Hi,
> 
> 
> On 12/04/2019 15:09, Simon Glass wrote:
>> Hi,
>>
>> On Thu, 11 Apr 2019 at 09:12, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>
>>> When fixing sandbox test for regmap_read_poll_timeout(), the
>>> sandbox_timer_add_offset was introduced but only defined in sandbox code
>>> thus generating warnings when used out of sandbox :
>>>
>>> include/regmap.h:289:2: note: in expansion of macro 'regmap_read_poll_timeout_test'
>>> regmap_read_poll_timeout_test(map, addr, val, cond, sleep_us, \
>>>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/spi/meson_spifc.c:169:8: note: in expansion of macro 'regmap_read_poll_timeout'
>>> ret = regmap_read_poll_timeout(spifc->regmap, REG_SLAVE, data,
>>>         ^~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/spi/meson_spifc.c: In function 'meson_spifc_txrx':
>>> include/regmap.h:277:4: warning: implicit declaration of function 'sandbox_timer_add_offset' [-Wimplicit-function-declaration]
>>>
>>> This simply adds an empty static inline sandbox_timer_add_offset()
>>> implementation that will be dropped by the compiler optimization routines.
>>>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> Reported-by: Tom Rini <trini@konsulko.com>
>>> Fixes: df9cf1cc08 ("test: dm: regmap: Fix the long test delay")
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  include/regmap.h | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>
>> This is OK with me, but I wonder if it would be better to change the code:
>>
>> if (IS_ENABLED(CONFIG_SANDBOX) && test_add_time) \
>>    sandbox_timer_add_offset(test_add_time); \
>>
>> to something like
>>
>>    do_test_add_time(test_add_time);
>>
>> where do_test_add_time() is defined above as either a sandbox call, or empty?
>>
>> The reason I say this is it seems a bit weird to define a function
>> called sandbox_... in non-sandbox code.
> 
> Yes, but it still seems weird to have empty test code defined in this header.
> 
> Can't we use sandbox_state->skip_delays here instead ?

What about the following ?

-----><--------------------------------------------
diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index fc52f47f82..e956a05262 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -59,14 +59,6 @@ void sandbox_i2c_eeprom_set_test_mode(struct udevice *dev,

 void sandbox_i2c_eeprom_set_offset_len(struct udevice *dev, int offset_len);

-/*
- * sandbox_timer_add_offset()
- *
- * Allow tests to add to the time reported through lib/time.c functions
- * offset: number of milliseconds to advance the system time
- */
-void sandbox_timer_add_offset(unsigned long offset);
-
 /**
  * sandbox_i2c_rtc_set_offset() - set the time offset from system/base time
  *
diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index 397e7561d4..9ca1eca027 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -31,7 +31,7 @@ void flush_cache(unsigned long start, unsigned long size)
 /* system timer offset in ms */
 static unsigned long sandbox_timer_offset;

-void sandbox_timer_add_offset(unsigned long offset)
+void timer_test_add_offset(unsigned long offset)
 {
 	sandbox_timer_offset += offset;
 }
diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
index decce2fa59..c136392350 100644
--- a/drivers/net/sandbox.c
+++ b/drivers/net/sandbox.c
@@ -350,7 +350,7 @@ static int sb_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	struct eth_sandbox_priv *priv = dev_get_priv(dev);

 	if (skip_timeout) {
-		sandbox_timer_add_offset(11000UL);
+		timer_test_add_offset(11000UL);
 		skip_timeout = false;
 	}

diff --git a/drivers/timer/sandbox_timer.c b/drivers/timer/sandbox_timer.c
index 6d2b045fe8..5228486082 100644
--- a/drivers/timer/sandbox_timer.c
+++ b/drivers/timer/sandbox_timer.c
@@ -14,7 +14,7 @@
 /* system timer offset in ms */
 static unsigned long sandbox_timer_offset;

-void sandbox_timer_add_offset(unsigned long offset)
+void timer_test_add_offset(unsigned long offset)
 {
 	sandbox_timer_offset += offset;
 }
diff --git a/include/regmap.h b/include/regmap.h
index 8359c511d2..3cd7a66cea 100644
--- a/include/regmap.h
+++ b/include/regmap.h
@@ -274,7 +274,7 @@ int regmap_raw_read_range(struct regmap *map, uint range_num, uint offset,
 		if (cond) \
 			break; \
 		if (IS_ENABLED(CONFIG_SANDBOX) && test_add_time) \
-			sandbox_timer_add_offset(test_add_time); \
+			timer_test_add_offset(test_add_time); \
 		if ((timeout_ms) && get_timer(__start) > (timeout_ms)) { \
 			__ret = regmap_read((map), (addr), &(val)); \
 			break; \
diff --git a/include/time.h b/include/time.h
index 825991e222..9fd0d73fb4 100644
--- a/include/time.h
+++ b/include/time.h
@@ -13,6 +13,14 @@ unsigned long get_timer(unsigned long base);
  */
 unsigned long timer_get_us(void);

+/*
+ * timer_test_add_offset()
+ *
+ * Allow tests to add to the time reported through lib/time.c functions
+ * offset: number of milliseconds to advance the system time
+ */
+void timer_test_add_offset(unsigned long offset);
+
 /*
  *	These inlines deal with timer wrapping correctly. You are
  *	strongly encouraged to use them


