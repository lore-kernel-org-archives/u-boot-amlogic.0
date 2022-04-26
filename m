Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web09.5784.1650976479814916691
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Apr 2022 05:34:40 -0700
Received: by mail-wr1-f46.google.com with SMTP id i5so6207821wrc.13
        for <u-boot-amlogic@groups.io>; Tue, 26 Apr 2022 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GX/NXkC6voXGjJtr65v+8EiJHYRAQUerTl6QpL63NU0=;
        b=Yzq5ILOLeThhFd2wd96/LAzg3OGFF76wZ9X7uFYN/TNaaIGjb+NnkZ8VvnUhZn+2sP
         yjZp2dTXVpmvo1YoZxDlWG+vdwwLzLRpznEPX1ODILI4ZzcwYiuW2zDMoms5L97mZe0b
         lYZe1ta5BVv3rXP4kFS/NEnFoaNeL2Pz+twSxAJRyAbADd7JK1ei/54lH9ZvSz0qIbEM
         2stvkUrYREF/6Q+Glug05V4Vz/F01rNrEhw1KUq7AM3Zpzp1T1rrmWhcK5k9Mp9yp7jV
         apgU0xwhHQL9butAgSbg+PKqDRenC9rZ2tXH3ho+QB5QtLcwE6itiG5T5GLbTsm0Gq99
         NJlA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] doc: boards: amlogic: update documentation for ADC support for AXG
Date: Tue, 26 Apr 2022 14:34:35 +0200
Message-Id: <165097646225.2900940.6271234573208864728.b4-ty@baylibre.com>
In-Reply-To: <20220426052633.3027932-1-adeep@lexina.in>
References: <20220426052633.3027932-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, Vyacheslav Bocharov <adeep@lexina.in>, u-boot@lists.denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Tue, 26 Apr 2022 08:26:32 +0300, Vyacheslav Bocharov wrote:
> 


Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/2] doc: boards: amlogic: update documentation for ADC support for AXG
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/39a40a90c87b1925efb59db729664b12c2852f81
[2/2] doc: boards: amlogic: update jethub d1 specifications
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/35cd09397240bd3c01fbd1bf9d1e5588773b9996

-- 
Neil
