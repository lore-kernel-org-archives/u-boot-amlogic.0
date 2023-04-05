Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.125299.1680683399301999516
 for <u-boot-amlogic@groups.io>;
 Wed, 05 Apr 2023 01:29:59 -0700
Received: by mail-wm1-f51.google.com with SMTP id m8so9499395wmq.5
        for <u-boot-amlogic@groups.io>; Wed, 05 Apr 2023 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680683398;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3PIaGM/JQHLq+AUpWeB1DxgRflZXBILY0Ozym7JJ6c=;
        b=Vd6ixv1v3bbrNWfHnd4WITN78FVmpKTVCo5o14/YZUPC9dhdEGBlcLyUJdExawddca
         JYi9X8fhD3IB9nbMHBButavRSOo0ejGh/o3kIB1qFes/kz9KE1r+veeibRNUXOb0+Z8V
         KLyySRG2NCZMnIh2ea+Ov98sckiREjrXHyDqqgXgkXZpvIC7uiJlIYicHdTq5lsqUnsI
         wpS8wh+0d/CYzH/bjPzh8LepBIps2sGKqEG4WFAixaDlhErdmrIGipP4djcHcKfrpJfV
         Wo23aK6u5R8ZFpkkz4V7oQjuEJd/1nf/bRDIgdR1NhTGTyguKTTPqD3ggvkW8Py6KRNk
         KlHw==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <f5a8db4e-b2d0-e00a-cc4f-01a4f794c761@yahoo.com>
References: <f5a8db4e-b2d0-e00a-cc4f-01a4f794c761.ref@yahoo.com>
 <f5a8db4e-b2d0-e00a-cc4f-01a4f794c761@yahoo.com>
Subject: Re: [PATCHv8 1/3] ARM: dts: add support for Beelink GT1 Ultimate
Message-Id: <168068339700.1444622.9576912419325432437.b4-ty@linaro.org>
Date: Wed, 05 Apr 2023 10:29:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, Karl Chan <exkcmailist@yahoo.com>
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Tue, 28 Mar 2023 04:11:52 +0800, Karl Chan wrote:
> Import the device-tree from linux-amlogic/for-next (Linux 6.3-rc1).
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/3] ARM: dts: add support for Beelink GT1 Ultimate
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e054cc7475d939c1bfce5833d16b43c8a75ebd67

-- 
Neil

