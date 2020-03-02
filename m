Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web12.11746.1583141641192282912
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Mar 2020 01:34:01 -0800
Received: by mail-wm1-f65.google.com with SMTP id f15so10240884wml.3
        for <u-boot-amlogic@groups.io>; Mon, 02 Mar 2020 01:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qDi8q82Cw7mO2bUskdBQqwbWDfh1G6Ky0ICF1UZBtd0=;
        b=cK0hwaob/jMRRiOR0gHirqEfEH99C+91kyLgKFQP66fNi/jK1TlElOMEtpZmBmr8Ll
         lV7CHjOekURMzgHVihaDMjWD6lGoSileKljzp4x9P41ElDFj8Lk+lJB2GXuJsMFTF88u
         G2Edwqv8g2bTj2WjuLECZxSBjVT9SNoCqJNB5NnrVhZfK6zhVy/46+1YVZ0eQWOwCoIV
         XIO+Nm17s/vo90nAzHF1/0T6gQ52ivqrhMdd9m127rW+VWpDUnzBwW7a/6G3bd40VOyi
         fGvf4mSnI8Z6rBLq1e0d4ikYdS8TyaZO2OJzi3PVi00x+VWgNCs5QyB2w/mXDfdrCE57
         AGoQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 4/6] arm64: dts: meson: sync dt and bindings from v5.6-rc2
References: <20200227112738.494579-1-jbrunet@baylibre.com>
 <20200227112738.494579-5-jbrunet@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8fcf46e5-e33e-c045-a131-efcf7ab18d31@baylibre.com>
