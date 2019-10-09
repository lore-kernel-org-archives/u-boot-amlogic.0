Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.5865.1570633962199875242
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Oct 2019 08:12:43 -0700
Received: by mail-wr1-f65.google.com with SMTP id b9so3523073wrs.0
        for <u-boot-amlogic@groups.io>; Wed, 09 Oct 2019 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vfG7flUDy3IPtfdueG7Pso021WKfm/wPKsbMaKioIbI=;
        b=GGD6EiyLHB413dWNJFoOd4V4AxGw1AHu8Iz/EAr1Rf6Pl8Hnjl9iYfnB932FY3vZsg
         IHZYphoMffIgtK+fIpnqqxkumAw7hDXFwYOt3Qza0IOWwOoWcljpYwnMCcEHclFKB8yY
         8jHRsnEkzhDDgiHWzY99Ao8mbonIqYcA+J8Cx9KB6xiQY9ajct9x1qtamonKLfDuqF1i
         xxYsp0PDLP93jTtSJoCm0z1SrJGLjTHmyeuE0NgZVt45fM5G1pC41abfAPEzixIg8Ayi
         KVfmIGH7R1n+qyr3fiEWHRFRtSOyGudjmEeGWNwP/c9rtEISwlc0sCNdMjR0VxlRvyTk
         0xSQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 4/8] video: meson: sync with linux drm-misc tree
References: <20190830120928.23890-1-narmstrong@baylibre.com>
 <20190830120928.23890-5-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8c4b276a-3757-c671-1f51-8a8f29597a23@baylibre.com>
Date: Wed, 9 Oct 2019 17:12:37 +0200
MIME-Version: 1.0
In-Reply-To: <20190830120928.23890-5-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: agust@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi Anatolij,

Gentle ping, did you have time to review this patchset ?

