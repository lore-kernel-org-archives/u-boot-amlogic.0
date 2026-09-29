Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A7FCA5FB3
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 18:07:35 +0000 (UTC)
Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2909.1790705247736259143
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Sep 2026 11:07:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=UAm/Senf;
 spf=pass (domain: brivo.com, ip: 74.125.230.233, mailfrom: sanderson@brivo.com)
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93c599e3902so382091885a.2
        for <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790705247; x=1791310047; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kSYQQOCi1xowosfn9KKr1ki0SDcyOhl4Y+cIQKX0L2Y=;
        b=UAm/SenfgUsGNxHxMV6ZpxscLQ2/dU865Vfh0dIqQzWR60oTQEMyZNJ5vKvej/niDn
         R++g32G0CTxsA/Iabt3aFTixK2u79SyP4Y1oSYwf1X6DmjFSDwCHHNrwOkNNt24VtXpH
         H7yrISL6rgM8TmG2GkQmsMXhNSTGwzya8rGvTSzaXcDBr/RrUfls8DwpO/AtVU7s/qyO
         n2psELWeMbB+oENGH2UZPneMkE+TU5J/5EOgsV+PHmRRdk+tT0HorfDn6Fz6gbQMhn6K
         rjdYSppXG3+dxZK6X6SMsBvYEqannFVK+JjI87fcd/TzUi4Mf7oKTV6rWCW0AV6USeYw
         F/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705247; x=1791310047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kSYQQOCi1xowosfn9KKr1ki0SDcyOhl4Y+cIQKX0L2Y=;
        b=gLu4sykKT95zCqdM182mkqUfroO4Jie8xx5JOtSSIfubKYutbux8/4bFOB0YhRemJC
         EYKesDNERbBGwgTDwAEjwR6Tl0MDirxCNMce0W2rLiqiKR4ts45eZAxaRnfdHnfmardT
         7TdZdJp0UKkiMqhpsZn8OUjZXImufQW+tML88u4nM3S26whdq3MJjX+4Pc/Dj+LvEJ9S
         +uDwmWF4ZSkUMICoTKYfdbR3XCAvdgWUSnYci7eGW6n5NmWteoaWKxJeAE4WMjCe4IDR
         j7HsgDp0f3XxcAtJBZ5/3rAcgI8Brk0Tzne4VBM7NkJT3yXJMH3pPLHteEcu4SYNMC9Z
         JCOg==
X-Gm-Message-State: AFuF++mL2nYGuEv4ZNlT/gV1wiD1+44Ghy81gbMYovY6lhh/5tUwIceU
	gmN6qRsUKesFa8v66vCr9T6VXoGPgK5HdTx0H5NT5vVnZfC0h2szStxhl8ymNs+9AmRmH8NzD6E
	fdub4lJAccka414SqM8AnmV5BCzY7vkw0y7S+u8Nn8SDUm1lGj2xxYw==
X-Gm-Gg: AYBFou1VgpJer/ncAVrS1PIHaS9u2QhYezuvDqEtZOM+GIdDFj4KHhlvbegWM01g4Y2
	cPhVmODK4LeGxTngFKI8Kqjn5yT64M/wrjvM7ZpjsDuoJYZIKTDbkg7YwqjVc22utNSfg21Gm8Z
	oQzxEb8vvRKs+z2ISVrnFn7LzciX/LX87a70o5yoi2RGJxK0S7tnHxh3bM2fSsTQbx6dWFYOtMS
	Xlrhp+dbDjD7EnTv59gTryzBoMsgaAC+cnol0RtWuEX/0p6x46ZqgWFtmvg37BaQG7YGe0MkdKx
	zQKlGx8Sz2FBxNPCTserRqFbVi91KVjRIfTK3/7PfFBxp1KlDLkFg/+YdnmOlEMTuinXOTPzvaI
	yPBuokbgez+DdjOPRBXtdm2qsSuQk81+D9LVbLQk0IwDR1hS9klk1O2ohIKTeVYmLONT0RsSVCt
	kPejHckhgl5lvaMRUvY/v19frpdHtuGNW6z26HI7ho0MgAmZiZTsWjr3I6nooUBzMP
X-Received: by 2002:a05:620a:4081:b0:939:a003:7127 with SMTP id af79cd13be357-93c9fc0822bmr61083785a.52.1790705246358;
        Tue, 29 Sep 2026 11:07:26 -0700 (PDT)
Received: from strozzi ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:07:26 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 3/9] clk: meson: a1: Use clk_set_rate from meson_mux_set_rate
Date: Tue, 29 Sep 2026 14:06:25 -0400
Message-ID: <20260929180721.3440839-4-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 18:07:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3106

This function is useful for other drivers, but it's tied to the a1's
meson_mux_set_rate implementation. Convert it to use clk_set_rate so
the drivers's set_rate implementation will be used (no matter what it
is).

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

 drivers/clk/meson/a1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index d0376663069..422cdf5f4d1 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -523,8 +523,6 @@ static ulong meson_composite_set_rate(struct clk *clk, ulong rate)
 	return 0;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate);
-
 static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
 {
 	int i;
@@ -542,7 +540,7 @@ static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
 			.id = info->parents[i],
 		};
 
-		ret = meson_clk_set_rate(&parent, rate);
+		ret = clk_set_rate(&parent, rate);
 		if (!ret) {
 			SET_PARM_VALUE(priv, info->parm, i);
 			break;
-- 
2.53.0


