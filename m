Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.5319.1663921499573597907
 for <u-boot-amlogic@groups.io>;
 Fri, 23 Sep 2022 01:24:59 -0700
Received: by mail-wr1-f52.google.com with SMTP id r7so19278534wrm.2
        for <u-boot-amlogic@groups.io>; Fri, 23 Sep 2022 01:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=7mfP3YIztfLNJ5FYx37sA3zzDSggmWuOKXYNLVCY0us=;
        b=XpYNzqvsN0ddpcHXJlX0itmc81VyFB+Tngjf6m+e+m8kX4/qbjU2i3qeYCxGBfJDFZ
         6LZoi17NiTSUlRcah9fxFwX2IFD7lKP1I+uUOMRQcHRJXypsHG7T9ukYN7+F+vz7EAmh
         /pVvHYSyW8I5pRJmprInm0l2ADlRO1oqTTxDL4ERj6t0TlLH6TFqawS27jVMwN53U2HY
         rFJOE5z0TqMOhMe56SOzII2iPGwBc+a+0AUnWuXGvsqvY95yxthkUjlrzFOClEcyfbu7
         QcQqbPbrj1clXtia1a3olkUobbkjz5KHZwVHy2jJqb/Hcub5c+Ix8dbH2EEX2EgFP+GV
         2akA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <221f2eeb-3838-5d44-7ce2-6ddd681ff837@linaro.org>
Date: Fri, 23 Sep 2022 10:24:56 +0200
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm: amlogic: add setbrg op to serial device
References: <20220918161701.572814-1-e.tomell@gmail.com>
 <e9c204ce-bdbb-89da-70b6-3ee721fe3cd7@linaro.org>
 <CAMRTVOnQO+G+wsKFVurHUXFH2Jc8JCBwST=NmtioBMiX5R959g@mail.gmail.com>
 <17176FB5AE83328E.16904@groups.io>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <17176FB5AE83328E.16904@groups.io>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, Edoardo Tomelleri <e.tomell@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 23/09/2022 10:23, Neil Armstrong via groups.io wrote:
> Hi,
> 
> On 22/09/2022 20:51, Edoardo Tomelleri wrote:
>> Hello,
>> Il giorno gio 22 set 2022 alle ore 18:51 Neil Armstrong
>> <neil.armstrong@linaro.org> ha scritto:
>>>
>>> Hi,
>>>
>>> Sorry for the delay...
>> No problem, don't worry
>>
>>> Looks good !
>>>
>>> If someone can test it ? otherwise I'll take it for next release.
>> ...does it count if I've tested it? I have a radxa zero board (S905Y2
>> chip), this started as an experimentation
>> with editing register values in memory "for fun" and I decided to try
>> to make a patch out of it.
> 
> Yes it's perfect, thanks a lot for the test results !
> 
>> I do not have an oscilloscope so I can not accurately measure the baud
>> rate, but the logic is the same as
>> in linux and using an USB to UART (PL2303) adapter console input and
>> loady command work fine.
>> I've just repeated a small test: I'm using picocom and lrzsz in ymodem
>> mode under WSL, the usb adapter
>> is forwarded to WSL using usbip, but this should not change anything
>> at this kind of speed (I hope).
>> Here are some results sending a 1 MB test file (created once from /dev/urandom):
>> picocom v3.1
>>
>> port is        : /dev/ttyUSB0
>> flowcontrol    : none
>> baudrate is    : 115200
>> parity is      : none
>> databits are   : 8
>> stopbits are   : 1
>> [...]
>> send_cmd is    : sz --ymodem -vv
>> receive_cmd is : rz -vv -E
>> [...]
>> @115200
>> Bytes Sent:1048576   BPS:7762
>> @230400
>> Bytes Sent:1048576   BPS:16372
>> @460800
>> Bytes Sent:1048576   BPS:26681
>> @500000
>> Bytes Sent:1048576   BPS:27689
>> @500000 (2nd run)
>> Bytes Sent:1048576   BPS:27207
>>
>> At this point I stopped testing, I think my adapter is not good enough
>> and that the logic
>> is correct (I've read amlogic's public datasheets [1], but I've not
>> found a formula specified there),
>> Reading address (for hardware device UARTAO1, that _of course_ is not
>> listed there)
>> md.l 0xff803014 1
>> ff803014: 0180000f
>> This corresponds to REG5 of device UARTAO1, with bits 24 (USE_XTAL_CLK), 23
>> (use new baud rate) set, and bits 27 and 26 clear (so 24 MHz crystal
>> clock is divided by 3),
>> NEW_BAUD_RATE is f, so baud rate should be (8 MHz / (15 + 1)) = 500K.
>>
>> Other than that, I noticed that setting the env variable baudrate is
>> restricted to values allowed
>> in a compile time config, loady is not and loady ignores the return
>> value of meson_serial_setbrg
>> (it returns -EINVAL if for example a baudrate higher than 8'000'000 is
>> requested), here's a test
>> (with env variable baudrate=500000):
>> => loady 0x01000000 8000001
>> ## Switch baudrate to 8000001 bps and press ENTER ...
>> ## Ready for binary (ymodem) download to 0x01000000 at 8000001 bps...
>> C
>> *** file: ./dest
>> $ sz --ymodem -vv ./dest
>> Sending: dest
>> Bytes Sent:1048576   BPS:27781
>> Sending:
>> Ymodem sectors/kbytes sent:   0/ 0k
>> Transfer complete
>>
>> *** exit status: 0 ***
>> ## Total Size      = 0x00100000 = 1048576 Bytes
>> ## Start Addr      = 0x01000000
>> ## Switch baudrate to 500000 bps and press ESC ...
>> =>
>>
>> setbrg fails, the baud rate register is left at the 500'000 setting
>> and that's it.
>> I think the "for fun" experiment has gone a bit too far.
>>
>> Edoardo
>> [1] https://dl.radxa.com/zero/docs/hw/IO%20Interface%ef%bc%8dS905Y2%20Datasheet.pdf
> 
> I'll apply it then.
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Oops :
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

> 
> Please send more patches with such quality !
> 
> Thanks,
> Neil
> 
> 
> 
> 
> 

