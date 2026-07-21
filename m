Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB4DC44529
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 07:26:59 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17353.1784618813549412943
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Jul 2026 00:26:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=QS97ILF/;
 spf=pass (domain: linaro.org, ip: 209.85.128.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49553515a8bso29992075e9.1
        for <u-boot-amlogic@groups.io>; Tue, 21 Jul 2026 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784618812; x=1785223612; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tg4Iqh6ufJjBPsRpeCIxF1O34hDY5WDd38VtPOQlljw=;
        b=QS97ILF/odthA8VSCYJ4SWmvOPyl/0jufULXBhmj68frkt78M8FbqIaX94FSLXbSdy
         O/QmY2ks4LxmV0nvQhYuG4XKYk6wZruLfFOgGePG8Me5a1MGmI6eq4yo2i0YJN0yylpN
         AU7OnHHpNbikNT2J5nCk/Q/F4ksdXcKx7J3ensTi5OAem7PIuDPZGW8to7BkK6Evs2kn
         1WSo9b8XWJkETUSUsHlSsrs9hUOwfYdN87SEPTK6PFhdN7O6gUkawzyK+xiUzL4axgfY
         uaI+tCuK+71NTJCXDYzBlxTgLlq3Zv9UNXXVTAy9LZuLmnghwTPZuunJmMM0dSELFTlR
         g65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784618812; x=1785223612;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tg4Iqh6ufJjBPsRpeCIxF1O34hDY5WDd38VtPOQlljw=;
        b=J5XqGdcC15w+EGaICRZ3V55NY35w3zV4H7CPFbgVOPB/QLU7J9fqgMv0JhIQMNRZ1I
         /5wJPaBmFI5ugwc+MgXRUJv/W0j8U/ANNijUl8kvnrzH844BZf7hS9vHCpkIUBsvTwmY
         0kEiy2nldfRtwf2ojzVzhfb30SlfeTpSiNVnoQo1mA37hWyr4xzp3Pb/PtDm/MNk1ykY
         YVn1fXF67AE1st5RBCy+DB7fbk7QJ0zUCGhFqOxJuh9Zl2G/QS9SSeKBlLtkWjEmkIp7
         qi2FoneMvWt5/JnNxZcJeSSH6gD18ttOwXQtkR2YtJIVenfgiwoXjjpJTSbXBGp7DgvP
         Ah1w==
X-Forwarded-Encrypted: i=1; AHgh+Rpq5AgoRPc1wlbU8I0Qx2+aJ4kmxtba76kgq+w2l7QFPU/wbjMxuH9fbt7gtOpiZYArIZiJfIz268dMLBKtjw==@groups.io
X-Gm-Message-State: AOJu0YyL4e4L3U3whaKyAgxxUcMYAuu4cMXsokhJGwM6Jlu6QMz0Jbi3
	22z+JZOismEhmgOwWAjvKlMQkEE78ceS3stxRA7e7WKDfQyRisv4EXgfUoBXWpBKyNg=
X-Gm-Gg: AfdE7clV2cFxvxvehVR2lUrOAijM+/AsPu0XXoffNRtBpoGcZBa/RKemsea52VCZJBl
	qFYbA2vzLjPmUua+aPwvcclPszrINu6BVM6sH/zLsDZinLTYVvtVlXcMddHEw8GlTVs6pk9aANE
	Fo8abrvA5cdsc8olfYDcpSIJ9CETRc9Oekr0/KlXthMPfrli67LIleAt9udQxIJPRBGd+jKqow3
	9gqdxL+5znppex8AUCRtDJnrpOcxyYkW5lTymjWQ1qFlEHXfXTTAa3aOsGXLaRfxH+z/nM0EkZ8
	Eb4i4OAye59Ddi4xlecVI1hYjA+4z9ysRna/HZbeaZQmuptvZgahZmnGCu0jYiDe7OC/WDUBmBK
	g20GrsUgRwJ8cVjYiggcG4YaPlJ+sEcFvJl3b+NIluY/afB3bYbIlm+m+Q8XyjpxeD/Rz2i+jMr
	GmhrRTvtBm7O765d8Csj/VlX5HjlqSHvrkn9CuigQwc/gmhBCdYZz15XkzaJLMigc7XgDV
X-Received: by 2002:a05:600c:4f54:b0:495:4815:2c54 with SMTP id 5b1f17b1804b1-4954a41303amr193263685e9.34.1784618811576;
        Tue, 21 Jul 2026 00:26:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1? ([2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49564011868sm63244485e9.3.2026.07.21.00.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 00:26:51 -0700 (PDT)
Message-ID: <b0bcf3b3-83b7-4a01-9fae-5e135f2dfc66@linaro.org>
Date: Tue, 21 Jul 2026 09:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 34/36] ufs: qcom: use clk_prepare_enable_bulk()
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
 <20260720-casey-ccf-upstream-july-v1-34-8fece1b0333d@linaro.org>
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
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-34-8fece1b0333d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 21 Jul 2026 07:26:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3009

On 7/20/26 18:41, Casey Connolly wrote:
> With CCF the clocks have to be prepared before enabling. The CCF core
> will do this for us but it's much better to be explicit.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/ufs/ufs-qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
> index f5f5a6eb110c..3656c3861cb5 100644
> --- a/drivers/ufs/ufs-qcom.c
> +++ b/drivers/ufs/ufs-qcom.c
> @@ -38,9 +38,9 @@ static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
>   
>   	if (priv->is_clks_enabled)
>   		return 0;
>   
> -	err = clk_enable_bulk(&priv->clks);
> +	err = clk_prepare_enable_bulk(&priv->clks);
>   	if (err)
>   		return err;
>   
>   	priv->is_clks_enabled = true;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

