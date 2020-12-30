Received: from mx2.mailbox.org (mx2.mailbox.org [80.241.60.215])
 by mx.groups.io with SMTP id smtpd.web12.4381.1609318439809826959
 for <u-boot-amlogic@groups.io>;
 Wed, 30 Dec 2020 00:54:00 -0800
Subject: Re: [PATCH] usb: xhci: Use only 32-bit accesses in nvme_writeq/nvme_readq
References: <77ac8cb333048b92600e8781b609251f2399790d.1609270634.git.stefan@agner.ch>
From: Stefan Roese <sr@denx.de>
Message-ID: <306a52cd-2a4b-54fa-7f8c-865118da19ff@denx.de>
Date: Wed, 30 Dec 2020 09:53:43 +0100
MIME-Version: 1.0
In-Reply-To: <77ac8cb333048b92600e8781b609251f2399790d.1609270634.git.stefan@agner.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Stefan Agner <stefan@agner.ch>, u-boot-amlogic@groups.io, narmstrong@baylibre.com, u-boot@lists.denx.de
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Zhikang Zhang <zhikang.zhang@nxp.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Matthias Brugger <mbrugger@suse.com>, Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Stefan,

On 29.12.20 20:37, Stefan Agner wrote:
> There might be hardware configurations where 64-bit data accesses
> to NVMe registers are not supported properly.  This patch removes
> the readq/writeq so always two 32-bit accesses are used to read/write
> 64-bit NVMe registers, similarly as it is done in Linux kernel.
>=20
> This patch fixes operation of NVMe devices on RPi4 Broadcom
> BCM2711 SoC based board, where the VL805 USB XHCI controller is
> connected to the PCIe Root Complex, which is attached to the system
> through the SCB bridge.
>=20
> Even though the architecture is 64-bit the PCIe BAR is 32-bit and likel=
y
> the 64-bit wide register accesses initiated by the CPU are not properly
> translated to a sequence of 32-bit PCIe accesses.
> nvme_readq(), for example, always returns same value in upper and lower
> 32-bits, e.g. 0x3c033fff3c033fff which lead to NVMe devices to fail
> probing.
>=20
> This fix is analogous to commit 8e2ab05000ab ("usb: xhci: Use only
> 32-bit accesses in xhci_writeq/xhci_readq").

I see. This is where you cloned the patch subject line from then. ;)

Please change the subject line and add my:

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Zhikang Zhang <zhikang.zhang@nxp.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>=20
>   drivers/nvme/nvme.h | 8 --------
>   1 file changed, 8 deletions(-)
>=20
> diff --git a/drivers/nvme/nvme.h b/drivers/nvme/nvme.h
> index 0e8cb221a7..aa4b3bac67 100644
> --- a/drivers/nvme/nvme.h
> +++ b/drivers/nvme/nvme.h
> @@ -535,28 +535,20 @@ struct nvme_completion {
>    */
>   static inline u64 nvme_readq(__le64 volatile *regs)
>   {
> -#if BITS_PER_LONG =3D=3D 64
> -	return readq(regs);
> -#else
>   	__u32 *ptr =3D (__u32 *)regs;
>   	u64 val_lo =3D readl(ptr);
>   	u64 val_hi =3D readl(ptr + 1);
>  =20
>   	return val_lo + (val_hi << 32);
> -#endif
>   }
>  =20
>   static inline void nvme_writeq(const u64 val, __le64 volatile *regs)
>   {
> -#if BITS_PER_LONG =3D=3D 64
> -	writeq(val, regs);
> -#else
>   	__u32 *ptr =3D (__u32 *)regs;
>   	u32 val_lo =3D lower_32_bits(val);
>   	u32 val_hi =3D upper_32_bits(val);
>   	writel(val_lo, ptr);
>   	writel(val_hi, ptr + 1);
> -#endif
>   }
>  =20
>   struct nvme_bar {
>=20


Viele Gr=C3=BC=C3=9Fe,
Stefan

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
