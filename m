Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mx.groups.io with SMTP id smtpd.web12.5346.1608195443825278531
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Dec 2020 00:57:24 -0800
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201217085720epoutp038edb81624359710d9735466a74494d0a~RdTulZQYH2926429264epoutp03C
	for <u-boot-amlogic@groups.io>; Thu, 17 Dec 2020 08:57:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201217085720epoutp038edb81624359710d9735466a74494d0a~RdTulZQYH2926429264epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608195441;
	bh=I5XCRx9jE6RIGkOYEJkF1q5A9Gv13Wxn7quxt3zToRs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
	b=OOCvyz2VhggyPMs5sazcLoZpbelcZhTE3slOGjaBA0NCEEnXgy64pYlx4+Y3OBHS5
	 9/gGwn/LUy0d2oWM/JqWTDt8kbi541CZ2LTO3Mw/OnKUuo6zxNzrEvMIm0CdPHIqs1
	 YHXJbSw7Pe3FsnHQSl6JPcsE7UGET41tlHny+xh0=
Subject: Re: [PATCH] board: amlogic: vim3: read ethernet MAC address from efuse
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <a95b8681-a43b-3838-42d9-2b6202a45f46@samsung.com>
Date: Thu, 17 Dec 2020 17:57:42 +0900
MIME-Version: 1.0
In-Reply-To: <449d0947-d1b1-b79f-cd49-4566f5b8d2fd@baylibre.com>
References: <CGME20201217072655eucas1p123aa0a548e4de21a8ac580dbc990c760@eucas1p1.samsung.com>
	<20201217072642.1319-1-m.szyprowski@samsung.com>
	<449d0947-d1b1-b79f-cd49-4566f5b8d2fd@baylibre.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
To: Neil Armstrong <narmstrong@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

On 12/17/20 5:43 PM, Neil Armstrong wrote:
> On 17/12/2020 08:26, Marek Szyprowski wrote:
>> Add the board specific code for reading built-in ethernet MAC address
>> from efuse.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  board/amlogic/vim3/vim3.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
>> index 09ef39ff30..a36df61583 100644
>> --- a/board/amlogic/vim3/vim3.c
>> +++ b/board/amlogic/vim3/vim3.c
>> @@ -11,6 +11,7 @@
>>  #include <net.h>
>>  #include <asm/io.h>
>>  #include <asm/arch/eth.h>
>> +#include <asm/arch/sm.h>
>>  #include <i2c.h>
>>  #include "khadas-mcu.h"
>>  
>> @@ -129,9 +130,27 @@ int meson_ft_board_setup(void *blob, struct bd_info *bd)
>>  	return 0;
>>  }
>>  
>> +#define EFUSE_MAC_OFFSET	0
>> +#define EFUSE_MAC_SIZE		6
>> +
>>  int misc_init_r(void)
>>  {
>> +	uint8_t mac_addr[EFUSE_MAC_SIZE];
>> +	ssize_t len;
>> +
>>  	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
>>  
>> +	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
>> +		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
>> +					  mac_addr, EFUSE_MAC_SIZE);
>> +		if (len != EFUSE_MAC_SIZE)
>> +			return 0;
>> +
>> +		if (is_valid_ethaddr(mac_addr))
>> +			eth_env_set_enetaddr("ethaddr", mac_addr);
>> +		else
>> +			meson_generate_serial_ethaddr();
>> +	}
>> +
>>  	return 0;
>>  }
>>
> 
> Thx, I wasn't aware Khadas flashed the MAC address in the fuse
> 
> I'll do a quick test on my boards.
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> 
> Neil
> 

