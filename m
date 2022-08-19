Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web08.1009.1660899641886628671
 for <u-boot-amlogic@groups.io>;
 Fri, 19 Aug 2022 02:00:42 -0700
Received: by mail-wm1-f49.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so2159824wmb.4
        for <u-boot-amlogic@groups.io>; Fri, 19 Aug 2022 02:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=JTx9Y3puBUpvQYIf5MBqqt/ShA35wKMET9jLv5bh0Lc=;
        b=wtqtG39Xt0etlY7TUXfm/HKtOjCWnHRyhUFJZgMJkyaOUVXDbGywKzN2n5pkFY81N3
         mSCYSj1c4RvTl+u2Duqyv28imzeXQ8k9+PehKJLjAw2crOfW5qIiwFi4+fNPsL6iA0ed
         6O31ynJPNAbYztEy3oK4EuEF2MwrcKpQKiuZITqoVAZP5HN3Z+P+UOxS29s2eRfzp638
         gIspQtJZwmZHJNaHGByb6tsIe1vKfOAkDgDMRuUNnAJm+tHZyPNeJhO5Z4wPuQKvkm6p
         8BzHwdHBIFN7KO0HqITTKoN4x+eLxAuH5/y3vCEIrJX1imFnI4vLq4p1Jw1eiQu/8NXv
         273w==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <78a2ace1-4e2f-b25c-ee91-93bf09c4f0a4@baylibre.com>
Date: Fri, 19 Aug 2022 11:00:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: Update email of Neil Armstrong
References: <20220816095808.948933-1-narmstrong@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
In-Reply-To: <20220816095808.948933-1-narmstrong@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

On 16/08/2022 11:58, Neil Armstrong wrote:
> From: Neil Armstrong <neil.armstrong@linaro.org>
> 
> My professional e-mail will change and the BayLibre one will
> bounce after mid-september of 2022.
> 
> This updates the MAINTAINERS files and adds an entry in the
> .mailmap file.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
[..]

Can you apply this or should I send it via a PR ?

Thanks,
Neil
