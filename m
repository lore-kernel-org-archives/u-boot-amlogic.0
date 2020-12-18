Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web12.7400.1608283498664494782
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 01:24:59 -0800
Received: by mail-wm1-f51.google.com with SMTP id k10so1630067wmi.3
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 01:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DNArhlNrRexg5Em48x+kCqbzBwYoVwJaTrUOOFlcIis=;
        b=Prcc5c9N/JX9cuW/PCtFlAO9VIAXNduIaR2RFqVgP7cM+EuejNGFB4+vCmJORvBelt
         Vo3Ag05E50VBKJea6aFBMnp2W1WQ395fQdh712OaDU+ij5Em3PTD9xvz15qeya2fS043
         GtBMTWLnebyH4s3Nx6HgTpZG+zgFooC8Gopf34sFSPV5ufEfgUzAJdQIUsg/be54MJr3
         cSlbCAWV8/7z8476NtbmY7rGSiSEz5Smth4LtdJj+OiPAB6MYs5Pwg68Aolk2KzDQlHq
         A0Yh7K5PYsDp0kOfU7LklVJBa62TVC81U0/9DLYu/Pj2cpNGZt/byVYnAOK03vPAq8to
         /VsQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH/RFC] board: amlogic: Fix Odroid-C4 SD card reboot issue
References: <CGME20201217090636eucas1p12fcdef289555f4efc425a8f325ddfe4c@eucas1p1.samsung.com>
 <20201217090624.14902-1-m.szyprowski@samsung.com>
 <0c53e06e-afa4-2308-7d5d-ba08b1d0caf3@baylibre.com>
 <b006ae83-3a27-f0dd-c905-5ac7f41be067@samsung.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <eea5161b-c5bc-3804-5f88-318052c29a31@baylibre.com>
Date: Fri, 18 Dec 2020 10:24:54 +0100
MIME-Version: 1.0
In-Reply-To: <b006ae83-3a27-f0dd-c905-5ac7f41be067@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Marek Szyprowski <m.szyprowski@samsung.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, tobetter <tobetter@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 18/12/2020 10:11, Marek Szyprowski wrote:
> Hi Neil,
> 
> On 18.12.2020 09:36, Neil Armstrong wrote:
>> On 17/12/2020 10:06, Marek Szyprowski wrote:
>>> For the proper reboot Odroid C4 board requires to switch TFLASH_VDD_EN
>>> pin to the input (high impedance?) mode, otherwise the board is stuck
>>> in the middle of loading early stages of the bootloader from SD card.
>> Did you try taking the regulator-tflash_vdd and doing a disable/enable sequence
>> to reset the card ?
>>
>> The GPIOAO_3 has a default pull-up, so I don't see why moving it to input could change
>> anything.
>>
>> So maybe simply doing a 0->1 transition could do the same, using the regulator
>> would be much better.
>>
>> Can't we add "shutdown" or equivalent method to  the mmc driver that could do this
>> directly with the vdd regulator ?
> 
> Yes, I've tried all combinations of playing this that GPIO and regulator 
> that came to my mind. Switching pin to the input is the only one I've 
> found working.

Thanks for the dumps !

Could you try switching the tflash_vdd to opendrain like :

--->8---

--- a/arch/arm/dts/meson-sm1-odroid-c4.dts
+++ b/arch/arm/dts/meson-sm1-odroid-c4.dts
@@ -52,7 +52,7 @@
                regulator-min-microvolt = <3300000>;
                regulator-max-microvolt = <3300000>;

-               gpio = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
+               gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
                enable-active-high;
                regulator-always-on;
        };

--->8---

This should leave the pin in input to achieve high state, and solve the issue.

Neil

