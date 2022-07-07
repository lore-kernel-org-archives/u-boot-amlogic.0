Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web12.3126.1657181415297436578
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Jul 2022 01:10:15 -0700
Received: by mail-wr1-f47.google.com with SMTP id a5so10473120wrx.12
        for <u-boot-amlogic@groups.io>; Thu, 07 Jul 2022 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6n2RJHLPC7l5D/iOwDdWUWcWgl4o91KLKpCD1as4HmM=;
        b=eMz06EK2OdlIppYotdaC9Qo4or4D8hi82Jn1/eQ0qZ84xWZ4cML58R/f2zTrtPzCDv
         IZcjb92q3PdovkUWtV7UuRtzAGf+hUzjVBIPni4Hizv27Sh0G8Q565Gjr3KX915z6A0V
         VjT7Idg4yo+dnwXaDhAlc8e/aAcLoGNXqZHnSHMJX4VG9Yj6tFO2xWfZ/NVqfcV4kVdt
         /h5cw+7utp9m2FLcNSXXDHs+TtrnODJehv0//pONYaPWmYBO9c+UEaNVvdYsiqxlCfdt
         5VLh7nzJKSRlmNvbWooKWDnkU0MDn6wLtGNuQZMltrd3aqy3jEhwRHL7VbP0cP5a0UBU
         qs3A==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] doc: board: amlogic: add documentation on boot flow
Date: Thu,  7 Jul 2022 10:10:11 +0200
Message-Id: <165718140622.3284173.1566161017218993109.b4-ty@baylibre.com>
In-Reply-To: <20220706093649.3261229-1-narmstrong@baylibre.com>
References: <20220706093649.3261229-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot-amlogic@groups.io, Simon Glass <sjg@chromium.org>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Wed, 6 Jul 2022 11:36:49 +0200, Neil Armstrong wrote:
> This is a preliminary documentation introducing different
> boot sequences, and notably the recovery mode.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/1] doc: board: amlogic: add documentation on boot flow
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/647ba68841dbb5de82983a1cad4cf42bcf63b9b3

-- 
Neil
