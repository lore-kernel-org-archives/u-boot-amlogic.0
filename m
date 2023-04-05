Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.125300.1680683400650742717
 for <u-boot-amlogic@groups.io>;
 Wed, 05 Apr 2023 01:30:00 -0700
Received: by mail-wm1-f54.google.com with SMTP id o32so20397966wms.1
        for <u-boot-amlogic@groups.io>; Wed, 05 Apr 2023 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680683399;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noZ+IINEHx0nI9nJNS4tqD4vLRCobIca+OyXov33sZM=;
        b=Dr5wJUVRZMHa7RMlwpEK5IDWxTk+LlZJu2NfdG8+L+2MQwvG2LguD9Twip49W6EhEo
         Ezyvz8Qbul3Thxadr1mHP4KY8IrPw1t5eHzl7ONudNBFv7uN6F3B00EeqD49L6R/BFKt
         2eddISX8rgTVePzkmxTKYufd/MP+BSODEhnXxkOHYZifoARfN+2kXrR+CnMJV33dnmDD
         2LJCyTbSG1FiXzG2dHjtaSUoaaTgJ47Bh+eyipv72yxVtzFgKSPtamjGcdHBXmD5rNxh
         kJerY7mrbO8n/sIcEqy/kO5wVqocUH2z3G+O21sh5NkcVKlOeME3vaPYMNgrBwhzPE9X
         CouA==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <8760391a-3506-5ac5-8d55-92c23cccff44@yahoo.com>
References: <8760391a-3506-5ac5-8d55-92c23cccff44.ref@yahoo.com>
 <8760391a-3506-5ac5-8d55-92c23cccff44@yahoo.com>
Subject: Re: [PATCHv8 3/3] doc: boards: amlogic: add documentation for Beelink GT1 Ultimate
Message-Id: <168068339856.1444622.13000747478628792706.b4-ty@linaro.org>
Date: Wed, 05 Apr 2023 10:29:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, Karl Chan <exkcmailist@yahoo.com>
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Tue, 28 Mar 2023 04:15:15 +0800, Karl Chan wrote:
> Add build instructions for the Beelink GT1 Ultimate board.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[3/3] doc: boards: amlogic: add documentation for Beelink GT1 Ultimate
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8ee577815e301f3c8403c508507ca009ea606e58

-- 
Neil

