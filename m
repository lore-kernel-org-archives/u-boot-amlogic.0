Subject: Re: Unable to build n-amlogic-openlinux-20170606 branch
From: krecis@gmail.com
MIME-Version: 1.0
Date: Tue, 09 Jun 2020 13:54:51 -0700
References: <e847feed-4606-a0fb-6cc0-a274483664fe@baylibre.com>
In-Reply-To: <e847feed-4606-a0fb-6cc0-a274483664fe@baylibre.com>
Message-ID: <5046.1591736091974546962@groups.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

This is the case when the error message doesn't really describes the proble=
m  .

The problem wasn't really about not having the right executables in PATH, =
in fact I checked and everything was properly set-up; the core of the issue=
 was about trying to run a 32 bit executable ( the compiler / toolchain ) u=
nder a 64 bit environment without 32 bit support . Basically the gcc binary=
 was unable to run at all and was reported as "not in PATH" .
