Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.88383.1696936436837980331
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Oct 2023 04:13:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2BA1D120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696936431;
	bh=4+AneF7qlMJfVCVMgjN+dGbk01RWwQ3cieUnZVl3iWY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=gRVFT/Q0mbVeW8Q4lCkl4JkOTWBp+leLjcn+XY4eLLxYXaHK8jjNAlbmsnBLsfo8P
	 kI84jWlOsoE4q21Co7CZQ+kh5uYhFF35TjeTVjQB4A/igaCe1N+hJv2cKGlFamE5MV
	 X2JedajDznNxjmQz1YwXaqddFraHYAeY/HZLTWYx5KGXubdjtjSy0LMeNEc6vvryAy
	 Ewj3X4AAQiKJkl3kkfR0eyVvI14dRi3jkGqyb+anjQgaDXG2fywQzCseAAihGTQpM5
	 xb3xb7+lBVSFLedOuCCU5UIPAvsNrscmMWzVhJ7SAo1iQ8X2lbyrxuxDzbucBUlFUa
	 IpI+UPBdZzrGg==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 0/1] hwrng: meson - add support for S4
Date: Tue, 10 Oct 2023 14:13:37 +0300
Message-ID: <20231010111344.77563-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sughosh.ganu@linaro.org, xypron.glpk@gmx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

Hello!=20

This patch adds support for Meson S4 series=20
hardware number generator using new algo.

V2:

- Sync with Linux version.

Alexey Romanov (1):
  drivers: rng: add support for Meson S4

 drivers/rng/meson-rng.c | 72 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

--=20
2.25.1

