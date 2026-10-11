Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A52CA9ED0
	for <webhook@archiver.kernel.org>; Mon, 12 Oct 2026 09:35:17 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3119.1791762148000299527
 for <u-boot-amlogic@groups.io>;
 Sun, 11 Oct 2026 16:42:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=IkrUT5F5;
 spf=pass (domain: gmail.com, ip: 209.85.167.179, mailfrom: imkyufie@gmail.com)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4e4a4d77e5bso1963628b6e.0
        for <u-boot-amlogic@groups.io>; Sun, 11 Oct 2026 16:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791762147; cv=none;
        d=google.com; s=arc-20260327;
        b=oC5C2kXYClBhWhKY685ElvWyXDxS/0qwef7+Jcr7C6f78L8Tmb4f93MAQE3mgiMdja
         ULq9XeHRtBOEgyO9JXaxeTEXV0lXafniDqI43xq5WEwgZjUU47eO8DDyIr0EYn0wks7o
         A3+6nKq1Wa9i7CHVmbvadbchxAKDWZ/1MpvJoLaixjL0ntXe0+Tqedq7iw2hK7W4g9pH
         BGJmR2V8K+rM1GHb/3EJAS1h+PaLdNe6JxjCd3Gzaie1CySFt1phw2WtKqZCrJEUVMI/
         sRq6Mxp3CdHkqY5LFCCCKJPAFTqPkvE0j9tyTiAckDxyFPKYk0GBOj7nHMUV8f9xaEeD
         8WPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b//LNHyzozc43+1ywcj2GCgynY7KVJ1ZK7vozmI+TB4=;
        fh=fw1cHuElIESaZl4OKpsxM5bNN+2Aj+0y0Ut1+lSoj54=;
        b=K2I/ysUWwpsY1rPVRxFipGIbCXPapSxmedez9vaFmJQIaJYHlv5cEdbuWuhLakKwX5
         1rWh0y/70z4SnfyORhxXhxervOCLEa8djAVGIpSMRy11rWeIf+8xRiAcnpl32hgqicWA
         CjgoNkIb9SBXd8kvqUyasjxl5emDSPI1qmuOgx+BxYRtc3TM1K+Dvsvq/ZWMS7brHv7P
         YI5FpxVxQ6Wzzmf3BuR9dXqOKWkadRhXwTel5g7RuNQr7f3dGI2Rns/jeoIATPjAMZib
         lICVsDGvgnn6tnhYbM/CNJFV1d7L5moDJHYIUkpkW/bwihTLT3X3UrOvOG8338a2nxEC
         HHBw==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791762147; x=1792366947; darn=groups.io;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b//LNHyzozc43+1ywcj2GCgynY7KVJ1ZK7vozmI+TB4=;
        b=IkrUT5F5/sVdm1S9ock0H7WdkOuySBxAnYiKwOlJ4/8Yn3CSW0IpNPFrI3yq1iOdCN
         J4YuC6Ct40rRTmwIxtyaxoCpfA47TAleK8DqnBX7MBV0S27XmRFxi3mPciNjrSSCbF9M
         MyWTxuqE8EetwA1+0t05rg3+1xV+j7JSy3gxuSmo70YwjVO9hGDvlpEdJYy+iskPtPhp
         z3nTFX+Z+2+EOYglbwwaWckt26f9EibzWqU/jvpi1abkVnxXbBRL8tZvoi614DCggYG1
         Rkti8T0DGscHV4wYkV8zZf4ScN+HFFXfadIHIUqx6NddWy3vLDWcAT7DbOohc4tkh8Vv
         Tpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791762147; x=1792366947;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b//LNHyzozc43+1ywcj2GCgynY7KVJ1ZK7vozmI+TB4=;
        b=zeQC8zXiEZJGDjSqRFlqROcJpewuDq17ySmZzvflSMXxqFseWYeXT6nnarry/tF6Rf
         viPtp4bJrphWQ3ai6o/CbSkGB5f7VR8N5R03Z6LB6vfxHJAJMUp0DRd7+GMu9vUH6SyF
         bmYGvJBiW7CPUXvWW1aedA7xLr8mU5zyWDXQRaFIuCj2zxqinNNeEsXqoNVEq69/aObe
         M3J0OXj00Zn+h62HMRq6TnN9Pas18lwoJYAKbnpArO5yKLevniLEhwOAWRYYnd5vn/mn
         WNvmP5kEvSSy56izTGFXWrzNJkaxyrDpbTooAoQSiUo35UIEkNgJwjao+1tRCgx3vOIP
         1pzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpoG9AW+rAanGsuKYOrnyq6jg8SdNeu1i8ta9g+dlj3bemN/ehoyyJAcivFDIINtqtFaEwRVy3pagXpfYOww==@groups.io
X-Gm-Message-State: AFq9FYKYvwjLduaL4WfJuDV03ytJtt3c1pxFv+LJ2BFnGcw+JXPDCNEG
	nt0dsz8ZslKwX1WaxW7aAZk14z3S3GUitidD5xa0r5+P6Ym3NQ1Zsrzyr4kGw8MSBuiXfuES2T8
	DshrLpZszEu5NBo8O5Lg8oyaQG5ywOWK/DTfn
