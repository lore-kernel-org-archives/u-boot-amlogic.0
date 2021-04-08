Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web12.4994.1617867716298236155
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Apr 2021 00:41:57 -0700
Received: by mail-wr1-f49.google.com with SMTP id q26so991990wrz.9
        for <u-boot-amlogic@groups.io>; Thu, 08 Apr 2021 00:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cb05Nl8X+w8Ee/bLbrhe7sRB7ckf5PrQbU3ucT9//z4=;
        b=obvwbntaLVKEL1ZxJtJqB64fKnMJLTimb8MyA3T9bPgEygkQKz2HoWRPkBk81zYa7h
         y3KjHUVtJEYEcoXFee08eAsmuFxg7Xsj/2mGA0MwnifOnFY7kayf0sochklWmPzN5SSX
         ap0qGI/E7x+IEcptAQuN9rvGpwMT2OoLVjVEGRIqXtfsPaYsKHKj00w6jFy0nyLfOdyK
         OYYWImgc8hKsKu81mXFoRl6fsrgL2yZH1aO27hxvdnblC5c48AJJuPD3ZUSiMoY1qKJb
         Sxmv2Th/agvnD+ExWWpAHrGPGQmVcm/t4yNRzNldaMWTRvzN0KOimn+ljjKennHStmPV
         rxvA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH RFT v2 0/4] pci: add common Designware PCIe functions and support Amlogic Meson PCIe controller
References: <20210325144921.1791892-1-narmstrong@baylibre.com>
 <d5f05f02-22e8-1faf-5754-715cd8dcfebd@baylibre.com>
 <CAEUhbmWtr93MGjEL9yfEz+ou5v-8y5w8eA+BxNeYLhxjkvZ+Tw@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <a4cc1629-c2a9-95bf-771e-2c48cec2af4e@baylibre.com>
Date: Thu, 8 Apr 2021 09:41:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAEUhbmWtr93MGjEL9yfEz+ou5v-8y5w8eA+BxNeYLhxjkvZ+Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, shawn.lin@rock-chips.com, Green Wan <green.wan@sifive.com>
List-ID: <u-boot-amlogic@groups.io>

On 08/04/2021 07:29, Bin Meng wrote:
> Hi Neil,
> 
> On Tue, Apr 6, 2021 at 8:22 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi Bin,
>>
>> On 25/03/2021 15:49, Neil Armstrong wrote:
>>> With the introduction of pcie_dw_rockchip, and need to support the DW PCIe in the
>>> Amlogic AXG & G12 SoCs, most of the DW PCIe helpers would be duplicated.
>>>
>>> This introduce a "common" DW PCIe helpers file with common code merged from the
>>> dw_ti and dw_rockchip drivers and adapted to fit with the upcoming dw_meson.
>>>
>>> The following changes will switch the dw_ti and dw_rockchip, and introduce a new
>>> driver to support the Amlogic AXG & G12 SoCs using these new common helpers.
>>>
>>> The dw_meson has been validated, but the dw_ti and dw_rockchip would need testing
>>> on hardware to validate nothing has been broken.
>>
>> How should be proceed ? I can't possibly test patches 2 & 3, but Green has tested it
>> on Sifive, should patch 1 & 4 be merged then we should wait feedback from the Ti & Rockchip
>> owners ?
> 
> This series is not assigned to me in patchwork so I cannot decide anything :)

I can switch them to you, but I never know who to assign for these multi-vendor series...

> 
> But my opinion was that let's wait for some more time, and if nobody
> jumps out let's merge this series.

Fine fore me !

Thanks,
Neil

> 
> Regards,
> Bin
> 

