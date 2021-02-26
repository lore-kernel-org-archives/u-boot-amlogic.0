Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web08.11515.1614355871532496018
 for <u-boot-amlogic@groups.io>;
 Fri, 26 Feb 2021 08:11:12 -0800
Received: by mail-wm1-f42.google.com with SMTP id i7so1273827wmb.0
        for <u-boot-amlogic@groups.io>; Fri, 26 Feb 2021 08:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QqXEAl4FUK+CQSByWUI8lO1fpeTUNT15Bh8JLBy2SCM=;
        b=w2m9k+pHsE8qHRXtEZt5UaeYs7sCj+m1v6d1MtrNzyBK99zgPxI/u/lvpJn5YxKM4A
         OYhggMM1at5TJFzCHEfvtJ3qMqvPzcAD4DkGukLyxBXki9BIhRa80NRoPXrqADXArf2Q
         yzUFGeuGFDzLw9GfzvS0mVSydGHHx1OSZ8f/t+FAPBkRqzdvs5dq9Q9nm046Uq8PtPK+
         f0/kausFve4XnfCN6lGWfWyxXCYmKNmHm2DbcenaTJpKl9MbUwzonWiZQhfNTc/U/2iz
         tLSW45Mto4TcGbSmc88ixZ7d61ggXnTuJwjOYHmy/JQX7MuVxqzQzdS6MbIAtb9eSPLi
         G1fQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] nvme: add cache flush in get/set_features
References: <20210226141318.3882733-1-narmstrong@baylibre.com>
 <52e8d653-c05a-e6a8-65c6-1571f426aab1@arm.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <14fa1b42-7248-fa03-0998-cd6480c89d02@baylibre.com>
Date: Fri, 26 Feb 2021 17:11:07 +0100
MIME-Version: 1.0
In-Reply-To: <52e8d653-c05a-e6a8-65c6-1571f426aab1@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, bmeng.cn@gmail.com
List-ID: <u-boot-amlogic@groups.io>

Hi Andre, Bin,

On 26/02/2021 16:22, André Przywara wrote:
> On 26/02/2021 14:13, Neil Armstrong wrote:
> 
> Hi,
> 
[..]

> 
> And if this seems to fix something, how?

Good question... sorry for the noise my patch is totally wrong, but it fixed something somehow.

But, "nvme: Always invalidate whole cqes[] array" fixes (correctly) the issue !

Thanks,

Neil

> 
> Cheers,
> Andre
> 
>>  
>>  	return nvme_submit_admin_cmd(dev, &c, result);
>>  }
>>
> 

