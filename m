Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858EBC61DC2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:39 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10059.1787742275452517089
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Aug 2026 04:04:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=C8IJE3VT;
 spf=pass (domain: linaro.org, ip: 209.85.222.41, mailfrom: ilias.apalodimas@linaro.org)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-977258a75d9so458375241.3
        for <u-boot-amlogic@groups.io>; Wed, 26 Aug 2026 04:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787742274; cv=none;
        d=google.com; s=arc-20260327;
        b=fQ6zn4poB3AnZZtgVzvfq5DIXGKmfbI1bGYXNbkvTQekMzT6y58Vc6Uvvi8TiruvSg
         rmTVU4Q4ckiDfjYZVKNdNjm12YjUXa1JHP8OQLo6pCSgzLLFNaHSBktX4VRps369QbvE
         rbQ1gEy4KwePDf8fkFgqN/17pCvBKl1Xj5x3ouA/OvXg0CY2XA/R80BNn8xE+I8iDWxw
         qGJSUFmzdNYuGK7BHjK5Tc+AM7MQGR3hAzGxnwThi1wy+uu5NaMECb8pBEyp9dyjFiyw
         Wb2bEoGAPetiEbcDymIvm7/v1RnwtSQITlkASK8rDZYwgRRzezZ+lVra/0vE11j1Y/Gw
         aWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kACzQV5Og47cEOPCxUyhbTWJIyjkgTj7MOSraXCLawY=;
        fh=TT4XMaw95JO2DVHLX3HXM2uYoDIcbtrFbrK8Txo6IR0=;
        b=iUGbXYpICU6FOqMWJWCEtOPdmCD8mDZWCCxXH+ILFTzSIUQSK4h/Hpaxtj2FhnC+D8
         9TKJuBITi+fTwh9U45D2P1uu9rj9K9UDVIfHGdj4IUk5pJXY7Z56QZmFZqPo3zloYOkf
         2na9hlm4y69TcGAJVayTTCni54aBHyzCfyI9MGultdA2oK/arULENUTjOLN8Fk75zv+b
         841fSRkIFwkxH42D2R29iLULP8NP25udalhHBpr3NTsqUnST41ds2kGRACdXr3ggQT8U
         iT2TdG5/zUcZJ6S5lPo/eGvdAzAQ4ngRt9+wE9LdbksEitec14cK36rsld8Ms9loJGSs
         CU5w==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787742274; x=1788347074; darn=groups.io;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kACzQV5Og47cEOPCxUyhbTWJIyjkgTj7MOSraXCLawY=;
        b=C8IJE3VTPL/S4SQPx3Zj00U+f+2q4IcY336KcfFCK2fYMfDQ88FF7Rgt5i3gMoWIhB
         Utw6aQbdJBboEtFSBYZ8XCN7xGnIDjru78kjIe3IO+yAbSIhEW2u521j5JU36ABRZZGQ
         WWbnT6z0WWCPGAIIsj1RngJl4Og/e2FauXqlMC2s04PfnlA0mKLHk2B4ZHVVNB0N8zSi
         pSEO7OD5F5zEgyslnRTJkJBHX8tiqH5Jv8fatK1r5ZpxvMhqh4Q9wxLgRR7zvHHMWvXY
         3RFl1LxYnqnUgCWjaxd0oxx5js0wrDTlZVGOj5GZTGKhRSND4XSgIIwXCbID9rY741p+
         thtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787742274; x=1788347074;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kACzQV5Og47cEOPCxUyhbTWJIyjkgTj7MOSraXCLawY=;
        b=D4Ie4pNewLtqgMM8xxuFFNDAhA/o+waDUuIBZ0yucF/vDWt71VLId3E7cEcGkLfTOR
         TYdEjC3Ivf0+YMF41sxMvyY/5sZe2Riez5QRxMJDALs+aFP4x2+Lfq+4EyNwlBRr3p5M
         nSdemwH3l4vm71k2wj0/R5gGVhazRQf6OK6JbTVYlQvjaE04K2W2J0s6V11A0IlxG0gD
         okbxx5TPLwnaHbDHMyupJ35Ysfz1Dlc6s5zXMNqQNWaF+WVJrWG4J9jKC6jyNpWXA/gG
         R4ZQOKaI2LFQ+ZkWGRTCScVe3CkoxB3cvz87uVNxE9Extxn4huUKb1SReXX2aiLaF7Qa
         ZrAg==
