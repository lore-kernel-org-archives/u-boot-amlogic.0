Subject: Re: [PATCH v3 0/3] ARM: meson: Add G12A USB Support
References: <20190507084339.14723-1-narmstrong@baylibre.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <037a2b22-393a-7df6-9217-5ae797ef5179@denx.de>
Date: Tue, 7 May 2019 15:05:00 +0200
MIME-Version: 1.0
In-Reply-To: <20190507084339.14723-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>, lukma@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 5/7/19 10:43 AM, Neil Armstrong wrote:
> This patchset adds support for USB on Amlogic G12A SoCs.
> 
> This patchset is composed with :
> - PHY Drivers
> - USB Control Glue driver
> - G12A board setup for Device mode
> 
> Device Tree nodes will be added in a separate patchset when applied
> on a tagged Linux tree.
> 
> The Amlogic G12A USB Complex is composed of :
> - 2 USB Controllers :
>  * DWC3 for USB2 and USB3 Host functionality
>  * DWC2 for USB2 Peripheral functionality
> - 2 USB2 OTG PHYs, only a single one will be routed to either DWC2 to DWC3
> - 1 USB3 PHY shared with PCIE funcionnality
> - A Glue to control PHY routing, setup and OTG detection
> 
> The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
> routing of the OTG PHY between the DWC3 and DWC2 controllers, and
> setups the on-chip OTG mode selection for this PHY.
> 
> This drivers supports the on-probe setup of the OTG mode, and manually
> via a setup function in the G12A common board code.
> 
> Changes since v2:
> - rebased on u-boot master
> 
> Changes since v1:
> - switch printf() to debug() in patch 1
> 
> Neil Armstrong (3):
>   usb: dwc3: Add Meson G12A USB Glue
>   phy: meson: add Amlogic G12A USB2 and USB3+PCIE PHY drivers
>   mach-meson: g12a: add DWC2 peripheral mode support
> 
>  arch/arm/include/asm/arch-meson/usb.h |  12 +
>  arch/arm/mach-meson/board-g12a.c      | 126 +++++++
>  drivers/phy/Kconfig                   |   8 +
>  drivers/phy/Makefile                  |   1 +
>  drivers/phy/meson-g12a-usb2.c         | 216 ++++++++++++
>  drivers/phy/meson-g12a-usb3-pcie.c    | 345 +++++++++++++++++++
>  drivers/usb/dwc3/Kconfig              |   8 +
>  drivers/usb/dwc3/Makefile             |   1 +
>  drivers/usb/dwc3/dwc3-meson-g12a.c    | 456 ++++++++++++++++++++++++++
>  9 files changed, 1173 insertions(+)
>  create mode 100644 arch/arm/include/asm/arch-meson/usb.h
>  create mode 100644 drivers/phy/meson-g12a-usb2.c
>  create mode 100644 drivers/phy/meson-g12a-usb3-pcie.c
>  create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c
> 
Looks good to me, pick this via the meson tree please.

-- 
Best regards,
Marek Vasut