X-Gm-Gg: AYBFou1aOxCbjn/efO4MwfP7T62yMiSBzGSgcHgsQelcJd4VN456e8lUHolwgxCXE68
	3nkAFIbRG/nLc61vjK1oU8oA5UDK5s4PvV13P7Ycpu/m1qJPqWSQvAX1rMfFWBatEQ0hN0e8E3V
	r0YtvMnUty/0Y9tVDbU72DqPsDUZHIEOgRNOXWFKbFJNp6UYdeo78CDWP6eVRx374qSPBqR1W/Z
	w91V67iwmvHkOVmMwjjGELYOrGjWGIntwWCKSZL7ED93z4374PshepccreOfmAh7lGxcqdy9y7J
	p+SqKxUnfyhKfJS92iwDGMYuc6KcDBqfcAQ2ZKIuXShUGbslkbS/8RKyLCV8zXDK8TjpA/vIqKE
	lZBRbXVbfdmU=
X-Received: by 2002:a05:701b:4510:20b0:15b:1439:1fcb with SMTP id
 a92af1059eb24-16a5b979b4bmr10870896c88.10.1791761715518; Sun, 11 Oct 2026
 16:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com> <CAFLszTj7kB=JkLx1ws9QbKX682ZiYyy8LHJywzVq_pZnObbUQw@mail.gmail.com>
In-Reply-To: <CAFLszTj7kB=JkLx1ws9QbKX682ZiYyy8LHJywzVq_pZnObbUQw@mail.gmail.com>
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Mon, 12 Oct 2026 06:35:02 +0700
X-Gm-Features: AclHuK_mgmJiIMIAVnrIVjikI6ge8eMwSbDGI1cj_bCvvb6ejuzvwgchPF3K2BQ
Message-ID: <CAAq9HC5oHhXKSEOkeWkvz7F6o9GuWt_Od6dbooZ8kMLFsbW-Eg@mail.gmail.com>
Subject: Re: [PATCH] video: use bpp conversion helpers consistently
To: Simon Glass <sjg@chromium.org>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org, 
	u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, 
	Anatolij Gustschin <ag.dev.uboot@gmail.com>, Eugen Hristev <ehristev@kernel.org>, 
	Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Andre Przywara <andre.przywara@arm.com>, 
	Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 12 Oct 2026 09:35:17 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3128

Hi Simon,

On Sun, Oct 11, 2026 at 11:09=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Reza,
>
> On 2026-10-08T13:51:38, Reza Kurniawan <imkyufie@gmail.com> wrote:
> > video: use bpp conversion helpers consistently
> >
> > Use bpp conversion helpers for consistency and to reduce the
> > reliance on the specially crafted VIDEO_BPP* enum values. No
> > functional change is made.
>
> Thanks for doing this!
>
> Please can you name the helpers here (VNBYTES() and VNBITS() from
> video.h)? It would also help to say that VNBYTES() is only correct for
> 8bpp and above, and that every site converted here is 16bpp or 32bpp,
> which is why there is no functional change.
>
> >
> > Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> >
> > cmd/bdinfo.c                           | 2 +-
> >  drivers/video/atmel_hlcdfb.c           | 2 +-
> >  drivers/video/imx/mxc_ipuv3_fb.c       | 2 +-
> >  drivers/video/meson/meson_vpu.c        | 4 ++--
> >  drivers/video/mvebu_lcd.c              | 2 +-
> >  drivers/video/sunxi/sunxi_de2.c        | 2 +-
> >  drivers/video/tegra/dc.c               | 4 ++--
> >  drivers/video/tegra/tegra124/display.c | 2 +-
> >  drivers/video/ti/tilcdc.c              | 4 ++--
> >  drivers/video/tidss/tidss_drv.c        | 4 ++--
> >  test/cmd/bdinfo.c                      | 2 +-
> >  11 files changed, 15 insertions(+), 15 deletions(-)
>
> > diff --git a/drivers/video/atmel_hlcdfb.c b/drivers/video/atmel_hlcdfb.=
c
> > @@ -315,7 +315,7 @@ static int atmel_hlcdc_bind(struct udevice *dev)
> >       uc_plat->size =3D LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
> > -                             (1 << LCD_MAX_LOG2_BPP) / 8;
> > +                             VNBYTES(LCD_MAX_LOG2_BPP);
>
> The subject says 'consistently', but a few sites are not converted.
> atmel_fb_lcd_bind() in drivers/video/atmel_lcdfb.c has exactly the
> same pattern:

Thanks for pointing that out, I did miss some of them. I'll try to
look for more.

>
>     uc_plat->size =3D LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
>             (1 << VIDEO_BPP16) / 8;
>
> The others I spotted:
>
>     drivers/video/sunxi/sunxi_de2.c:221  (1 << l2bpp) / 8
> (efi_add_memory_map() size)
>     boot/fdt_simplefb.c:62               xsize * (1 << bpix) / 8
>     drivers/video/video_bmp.c:322        1 << bpix             (VNBITS())

Is changing 1 << bpix appropriate in this case? Since bpix is already set t=
o
VNBITS(priv->bpix), that bit shift shouldn't be aimed at calculating the bi=
ts
out of a log2 bpp. Should this be left out?

>
> Please can you convert these too, or say in the commit message why
> they are left out?
>
> Regards,
> Simon

Best regards,
Reza Kurniawan

