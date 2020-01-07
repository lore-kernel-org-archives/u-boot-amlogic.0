Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.3965.1578392164314389174
 for <u-boot-amlogic@groups.io>;
 Tue, 07 Jan 2020 02:16:04 -0800
Received: by mail-wr1-f67.google.com with SMTP id y17so53270573wrh.5
        for <u-boot-amlogic@groups.io>; Tue, 07 Jan 2020 02:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xknX+9MAgHp7ABExlsvf3GSt4cWIUmP/we/9BxBb1fY=;
        b=RSw2nPmrfzFA9NF1oNdvBRzSSEFk71sM1HDTGSzShkjgNJCajnAOhwo8bvBrlEGNWW
         yWO121Sb/iiMprpSjCtJLYwcBISiKHXFmH+9fZDvGLpGjIPuXM4enObW57jfuexI1khZ
         JT0GDcheJJMGjHwuIx7LM89Ba0h4fSe4DjtbrpvvqiTA7+vPI2Ff5YrvP0ECW9zFHjgb
         9S8glydrLMFP2Izu3848StaqmjpxP7pTkgkzuINkQCsvNsJFqxO6TZ2lRoTmZoYz61xX
         SnNsyjA2nh/gc/zgXyPFx94qo+BSDapTmlV4KeBMdEKSZewU3ne86d+G7s/kQY8xl5Od
         eXng==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 23/30] video: meson: Drop unnecessary header includes
From: "Neil Armstrong" <narmstrong@baylibre.com>
References: <20191027155410.187957-1-sjg@chromium.org>
 <20191027155410.187957-23-sjg@chromium.org>
 <aa3e6b42-a3f6-bbe1-4d66-02aa1597a2cf@baylibre.com>
