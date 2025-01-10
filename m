Return-Path: <christianshewitt@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA5AE7719D
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 04:12:37 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.11715.1736482352344012796
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Jan 2025 20:12:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PBoy+bP5;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: christianshewitt@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso878857f8f.3
        for <u-boot-amlogic@groups.io>; Thu, 09 Jan 2025 20:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736482350; x=1737087150; darn=groups.io;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcg+AbNUagdr/GnXOyARNpX3VNRzL5mr6RLcmdmpWq4=;
        b=PBoy+bP5hXgOpwm2n8fzVqqn6uRMebKbFy242qIqMQV3jAtwH7GIr9NckNjMDBtE/i
         lC9TazempSrFBlNKN2mS7nqih5XjqwHjSurFjALLPPkhmqtR56s7ohMeIoLTNhijIZih
         F7UsRDcnyZWlYQCiskilkpImbkOlyayyB2w4lakqFY5EMixYLAoReWk21s8osWRaOC6J
         Pwqhi0bqcWOWmrzOnenkYz2XyfstbVxp45p5JTCAUk7P2UQqbLQ98WNAj74diqM+R7TY
         cLRpuUYCqdoSpppq+odqpPwng8dDbf4TdR+kgykhs0DFgg1Sd7m3P9m3y+qR1pp29GuZ
         a5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736482350; x=1737087150;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcg+AbNUagdr/GnXOyARNpX3VNRzL5mr6RLcmdmpWq4=;
        b=oGSJ8Sv1wfqKIQVc50GUBBvfMHbAEU9qQiSCBOPCvF7hHnzTOEBEgPqKBM/uz4Mryr
         TcFDF1jWbqbOZ0b4RiUJozkzGwgm/2ebH3SMeRgZwjMW7DSAVvECQlEqtJfvycBWiebI
         NLUFgfeSl8m9dCoG5Zs3x+VjVC9kG1wJJblFArSY1oRWoPaq4Blf9lMwBa2OFzDEvvu3
         iQ+Z8UoCw5WoJmXdJjlbuIS4GobidbwLVngdDgsXhPzwfC4SkCGMXcFiMORx59dZ3Gnd
         C93fv2JgT1sHVy4fyT7/Vc1F2mu0LMsrJ4TSyOocCQb2qQXZ/gT5vL03YFUEaSxeiME/
         59LA==
X-Forwarded-Encrypted: i=1; AJvYcCWCtZj6ElmQ1Iv7pxpXLu/eSgmQkNprPHJe/ceh8nsEbbxS76yav8E2amUxZlc+Hlxpnp4aB/q7+3btaVWthw==@groups.io
X-Gm-Message-State: AOJu0YyT5H/pNXbQ7Hpl7GDgY3+GjnZxzHvSaGDjeCCVouzy+kpSugpE
	QVaPcJzxH76uSAwsLupwFcIasAVvs+jnDw70yKngGl4ghfQ9+7hj
X-Gm-Gg: ASbGncscDIzK6vrWJLewXI0gPJB2xTUHub4MfdhYEOqfMVew0FCnMWYKU8MNx8f68De
	cYUu5HM15GOSzf7vEUpyCy6Co0SKLB1sCD1KmIAVNJyXYsBDuVQxqDnGMi/tI1CscYsQHDO/W24
	i3duzpkkmUP97xhvtLIYICxx18qAKwLJiLxlw4bci/MBMxsaK6rwpIlS2bOZ8USJ8DJlmhWhKKz
	N25n26lIMPKOt0mnFcKBZJb8IGZxFqiu9B19KwIy7XL47eQ1CGmAO4S5lAsGyxZ/CPEWNDSeJUl
	b34=
X-Google-Smtp-Source: AGHT+IGbDMIld2lAh5kd8KV7ln8byuZOqPwrIxJ4sixY28HelypxvHQugYQ+DIZdYNNqD3wjEoTaLQ==
X-Received: by 2002:a05:6000:1fa1:b0:388:caf4:e909 with SMTP id ffacd0b85a97d-38a872e8bc4mr8994719f8f.25.1736482350274;
        Thu, 09 Jan 2025 20:12:30 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c697sm3429114f8f.52.2025.01.09.20.12.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2025 20:12:29 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] board: amlogic: odroid-n2: remove amlogic prefix from
 fdtdir path
Date: Fri, 10 Jan 2025 08:12:17 +0400
References: <20250110040353.3424412-1-christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de,
 u-boot-amlogic@groups.io,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20250110040353.3424412-1-christianshewitt@gmail.com>
Message-Id: <CC4AC28B-2FB2-4AE0-B4CB-8FCA84D8A6C2@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 10 Jan 2025 04:12:37 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2611

> On 10 Jan 2025, at 8:03=E2=80=AFam, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
>=20
> Commit 834e7c8136c6 ("dts: meson-g12a: Switch to using upstream DT")
> changed Amlogic configs to contain the default /amlogic device-tree
> path prefix, e.g. for odroid-n2:
>=20
> CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-g12b-odroid-n2"
>=20
> The board files also prefix amlogic when using fdtdir resulting in
> an /amlogic/amlogic/meson-g12b-odroid-n2.dtb path which is invalid
> with most distro packaging. Drop the prefix here to align with the
> board configs. This resolves fdtdir boot on Odroid N2/C4/HC4.
>=20
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Please disregard this patch. I=E2=80=99ve spotted the issue in our =
distro
packaging and this is not required. Apologies for the noise.

CH.


