Received: from mx.msync.work (mx.msync.work [95.217.65.204])
 by mx.groups.io with SMTP id smtpd.web08.8329.1632121580666044332
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Sep 2021 00:06:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1632121578; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:
	 disposition-notification-to; bh=AzM7UpvUH30vhPUDWFJP2Map8jVbggPHKffJ8J73/+E=;
	b=nktRgIDolXzf037nc+H7VO8HB72/KbKeg9i1kGDggkaQD06PYEccXfWozT1IAsoCrflTDU
	Ooddwr5j1gKsqWKuqcfb/tHaFYJLZsMxmfcgHV0d6Fc3s/4tojTv25fyhfikcQNqI58BiD
	0ui+EQJlaz0mlo5PQFRBUd2GQL2R+OKp0YlzjyB/qBkMfk+S+yBSIaGsJNOvTLKcvdwTBG
	E/90oQUQ2TnbFCTQC6WT7K20x/bsWD9eahn54uLFv+5CfbumuDZ9UE1KsPpVHAr6dOraSV
	5p9qOmSMHxUfHmlI1UXmkLYk9V/jfqGjO1BfX2gsplHCQ0F9sXLcFZFtJX+SAA==
Subject: Re: [PATCH v2 2/3] ARM: amlogic: add JetHub D1/H1 device support
References: <20210919155216.4000369-1-adeep@lexina.in>
 <20210919155216.4000369-3-adeep@lexina.in>
 <4ef4798b-33a3-76f9-f4a7-83ec7e4b893a@baylibre.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Message-ID: <a6c09812-c63a-d0dd-37e7-d59ccf4e174f@lexina.in>
Date: Mon, 20 Sep 2021 10:06:15 +0300
MIME-Version: 1.0
In-Reply-To: <4ef4798b-33a3-76f9-f4a7-83ec7e4b893a@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

20.09.2021 09:43, Neil Armstrong wrote:
> Hi,
> 
> On 19/09/2021 17:52, Vyacheslav Bocharov wrote:
>> Add support for new home automation devices.
> 
> While applying I had a few warnings:
> 
>> +	if (!env_get("serial")) {
>> +		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
> 
> ERROR: trailing whitespace
> #777: FILE: board/amlogic/jethub-j80/jethub-j80.c:48:
> +^I^Ilen = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial, $
> 
> CHECK: Alignment should match open parenthesis
> #778: FILE: board/amlogic/jethub-j80/jethub-j80.c:49:
> +		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
> +			EFUSE_SN_SIZE);
> 
> CHECK: Alignment should match open parenthesis
> #785: FILE: board/amlogic/jethub-j80/jethub-j80.c:56:
> +		len = meson_sm_read_efuse(EFUSE_USID_OFFSET, usid,
> +			EFUSE_USID_SIZE);

I'll double-check everything and resend a new version of the patches.

> 
> This file isn't part of any MAINTAINERS file, either add it to the s400 one or the j80 one.

I'll add it to jethub-j80/MAINTAINERS.

Thanks!


