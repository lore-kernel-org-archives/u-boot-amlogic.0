Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2398CC6B1F
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 09:20:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3317.1791885076421212934
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Oct 2026 02:51:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20260515 header.b=nnO+Ahvm;
 spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: mkorpershoek@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EEB69600D1;
	Tue, 13 Oct 2026 09:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319781F000FF;
	Tue, 13 Oct 2026 09:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791884690;
	bh=YX0v6coLzZMTjxH8asmNU0veahDytGWYu/rrEJJdSlU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nnO+Ahvm8Z2Y/zNtt658PsAlv/ec+POmkt+7sCMbTbTXP1IujaCpSiNWF0UAqfc1k
	 0U1yiSilx03cKRM45pbbCm7GUWLldLys9E1Pv+T7/fGW/3xdwKdjCAjGcS5Fua98ee
	 N7s/sYzrPy9556QiEyuXAPcIYC22U6gaoop36blZm7BpwghI6GrPkpUwkbcq9s9Mi6
	 1WSApEaYy+zs0leAORQh/OACx07gi56ZoslhkQdSaYGGJD9o+pUSqyJBlcnBSS1Or7
	 lghtuQoahdxQbBxtAWzy5JbhesoKw1cwPQhixGkshZ2kIvlSAiuUnHt5t+OsjYPOIP
	 S4ZT8om+6ZGeg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io,
 u-boot@lists.u-boot-project.org, Guillaume La Roque
 <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/4] configs: khadas-vim3: refresh Android support
In-Reply-To: <179146357781.183177.17223915816731601716.b4-ty@b4>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
 <179146357781.183177.17223915816731601716.b4-ty@b4>
Date: Tue, 13 Oct 2026 11:44:48 +0200
Message-ID: <xhkdb1p9u7x4f.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 14 Oct 2026 09:20:26 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3132

Hi Neil,

On Thu, Oct 08, 2026 at 14:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi,
>
> On Fri, 25 Sep 2026 15:42:23 +0200, Guillaume La Roque wrote:
>> Update VIM3 and VIM3L Android support to match the Android 16 AOSP
>> A/B images used by these Khadas development boards. Remove the unused
>> non-A/B defconfigs, increase the fastboot buffer to 512 MiB, update the
>> partition layout and correct the DTB indices in vendor_boot.
>> 
>> The layout follows the AOSP generic boot and vendor_boot model:
>> https://source.android.com/docs/core/architecture/partitions/generic-boot
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)
>
> [1/4] configs: khadas-vim3: drop non-A/B Android defconfigs
>       https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a2d0134bfc140b9b2092ab09cfef37a7da7c51ac
> [2/4] configs: khadas-vim3: enlarge the fastboot buffer
>       https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/349d13ce42f60dba1604accc3abb24d5f6afeb18
> [3/4] configs: khadas-vim3: update the Android partition layout
>       https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/09aee880eea6cf05e117988da1be8231b07c5bc0
> [4/4] configs: khadas-vim3: fix the Android DTB index
>       https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7a403d3db56db9f1efba44ed145e875c23fb785d

I see that the patches have been applied to git.u-boot-project.org [1]
but the b4 ty note still lists source.denx.de.

Can you consider updating your b4.thanks-treename and
b4.thanks-commit-url-mask so that it points the new instance?

FWIW, this is what I added to my ~/.gitconfig for DFU:

 [b4]
-    thanks-commit-url-mask = https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/%.40s
+    thanks-commit-url-mask = https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/%.40s
     thanks-am-template = /home/mkorpershoek/.dotfiles-private/u-boot-dfu/thanks-am-template
-    thanks-treename = https://source.denx.de/u-boot/custodians/u-boot-dfu
+    thanks-treename = https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu

Thanks!
Mattijs

[1] https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-amlogic/-/tree/u-boot-amlogic-next?ref_type=heads

>
> -- 
> Neil

