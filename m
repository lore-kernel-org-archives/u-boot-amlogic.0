Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD08D6DDFE
	for <webhook@archiver.kernel.org>; Fri, 15 Nov 2024 13:14:22 +0000 (UTC)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
 by mx.groups.io with SMTP id smtpd.web11.15894.1731515809672524601
 for <u-boot-amlogic@groups.io>;
 Wed, 13 Nov 2024 08:36:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Scu5jiU4;
 spf=pass (domain: gmail.com, ip: 209.85.166.182, mailfrom: caconeta1234@gmail.com)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a6bc65e414so1030215ab.0
        for <u-boot-amlogic@groups.io>; Wed, 13 Nov 2024 08:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731515809; x=1732120609; darn=groups.io;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/zciTR+8EblpsTG4JK1B5st2cc5bvniBmZ6U0BZjSVY=;
        b=Scu5jiU47nGHOQvwL9YQchno8oYHRXrI/K4QEu6qtEHb6vn7xC8a9+O/SERBZmh7GA
         vu6qkRfhR1iBq+rT88y8gn7VriguaPwWgPNEBVU2wSgD9uOiBQCanUxpVRC2xBC0nN9A
         seOxdqTzq9s4gKFlZl6eOMdzFwzzCCkJ1tuiDjgG3cPWigVe/MAnZNu3mIR65lL9AO+1
         rmffdrJF10LBbOVilc/rnEJh4v6OPMstFjxTC857MvotZUl/pRJFnFKEre68usd3XPrq
         DB5hPzwRprmJzceyhc21q2dzY3HfqbqA9NjzmR4i1uRY63eQXL/ukPfQkw1MKtWd+QwM
         fioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515809; x=1732120609;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/zciTR+8EblpsTG4JK1B5st2cc5bvniBmZ6U0BZjSVY=;
        b=YKRMUDfLTT9w1E+GN35g7Y8HD68CspxQBNYpWS5qFzEOGwfg2saJGagAtAnrP+t7rZ
         Q8zf25TqdM04EhnKUfIYgsoyCRbwrCf0Eu6H/3J/f6b2LnZPVBOi7GdVe0/m8CuK59BT
         uelPOdEPeKf7oLqpVNBxUqYdiQ4bQqJUNUuMtnoNlfcvJzH79r7Ins46636kfENbC2iG
         FgzhUEBRLjHNIfXcYx/+q28+6JgYDTqg1WSfB2gaz2Aazz1XwkTM+GPBtWlG8gJUNNkX
         D0K3vGpiKXmfkwvohLsPEwnNExb5hws7NDAUh9kauh6aFCzhXUb/YlKEd3A16vtWZn92
         R0kA==
X-Gm-Message-State: AOJu0Ywn58ZRIEHT/inVx7XM0jSGlU4csTV6g99oXyascPX6lnyIt9yc
	FhjLLL7N9ac5V4XEIc5qUn1C1K1cR/7tb74DlFar81zrx23KoC5SJ++d332CszSvpZ7Gpt6Xu/E
	QMd0N7GboHJdMNsb/6jhgbvT+lvNa3g==
X-Google-Smtp-Source: AGHT+IHkb0GG4wCRYDv8QEsetDUdtMKsNDQ4B7pLnlamPiRj9bZTTjsBLIKiIoWJSAqfzWPGNZnWq1LI0/DkGpQ700k=
X-Received: by 2002:a05:6e02:13ad:b0:3a3:c207:b4cd with SMTP id
 e9e14a558f8ab-3a6f1a6aa81mr61917245ab.5.1731515808740; Wed, 13 Nov 2024
 08:36:48 -0800 (PST)
MIME-Version: 1.0
From: caconeta1234@gmail.com
Date: Wed, 13 Nov 2024 17:36:12 +0100
Message-ID: <CAKPkay15xf85cbMb244=gCfiXSeLqzHEOTxaA22FTHLAyuTBOg@mail.gmail.com>
Subject: NAND for Amlogic status
To: u-boot-amlogic@groups.io
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 15 Nov 2024 13:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2557

Hi there,

I would like to know current status for NAND support in amlogic u-boot.
We're using the 2015.xx version provided by the manufacturer and would like
to try u-boot-amlogic.

From the status table in linux-meson.com it seems NAND is not supported
yet, but it looks like there's been some work on that. I'm interested
particularly in the A113X (axg).

Another important feature is whether there would be something equivalent to
'aml-flash-tool' ('update' tool) for flashing the device over USB.

Thanks a lot.

Regards,
Juan