X-Forwarded-Encrypted: i=1; AHgh+RpTst+HbvEOq8Ev9/PxqONIFHnKWEu47IMsNRjXX3wCSr4a3/qai2iUm59r2BA7BYEkTKlGVFM//OhUg+YTIQ==@groups.io
X-Gm-Message-State: AFuF++nGFTobkge8X+YuPQVykirBeP/hHskTpwWt6HqBo8q/Ce3TkXlG
	DZabXDhaQr01h5rrbPUEF/q5WQLmUUfVkEtm1EzfhBXsbkwfTmFnWUPZAxnqsckm3BZJ9txTtuW
	yCuG7r1dWVyFLBxStYovMgm3EFWDjI43Ju+x9JPKdJMw6xwMG+1gAzEUUxQ==
X-Gm-Gg: AR+sD10nB8GOQoJ1CsacwhgJcGmwalHA8gnRB+ccHWIAw6ruspMcJh0OndkQAmRItwt
	/AAOZ35eL8fZeDSuugoPoQdy84aETlnwAvv08HMpA+Tb2tHEihiqi8ToHNDW591DYbdBVAbFBqq
	PHQ8cCujSKX02WvD76OTpZqdA6EwKlUw/kU27983vT+N7a4GMUGEsS1UHYebSi4ZYGII7Us8GG9
	fl+gsPT2n+jhPYE55BnWD1Srqk70tVS9gtJmetUIYKzN36twcbRM4MYtPhPpq11nTR83br6vQC7
	gfbK+olmPD35WpakqTu6XobXa47EdWk8RfoFB25DcJAtDNSV1Yfo3dTyuV/pj6o0TalMA8Ts6B+
	dRi06Cj0BJ88NOpeNUV/BtmJd1r25SVWo+LJKc9BtSm1TgfLn0+HosUIMuVHcQqm8iM6bqzV9bf
	dToYEV9pGKl07vqXhK4Zqzjswpg/z7IQf3vnOh7F6f28UcHBNNYt9FAiPTYKnONM0KnPlXHDaJ/
	vq8dns0ft2ZUFaRaIwjZIM0ruO817MbBEJoA5tB6XaTIAt7pTLKmfdkkZdeK22Wuz5bSlM2QJnM
	1+sZ3pJY2CQ/AwnAT55Fc8HIto48+c91Wwff5U0EzJ92pCjf3KCpXHF8MUnn61BVC6s5WTSWr0w
	GfBTlChH8A0+/SBmDkrmCamxA5+7yM2v19YjKDyF38uc=
X-Received: by 2002:a05:690e:1443:b0:66d:1a5a:1d27 with SMTP id
 956f58d0204a3-66d2568aa90mr2158151d50.12.1787741802016; Wed, 26 Aug 2026
 03:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de> <20260825-linkcheck-v1-11-ee7573fe3a4a@cherry.de>
In-Reply-To: <20260825-linkcheck-v1-11-ee7573fe3a4a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Aug 2026 13:56:06 +0300
X-Gm-Features: AcwNN1VLYZ59-WL-ME7Hj9H5ELhHNRUHxsSBI62voLrBlDZWOaxOrEVzQ-1jG4A
Message-ID: <CAC_iWj+rpZ3ceNVbX3iKpEvci0Nddk99hvnGCLA_5jDhmsU2EA@mail.gmail.com>
Subject: Re: [PATCH next 11/45] doc: develop: uefi: update link to ipxe git repo
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io, 
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Viacheslav Bocharov <adeep@lexina.in>, 
	Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>, 
	Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
	Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
	Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
	Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Aug 2026 13:42:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3068

On Tue, 25 Aug 2026 at 19:50, Quentin Schulz <foss+uboot@0leil.net> wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> http://git.ipxe.org/ipxe.git redirects to https://github.com/ipxe/ipxe
> so let's use the proper link without a redirect in-between.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> ---
>  doc/develop/uefi/iscsi.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/develop/uefi/iscsi.rst b/doc/develop/uefi/iscsi.rst
> index 51d38cde2438..52fa79f35620 100644
> --- a/doc/develop/uefi/iscsi.rst
> +++ b/doc/develop/uefi/iscsi.rst
> @@ -125,7 +125,7 @@ iPXE
>
>  For running iPXE on arm64 the bin-arm64-efi/snp.efi build target is
> needed::
>
> -    git clone http://git.ipxe.org/ipxe.git
> +    git clone https://github.com/ipxe/ipxe
>      cd ipxe/src
>      make bin-arm64-efi/snp.efi -j6 EMBED=myscript.ipxe
>
>
> --
> 2.55.0
>
>