Message-ID: <f62ed074-22b3-3bf3-196e-9446cc9f63d2@baylibre.com>
Date: Tue, 7 Jan 2020 11:16:01 +0100
MIME-Version: 1.0
In-Reply-To: <aa3e6b42-a3f6-bbe1-4d66-02aa1597a2cf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 27/10/2019 18:48, Neil Armstrong wrote:
> On 27/10/2019 16:54, Simon Glass wrote:
>> These files should not be included in meson header files. Drop them and
>> tidy up the affected C files.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>>  drivers/video/meson/meson_canvas.c   |  4 ++++
>>  drivers/video/meson/meson_plane.c    |  5 +++++
>>  drivers/video/meson/meson_vclk.c     |  2 ++
>>  drivers/video/meson/meson_venc.c     |  4 ++++
>>  drivers/video/meson/meson_vpu.c      | 18 +++++++++++++++---
>>  drivers/video/meson/meson_vpu.h      | 17 +++++------------
>>  drivers/video/meson/meson_vpu_init.c |  4 ++++
>>  include/video.h                      |  2 ++
>>  8 files changed, 41 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/video/meson/meson_canvas.c b/drivers/video/meson/meson_canvas.c
>> index b71cbfcc0b..eccac2f8f2 100644
>> --- a/drivers/video/meson/meson_canvas.c
>> +++ b/drivers/video/meson/meson_canvas.c
>> @@ -6,6 +6,10 @@
>>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>>   */
>>  
>> +#include <common.h>
>> +#include <dm.h>
>> +#include <asm/io.h>
>> +
>>  #include "meson_vpu.h"
>>  
>>  /* DMC Registers */
>> diff --git a/drivers/video/meson/meson_plane.c b/drivers/video/meson/meson_plane.c
>> index 2bc9327e1e..8edf451f13 100644
>> --- a/drivers/video/meson/meson_plane.c
>> +++ b/drivers/video/meson/meson_plane.c
>> @@ -6,6 +6,11 @@
>>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>>   */
>>  
>> +#include <common.h>
>> +#include <dm.h>
>> +#include <asm/io.h>
>> +#include <linux/bitfield.h>
>> +
>>  #include "meson_vpu.h"
>>  
>>  /* OSDx_BLKx_CFG */
>> diff --git a/drivers/video/meson/meson_vclk.c b/drivers/video/meson/meson_vclk.c
>> index 0f628e920b..01bfa4bcb8 100644
>> --- a/drivers/video/meson/meson_vclk.c
>> +++ b/drivers/video/meson/meson_vclk.c
>> @@ -6,6 +6,8 @@
>>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>>   */
>>  
>> +#include <common.h>
>> +#include <dm.h>
>>  #include <edid.h>
>>  #include "meson_vpu.h"
>>  #include <linux/iopoll.h>
>> diff --git a/drivers/video/meson/meson_venc.c b/drivers/video/meson/meson_venc.c
>> index 5da4b3f096..89e859b02a 100644
>> --- a/drivers/video/meson/meson_venc.c
>> +++ b/drivers/video/meson/meson_venc.c
>> @@ -6,7 +6,11 @@
>>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>>   */
>>  
>> +#include <common.h>
>> +#include <dm.h>
>>  #include <edid.h>
>> +#include <fdtdec.h>
>> +#include <asm/io.h>
>>  #include "meson_vpu.h"
>>  
>>  enum {
>> diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
>> index c3af9b013c..4eb66398d0 100644
>> --- a/drivers/video/meson/meson_vpu.c
>> +++ b/drivers/video/meson/meson_vpu.c
>> @@ -6,13 +6,17 @@
>>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>>   */
>>  
>> -#include "meson_vpu.h"
>> +#include <common.h>
>> +#include <display.h>
>> +#include <dm.h>
>>  #include <efi_loader.h>
>> -#include <dm/device-internal.h>
>> -#include <dm/uclass-internal.h>
>>  #include <fdt_support.h>
>>  #include <linux/sizes.h>
>>  #include <asm/arch/mem.h>
>> +#include <dm/device-internal.h>
>> +#include <dm/uclass-internal.h>
>> +
>> +#include "meson_vpu.h"
>>  #include "meson_registers.h"
>>  #include "simplefb_common.h"
>>  
>> @@ -27,6 +31,14 @@ static struct meson_framebuffer {
>>  	bool is_cvbs;
>>  } meson_fb = { 0 };
>>  
>> +bool meson_vpu_is_compatible(struct meson_vpu_priv *priv,
>> +			     enum vpu_compatible family)
>> +{
>> +	enum vpu_compatible compat = dev_get_driver_data(priv->dev);
>> +
>> +	return compat == family;
>> +}
>> +
>>  static int meson_vpu_setup_mode(struct udevice *dev, struct udevice *disp)
>>  {
>>  	struct video_uc_platdata *uc_plat = dev_get_uclass_platdata(dev);
>> diff --git a/drivers/video/meson/meson_vpu.h b/drivers/video/meson/meson_vpu.h
>> index 0d9fddad2e..d9588c3775 100644
>> --- a/drivers/video/meson/meson_vpu.h
>> +++ b/drivers/video/meson/meson_vpu.h
>> @@ -9,14 +9,12 @@
>>  #ifndef __MESON_VPU_H__
>>  #define __MESON_VPU_H__
>>  
>> -#include <common.h>
>> -#include <dm.h>
>>  #include <video.h>
>> -#include <display.h>
>> -#include <linux/io.h>
>> -#include <linux/bitfield.h>
>>  #include "meson_registers.h"
>>  
>> +struct display_timing;
>> +struct udevice;
>> +
>>  enum {
>>  	/* Maximum size we support */
>>  	VPU_MAX_WIDTH		= 3840,
>> @@ -38,13 +36,8 @@ struct meson_vpu_priv {
>>  	void __iomem *dmc_base;
>>  };
>>  
>> -static inline bool meson_vpu_is_compatible(struct meson_vpu_priv *priv,
>> -					   enum vpu_compatible family)
>> -{
>> -	enum vpu_compatible compat = dev_get_driver_data(priv->dev);
>> -
>> -	return compat == family;
>> -}
>> +bool meson_vpu_is_compatible(struct meson_vpu_priv *priv,
>> +			     enum vpu_compatible family);
>>  
>>  #define hhi_update_bits(offset, mask, value) \
>>  	writel_bits(mask, value, priv->hhi_base + offset)
>> diff --git a/drivers/video/meson/meson_vpu_init.c b/drivers/video/meson/meson_vpu_init.c
>> index 12f8c4194a..8408c59eaa 100644
>> --- a/drivers/video/meson/meson_vpu_init.c
>> +++ b/drivers/video/meson/meson_vpu_init.c
>> @@ -8,6 +8,10 @@
>>  
>>  #define DEBUG
>>  
>> +#include <common.h>
>> +#include <dm.h>
>> +#include <asm/io.h>
>> +
>>  #include "meson_vpu.h"
>>  
>>  /* HHI Registers */
>> diff --git a/include/video.h b/include/video.h
>> index 485071d072..e7c58e86cb 100644
>> --- a/include/video.h
>> +++ b/include/video.h
>> @@ -17,6 +17,8 @@
>>  
>>  #include <stdio_dev.h>
>>  
>> +struct udevice;
>> +
>>  struct video_uc_platdata {
>>  	uint align;
>>  	uint size;
>>
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> 

Applied to u-boot-amlogic

Neil
