Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by mx.groups.io with SMTP id smtpd.web10.16382.1609270647172534405
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Dec 2020 11:37:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1609270643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:
	 content-transfer-encoding:content-transfer-encoding:in-reply-to:
	 references; bh=7I8seia8VmxUPpfelmqmjsPpygxzp8CUJ7BDAev3qAY=;
	b=ErrirTtwICbeRvfc+/gY+sIcsuSHT5FnnvOQY4uYK2WXFovRVqMLN/JZ9FvcYCKUiGGly4
	HfyYH0eMctm+CNYHdMrrwQqRpFVX/2hgay3Bfq5ejR/vFbls/Acaw09kc3VlkoF3EhOgbK
	HKLGt35GpZJxAyBGScBSnSaLq8Jpp1U=
From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] usb: xhci: Use only 32-bit accesses in nvme_writeq/nvme_readq
Date: Tue, 29 Dec 2020 20:37:20 +0100
Message-Id: <77ac8cb333048b92600e8781b609251f2399790d.1609270634.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com, u-boot@lists.denx.de
Cc: Stefan Agner <stefan@agner.ch>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Zhikang Zhang <zhikang.zhang@nxp.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Matthias Brugger <mbrugger@suse.com>, Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
List-ID: <u-boot-amlogic@groups.io>

There might be hardware configurations where 64-bit data accesses
to NVMe registers are not supported properly.  This patch removes
the readq/writeq so always two 32-bit accesses are used to read/write
64-bit NVMe registers, similarly as it is done in Linux kernel.

This patch fixes operation of NVMe devices on RPi4 Broadcom
BCM2711 SoC based board, where the VL805 USB XHCI controller is
connected to the PCIe Root Complex, which is attached to the system
through the SCB bridge.

Even though the architecture is 64-bit the PCIe BAR is 32-bit and likely
the 64-bit wide register accesses initiated by the CPU are not properly
translated to a sequence of 32-bit PCIe accesses.
nvme_readq(), for example, always returns same value in upper and lower
32-bits, e.g. 0x3c033fff3c033fff which lead to NVMe devices to fail
probing.

This fix is analogous to commit 8e2ab05000ab ("usb: xhci: Use only
32-bit accesses in xhci_writeq/xhci_readq").

Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Zhikang Zhang <zhikang.zhang@nxp.com>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---

 drivers/nvme/nvme.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/nvme/nvme.h b/drivers/nvme/nvme.h
index 0e8cb221a7..aa4b3bac67 100644
--- a/drivers/nvme/nvme.h
+++ b/drivers/nvme/nvme.h
@@ -535,28 +535,20 @@ struct nvme_completion {
  */
 static inline u64 nvme_readq(__le64 volatile *regs)
 {
-#if BITS_PER_LONG =3D=3D 64
-	return readq(regs);
-#else
 	__u32 *ptr =3D (__u32 *)regs;
 	u64 val_lo =3D readl(ptr);
 	u64 val_hi =3D readl(ptr + 1);
=20
 	return val_lo + (val_hi << 32);
-#endif
 }
=20
 static inline void nvme_writeq(const u64 val, __le64 volatile *regs)
 {
-#if BITS_PER_LONG =3D=3D 64
-	writeq(val, regs);
-#else
 	__u32 *ptr =3D (__u32 *)regs;
 	u32 val_lo =3D lower_32_bits(val);
 	u32 val_hi =3D upper_32_bits(val);
 	writel(val_lo, ptr);
 	writel(val_hi, ptr + 1);
-#endif
 }
=20
 struct nvme_bar {
--=20
2.29.2

