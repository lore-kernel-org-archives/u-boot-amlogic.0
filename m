Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D772C3DA59
	for <webhook@archiver.kernel.org>; Mon, 22 Jul 2024 10:07:54 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
 by mx.groups.io with SMTP id smtpd.web11.244.1721322805228999346
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Jul 2024 10:13:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DreEY1Zd;
 spf=pass (domain: konsulko.com, ip: 209.85.161.50, mailfrom: trini@konsulko.com)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d3cf39c239so570616eaf.1
        for <u-boot-amlogic@groups.io>; Thu, 18 Jul 2024 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1721322804; x=1721927604; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xyz4oBZLIPbkYz582n4fTn+Rbd24cV3n3QH9P14Rvus=;
        b=DreEY1ZdiN8/mTR4oHpekUjDwLImWuY9U5j0uilRaMJ4Xbsy3/0pGLEeG9MtCiesW0
         dPvftzgyXeb+Amw+P56Ab87N0KqL9VLAGRUaDczSJ1q+HtmBklbOPVTtSZE6ihPqinIb
         UfZtMSbY8TXZzB1IhXTX1feBBrZoYxI2y6ub8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721322804; x=1721927604;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xyz4oBZLIPbkYz582n4fTn+Rbd24cV3n3QH9P14Rvus=;
        b=BuD+K6FQKjR17V/3MIfdmOc/Fg9zN6xqKAwQosKXOfBnWF20S4RUJK6QrO6Gixz5NZ
         0HiJE4M0LgNfV3+8PPqrmgbjxPfPp1uxF+l8GazOJC4u6OcDL27fyU4ZMlXmPsDXs7j2
         XENkTgGwPTrDQA67gqvrxtbQUa3U3qisYChJuR6C5aS64XbSuEG8r9kklCC2hfkEsHhv
         6mEo8FJpQgLHP7k3U6mZB9W8aR+iRSEwVWjeW7tpnTwktoHAfCkNTcfNIzwaz0lZHYsk
         k2j4cUbSPrU6kp97m2qtWd8za0QHF1vJg+6XnKIVp0Lwtsi4Kh5QMB0PXzD5Om06/O8z
         cLzA==
X-Forwarded-Encrypted: i=1; AJvYcCWPbdAjOwYXKPnnYIuh+ynFMbs1QxxHk5W4cXS+4R9qxQ8gb6Awq+g/taRmpuKHVEJ3De0Sb8rtUMY/6PrTUR2BN5uXHJ+l8+0=
X-Gm-Message-State: AOJu0YxxETBOVUoshdTvFzhbOAHSeoJ6RZXElArLS58V1dtKSyUPSzHR
	Uoi9kiANHMxFVLwusNJSLh5FkWHYIfKu0EoPJxx0/wsSuEaXTZSWWVf4BJK7g5kJ1ES2FCTlWif
	HlKg=
X-Google-Smtp-Source: AGHT+IHzsPwaDLnC+JSwdgLbouKUjYxiUlXxFUwyqsQwmnsLjIKqGERB3hnxCI9Esxkq6TNm8UWKaQ==
X-Received: by 2002:a05:6871:153:b0:25e:1817:e4b7 with SMTP id 586e51a60fabf-260d9504caemr4659896fac.38.1721322804472;
        Thu, 18 Jul 2024 10:13:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net. [189.203.103.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-260ee584a56sm422664fac.7.2024.07.18.10.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 10:13:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
In-Reply-To: <20240718-u-boot-fix-v6-10-upstream-build-v1-1-ebeb67ef773e@linaro.org>
References: <20240718-u-boot-fix-v6-10-upstream-build-v1-1-ebeb67ef773e@linaro.org>
Subject: Re: [PATCH] ARM: dts: remove leftover Amlogic GX/G12 bindings headers
Message-Id: <172132280380.1848517.3639926942922389573.b4-ty@konsulko.com>
Date: Thu, 18 Jul 2024 11:13:23 -0600
MIME-Version: 1.0
X-Mailer: b4 0.13.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 22 Jul 2024 10:07:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2358

On Thu, 18 Jul 2024 10:28:37 +0200, Neil Armstrong wrote:

> Remove the leftover Amlogic GX/G12 bindings headers that
> maked the v6.10 upstream DT fail to build.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom



