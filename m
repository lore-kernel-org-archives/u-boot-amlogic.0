Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web09.8921.1616682249224001560
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Mar 2021 07:24:10 -0700
Received: by mail-wm1-f41.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so3215747wml.2
        for <u-boot-amlogic@groups.io>; Thu, 25 Mar 2021 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wb/ZaBUQc5wfBgj6Kg9KmJxOL7urYGUN/ZyjYuACmzo=;
        b=vd9kIoc7S1H0VFZgz4QB0o2EHPhYI9Hm4UGG2bq8myztZ/XGVi1iC1jT+bGCr54UFP
         BcVnHQVDH4y3t7gKeYNHAL9UDjUKeduWYUfDaHGpZuZamC2R//8+ecbrD5AyeiPw8G26
         +o0s684R/ib1APEIa/IITDkOU7+RnrlyihwPJaulY07pyayZI+vV9XtTS2mm8DSbBGIw
         VtXvlmc+B2K7JWlklW1/rgz/8HUE+OzMFiDUVaj7fhTpb8eWlxw+nphh5FQqZ7gf+IsV
         8IB/a+otibvDm7ZtHVuZjxDPp8sjfKKyLjWTvyamp6BCWYSDgzoUdi+4mJ0YOOzenort
         +5ag==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH RFT 1/4] pci: add common Designware PCIe functions
References: <20210322091812.2511462-1-narmstrong@baylibre.com>
 <20210322091812.2511462-2-narmstrong@baylibre.com>
 <CAEUhbmUJv_3h8NCFun7ci5R70j2ckCF3SNfXQ_1s9AzZb3pBuA@mail.gmail.com>
 <CAJivOr7hkFJcOFO9Y_2OB0Kh1m=ERh4hg-MwD67nRUKUB8uVmg@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <cfcdbe75-bc1d-a14c-9424-9d04c2993781@baylibre.com>
Date: Thu, 25 Mar 2021 15:24:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAJivOr7hkFJcOFO9Y_2OB0Kh1m=ERh4hg-MwD67nRUKUB8uVmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Green Wan <green.wan@sifive.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, shawn.lin@rock-chips.com, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 25/03/2021 11:37, Green Wan wrote:
> Hi Neil,
> 
> I gave it a try today. I think the patch is good and I would like to
> add some comments quickly before I finish the rest of the tests. See
> my comments below. Thanks,

Thanks for testing !

