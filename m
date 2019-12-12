Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
 by mx.groups.io with SMTP id smtpd.web12.4428.1576194992225083817
 for <u-boot-amlogic@groups.io>;
 Thu, 12 Dec 2019 15:56:32 -0800
Received: by mail-pg1-f196.google.com with SMTP id k25so505225pgt.7
        for <u-boot-amlogic@groups.io>; Thu, 12 Dec 2019 15:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=EMKOZ7lj+YGkb7YAUS9V7HSHJOjWrMQuUTBWNxCh4ao=;
        b=VirtC3QlBxKB9e5BZg7NAyxyodiYE88TgOVv48G8m7Q+/CGzuG2ynpwrhLqiaUnRGP
         DK1djeyXh4eG6YqahaCPUibnP+7GQtxdi+kmbvLI1j8qZkABhDhlWA+LSzH3VBmBtHql
         RYkWpHTWWXoJ6uODKXSPKawHqAe8SyiIFJ/pxKzDbfJjPA5YdxUBCmANIqxstvwfkFBx
         AYl+4W0+Pu6KuKSGzo8DmjjAxVsN6x7DDkayuzd7OP7Cx8nGPoGQ0SwtvedbWHnIE3i6
         ry5OF+GUlDmsOXLq010+xgT799a+vhbb38pjd1XfIw+Ocjh4VvYoxMbqLiY/4MkKvUJ/
         hcsw==
Return-Path: <khilman@baylibre.com>
From: "Kevin Hilman" <khilman@baylibre.com>
Subject: Re: [PATCH 0/2] amlogic: add Khadas VIM3L support
In-Reply-To: <1576056054-4458-1-git-send-email-christianshewitt@gmail.com>
References: <1576056054-4458-1-git-send-email-christianshewitt@gmail.com>
Date: Thu, 12 Dec 2019 15:56:29 -0800
Message-ID: <7heex9jdxu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: u-boot-amlogic@groups.io, christianshewitt@gmail.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Christian Hewitt <christianshewitt@gmail.com> writes:

> Khadas VIM3L is a new revision of the VIM3 board that swaps the premium
> A311D chip for Amlogic's mid-range S905D3 chip.

Tested-by: Kevin Hilman <khilman@baylibre.com>
