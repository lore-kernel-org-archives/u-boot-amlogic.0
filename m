Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.117427.1597949934475152318
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Aug 2020 11:58:54 -0700
Received: by mail-wr1-f47.google.com with SMTP id 88so3169387wrh.3
        for <u-boot-amlogic@groups.io>; Thu, 20 Aug 2020 11:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:mime-version:message-id:user-agent
         :content-transfer-encoding;
        bh=A+59XKPmF9U+TsVEcjtI5j+3nzimOAw7QCQHhhpJPlM=;
        b=M7KVSUBcYRM4EI8W9FUL/3I6H/pP87RYRIOQRz+Ss+qbRRapbPBkgKwC8/xr7RX8RE
         eBT3/judVYrFy96aIENtyF99208Q3LeRwnXUqfu3B5RGjAT4M+OMAgprKtObem/Sj0QQ
         88MbNG7fha7X0YcaWAV+z+3ncGUJ/JTkT2oR3Mzl6GhBiA5r1naqieQuWhMtAaqdSamD
         N7DUKNItVUvh6pFhMeTHyOrcGdGSGM8JgSKZarTTiusDLNH9M3NN3Il0cFPhaLWIN7KK
         AVGOINpd6xQXGP3PNXMwc8HxeJ5iUzh9egzucv9QabhwRgpQdefPfKpUR7n+X+7o2BWl
         YTYw==
Return-Path: <vicencb@gmail.com>
Received: from localhost ([170.253.38.159])
        by smtp.gmail.com with ESMTPSA id t189sm6460701wmf.47.2020.08.20.11.58.51
        for <u-boot-amlogic@groups.io>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 11:58:52 -0700 (PDT)
From: "Vicente Bergas" <vicencb@gmail.com>
Subject: HDMI on Odroid-C4
Date: Thu, 20 Aug 2020 20:58:51 +0200
MIME-Version: 1.0
Message-ID: <0d556ad4-39b4-4ccd-975d-b5eb96e4007e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi, i've got an Odroid-C4 and testing u-boot on it but cannot make HDMI=20
work.
U-Boot version is 2020.10-rc2 and configuration is odroid-c4_defconfig.
From the serial port, the 'dm uclass' command reports req -1 for display,=
=20
video and vidconsole uclasses.
Am i missing something or is it supposed to work?

Regards,
 Vicente.