> 
> On Mon, Mar 22, 2021 at 5:41 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> +Green Wan for SiFive FU740 PCIe which is another variant of DW PCIe
>>
>> On Mon, Mar 22, 2021 at 5:18 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>
>>> With the introduction of pcie_dw_rockchip, and need to support the DW PCIe in the
>>> Amlogic AXG & G12 SoCs, most of the DW PCIe helpers would be duplicated.
>>>
>>> This introduce a "common" DW PCIe helpers file with common code merged from the
>>> dw_ti and dw_rockchip drivers and adapted to fit with the upcoming dw_meson.
>>>
>>> The following changes will switch the dw_ti and dw_rockchip to use these helpers.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  drivers/pci/Kconfig          |   4 +
>>>  drivers/pci/Makefile         |   1 +
>>>  drivers/pci/pcie_dw_common.c | 352 +++++++++++++++++++++++++++++++++++
>>>  drivers/pci/pcie_dw_common.h | 153 +++++++++++++++
>>>  4 files changed, 510 insertions(+)
>>>  create mode 100644 drivers/pci/pcie_dw_common.c
>>>  create mode 100644 drivers/pci/pcie_dw_common.h
>>>
>>
>> Regards,
>> Bin
> 
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index ba41787f64..ab5a5e7ed6 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -258,6 +258,10 @@  config PCI_MVEBU
>>    Say Y here if you want to enable PCIe controller support on
>>    Armada XP/38x SoCs.
>>
>> +config PCIE_DW_COMMON
>> + bool
>> + select DM_PCI
>> +
>>  config PCI_KEYSTONE
>>  bool "TI Keystone PCIe controller"
>>  depends on DM_PCI
>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> index 5ed94bc95c..e3ca8b27e4 100644
>> --- a/drivers/pci/Makefile
>> +++ b/drivers/pci/Makefile
>> @@ -45,6 +45,7 @@  obj-$(CONFIG_PCIE_LAYERSCAPE_GEN4) += pcie_layerscape_gen4.o \
>>  obj-$(CONFIG_PCI_XILINX) += pcie_xilinx.o
>>  obj-$(CONFIG_PCI_PHYTIUM) += pcie_phytium.o
>>  obj-$(CONFIG_PCIE_INTEL_FPGA) += pcie_intel_fpga.o
>> +obj-$(CONFIG_PCIE_DW_COMMON) += pcie_dw_common.o
>>  obj-$(CONFIG_PCI_KEYSTONE) += pcie_dw_ti.o
>>  obj-$(CONFIG_PCIE_MEDIATEK) += pcie_mediatek.o
>>  obj-$(CONFIG_PCIE_ROCKCHIP) += pcie_rockchip.o
>> diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_common.c
>> new file mode 100644
>> index 0000000000..c05ae24974
>> --- /dev/null
>> +++ b/drivers/pci/pcie_dw_common.c
>> @@ -0,0 +1,352 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (c) 2021 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + *
>> + * Copyright (c) 2021 Rockchip, Inc.
>> + *
>> + * Copyright (C) 2018 Texas Instruments, Inc
>> + */
>> +
>> +#include <common.h>
>> +#include <dm.h>
>> +#include <log.h>
>> +#include <pci.h>
>> +#include <dm/device_compat.h>
>> +#include <asm/io.h>
>> +#include <linux/delay.h>
>> +#include "pcie_dw_common.h"
>> +
>> +int pcie_dw_get_link_speed(struct pcie_dw *pci)
>> +{
>> + return (readl(pci->dbi_base + PCIE_LINK_STATUS_REG) &
>> + PCIE_LINK_STATUS_SPEED_MASK) >> PCIE_LINK_STATUS_SPEED_OFF;
>> +}
>> +
>> +int pcie_dw_get_link_width(struct pcie_dw *pci)
>> +{
>> + return (readl(pci->dbi_base + PCIE_LINK_STATUS_REG) &
>> + PCIE_LINK_STATUS_WIDTH_MASK) >> PCIE_LINK_STATUS_WIDTH_OFF;
>> +}
>> +
>> +static void dw_pcie_writel_ob_unroll(struct pcie_dw *pci, u32 index, u32 reg,
>> +      u32 val)
>> +{
>> + u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
>> + void __iomem *base = pci->atu_base;
>> +
>> + writel(val, base + offset + reg);
>> +}
>> +
>> +static u32 dw_pcie_readl_ob_unroll(struct pcie_dw *pci, u32 index, u32 reg)
>> +{
>> + u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
>> + void __iomem *base = pci->atu_base;
>> +
>> + return readl(base + offset + reg);
>> +}
>> +
>> +/**
>> + * pcie_dw_prog_outbound_atu_unroll() - Configure ATU for outbound accesses
>> + *
>> + * @pcie: Pointer to the PCI controller state
>> + * @index: ATU region index
>> + * @type: ATU accsess type
>> + * @cpu_addr: the physical address for the translation entry
>> + * @pci_addr: the pcie bus address for the translation entry
>> + * @size: the size of the translation entry
>> + *
>> + * Return: 0 is successful and -1 is failure
>> + */
>> +int pcie_dw_prog_outbound_atu_unroll(struct pcie_dw *pci, int index,
>> +      int type, u64 cpu_addr,
>> +      u64 pci_addr, u32 size)
>> +{
>> + u32 retries, val;
>> +
>> + dev_dbg(pci->dev, "ATU programmed with: index: %d, type: %d, cpu addr: %8llx, pci addr: %8llx, size: %8x\n",
>> + index, type, cpu_addr, pci_addr, size);
>> +
>> + dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
>> + lower_32_bits(cpu_addr));
>> + dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_BASE,
>> + upper_32_bits(cpu_addr));
>> + dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LIMIT,
>> + lower_32_bits(cpu_addr + size - 1));
>> + dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
>> + lower_32_bits(pci_addr));
>> + dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>> + upper_32_bits(pci_addr));
>> + dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
>> + type);
>> + dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
>> + PCIE_ATU_ENABLE);
>> +
>> + /*
>> + * Make sure ATU enable takes effect before any subsequent config
>> + * and I/O accesses.
>> + */
>> + for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
>> + val = dw_pcie_readl_ob_unroll(pci, index,
>> +       PCIE_ATU_UNR_REGION_CTRL2);
>> + if (val & PCIE_ATU_ENABLE)
>> + return 0;
>> +
>> + udelay(LINK_WAIT_IATU);
>> + }
>> + dev_err(pci->dev, "outbound iATU is not being enabled\n");
>> +
>> + return -1;
>> +}
>> +
>> +/**
>> + * set_cfg_address() - Configure the PCIe controller config space access
>> + *
>> + * @pcie: Pointer to the PCI controller state
>> + * @d: PCI device to access
>> + * @where: Offset in the configuration space
>> + *
>> + * Configures the PCIe controller to access the configuration space of
>> + * a specific PCIe device and returns the address to use for this
>> + * access.
>> + *
>> + * Return: Address that can be used to access the configation space
>> + *         of the requested device / offset
>> + */
>> +static uintptr_t set_cfg_address(struct pcie_dw *pcie,
>> + pci_dev_t d, uint where)
>> +{
>> + int bus = PCI_BUS(d) - pcie->first_busno;
>> + uintptr_t va_address;
>> + u32 atu_type;
>> + int ret;
>> +
>> + /* Use dbi_base for own configuration read and write */
>> + if (!bus) {
>> + va_address = (uintptr_t)pcie->dbi_base;
>> + goto out;
>> + }
>> +
>> + if (bus == 1)
>> + /*
>> + * For local bus whose primary bus number is root bridge,
>> + * change TLP Type field to 4.
>> + */
>> + atu_type = PCIE_ATU_TYPE_CFG0;
>> + else
>> + /* Otherwise, change TLP Type field to 5. */
>> + atu_type = PCIE_ATU_TYPE_CFG1;
>> +
>> + /*
>> + * Not accessing root port configuration space?
>> + * Region #0 is used for Outbound CFG space access.
>> + * Direction = Outbound
>> + * Region Index = 0
>> + */
>> + d = PCI_MASK_BUS(d);
>> + d = PCI_ADD_BUS(bus, d);
>> + ret = pcie_dw_prog_outbound_atu_unroll(pcie, PCIE_ATU_REGION_INDEX1,
>> +        atu_type, (u64)pcie->cfg_base,
>> + d << 8, pcie->cfg_size);
>> + if (ret)
>> + return (uintptr_t)ret;
>> +
>> + va_address = (uintptr_t)pcie->cfg_base;
>> +
>> +out:
>> + va_address += where & ~0x3;
>> +
>> + return va_address;
>> +}
>> +
>> +/**
>> + * pcie_dw_addr_valid() - Check for valid bus address
>> + *
>> + * @d: The PCI device to access
>> + * @first_busno: Bus number of the PCIe controller root complex
>> + *
>> + * Return 1 (true) if the PCI device can be accessed by this controller.
>> + *
>> + * Return: 1 on valid, 0 on invalid
>> + */
>> +static int pcie_dw_addr_valid(pci_dev_t d, int first_busno)
>> +{
>> + if ((PCI_BUS(d) == first_busno) && (PCI_DEV(d) > 0))
>> + return 0;
>> + if ((PCI_BUS(d) == first_busno + 1) && (PCI_DEV(d) > 0))
>> + return 0;
>> +
>> + return 1;
>> +}
>> +
>> +/**
>> + * pcie_dw_read_config() - Read from configuration space
>> + *
>> + * @bus: Pointer to the PCI bus
>> + * @bdf: Identifies the PCIe device to access
>> + * @offset: The offset into the device's configuration space
>> + * @valuep: A pointer at which to store the read value
>> + * @size: Indicates the size of access to perform
>> + *
>> + * Read a value of size @size from offset @offset within the configuration
>> + * space of the device identified by the bus, device & function numbers in @bdf
>> + * on the PCI bus @bus.
>> + *
>> + * Return: 0 on success
>> + */
>> +int pcie_dw_read_config(const struct udevice *bus, pci_dev_t bdf,
>> + uint offset, ulong *valuep,
>> + enum pci_size_t size)
>> +{
>> + struct pcie_dw *pcie = dev_get_priv(bus);
>> + uintptr_t va_address;
>> + ulong value;
>> +
>> + dev_dbg(pcie->dev, "PCIE CFG read: bdf=%2x:%2x:%2x ",
>> + PCI_BUS(bdf), PCI_DEV(bdf), PCI_FUNC(bdf));
>> +
>> + if (!pcie_dw_addr_valid(bdf, pcie->first_busno)) {
>> + debug("- out of range\n");
>> + *valuep = pci_get_ff(size);
>> + return 0;
>> + }
>> +
>> + va_address = set_cfg_address(pcie, bdf, offset);
>> +
>> + value = readl(va_address);
>> +
>> + debug("(addr,val)=(0x%04x, 0x%08lx)\n", offset, value);
>> + *valuep = pci_conv_32_to_size(value, offset, size);
>> +
>> + return pcie_dw_prog_outbound_atu_unroll(pcie, PCIE_ATU_REGION_INDEX1,
>> + PCIE_ATU_TYPE_IO, pcie->io.phys_start,
>> + pcie->io.bus_start, pcie->io.size);
>> +}
>> +
>> +/**
>> + * pcie_dw_write_config() - Write to configuration space
>> + *
>> + * @bus: Pointer to the PCI bus
>> + * @bdf: Identifies the PCIe device to access
>> + * @offset: The offset into the device's configuration space
>> + * @value: The value to write
>> + * @size: Indicates the size of access to perform
>> + *
>> + * Write the value @value of size @size from offset @offset within the
>> + * configuration space of the device identified by the bus, device & function
>> + * numbers in @bdf on the PCI bus @bus.
>> + *
>> + * Return: 0 on success
>> + */
>> +int pcie_dw_write_config(struct udevice *bus, pci_dev_t bdf,
>> + uint offset, ulong value,
>> + enum pci_size_t size)
>> +{
>> + struct pcie_dw *pcie = dev_get_priv(bus);
>> + uintptr_t va_address;
>> + ulong old;
>> +
>> + dev_dbg(pcie->dev, "PCIE CFG write: (b,d,f)=(%2d,%2d,%2d) ",
>> + PCI_BUS(bdf), PCI_DEV(bdf), PCI_FUNC(bdf));
>> + dev_dbg(pcie->dev, "(addr,val)=(0x%04x, 0x%08lx)\n", offset, value);
>> +
>> + if (!pcie_dw_addr_valid(bdf, pcie->first_busno)) {
>> + debug("- out of range\n");
>> + return 0;
>> + }
>> +
>> + va_address = set_cfg_address(pcie, bdf, offset);
>> +
>> + old = readl(va_address);
>> + value = pci_conv_size_to_32(old, value, offset, size);
>> + writel(value, va_address);
>> +
>> + return pcie_dw_prog_outbound_atu_unroll(pcie, PCIE_ATU_REGION_INDEX1,
>> + PCIE_ATU_TYPE_IO, pcie->io.phys_start,
>> + pcie->io.bus_start, pcie->io.size);
>> +}
>> +
>> +/**
>> + * pcie_dw_setup_host() - Setup the PCIe controller for RC opertaion
>> + *
>> + * @pcie: Pointer to the PCI controller state
>> + *
>> + * Configure the host BARs of the PCIe controller root port so that
>> + * PCI(e) devices may access the system memory.
>> + */
>> +void pcie_dw_setup_host(struct pcie_dw *pci)
>> +{
>> + struct udevice *ctlr = pci_get_controller(pci->dev);
>> + struct pci_controller *hose = dev_get_uclass_priv(ctlr);
>> + u32 ret;
>> +
>> + if (!pci->atu_base)
>> + pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
>> +
>> + /* setup RC BARs */
>> + writel(PCI_BASE_ADDRESS_MEM_TYPE_64,
>> +        pci->dbi_base + PCI_BASE_ADDRESS_0);
>> + writel(0x0, pci->dbi_base + PCI_BASE_ADDRESS_1);
>> +
>> + /* setup interrupt pins */
>> + clrsetbits_le32(pci->dbi_base + PCI_INTERRUPT_LINE,
>> + 0xff00, 0x100);
>> +
>> + /* setup bus numbers */
>> + clrsetbits_le32(pci->dbi_base + PCI_PRIMARY_BUS,
>> + 0xffffff, 0x00ff0100);
>> +
>> + /* setup command register */
>> + clrsetbits_le32(pci->dbi_base + PCI_PRIMARY_BUS,
>> + 0xffff,
>> + PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
>> + PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
>> +
>> + /* Enable write permission for the DBI read-only register */
>> + dw_pcie_dbi_write_enable(pci, true);
>> + /* program correct class for RC */
>> + writew(PCI_CLASS_BRIDGE_PCI, pci->dbi_base + PCI_CLASS_DEVICE);
>> + /* Better disable write permission right after the update */
>> + dw_pcie_dbi_write_enable(pci, false);
>> +
>> + setbits_le32(pci->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL,
>> +      PORT_LOGIC_SPEED_CHANGE);
>> +
>> + for (ret = 0; ret < hose->region_count; ret++) {
>> + if (hose->regions[ret].flags == PCI_REGION_IO) {
>> + pci->io.phys_start = hose->regions[ret].phys_start; /* IO base */
>> + pci->io.bus_start  = hose->regions[ret].bus_start;  /* IO_bus_addr */
>> + pci->io.size       = hose->regions[ret].size;      /* IO size */
>> + } else if (hose->regions[ret].flags == PCI_REGION_MEM) {
>> + pci->mem.phys_start = hose->regions[ret].phys_start; /* MEM base */
>> + pci->mem.bus_start  = hose->regions[ret].bus_start;  /* MEM_bus_addr */
>> + pci->mem.size      = hose->regions[ret].size;     /* MEM size */
>> + } else if (hose->regions[ret].flags == PCI_REGION_SYS_MEMORY) {
>> + pci->cfg_base = (void *)(pci->io.phys_start - pci->io.size);
>> + pci->cfg_size = pci->io.size;
>> + } else {
>> + dev_err(pci->dev, "invalid flags type!\n");
> 
> Need another 'else if' for "PCI_REGION_PREFETCH", otherwise code goes
> to dev_err() if region type is 'prefetch'.


Sure, will add.

> 
>> + }
>> + }
>> +
>> + dev_dbg(pci->dev, "Config space: [0x%p - 0x%p, size 0x%llx]\n",
>> + pci->cfg_base, pci->cfg_base + pci->cfg_size,
>> + pci->cfg_size);
>> +
>> + dev_dbg(pci->dev, "IO space: [0x%llx - 0x%llx, size 0x%lx]\n",
>> + pci->io.phys_start, pci->io.phys_start + pci->io.size,
>> + pci->io.size);
>> +
>> + dev_dbg(pci->dev, "IO bus:   [0x%lx - 0x%lx, size 0x%lx]\n",
>> + pci->io.bus_start, pci->io.bus_start + pci->io.size,
>> + pci->io.size);
>> +
>> + dev_dbg(pci->dev, "MEM space: [0x%llx - 0x%llx, size 0x%lx]\n",
>> + pci->mem.phys_start, pci->mem.phys_start + pci->mem.size,
>> + pci->mem.size);
>> +
>> + dev_dbg(pci->dev, "MEM bus:   [0x%lx - 0x%lx, size 0x%lx]\n",
>> + pci->mem.bus_start, pci->mem.bus_start + pci->mem.size,
>> + pci->mem.size);
>> +}
>> +
>> diff --git a/drivers/pci/pcie_dw_common.h b/drivers/pci/pcie_dw_common.h
>> new file mode 100644
>> index 0000000000..48c61a3735
>> --- /dev/null
>> +++ b/drivers/pci/pcie_dw_common.h
>> @@ -0,0 +1,153 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (c) 2021 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + *
>> + * Copyright (c) 2021 Rockchip, Inc.
>> + *
>> + * Copyright (C) 2018 Texas Instruments, Inc
>> + */
>> +
>> +#ifndef PCIE_DW_COMMON_H
>> +#define PCIE_DW_COMMON_H
>> +
>> +#define DEFAULT_DBI_ATU_OFFSET (0x3 << 20)
>> +
>> +/* PCI DBICS registers */
>> +#define PCIE_LINK_STATUS_REG 0x80
>> +#define PCIE_LINK_STATUS_SPEED_OFF 16
>> +#define PCIE_LINK_STATUS_SPEED_MASK (0xf << PCIE_LINK_STATUS_SPEED_OFF)
>> +#define PCIE_LINK_STATUS_WIDTH_OFF 20
>> +#define PCIE_LINK_STATUS_WIDTH_MASK (0xf << PCIE_LINK_STATUS_WIDTH_OFF)
>> +
>> +/*
>> + * iATU Unroll-specific register definitions
>> + * From 4.80 core version the address translation will be made by unroll.
>> + * The registers are offset from atu_base
>> + */
>> +#define PCIE_ATU_UNR_REGION_CTRL1 0x00
>> +#define PCIE_ATU_UNR_REGION_CTRL2 0x04
>> +#define PCIE_ATU_UNR_LOWER_BASE 0x08
>> +#define PCIE_ATU_UNR_UPPER_BASE 0x0c
>> +#define PCIE_ATU_UNR_LIMIT 0x10
>> +#define PCIE_ATU_UNR_LOWER_TARGET 0x14
>> +#define PCIE_ATU_UNR_UPPER_TARGET 0x18
>> +
>> +#define PCIE_ATU_REGION_INDEX1 (0x1 << 0)
>> +#define PCIE_ATU_REGION_INDEX0 (0x0 << 0)
>> +#define PCIE_ATU_TYPE_MEM (0x0 << 0)
>> +#define PCIE_ATU_TYPE_IO (0x2 << 0)
>> +#define PCIE_ATU_TYPE_CFG0 (0x4 << 0)
>> +#define PCIE_ATU_TYPE_CFG1 (0x5 << 0)
>> +#define PCIE_ATU_ENABLE (0x1 << 31)
>> +#define PCIE_ATU_BAR_MODE_ENABLE (0x1 << 30)
>> +#define PCIE_ATU_BUS(x) (((x) & 0xff) << 24)
>> +#define PCIE_ATU_DEV(x) (((x) & 0x1f) << 19)
>> +#define PCIE_ATU_FUNC(x) (((x) & 0x7) << 16)
>> +
>> +/* Register address builder */
>> +#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region) ((region) << 9)
>> +
>> +/* Parameters for the waiting for iATU enabled routine */
>> +#define LINK_WAIT_MAX_IATU_RETRIES 5
>> +#define LINK_WAIT_IATU_US 10000
>> +
>> +/* PCI DBICS registers */
>> +#define PCIE_LINK_STATUS_REG 0x80
>> +#define PCIE_LINK_STATUS_SPEED_OFF 16
>> +#define PCIE_LINK_STATUS_SPEED_MASK (0xf << PCIE_LINK_STATUS_SPEED_OFF)
>> +#define PCIE_LINK_STATUS_WIDTH_OFF 20
>> +#define PCIE_LINK_STATUS_WIDTH_MASK (0xf << PCIE_LINK_STATUS_WIDTH_OFF)
>> +
>> +#define PCIE_LINK_CAPABILITY 0x7c
>> +#define PCIE_LINK_CTL_2 0xa0
>> +#define TARGET_LINK_SPEED_MASK 0xf
>> +#define LINK_SPEED_GEN_1 0x1
>> +#define LINK_SPEED_GEN_2 0x2
>> +#define LINK_SPEED_GEN_3 0x3
>> +
>> +/* Synopsys-specific PCIe configuration registers */
>> +#define PCIE_PORT_LINK_CONTROL 0x710
>> +#define PORT_LINK_DLL_LINK_EN BIT(5)
>> +#define PORT_LINK_FAST_LINK_MODE BIT(7)
>> +#define PORT_LINK_MODE_MASK GENMASK(21, 16)
>> +#define PORT_LINK_MODE(n) FIELD_PREP(PORT_LINK_MODE_MASK, n)
>> +#define PORT_LINK_MODE_1_LANES PORT_LINK_MODE(0x1)
>> +#define PORT_LINK_MODE_2_LANES PORT_LINK_MODE(0x3)
>> +#define PORT_LINK_MODE_4_LANES PORT_LINK_MODE(0x7)
>> +#define PORT_LINK_MODE_8_LANES PORT_LINK_MODE(0xf)
>> +
>> +#define PCIE_LINK_WIDTH_SPEED_CONTROL 0x80C
>> +#define PORT_LOGIC_N_FTS_MASK GENMASK(7, 0)
>> +#define PORT_LOGIC_SPEED_CHANGE BIT(17)
>> +#define PORT_LOGIC_LINK_WIDTH_MASK GENMASK(12, 8)
>> +#define PORT_LOGIC_LINK_WIDTH(n) FIELD_PREP(PORT_LOGIC_LINK_WIDTH_MASK, n)
>> +#define PORT_LOGIC_LINK_WIDTH_1_LANES PORT_LOGIC_LINK_WIDTH(0x1)
>> +#define PORT_LOGIC_LINK_WIDTH_2_LANES PORT_LOGIC_LINK_WIDTH(0x2)
>> +#define PORT_LOGIC_LINK_WIDTH_4_LANES PORT_LOGIC_LINK_WIDTH(0x4)
>> +#define PORT_LOGIC_LINK_WIDTH_8_LANES PORT_LOGIC_LINK_WIDTH(0x8)
>> +
>> +#define PCIE_MISC_CONTROL_1_OFF 0x8bc
>> +#define PCIE_DBI_RO_WR_EN BIT(0)
>> +
>> +/* Parameters for the waiting for iATU enabled routine */
>> +#define LINK_WAIT_MAX_IATU_RETRIES 5
>> +#define LINK_WAIT_IATU 10000
>> +
>> +/**
>> + * struct pcie_dw - DW PCIe controller state
>> + *
>> + * @dbi_base: The base address of dbi register space
>> + * @cfg_base: The base address of configuration space
>> + * @atu_base: The base address of ATU space
>> + * @cfg_size: The size of the configuration space which is needed
>> + *            as it gets written into the PCIE_ATU_LIMIT register
>> + * @first_busno: This driver supports multiple PCIe controllers.
>> + *               first_busno stores the bus number of the PCIe root-port
>> + *               number which may vary depending on the PCIe setup
>> + *               (PEX switches etc).
>> + * @io: The IO space for EP's BAR
>> + * @mem: The memory space for EP's BAR
>> + */
>> +struct pcie_dw {
>> + struct udevice *dev;
>> + void *dbi_base;
>> + void *cfg_base;
>> + void *atu_base;
> 
> Can we use "void __iomem *" instead?

Yes, It should be possible, and cleaner.

> 
>> + fdt_size_t cfg_size;
>> +
>> + int first_busno;
>> +
>> + /* IO and MEM PCI regions */
>> + struct pci_region io;
>> + struct pci_region mem;
> 
> Need a region for the prefetch?

Yep will add

> 
>> +};
>> +
>> +int pcie_dw_get_link_speed(struct pcie_dw *pci);
>> +
>> +int pcie_dw_get_link_width(struct pcie_dw *pci);
>> +
>> +int pcie_dw_prog_outbound_atu_unroll(struct pcie_dw *pci, int index, int type, u64 cpu_addr,
>> +      u64 pci_addr, u32 size);
>> +
>> +int pcie_dw_read_config(const struct udevice *bus, pci_dev_t bdf, uint offset, ulong *valuep,
>> + enum pci_size_t size);
>> +
>> +int pcie_dw_write_config(struct udevice *bus, pci_dev_t bdf, uint offset, ulong value,
>> + enum pci_size_t size);
>> +
>> +static inline void dw_pcie_dbi_write_enable(struct pcie_dw *pci, bool en)
>> +{
>> + u32 val;
>> +
>> + val = readl(pci->dbi_base + PCIE_MISC_CONTROL_1_OFF);
>> + if (en)
>> + val |= PCIE_DBI_RO_WR_EN;
>> + else
>> + val &= ~PCIE_DBI_RO_WR_EN;
>> + writel(val, pci->dbi_base + PCIE_MISC_CONTROL_1_OFF);
>> +}
>> +
>> +void pcie_dw_setup_host(struct pcie_dw *pci);
>> +
>>
>> +#endif

Thanks for your test, I'll send a v2 with those changes.

Neil
