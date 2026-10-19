Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35176.1792418448102593231
 for <u-boot-amlogic@groups.io>;
 Mon, 19 Oct 2026 07:00:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=Jo9Ay7m6;
 spf=pass (domain: chromium.org, ip: 209.85.218.53, mailfrom: sjg@chromium.org)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c450ab1483cso83704166b.3
        for <u-boot-amlogic@groups.io>; Mon, 19 Oct 2026 07:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792418446; cv=none;
        d=google.com; s=arc-20260327;
        b=UfGIT+6Qg9uyiudu4+ZiLYxJQ1GiXCyAIqiTnyt1rx1+p/7/wxRRECykmaz1dO9tOT
         +UP34VAw59AUott50z2Jpt57IJ/4MTW95d7jbmv1pOVzhUHF/r9mnEXMObVHTLDVRzoB
         d4Zo29QNpaSGh5BWSta47zywE3QhO0oHpChyK3xQf/jPgJvHbVbHUgXeNCoNEY48bKVf
         F2HdW3hhu1jmWF/UltDmh8Vw8hzu8L18zOEI39wiXoS1kSWsRKuTDizKhMYJAm/mTHQa
         wRzpi/FBnUwzgGdK8KYYdzKtiPw5yc2u7ak4LR9s/bcDc3tmBBxlQIfRZJ6piZHedpQZ
         Dm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=CqbY2lbHeB5AwxRzqmhGm+nDvQ8qglA8lg7tQc3+1hw=;
        fh=Ddl6YlwkhzAPRFWoaiC9oyriQ7Foz8eOOENevOeZREk=;
        b=hJ8nUVxnK053qnjorC/kYCJli3itRfsw9hwgUH3FoqtMuIMRdycG502R9ilthpRSww
         Jm44i8OwQh3upp/v5lAn/LLT9OUtdH6bGBCwib2Iet8Ei1UXxEvjZu1O1ZZoUX0EiRJB
         gzCRCq/AW3cvsGELqKAuN6DtH1md64fvsW9OGNuoCawjbM3MJ12/kmrZU7PZPhVE8N8z
         V2wdyP1svYwiu0akqQgmp0fqnyBsc4cmeFdrouqQrIUyOT8nes+Ss6Zb3YW6SP5vAfL4
         SOcz32C6lkz2QuyIr5FGISKSWH2cKxB1bPskFn47gVIMXgxjBCKOZ7yqnRl1d0SF6HuM
         EzRg==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792418446; x=1793023246; darn=groups.io;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CqbY2lbHeB5AwxRzqmhGm+nDvQ8qglA8lg7tQc3+1hw=;
        b=Jo9Ay7m6WQsseGSHcP+9XDa8emTMY4EHVP4EyqiYk3tsxJxLNmSYW/r0CZwY5yW2QM
         V5LqPVgB9A8NlYy/ULrBHviBYrWDEV1IrWBOtsKv+ZsFWaZ24B4artUtHgdCmwWLl08C
         Lxey3VghAEvyVtor4eP8wVePfqJ9AUw/C3sJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792418446; x=1793023246;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CqbY2lbHeB5AwxRzqmhGm+nDvQ8qglA8lg7tQc3+1hw=;
        b=i9O8HyEqOik9j57dOyl8/RsCedlqMeRksP0dATFYo4nwfajZ1RpFDc+TEHhpjengVY
         oTf67AIa4lBpOX4iJXrZ0ZtJcqiTkwypDOeCMrYrFXUeUZN8jWIjxodJgPrDfaasCXxQ
         YWUFXmuIyJhE5va6F5Uh9Hfts+E58nxJFnN0ssbc9MExYfVJbVPKVSWtif28ogyF8X+4
         QU/8dakiI0u1tXyZ32kQNqu5S/pWcxRhs65fR2gGpwWfQAE8xdQJhPsY2h/9BWVWgSEb
         WRfMBwaWt8eJQ25KInt4oZhpEIqtxP3ldD9FarsxRkW83KrS54NQhnHRjIK5omoSqlGu
         Jswg==
