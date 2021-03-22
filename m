Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.70.199])
 by mx.groups.io with SMTP id smtpd.web12.10395.1616405263942933916
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Mar 2021 02:27:44 -0700
Message-ID: <8cb80b89-8305-35fe-a876-6bf613646c1c@rock-chips.com>
Date: Mon, 22 Mar 2021 17:27:38 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFT 0/4] pci: add common Designware PCIe functions and support Amlogic Meson PCIe controller
References: <20210322091812.2511462-1-narmstrong@baylibre.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210322091812.2511462-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>, lokeshvutla@ti.com, nsekhar@ti.com
Cc: shawn.lin@rock-chips.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On 2021/3/22 17:18, Neil Armstrong wrote:
> With the introduction of pcie_dw_rockchip, and need to support the DW PCIe in the
> Amlogic AXG & G12 SoCs, most of the DW PCIe helpers would be duplicated.
> 
> This introduce a "common" DW PCIe helpers file with common code merged from the
> dw_ti and dw_rockchip drivers and adapted to fit with the upcoming dw_meson.

That's a good idea.

BTW, pcie_dw_mvebu.c and  pcie_imx.c also should need a migration.

> 
> The following changes will switch the dw_ti and dw_rockchip, and introduce a new
> driver to support the Amlogic AXG & G12 SoCs using these new common helpers.
> 
> The dw_meson has been validated, but the dw_ti and dw_rockchip would need testing
> on hardware to validate nothing has been broken.
> 
> Neil Armstrong (4):
>    pci: add common Designware PCIe functions
>    pci: pcie_dw_ti: migrate to common Designware PCIe functions
>    pci: pcie_dw_rockchip: migrate to common Designware PCIe functions
>    pci: add Amlogic Meson Designware PCIe controller
> 
>   drivers/pci/Kconfig            |  15 +-
>   drivers/pci/Makefile           |   2 +
>   drivers/pci/pcie_dw_common.c   | 352 ++++++++++++++++++++++++
>   drivers/pci/pcie_dw_common.h   | 153 +++++++++++
>   drivers/pci/pcie_dw_meson.c    | 459 ++++++++++++++++++++++++++++++++
>   drivers/pci/pcie_dw_rockchip.c | 472 ++-------------------------------
>   drivers/pci/pcie_dw_ti.c       | 444 +++----------------------------
>   7 files changed, 1046 insertions(+), 851 deletions(-)
>   create mode 100644 drivers/pci/pcie_dw_common.c
>   create mode 100644 drivers/pci/pcie_dw_common.h
>   create mode 100644 drivers/pci/pcie_dw_meson.c
> 


