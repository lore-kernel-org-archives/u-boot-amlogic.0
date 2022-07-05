Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web09.82156.1657008509523104934
 for <u-boot-amlogic@groups.io>;
 Tue, 05 Jul 2022 01:08:30 -0700
Received: by mail-wm1-f43.google.com with SMTP id n185so6549113wmn.4
        for <u-boot-amlogic@groups.io>; Tue, 05 Jul 2022 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Ex9HrUXR1ijitzP3RWaZ0rJE2EAdC6OmPgNRGVXq8y4=;
        b=i+3ZEASohMgHM4owvadCI1xt3k2d+VlOp56HngAK0qoavGdjDTnaXMSwGJROzN7wGM
         yKC75CB6UtyEm6QUACoi+0wLDKD8R02mkqmsgyH9drcsvHju+Bh8WnaS6DgAQ9OnLBE3
         AFknm+zX2PHslJxz9z4EbFiNLRqGESg5Ifz0oxeexQka/zS+d0tLibOlL3pDFrt3PW66
         Dq0CKT1g1kZzL7hQY5itrCcyCRFWjALgm9B+xWcqVATHtsogEiS4Ilcm+VlljmV2KoAT
         6OwZ8iMFQYxM378Rap8t0ZmE+/S9h05qIdCBroCY6kCqQ2vR1QfgS+a48hVtUJ5w99jY
         g+3Q==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH] doc: board: amlogic: add documentation on boot flow
In-Reply-To: <20220704141016.3060901-1-narmstrong@baylibre.com>
References: <20220704141016.3060901-1-narmstrong@baylibre.com>
Date: Tue, 05 Jul 2022 10:08:26 +0200
Message-ID: <87a69ooubp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On Mon, Jul 04, 2022 at 16:10, "Neil Armstrong" <narmstrong@baylibre.com> wrote:

