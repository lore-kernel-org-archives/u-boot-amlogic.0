Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F3FCF58F6
	for <webhook@archiver.kernel.org>; Fri, 20 Sep 2024 09:27:38 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.web10.13188.1726504157204858192
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Sep 2024 09:29:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=M0sRQ6qZ;
 spf=pass (domain: konsulko.com, ip: 209.85.160.181, mailfrom: trini@konsulko.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-457cfc2106aso32182601cf.2
        for <u-boot-amlogic@groups.io>; Mon, 16 Sep 2024 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1726504156; x=1727108956; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXRuulX/PkQjPAYIohyUG6dUamOp+riFdkv4e58t9lY=;
        b=M0sRQ6qZePWQ6ZwZ5Fh17mUQsHqXxM7cKSXjCwwhv9i3ZYFPcOkUypQThGwznkEDBX
         uS7HL/E+CgcsXtE0fe7YKONWk0jTK+aONtNDBw+u8OrXjqJI6IczK46r116lEWjPJMJZ
         AXRnzXKihb56XyVPjADIUM3gUU2+Ht1ETLD9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726504156; x=1727108956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXRuulX/PkQjPAYIohyUG6dUamOp+riFdkv4e58t9lY=;
        b=t/qNtZCw4oa5Ao8fCQl3XVCUFVgvcgrUtv+LWz50ky5wsaDQi17TgUEZ2Fth5wWHSd
         YnOTq7ytnsuJ+IRVz7Kfa6tD9IO68EUzX0FZTjexCsB86wK/B/dgrP16+/998DD3tV45
         rAykDTZQFt25GxS04H4sMtTHBrFHyX8FMrlZiXry55yV4w4Z87l+53ttlDz25gtHf9LS
         +BLzBCs+IdGkoljnRnT6FIxLpql5QewnxF27i4EzgQYlecu9VCakmW8+MW1xqrfza8M2
         KJgW3KGchyxCPhcAvq/oCQSlgP+MMLJtGtw/XjF/Xz3Qf5SaEVzUsYoAU24jodX0vQUG
         dPHQ==
X-Gm-Message-State: AOJu0YxUGBjlXZR7aTJNQzZ71IaT28Ht9xrXSVJSUnBrqWMm/ssXs8NV
	MkXgwa3xIfZUn9UawKJnzrLyQq0poEzNlNRxpvWipSshph7XN9tpu9NYJwS11m0=
X-Google-Smtp-Source: AGHT+IEwxqNMoHq1VnOJl65OZaV8b+cBPzaaL7bVSQeU3vBxX5kuGRb700CzesXB79lB2ksSAUQzwQ==
X-Received: by 2002:a05:622a:1ba3:b0:458:2f3d:dd78 with SMTP id d75a77b69052e-4599d235b4cmr191035491cf.15.1726504155907;
        Mon, 16 Sep 2024 09:29:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac611c9sm28814291cf.17.2024.09.16.09.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 09:29:15 -0700 (PDT)
Date: Mon, 16 Sep 2024 10:29:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Da Xue <da@libre.computer>
Subject: Re: [PATCH 0/2] ARM: meson: libretech-ac: add suppor for EFI Capsules Update
Message-ID: <20240916162912.GF4252@bill-the-cat>
References: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=Byujhtgi6jzzx8MMKIiF"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Sep 2024 09:27:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2394

--Groupsio=Byujhtgi6jzzx8MMKIiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 11:41:47AM +0200, Neil Armstrong wrote:

> The necessary changes were made in U-Boot to easily support
> EFI Capsules Update and be compliant with Arm SystemReady SR.

To be clear, "SR" or "IR" ? I assume you meant IR here.

--=20
Tom

--Groupsio=Byujhtgi6jzzx8MMKIiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmboXNgACgkQFHw5/5Y0
tyxweAwAg2r/BhkOFrvohD+JIKVVkO8F7ovMuCHA3/rYB31Nar6nUHvbk8nHqsjZ
OiDiSpg7EVdZela4h6dtok86gFcTEo3aQ2KyAZdc4hl3jiE4iH2KrJ18fPpyrOWh
crA6FYlBfoFHwM2K4aDtMvDSWJmonW440H65W67EbnBCGbHL9X3Igt5n0uQdJFIo
Ow1weEirrhEXpgusLN3aBN9tgnPEzSnYMKRVugxJZ4MKQlG0R6bmu03AKSJ5WVS5
gjIJduBbjlVr5pcvI5Nc3HC7ZjR2uFcHR2zltFqGDx9gWcEcuZhNJGjhnGx9GPn0
Q5YS/7JOMrnWk7XxA0Jvmhj5RF9XUVxKukDPL/PVmDJwjk+8tvWWTU9t9gwFYtfz
qlOoVD5c1iBPDGn60DbylWMcYlD503t3TpH0WpalNkerDHp3k2a59H2/PXPF8mSD
R6kSeFKiVdHJdSllG1g+O/vxPE/DbY53gNrDodXK3v4NVz2/f5ZfZCjjfljVjqW4
hyCRS1jU
=PHwe
-----END PGP SIGNATURE-----

--Groupsio=Byujhtgi6jzzx8MMKIiF--

