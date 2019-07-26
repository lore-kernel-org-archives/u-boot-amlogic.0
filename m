Subject: Re: how to encrypt fip for GXB P201 and possible bug in docs
From: krecis@gmail.com
MIME-Version: 1.0
Date: Fri, 26 Jul 2019 11:03:03 -0700
References: <5f5ee7b6-ac19-a33a-3aa0-aebe1b080b0f@baylibre.com>
In-Reply-To: <5f5ee7b6-ac19-a33a-3aa0-aebe1b080b0f@baylibre.com>
Message-ID: <10527.1564164183658025956@groups.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

I'm interested in re-using already existing binaries but for now I'm more i=
nterested in closing down on how to build u-boot from sources and get it to=
 work . I'll reserve this for another topic .

I have successfully compiled the "plain" p212 target ( meaning without any=
 p281 specific step ) and I don't get the very last step inside the readme =
:

 > dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D512 s=
kip=3D1 seek=3D1
and this basically means : copy uboot but skip the first 512 bytes so you =
can leave the partition table alone

 > dd if=3Dfip/u-boot.bin.sd.bin of=3D$DEV conv=3Dfsync,notrunc bs=3D1 cou=
nt=3D444
what are we doing here ? and most importantly : why just 444 bytes ? my fi=
p/u-boot.bin.sd.bin is 803328 bytes .

Also, do you have any suggestions about how to create a complete sd image =
with kernel and rootfs ? I don't want a complete rootfs but really the bare=
 minimum .