> This is a preliminary documentation introducing different
> boot sequences, and notably the recovery mode.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  doc/board/amlogic/boot-flow.rst | 147 ++++++++++++++++++++++++++++++++
>  doc/board/amlogic/index.rst     |   1 +
>  2 files changed, 148 insertions(+)
>  create mode 100644 doc/board/amlogic/boot-flow.rst
>
> diff --git a/doc/board/amlogic/boot-flow.rst b/doc/board/amlogic/boot-flow.rst
> new file mode 100644
> index 0000000000..32943f42db
> --- /dev/null
> +++ b/doc/board/amlogic/boot-flow.rst
> @@ -0,0 +1,147 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Amlogic SoC Boot Flow
> +=====================
> +
> +The Amlogic SoCs has a pre-defined boot sequence in the SoC ROM code.
> +
> +Here is the possible boot sources of different SoC families supported by U-Boot:
> +
> +GX* & AXG family
> +----------------
> +
> ++----------+--------------------+-------+-------+---------------+---------------+
> +|          |   1                | 2     | 3     |    4          |     5         |
> ++==========+====================+=======+=======+===============+===============+
> +| S905     | POC=0: SPI NOR     | eMMC  | NAND  | SD Card       | USB Device    |
> +| S905X    |                    |       |       |               |               |
> +| S905L    |                    |       |       |               |               |
> +| S905W    |                    |       |       |               |               |
> +| S912     |                    |       |       |               |               |
> ++----------+--------------------+-------+-------+---------------+---------------+
> +| S805X    | POC=0: SPI NOR     | eMMC  | NAND  | USB Device    | -             |
> +| A113D    |                    |       |       |               |               |
> +| A113X    |                    |       |       |               |               |
> ++----------+--------------------+-------+-------+---------------+---------------+
> +
> +POC pin: `NAND_CLE`
> +
> +Usually boards provides a button to force USB BOOT which disables eMMC clock signal to
> +bypass eMMC.
> +
> +Most of the GX SBCs have removable eMMC modules, in this case removing the eMMC and SDCard
> +will boot over USB.
> +
> +An exception is the lafrite board (aml-s805x-xx) which doesn't have an SDCard and boots
> +over SPI. The only ways to boot over USB are:
> +
> + - erase first sectors of SPI NOR flash
> + - insert an HDMI boot plug forcing boot over USB
> +
> +The VIM1 and initial VIM2 boards provides a test point on the eMMC signals to block the
> +storage from answering and continue to the next boot step.
> +
> +The USB Device boot uses the first USB interface, on some boards this port is only
> +available on an USB-A type connector, and needs an special Type-A to Type-A cable
> +to communicate with the BootROM.
> +
> +G12* & SM1 family
> +-----------------
> +
> ++-------+-------+-------+---------------+---------------+---------------+---------------+
> +| POC0  | POC1  | POC2  | 1             | 2             | 3             | 4             |
> ++=======+=======+=======+===============+===============+===============+===============+
> +| 0     | 0     | 0     | USB Device    | SPI NOR       | NAND/eMMC     | SDCard        |
> ++-------+-------+-------+---------------+---------------+---------------+---------------+
> +| 0     | 0     | 1     | USB Device    | NAND/eMMC     | SDCard        | -             |
> ++-------+-------+-------+---------------+---------------+---------------+---------------+
> +| 0     | 1     | 0     | SPI NOR       | NAND/eMMC     | SDCard        | USB Device    |
> ++-------+-------+-------+---------------+---------------+---------------+---------------+
> +| 0     | 1     | 1     | SPI NAND      | NAND/eMMC     | USB Device    | -             |
> ++-------+-------+-------+---------------+---------------+---------------+---------------+
> +| 1     | 0     | 0     | USB Device    | SPI NOR       | NAND/eMMC     | SDCard        |
> ++-------+-------+-------+---------------+---------------+---------------+---------------+
> +| 1     | 0     | 1     | USB Device    | NAND/eMMC     | SDCard        | -             |
> ++-------+-------+-------+---------------+---------------+---------------+---------------+
> +| 1     | 1     | 0     | SPI NOR       | NAND/eMMC     | SDCard        | USB Device    |
> ++-------+-------+-------+---------------+---------------+---------------+---------------+
> +| 1     | 1     | 1     | NAND/eMMC     | SDCard        | USB Device    | -             |
> ++-------+-------+-------+---------------+---------------+---------------+---------------+
> +
> +The last is the normal default boot on production devices.
> +
> + * POC0 pin: `BOOT_4` (0 and all other 1 means SPI NAND boot first)
> + * POC1 pin: `BOOT_5` (0 and all other 1 means USB Device boot first
> + * POC2 pin: `BOOT_6` (0 and all other 1 means SPI NOR boot first)
> +
> +Usually boards provides a button to force USB BOOT which lowers `BOOT_5` to 0.
> +
> +Some boards provides a test point on the eMMC or SPI NOR clock signals to block the
> +storage from answering and continue to the next boot step.
> +
> +The Khadas VIM3 boards embeds a microcontroller which sets POC signals depending
> +on it's configuration or a specific key press sequence to either boot from SPI NOR
> +or eMMC then SDCard, or boot as USB Device.
> +
> +The Odroid-N2(+) has a switch to select SPI NOR or eMMC boot.
> +
> +Boot Modes
> +----------
> +
> + * SDCard
> +
> +The BootROM fetches the first SDCard sectors in one sequence, then checks the content
> +of the data.
> +
> +The BootROM expects finding the FIP binary are sector 1, 512 bytes offset from the start.
> +
> + * eMMC
> +
> +The BootROM fetches the first sectors in one sequence, first on the main partition,
> +and then on the Boot0 followed by Boot1 HW partitions.
> +
> +After each read, the BootROM checks the data and looks the next partition if it fails.
> +
> +The BootROM expects finding the FIP binary are sector 1, 512 bytes offset from the start.
> +
> + * SPI NOR
> +
> +The BootROM fetches the first SPI NOR sectors in one sequence, then checks the content
> +of the data.
> +
> +The BootROM expects finding the FIP binary are sector 1, 512 bytes offset from the start.
> +
> + * NAND & SPI NAND
> +
> +Those modes are not widely used in open platforms, thus no details are available.
> +
> + * USB Device
> +
> +The BootROM setups the USB Gadget interface to serve a custom USB protocols with the
> +USB ID 1b8e:c003.
> +
> +This protocol is also implemented in the Amlogic Vendor U-Boot.
> +
> +The `update` utility provided by Amlogic is designed to use this protocol.
> +
> +The https://github.com/superna9999/pyamlboot open-source utility also implements this
> +protocol and can load U-Boot in memory in order to start the SoC without any attached
> +storage or to recover from a failed storage/flash tentative.
> +
> +HDMI Recovery
> +-------------
> +
> +The BootROM also briefly reads 8 bytes at address I2C 0x52 offset 0xf8 (248) on the
> +HDMI DDC bus.
> +
> +If the content is `boot@USB` it will force USB boot mode, if the content is `boot@SDC`
> +it will force SDCard boot mode.
> +
> +If USB Device doesn't enumerate or SD Card boot step doesn't work, it will continue the
> +boot steps.
> +
> +Special boot dongles can be built by connecting a 256bytes EEPROM set to answer on
> +address 0x52, and program `boot@USB` or `boot@SDC` at offset 0xf8 (248).
> +
> +Note: if the SoC was booted with USB Device forced at first step, it will keep the boot
> +order on a warm reboot, only a cold reboot (remove power) will reset the boot order.
> diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
> index 9c7fadf2c0..8b9f1e2e1d 100644
> --- a/doc/board/amlogic/index.rst
> +++ b/doc/board/amlogic/index.rst
> @@ -81,6 +81,7 @@ Boot Documentation
>     :maxdepth: 1
>  
>     pre-generated-fip
> +   boot-flow
>  
>  Board Documentation
>  -------------------
> -- 
> 2.25.1
>
>
>
> 
