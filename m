Subject: [PATCHv2 0/3] ARM: meson: Add initial support for beelink gt1
From: exkc_maillist@list.ru
MIME-Version: 1.0
Date: Wed, 22 Mar 2023 12:17:08 -0700
Message-ID: <KFid.1679512628339564284.oldC@groups.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Add initial support for beelink gt1

Signed-off-by:  Karl Chan <exxxxkc@getgoogleoff.me>

---

This patch is base on this patch from in pm os .

https://gitlab.com/postmarketOS/pmaports/-/blob/master/device/testing/u-boo=
t-beelink-gt1/0001-add-basic-support-for-beelink-gt1.patch

---

 .../dts/meson-gxm-gt1-ultimate-u-boot.dtsi    |  7 ++
 arch/arm/dts/meson-gxm-gt1-ultimate.dts       | 91 +++++++++++++++++++
 board/amlogic/q200/MAINTAINERS                |  2 +
 configs/beelink_gt1_ultimate_defconfig        | 85 +++++++++++++++++
 doc/board/amlogic/beelink-gt1.rst             | 65 +++++++++++++
 doc/board/amlogic/index.rst                   |  3 +-
 6 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate.dts
 create mode 100644 configs/beelink_gt1_ultimate_defconfig
 create mode 100644 doc/board/amlogic/beelink-gt1.rst
