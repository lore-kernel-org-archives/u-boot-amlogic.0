Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B12C79FB9
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 13:09:04 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13542.1789045738063325821
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2026 06:08:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=xA3fON5+;
 spf=pass (domain: linaro.org, ip: 209.85.221.47, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-485888b3c3dso7091972f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2026 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789045736; x=1789650536; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GgBRwr9klUJKxnZ6OzU3HU+Tf1smNtxwyie49GbKteE=;
        b=xA3fON5+FmErORncRwI25Badz6EyPhoIKZvGkyBYSSvnoEBDzJZqL99/JhI0AuQKuA
         k5kJ2a9+6ueJi5PZMomtznp5KfM2tEB1p2Hhvv1ztZOhuBJ6kAXjxb+DFXqOnTro1L2q
         rCg7D5jzkX/Sb4pHxbYYkED7m3Y5Sxs92hylgePz8IOoDoEMfXeeVcIEFekzcHNeFFhg
         M9aYXCTHVzO5ZDhNpRB/uupxQLhmkgwC2cW3weSluizDXlyHjLZp9/KhfUPM4QEDjAD8
         TNlL1h12cPujJjHPKW7dqQIZB7v6Vz+qn0M7E34m9r7co7DIOyVS7NA3CdeiawcJtdVa
         m3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789045736; x=1789650536;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GgBRwr9klUJKxnZ6OzU3HU+Tf1smNtxwyie49GbKteE=;
        b=g0COUQ5HY2wb8FU+ALMyGl9Nwefc/cBP9dkE06WbWmDBDkjMup7OFgP+xONvIUTImp
         06VMpD88M7JL+OCoFz5SjUAM9ynkbuM3u6CWYNoRl0pF9ELV71JuEU2mNQtl1VHyuxwe
         VVXexNQLNL8C0ndPGr1jlJZRnw/mDTZlOIhIptTAsHQ0LxXwM1Oe76s9bLY+9voS4NVr
         bwdjXGHajYVXQGY7+F3AOJ1QaMnMNLBLglwqtUOFaeR2lBzzLVCZfoB+nyHWe0BpFVNs
         x6tPqnmqQdBunw++2z6ylCJ2Y0d4C0A0+hOtAHDmIkxgohWk7uKU9NN68VMJioeW3S/W
         tDRA==
X-Forwarded-Encrypted: i=1; AKwUvBwDxOg30JXsSBaH4dQMDO0RfeigfTY0t5bboD2nytjQTyBlo+aIlNv1qwwKphSBF+Njrp2GWDzT+7/yyYIGxQ==@groups.io
X-Gm-Message-State: AFuF++kagV+bitR/eexzT+VoTz7zdREhP+G62NW2/u50V/Gy4qe+TQrN
	9LFz2MXKKtj4VD/G62WR+NFN4zC5X8mxSl0LOvzxO1HPiri6Kkpj47SwYM6B2XZjHdE=
X-Gm-Gg: AYBFou0lHAq6Qf2Ynr3sdXejyd6nu6JY00vY+VGQ+muZU9zR017+JsMoauAR876cHEA
	I/cITujERRIX60pHZOyRTx0Mzv6d8VuPt3ujHpF55l35B3u9aYxT6xv9IqVxl4eagvWf+P5tjUL
	LEHSOvdCOMcCSHnI3GkZZNKfcp9pMyz/RAUJNT33yikpB8f4NSv3WCeVhO0BgwOxZJOCKsYt64k
	kQ7dywkKfHAFnIm12MDNuGUJo11/6rXxjrTLi6LaTdc26RgNh/Hmlgu7INoKnm/OPpakZtDpcBH
	XZqPhOnupo9frO3lObkopd7vTTixc3cDbPBmxY0fc/MX1ShzEaDg5wVvrxbwcxWbAizeIQbOzaB
	+ZYw/PFxjQ2l3ZyJ2FhEfjV9eB2sIIs5v5ZhJ74KD7Sx0RFd9MZmKaKYhYpUhFVdWvLKUAdhsKe
	hHbjUY9bOfDW2axhgQ02mU5jDs9A3u8PgyGAHkvJ+RYoRJjsHdMr1D96Oit4HUYKm/wTGchv0X5
	0NXOQ/fnxjo/a5zyZkr0jtu4md/y1nErtZZn07HVHyxeZW4IGIdxA==
X-Received: by 2002:a05:6000:240e:b0:485:8f9c:2879 with SMTP id ffacd0b85a97d-4858f9c29e1mr35059633f8f.6.1789045736086;
        Thu, 10 Sep 2026 06:08:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:edd1:1b07:ea07:35f2? ([2a01:e0a:106d:1080:edd1:1b07:ea07:35f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c5bc5sm54150633f8f.24.2026.09.10.06.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 06:08:54 -0700 (PDT)
Message-ID: <72cb8528-93ec-4788-a510-9d09e276ebdc@linaro.org>
Date: Thu, 10 Sep 2026 15:08:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 36/36] ufs: qcom: fix core clk max rate setting
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sumit Garg <sumit.garg@kernel.org>, Paul Barker <paul@pbarker.dev>,
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com,
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Michal Simek <michal.simek@amd.com>, Liviu Dudau <liviu.dudau@foss.arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Mario Six <mario.six@gdsys.cc>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Andre Przywara <andre.przywara@arm.com>, Thierry Reding
 <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Yao Zi <me@ziyao.cc>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
References: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
 <20260720-casey-ccf-upstream-july-v1-36-8fece1b0333d@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-36-8fece1b0333d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 10 Sep 2026 13:09:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3087

On 7/20/26 18:41, Casey Connolly wrote:
> The unipro core clock rates are described in an OPP table, but we were
> not reading this correctly at all. Fix this and actually get the max
> rate and call clk_set_rate(). This fixes UFS init with CCF.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/ufs/ufs-qcom.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
> index 3656c3861cb5..f514b32afc6d 100644
> --- a/drivers/ufs/ufs-qcom.c
> +++ b/drivers/ufs/ufs-qcom.c
> @@ -315,9 +315,9 @@ static u32 ufs_qcom_get_core_clk_unipro_max_freq(struct ufs_hba *hba)
>   	if (pos < 0)
>   		goto fallback;
>   
>   	/* Try parsing the opps */
> -	if (!ofnode_parse_phandle_with_args(node, "required-opps",
> +	if (!ofnode_parse_phandle_with_args(node, "operating-points-v2",
>   					    NULL, 0, 0, &opp_table) &&
>   	    ofnode_device_is_compatible(opp_table.node, "operating-points-v2")) {
>   		ofnode opp_node;
>   
> @@ -547,9 +547,8 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable)
>   static int ufs_qcom_init(struct ufs_hba *hba)
>   {
>   	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
>   	struct udevice *dev = hba->dev;
> -	struct clk clk;
>   	u32 max_freq;
>   	long rate;
>   	int err;
>   
> @@ -557,28 +556,28 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>   
>   	/* Get maximum frequency for core_clk_unipro from device tree */
>   	max_freq = ufs_qcom_get_core_clk_unipro_max_freq(hba);
>   
> -	/* Get and configure core_clk_unipro */
> -	err = clk_get_by_name(dev, "core_clk_unipro", &clk);
> -	if (err) {
> -		dev_err(dev, "Failed to get core_clk_unipro: %d\n", err);
> -		return err;
> -	}
> -
> -	rate = clk_set_rate(&clk, max_freq);
> -	if (rate < 0) {
> -		dev_err(dev, "Failed to set core_clk_unipro rate to %u Hz: %ld\n",
> -			max_freq, rate);
> -	}
> -
>   	/* Get all clocks */
>   	err = clk_get_bulk(dev, &priv->clks);
>   	if (err) {
>   		dev_err(dev, "clk_get_bulk failed: %d\n", err);
>   		return err;
>   	}
>   
> +	int unipro_idx = ofnode_stringlist_search(dev_ofnode(dev), "clock-names", "core_clk_unipro");
> +	if (unipro_idx < 0) {
> +		dev_err(dev, "Failed to get core_clk_unipro: %d\n", err);
> +		return err;
> +	}
> +
> +	rate = clk_set_rate(&priv->clks.clks[unipro_idx], max_freq);
> +	if (rate < 0) {
> +		dev_err(dev, "Failed to set core_clk_unipro rate to %u Hz: %ld\n",
> +			max_freq, rate);
> +	}
> +	dev_info(dev, "Set core_clk_unipro rate to %u Hz\n", max_freq);
> +
>   	/* Enable clocks */
>   	err = ufs_qcom_enable_clks(priv);
>   	if (err) {
>   		dev_err(dev, "failed to enable clocks: %d\n", err);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

