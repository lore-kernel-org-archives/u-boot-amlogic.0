Received: by mail-wr1-f48.google.com with SMTP id v13so9063441wrw.5
        for <u-boot-amlogic@groups.io>; Mon, 25 Feb 2019 01:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cLaoN5mtiEtU9xKz7dUlp2nVlpAIpG+Dsp0PML1uJMk=;
        b=XGfo14WIsm8fZuURjXTZBkFOZ4kF+bH8gsDUXVxW/qauuOjYqvW8xP9UMDCK5WVbPq
         k0cCui8TYN0npsKUSjlo6BE631KSyNJhW+JH6dvsxUtCp1A2UpTsRLEhiJijd5XDnmML
         Ysz6ii7aRXgAvJamOE0qVJ97hAoQPXAvkCnZbRTma+XwiE6TaFSwKO8Efvrh0kxyEMU8
         FiUIz4tLKW/8BOlmDrr3+ZjbQ7chH8YBvm5evwXVUoSnKIkB+kg9aD3xALaNde8GEkCP
         89pu4EYN/07DvsMbNgSXf/veLal/wknCu+hwYmOD6+ZXLVrTzncQCc2fRlNZ5LXg/AF1
         4C4A==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: Error in README.nanopi-k2 in mainline u-boot?
References: <CAJDSL=XkweEsJjzdjqJ6qXjpw7R1FdfEGbm9KqB+sefY--1ndQ@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <d2062adc-7733-9ae3-a7a4-36d9b4ad7abe@baylibre.com>
Date: Mon, 25 Feb 2019 10:32:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAJDSL=XkweEsJjzdjqJ6qXjpw7R1FdfEGbm9KqB+sefY--1ndQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Andr=c3=a9_Balsa?= <andrebalsa@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi André,

Only second checkout is needed

Can you send a fix to the u-boot mailing list for that ?

Neil


On 24/02/2019 07:51, André Balsa wrote:
> Hello,
> A quick introduction: André Derrick Balsa (AndrewDB), Linux hacker, trying to document step-by-step building u-boot for an Amlogic S905 SBC.
> On to the point of this mail:
> In mainline u-boot, in u-boot/board/amlogic/odroid-c2/README.nanopi-k2, in the instructions to build the fip dir, we can find two git clone commands in sequence and I believe one of them is redundant, but I don't dare say which:
> 
> git clone https://github.com/BayLibre/u-boot.git -b libretech-cc amlogic-u-boot
> 
> git clone https://github.com/friendlyarm/u-boot.git -b nanopi-k2-v2015.01 amlogic-u-boot
> 
> if executed in sequence the second git clone returns a fatal error:
> fatal: destination path 'amlogic-u-boot' already exists and is not an empty directory.
> 
> Thank you for taking any time for any answer on the subject.
> Best regards,
> AndrewDB