Thanks,
Neil
On 30/08/2019 14:09, Neil Armstrong wrote:
> Synchronize the Amlogic Meson Video driver back with the latest
> DRM misc tree, adding G12A platform support, from the latest commit:
> 528a25d040bc ("drm: meson: use match data to detect vpu compatibility")
> 
> The sync includes the following changes from Linux adapted to U-Boot:
> - Add support for VIC alternate timings
> - Switch PLL to 5.94GHz base for 297Mhz pixel clock
> - Add registers for G12A SoC
> - Add G12A Support for VPP setup
> - Add G12A Support for VIU setup
> - Add G12A support for OSD1 Plane
> - Add G12A support for plane handling in CRTC driver
> - Add G12A support for CVBS Encoder
> - Add G12A Video Clock setup
> - Add G12A support for the DW-HDMI Glue
> - fix G12A HDMI PLL settings for 4K60 1000/1001 variations
> - fix primary plane disabling
> - fix G12A primary plane disabling
> - mask value when writing bits relaxed
> - crtc: drv: vpp: viu: venc: use proper macros instead of magic constants
> - global clean-up
> - add macro used to enable HDMI PLL
> - venc: set the correct macrovision max amplitude value
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/video/meson/meson_dw_hdmi.c   |  61 ++++-
>  drivers/video/meson/meson_plane.c     |  47 +++-
>  drivers/video/meson/meson_registers.h | 373 +++++++++++++++++++++++++-
>  drivers/video/meson/meson_vclk.c      | 233 ++++++++++++----
>  drivers/video/meson/meson_venc.c      | 169 +++++++++---
>  drivers/video/meson/meson_vpu.h       |   1 +
>  drivers/video/meson/meson_vpu_init.c  | 205 +++++++++++---
>  7 files changed, 929 insertions(+), 160 deletions(-)
> 
> diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
> index 9831d978fc..ae2e6288f3 100644
> --- a/drivers/video/meson/meson_dw_hdmi.c
> +++ b/drivers/video/meson/meson_dw_hdmi.c
> @@ -24,6 +24,7 @@
>  #define HDMITX_TOP_ADDR_REG	0x0
>  #define HDMITX_TOP_DATA_REG	0x4
>  #define HDMITX_TOP_CTRL_REG	0x8
> +#define HDMITX_TOP_G12A_OFFSET	0x8000
>  
>  /* Controller Communication Channel */
>  #define HDMITX_DWC_ADDR_REG	0x10
> @@ -37,6 +38,8 @@
>  #define HHI_HDMI_PHY_CNTL1	0x3a4 /* 0xe9 */
>  #define HHI_HDMI_PHY_CNTL2	0x3a8 /* 0xea */
>  #define HHI_HDMI_PHY_CNTL3	0x3ac /* 0xeb */
> +#define HHI_HDMI_PHY_CNTL4	0x3b0 /* 0xec */
> +#define HHI_HDMI_PHY_CNTL5	0x3b4 /* 0xed */
>  
>  struct meson_dw_hdmi {
>  	struct udevice *dev;
> @@ -48,6 +51,7 @@ enum hdmi_compatible {
>  	HDMI_COMPATIBLE_GXBB = 0,
>  	HDMI_COMPATIBLE_GXL = 1,
>  	HDMI_COMPATIBLE_GXM = 2,
> +	HDMI_COMPATIBLE_G12A = 3,
>  };
>  
>  static inline bool meson_hdmi_is_compatible(struct meson_dw_hdmi *priv,
> @@ -60,8 +64,14 @@ static inline bool meson_hdmi_is_compatible(struct meson_dw_hdmi *priv,
>  
>  static unsigned int dw_hdmi_top_read(struct dw_hdmi *hdmi, unsigned int addr)
>  {
> +	struct meson_dw_hdmi *priv = container_of(hdmi, struct meson_dw_hdmi,
> +						  hdmi);
>  	unsigned int data;
>  
> +	if (meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_G12A))
> +		return readl(hdmi->ioaddr +
> +			     HDMITX_TOP_G12A_OFFSET + (addr << 2));
> +
>  	/* ADDR must be written twice */
>  	writel(addr & 0xffff, hdmi->ioaddr + HDMITX_TOP_ADDR_REG);
>  	writel(addr & 0xffff, hdmi->ioaddr + HDMITX_TOP_ADDR_REG);
> @@ -76,6 +86,15 @@ static unsigned int dw_hdmi_top_read(struct dw_hdmi *hdmi, unsigned int addr)
>  static inline void dw_hdmi_top_write(struct dw_hdmi *hdmi,
>  				     unsigned int addr, unsigned int data)
>  {
> +	struct meson_dw_hdmi *priv = container_of(hdmi, struct meson_dw_hdmi,
> +						  hdmi);
> +
> +	if (meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_G12A)) {
> +		writel(data, hdmi->ioaddr +
> +		       HDMITX_TOP_G12A_OFFSET + (addr << 2));
> +		return;
> +	}
> +
>  	/* ADDR must be written twice */
>  	writel(addr & 0xffff, hdmi->ioaddr + HDMITX_TOP_ADDR_REG);
>  	writel(addr & 0xffff, hdmi->ioaddr + HDMITX_TOP_ADDR_REG);
> @@ -237,7 +256,7 @@ static void meson_dw_hdmi_phy_setup_mode(struct meson_dw_hdmi *priv,
>  			hhi_write(HHI_HDMI_PHY_CNTL0, 0x33604142);
>  			hhi_write(HHI_HDMI_PHY_CNTL3, 0x0016315b);
>  		}
> -	} else {
> +	} else if (meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_GXBB)) {
>  		if (pixel_clock >= 371250) {
>  			/* 5.94Gbps, 3.7125Gbps */
>  			hhi_write(HHI_HDMI_PHY_CNTL0, 0x33353245);
> @@ -251,6 +270,23 @@ static void meson_dw_hdmi_phy_setup_mode(struct meson_dw_hdmi *priv,
>  			hhi_write(HHI_HDMI_PHY_CNTL0, 0x33632122);
>  			hhi_write(HHI_HDMI_PHY_CNTL3, 0x2000115b);
>  		}
> +	} else if (meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_G12A)) {
> +		if (pixel_clock >= 371250) {
> +			/* 5.94Gbps, 3.7125Gbps */
> +			hhi_write(HHI_HDMI_PHY_CNTL0, 0x37eb65c4);
> +			hhi_write(HHI_HDMI_PHY_CNTL3, 0x2ab0ff3b);
> +			hhi_write(HHI_HDMI_PHY_CNTL5, 0x0000080b);
> +		} else if (pixel_clock >= 297000) {
> +			/* 2.97Gbps */
> +			hhi_write(HHI_HDMI_PHY_CNTL0, 0x33eb6262);
> +			hhi_write(HHI_HDMI_PHY_CNTL3, 0x2ab0ff3b);
> +			hhi_write(HHI_HDMI_PHY_CNTL5, 0x00000003);
> +		} else {
> +			/* 1.485Gbps, and below */
> +			hhi_write(HHI_HDMI_PHY_CNTL0, 0x33eb4242);
> +			hhi_write(HHI_HDMI_PHY_CNTL3, 0x2ab0ff3b);
> +			hhi_write(HHI_HDMI_PHY_CNTL5, 0x00000003);
> +		}
>  	}
>  }
>  
> @@ -292,7 +328,8 @@ static int meson_dw_hdmi_phy_init(struct dw_hdmi *hdmi, uint pixel_clock)
>  
>  	/* BIT_INVERT */
>  	if (meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_GXL) ||
> -	    meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_GXM))
> +	    meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_GXM) ||
> +	    meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_G12A))
>  		dw_hdmi_hhi_update_bits(priv, HHI_HDMI_PHY_CNTL1, BIT(17), 0);
>  	else
>  		dw_hdmi_hhi_update_bits(priv, HHI_HDMI_PHY_CNTL1,
> @@ -356,8 +393,12 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
>  	priv->hdmi.hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>  	priv->hdmi.hdmi_data.enc_in_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
>  	priv->hdmi.phy_set = meson_dw_hdmi_phy_init;
> -	priv->hdmi.write_reg = dw_hdmi_dwc_write;
> -	priv->hdmi.read_reg = dw_hdmi_dwc_read;
> +	if (meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_G12A))
> +		priv->hdmi.reg_io_width = 1;
> +	else {
> +		priv->hdmi.write_reg = dw_hdmi_dwc_write;
> +		priv->hdmi.read_reg = dw_hdmi_dwc_read;
> +	}
>  	priv->hdmi.i2c_clk_high = 0x67;
>  	priv->hdmi.i2c_clk_low = 0x78;
>  
> @@ -409,9 +450,13 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
>  	if (ret)
>  		return ret;
>  
> -	/* Enable APB3 fail on error */
> -	writel_bits(BIT(15), BIT(15), priv->hdmi.ioaddr + HDMITX_TOP_CTRL_REG);
> -	writel_bits(BIT(15), BIT(15), priv->hdmi.ioaddr + HDMITX_DWC_CTRL_REG);
> +	if (!meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_G12A)) {
> +		/* Enable APB3 fail on error */
> +		writel_bits(BIT(15), BIT(15),
> +			    priv->hdmi.ioaddr + HDMITX_TOP_CTRL_REG);
> +		writel_bits(BIT(15), BIT(15),
> +			    priv->hdmi.ioaddr + HDMITX_DWC_CTRL_REG);
> +	}
>  
>  	/* Bring out of reset */
>  	dw_hdmi_top_write(&priv->hdmi, HDMITX_TOP_SW_RESET,  0);
> @@ -448,6 +493,8 @@ static const struct udevice_id meson_dw_hdmi_ids[] = {
>  		.data = HDMI_COMPATIBLE_GXL },
>  	{ .compatible = "amlogic,meson-gxm-dw-hdmi",
>  		.data = HDMI_COMPATIBLE_GXM },
> +	{ .compatible = "amlogic,meson-g12a-dw-hdmi",
> +		.data = HDMI_COMPATIBLE_G12A },
>  	{ }
>  };
>  
> diff --git a/drivers/video/meson/meson_plane.c b/drivers/video/meson/meson_plane.c
> index 63a4bf2d8d..2bc9327e1e 100644
> --- a/drivers/video/meson/meson_plane.c
> +++ b/drivers/video/meson/meson_plane.c
> @@ -108,12 +108,33 @@ void meson_vpu_setup_plane(struct udevice *dev, bool is_interlaced)
>  	dest_y1 = src_y1 = 0;
>  	dest_y2 = src_y2 = uc_priv->ysize;
>  
> -	/* Enable VPP Postblend */
> -	writel(uc_priv->xsize,
> -	       priv->io_base + _REG(VPP_POSTBLEND_H_SIZE));
> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
> +		/* VD1 Preblend vertical start/end */
> +		writel(FIELD_PREP(GENMASK(11, 0), 2303),
> +		       priv->io_base + _REG(VPP_PREBLEND_VD1_V_START_END));
> +
> +		/* Setup Blender */
> +		writel(uc_priv->xsize |
> +		       uc_priv->ysize << 16,
> +		       priv->io_base + _REG(VPP_POSTBLEND_H_SIZE));
> +
> +		writel(0 << 16 |
> +		       (uc_priv->xsize - 1),
> +		       priv->io_base + _REG(VPP_OSD1_BLD_H_SCOPE));
> +		writel(0 << 16 |
> +		       (uc_priv->ysize - 1),
> +		       priv->io_base + _REG(VPP_OSD1_BLD_V_SCOPE));
> +		writel(uc_priv->xsize << 16 |
> +		       uc_priv->ysize,
> +		       priv->io_base + _REG(VPP_OUT_H_V_SIZE));
> +	} else {
> +		/* Enable VPP Postblend */
> +		writel(uc_priv->xsize,
> +		       priv->io_base + _REG(VPP_POSTBLEND_H_SIZE));
>  
> -	writel_bits(VPP_POSTBLEND_ENABLE, VPP_POSTBLEND_ENABLE,
> -		    priv->io_base + _REG(VPP_MISC));
> +		writel_bits(VPP_POSTBLEND_ENABLE, VPP_POSTBLEND_ENABLE,
> +			    priv->io_base + _REG(VPP_MISC));
> +	}
>  
>  	/* uc_plat->base is the framebuffer */
>  
> @@ -172,6 +193,18 @@ void meson_vpu_setup_plane(struct udevice *dev, bool is_interlaced)
>  			   MESON_CANVAS_BLKMODE_LINEAR);
>  
>  	/* Enable OSD1 */
> -	writel_bits(VPP_OSD1_POSTBLEND, VPP_OSD1_POSTBLEND,
> -		    priv->io_base + _REG(VPP_MISC));
> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
> +		writel(((dest_x2 - 1) << 16) | dest_x1,
> +		       priv->io_base + _REG(VIU_OSD_BLEND_DIN0_SCOPE_H));
> +		writel(((dest_y2 - 1) << 16) | dest_y1,
> +		       priv->io_base + _REG(VIU_OSD_BLEND_DIN0_SCOPE_V));
> +		writel(uc_priv->xsize << 16 | uc_priv->ysize,
> +		       priv->io_base + _REG(VIU_OSD_BLEND_BLEND0_SIZE));
> +		writel(uc_priv->xsize << 16 | uc_priv->ysize,
> +		       priv->io_base + _REG(VIU_OSD_BLEND_BLEND1_SIZE));
> +		writel_bits(3 << 8, 3 << 8,
> +			    priv->io_base + _REG(OSD1_BLEND_SRC_CTRL));
> +	} else
> +		writel_bits(VPP_OSD1_POSTBLEND, VPP_OSD1_POSTBLEND,
> +			    priv->io_base + _REG(VPP_MISC));
>  }
> diff --git a/drivers/video/meson/meson_registers.h b/drivers/video/meson/meson_registers.h
> index 01fe7d2431..39e8ec8639 100644
> --- a/drivers/video/meson/meson_registers.h
> +++ b/drivers/video/meson/meson_registers.h
> @@ -136,11 +136,19 @@
>  #define VIU_ADDR_START 0x1a00
>  #define VIU_ADDR_END 0x1aff
>  #define VIU_SW_RESET 0x1a01
> +#define		VIU_SW_RESET_OSD1               BIT(0)
>  #define VIU_MISC_CTRL0 0x1a06
> +#define		VIU_CTRL0_VD1_AFBC_MASK         0x170000
>  #define VIU_MISC_CTRL1 0x1a07
>  #define D2D3_INTF_LENGTH 0x1a08
>  #define D2D3_INTF_CTRL0 0x1a09
>  #define VIU_OSD1_CTRL_STAT 0x1a10
> +#define		VIU_OSD1_OSD_BLK_ENABLE         BIT(0)
> +#define		VIU_OSD1_POSTBLD_SRC_VD1        (1 << 8)
> +#define		VIU_OSD1_POSTBLD_SRC_VD2        (2 << 8)
> +#define		VIU_OSD1_POSTBLD_SRC_OSD1       (3 << 8)
> +#define		VIU_OSD1_POSTBLD_SRC_OSD2       (4 << 8)
> +#define		VIU_OSD1_OSD_ENABLE             BIT(21)
>  #define VIU_OSD1_CTRL_STAT2 0x1a2d
>  #define VIU_OSD1_COLOR_ADDR 0x1a11
>  #define VIU_OSD1_COLOR 0x1a12
> @@ -206,6 +214,35 @@
>  #define VIU_OSD2_FIFO_CTRL_STAT 0x1a4b
>  #define VIU_OSD2_TEST_RDDATA 0x1a4c
>  #define VIU_OSD2_PROT_CTRL 0x1a4e
> +#define VIU_OSD2_MALI_UNPACK_CTRL 0x1abd
> +#define VIU_OSD2_DIMM_CTRL 0x1acf
> +
> +#define VIU_OSD3_CTRL_STAT 0x3d80
> +#define VIU_OSD3_CTRL_STAT2 0x3d81
> +#define VIU_OSD3_COLOR_ADDR 0x3d82
> +#define VIU_OSD3_COLOR 0x3d83
> +#define VIU_OSD3_TCOLOR_AG0 0x3d84
> +#define VIU_OSD3_TCOLOR_AG1 0x3d85
> +#define VIU_OSD3_TCOLOR_AG2 0x3d86
> +#define VIU_OSD3_TCOLOR_AG3 0x3d87
> +#define VIU_OSD3_BLK0_CFG_W0 0x3d88
> +#define VIU_OSD3_BLK0_CFG_W1 0x3d8c
> +#define VIU_OSD3_BLK0_CFG_W2 0x3d90
> +#define VIU_OSD3_BLK0_CFG_W3 0x3d94
> +#define VIU_OSD3_BLK0_CFG_W4 0x3d98
> +#define VIU_OSD3_BLK1_CFG_W4 0x3d99
> +#define VIU_OSD3_BLK2_CFG_W4 0x3d9a
> +#define VIU_OSD3_FIFO_CTRL_STAT 0x3d9c
> +#define VIU_OSD3_TEST_RDDATA 0x3d9d
> +#define VIU_OSD3_PROT_CTRL 0x3d9e
> +#define VIU_OSD3_MALI_UNPACK_CTRL 0x3d9f
> +#define VIU_OSD3_DIMM_CTRL 0x3da0
> +
> +#define VIU_OSD_DDR_PRIORITY_URGENT      BIT(0)
> +#define VIU_OSD_HOLD_FIFO_LINES(lines)   ((lines & 0x1f) << 5)
> +#define VIU_OSD_FIFO_DEPTH_VAL(val)      ((val & 0x7f) << 12)
> +#define VIU_OSD_WORDS_PER_BURST(words)   (((words & 0x4) >> 1) << 22)
> +#define VIU_OSD_FIFO_LIMITS(size)        ((size & 0xf) << 24)
>  
>  #define VD1_IF0_GEN_REG 0x1a50
>  #define VD1_IF0_CANVAS0 0x1a51
> @@ -277,6 +314,27 @@
>  #define VIU_OSD1_MATRIX_COEF31_32 0x1a9e
>  #define VIU_OSD1_MATRIX_COEF40_41 0x1a9f
>  #define VD1_IF0_GEN_REG3 0x1aa7
> +
> +#define VIU_OSD_BLENDO_H_START_END 0x1aa9
> +#define VIU_OSD_BLENDO_V_START_END 0x1aaa
> +#define VIU_OSD_BLEND_GEN_CTRL0 0x1aab
> +#define VIU_OSD_BLEND_GEN_CTRL1 0x1aac
> +#define VIU_OSD_BLEND_DUMMY_DATA 0x1aad
> +#define VIU_OSD_BLEND_CURRENT_XY 0x1aae
> +
> +#define VIU_OSD2_MATRIX_CTRL 0x1ab0
> +#define VIU_OSD2_MATRIX_COEF00_01 0x1ab1
> +#define VIU_OSD2_MATRIX_COEF02_10 0x1ab2
> +#define VIU_OSD2_MATRIX_COEF11_12 0x1ab3
> +#define VIU_OSD2_MATRIX_COEF20_21 0x1ab4
> +#define VIU_OSD2_MATRIX_COEF22 0x1ab5
> +#define VIU_OSD2_MATRIX_OFFSET0_1 0x1ab6
> +#define VIU_OSD2_MATRIX_OFFSET2 0x1ab7
> +#define VIU_OSD2_MATRIX_PRE_OFFSET0_1 0x1ab8
> +#define VIU_OSD2_MATRIX_PRE_OFFSET2 0x1ab9
> +#define VIU_OSD2_MATRIX_PROBE_COLOR 0x1aba
> +#define VIU_OSD2_MATRIX_HL_COLOR 0x1abb
> +#define VIU_OSD2_MATRIX_PROBE_POS 0x1abc
>  #define VIU_OSD1_EOTF_CTL 0x1ad4
>  #define VIU_OSD1_EOTF_COEF00_01 0x1ad5
>  #define VIU_OSD1_EOTF_COEF02_10 0x1ad6
> @@ -295,6 +353,7 @@
>  #define VPP_LINE_IN_LENGTH 0x1d01
>  #define VPP_PIC_IN_HEIGHT 0x1d02
>  #define VPP_SCALE_COEF_IDX 0x1d03
> +#define		VPP_SCALE_HORIZONTAL_COEF       BIT(8)
>  #define VPP_SCALE_COEF 0x1d04
>  #define VPP_VSC_REGION12_STARTP 0x1d05
>  #define VPP_VSC_REGION34_STARTP 0x1d06
> @@ -316,6 +375,12 @@
>  #define VPP_HSC_REGION4_PHASE_SLOPE 0x1d17
>  #define VPP_HSC_PHASE_CTRL 0x1d18
>  #define VPP_SC_MISC 0x1d19
> +#define		VPP_SC_VD_EN_ENABLE             BIT(15)
> +#define		VPP_SC_TOP_EN_ENABLE            BIT(16)
> +#define		VPP_SC_HSC_EN_ENABLE            BIT(17)
> +#define		VPP_SC_VSC_EN_ENABLE            BIT(18)
> +#define		VPP_VSC_BANK_LENGTH(length)     (length & 0x7)
> +#define		VPP_HSC_BANK_LENGTH(length)     ((length & 0x7) << 8)
>  #define VPP_PREBLEND_VD1_H_START_END 0x1d1a
>  #define VPP_PREBLEND_VD1_V_START_END 0x1d1b
>  #define VPP_POSTBLEND_VD1_H_START_END 0x1d1c
> @@ -325,24 +390,28 @@
>  #define VPP_PREBLEND_H_SIZE 0x1d20
>  #define VPP_POSTBLEND_H_SIZE 0x1d21
>  #define VPP_HOLD_LINES 0x1d22
> +#define		VPP_POSTBLEND_HOLD_LINES(lines) (lines & 0xf)
> +#define		VPP_PREBLEND_HOLD_LINES(lines)  ((lines & 0xf) << 8)
>  #define VPP_BLEND_ONECOLOR_CTRL 0x1d23
>  #define VPP_PREBLEND_CURRENT_XY 0x1d24
>  #define VPP_POSTBLEND_CURRENT_XY 0x1d25
>  #define VPP_MISC 0x1d26
> -#define		VPP_PREBLEND_ENABLE	BIT(6)
> -#define		VPP_POSTBLEND_ENABLE	BIT(7)
> -#define		VPP_OSD2_ALPHA_PREMULT	BIT(8)
> -#define		VPP_OSD1_ALPHA_PREMULT	BIT(9)
> -#define		VPP_VD1_POSTBLEND	BIT(10)
> -#define		VPP_VD2_POSTBLEND	BIT(11)
> -#define		VPP_OSD1_POSTBLEND	BIT(12)
> -#define		VPP_OSD2_POSTBLEND	BIT(13)
> -#define		VPP_VD1_PREBLEND	BIT(14)
> -#define		VPP_VD2_PREBLEND	BIT(15)
> -#define		VPP_OSD1_PREBLEND	BIT(16)
> -#define		VPP_OSD2_PREBLEND	BIT(17)
> -#define		VPP_COLOR_MNG_ENABLE	BIT(28)
> +#define		VPP_PREBLEND_ENABLE             BIT(6)
> +#define		VPP_POSTBLEND_ENABLE            BIT(7)
> +#define		VPP_OSD2_ALPHA_PREMULT          BIT(8)
> +#define		VPP_OSD1_ALPHA_PREMULT          BIT(9)
> +#define		VPP_VD1_POSTBLEND               BIT(10)
> +#define		VPP_VD2_POSTBLEND               BIT(11)
> +#define		VPP_OSD1_POSTBLEND              BIT(12)
> +#define		VPP_OSD2_POSTBLEND              BIT(13)
> +#define		VPP_VD1_PREBLEND                BIT(14)
> +#define		VPP_VD2_PREBLEND                BIT(15)
> +#define		VPP_OSD1_PREBLEND               BIT(16)
> +#define		VPP_OSD2_PREBLEND               BIT(17)
> +#define		VPP_COLOR_MNG_ENABLE            BIT(28)
>  #define VPP_OFIFO_SIZE 0x1d27
> +#define		VPP_OFIFO_SIZE_MASK             GENMASK(13, 0)
> +#define		VPP_OFIFO_SIZE_DEFAULT          (0xfff << 20 | 0x1000)
>  #define VPP_FIFO_STATUS 0x1d28
>  #define VPP_SMOKE_CTRL 0x1d29
>  #define VPP_SMOKE1_VAL 0x1d2a
> @@ -358,6 +427,8 @@
>  #define VPP_HSC_PHASE_CTRL1 0x1d34
>  #define VPP_HSC_INI_PAT_CTRL 0x1d35
>  #define VPP_VADJ_CTRL 0x1d40
> +#define		VPP_MINUS_BLACK_LVL_VADJ1_ENABLE BIT(1)
> +
>  #define VPP_VADJ1_Y 0x1d41
>  #define VPP_VADJ1_MA_MB 0x1d42
>  #define VPP_VADJ1_MC_MD 0x1d43
> @@ -417,6 +488,7 @@
>  #define VPP_PEAKING_VGAIN 0x1d92
>  #define VPP_PEAKING_NLP_1 0x1d93
>  #define VPP_DOLBY_CTRL 0x1d93
> +#define VPP_PPS_DUMMY_DATA_MODE (1 << 17)
>  #define VPP_PEAKING_NLP_2 0x1d94
>  #define VPP_PEAKING_NLP_3 0x1d95
>  #define VPP_PEAKING_NLP_4 0x1d96
> @@ -471,6 +543,83 @@
>  #define VPP_OSD_SCALE_COEF 0x1dcd
>  #define VPP_INT_LINE_NUM 0x1dce
>  
> +#define VPP_WRAP_OSD1_MATRIX_COEF00_01 0x3d60
> +#define VPP_WRAP_OSD1_MATRIX_COEF02_10 0x3d61
> +#define VPP_WRAP_OSD1_MATRIX_COEF11_12 0x3d62
> +#define VPP_WRAP_OSD1_MATRIX_COEF20_21 0x3d63
> +#define VPP_WRAP_OSD1_MATRIX_COEF22 0x3d64
> +#define VPP_WRAP_OSD1_MATRIX_COEF13_14 0x3d65
> +#define VPP_WRAP_OSD1_MATRIX_COEF23_24 0x3d66
> +#define VPP_WRAP_OSD1_MATRIX_COEF15_25 0x3d67
> +#define VPP_WRAP_OSD1_MATRIX_CLIP 0x3d68
> +#define VPP_WRAP_OSD1_MATRIX_OFFSET0_1 0x3d69
> +#define VPP_WRAP_OSD1_MATRIX_OFFSET2 0x3d6a
> +#define VPP_WRAP_OSD1_MATRIX_PRE_OFFSET0_1 0x3d6b
> +#define VPP_WRAP_OSD1_MATRIX_PRE_OFFSET2 0x3d6c
> +#define VPP_WRAP_OSD1_MATRIX_EN_CTRL 0x3d6d
> +
> +#define VPP_WRAP_OSD2_MATRIX_COEF00_01 0x3d70
> +#define VPP_WRAP_OSD2_MATRIX_COEF02_10 0x3d71
> +#define VPP_WRAP_OSD2_MATRIX_COEF11_12 0x3d72
> +#define VPP_WRAP_OSD2_MATRIX_COEF20_21 0x3d73
> +#define VPP_WRAP_OSD2_MATRIX_COEF22 0x3d74
> +#define VPP_WRAP_OSD2_MATRIX_COEF13_14 0x3d75
> +#define VPP_WRAP_OSD2_MATRIX_COEF23_24 0x3d76
> +#define VPP_WRAP_OSD2_MATRIX_COEF15_25 0x3d77
> +#define VPP_WRAP_OSD2_MATRIX_CLIP 0x3d78
> +#define VPP_WRAP_OSD2_MATRIX_OFFSET0_1 0x3d79
> +#define VPP_WRAP_OSD2_MATRIX_OFFSET2 0x3d7a
> +#define VPP_WRAP_OSD2_MATRIX_PRE_OFFSET0_1 0x3d7b
> +#define VPP_WRAP_OSD2_MATRIX_PRE_OFFSET2 0x3d7c
> +#define VPP_WRAP_OSD2_MATRIX_EN_CTRL 0x3d7d
> +
> +#define VPP_WRAP_OSD3_MATRIX_COEF00_01 0x3db0
> +#define VPP_WRAP_OSD3_MATRIX_COEF02_10 0x3db1
> +#define VPP_WRAP_OSD3_MATRIX_COEF11_12 0x3db2
> +#define VPP_WRAP_OSD3_MATRIX_COEF20_21 0x3db3
> +#define VPP_WRAP_OSD3_MATRIX_COEF22 0x3db4
> +#define VPP_WRAP_OSD3_MATRIX_COEF13_14 0x3db5
> +#define VPP_WRAP_OSD3_MATRIX_COEF23_24 0x3db6
> +#define VPP_WRAP_OSD3_MATRIX_COEF15_25 0x3db7
> +#define VPP_WRAP_OSD3_MATRIX_CLIP 0x3db8
> +#define VPP_WRAP_OSD3_MATRIX_OFFSET0_1 0x3db9
> +#define VPP_WRAP_OSD3_MATRIX_OFFSET2 0x3dba
> +#define VPP_WRAP_OSD3_MATRIX_PRE_OFFSET0_1 0x3dbb
> +#define VPP_WRAP_OSD3_MATRIX_PRE_OFFSET2 0x3dbc
> +#define VPP_WRAP_OSD3_MATRIX_EN_CTRL 0x3dbd
> +
> +/* osd2 scaler */
> +#define OSD2_VSC_PHASE_STEP 0x3d00
> +#define OSD2_VSC_INI_PHASE 0x3d01
> +#define OSD2_VSC_CTRL0 0x3d02
> +#define OSD2_HSC_PHASE_STEP 0x3d03
> +#define OSD2_HSC_INI_PHASE 0x3d04
> +#define OSD2_HSC_CTRL0 0x3d05
> +#define OSD2_HSC_INI_PAT_CTRL 0x3d06
> +#define OSD2_SC_DUMMY_DATA 0x3d07
> +#define OSD2_SC_CTRL0 0x3d08
> +#define OSD2_SCI_WH_M1 0x3d09
> +#define OSD2_SCO_H_START_END 0x3d0a
> +#define OSD2_SCO_V_START_END 0x3d0b
> +#define OSD2_SCALE_COEF_IDX 0x3d18
> +#define OSD2_SCALE_COEF 0x3d19
> +
> +/* osd34 scaler */
> +#define OSD34_SCALE_COEF_IDX 0x3d1e
> +#define OSD34_SCALE_COEF 0x3d1f
> +#define OSD34_VSC_PHASE_STEP 0x3d20
> +#define OSD34_VSC_INI_PHASE 0x3d21
> +#define OSD34_VSC_CTRL0 0x3d22
> +#define OSD34_HSC_PHASE_STEP 0x3d23
> +#define OSD34_HSC_INI_PHASE 0x3d24
> +#define OSD34_HSC_CTRL0 0x3d25
> +#define OSD34_HSC_INI_PAT_CTRL 0x3d26
> +#define OSD34_SC_DUMMY_DATA 0x3d27
> +#define OSD34_SC_CTRL0 0x3d28
> +#define OSD34_SCI_WH_M1 0x3d29
> +#define OSD34_SCO_H_START_END 0x3d2a
> +#define OSD34_SCO_V_START_END 0x3d2b
> +
>  /* viu2 */
>  #define VIU2_ADDR_START 0x1e00
>  #define VIU2_ADDR_END 0x1eff
> @@ -584,6 +733,25 @@
>  #define VENC_UPSAMPLE_CTRL0 0x1b64
>  #define VENC_UPSAMPLE_CTRL1 0x1b65
>  #define VENC_UPSAMPLE_CTRL2 0x1b66
> +#define		VENC_UPSAMPLE_CTRL_F0_2_CLK_RATIO        BIT(0)
> +#define		VENC_UPSAMPLE_CTRL_F1_EN                 BIT(5)
> +#define		VENC_UPSAMPLE_CTRL_F1_UPSAMPLE_EN        BIT(6)
> +#define		VENC_UPSAMPLE_CTRL_INTERLACE_HIGH_LUMA   (0x0 << 12)
> +#define		VENC_UPSAMPLE_CTRL_CVBS                  (0x1 << 12)
> +#define		VENC_UPSAMPLE_CTRL_S_VIDEO_LUMA          (0x2 << 12)
> +#define		VENC_UPSAMPLE_CTRL_S_VIDEO_CHROMA        (0x3 << 12)
> +#define		VENC_UPSAMPLE_CTRL_INTERLACE_PB          (0x4 << 12)
> +#define		VENC_UPSAMPLE_CTRL_INTERLACE_PR          (0x5 << 12)
> +#define		VENC_UPSAMPLE_CTRL_INTERLACE_R           (0x6 << 12)
> +#define		VENC_UPSAMPLE_CTRL_INTERLACE_G           (0x7 << 12)
> +#define		VENC_UPSAMPLE_CTRL_INTERLACE_B           (0x8 << 12)
> +#define		VENC_UPSAMPLE_CTRL_PROGRESSIVE_Y         (0x9 << 12)
> +#define		VENC_UPSAMPLE_CTRL_PROGRESSIVE_PB        (0xa << 12)
> +#define		VENC_UPSAMPLE_CTRL_PROGRESSIVE_PR        (0xb << 12)
> +#define		VENC_UPSAMPLE_CTRL_PROGRESSIVE_R         (0xc << 12)
> +#define		VENC_UPSAMPLE_CTRL_PROGRESSIVE_G         (0xd << 12)
> +#define		VENC_UPSAMPLE_CTRL_PROGRESSIVE_B         (0xe << 12)
> +#define		VENC_UPSAMPLE_CTRL_VDAC_TEST_VALUE       (0xf << 12)
>  #define TCON_INVERT_CTL 0x1b67
>  #define VENC_VIDEO_PROG_MODE 0x1b68
>  #define VENC_ENCI_LINE 0x1b69
> @@ -592,6 +760,7 @@
>  #define VENC_ENCP_PIXEL 0x1b6c
>  #define VENC_STATA 0x1b6d
>  #define VENC_INTCTRL 0x1b6e
> +#define		VENC_INTCTRL_ENCI_LNRST_INT_EN  BIT(1)
>  #define VENC_INTFLAG 0x1b6f
>  #define VENC_VIDEO_TST_EN 0x1b70
>  #define VENC_VIDEO_TST_MDSEL 0x1b71
> @@ -602,6 +771,7 @@
>  #define VENC_VIDEO_TST_CLRBAR_WIDTH 0x1b76
>  #define VENC_VIDEO_TST_VDCNT_STSET 0x1b77
>  #define VENC_VDAC_DACSEL0 0x1b78
> +#define		VENC_VDAC_SEL_ATV_DMD           BIT(5)
>  #define VENC_VDAC_DACSEL1 0x1b79
>  #define VENC_VDAC_DACSEL2 0x1b7a
>  #define VENC_VDAC_DACSEL3 0x1b7b
> @@ -622,6 +792,7 @@
>  #define VENC_VDAC_DAC5_GAINCTRL 0x1bfa
>  #define VENC_VDAC_DAC5_OFFSET 0x1bfb
>  #define VENC_VDAC_FIFO_CTRL 0x1bfc
> +#define		VENC_VDAC_FIFO_EN_ENCI_ENABLE   BIT(13)
>  #define ENCL_TCON_INVERT_CTL 0x1bfd
>  #define ENCP_VIDEO_EN 0x1b80
>  #define ENCP_VIDEO_SYNC_MODE 0x1b81
> @@ -637,6 +808,7 @@
>  #define ENCP_VIDEO_SYNC_OFFST 0x1b8b
>  #define ENCP_VIDEO_MACV_OFFST 0x1b8c
>  #define ENCP_VIDEO_MODE 0x1b8d
> +#define		ENCP_VIDEO_MODE_DE_V_HIGH       BIT(14)
>  #define ENCP_VIDEO_MODE_ADV 0x1b8e
>  #define ENCP_DBG_PX_RST 0x1b90
>  #define ENCP_DBG_LN_RST 0x1b91
> @@ -715,6 +887,11 @@
>  #define C656_FS_LNED 0x1be7
>  #define ENCI_VIDEO_MODE 0x1b00
>  #define ENCI_VIDEO_MODE_ADV 0x1b01
> +#define		ENCI_VIDEO_MODE_ADV_DMXMD(val)          (val & 0x3)
> +#define		ENCI_VIDEO_MODE_ADV_VBICTL_LINE_17_22   BIT(2)
> +#define		ENCI_VIDEO_MODE_ADV_YBW_MEDIUM          (0 << 4)
> +#define		ENCI_VIDEO_MODE_ADV_YBW_LOW             (0x1 << 4)
> +#define		ENCI_VIDEO_MODE_ADV_YBW_HIGH            (0x2 << 4)
>  #define ENCI_VIDEO_FSC_ADJ 0x1b02
>  #define ENCI_VIDEO_BRIGHT 0x1b03
>  #define ENCI_VIDEO_CONT 0x1b04
> @@ -785,13 +962,17 @@
>  #define ENCI_DBG_MAXPX 0x1b4c
>  #define ENCI_DBG_MAXLN 0x1b4d
>  #define ENCI_MACV_MAX_AMP 0x1b50
> +#define		ENCI_MACV_MAX_AMP_ENABLE_CHANGE BIT(15)
> +#define		ENCI_MACV_MAX_AMP_VAL(val)      (val & 0x83ff)
>  #define ENCI_MACV_PULSE_LO 0x1b51
>  #define ENCI_MACV_PULSE_HI 0x1b52
>  #define ENCI_MACV_BKP_MAX 0x1b53
>  #define ENCI_CFILT_CTRL 0x1b54
> +#define		ENCI_CFILT_CMPT_SEL_HIGH        BIT(1)
>  #define ENCI_CFILT7 0x1b55
>  #define ENCI_YC_DELAY 0x1b56
>  #define ENCI_VIDEO_EN 0x1b57
> +#define		ENCI_VIDEO_EN_ENABLE            BIT(0)
>  #define ENCI_DVI_HSO_BEGIN 0x1c00
>  #define ENCI_DVI_HSO_END 0x1c01
>  #define ENCI_DVI_VSO_BLINE_EVN 0x1c02
> @@ -803,6 +984,10 @@
>  #define ENCI_DVI_VSO_END_EVN 0x1c08
>  #define ENCI_DVI_VSO_END_ODD 0x1c09
>  #define ENCI_CFILT_CTRL2 0x1c0a
> +#define		ENCI_CFILT_CMPT_CR_DLY(delay)   (delay & 0xf)
> +#define		ENCI_CFILT_CMPT_CB_DLY(delay)   ((delay & 0xf) << 4)
> +#define		ENCI_CFILT_CVBS_CR_DLY(delay)   ((delay & 0xf) << 8)
> +#define		ENCI_CFILT_CVBS_CB_DLY(delay)   ((delay & 0xf) << 12)
>  #define ENCI_DACSEL_0 0x1c0b
>  #define ENCI_DACSEL_1 0x1c0c
>  #define ENCP_DACSEL_0 0x1c0d
> @@ -817,6 +1002,8 @@
>  #define ENCI_TST_CLRBAR_WIDTH 0x1c16
>  #define ENCI_TST_VDCNT_STSET 0x1c17
>  #define ENCI_VFIFO2VD_CTL 0x1c18
> +#define		ENCI_VFIFO2VD_CTL_ENABLE        BIT(0)
> +#define		ENCI_VFIFO2VD_CTL_VD_SEL(val)   ((val & 0xff) << 8)
>  #define ENCI_VFIFO2VD_PIXEL_START 0x1c19
>  #define ENCI_VFIFO2VD_PIXEL_END 0x1c1a
>  #define ENCI_VFIFO2VD_LINE_TOP_START 0x1c1b
> @@ -879,6 +1066,7 @@
>  #define VENC_VDAC_DAC5_FILT_CTRL0 0x1c56
>  #define VENC_VDAC_DAC5_FILT_CTRL1 0x1c57
>  #define VENC_VDAC_DAC0_FILT_CTRL0 0x1c58
> +#define		VENC_VDAC_DAC0_FILT_CTRL0_EN    BIT(0)
>  #define VENC_VDAC_DAC0_FILT_CTRL1 0x1c59
>  #define VENC_VDAC_DAC1_FILT_CTRL0 0x1c5a
>  #define VENC_VDAC_DAC1_FILT_CTRL1 0x1c5b
> @@ -1284,6 +1472,18 @@
>  #define		VIU2_SEL_VENC_ENCP	(2 << 2)
>  #define		VIU2_SEL_VENC_ENCT	(3 << 2)
>  #define VPU_HDMI_SETTING 0x271b
> +#define		VPU_HDMI_ENCI_DATA_TO_HDMI      BIT(0)
> +#define		VPU_HDMI_ENCP_DATA_TO_HDMI      BIT(1)
> +#define		VPU_HDMI_INV_HSYNC              BIT(2)
> +#define		VPU_HDMI_INV_VSYNC              BIT(3)
> +#define		VPU_HDMI_OUTPUT_CRYCB           (0 << 5)
> +#define		VPU_HDMI_OUTPUT_YCBCR           (1 << 5)
> +#define		VPU_HDMI_OUTPUT_YCRCB           (2 << 5)
> +#define		VPU_HDMI_OUTPUT_CBCRY           (3 << 5)
> +#define		VPU_HDMI_OUTPUT_CBYCR           (4 << 5)
> +#define		VPU_HDMI_OUTPUT_CRCBY           (5 << 5)
> +#define		VPU_HDMI_WR_RATE(rate)          (((rate & 0x1f) - 1) << 8)
> +#define		VPU_HDMI_RD_RATE(rate)          (((rate & 0x1f) - 1) << 12)
>  #define ENCI_INFO_READ 0x271c
>  #define ENCP_INFO_READ 0x271d
>  #define ENCT_INFO_READ 0x271e
> @@ -1360,6 +1560,7 @@
>  #define VPU_RDARB_MODE_L1C2 0x2799
>  #define VPU_RDARB_MODE_L2C1 0x279d
>  #define VPU_WRARB_MODE_L2C1 0x27a2
> +#define		VPU_RDARB_SLAVE_TO_MASTER_PORT(dc, port) (port << (16 + dc))
>  
>  /* osd super scale */
>  #define OSDSR_HV_SIZEIN 0x3130
> @@ -1390,4 +1591,150 @@
>  #define OSDSR_YBIC_VCOEF0 0x3149
>  #define OSDSR_CBIC_VCOEF0 0x314a
>  
> +/* osd afbcd on gxtvbb */
> +#define OSD1_AFBCD_ENABLE 0x31a0
> +#define OSD1_AFBCD_MODE 0x31a1
> +#define OSD1_AFBCD_SIZE_IN 0x31a2
> +#define OSD1_AFBCD_HDR_PTR 0x31a3
> +#define OSD1_AFBCD_FRAME_PTR 0x31a4
> +#define OSD1_AFBCD_CHROMA_PTR 0x31a5
> +#define OSD1_AFBCD_CONV_CTRL 0x31a6
> +#define OSD1_AFBCD_STATUS 0x31a8
> +#define OSD1_AFBCD_PIXEL_HSCOPE 0x31a9
> +#define OSD1_AFBCD_PIXEL_VSCOPE 0x31aa
> +
> +/* add for gxm and 962e dv core2 */
> +#define DOLBY_CORE2A_SWAP_CTRL1	0x3434
> +#define DOLBY_CORE2A_SWAP_CTRL2	0x3435
> +
> +/* osd afbc on g12a */
> +#define VPU_MAFBC_BLOCK_ID 0x3a00
> +#define VPU_MAFBC_IRQ_RAW_STATUS 0x3a01
> +#define VPU_MAFBC_IRQ_CLEAR 0x3a02
> +#define VPU_MAFBC_IRQ_MASK 0x3a03
> +#define VPU_MAFBC_IRQ_STATUS 0x3a04
> +#define VPU_MAFBC_COMMAND 0x3a05
> +#define VPU_MAFBC_STATUS 0x3a06
> +#define VPU_MAFBC_SURFACE_CFG 0x3a07
> +#define VPU_MAFBC_HEADER_BUF_ADDR_LOW_S0 0x3a10
> +#define VPU_MAFBC_HEADER_BUF_ADDR_HIGH_S0 0x3a11
> +#define VPU_MAFBC_FORMAT_SPECIFIER_S0 0x3a12
> +#define VPU_MAFBC_BUFFER_WIDTH_S0 0x3a13
> +#define VPU_MAFBC_BUFFER_HEIGHT_S0 0x3a14
> +#define VPU_MAFBC_BOUNDING_BOX_X_START_S0 0x3a15
> +#define VPU_MAFBC_BOUNDING_BOX_X_END_S0 0x3a16
> +#define VPU_MAFBC_BOUNDING_BOX_Y_START_S0 0x3a17
> +#define VPU_MAFBC_BOUNDING_BOX_Y_END_S0 0x3a18
> +#define VPU_MAFBC_OUTPUT_BUF_ADDR_LOW_S0 0x3a19
> +#define VPU_MAFBC_OUTPUT_BUF_ADDR_HIGH_S0 0x3a1a
> +#define VPU_MAFBC_OUTPUT_BUF_STRIDE_S0 0x3a1b
> +#define VPU_MAFBC_PREFETCH_CFG_S0 0x3a1c
> +
> +#define VPU_MAFBC_HEADER_BUF_ADDR_LOW_S1 0x3a30
> +#define VPU_MAFBC_HEADER_BUF_ADDR_HIGH_S1 0x3a31
> +#define VPU_MAFBC_FORMAT_SPECIFIER_S1 0x3a32
> +#define VPU_MAFBC_BUFFER_WIDTH_S1 0x3a33
> +#define VPU_MAFBC_BUFFER_HEIGHT_S1 0x3a34
> +#define VPU_MAFBC_BOUNDING_BOX_X_START_S1 0x3a35
> +#define VPU_MAFBC_BOUNDING_BOX_X_END_S1 0x3a36
> +#define VPU_MAFBC_BOUNDING_BOX_Y_START_S1 0x3a37
> +#define VPU_MAFBC_BOUNDING_BOX_Y_END_S1 0x3a38
> +#define VPU_MAFBC_OUTPUT_BUF_ADDR_LOW_S1 0x3a39
> +#define VPU_MAFBC_OUTPUT_BUF_ADDR_HIGH_S1 0x3a3a
> +#define VPU_MAFBC_OUTPUT_BUF_STRIDE_S1 0x3a3b
> +#define VPU_MAFBC_PREFETCH_CFG_S1 0x3a3c
> +
> +#define VPU_MAFBC_HEADER_BUF_ADDR_LOW_S2 0x3a50
> +#define VPU_MAFBC_HEADER_BUF_ADDR_HIGH_S2 0x3a51
> +#define VPU_MAFBC_FORMAT_SPECIFIER_S2 0x3a52
> +#define VPU_MAFBC_BUFFER_WIDTH_S2 0x3a53
> +#define VPU_MAFBC_BUFFER_HEIGHT_S2 0x3a54
> +#define VPU_MAFBC_BOUNDING_BOX_X_START_S2 0x3a55
> +#define VPU_MAFBC_BOUNDING_BOX_X_END_S2 0x3a56
> +#define VPU_MAFBC_BOUNDING_BOX_Y_START_S2 0x3a57
> +#define VPU_MAFBC_BOUNDING_BOX_Y_END_S2 0x3a58
> +#define VPU_MAFBC_OUTPUT_BUF_ADDR_LOW_S2 0x3a59
> +#define VPU_MAFBC_OUTPUT_BUF_ADDR_HIGH_S2 0x3a5a
> +#define VPU_MAFBC_OUTPUT_BUF_STRIDE_S2 0x3a5b
> +#define VPU_MAFBC_PREFETCH_CFG_S2 0x3a5c
> +
> +#define VPU_MAFBC_HEADER_BUF_ADDR_LOW_S3 0x3a70
> +#define VPU_MAFBC_HEADER_BUF_ADDR_HIGH_S3 0x3a71
> +#define VPU_MAFBC_FORMAT_SPECIFIER_S3 0x3a72
> +#define VPU_MAFBC_BUFFER_WIDTH_S3 0x3a73
> +#define VPU_MAFBC_BUFFER_HEIGHT_S3 0x3a74
> +#define VPU_MAFBC_BOUNDING_BOX_X_START_S3 0x3a75
> +#define VPU_MAFBC_BOUNDING_BOX_X_END_S3 0x3a76
> +#define VPU_MAFBC_BOUNDING_BOX_Y_START_S3 0x3a77
> +#define VPU_MAFBC_BOUNDING_BOX_Y_END_S3 0x3a78
> +#define VPU_MAFBC_OUTPUT_BUF_ADDR_LOW_S3 0x3a79
> +#define VPU_MAFBC_OUTPUT_BUF_ADDR_HIGH_S3 0x3a7a
> +#define VPU_MAFBC_OUTPUT_BUF_STRIDE_S3 0x3a7b
> +#define VPU_MAFBC_PREFETCH_CFG_S3 0x3a7c
> +
> +#define DOLBY_PATH_CTRL 0x1a0c
> +#define		DOLBY_BYPASS_EN(val)            (val & 0xf)
> +#define OSD_PATH_MISC_CTRL 0x1a0e
> +#define MALI_AFBCD_TOP_CTRL 0x1a0f
> +
> +#define VIU_OSD_BLEND_CTRL 0x39b0
> +#define		VIU_OSD_BLEND_REORDER(dest, src)      ((src) << (dest * 4))
> +#define		VIU_OSD_BLEND_DIN_EN(bits)            ((bits & 0xf) << 20)
> +#define		VIU_OSD_BLEND1_DIN3_BYPASS_TO_DOUT1   BIT(24)
> +#define		VIU_OSD_BLEND1_DOUT_BYPASS_TO_BLEND2  BIT(25)
> +#define		VIU_OSD_BLEND_DIN0_BYPASS_TO_DOUT0    BIT(26)
> +#define		VIU_OSD_BLEND_BLEN2_PREMULT_EN(input) ((input & 0x3) << 27)
> +#define		VIU_OSD_BLEND_HOLD_LINES(lines)       ((u32)(lines & 0x7) << 29)
> +#define VIU_OSD_BLEND_CTRL1 0x39c0
> +#define VIU_OSD_BLEND_DIN0_SCOPE_H 0x39b1
> +#define VIU_OSD_BLEND_DIN0_SCOPE_V 0x39b2
> +#define VIU_OSD_BLEND_DIN1_SCOPE_H 0x39b3
> +#define VIU_OSD_BLEND_DIN1_SCOPE_V 0x39b4
> +#define VIU_OSD_BLEND_DIN2_SCOPE_H 0x39b5
> +#define VIU_OSD_BLEND_DIN2_SCOPE_V 0x39b6
> +#define VIU_OSD_BLEND_DIN3_SCOPE_H 0x39b7
> +#define VIU_OSD_BLEND_DIN3_SCOPE_V 0x39b8
> +#define VIU_OSD_BLEND_DUMMY_DATA0 0x39b9
> +#define VIU_OSD_BLEND_DUMMY_ALPHA 0x39ba
> +#define VIU_OSD_BLEND_BLEND0_SIZE 0x39bb
> +#define VIU_OSD_BLEND_BLEND1_SIZE 0x39bc
> +#define VIU_OSD_BLEND_RO_CURRENT_XY 0x39bf
> +
> +#define VPP_OUT_H_V_SIZE 0x1da5
> +
> +#define VPP_VD2_HDR_IN_SIZE 0x1df0
> +#define VPP_OSD1_IN_SIZE 0x1df1
> +#define VPP_GCLK_CTRL2 0x1df2
> +#define VD2_PPS_DUMMY_DATA 0x1df4
> +#define VPP_OSD1_BLD_H_SCOPE 0x1df5
> +#define VPP_OSD1_BLD_V_SCOPE 0x1df6
> +#define VPP_OSD2_BLD_H_SCOPE 0x1df7
> +#define VPP_OSD2_BLD_V_SCOPE 0x1df8
> +#define VPP_WRBAK_CTRL 0x1df9
> +#define VPP_SLEEP_CTRL 0x1dfa
> +#define VD1_BLEND_SRC_CTRL 0x1dfb
> +#define VD2_BLEND_SRC_CTRL 0x1dfc
> +#define		VD_BLEND_PREBLD_SRC_VD1         (1 << 0)
> +#define		VD_BLEND_PREBLD_SRC_VD2         (2 << 0)
> +#define		VD_BLEND_PREBLD_SRC_OSD1        (3 << 0)
> +#define		VD_BLEND_PREBLD_SRC_OSD2        (4 << 0)
> +#define		VD_BLEND_PREBLD_PREMULT_EN      BIT(4)
> +#define		VD_BLEND_POSTBLD_SRC_VD1        (1 << 8)
> +#define		VD_BLEND_POSTBLD_SRC_VD2        (2 << 8)
> +#define		VD_BLEND_POSTBLD_SRC_OSD1       (3 << 8)
> +#define		VD_BLEND_POSTBLD_SRC_OSD2       (4 << 8)
> +#define		VD_BLEND_POSTBLD_PREMULT_EN     BIT(16)
> +#define OSD1_BLEND_SRC_CTRL 0x1dfd
> +#define OSD2_BLEND_SRC_CTRL 0x1dfe
> +#define		OSD_BLEND_POSTBLD_SRC_VD1       (1 << 8)
> +#define		OSD_BLEND_POSTBLD_SRC_VD2       (2 << 8)
> +#define		OSD_BLEND_POSTBLD_SRC_OSD1      (3 << 8)
> +#define		OSD_BLEND_POSTBLD_SRC_OSD2      (4 << 8)
> +#define		OSD_BLEND_PATH_SEL_ENABLE       BIT(20)
> +
> +#define VPP_POST_BLEND_BLEND_DUMMY_DATA 0x3968
> +#define VPP_POST_BLEND_DUMMY_ALPHA 0x3969
> +#define VPP_RDARB_MODE 0x3978
> +#define VPP_RDARB_REQEN_SLV 0x3979
> +
>  #endif /* __MESON_REGISTERS_H */
> diff --git a/drivers/video/meson/meson_vclk.c b/drivers/video/meson/meson_vclk.c
> index 693e0ebe39..0f628e920b 100644
> --- a/drivers/video/meson/meson_vclk.c
> +++ b/drivers/video/meson/meson_vclk.c
> @@ -68,14 +68,20 @@ enum {
>  #define CTS_HDMI_SYS_EN		BIT(8)
>  
>  #define HHI_HDMI_PLL_CNTL	0x320 /* 0xc8 offset in data sheet */
> +#define HHI_HDMI_PLL_CNTL_EN	BIT(30)
>  #define HHI_HDMI_PLL_CNTL2	0x324 /* 0xc9 offset in data sheet */
>  #define HHI_HDMI_PLL_CNTL3	0x328 /* 0xca offset in data sheet */
>  #define HHI_HDMI_PLL_CNTL4	0x32C /* 0xcb offset in data sheet */
>  #define HHI_HDMI_PLL_CNTL5	0x330 /* 0xcc offset in data sheet */
>  #define HHI_HDMI_PLL_CNTL6	0x334 /* 0xcd offset in data sheet */
> +#define HHI_HDMI_PLL_CNTL7	0x338 /* 0xce offset in data sheet */
>  
>  #define HDMI_PLL_RESET		BIT(28)
> +#define HDMI_PLL_RESET_G12A	BIT(29)
>  #define HDMI_PLL_LOCK		BIT(31)
> +#define HDMI_PLL_LOCK_G12A	(3 << 30)
> +
> +#define FREQ_1000_1001(_freq)	DIV_ROUND_CLOSEST(_freq * 1000, 1001)
>  
>  /* VID PLL Dividers */
>  enum {
> @@ -206,8 +212,6 @@ static void meson_venci_cvbs_clock_config(struct meson_vpu_priv *priv)
>  {
>  	unsigned int val;
>  
> -	debug("%s:%d\n", __func__, __LINE__);
> -
>  	/* Setup PLL to output 1.485GHz */
>  	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB)) {
>  		hhi_write(HHI_HDMI_PLL_CNTL, 0x5800023d);
> @@ -217,6 +221,10 @@ static void meson_venci_cvbs_clock_config(struct meson_vpu_priv *priv)
>  		hhi_write(HHI_HDMI_PLL_CNTL5, 0x71486980);
>  		hhi_write(HHI_HDMI_PLL_CNTL6, 0x00000e55);
>  		hhi_write(HHI_HDMI_PLL_CNTL, 0x4800023d);
> +
> +		/* Poll for lock bit */
> +		readl_poll_timeout(priv->hhi_base + HHI_HDMI_PLL_CNTL, val,
> +				   (val & HDMI_PLL_LOCK), 10);
>  	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
>  		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL)) {
>  		hhi_write(HHI_HDMI_PLL_CNTL, 0x4000027b);
> @@ -231,13 +239,26 @@ static void meson_venci_cvbs_clock_config(struct meson_vpu_priv *priv)
>  				HDMI_PLL_RESET, HDMI_PLL_RESET);
>  		hhi_update_bits(HHI_HDMI_PLL_CNTL,
>  				HDMI_PLL_RESET, 0);
> -	}
>  
> -	debug("%s:%d\n", __func__, __LINE__);
> +		/* Poll for lock bit */
> +		readl_poll_timeout(priv->hhi_base + HHI_HDMI_PLL_CNTL, val,
> +				   (val & HDMI_PLL_LOCK), 10);
> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
> +		hhi_write(HHI_HDMI_PLL_CNTL, 0x1a0504f7);
> +		hhi_write(HHI_HDMI_PLL_CNTL2, 0x00010000);
> +		hhi_write(HHI_HDMI_PLL_CNTL3, 0x00000000);
> +		hhi_write(HHI_HDMI_PLL_CNTL4, 0x6a28dc00);
> +		hhi_write(HHI_HDMI_PLL_CNTL5, 0x65771290);
> +		hhi_write(HHI_HDMI_PLL_CNTL6, 0x39272000);
> +		hhi_write(HHI_HDMI_PLL_CNTL7, 0x56540000);
> +		hhi_write(HHI_HDMI_PLL_CNTL, 0x3a0504f7);
> +		hhi_write(HHI_HDMI_PLL_CNTL, 0x1a0504f7);
>  
> -	/* Poll for lock bit */
> -	readl_poll_timeout(priv->hhi_base + HHI_HDMI_PLL_CNTL, val,
> -			   (val & HDMI_PLL_LOCK), 10);
> +		/* Poll for lock bit */
> +		readl_poll_timeout(priv->hhi_base + HHI_HDMI_PLL_CNTL, val,
> +			((val & HDMI_PLL_LOCK_G12A) == HDMI_PLL_LOCK_G12A),
> +			10);
> +	}
>  
>  	/* Disable VCLK2 */
>  	hhi_update_bits(HHI_VIID_CLK_CNTL, VCLK2_EN, 0);
> @@ -250,8 +271,13 @@ static void meson_venci_cvbs_clock_config(struct meson_vpu_priv *priv)
>  			VCLK2_DIV_MASK, (55 - 1));
>  
>  	/* select vid_pll for vclk2 */
> -	hhi_update_bits(HHI_VIID_CLK_CNTL,
> -			VCLK2_SEL_MASK, (4 << VCLK2_SEL_SHIFT));
> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
> +		hhi_update_bits(HHI_VIID_CLK_CNTL,
> +				VCLK2_SEL_MASK, (0 << VCLK2_SEL_SHIFT));
> +	else
> +		hhi_update_bits(HHI_VIID_CLK_CNTL,
> +				VCLK2_SEL_MASK, (4 << VCLK2_SEL_SHIFT));
> +
>  	/* enable vclk2 gate */
>  	hhi_update_bits(HHI_VIID_CLK_CNTL, VCLK2_EN, VCLK2_EN);
>  
> @@ -282,14 +308,12 @@ static void meson_venci_cvbs_clock_config(struct meson_vpu_priv *priv)
>  	/* enable vdac_clk */
>  	hhi_update_bits(HHI_VID_CLK_CNTL2,
>  			CTS_VDAC_EN, CTS_VDAC_EN);
> -
> -	debug("%s:%d\n", __func__, __LINE__);
>  }
>  
>  enum {
>  /* PLL	O1 O2 O3 VP DV     EN TX */
>  /* 4320 /4 /4 /1 /5 /1  => /2 /2 */
> -	MESON_VCLK_HDMI_ENCI_54000 = 1,
> +	MESON_VCLK_HDMI_ENCI_54000 = 0,
>  /* 4320 /4 /4 /1 /5 /1  => /1 /2 */
>  	MESON_VCLK_HDMI_DDR_54000,
>  /* 2970 /4 /1 /1 /5 /1  => /1 /2 */
> @@ -305,6 +329,7 @@ enum {
>  };
>  
>  struct meson_vclk_params {
> +	unsigned int pixel_freq;
>  	unsigned int pll_base_freq;
>  	unsigned int pll_od1;
>  	unsigned int pll_od2;
> @@ -313,6 +338,7 @@ struct meson_vclk_params {
>  	unsigned int vclk_div;
>  } params[] = {
>  	[MESON_VCLK_HDMI_ENCI_54000] = {
> +		.pixel_freq = 54000,
>  		.pll_base_freq = 4320000,
>  		.pll_od1 = 4,
>  		.pll_od2 = 4,
> @@ -321,6 +347,7 @@ struct meson_vclk_params {
>  		.vclk_div = 1,
>  	},
>  	[MESON_VCLK_HDMI_DDR_54000] = {
> +		.pixel_freq = 54000,
>  		.pll_base_freq = 4320000,
>  		.pll_od1 = 4,
>  		.pll_od2 = 4,
> @@ -329,6 +356,7 @@ struct meson_vclk_params {
>  		.vclk_div = 1,
>  	},
>  	[MESON_VCLK_HDMI_DDR_148500] = {
> +		.pixel_freq = 148500,
>  		.pll_base_freq = 2970000,
>  		.pll_od1 = 4,
>  		.pll_od2 = 1,
> @@ -337,6 +365,7 @@ struct meson_vclk_params {
>  		.vclk_div = 1,
>  	},
>  	[MESON_VCLK_HDMI_74250] = {
> +		.pixel_freq = 74250,
>  		.pll_base_freq = 2970000,
>  		.pll_od1 = 2,
>  		.pll_od2 = 2,
> @@ -345,6 +374,7 @@ struct meson_vclk_params {
>  		.vclk_div = 1,
>  	},
>  	[MESON_VCLK_HDMI_148500] = {
> +		.pixel_freq = 148500,
>  		.pll_base_freq = 2970000,
>  		.pll_od1 = 1,
>  		.pll_od2 = 2,
> @@ -353,14 +383,16 @@ struct meson_vclk_params {
>  		.vclk_div = 1,
>  	},
>  	[MESON_VCLK_HDMI_297000] = {
> -		.pll_base_freq = 2970000,
> -		.pll_od1 = 1,
> +		.pixel_freq = 297000,
> +		.pll_base_freq = 5940000,
> +		.pll_od1 = 2,
>  		.pll_od2 = 1,
>  		.pll_od3 = 1,
>  		.vid_pll_div = VID_PLL_DIV_5,
>  		.vclk_div = 2,
>  	},
>  	[MESON_VCLK_HDMI_594000] = {
> +		.pixel_freq = 594000,
>  		.pll_base_freq = 5940000,
>  		.pll_od1 = 1,
>  		.pll_od2 = 1,
> @@ -368,6 +400,7 @@ struct meson_vclk_params {
>  		.vid_pll_div = VID_PLL_DIV_5,
>  		.vclk_div = 1,
>  	},
> +	{ /* sentinel */ },
>  };
>  
>  static inline unsigned int pll_od_to_reg(unsigned int od)
> @@ -431,6 +464,50 @@ void meson_hdmi_pll_set_params(struct meson_vpu_priv *priv, unsigned int m,
>  		/* Poll for lock bit */
>  		readl_poll_timeout(priv->hhi_base + HHI_HDMI_PLL_CNTL, val,
>  				   (val & HDMI_PLL_LOCK), 10);
> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
> +		hhi_write(HHI_HDMI_PLL_CNTL, 0x0b3a0400 | m);
> +
> +		/* Enable and reset */
> +		hhi_update_bits(HHI_HDMI_PLL_CNTL, 0x3 << 28, 0x3 << 28);
> +
> +		hhi_write(HHI_HDMI_PLL_CNTL2, frac);
> +		hhi_write(HHI_HDMI_PLL_CNTL3, 0x00000000);
> +
> +		/* G12A HDMI PLL Needs specific parameters for 5.4GHz */
> +		if (m >= 0xf7) {
> +			if (frac < 0x10000) {
> +				hhi_write(HHI_HDMI_PLL_CNTL4, 0x6a685c00);
> +				hhi_write(HHI_HDMI_PLL_CNTL5, 0x11551293);
> +			} else {
> +				hhi_write(HHI_HDMI_PLL_CNTL4, 0xea68dc00);
> +				hhi_write(HHI_HDMI_PLL_CNTL5, 0x65771290);
> +			}
> +			hhi_write(HHI_HDMI_PLL_CNTL6, 0x39272000);
> +			hhi_write(HHI_HDMI_PLL_CNTL7, 0x55540000);
> +		} else {
> +			hhi_write(HHI_HDMI_PLL_CNTL4, 0x0a691c00);
> +			hhi_write(HHI_HDMI_PLL_CNTL5, 0x33771290);
> +			hhi_write(HHI_HDMI_PLL_CNTL6, 0x39270000);
> +			hhi_write(HHI_HDMI_PLL_CNTL7, 0x50540000);
> +		}
> +
> +		do {
> +			/* Reset PLL */
> +			hhi_update_bits(HHI_HDMI_PLL_CNTL,
> +					HDMI_PLL_RESET_G12A,
> +					HDMI_PLL_RESET_G12A);
> +
> +			/* UN-Reset PLL */
> +			hhi_update_bits(HHI_HDMI_PLL_CNTL,
> +					HDMI_PLL_RESET_G12A, 0);
> +
> +			/* Poll for lock bits */
> +			if (!readl_poll_timeout(
> +					priv->hhi_base + HHI_HDMI_PLL_CNTL, val,
> +					((val & HDMI_PLL_LOCK_G12A)
> +						== HDMI_PLL_LOCK_G12A), 100))
> +				break;
> +		} while (1);
>  	}
>  
>  	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB))
> @@ -440,6 +517,9 @@ void meson_hdmi_pll_set_params(struct meson_vpu_priv *priv, unsigned int m,
>  		 meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL))
>  		hhi_update_bits(HHI_HDMI_PLL_CNTL3,
>  				3 << 21, pll_od_to_reg(od1) << 21);
> +	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
> +		hhi_update_bits(HHI_HDMI_PLL_CNTL,
> +				3 << 16, pll_od_to_reg(od1) << 16);
>  
>  	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB))
>  		hhi_update_bits(HHI_HDMI_PLL_CNTL2,
> @@ -448,6 +528,9 @@ void meson_hdmi_pll_set_params(struct meson_vpu_priv *priv, unsigned int m,
>  		 meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL))
>  		hhi_update_bits(HHI_HDMI_PLL_CNTL3,
>  				3 << 23, pll_od_to_reg(od2) << 23);
> +	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
> +		hhi_update_bits(HHI_HDMI_PLL_CNTL,
> +				3 << 18, pll_od_to_reg(od2) << 18);
>  
>  	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB))
>  		hhi_update_bits(HHI_HDMI_PLL_CNTL2,
> @@ -456,6 +539,9 @@ void meson_hdmi_pll_set_params(struct meson_vpu_priv *priv, unsigned int m,
>  		 meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL))
>  		hhi_update_bits(HHI_HDMI_PLL_CNTL3,
>  				3 << 19, pll_od_to_reg(od3) << 19);
> +	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
> +		hhi_update_bits(HHI_HDMI_PLL_CNTL,
> +				3 << 20, pll_od_to_reg(od3) << 20);
>  }
>  
>  #define XTAL_FREQ 24000
> @@ -472,6 +558,7 @@ static unsigned int meson_hdmi_pll_get_m(struct meson_vpu_priv *priv,
>  
>  #define HDMI_FRAC_MAX_GXBB	4096
>  #define HDMI_FRAC_MAX_GXL	1024
> +#define HDMI_FRAC_MAX_G12A	131072
>  
>  static unsigned int meson_hdmi_pll_get_frac(struct meson_vpu_priv *priv,
>  					    unsigned int m,
> @@ -488,6 +575,9 @@ static unsigned int meson_hdmi_pll_get_frac(struct meson_vpu_priv *priv,
>  		parent_freq *= 2;
>  	}
>  
> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
> +		frac_max = HDMI_FRAC_MAX_G12A;
> +
>  	/* We can have a perfect match !*/
>  	if (pll_freq / m == parent_freq &&
>  	    pll_freq % m == 0)
> @@ -519,6 +609,12 @@ static bool meson_hdmi_pll_validate_params(struct meson_vpu_priv *priv,
>  			return false;
>  		if (frac >= HDMI_FRAC_MAX_GXL)
>  			return false;
> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
> +		/* Empiric supported min/max dividers */
> +		if (m < 106 || m > 247)
> +			return false;
> +		if (frac >= HDMI_FRAC_MAX_G12A)
> +			return false;
>  	}
>  
>  	return true;
> @@ -595,8 +691,10 @@ meson_vclk_set(struct meson_vpu_priv *priv, unsigned int pll_base_freq,
>  	       unsigned int od1, unsigned int od2, unsigned int od3,
>  	       unsigned int vid_pll_div, unsigned int vclk_div,
>  	       unsigned int hdmi_tx_div, unsigned int venc_div,
> -	       bool hdmi_use_enci)
> +	       bool hdmi_use_enci, bool vic_alternate_clock)
>  {
> +	unsigned int m = 0, frac = 0;
> +
>  	/* Set HDMI-TX sys clock */
>  	hhi_update_bits(HHI_HDMI_CLK_CNTL,
>  			CTS_HDMI_SYS_SEL_MASK, 0);
> @@ -611,34 +709,55 @@ meson_vclk_set(struct meson_vpu_priv *priv, unsigned int pll_base_freq,
>  	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB)) {
>  		switch (pll_base_freq) {
>  		case 2970000:
> -			meson_hdmi_pll_set_params(priv, 0x3d, 0xe00,
> -						  od1, od2, od3);
> +			m = 0x3d;
> +			frac = vic_alternate_clock ? 0xd02 : 0xe00;
>  			break;
>  		case 4320000:
> -			meson_hdmi_pll_set_params(priv, 0x5a, 0,
> -						  od1, od2, od3);
> +			m = vic_alternate_clock ? 0x59 : 0x5a;
> +			frac = vic_alternate_clock ? 0xe8f : 0;
>  			break;
>  		case 5940000:
> -			meson_hdmi_pll_set_params(priv, 0x7b, 0xc00,
> -						  od1, od2, od3);
> +			m = 0x7b;
> +			frac = vic_alternate_clock ? 0xa05 : 0xc00;
>  			break;
>  		}
> +
> +		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
>  	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
>  		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL)) {
>  		switch (pll_base_freq) {
>  		case 2970000:
> -			meson_hdmi_pll_set_params(priv, 0x7b, 0x300,
> -						  od1, od2, od3);
> +			m = 0x7b;
> +			frac = vic_alternate_clock ? 0x281 : 0x300;
> +			break;
> +		case 4320000:
> +			m = vic_alternate_clock ? 0xb3 : 0xb4;
> +			frac = vic_alternate_clock ? 0x347 : 0;
> +			break;
> +		case 5940000:
> +			m = 0xf7;
> +			frac = vic_alternate_clock ? 0x102 : 0x200;
> +			break;
> +		}
> +
> +		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
> +		switch (pll_base_freq) {
> +		case 2970000:
> +			m = 0x7b;
> +			frac = vic_alternate_clock ? 0x140b4 : 0x18000;
>  			break;
>  		case 4320000:
> -			meson_hdmi_pll_set_params(priv, 0xb4, 0,
> -						  od1, od2, od3);
> +			m = vic_alternate_clock ? 0xb3 : 0xb4;
> +			frac = vic_alternate_clock ? 0x1a3ee : 0;
>  			break;
>  		case 5940000:
> -			meson_hdmi_pll_set_params(priv, 0xf7, 0x200,
> -						  od1, od2, od3);
> +			m = 0xf7;
> +			frac = vic_alternate_clock ? 0x8148 : 0x10000;
>  			break;
>  		}
> +
> +		meson_hdmi_pll_set_params(priv, m, frac, od1, od2, od3);
>  	}
>  
>  	/* Setup vid_pll divider */
> @@ -803,6 +922,7 @@ static void meson_vclk_setup(struct meson_vpu_priv *priv, unsigned int target,
>  			     unsigned int vclk_freq, unsigned int venc_freq,
>  			     unsigned int dac_freq, bool hdmi_use_enci)
>  {
> +	bool vic_alternate_clock = false;
>  	unsigned int freq;
>  	unsigned int hdmi_tx_div;
>  	unsigned int venc_div;
> @@ -820,8 +940,7 @@ static void meson_vclk_setup(struct meson_vpu_priv *priv, unsigned int target,
>  		 * - encp encoder
>  		 */
>  		meson_vclk_set(priv, vclk_freq * 10, 0, 0, 0,
> -			       VID_PLL_DIV_5, 2, 1, 1, false);
> -
> +			       VID_PLL_DIV_5, 2, 1, 1, false, false);
>  		return;
>  	}
>  
> @@ -841,31 +960,35 @@ static void meson_vclk_setup(struct meson_vpu_priv *priv, unsigned int target,
>  		return;
>  	}
>  
> -	switch (vclk_freq) {
> -	case 54000:
> -		if (hdmi_use_enci)
> -			freq = MESON_VCLK_HDMI_ENCI_54000;
> -		else
> -			freq = MESON_VCLK_HDMI_DDR_54000;
> -		break;
> -	case 74250:
> -		freq = MESON_VCLK_HDMI_74250;
> -		break;
> -	case 148500:
> -		if (dac_freq != 148500)
> -			freq = MESON_VCLK_HDMI_DDR_148500;
> -		else
> -			freq = MESON_VCLK_HDMI_148500;
> -		break;
> -	case 297000:
> -		freq = MESON_VCLK_HDMI_297000;
> -		break;
> -	case 594000:
> -		freq = MESON_VCLK_HDMI_594000;
> -		break;
> -	default:
> -		printf("Fatal Error, invalid HDMI vclk freq %d\n",
> -		       vclk_freq);
> +	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
> +		if (vclk_freq == params[freq].pixel_freq ||
> +		    vclk_freq == FREQ_1000_1001(params[freq].pixel_freq)) {
> +			if (vclk_freq != params[freq].pixel_freq)
> +				vic_alternate_clock = true;
> +			else
> +				vic_alternate_clock = false;
> +
> +			if (freq == MESON_VCLK_HDMI_ENCI_54000 &&
> +			    !hdmi_use_enci)
> +				continue;
> +
> +			if (freq == MESON_VCLK_HDMI_DDR_54000 &&
> +			    hdmi_use_enci)
> +				continue;
> +
> +			if (freq == MESON_VCLK_HDMI_DDR_148500 &&
> +			    dac_freq == vclk_freq)
> +				continue;
> +
> +			if (freq == MESON_VCLK_HDMI_148500 &&
> +			    dac_freq != vclk_freq)
> +				continue;
> +			break;
> +		}
> +	}
> +
> +	if (!params[freq].pixel_freq) {
> +		pr_err("Fatal Error, invalid HDMI vclk freq %d\n", vclk_freq);
>  		return;
>  	}
>  
> @@ -873,7 +996,7 @@ static void meson_vclk_setup(struct meson_vpu_priv *priv, unsigned int target,
>  		       params[freq].pll_od1, params[freq].pll_od2,
>  		       params[freq].pll_od3, params[freq].vid_pll_div,
>  		       params[freq].vclk_div, hdmi_tx_div, venc_div,
> -		       hdmi_use_enci);
> +		       hdmi_use_enci, vic_alternate_clock);
>  }
>  
>  void meson_vpu_setup_vclk(struct udevice *dev,
> diff --git a/drivers/video/meson/meson_venc.c b/drivers/video/meson/meson_venc.c
> index d137dde8e2..5da4b3f096 100644
> --- a/drivers/video/meson/meson_venc.c
> +++ b/drivers/video/meson/meson_venc.c
> @@ -23,7 +23,9 @@ enum meson_venc_source {
>  };
>  
>  #define HHI_VDAC_CNTL0		0x2F4 /* 0xbd offset in data sheet */
> +#define HHI_VDAC_CNTL0_G12A	0x2EC /* 0xbb offset in data sheet */
>  #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
> +#define HHI_VDAC_CNTL1_G12A	0x2F0 /* 0xbc offset in data sheet */
>  
>  struct meson_cvbs_enci_mode {
>  	unsigned int mode_tag;
> @@ -175,7 +177,7 @@ union meson_hdmi_venc_mode meson_hdmi_enci_mode_480i = {
>  		.hso_end = 129,
>  		.vso_even = 3,
>  		.vso_odd = 260,
> -		.macv_max_amp = 0x810b,
> +		.macv_max_amp = 0xb,
>  		.video_prog_mode = 0xf0,
>  		.video_mode = 0x8,
>  		.sch_adjust = 0x20,
> @@ -195,7 +197,7 @@ union meson_hdmi_venc_mode meson_hdmi_enci_mode_576i = {
>  		.hso_end = 129,
>  		.vso_even = 3,
>  		.vso_odd = 260,
> -		.macv_max_amp = 8107,
> +		.macv_max_amp = 0x7,
>  		.video_prog_mode = 0xff,
>  		.video_mode = 0x13,
>  		.sch_adjust = 0x28,
> @@ -774,12 +776,13 @@ static void meson_venc_hdmi_mode_set(struct meson_vpu_priv *priv,
>  	unsigned int eof_lines;
>  	unsigned int sof_lines;
>  	unsigned int vsync_lines;
> +	u32 reg;
>  
>  	/* Use VENCI for 480i and 576i and double HDMI pixels */
>  	if (mode->flags & DISPLAY_FLAGS_DOUBLECLK) {
> -		venc_hdmi_latency = 1;
>  		hdmi_repeat = true;
>  		use_enci = true;
> +		venc_hdmi_latency = 1;
>  	}
>  
>  	meson_venc_hdmi_get_dmt_vmode(mode, &vmode_dmt);
> @@ -850,8 +853,11 @@ static void meson_venc_hdmi_mode_set(struct meson_vpu_priv *priv,
>  		unsigned int lines_f1;
>  
>  		/* CVBS Filter settings */
> -		writel(0x12, priv->io_base + _REG(ENCI_CFILT_CTRL));
> -		writel(0x12, priv->io_base + _REG(ENCI_CFILT_CTRL2));
> +		writel(ENCI_CFILT_CMPT_SEL_HIGH | 0x10,
> +		       priv->io_base + _REG(ENCI_CFILT_CTRL));
> +		writel(ENCI_CFILT_CMPT_CR_DLY(2) |
> +		       ENCI_CFILT_CMPT_CB_DLY(1),
> +		       priv->io_base + _REG(ENCI_CFILT_CTRL2));
>  
>  		/* Digital Video Select : Interlace, clk27 clk, external */
>  		writel(0, priv->io_base + _REG(VENC_DVI_SETTING));
> @@ -873,7 +879,8 @@ static void meson_venc_hdmi_mode_set(struct meson_vpu_priv *priv,
>  		       priv->io_base + _REG(ENCI_SYNC_VSO_ODDLN));
>  
>  		/* Macrovision max amplitude change */
> -		writel(vmode->enci.macv_max_amp,
> +		writel(ENCI_MACV_MAX_AMP_ENABLE_CHANGE |
> +		       ENCI_MACV_MAX_AMP_VAL(vmode->enci.macv_max_amp),
>  		       priv->io_base + _REG(ENCI_MACV_MAX_AMP));
>  
>  		/* Video mode */
> @@ -882,7 +889,8 @@ static void meson_venc_hdmi_mode_set(struct meson_vpu_priv *priv,
>  		writel(vmode->enci.video_mode,
>  		       priv->io_base + _REG(ENCI_VIDEO_MODE));
>  
> -		/* Advanced Video Mode :
> +		/*
> +		 * Advanced Video Mode :
>  		 * Demux shifting 0x2
>  		 * Blank line end at line17/22
>  		 * High bandwidth Luma Filter
> @@ -890,7 +898,10 @@ static void meson_venc_hdmi_mode_set(struct meson_vpu_priv *priv,
>  		 * Bypass luma low pass filter
>  		 * No macrovision on CSYNC
>  		 */
> -		writel(0x26, priv->io_base + _REG(ENCI_VIDEO_MODE_ADV));
> +		writel(ENCI_VIDEO_MODE_ADV_DMXMD(2) |
> +		       ENCI_VIDEO_MODE_ADV_VBICTL_LINE_17_22 |
> +		       ENCI_VIDEO_MODE_ADV_YBW_HIGH,
> +		       priv->io_base + _REG(ENCI_VIDEO_MODE_ADV));
>  
>  		writel(vmode->enci.sch_adjust,
>  		       priv->io_base + _REG(ENCI_VIDEO_SCH));
> @@ -905,8 +916,17 @@ static void meson_venc_hdmi_mode_set(struct meson_vpu_priv *priv,
>  		/* UNreset Interlaced TV Encoder */
>  		writel(0, priv->io_base + _REG(ENCI_DBG_PX_RST));
>  
> -		/* Enable Vfifo2vd, Y_Cb_Y_Cr select */
> -		writel(0x4e01, priv->io_base + _REG(ENCI_VFIFO2VD_CTL));
> +		/*
> +		 * Enable Vfifo2vd and set Y_Cb_Y_Cr:
> +		 * Corresponding value:
> +		 * Y  => 00 or 10
> +		 * Cb => 01
> +		 * Cr => 11
> +		 * Ex: 0x4e => 01001110 would mean Cb/Y/Cr/Y
> +		 */
> +		writel(ENCI_VFIFO2VD_CTL_ENABLE |
> +		       ENCI_VFIFO2VD_CTL_VD_SEL(0x4e),
> +		       priv->io_base + _REG(ENCI_VFIFO2VD_CTL));
>  
>  		/* Timings */
>  		writel(vmode->enci.pixel_start,
> @@ -928,7 +948,8 @@ static void meson_venc_hdmi_mode_set(struct meson_vpu_priv *priv,
>  		meson_vpp_setup_mux(priv, MESON_VIU_VPP_MUX_ENCI);
>  
>  		/* Interlace video enable */
> -		writel(1, priv->io_base + _REG(ENCI_VIDEO_EN));
> +		writel(ENCI_VIDEO_EN_ENABLE,
> +		       priv->io_base + _REG(ENCI_VIDEO_EN));
>  
>  		lines_f0 = mode->vback_porch.typ + mode->vactive.typ +
>  			   mode->vback_porch.typ + mode->vsync_len.typ;
> @@ -1177,7 +1198,8 @@ static void meson_venc_hdmi_mode_set(struct meson_vpu_priv *priv,
>  		writel(1, priv->io_base + _REG(ENCP_VIDEO_EN));
>  
>  		/* Set DE signal's polarity is active high */
> -		writel_bits(BIT(14), BIT(14),
> +		writel_bits(ENCP_VIDEO_MODE_DE_V_HIGH,
> +			    ENCP_VIDEO_MODE_DE_V_HIGH,
>  			    priv->io_base + _REG(ENCP_VIDEO_MODE));
>  
>  		/* Program DE timing */
> @@ -1302,21 +1324,52 @@ static void meson_venc_hdmi_mode_set(struct meson_vpu_priv *priv,
>  		meson_vpp_setup_mux(priv, MESON_VIU_VPP_MUX_ENCP);
>  	}
>  
> -	writel((use_enci ? 1 : 2) |
> -		       (mode->flags & DISPLAY_FLAGS_HSYNC_HIGH ? 1 << 2 : 0) |
> -		       (mode->flags & DISPLAY_FLAGS_VSYNC_HIGH ? 1 << 3 : 0) |
> -		       4 << 5 |
> -		       (venc_repeat ? 1 << 8 : 0) |
> -		       (hdmi_repeat ? 1 << 12 : 0),
> -		       priv->io_base + _REG(VPU_HDMI_SETTING));
> +	/* Set VPU HDMI setting */
> +	/* Select ENCP or ENCI data to HDMI */
> +	if (use_enci)
> +		reg = VPU_HDMI_ENCI_DATA_TO_HDMI;
> +	else
> +		reg = VPU_HDMI_ENCP_DATA_TO_HDMI;
> +
> +	/* Invert polarity of HSYNC from VENC */
> +	if (mode->flags & DISPLAY_FLAGS_HSYNC_HIGH)
> +		reg |= VPU_HDMI_INV_HSYNC;
> +
> +	/* Invert polarity of VSYNC from VENC */
> +	if (mode->flags & DISPLAY_FLAGS_VSYNC_HIGH)
> +		reg |= VPU_HDMI_INV_VSYNC;
> +
> +	/* Output data format: CbYCr */
> +	reg |= VPU_HDMI_OUTPUT_CBYCR;
> +
> +	/*
> +	 * Write rate to the async FIFO between VENC and HDMI.
> +	 * One write every 2 wr_clk.
> +	 */
> +	if (venc_repeat)
> +		reg |= VPU_HDMI_WR_RATE(2);
> +
> +	/*
> +	 * Read rate to the async FIFO between VENC and HDMI.
> +	 * One read every 2 wr_clk.
> +	 */
> +	if (hdmi_repeat)
> +		reg |= VPU_HDMI_RD_RATE(2);
> +
> +	writel(reg, priv->io_base + _REG(VPU_HDMI_SETTING));
>  }
>  
>  static void meson_venci_cvbs_mode_set(struct meson_vpu_priv *priv,
>  				      struct meson_cvbs_enci_mode *mode)
>  {
> +	u32 reg;
> +
>  	/* CVBS Filter settings */
> -	writel(0x12, priv->io_base + _REG(ENCI_CFILT_CTRL));
> -	writel(0x12, priv->io_base + _REG(ENCI_CFILT_CTRL2));
> +	writel(ENCI_CFILT_CMPT_SEL_HIGH | 0x10,
> +	       priv->io_base + _REG(ENCI_CFILT_CTRL));
> +	writel(ENCI_CFILT_CMPT_CR_DLY(2) |
> +	       ENCI_CFILT_CMPT_CB_DLY(1),
> +	       priv->io_base + _REG(ENCI_CFILT_CTRL2));
>  
>  	/* Digital Video Select : Interlace, clk27 clk, external */
>  	writel(0, priv->io_base + _REG(VENC_DVI_SETTING));
> @@ -1338,7 +1391,8 @@ static void meson_venci_cvbs_mode_set(struct meson_vpu_priv *priv,
>  	       priv->io_base + _REG(ENCI_SYNC_VSO_ODDLN));
>  
>  	/* Macrovision max amplitude change */
> -	writel(0x8100 + mode->macv_max_amp,
> +	writel(ENCI_MACV_MAX_AMP_ENABLE_CHANGE |
> +	       ENCI_MACV_MAX_AMP_VAL(mode->macv_max_amp),
>  	       priv->io_base + _REG(ENCI_MACV_MAX_AMP));
>  
>  	/* Video mode */
> @@ -1347,7 +1401,8 @@ static void meson_venci_cvbs_mode_set(struct meson_vpu_priv *priv,
>  	writel(mode->video_mode,
>  	       priv->io_base + _REG(ENCI_VIDEO_MODE));
>  
> -	/* Advanced Video Mode :
> +	/*
> +	 * Advanced Video Mode :
>  	 * Demux shifting 0x2
>  	 * Blank line end at line17/22
>  	 * High bandwidth Luma Filter
> @@ -1355,7 +1410,10 @@ static void meson_venci_cvbs_mode_set(struct meson_vpu_priv *priv,
>  	 * Bypass luma low pass filter
>  	 * No macrovision on CSYNC
>  	 */
> -	writel(0x26, priv->io_base + _REG(ENCI_VIDEO_MODE_ADV));
> +	writel(ENCI_VIDEO_MODE_ADV_DMXMD(2) |
> +	       ENCI_VIDEO_MODE_ADV_VBICTL_LINE_17_22 |
> +	       ENCI_VIDEO_MODE_ADV_YBW_HIGH,
> +	       priv->io_base + _REG(ENCI_VIDEO_MODE_ADV));
>  
>  	writel(mode->sch_adjust, priv->io_base + _REG(ENCI_VIDEO_SCH));
>  
> @@ -1387,16 +1445,50 @@ static void meson_venci_cvbs_mode_set(struct meson_vpu_priv *priv,
>  	/* UNreset Interlaced TV Encoder */
>  	writel(0, priv->io_base + _REG(ENCI_DBG_PX_RST));
>  
> -	/* Enable Vfifo2vd, Y_Cb_Y_Cr select */
> -	writel(0x4e01, priv->io_base + _REG(ENCI_VFIFO2VD_CTL));
> +	/*
> +	 * Enable Vfifo2vd and set Y_Cb_Y_Cr:
> +	 * Corresponding value:
> +	 * Y  => 00 or 10
> +	 * Cb => 01
> +	 * Cr => 11
> +	 * Ex: 0x4e => 01001110 would mean Cb/Y/Cr/Y
> +	 */
> +	writel(ENCI_VFIFO2VD_CTL_ENABLE |
> +	       ENCI_VFIFO2VD_CTL_VD_SEL(0x4e),
> +	       priv->io_base + _REG(ENCI_VFIFO2VD_CTL));
>  
>  	/* Power UP Dacs */
>  	writel(0, priv->io_base + _REG(VENC_VDAC_SETTING));
>  
>  	/* Video Upsampling */
> -	writel(0x0061, priv->io_base + _REG(VENC_UPSAMPLE_CTRL0));
> -	writel(0x4061, priv->io_base + _REG(VENC_UPSAMPLE_CTRL1));
> -	writel(0x5061, priv->io_base + _REG(VENC_UPSAMPLE_CTRL2));
> +	/*
> +	 * CTRL0, CTRL1 and CTRL2:
> +	 * Filter0: input data sample every 2 cloks
> +	 * Filter1: filtering and upsample enable
> +	 */
> +	reg = VENC_UPSAMPLE_CTRL_F0_2_CLK_RATIO | VENC_UPSAMPLE_CTRL_F1_EN |
> +		VENC_UPSAMPLE_CTRL_F1_UPSAMPLE_EN;
> +
> +	/*
> +	 * Upsample CTRL0:
> +	 * Interlace High Bandwidth Luma
> +	 */
> +	writel(VENC_UPSAMPLE_CTRL_INTERLACE_HIGH_LUMA | reg,
> +	       priv->io_base + _REG(VENC_UPSAMPLE_CTRL0));
> +
> +	/*
> +	 * Upsample CTRL1:
> +	 * Interlace Pb
> +	 */
> +	writel(VENC_UPSAMPLE_CTRL_INTERLACE_PB | reg,
> +	       priv->io_base + _REG(VENC_UPSAMPLE_CTRL1));
> +
> +	/*
> +	 * Upsample CTRL2:
> +	 * Interlace R
> +	 */
> +	writel(VENC_UPSAMPLE_CTRL_INTERLACE_PR | reg,
> +	       priv->io_base + _REG(VENC_UPSAMPLE_CTRL2));
>  
>  	/* Select Interlace Y DACs */
>  	writel(0, priv->io_base + _REG(VENC_VDAC_DACSEL0));
> @@ -1410,14 +1502,16 @@ static void meson_venci_cvbs_mode_set(struct meson_vpu_priv *priv,
>  	meson_vpp_setup_mux(priv, MESON_VIU_VPP_MUX_ENCI);
>  
>  	/* Enable ENCI FIFO */
> -	writel(0x2000, priv->io_base + _REG(VENC_VDAC_FIFO_CTRL));
> +	writel(VENC_VDAC_FIFO_EN_ENCI_ENABLE,
> +	       priv->io_base + _REG(VENC_VDAC_FIFO_CTRL));
>  
>  	/* Select ENCI DACs 0, 1, 4, and 5 */
>  	writel(0x11, priv->io_base + _REG(ENCI_DACSEL_0));
>  	writel(0x11, priv->io_base + _REG(ENCI_DACSEL_1));
>  
>  	/* Interlace video enable */
> -	writel(1, priv->io_base + _REG(ENCI_VIDEO_EN));
> +	writel(ENCI_VIDEO_EN_ENABLE,
> +	       priv->io_base + _REG(ENCI_VIDEO_EN));
>  
>  	/* Configure Video Saturation / Contrast / Brightness / Hue */
>  	writel(mode->video_saturation,
> @@ -1430,7 +1524,8 @@ static void meson_venci_cvbs_mode_set(struct meson_vpu_priv *priv,
>  	       priv->io_base + _REG(ENCI_VIDEO_HUE));
>  
>  	/* Enable DAC0 Filter */
> -	writel(0x1, priv->io_base + _REG(VENC_VDAC_DAC0_FILT_CTRL0));
> +	writel(VENC_VDAC_DAC0_FILT_CTRL0_EN,
> +	       priv->io_base + _REG(VENC_VDAC_DAC0_FILT_CTRL0));
>  	writel(0xfc48, priv->io_base + _REG(VENC_VDAC_DAC0_FILT_CTRL1));
>  
>  	/* 0 in Macrovision register 0 */
> @@ -1441,15 +1536,21 @@ static void meson_venci_cvbs_mode_set(struct meson_vpu_priv *priv,
>  	       priv->io_base + _REG(ENCI_SYNC_ADJ));
>  
>  	/* enable VDAC */
> -	writel_bits(BIT(5), 0, priv->io_base + _REG(VENC_VDAC_DACSEL0));
> +	writel_bits(VENC_VDAC_SEL_ATV_DMD, 0,
> +		    priv->io_base + _REG(VENC_VDAC_DACSEL0));
>  
>  	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXBB))
>  		hhi_write(HHI_VDAC_CNTL0, 1);
>  	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL) ||
>  		 meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM))
>  		hhi_write(HHI_VDAC_CNTL0, 0xf0001);
> +	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
> +		hhi_write(HHI_VDAC_CNTL0_G12A, 0x906001);
>  
> -	hhi_write(HHI_VDAC_CNTL1, 0);
> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
> +		hhi_write(HHI_VDAC_CNTL1_G12A, 0);
> +	else
> +		hhi_write(HHI_VDAC_CNTL1, 0);
>  }
>  
>  void meson_vpu_setup_venc(struct udevice *dev,
> diff --git a/drivers/video/meson/meson_vpu.h b/drivers/video/meson/meson_vpu.h
> index ef5f10eae3..3412dac052 100644
> --- a/drivers/video/meson/meson_vpu.h
> +++ b/drivers/video/meson/meson_vpu.h
> @@ -14,6 +14,7 @@
>  #include <video.h>
>  #include <display.h>
>  #include <linux/io.h>
> +#include <linux/bitfield.h>
>  #include "meson_registers.h"
>  
>  enum {
> diff --git a/drivers/video/meson/meson_vpu_init.c b/drivers/video/meson/meson_vpu_init.c
> index 92228b5ceb..12f8c4194a 100644
> --- a/drivers/video/meson/meson_vpu_init.c
> +++ b/drivers/video/meson/meson_vpu_init.c
> @@ -12,7 +12,9 @@
>  
>  /* HHI Registers */
>  #define HHI_VDAC_CNTL0		0x2F4 /* 0xbd offset in data sheet */
> +#define HHI_VDAC_CNTL0_G12A	0x2EC /* 0xbd offset in data sheet */
>  #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
> +#define HHI_VDAC_CNTL1_G12A	0x2F0 /* 0xbe offset in data sheet */
>  #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 offset in data sheet */
>  
>  /* OSDx_CTRL_STAT2 */
> @@ -42,7 +44,7 @@ static void meson_vpp_write_scaling_filter_coefs(struct meson_vpu_priv *priv,
>  {
>  	int i;
>  
> -	writel(is_horizontal ? BIT(8) : 0,
> +	writel(is_horizontal ? VPP_SCALE_HORIZONTAL_COEF : 0,
>  	       priv->io_base + _REG(VPP_OSD_SCALE_COEF_IDX));
>  	for (i = 0; i < 33; i++)
>  		writel(coefs[i],
> @@ -67,7 +69,7 @@ static void meson_vpp_write_vd_scaling_filter_coefs(struct meson_vpu_priv *priv,
>  {
>  	int i;
>  
> -	writel(is_horizontal ? BIT(8) : 0,
> +	writel(is_horizontal ? VPP_SCALE_HORIZONTAL_COEF : 0,
>  	       priv->io_base + _REG(VPP_SCALE_COEF_IDX));
>  	for (i = 0; i < 33; i++)
>  		writel(coefs[i],
> @@ -112,6 +114,34 @@ static int eotf_bypass_coeff[EOTF_COEFF_SIZE] = {
>  	EOTF_COEFF_RIGHTSHIFT /* right shift */
>  };
>  
> +static void meson_viu_set_g12a_osd1_matrix(struct meson_vpu_priv *priv,
> +					   int *m, bool csc_on)
> +{
> +	/* VPP WRAP OSD1 matrix */
> +	writel(((m[0] & 0xfff) << 16) | (m[1] & 0xfff),
> +	       priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_PRE_OFFSET0_1));
> +	writel(m[2] & 0xfff,
> +	       priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_PRE_OFFSET2));
> +	writel(((m[3] & 0x1fff) << 16) | (m[4] & 0x1fff),
> +	       priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_COEF00_01));
> +	writel(((m[5] & 0x1fff) << 16) | (m[6] & 0x1fff),
> +	       priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_COEF02_10));
> +	writel(((m[7] & 0x1fff) << 16) | (m[8] & 0x1fff),
> +	       priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_COEF11_12));
> +	writel(((m[9] & 0x1fff) << 16) | (m[10] & 0x1fff),
> +	       priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_COEF20_21));
> +	writel((m[11] & 0x1fff) << 16,
> +	       priv->io_base +	_REG(VPP_WRAP_OSD1_MATRIX_COEF22));
> +
> +	writel(((m[18] & 0xfff) << 16) | (m[19] & 0xfff),
> +	       priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_OFFSET0_1));
> +	writel(m[20] & 0xfff,
> +	       priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_OFFSET2));
> +
> +	writel_bits(BIT(0), csc_on ? BIT(0) : 0,
> +		    priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_EN_CTRL));
> +}
> +
>  static void meson_viu_set_osd_matrix(struct meson_vpu_priv *priv,
>  				     enum viu_matrix_sel_e m_select,
>  				     int *m, bool csc_on)
> @@ -322,20 +352,47 @@ static void meson_viu_load_matrix(struct meson_vpu_priv *priv)
>  				 true);
>  }
>  
> +static inline uint32_t meson_viu_osd_burst_length_reg(uint32_t length)
> +{
> +	u32 val = (((length & 0x80) % 24) / 12);
> +
> +	return (((val & 0x3) << 10) | (((val & 0x4) >> 2) << 31));
> +}
> +
>  void meson_vpu_init(struct udevice *dev)
>  {
>  	struct meson_vpu_priv *priv = dev_get_priv(dev);
>  	u32 reg;
>  
> -	/* vpu initialization */
> -	writel(0x210000, priv->io_base + _REG(VPU_RDARB_MODE_L1C1));
> -	writel(0x10000, priv->io_base + _REG(VPU_RDARB_MODE_L1C2));
> -	writel(0x900000, priv->io_base + _REG(VPU_RDARB_MODE_L2C1));
> -	writel(0x20000, priv->io_base + _REG(VPU_WRARB_MODE_L2C1));
> +	/*
> +	 * Slave dc0 and dc5 connected to master port 1.
> +	 * By default other slaves are connected to master port 0.
> +	 */
> +	reg = VPU_RDARB_SLAVE_TO_MASTER_PORT(0, 1) |
> +		VPU_RDARB_SLAVE_TO_MASTER_PORT(5, 1);
> +	writel(reg, priv->io_base + _REG(VPU_RDARB_MODE_L1C1));
> +
> +	/* Slave dc0 connected to master port 1 */
> +	reg = VPU_RDARB_SLAVE_TO_MASTER_PORT(0, 1);
> +	writel(reg, priv->io_base + _REG(VPU_RDARB_MODE_L1C2));
> +
> +	/* Slave dc4 and dc7 connected to master port 1 */
> +	reg = VPU_RDARB_SLAVE_TO_MASTER_PORT(4, 1) |
> +		VPU_RDARB_SLAVE_TO_MASTER_PORT(7, 1);
> +	writel(reg, priv->io_base + _REG(VPU_RDARB_MODE_L2C1));
> +
> +	/* Slave dc1 connected to master port 1 */
> +	reg = VPU_RDARB_SLAVE_TO_MASTER_PORT(1, 1);
> +	writel(reg, priv->io_base + _REG(VPU_WRARB_MODE_L2C1));
>  
>  	/* Disable CVBS VDAC */
> -	hhi_write(HHI_VDAC_CNTL0, 0);
> -	hhi_write(HHI_VDAC_CNTL1, 8);
> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
> +		hhi_write(HHI_VDAC_CNTL0_G12A, 0);
> +		hhi_write(HHI_VDAC_CNTL1_G12A, 8);
> +	} else {
> +		hhi_write(HHI_VDAC_CNTL0, 0);
> +		hhi_write(HHI_VDAC_CNTL1, 8);
> +	}
>  
>  	/* Power Down Dacs */
>  	writel(0xff, priv->io_base + _REG(VENC_VDAC_SETTING));
> @@ -344,7 +401,9 @@ void meson_vpu_init(struct udevice *dev)
>  	hhi_write(HHI_HDMI_PHY_CNTL0, 0);
>  
>  	/* Disable HDMI */
> -	writel_bits(0x3, 0, priv->io_base + _REG(VPU_HDMI_SETTING));
> +	writel_bits(VPU_HDMI_ENCI_DATA_TO_HDMI |
> +		    VPU_HDMI_ENCP_DATA_TO_HDMI, 0,
> +		    priv->io_base + _REG(VPU_HDMI_SETTING));
>  
>  	/* Disable all encoders */
>  	writel(0, priv->io_base + _REG(ENCI_VIDEO_EN));
> @@ -360,43 +419,58 @@ void meson_vpu_init(struct udevice *dev)
>  	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM)) {
>  		writel_bits(0xff << 16, 0xff << 16,
>  			    priv->io_base + _REG(VIU_MISC_CTRL1));
> -		writel(0x20000, priv->io_base + _REG(VPP_DOLBY_CTRL));
> +		writel(VPP_PPS_DUMMY_DATA_MODE,
> +		       priv->io_base + _REG(VPP_DOLBY_CTRL));
>  		writel(0x1020080,
>  		       priv->io_base + _REG(VPP_DUMMY_DATA1));
> -	}
> +	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
> +		writel(0xf, priv->io_base + _REG(DOLBY_PATH_CTRL));
>  
>  	/* Initialize vpu fifo control registers */
> -	writel(readl(priv->io_base + _REG(VPP_OFIFO_SIZE)) |
> -			0x77f, priv->io_base + _REG(VPP_OFIFO_SIZE));
> -	writel(0x08080808, priv->io_base + _REG(VPP_HOLD_LINES));
> -
> -	/* Turn off preblend */
> -	writel_bits(VPP_PREBLEND_ENABLE, 0,
> -		    priv->io_base + _REG(VPP_MISC));
> -
> -	/* Turn off POSTBLEND */
> -	writel_bits(VPP_POSTBLEND_ENABLE, 0,
> -		    priv->io_base + _REG(VPP_MISC));
> -
> -	/* Force all planes off */
> -	writel_bits(VPP_OSD1_POSTBLEND | VPP_OSD2_POSTBLEND |
> -		    VPP_VD1_POSTBLEND | VPP_VD2_POSTBLEND |
> -		    VPP_VD1_PREBLEND | VPP_VD2_PREBLEND, 0,
> -		    priv->io_base + _REG(VPP_MISC));
> -
> -	/* Setup default VD settings */
> -	writel(4096,
> -	       priv->io_base + _REG(VPP_PREBLEND_VD1_H_START_END));
> -	writel(4096,
> -	       priv->io_base + _REG(VPP_BLEND_VD2_H_START_END));
> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
> +		writel(VPP_OFIFO_SIZE_DEFAULT,
> +		       priv->io_base + _REG(VPP_OFIFO_SIZE));
> +	else
> +		writel_bits(VPP_OFIFO_SIZE_MASK, 0x77f,
> +			    priv->io_base + _REG(VPP_OFIFO_SIZE));
> +	writel(VPP_POSTBLEND_HOLD_LINES(4) | VPP_PREBLEND_HOLD_LINES(4),
> +	       priv->io_base + _REG(VPP_HOLD_LINES));
> +
> +	if (!meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
> +		/* Turn off preblend */
> +		writel_bits(VPP_PREBLEND_ENABLE, 0,
> +			    priv->io_base + _REG(VPP_MISC));
> +
> +		/* Turn off POSTBLEND */
> +		writel_bits(VPP_POSTBLEND_ENABLE, 0,
> +			    priv->io_base + _REG(VPP_MISC));
> +
> +		/* Force all planes off */
> +		writel_bits(VPP_OSD1_POSTBLEND | VPP_OSD2_POSTBLEND |
> +			    VPP_VD1_POSTBLEND | VPP_VD2_POSTBLEND |
> +			    VPP_VD1_PREBLEND | VPP_VD2_PREBLEND, 0,
> +			    priv->io_base + _REG(VPP_MISC));
> +
> +		/* Setup default VD settings */
> +		writel(4096,
> +		       priv->io_base + _REG(VPP_PREBLEND_VD1_H_START_END));
> +		writel(4096,
> +		       priv->io_base + _REG(VPP_BLEND_VD2_H_START_END));
> +	}
>  
>  	/* Disable Scalers */
>  	writel(0, priv->io_base + _REG(VPP_OSD_SC_CTRL0));
>  	writel(0, priv->io_base + _REG(VPP_OSD_VSC_CTRL0));
>  	writel(0, priv->io_base + _REG(VPP_OSD_HSC_CTRL0));
> -	writel(4 | (4 << 8) | BIT(15),
> +
> +	writel(VPP_VSC_BANK_LENGTH(4) | VPP_HSC_BANK_LENGTH(4) |
> +	       VPP_SC_VD_EN_ENABLE,
>  	       priv->io_base + _REG(VPP_SC_MISC));
>  
> +	/* Enable minus black level for vadj1 */
> +	writel(VPP_MINUS_BLACK_LVL_VADJ1_ENABLE,
> +	       priv->io_base + _REG(VPP_VADJ_CTRL));
> +
>  	/* Write in the proper filter coefficients. */
>  	meson_vpp_write_scaling_filter_coefs(priv,
>  				vpp_filter_coefs_4point_bspline, false);
> @@ -410,23 +484,31 @@ void meson_vpu_init(struct udevice *dev)
>  						true);
>  
>  	/* Disable OSDs */
> -	writel_bits(BIT(0) | BIT(21), 0,
> +	writel_bits(VIU_OSD1_OSD_BLK_ENABLE | VIU_OSD1_OSD_ENABLE, 0,
>  		    priv->io_base + _REG(VIU_OSD1_CTRL_STAT));
> -	writel_bits(BIT(0) | BIT(21), 0,
> +	writel_bits(VIU_OSD1_OSD_BLK_ENABLE | VIU_OSD1_OSD_ENABLE, 0,
>  		    priv->io_base + _REG(VIU_OSD2_CTRL_STAT));
>  
>  	/* On GXL/GXM, Use the 10bit HDR conversion matrix */
>  	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
>  	    meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL))
>  		meson_viu_load_matrix(priv);
> +	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
> +		meson_viu_set_g12a_osd1_matrix(priv, RGB709_to_YUV709l_coeff,
> +					       true);
>  
>  	/* Initialize OSD1 fifo control register */
> -	reg = BIT(0) |	/* Urgent DDR request priority */
> -	      (4 << 5) | /* hold_fifo_lines */
> -	      (3 << 10) | /* burst length 64 */
> -	      (32 << 12) | /* fifo_depth_val: 32*8=256 */
> -	      (2 << 22) | /* 4 words in 1 burst */
> -	      (2 << 24);
> +	reg = VIU_OSD_DDR_PRIORITY_URGENT |
> +		VIU_OSD_HOLD_FIFO_LINES(4) |
> +		VIU_OSD_FIFO_DEPTH_VAL(32) | /* fifo_depth_val: 32*8=256 */
> +		VIU_OSD_WORDS_PER_BURST(4) | /* 4 words in 1 burst */
> +		VIU_OSD_FIFO_LIMITS(2);      /* fifo_lim: 2*16=32 */
> +
> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
> +		reg |= meson_viu_osd_burst_length_reg(32);
> +	else
> +		reg |= meson_viu_osd_burst_length_reg(64);
> +
>  	writel(reg, priv->io_base + _REG(VIU_OSD1_FIFO_CTRL_STAT));
>  	writel(reg, priv->io_base + _REG(VIU_OSD2_FIFO_CTRL_STAT));
>  
> @@ -437,4 +519,39 @@ void meson_vpu_init(struct udevice *dev)
>  	writel_bits(0xff << OSD_REPLACE_SHIFT,
>  		    0xff << OSD_REPLACE_SHIFT,
>  		    priv->io_base + _REG(VIU_OSD2_CTRL_STAT2));
> +
> +	/* Disable VD1 AFBC */
> +	/* di_mif0_en=0 mif0_to_vpp_en=0 di_mad_en=0 and afbc vd1 set=0*/
> +	writel_bits(VIU_CTRL0_VD1_AFBC_MASK, 0,
> +		    priv->io_base + _REG(VIU_MISC_CTRL0));
> +	writel(0, priv->io_base + _REG(AFBC_ENABLE));
> +
> +	writel(0x00FF00C0,
> +	       priv->io_base + _REG(VD1_IF0_LUMA_FIFO_SIZE));
> +	writel(0x00FF00C0,
> +	       priv->io_base + _REG(VD2_IF0_LUMA_FIFO_SIZE));
> +
> +	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
> +		writel(VIU_OSD_BLEND_REORDER(0, 1) |
> +		       VIU_OSD_BLEND_REORDER(1, 0) |
> +		       VIU_OSD_BLEND_REORDER(2, 0) |
> +		       VIU_OSD_BLEND_REORDER(3, 0) |
> +		       VIU_OSD_BLEND_DIN_EN(1) |
> +		       VIU_OSD_BLEND1_DIN3_BYPASS_TO_DOUT1 |
> +		       VIU_OSD_BLEND1_DOUT_BYPASS_TO_BLEND2 |
> +		       VIU_OSD_BLEND_DIN0_BYPASS_TO_DOUT0 |
> +		       VIU_OSD_BLEND_BLEN2_PREMULT_EN(1) |
> +		       VIU_OSD_BLEND_HOLD_LINES(4),
> +		       priv->io_base + _REG(VIU_OSD_BLEND_CTRL));
> +		writel(OSD_BLEND_PATH_SEL_ENABLE,
> +		       priv->io_base + _REG(OSD1_BLEND_SRC_CTRL));
> +		writel(OSD_BLEND_PATH_SEL_ENABLE,
> +		       priv->io_base + _REG(OSD2_BLEND_SRC_CTRL));
> +		writel(0, priv->io_base + _REG(VD1_BLEND_SRC_CTRL));
> +		writel(0, priv->io_base + _REG(VD2_BLEND_SRC_CTRL));
> +		writel(0, priv->io_base + _REG(VIU_OSD_BLEND_DUMMY_DATA0));
> +		writel(0, priv->io_base + _REG(VIU_OSD_BLEND_DUMMY_ALPHA));
> +		writel_bits(DOLBY_BYPASS_EN(0xc), DOLBY_BYPASS_EN(0xc),
> +			    priv->io_base + _REG(DOLBY_PATH_CTRL));
> +	}
>  }
> 

