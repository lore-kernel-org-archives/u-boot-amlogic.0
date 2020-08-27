Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.13707.1598513186108577222
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Aug 2020 00:26:27 -0700
Received: by mail-wr1-f44.google.com with SMTP id l7so485414wrx.8
        for <u-boot-amlogic@groups.io>; Thu, 27 Aug 2020 00:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mn3kEsdcJ87iA0hdYovR4BCOb6prmJXwMQQYBcmDoQs=;
        b=eyw620jTuBDksZPChqK0zhkJCeFOeAA1uYkfPKvRo0bhX9zui4euTudpMn4BcuQX4o
         WZamHYoeI8jQA5tEyUPFnx6AeXu5pnVTGrrP8GPriOCfSo6PKZZQ45+pbgvLZe61wKnI
         ypuhXSmEIomLFmx46WgzUmY2aIw8GKJ+DWXwm+sr52+YCe44Fzp0MrDXglZBnSANWRuj
         d2cvWO3bhGFunM238x49DJX9ek2yitalpPak+yOhDmdJHkU80in47e0hRBSFz+mowlAu
         7ulJXiBjchDDAuhikwxGhxNEvdaC6aBlf38BWZDoY7nAajfOfp2BN5GaMHrrPzBfErUn
         VTsg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: HDMI on Odroid-C4
References: <0d556ad4-39b4-4ccd-975d-b5eb96e4007e@gmail.com>
 <3d8f1054-6dd0-2d46-eba3-95d0a0cdedb9@baylibre.com>
 <8a10df70-91d7-4cd9-8813-0cd056d8623e@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <4913733d-7689-1173-eb97-fc2a0ddf115e@baylibre.com>
Date: Thu, 27 Aug 2020 09:26:21 +0200
MIME-Version: 1.0
In-Reply-To: <8a10df70-91d7-4cd9-8813-0cd056d8623e@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, vicencb@gmail.com
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 24/08/2020 20:01, Vicente Bergas wrote:
> On Monday, August 24, 2020 10:32:52 AM CEST, Neil Armstrong wrote:
>> Hi,
>>
>> On 20/08/2020 20:58, Vicente Bergas wrote:
>>> Hi, i've got an Odroid-C4 and testing u-boot on it but cannot make HDMI work.
>>> U-Boot version is 2020.10-rc2 and configuration is odroid-c4_defconfig.
>>> From the serial port, the 'dm uclass' command reports req -1 for display, video and vidconsole uclasses.
>>> Am i missing something or is it supposed to work?
>>
>> It' supposed to work, could you test with https://patchwork.ozlabs.org/project/uboot/patch/20200814062515.1803-2-linux.amoon@gmail.com/ ?
> 
> Hi Neil,
> just tested latest master branch with the aforementioned patch on top of it.
> It did not work either. When u-boot boots it reports "serial" as the only In/Out/Err means.
> Below is the boot log. Wich would be the next step in debugging this?

The simplest is to add "#define DEBUG" in include/common.h, boot and look for errors when the display is probing.

Neil

> 
> Regards,
>  Vicente.
> 
> SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:F;RCY:0;EMMC:800;NAND:81;SD?:0;SD:0;READ:0;0.0;CHK:0;
> bl2_stage_init 0x01
> bl2_stage_init 0x81
> hw id: 0x0000 - pwm id 0x01
> bl2_stage_init 0xc1
> bl2_stage_init 0x02
> 
> no sdio debug board detected L0:00000000
> L1:00000703
> L2:00008067
> L3:15000020
> S1:00000000
> B2:20282000
> B1:a0f83180
> 
> TE: 295352
> 
> BL2 Built : 20:29:41, Jun 18 2019. g12a ga659aac - luan.yuan@droid15-sz
> 
> Board ID = 1
> Set cpu clk to 24M
> Set clk81 to 24M
> Use GP1_pll as DSU clk.
> DSU clk: 1200 Mhz
> CPU clk: 1200 MHz
> Set clk81 to 166.6M
> DDR driver_vesion: LPDDR4_PHY_V_0_1_15 build time: Jun 18 2019 20:29:37
> board id: 1
> Load FIP HDR from SD, src: 0x00010200, des: 0xfffd0000, size: 0x00004000, part: 0
> fw parse done
> Load ddrfw from SD, src: 0x00060200, des: 0xfffd0000, size: 0x0000c000, part: 0
> Load ddrfw from SD, src: 0x00038200, des: 0xfffd0000, size: 0x00004000, part: 0
> PIEI prepare done
> fastboot data load
> fastboot data verify
> verify result: 255
> Cfg max: 2, cur: 1. Board id: 255. Force loop cfg
> DDR4 probe
> ddr clk to 1320MHz
> Load ddrfw from SD, src: 0x00014200, des: 0xfffd0000, size: 0x0000c000, part: 0
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
> Load ddrfw from SD, src: 0x00020200, des: 0xfffd0000, size: 0x0000c000, part: 0
> Check phy result
> INFO : End of initialization
> INFO : End of 2D read delay Voltage center optimization
> INFO : End of 2D write delay Voltage center optimization
> INFO : Training has run successfully!
> 
> R0_RxClkDly_Margin==106 ps 9
> R0_TxDqDly_Margi==94 ps 8
> 
> 
> R1_RxClkDly_Margin==0 ps 0
> R1_TxDqDly_Margi==0 ps 0
> 
> dwc_ddrphy_apb_wr((0<<20)|(2<<16)|(0<<12)|(0xb0):0001
> soc_vref_reg_value 0x 0000004d 0000004e 0000004f 0000004d 0000004d 00000050 0000004e 0000004c 0000004d 0000004e 0000004e 0000004d 0000004b 0000004d 00000050 0000004d 0000004d 0000004e 0000004d 0000004f 0000004e 0000004c 0000004d 0000004e 0000004d 0000004e 0000004e 0000004e 0000004c 0000004f 0000004d 0000004e dram_vref_reg_value 0x 00000022
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
> 100bdlr_step_size ps== 450
> result report
> boot times 0Enable ddr reg access
> Load FIP HDR from SD, src: 0x00010200, des: 0x01700000, size: 0x00004000, part: 0
> Load BL3X from SD, src: 0x00078200, des: 0x01768000, size: 0x00098000, part: 0
> bl2z: ptr: 05129330, size: 00001e40
> 0.0;M3 CHK:0;cm4_sp_mode 0
> MVN_1=0x00000000
> MVN_2=0x00000000
> [Image: g12a_v1.1.3386-3b31431 2019-05-21 10:41:54 luan.yuan@droid15-sz]
> OPS=0x10
> ring efuse init
> 2b 0c 10 00 01 10 10 00 00 09 36 30 43 57 50 50 [0.017354 Inits done]
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
> U-Boot 2020.10-rc2-00222-gd584648dad-dirty (Jan 01 1970 - 00:00:00 +0000) odroid-c4
> 
> Model: Hardkernel ODROID-C4
> SoC:   Amlogic Meson SM1 (Unknown) Revision 2b:c (10:2)
> DRAM:  3.8 GiB
> MMC:   sd@ffe05000: 0, mmc@ffe07000: 1
> In:    serial
> Out:   serial
> Err:   serial
> Net:   eth0: ethernet@ff3f0000
> Hit any key to stop autoboot:  0
> 
> 
> 