> 
> It looks that there must be some additional (hw?) logic there, which 
> does the SD card reset during the BL, which in turn conflicts with the 
> constant 0 or constant 1 driven from TFLASH_VDD_EN gpio. This is also 
> what the vendor's kernel does: 
> https://github.com/hardkernel/linux/commit/84628497332a5cd2154c92436ec86fad900fe0af 
> That commit states that it is according to the odroid schematic, but on 
> the public schematics of C4 I cannot find anything what might need such 
> workaround/fix.
> 
> Here is how it behaves without the fix:
> 
> 1. if SD card is not used (TFLASH regulator is not even instantiated, so 
> GPIO pin is in input state as its initial value left by earlier BL 
> stages), the reboot works fine:
> 
> --->8---
> 
> U-Boot 2021.01-rc3 (Dec 18 2020 - 10:00:48 +0100) odroid-c4
> 
> Model: Hardkernel ODROID-C4
> SoC:   Amlogic Meson SM1 (S905X3) Revision 2b:c (10:2)
> DRAM:  3.8 GiB
> MMC:   sd@ffe05000: 0, mmc@ffe07000: 1
> In:    serial
> Out:   serial
> Err:   serial
> Net:   eth0: ethernet@ff3f0000
> Hit any key to stop autoboot:  0
> =>
> => reset
> resetting ...
> bl31 reboot reason: 0xd
> bl31 reboot reason: 0x0
> system cmd  1.
> SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:F;RCY:0;EMMC:800;NAND:81;SD?:0;SD:0;READ:0;0.0;CHK:0;
> bl2_stage_init 0x01
> bl2_stage_init 0x81
> hw id: 0x0000 - pwm id 0x01
> bl2_stage_init 0xc1
> bl2_stage_init 0x02
> 
> no sdio debug board detected
> L0:00000000
> L1:00000703
> L2:00008067
> L3:15000020
> S1:00000000
> B2:20282000
> B1:a0f83180
> 
> TE: 143230
> 
> BL2 Built : 22:54:32, Apr 28 2020. g12a ga659aac-dirty - 
> changqing.gao@droid11
> 
> Board ID = 1
> Set cpu clk to 24M
> Set clk81 to 24M
> Use GP1_pll as DSU clk.
> DSU clk: 1200 Mhz
> CPU clk: 1200 MHz
> Set clk81 to 166.6M
> DDR driver_vesion: LPDDR4_PHY_V_0_1_15 build time: Apr 28 2020 22:54:28
> board id: 1
> Load FIP HDR from SD, src: 0x00010200, des: 0xfffd0000, size: 
> 0x00004000, part: 0
> fw parse done
> Load ddrfw from SD, src: 0x00060200, des: 0xfffd0000, size: 0x0000c000, 
> part: 0
> Load ddrfw from SD, src: 0x00038200, des: 0xfffd0000, size: 0x00004000, 
> part: 0
> PIEI prepare done
> fastboot data load
> fastboot data verify
> verify result: 255
> Cfg max: 2, cur: 1. Board id: 255. Force loop cfg
> DDR4 probe
> ddr clk to 1320MHz
> Load ddrfw from SD, src: 0x00014200, des: 0xfffd0000, size: 0x0000c000, 
> part: 0
> 
> dmc_version 0001
> Check phy result
> INFO : End of initialization
> INFO : End of read enable training
> INFO : End of fine write leveling
> INFO : End of read dq deskew training
> INFO : End of MPR read delay center optimization
> INFO : End of Write leveling coarse delay
> INFO : End of write delay center optimization
> INFO : End of read delay center optimization
> INFO : End of max read latency training
> INFO : Training has run successfully!
> 1D training succeed
> Load ddrfw from SD, src: 0x00020200, des: 0xfffd0000, size: 0x0000c000, 
> part: 0
> Check phy result
> INFO : End of initialization
> INFO : End of 2D read delay Voltage center optimization
> INFO : End of 2D write delay Voltage center optimization
> INFO : Training has run successfully!
> 
> R0_RxClkDly_Margin==94 ps 8
> R0_TxDqDly_Margi==106 ps 9
> 
> 
> R1_RxClkDly_Margin==0 ps 0
> R1_TxDqDly_Margi==0 ps 0
> 
>   dwc_ddrphy_apb_wr((0<<20)|(2<<16)|(0<<12)|(0xb0):0001
> 
> soc_vref_reg_value 0x 0000004e 0000004f 0000004e 0000004f 00000050 
> 0000004f 0000004f 0000004e 0000004d 0000004c 0000004f 0000004d 00000050 
> 00000050 0000004f 0000004f 0000004e 0000004f 0000004e 0000004e 0000004e 
> 0000004d 0000004e 0000004e 00000050 0000004e 0000004f 0000004d 0000004d 
> 0000004e 0000004e 0000004d dram_vref_reg_value 0x 00000022
> 2D training succeed
> aml_ddr_fw_vesion: LPDDR4_PHY_V_0_1_15 build time: Jun 18 2019 20:29:43
> auto size-- 65535DDR cs0 size: 2048MB
> DDR cs1 size: 2048MB
> DMC_DDR_CTRL: 00700024DDR size: 3928MB
> cs0 DataBus test pass
> cs1 DataBus test pass
> cs0 AddrBus test pass
> cs1 AddrBus test pass
> 
> non-sec scramble use zero key
> ddr scramble enabled
> 
> 100bdlr_step_size ps== 425
> result report
> boot times 1Enable ddr reg access
> Load FIP HDR from SD, src: 0x00010200, des: 0x01700000, size: 
> 0x00004000, part: 0
> Load BL3X from SD, src: 0x0006c200, des: 0x0175c000, size: 0x00098000, 
> part: 0
> 0.0;M3 CHK:0;cm4_sp_mode 0
> MVN_1=0x00000000
> MVN_2=0x00000000
> [Image: g12a_v1.1.3386-3b31431 2019-05-21 10:41:54 luan.yuan@droid15-sz]
> OPS=0x10
> ring efuse init
> 2b 0c 10 00 01 15 06 00 00 11 36 30 43 57 50 50
> [1.016710 Inits done]
> secure task start!
> high task start!
> low task start!
> run into bl31
> NOTICE:  BL31: v1.3(release):4fc40b1
> NOTICE:  BL31: Built : 15:57:33, May 22 2019
> NOTICE:  BL31: G12A normal boot!
> NOTICE:  BL31: BL33 decompress pass
> ERROR:   Error initializing runtime service opteed_fast
> 
> 
> U-Boot 2021.01-rc3 (Dec 18 2020 - 10:00:48 +0100) odroid-c4
> 
> --->8---
> 
> 2. If SD card is touched, then reboot hangs somewhere between BL2->BL3 
> stages:
> 
> --->8---
> 
> U-Boot 2021.01-rc3 (Dec 18 2020 - 10:00:48 +0100) odroid-c4
> 
> Model: Hardkernel ODROID-C4
> SoC:   Amlogic Meson SM1 (S905X3) Revision 2b:c (10:2)
> DRAM:  3.8 GiB
> MMC:   sd@ffe05000: 0, mmc@ffe07000: 1
> In:    serial
> Out:   serial
> Err:   serial
> Net:   eth0: ethernet@ff3f0000
> Hit any key to stop autoboot:  0
> =>
> => mmc info
> Device: sd@ffe05000
> Manufacturer ID: 74
> OEM: 4a45
> Name: SDU1
> Bus Speed: 50000000
> Mode: SD High Speed (50MHz)
> Rd Block Len: 512
> SD version 3.0
> High Capacity: Yes
> Capacity: 7.5 GiB
> Bus Width: 4-bit
> Erase Group Size: 512 Bytes
> => reset
> resetting ...
> bl31 reboot reason: 0xd
> bl31 reboot reason: 0x0
> system cmd  1.
> SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:F;RCY:0;EMMC:800;NAND:81;SD?:0;SD:0;READ:0;0.0;CHK:0;
> bl2_stage_init 0x01
> bl2_stage_init 0x81
> hw id: 0x0000 - pwm id 0x01
> bl2_stage_init 0xc1
> bl2_stage_init 0x02
> 
> no sdio debug board detected
> L0:00000000
> L1:00000703
> L2:00008067
> L3:15000020
> S1:00000000
> B2:20282000
> B1:a0f83180
> 
> TE: 145782
> 
> BL2 Built : 22:54:32, Apr 28 2020. g12a ga659aac-dirty - 
> changqing.gao@droid11
> 
> Board ID = 1
> Set cpu clk to 24M
> Set clk81 to 24M
> Use GP1_pll as DSU clk.
> DSU clk: 1200 Mhz
> CPU clk: 1200 MHz
> Set clk81 to 166.6M
> DDR driver_vesion: LPDDR4_PHY_V_0_1_15 build time: Apr 28 2020 22:54:28
> board id: 1
> Load FIP HDR from SD, src: 0x00010200, des: 0xfffd0000, size: 
> 0x00004000, part: 0
> FIP HDR CHK: 0x00000089 ADDR 0xfffd0000
> reset...
> SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:F;RCY:0;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:1;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:2;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:3;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:4;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:5;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:6;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:7;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:8;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:9;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:A;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:B;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:C;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:D;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:E;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:F;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:10;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;LOOP:11;EMMC:800;NAND:81;SD?:0;SD:800;USB:8;
> 
> --->8---
> 
>> @tobetter, could you provide us a summary of how to fix the reboot issues on the
>> N2, N2+, C4 and HC4 ?
> 
> On the other hand I didn't observe any reboot related issues on N2/N2+.
> 
> Best regards
> 

