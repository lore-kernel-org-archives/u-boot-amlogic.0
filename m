Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D27AC79FA7
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 16:46:22 +0000 (UTC)
Received: from out28-135.mail.aliyun.com (out28-135.mail.aliyun.com [115.124.28.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.117042.1766566003800938746
 for <u-boot-amlogic@groups.io>;
 Wed, 24 Dec 2025 00:46:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@winmarketrresearch.com header.s=default header.b=qdxEfP2T;
 spf=pass (domain: winmarketrresearch.com, ip: 115.124.28.135, mailfrom: yilia@winmarketrresearch.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=winmarketrresearch.com; s=default;
	t=1766566002; h=Date:From:Message-ID:Subject:MIME-Version:Content-Type;
	bh=5Or+GNoAdR+hQVOMcG/sOFdbkodKIYIXZRvRnghVnxw=;
	b=qdxEfP2TjYTBAw9GeAmAa0ngZnIEpAmfrevInf+Yu9camwPK6owMChQJHHlzweH1GO8KeC9v8KWBvkFf0Wd4yR1YaVINACwO3R8tVMq5Emmr98eglg6SxQiy88yLNDcIHLajglb2luTTwZBBtZ4yN2Vv1qLLvV/rIwwLElTqWbtXC4hOe8uK/kJ+BZG0b+heg13CuYp+9nXCfrN/cCdYpAKBE0dlnUkl+mbeWoSGhFQIBIbL0+9JOJWtg7ZxWoF/QNUlbefk3SG8nave2dzVuRLCmTSntJFBBANVNdf9te4k9dHugFrGTqMLc/dp1XIi9lm/2kFm1qkzmowM0/hTVg==
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6659176|-1;BR=01201311R141b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_social|0.446397-0.0503819-0.503221;FP=14389688140051190843|4|2|451|0|-1|-1|-1;HT=maildocker-contentspam033037021130;MF=yilia@winmarketrresearch.com;NM=1;PH=DW;RN=138;RT=1;SR=0;TI=W4_0.2.3_v5ForWebDing_2125115E_1766564995853_o7001c167l;
Received: from WS-web (yilia@winmarketrresearch.com[W4_0.2.3_v5ForWebDing_2125115E_1766564995853_o7001c167l] cluster:ay29) at Wed, 24 Dec 2025 16:29:56 +0800
Date: Wed, 24 Dec 2025 16:29:56 +0800
From: "Yilia" <yilia@winmarketrresearch.com>
Cc: "VICXIN132" <VICXIN132@163.com>
Reply-To: "Yilia" <yilia@winmarketrresearch.com>
Message-ID: <96b45ed1-dc43-4e75-b152-cb2291daea50.yilia@winmarketrresearch.com>
Subject: Low Power AI Voice Processor Chip
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Chrome]
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_M3LTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzOS4wLjAuMCBTYWZhcmkvNTM3LjM2vN
To: u-boot-amlogic@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 05 Jan 2026 16:46:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2881

QSBDb21wYXJpc2lvbiBiZXR3ZWVuIFlvdXIgTG93IFBvd2VyIEFJIFZvaWNlIFByb2Nlc3NvciBD
aGlwIHRvIHlvdXIgQ29tcGV0aXRvcidzIChKVVNUIFJFTEVBU0VEKQpEZWFyIE1hZGFtIG9yIFNp
ciwKVGhpcyBpcyBYaW4gZnJvbSBWTVJlc2VhcmNoLiBXZSByZWNlbnRseSBwdWJsaXNoZWQgYSBu
ZXcgbWFya2V0IHJlc2VhcmNoIHJlcG9ydDoK44CKIEdsb2JhbCBMb3cgUG93ZXIgQUkgVm9pY2Ug
UHJvY2Vzc29yIENoaXAgTWFya2V0IFJlc2VhcmNoIFJlcG9ydCAyMDIwLTIwMzHjgIsKSWYgeW91
IGFyZSBpbnRlcmVzdGVkIGluIGdldHRpbmcgbW9yZSBkZXRhaWxzIG9yIHBsYWNpbmcgYW4gb3Jk
ZXIsIHBsZWFzZSBmZWVsIGZyZWUgdG8gY29udGFjdDogeGluQHZpY21hcmtldHJlc2VhcmNoLmNv
bSAuIEEgc2FtcGxlIHJlcG9ydCB3aWxsIGJlIHNlbnQgdG8geW91LgpUaGlzIHJlcG9ydCB3aWxs
IHdhbGsgeW91IHRocm91Z2ggdGhlIExvdyBQb3dlciBBSSBWb2ljZSBQcm9jZXNzb3IgQ2hpcCBt
YXJrZXQgZnJvbSB0aGUgZm9sbG93aW5nIGFzcGVjdHMgaW46IENvbnN1bXB0aW9uLCBTYWxlcywg
UmV2ZW51ZSwgUHJpY2UsIENvc3QsIEdyb3NzIE1hcmdpbiwgTWFya2V0IHNpemUsIE1hcmtldCBz
aGFyZSwgR3Jvd3RoIFJhdGUsIFRyZW5kcywgZXRjLiBUaGUgZm9sbG93aW5nIG1hbnVmYWN0dXJl
cnMgYXJlIGNvdmVyZWQgaW4gdGhpcyByZXBvcnQ6ClN5bnRpYW50CkFuYWxvZyBEZXZpY2VzClBP
TFlOIFRlY2hub2xvZ3kKRm9ydGVtZWRpYQpTeW5zZW5zZQpDaXJydXMgTG9naWMKTGVpbG9uZyBE
ZXZlbG9wbWVudApOYXRpb25hbGNoaXAgU2NpZW5jZSBhbmQgVGVjaG5vbG9neQpVbmlzb3VuZCBB
SSBUZWNobm9sb2d5CldheXRyb25pYwpOaW5lIENoaXAgRWxlY3Ryb24gU2NpZW5jZSAmIFRlY2hu
b2xvZ3kKQ2hpcEludGVsbGkKU3BhY2V0b3VjaCBUZWNobm9sb2d5CkFJU1RBUlRFSwpBSVNwZWVj
aApBbWxvZ2ljCkFjdGlvbnMgVGVjaG5vbG9neQpaaGljdW4gVGVjaG5vbG9neQouLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLgpNb3JlIGNvbXBhbmllcyB0aGF0IG5vdCBsaXN0ZWQgaGVyZSBh
cmUgYWxzbyBhdmFpbGFibGUuIFRoZSBzYW1wbGUganVzdCBsaXN0cyBwYXJ0IG9mIGNvbXBhbmll
cywgaWYgeW91IGFyZSBpbnRlcmVzdGluZyBpbiBvdGhlciBjb21wYW5pZXMgd2hpY2ggdGhlIHNh
bXBsZSBkb2Vzbid0IGluY2x1ZGUsIHBsZWFzZSBwcm92aWRlIHRoZSBsaXN0IHRvIHVzLCB3ZSBj
YW4gY292ZXJlZCBpdCBpbiB0aGUgZmluYWwgcmVwb3J0IGZvciB5b3UuCldpdGggY2hhcHRlcnMg
Y292ZXJpbmc6Ckdsb2JhbCBMb3cgUG93ZXIgQUkgVm9pY2UgUHJvY2Vzc29yIENoaXAgTWFya2V0
IENvbXBldGl0aW9uIGJ5IENvbXBhbnkKR2xvYmFsIExvdyBQb3dlciBBSSBWb2ljZSBQcm9jZXNz
b3IgQ2hpcCBNYXJrZXQgU2l6ZSBieSBBcHBsaWNhdGlvbgpLZXkgUmVnaW9ucyBNYXJrZXQgU2l6
ZSBTZWdtZW50IGJ5IFR5cGUKTWFya2V0IFN0cmF0ZWd5IEFuYWx5c2lzLCBEaXN0cmlidXRvcnMK
RWFjaCBvZiB0aGUgZm9sbG93aW5nIGNoYXB0ZXJzIG5vdCBsaXN0ZWQgaGVyZSBjb3ZlciB0aGUg
bWFudWZhY3R1cmVycyBsaXN0ZWQgYWJvdmUuIElmIHlvdSBoYXZlIGEgY3VzdG9tIHJlcXVpcmVt
ZW50LiBQbGVhc2UgY29udGFjdCB1cy4KTWF5YmUgaXQgd2lsbCBiZSBoZWxwZnVsIHRvIHRoZSBt
YXJrZXRpbmcgZGVwYXJ0bWVudCBvciB0aGUgcGVyc29uIGluIGNoYXJnZSBvZiB5b3VyIGNvbXBh
bnkuIFdlIHdvdWxkIGJlIGdyYXRlZnVsIGlmIHlvdSBjb3VsZCBmb3J3YXJkIGl0LgpUaGFuayB5
b3UgZm9yIHJlYWRpbmcuCkJlc3QgcmVnYXJkcyAvIE1pdCBmcmV1bmRsaWNoZW4gR3LDvMOfZW4g
LyDmraToh7TmlazmhI8sClhpbgo=

