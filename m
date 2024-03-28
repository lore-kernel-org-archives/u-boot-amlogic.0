Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F62C54E67
	for <webhook@archiver.kernel.org>; Thu, 28 Mar 2024 07:50:27 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.10255.1711612213322081126
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Mar 2024 00:50:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ktIaW+/O;
 spf=pass (domain: linaro.org, ip: 209.85.128.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41494c040a1so4408775e9.2
        for <u-boot-amlogic@groups.io>; Thu, 28 Mar 2024 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711612212; x=1712217012; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPzO6S5PTuA89enu0ZegM0OZvfexbsxFVvIsm04Tn4s=;
        b=ktIaW+/OLeeS21DSRVpHL3gwxHi93isGD81e9FOfCT7h3BeSftzFU4l2S7n5pPUQHn
         i5ZoSvTvRR7xk6DDkoJXJFI2iPp+KXg0JgfGvy8an65/Q4l4i7lbC5op/Je+dEuYjUuY
         aHEed3I6vDjDYYfE98QeFVJ7pj8T0EGT+XRcWa61faFWxBszPaJJqmYMk9pqWuvwGPvX
         LCFo2y9Gp3L63Z0ds2oxD7hg/92z9+mKOCeVaNOH3VWryS8mNM7BUBINCqZxaViS9Zzk
         Fhx7KhG7+z+kF7U0y+STcBPAsU+bzKXfc3gupJw0d+slsGrH9Ch672GzJ85UDKMLVP7E
         zGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612212; x=1712217012;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UPzO6S5PTuA89enu0ZegM0OZvfexbsxFVvIsm04Tn4s=;
        b=SHBFm2BNGJ/LC4WDkwf4TtM2e7CB9D044hQyDl+OVKmn3CxNjrBvhyLqzC/UpvoIkA
         fco3Pg25xytiu7ZU6AvdVn1xLV8ZZ2UrJMbUyjtei0qcMWUUyBuBI0XWr55pq1ZuY3d8
         1vijs8UTcL2vz94Ny7Ui6Z56j30oDWfHanjIjPAbAexsSz9ou5IsAv2xQ1CmlsajKHz8
         wiGNvUysGqcRkuLPigEs9Sz5T/NFDBSSHrfxZ/lds6y5JkpA2NU1xvsRZqWN6Uimaisj
         JMoppjFsQ2q87AOb7SCrwKh3nN12Z37X6P2iMlX5+yKhs7BgGgs+INC1e4kgFXN+VBFs
         5sBA==
X-Gm-Message-State: AOJu0YxylecHxLlBTTrT4IVppfmvVDxfhyOptx6am9NNZRspOkJbaNJy
	vZIoc4EgOiedNcBvzfJKaCUAz9kZkQRkbXE8HACmfmHKN8QJ7hApY/W35n48doQ=
X-Google-Smtp-Source: AGHT+IHcZ6XzPTYDEznA7AGQIjPvj+ce/pWsz3Ixh7OH2Qd76AcgL+uMZY/ah6X1jZfX5yaYoNccXA==
X-Received: by 2002:a05:600c:3b9f:b0:415:45ba:bf55 with SMTP id n31-20020a05600c3b9f00b0041545babf55mr531917wms.34.1711612211508;
        Thu, 28 Mar 2024 00:50:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6306:1c7a:72c2:892a? ([2a01:e0a:982:cbb0:6306:1c7a:72c2:892a])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05600c1f1100b0041493615585sm1396048wmb.39.2024.03.28.00.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:50:11 -0700 (PDT)
Message-ID: <f8fce939-f095-449f-816e-39a96f8e298f@linaro.org>
Date: Thu, 28 Mar 2024 08:50:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/4] arm: meson: Switch to using upstream DT for GXL, GXM,
 AXG, G12A, G12B & SM1 SoCs
To: Viacheslav <adeep@lexina.in>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Christian Hewitt <christianshewitt@gmail.com>
References: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
 <045a8bb4-e061-4727-9f07-a55825a99518@linaro.org>
 <3a411122-fefa-4193-b988-ba3b35449946@lexina.in>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <3a411122-fefa-4193-b988-ba3b35449946@lexina.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 28 Mar 2024 07:50:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2251

