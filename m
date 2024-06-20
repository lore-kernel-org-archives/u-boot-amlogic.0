Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD188C27C4F
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 07:35:07 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.45852.1718884730076220990
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jun 2024 04:58:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=KMSmGF2V;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 8352187EBD;
	Thu, 20 Jun 2024 13:58:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718884728;
	bh=GBgqSxou2HpB58y/v8BpXzxKa2VPzK/PHtQVPM14yAM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KMSmGF2VR54MHvz+7QlWNOTARhU1D9FoDy9a7AehTL867AOyUzzlEGGqVVKi5dXRJ
	 6veOoF0zBcRlQqYZQhSTQWvxKMN7iFkZoqjY/p/haPfK9xa93KJpUvEdyhXlIMqtBS
	 k8PAiKjjv7PG5OeZ1ule1zD1nAeQcvHxCvw/geb4IJRxEnGQaY/11DYbkvtG812U0I
	 slLuznPzlOV0Vv55JMGswblXCPLQnUzZ3LC95CQSF9UdVOhXE2Gb4cKu9QlTOtfCcT
	 Eoy8SE8Xitdvupih8+V1Ur44gBG4zhnbHWlV1GX2D+79kmLVQgFqhiyARkAD/dvhwz
	 PmGXYmaT3v3wg==
Message-ID: <8ce68679-f518-47c1-a6f8-f13e4cfd4dcc@denx.de>
Date: Thu, 20 Jun 2024 13:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] phy: meson-gxl-usb2: remove phy_meson_gxl_usb2_set_mode
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
 <20240618-u-boot-usb-gxl-phy-set-mode-v1-3-6b41efa46e35@linaro.org>
 <54c7dcab-8925-4b20-b455-413a9bee8fda@denx.de>
 <d8e7d2cb-b402-43fa-8c3e-eaebfaf5b0fc@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d8e7d2cb-b402-43fa-8c3e-eaebfaf5b0fc@linaro.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 21 Jun 2024 07:35:07 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2313

On 6/20/24 9:39 AM, Neil Armstrong wrote:
> On 18/06/2024 16:56, Marek Vasut wrote:
>> On 6/18/24 9:55 AM, Neil Armstrong wrote:
>>
>> [...]
>>
>>> @@ -205,7 +188,7 @@ static int phy_meson_gxl_usb2_power_off(struct=20
>>> phy *phy)
>>> =C2=A0 struct phy_ops meson_gxl_usb2_phy_ops =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .power_on =3D phy_meson_gxl_usb2_power_o=
n,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .power_off =3D phy_meson_gxl_usb2_power_=
off,
>>> -=C2=A0=C2=A0=C2=A0 .set_mode =3D _phy_meson_gxl_usb2_set_mode,
>>> +=C2=A0=C2=A0=C2=A0 .set_mode =3D phy_meson_gxl_usb2_set_mode,
>>
>> Oh, I see you did rename it here, so please ignore my comment on 1/5 .=
=20
>> Maybe just mention in the 1/5 commit message that the rename is=20
>> happening in follow up patch , if you are doing V2 at all .
>=20
> Sure, let me update the commit message,

Thank you

