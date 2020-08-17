Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web12.49814.1597690079402018247
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2020 11:47:59 -0700
Received: by mail-wm1-f51.google.com with SMTP id d190so14092870wmd.4
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2020 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:mime-version:message-id:user-agent
         :content-transfer-encoding;
        bh=A+59XKPmF9U+TsVEcjtI5j+3nzimOAw7QCQHhhpJPlM=;
        b=EZWvgkVVRMxpHrMmUPuSmZeowi6wF2JeZpSlZi/hItDMaJEPa+phbOQlLnZZYoJPgv
         lo/lEwH1aCKLr5USG1KrkjfgPBhoW0rMWnr6mS6YzdMBaXdwCmxoQLii1B/SLyoFsRIx
         Z4L7g3Z6DsIrEeMGB+JxPVk19V0/65dmQc2KselKw3gdWiGb78KLA2hBWlX88ofgEEgv
         BBlw5fuapM7Xi0snwBlbirZYDL3moK1QP5rdVBJCLCN4N0Cf3KxSkDhxSe8QHQDMHFIz
         3/ZbchE3dxQcybbpeoUaO0Q1WLjCvA0m4rqt+jjbxDq5BnvxOqblbrmYJYWyhMXi4Mip
         SQDg==
Return-Path: <vicencb@gmail.com>
Received: from localhost ([170.253.38.159])
        by smtp.gmail.com with ESMTPSA id w10sm30696686wmk.0.2020.08.17.11.47.56
        for <u-boot-amlogic@groups.io>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 11:47:56 -0700 (PDT)
From: Vicente Bergas <vicencb@gmail.com>
Subject: HDMI on Odroid-C4
Date: Mon, 17 Aug 2020 20:47:55 +0200
MIME-Version: 1.0
Message-ID: <8797ec47-254c-4694-8ec3-41ba8fa9b7cc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi, i've got an Odroid-C4 and testing u-boot on it but cannot make HDMI=20
work.
U-Boot version is 2020.10-rc2 and configuration is odroid-c4_defconfig.
From the serial port, the 'dm uclass' command reports req -1 for display,=20
video and vidconsole uclasses.
Am i missing something or is it supposed to work?

Regards,
  Vicente.