Hi,

On 28/03/2024 07:58, Viacheslav wrote:
> Hi, Neil!
> 
> With this patchset I got wrong fdt link in env with double prefix:
> 
> fdtfile=amlogic/amlogic/meson-gxl-s905w-jethome-jethub-j80.dtb
> 
> 
> but if i remove "amlogic" prefix in config it does not build
> 
> --- a/configs/jethub_j80_defconfig
> +++ b/configs/jethub_j80_defconfig
> -CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905w-jethome-jethub-j80"
> +CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905w-jethome-jethub-j80"
> 
> 
> Error:
> 
> make[2]: *** No rule to make target 'dts/upstream/src/arm64/meson-gxl-s905w-jethome-jethub-j80.dtb', needed by 'dtbs'.  Stop.
> make[1]: *** [dts/Makefile:54: arch-dtbs] Error 2
> make: *** [Makefile:1166: dts/dt.dtb] Error 2

You're right, I forgot to remove the fdtfile prefix, can you retry with:

=====><===========================================
diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index efab9a624d..65fa5f3d6d 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -120,6 +120,12 @@

  #include <config_distro_bootcmd.h>

+#ifdef CONFIG_OF_UPSTREAM
+#define FDTFILE_NAME           CONFIG_DEFAULT_DEVICE_TREE ".dtb"
+#else
+#define FDTFILE_NAME           "amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb"
+#endif
+
  #ifndef CFG_EXTRA_ENV_SETTINGS
  #define CFG_EXTRA_ENV_SETTINGS \
         "stdin=" STDIN_CFG "\0" \
@@ -133,7 +139,7 @@
         "pxefile_addr_r=" PXEFILE_ADDR_R "\0" \
         "fdtoverlay_addr_r=" FDTOVERLAY_ADDR_R "\0" \
         "ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
-       "fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
+       "fdtfile=" FDTFILE_NAME "\0" \
         "dfu_alt_info=fitimage ram " KERNEL_ADDR_R " 0x4000000 \0" \
         BOOTENV
  #endif
=====><===========================================

Thanks,
Neil

