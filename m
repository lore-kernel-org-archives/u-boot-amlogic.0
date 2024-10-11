Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE62D0D7BA
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 15:06:41 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web11.14192.1728659198779369695
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2024 08:06:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=cRX+idLj;
 spf=pass (domain: baylibre.com, ip: 209.85.208.182, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fac47f0b1aso21471211fa.1
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728659197; x=1729263997; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LnC10CaG24WPSzLSNKOFOgGsi6jjDThxQwiyj7ue9sI=;
        b=cRX+idLjrJch2KaeRUod3azmszn+6NwEtdp3OJxdf2ylFGYc3mk9BSJALdJNpoX2y9
         RV2JDEAKvjgb58EVLIdtU5TzHoVpgx3APAJdO5/i7lib9Wf/ZOE3ot+kkNP0NyXIQRAN
         W+cQL4lKdBhieF0zmQNlyb9sVuLkVQcoeFupMCDuGqy44GxAs3whkYaOsIAu8QqjZMdi
         nKzz+RUNmfxtL632qKx9rz4+1lb7I0JP4wstGw25KP4rpWriR643hZsljwgCK/UaZYsI
         DccJwz81HUbsebS83IERqbEkD8zJYCao9m4D13Pjp0DtF0dFM+gLGInVZZHTRzQ0ucsE
         VOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659197; x=1729263997;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnC10CaG24WPSzLSNKOFOgGsi6jjDThxQwiyj7ue9sI=;
        b=G4dOaYQuax0wQH06/0d4Avy4CyXjapdVmAqcsJkbQktgtc6kRuYD3LopELfmAowDzu
         Pns8W4uG9NBswp/b3rV326GuPjobOVsN/Z7e5YaqqXXGEXjIAXS0Ij4jKYIC8HOU0lgS
         VAzkmnpdLS4Xx1CthPfFCZ+doBqHHSvAQbdzvxGArSzO6SVl+mx0Wwe82ZS3z+37dnPK
         3RMNZMXoEOvyk1fio20EEh/2o8C0HSA/2cSlrQwYfEnB6yc418yHpcamH342fOr7+LIj
         0Jt8YmaIleDVQQfjAlTC0Ss2sEKKV/ljmb5bsnoZU05csZmlFonNDQNJlsuPdEDA6NHM
         x+8g==
X-Gm-Message-State: AOJu0Yz1RYGN1kA1lETJQudhlxUrGovnAk3Dy4XUoErRSBJkG9x8pOpI
	lD0/xPPfVWyWbxG158ln3JR8UBtiW/wnwSokpDOyrqktigO6wm6w+V4a/NXDxek=
X-Google-Smtp-Source: AGHT+IECnKBqoOc7k/CFj4x1daaYO3nw/jGKlt/7w1KCslOD5pYHxmM8tu+9qFbNR8DtXOtxcoFVgw==
X-Received: by 2002:a2e:460a:0:b0:2fb:2f7c:28dd with SMTP id 38308e7fff4ca-2fb32740971mr12143731fa.18.1728659196758;
        Fri, 11 Oct 2024 08:06:36 -0700 (PDT)
Received: from localhost ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a82f3sm4138899f8f.24.2024.10.11.08.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:06:34 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: u-boot-amlogic@groups.io, Simon Glass <sjg@chromium.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, rockosov@gmail.com, kernel@salutedevices.com
Subject: Re: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print
 BCB block content
In-Reply-To: <20241011144519.xukl22ksrjsqz55l@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
 <CAFLszTh7qjUN__MvAbcMPL+W4V=mfBrgt9zcg8zyfx+WBN=9bg@mail.gmail.com>
 <20241009132614.mlkpfkdni4cp2tgg@CAB-WSD-L081021>
 <CAFLszTgr-qHXF2QU7toZXOU0FgRMPU0XXnQ6SzMq32a_pguAww@mail.gmail.com>
 <20241010102051.q67usj6oaykjaixx@CAB-WSD-L081021>
 <17FD1697482D61A4.19251@groups.io> <87bjzqhg7g.fsf@baylibre.com>
 <20241011144519.xukl22ksrjsqz55l@CAB-WSD-L081021>
Date: Fri, 11 Oct 2024 17:06:30 +0200
Message-ID: <8734l2he6h.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 15:06:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2446

On ven., oct. 11, 2024 at 17:45, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> Hello Mattijs,
>
> On Fri, Oct 11, 2024 at 04:22:43PM +0200, Mattijs Korpershoek wrote:
>> Hi Dmitry,
>> 
>> On jeu., oct. 10, 2024 at 14:17, "Mattijs Korpershoek via groups.io" <mkorpershoek=baylibre.com@groups.io> wrote:
>> 
>> [...]
>> 
>> >>> > >
>> >>> > > Reviewed-by: Simon Glass <sjg@chromium.org>
>> >>> > >
>> >>> > > Can you also update the test?
>> >>> >
>> >>> > I apologize, but I didn't quite understand your point. Could you please
>> >>> > clarify? This patch series includes additional tests for the 'ab_dump'
>> >>> > subcommand. For more details, please refer to:
>> >>> >
>> >>> > https://lore.kernel.org/all/20241008-android_ab_master-v3-6-f292c45a33e4@salutedevices.com/
>> >>> 
>> >>> OK, thank you. Sometimes it is easier (for reviewers) if you update
>> >>> the test in the same commit.
>> >>
>> >> Should I resend the patch series with ab_dump implementation and tests
>> >> in the same commit?
>> >>
>> >> I can prepare new version, if needed, no problem.
>> >
>> > No need to resend a new version just for this, since it's already
>> > been reviewed.
>> >
>> > Keep the suggestion in mind for future series!
>> 
>> If you do need to re-spin this as v4, you can squash the test commit
>> with this one if you wish.
>
> Of course, I can re-spin that.
> I believe I can save all RvB trailers during the squashing process.
> Could you please clarify if my understanding is correct? 

Yes, I believe your understanding is correct

>
> -- 
> Thank you,
> Dmitry

