Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web10.11333.1589202205387012052
 for <u-boot-amlogic@groups.io>;
 Mon, 11 May 2020 06:03:26 -0700
Received: by mail-wr1-f65.google.com with SMTP id x17so10876331wrt.5
        for <u-boot-amlogic@groups.io>; Mon, 11 May 2020 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yr/nLi3tlcIEgqit2CGPLy+MorgJZqumm6uG4HY12yk=;
        b=w4qxgygES0wkdVelTTgRxI+j92eU69SnzqG3KcyU2ifn/DV112d6BCTCMJsWG+mmKT
         ys6uqS9KyesG5l/SJ/leabmVMnuVDTHfpJcBqv/1u8OFVK6yMqf1rSsDZnepK/9KpGTP
         Maoqt7HpsnVBiDpp3AwU5oNiafDu5bN3p65loAKy+C06035F74s0ZzJrXHJHLwLwSM3g
         nzcM5ekc2fpwZYJnrSKdSCcCh8zANnXPXGQtkHUyhK4+sOrAM465VGqij4gRFIZuwxLY
         mtLAB4jfP3pWd86Fv1jTSRalMOfML3w20ggP4mmQ2X/DsqCL6z4WLnY0siW8f8PolKb1
         XuCw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] odroid-c2: enable USB host controller
References: <20190818134255.7135-1-b.galvani@gmail.com>
 <20190818134255.7135-3-b.galvani@gmail.com> <20200510140829.GA1602@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <f5ddd116-685e-4da0-cc40-40e4067b032b@baylibre.com>
Date: Mon, 11 May 2020 15:03:20 +0200
MIME-Version: 1.0
In-Reply-To: <20200510140829.GA1602@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Beniamino Galvani <b.galvani@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@ti.com>, Albert Aribaud <albert.u.boot@aribaud.net>, Maxime Jourdan <mjourdan@baylibre.com>, Patrick Delaunay <patrick.delaunay@st.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,
On 10/05/2020 16:08, Beniamino Galvani wrote:
> On Sun, Aug 18, 2019 at 03:42:55PM +0200, Beniamino Galvani wrote:
>> Enable the second USB controller, which is connected to a hub with 4
>> ports. The first controller is for the OTG port and is currently not
>> supported.
>>
>> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
>> ---
>>  arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi | 8 ++++++++
>>  configs/odroid-c2_defconfig                  | 7 +++++++
>>  include/configs/meson64.h                    | 5 +++++
>>  3 files changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
>> index c35158d7e9..484b40504d 100644
>> --- a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
>> +++ b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
>> @@ -5,3 +5,11 @@
>>   */
>>  
>>  #include "meson-gx-u-boot.dtsi"
>> +
>> +&usb0 {
>> +	status = "disabled";
>> +};
>> +
>> +&usb1 {
>> +	hnp-srp-disable;
>> +};
>> diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
>> index 8849058d33..366ea125af 100644
>> --- a/configs/odroid-c2_defconfig
>> +++ b/configs/odroid-c2_defconfig
>> @@ -16,6 +16,7 @@ CONFIG_CMD_GPIO=y
>>  CONFIG_CMD_I2C=y
>>  # CONFIG_CMD_LOADS is not set
>>  CONFIG_CMD_MMC=y
>> +CONFIG_CMD_USB=y
>>  # CONFIG_CMD_SETEXPR is not set
>>  CONFIG_CMD_REGULATOR=y
>>  CONFIG_OF_CONTROL=y
>> @@ -29,13 +30,19 @@ CONFIG_MMC_MESON_GX=y
>>  CONFIG_PHY_REALTEK=y
>>  CONFIG_DM_ETH=y
>>  CONFIG_ETH_DESIGNWARE=y
>> +CONFIG_PHY=y
>> +CONFIG_MESON_GXBB_USB_PHY=y
>>  CONFIG_PINCTRL=y
>>  CONFIG_PINCTRL_MESON_GXBB=y
>>  CONFIG_DM_REGULATOR=y
>>  CONFIG_DM_REGULATOR_FIXED=y
>> +CONFIG_DM_REGULATOR_GPIO=y
>>  CONFIG_DM_RESET=y
>>  CONFIG_DEBUG_UART_MESON=y
>>  CONFIG_DEBUG_UART_ANNOUNCE=y
>>  CONFIG_DEBUG_UART_SKIP_INIT=y
>>  CONFIG_MESON_SERIAL=y
>> +CONFIG_USB=y
>> +CONFIG_DM_USB=y
>> +CONFIG_USB_DWC2=y
>>  CONFIG_OF_LIBFDT_OVERLAY=y
>> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
>> index f8d3eee292..483a8f567c 100644
>> --- a/include/configs/meson64.h
>> +++ b/include/configs/meson64.h
>> @@ -16,6 +16,11 @@
>>  #define GICC_BASE			0xc4302000
>>  #endif
>>  
>> +/* USB */
>> +#if defined(CONFIG_MESON_GXBB)
>> +#define CONFIG_DWC2_UTMI_WIDTH		16
>> +#endif
> 
> Hi Neil,
> 
> I noticed this change to the bus width configuration isn't actually
> needed. The USB port works with or without it. The kernel driver
> doesn't set 16bit mode, so can you please remove these 4 lines from
> the commit before sending the pull request?
> 
> Thanks,
> Beniamino
> 

Thanks,

I altered the commit removing this.

Neil
