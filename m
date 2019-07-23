Subject: how to encrypt fip for GXB P201 and possible bug in docs
From: krecis@gmail.com
MIME-Version: 1.0
Date: Tue, 23 Jul 2019 10:57:53 -0700
Message-ID: <28195.1563904673848199695@groups.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,
this is my first approach to both u-boot and this group, I have an S905w b=
ased board .
Here is my problem :
in the vanilla u-boot ( version 2019.07 ), there is a txt file ( u-boot-am=
logic/board/amlogic/p201/README.p201 ) containing instructions on how to bu=
ild the bootloader that you need in order to boot from an SD card starting =
from the p201_defconfig .

The problem is that I think that the original author mixed the two GXB and=
 GXL targets and wrote something about GXL inside a document intended for G=
XB targets .

According to the description the gxb_p201_v1_defconfig is the target that =
I'm looking for ( considering the S905W hardware properties ) and it's a GX=
B target that uses "aml_encrypt_gxb" and not "aml_encrypt_gxl", infact afte=
r building the suggested amlogic-openlinux-20170606 Baylibre branch I have =
a "fip/gxb" populated with all the expected files where the "fip/gxl" conte=
nt is not enough to build anything.

from this point on I'm unable to build anything since the last instruction=
s in the README.p201 are mentioning files that are simply not generated and=
 an utility like aml_encrypt_gxl which I don't think I should use for my P2=
01 GXB target .

Am I wrong ? what are the final steps to create the right u-boot.bin.sd.bi=
n by "adding together" the vanilla and Baylibre builds ?
