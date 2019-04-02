Subject: Re: [PATCH v2 1/3] usb: dwc3: Add Meson G12A USB Glue
References: <20190401124657.29736-1-narmstrong@baylibre.com>
 <20190401124657.29736-2-narmstrong@baylibre.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <4bf37bf7-f50b-00ce-ad5d-2514814881d9@denx.de>
Date: Tue, 2 Apr 2019 03:02:49 +0200
MIME-Version: 1.0
In-Reply-To: <20190401124657.29736-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 4/1/19 2:46 PM, Neil Armstrong wrote:
> Adds support for Amlogic G12A USB Control Glue HW.
> 
> The Amlogic G12A SoC Family embeds 2 USB Controllers :
> - a DWC3 IP configured as Host for USB2 and USB3
> - a DWC2 IP configured as Peripheral USB2 Only
> 
> A glue connects these both controllers to 2 USB2 PHYs, and optionnally
> to an USB3+PCIE Combo PHY shared with the PCIE controller.
> 
> The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
> routing of the OTG PHY between the DWC3 and DWC2 controllers, and
> setups the on-chip OTG mode selection for this PHY.
> 
> This driver sets the OTG capable port as Host mode by default,
> the switch to Device mode is to be done in a separate patch.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Marek Vasut <marex@denx.de>

-- 
Best regards,
Marek Vasut