X-Forwarded-Encrypted: i=1; AKwUvBwfEdE3BQhFF/0ak/jd11zGxTKj12gBmwzk1hdEb6s7hgViclDBvYzwc/GPvvC3RSfcfEkqOj3ehWXX41q2Jg==@groups.io
X-Gm-Message-State: AFq9FYK2ln5l5x5VBO5iRnQvVZh611ZpELodt1+zxTDjT53VWIQ4pLIY
	wUfZkb1oiLcTMycEUwzcWqpXGnuaNjX3PpdZ1vBtJ1VBr6RT1L3hmznNEmttiZpfwH34T6yHhu+
	cAlh6dcdnICLG3x3HpU8MkPPec0pemHOvDE4wIuRrhc+g0s2ilqOzlA==
X-Gm-Gg: AYBFou0Yn7Cjh9jROkDASWn0LhpWruOD4etOFotYmmFhGvPnSq6Na7J9W7vC8Xy3sWb
	XvcDh7c/77Agb1B8Azko8KSuLMW9+rafq36csQqf/sxp8tBOf5PPtR3dJhBIaO+h4VQmxdHl6xo
	mEZXkTRBgXCH8PvHYmt9LgXClIwdHiiH04CXrNO4PhUMkuGD1xZbnqh20n8CI94vyzAWq1JL2lo
	qn9wGZXXA2AgYP+Pl2aaUUIo2O+6C40n6r3b03UCOVN2kkY2MPmmjzWsK5Q/VdbSY0uASASJXeI
	Q0R7Vhht7t7iG9VDqhXHq+H1NUo8OtVtHvOkdgP2G12LDKVwOlXu7w==
X-Received: by 2002:a05:6402:4551:b0:6b1:b0f5:40e6 with SMTP id
 4fb4d7f45d1cf-6b3a818e3ecmr3554789a12.36.1792417954492; Mon, 19 Oct 2026
 06:52:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:52:31 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:52:29 -0700
MIME-Version: 1.0
from: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAAq9HC5oHhXKSEOkeWkvz7F6o9GuWt_Od6dbooZ8kMLFsbW-Eg@mail.gmail.com>
References: <20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com>
 <CAFLszTj7kB=JkLx1ws9QbKX682ZiYyy8LHJywzVq_pZnObbUQw@mail.gmail.com> <CAAq9HC5oHhXKSEOkeWkvz7F6o9GuWt_Od6dbooZ8kMLFsbW-Eg@mail.gmail.com>
Date: Mon, 19 Oct 2026 06:52:31 -0700
X-Gm-Features: AclHuK_S3Fxl5pfkshi2jbaQSyuqEfrdCqj0FbNMQDBlZObe0JKcA-N3fLhw_aY
Message-ID: <CAFLszTj_cjm9S=7UH_ggncMydYuCE-usOnh57iGuqMpcgZ9HYQ@mail.gmail.com>
Subject: Re: [PATCH] video: use bpp conversion helpers consistently
To: Reza Kurniawan <imkyufie@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org, 
	u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, 
	Anatolij Gustschin <ag.dev.uboot@gmail.com>, Eugen Hristev <ehristev@kernel.org>, 
	Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Andre Przywara <andre.przywara@arm.com>, 
	Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Tue, 20 Oct 2026 08:48:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3139

Hi Reza,

Reza Kurniawan <imkyufie@gmail.com> wrote:

> Is changing 1 << bpix appropriate in this case? Since bpix is already set to
> VNBITS(priv->bpix), that bit shift shouldn't be aimed at calculating the bits
> out of a log2 bpp. Should this be left out?

You are right, sorry, I misread that one. 'bpix' there is already in
bits (from VNBITS()), so VNBITS() does not apply. Please leave it out.

As an aside, '1 << bpix' in that debug() looks wrong anyway (for a
32bpp display it overflows), but that is a pre-existing bug and not
for this series.

Regards,
Simon
