Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.10141.1616405431071217271
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Mar 2021 02:30:31 -0700
Received: by mail-wr1-f54.google.com with SMTP id b9so15870160wrt.8
        for <u-boot-amlogic@groups.io>; Mon, 22 Mar 2021 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qrgEXSu6mp2vzO2VpX0WpVmmnnMoXFKgMuvQE3yJ0sE=;
        b=owbYgnXD2okw2NAnOGmtUyq1+eT2VaKRV8B1MB/Bbnz3TuUa+UwAXGR9vyUt0XG+PU
         zYCbch1M0u86Y9isigHpWJZgOwFxtPE1ofCvrdCWbKa+0Z6RS5Ck9Y+7e+lri4HaVcjf
         hLreEyhBo/EMEY0dGxpM9nKU163icfV0z+Izx5D78SF68kWVatcZzvgqrigJSV2vjrWF
         swhS+JZ1A2fVTCa0H3Ws9P7fBNkNCxvE+IIELeagySRnvaKFlTn8mZuBCmnqq1mO3k2X
         BDPOn9Tr2tDKtYoxIFKLwCO9PhoBbYTUWviNSkBuOqGn2RoLsvD5LFJpJnrUgHzB9oMw
         YW/Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH RFT 0/4] pci: add common Designware PCIe functions and support Amlogic Meson PCIe controller
References: <20210322091812.2511462-1-narmstrong@baylibre.com>
 <8cb80b89-8305-35fe-a876-6bf613646c1c@rock-chips.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <385bb9af-ad2f-4871-0cc1-432dba4d964a@baylibre.com>
Date: Mon, 22 Mar 2021 10:30:27 +0100
MIME-Version: 1.0
In-Reply-To: <8cb80b89-8305-35fe-a876-6bf613646c1c@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Shawn Lin <shawn.lin@rock-chips.com>, lokeshvutla@ti.com, nsekhar@ti.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 22/03/2021 10:27, Shawn Lin wrote:
> Hi Neil,
> 
> On 2021/3/22 17:18, Neil Armstrong wrote:
>> With the introduction of pcie_dw_rockchip, and need to support the DW PCIe in the
>> Amlogic AXG & G12 SoCs, most of the DW PCIe helpers would be duplicated.
>>
>> This introduce a "common" DW PCIe helpers file with common code merged from the
>> dw_ti and dw_rockchip drivers and adapted to fit with the upcoming dw_meson.
> 
> That's a good idea.
> 
> BTW, pcie_dw_mvebu.c and  pcie_imx.c also should need a migration.

Exact, same for the recently submitted pci_sifive, they should probably wait for a second round

Neil

> 
>>
>> The following changes will switch the dw_ti and dw_rockchip, and introduce a new
>> driver to support the Amlogic AXG & G12 SoCs using these new common helpers.
>>
>> The dw_meson has been validated, but the dw_ti and dw_rockchip would need testing
>> on hardware to validate nothing has been broken.
>>
>> Neil Armstrong (4):
>>    pci: add common Designware PCIe functions
>>    pci: pcie_dw_ti: migrate to common Designware PCIe functions
>>    pci: pcie_dw_rockchip: migrate to common Designware PCIe functions
>>    pci: add Amlogic Meson Designware PCIe controller
>>
>>   drivers/pci/Kconfig            |  15 +-
>>   drivers/pci/Makefile           |   2 +
>>   drivers/pci/pcie_dw_common.c   | 352 ++++++++++++++++++++++++
>>   drivers/pci/pcie_dw_common.h   | 153 +++++++++++
>>   drivers/pci/pcie_dw_meson.c    | 459 ++++++++++++++++++++++++++++++++
>>   drivers/pci/pcie_dw_rockchip.c | 472 ++-------------------------------
>>   drivers/pci/pcie_dw_ti.c       | 444 +++----------------------------
>>   7 files changed, 1046 insertions(+), 851 deletions(-)
>>   create mode 100644 drivers/pci/pcie_dw_common.c
>>   create mode 100644 drivers/pci/pcie_dw_common.h
>>   create mode 100644 drivers/pci/pcie_dw_meson.c
>>
> 
> 

