Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 by mx.groups.io with SMTP id smtpd.web11.16238.1696420213522577073
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Oct 2023 04:50:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1696420210; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=XxUVsJJIJc1rvpKl2Qlby4KqXmIuq9s5BvqtsFO8Aec=;
	b=BPcaLNr/VC98tA+CXGuwo6yJZdAaqa031z49psX2SoX0SH4ITRFhtzGeZwBhs1pliY15Rz
	tYdMwtvvb9DXDBT763G+H9WFHWRj320Go7v9w2aNfmRcjkNh1kDTn9sNxEFsb5So8Yy02k
	LHlDeG70o2ypVIGFTr4YESKy9HOwCWAKE4i7VKtPO/1+CXIPah/IXRHyQ+ZH7R73pcgu2e
	DtMDD/9MeRhQpnzu9GwkIQqf/gRIkQg+HuUHhBtjXuZHenNq2SntWkFz9etUev7oHHUtMK
	ERbVSguLA9Zp7PmNVKQzsaL9vKhfiVdPziQR42JmlADoDUSAVPVH//h/esYmeg==
Message-ID: <92db249a-435d-483a-aeaa-50cd3a0c1adc@lexina.in>
Date: Wed, 4 Oct 2023 14:50:05 +0300
MIME-Version: 1.0
Subject: Re: [RFT PATCH 0/2] mmc: meson-gx: improve MMC reliabilty
References: <20230915160130.352099-1-jbrunet@baylibre.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
In-Reply-To: <20230915160130.352099-1-jbrunet@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi, Jerome!

Seems works for me. Tested on axg (A113X) and gxl (S905W).

Tested-by: Viacheslav Bocharov <adeep@lexina.in>

On 15/09/2023 19.01, Jerome Brunet wrote:
> Amlogic MMC on the GX (and later) SoCs has been problematic for years,
> especially with u-boot.
> 
> Linux has been fairly stable for a few years. It is using a fixed phase
> setting with Core = 180, Tx = 0 and Rx = 0 (the latter cannot be set
> starting from the v3 MMC IPs)
> 
> Still the results were not good with those settings with u-boot, on some
> sm1 based platforms. U-boot then started using a 270 core phase for sm1
> only.  This worked for most sm1 platforms but problems persist on others.
> 
> The proposal with this patchset is to use 270 for the ID phase, 180
> otherwise.  This works well on the platforms I have tested (Libretech's
> boards and VIM3L)
> 
> It would be great if others could test this and report whether this work
> for them or not.
> 
> If the results are good, this might be ported to Linux as well (... but the
> situation is less critical there)
> 
> Jerome Brunet (2):
>    mmc: meson-gx: clean up and align on Linux settings
>    mmc: meson-gx: set 270 core phase during the identification
> 
>   drivers/mmc/meson_gx_mmc.c | 50 ++++++++++++++++++--------------------
>   drivers/mmc/meson_gx_mmc.h |  9 +++++--
>   2 files changed, 31 insertions(+), 28 deletions(-)
> 
