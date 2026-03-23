Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637B2E9A747
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:24:15 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13421.1774329432946076767
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Mar 2026 22:17:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mailbox.org header.s=mail20150812 header.b=YbMAPmm+;
 dkim=pass header.i=@mailbox.org header.s=mail20150812 header.b=m2W7T3qO;
 spf=pass (domain: mailbox.org, ip: 80.241.56.151, mailfrom: marek.vasut@mailbox.org)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ffymG1G6Nz9tVP;
	Tue, 24 Mar 2026 06:10:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774329038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeBpXq998F+Il6SGSNqyhvQOWewItovfYlB6eObyoeU=;
	b=YbMAPmm+SgUaArncWHA+yBoBBMg366Rh1elh1yMRJx1WNZhZINfNeNixYhzNlD9WSpI8mn
	Ne0op2+wujUlVp7nb4APq+Mg2sNwlETrfsZjlyTYWakycNCcW10aXK2rC22c3tetoQQhFj
	UqZIxKRipVm+PilbOeGyLPvxm8rAb7PQbZWwyzKLYDMiu6REKTIASQHsCnsH1U6SlcMTSh
	Ox8sVK9VtPGM2Bl7rmipnIcpKWmselJXYcWk7gOcMVxZGBxSCkmZQ+dNC67zpvmXVWpbxQ
	Tt4POXVKopqtKGNXDcJNVnyFIQTJcLDFZNv8vchPnlCHqCMrtHkPcgfhs4AIMQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=m2W7T3qO;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <ef7c8db3-0df8-4d32-983f-4b2dd81b298e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774329036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeBpXq998F+Il6SGSNqyhvQOWewItovfYlB6eObyoeU=;
	b=m2W7T3qOL6rMsc54QvYEVJYZpx0TASRHHkXJqFQ/l1z8TH0KuM97qdBkPFUmj0X8PnbJu2
	w2g0IBzmkrleHlaBydJelz/PKTH+uAPi9mlamARxrdUMiWugpZqaPHgN03UwrOl+tXf6pU
	hOFXCN6TRF2+fz0uOjHhABib2tP1DxgVky3NWLdyop5guOw5jeHOfLf59A7A/MH1PQkS78
	+gJZlt107lHyyk/LNyyYt8GugmFDHMDPUKZfGXbum8J7smMnjuXmk+/2TORApIcIt5jRm8
	J2CAVQa8CX5g7YUP5aj15Dusxo+A11lzvdDgb1zwRlHcjyd+Z6fSzOIC+cP5KQ==
Date: Tue, 24 Mar 2026 00:28:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] global: Correct duplicate U_BOOT_DRIVER entry names
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Bin Meng
 <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, =?UTF-8?Q?=C5=81ukasz_Majewski?=
 <lukma@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot-qcom@groups.io,
 linux@analog.com
References: <20260323225537.896180-1-trini@konsulko.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260323225537.896180-1-trini@konsulko.com>
X-MBO-RS-ID: 7e33b08a627f9a9c824
X-MBO-RS-META: xznd7cphsqw5tc6zx1y3htxqroquz93o
X-Rspamd-Queue-Id: 4ffymG1G6Nz9tVP
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 24 Mar 2026 09:24:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2936


[...]

> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index 41d15996e5b2..49e9c3fa0e99 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -533,7 +533,7 @@ static const struct udevice_id dwc3_meson_g12a_ids[] = {
>   	{ }
>   };
>   
> -U_BOOT_DRIVER(dwc3_generic_wrapper) = {
> +U_BOOT_DRIVER(dwc3_meson_g12a) = {

Could you please add usb_ as a prefix in front those usb drivers ?

Either way, for the USB part:

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

Thanks !