> 
> 
> 
> 22/03/2024 12.03, Neil Armstrong:
>> Hi Viacheslav,
>>
>> On 19/03/2024 15:42, Neil Armstrong wrote:
>>> Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
>>> DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
>>> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
>>> drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
>>> kept in arch/arm/dts directory for these boards.
>>>
>>> Keep A1 DTs locally since the architecture is still young.
>>>
>>> CI built & tested at:
>>> https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/pipelines/1219273552
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>> Neil Armstrong (4):
>>>        dts: meson: Switch GXL, GXM & AXG to using upstream DT
>>>        dts: meson: Drop redundant GXL, GXM & AXG devicetree files
>>
>> Could you run a test run on your boards so make sure is still boots fine ?
>>
>> Thanks,
>> Neil
>>
>>>        dts: meson-g12a: Switch to using upstream DT
>>>        dts: meson: Drop redundant G12A, G12B & SM1 devicetree files
>>>
>>>   arch/arm/dts/Makefile                              |   36 +-
>>>   arch/arm/dts/meson-axg-jethome-jethub-j100.dts     |  361 ---
>>>   arch/arm/dts/meson-axg-s400.dts                    |  602 -----
>>>   arch/arm/dts/meson-axg.dtsi                        | 1957 ---------------
>>>   arch/arm/dts/meson-g12-common.dtsi                 | 2493 --------------------
>>>   arch/arm/dts/meson-g12.dtsi                        |  385 ---
>>>   arch/arm/dts/meson-g12a-radxa-zero.dts             |  405 ----
>>>   arch/arm/dts/meson-g12a-sei510.dts                 |  566 -----
>>>   arch/arm/dts/meson-g12a-u200.dts                   |  308 ---
>>>   arch/arm/dts/meson-g12a.dtsi                       |  140 --
>>>   arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts     |   33 -
>>>   arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   41 -
>>>   arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 --
>>>   arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     |  165 --
>>>   arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          |  388 ---
>>>   arch/arm/dts/meson-g12b-bananapi.dtsi              |  521 ----
>>>   arch/arm/dts/meson-g12b-gsking-x.dts               |  133 --
>>>   arch/arm/dts/meson-g12b-gtking-pro.dts             |  142 --
>>>   arch/arm/dts/meson-g12b-gtking.dts                 |  163 --
>>>   arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  107 -
>>>   arch/arm/dts/meson-g12b-odroid-go-ultra.dts        |  722 ------
>>>   arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |   31 -
>>>   arch/arm/dts/meson-g12b-odroid-n2.dts              |   15 -
>>>   arch/arm/dts/meson-g12b-odroid-n2.dtsi             |  303 ---
>>>   arch/arm/dts/meson-g12b-odroid-n2l.dts             |  125 -
>>>   arch/arm/dts/meson-g12b-odroid.dtsi                |  445 ----
>>>   arch/arm/dts/meson-g12b-radxa-zero2.dts            |  489 ----
>>>   arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts     |   14 -
>>>   arch/arm/dts/meson-g12b-s922x.dtsi                 |  139 --
>>>   arch/arm/dts/meson-g12b-w400.dtsi                  |  425 ----
>>>   arch/arm/dts/meson-g12b.dtsi                       |  146 --
>>>   arch/arm/dts/meson-gx-libretech-pc.dtsi            |  447 ----
>>>   arch/arm/dts/meson-gx-mali450.dtsi                 |   61 -
>>>   arch/arm/dts/meson-gx-p23x-q20x.dtsi               |  324 ---
>>>   arch/arm/dts/meson-gx.dtsi                         |  675 ------
>>>   arch/arm/dts/meson-gxl-mali.dtsi                   |   17 -
>>>   arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  319 ---
>>>   arch/arm/dts/meson-gxl-s805x.dtsi                  |   23 -
>>>   arch/arm/dts/meson-gxl-s905d-libretech-pc.dts      |   16 -
>>>   arch/arm/dts/meson-gxl-s905d.dtsi                  |   12 -
>>>   .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  247 --
>>>   arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  237 --
>>>   arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |  313 ---
>>>   arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  356 ---
>>>   arch/arm/dts/meson-gxl-s905x-p212.dts              |  134 --
>>>   arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  213 --
>>>   arch/arm/dts/meson-gxl-s905x.dtsi                  |   18 -
>>>   arch/arm/dts/meson-gxl.dtsi                        |  940 --------
>>>   arch/arm/dts/meson-gxm-gt1-ultimate.dts            |   91 -
>>>   arch/arm/dts/meson-gxm-khadas-vim2.dts             |  424 ----
>>>   arch/arm/dts/meson-gxm-s912-libretech-pc.dts       |   62 -
>>>   arch/arm/dts/meson-gxm-wetek-core2.dts             |   85 -
>>>   arch/arm/dts/meson-gxm.dtsi                        |  216 --
>>>   arch/arm/dts/meson-khadas-vim3.dtsi                |  534 -----
>>>   arch/arm/dts/meson-sm1-bananapi-m2-pro.dts         |   97 -
>>>   arch/arm/dts/meson-sm1-bananapi-m5.dts             |  221 --
>>>   arch/arm/dts/meson-sm1-bananapi.dtsi               |  435 ----
>>>   arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  113 -
>>>   arch/arm/dts/meson-sm1-odroid-c4.dts               |   48 -
>>>   arch/arm/dts/meson-sm1-odroid-hc4.dts              |  140 --
>>>   arch/arm/dts/meson-sm1-odroid.dtsi                 |  449 ----
>>>   arch/arm/dts/meson-sm1-sei610.dts                  |  616 -----
>>>   arch/arm/dts/meson-sm1.dtsi                        |  550 -----
>>>   arch/arm/mach-meson/Kconfig                        |    4 +
>>>   configs/bananapi-cm4-cm4io_defconfig               |    2 +-
>>>   configs/bananapi-m2-pro_defconfig                  |    2 +-
>>>   configs/bananapi-m2s_defconfig                     |    2 +-
>>>   configs/bananapi-m5_defconfig                      |    2 +-
>>>   configs/beelink-gsking-x_defconfig                 |    2 +-
>>>   configs/beelink-gt1-ultimate_defconfig             |    2 +-
>>>   configs/beelink-gtking_defconfig                   |    2 +-
>>>   configs/beelink-gtkingpro_defconfig                |    2 +-
>>>   configs/jethub_j100_defconfig                      |    2 +-
>>>   configs/jethub_j80_defconfig                       |    2 +-
>>>   configs/khadas-vim2_defconfig                      |    2 +-
>>>   configs/khadas-vim3_android_ab_defconfig           |    2 +-
>>>   configs/khadas-vim3_android_defconfig              |    2 +-
>>>   configs/khadas-vim3_defconfig                      |    2 +-
>>>   configs/khadas-vim3l_android_ab_defconfig          |    2 +-
>>>   configs/khadas-vim3l_android_defconfig             |    2 +-
>>>   configs/khadas-vim3l_defconfig                     |    2 +-
>>>   configs/khadas-vim_defconfig                       |    2 +-
>>>   configs/libretech-ac_defconfig                     |    2 +-
>>>   configs/libretech-cc_defconfig                     |    2 +-
>>>   configs/libretech-cc_v2_defconfig                  |    2 +-
>>>   configs/libretech-s905d-pc_defconfig               |    2 +-
>>>   configs/libretech-s912-pc_defconfig                |    2 +-
>>>   configs/odroid-c4_defconfig                        |    2 +-
>>>   configs/odroid-go-ultra_defconfig                  |    2 +-
>>>   configs/odroid-hc4_defconfig                       |    2 +-
>>>   configs/odroid-n2_defconfig                        |    2 +-
>>>   configs/odroid-n2l_defconfig                       |    2 +-
>>>   configs/p212_defconfig                             |    2 +-
>>>   configs/radxa-zero2_defconfig                      |    2 +-
>>>   configs/radxa-zero_defconfig                       |    2 +-
>>>   configs/s400_defconfig                             |    2 +-
>>>   configs/sei510_defconfig                           |    2 +-
>>>   configs/sei610_defconfig                           |    2 +-
>>>   configs/u200_defconfig                             |    2 +-
>>>   configs/wetek-core2_defconfig                      |    2 +-
>>>   include/dt-bindings/gpio/meson-axg-gpio.h          |  116 -
>>>   include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 -
>>>   include/dt-bindings/gpio/meson-gxbb-gpio.h         |  148 --
>>>   include/dt-bindings/gpio/meson-gxl-gpio.h          |  125 -
>>>   include/dt-bindings/power/meson-axg-power.h        |   14 -
>>>   include/dt-bindings/power/meson-g12a-power.h       |   13 -
>>>   include/dt-bindings/power/meson-gxbb-power.h       |   13 -
>>>   include/dt-bindings/power/meson-sm1-power.h        |   18 -
>>>   .../reset/amlogic,meson-axg-audio-arb.h            |   19 -
>>>   .../dt-bindings/reset/amlogic,meson-axg-reset.h    |  123 -
>>>   .../reset/amlogic,meson-g12a-audio-reset.h         |   53 -
>>>   .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  137 --
>>>   .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |  161 --
>>>   include/dt-bindings/sound/meson-aiu.h              |   18 -
>>>   include/dt-bindings/sound/meson-g12a-toacodec.h    |   10 -
>>>   include/dt-bindings/sound/meson-g12a-tohdmitx.h    |   13 -
>>>   116 files changed, 42 insertions(+), 21511 deletions(-)
>>> ---
>>> base-commit: b145877c22b391a4872c875145a8f86f6ffebaba
>>> change-id: 20240319-u-boot-of-upstream-46454fded5ea
>>>
>>> Best regards,
>>
> 
> -- 
> Best regards,
> Viacheslav