Date: Mon, 2 Mar 2020 10:33:58 +0100
MIME-Version: 1.0
In-Reply-To: <20200227112738.494579-5-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 27/02/2020 12:27, Jerome Brunet wrote:
> Sync the device tree and dt-bindings from Linux v5.6-rc2
> 11a48a5a18c6 ("Linux 5.6-rc2")
> 
> The only exception to this is the mmc pinctrl pin bias of gxl SoC family.
> This is a fix which found its way to u-boot but not Linux yet.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm/dts/meson-axg-s400.dts               |  70 ++-
>  arch/arm/dts/meson-axg.dtsi                   | 273 ++++++++--
>  arch/arm/dts/meson-g12-common.dtsi            | 478 ++++++------------
>  arch/arm/dts/meson-g12.dtsi                   | 398 +++++++++++++++
>  arch/arm/dts/meson-g12a-sei510.dts            |  64 +++
>  arch/arm/dts/meson-g12a-u200.dts              |  54 ++
>  arch/arm/dts/meson-g12a.dtsi                  |  33 +-
>  arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts |  25 +
>  arch/arm/dts/meson-g12b-odroid-n2.dts         |   2 +-
>  arch/arm/dts/meson-g12b.dtsi                  |  26 +-
>  arch/arm/dts/meson-gx.dtsi                    |  87 +++-
>  arch/arm/dts/meson-gxbb-nanopi-k2.dts         |  26 +-
>  arch/arm/dts/meson-gxbb-odroidc2.dts          | 100 +++-
>  arch/arm/dts/meson-gxbb-p200.dts              |   9 +-
>  arch/arm/dts/meson-gxbb-p201.dts              |   2 +-
>  arch/arm/dts/meson-gxbb-p20x.dtsi             |   9 +-
>  arch/arm/dts/meson-gxbb.dtsi                  | 118 ++++-
>  arch/arm/dts/meson-gxl-s805x-libretech-ac.dts |   2 +-
>  arch/arm/dts/meson-gxl-s905x-khadas-vim.dts   |  20 +-
>  arch/arm/dts/meson-gxl-s905x-libretech-cc.dts |  26 +-
>  arch/arm/dts/meson-gxl-s905x-p212.dtsi        |  10 +-
>  arch/arm/dts/meson-gxl.dtsi                   |  76 ++-
>  arch/arm/dts/meson-gxm-khadas-vim2.dts        |  71 +--
>  arch/arm/dts/meson-gxm.dtsi                   |  39 +-
>  arch/arm/dts/meson-khadas-vim3.dtsi           |   7 +
>  arch/arm/dts/meson-sm1-khadas-vim3l.dts       |  95 ++++
>  arch/arm/dts/meson-sm1-sei610.dts             | 236 ++++++++-
>  arch/arm/dts/meson-sm1.dtsi                   | 356 +++++++++++++
>  include/dt-bindings/clock/axg-audio-clkc.h    |  10 +
>  include/dt-bindings/clock/gxbb-aoclkc.h       |   7 +
>  include/dt-bindings/clock/gxbb-clkc.h         |  21 +
>  include/dt-bindings/gpio/meson-gxbb-gpio.h    |   8 +-
>  include/dt-bindings/gpio/meson-gxl-gpio.h     |   8 +-
>  .../reset/amlogic,meson-axg-audio-arb.h       |   2 +
>  .../reset/amlogic,meson-axg-reset.h           |   3 +-
>  .../reset/amlogic,meson-g12a-audio-reset.h    |  15 +
>  .../reset/amlogic,meson-gxbb-reset.h          |  51 +-
>  37 files changed, 2214 insertions(+), 623 deletions(-)
>  create mode 100644 arch/arm/dts/meson-g12.dtsi
>  create mode 100644 arch/arm/dts/meson-sm1-khadas-vim3l.dts
> 
> diff --git a/arch/arm/dts/meson-axg-s400.dts b/arch/arm/dts/meson-axg-s400.dts
> index 18778ada7bd3..4cd2d5951822 100644
> --- a/arch/arm/dts/meson-axg-s400.dts
> +++ b/arch/arm/dts/meson-axg-s400.dts
> @@ -60,7 +60,7 @@
>  		serial1 = &uart_A;
>  	};
>  
> -	linein: audio-codec@0 {
> +	linein: audio-codec-0 {
>  		#sound-dai-cells = <0>;
>  		compatible = "everest,es7241";
>  		VDDA-supply = <&vcc_3v3>;
> @@ -70,7 +70,7 @@
>  		sound-name-prefix = "Linein";
>  	};
>  
> -	lineout: audio-codec@1 {
> +	lineout: audio-codec-1 {
>  		#sound-dai-cells = <0>;
>  		compatible = "everest,es7154";
>  		VDD-supply = <&vcc_3v3>;
> @@ -79,14 +79,14 @@
>  		sound-name-prefix = "Lineout";
>  	};
>  
> -	spdif_dit: audio-codec@2 {
> +	spdif_dit: audio-codec-2 {
>  		#sound-dai-cells = <0>;
>  		compatible = "linux,spdif-dit";
>  		status = "okay";
>  		sound-name-prefix = "DIT";
>  	};
>  
> -	dmics: audio-codec@3 {
> +	dmics: audio-codec-3 {
>  		#sound-dai-cells = <0>;
>  		compatible = "dmic-codec";
>  		num-channels = <7>;
> @@ -95,6 +95,13 @@
>  		sound-name-prefix = "MIC";
>  	};
>  
> +	spdif_dir: audio-codec-4 {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dir";

[...]

> - * are met:
> - *
> - *   * Redistributions of source code must retain the above copyright
> - *     notice, this list of conditions and the following disclaimer.
> - *   * Redistributions in binary form must reproduce the above copyright
> - *     notice, this list of conditions and the following disclaimer in
> - *     the documentation and/or other materials provided with the
> - *     distribution.
> - *   * Neither the name of Intel Corporation nor the names of its
> - *     contributors may be used to endorse or promote products derived
> - *     from this software without specific prior written permission.
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
>  #ifndef _DT_BINDINGS_AMLOGIC_MESON_GXBB_RESET_H
>  #define _DT_BINDINGS_AMLOGIC_MESON_GXBB_RESET_H
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
