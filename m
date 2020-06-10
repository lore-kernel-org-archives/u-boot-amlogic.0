Subject: How to properly boot without a separate initrd
From: krecis@gmail.com
MIME-Version: 1.0
Date: Wed, 10 Jun 2020 09:07:12 -0700
Message-ID: <t1wJ.1591805232018748483.qg3Y@groups.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,
I have a kernel image which already contains an initramfs, I don't know ho=
w to properly boot that with uboot .

The bootm syntax is
bootm start <os> <initrd> <fdtaddr>

which implies that the user always has a 2 separate files for the kernel a=
nd the initrd, I have an Image file with kernel+initramfs and a dtb/fdt fil=
e : how do I boot ?
I have not found a proper way/command to achieve this under uboot .
should I set the initrd address to 0 ?
