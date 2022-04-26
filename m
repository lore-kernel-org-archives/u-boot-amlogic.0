Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web09.3398.1650957516983747044
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Apr 2022 00:18:37 -0700
Received: by mail-wm1-f51.google.com with SMTP id q20so10600660wmq.1
        for <u-boot-amlogic@groups.io>; Tue, 26 Apr 2022 00:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=j9/3x3pgne7jqu4cjIzZMBHx8sAfi63aF52xxmy2EIo=;
        b=yb2JiwZP1hxtaSbfRRmgCTfTP+3FxSpyDbYwdqmW3Yk3Wqhlq8qGcV6r1Nas6ZAycK
         MOd+h3pudr/u2XektSvICb/OhOAtBVu8UuajYyZop78vhiHgpkdWvbP9WSXzIseUKfza
         tF7Xy8KByzXsoK1aRHJZkKHSIuVQZ1SbhPrR0sIkqryGadAUmLvEHNyQyeikCAq2NMsv
         i/feEqDu4+8bfxaFeCunJy6xnnJMWuQET4GsI4nSu++Btqm9dJ26/Zt0zDlyaBMWIh9h
         UlPnMA9SXvCSzcAljQHXCjnqkqGw6ityXzdW8ji3p3NTadwYlBxDhHkZwjrJN42E8FLM
         scVQ==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <a62044d7-c10b-c0a4-3aa0-3834e5a9c68f@baylibre.com>
Date: Tue, 26 Apr 2022 09:18:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] doc: boards: amlogic: update documentation for ADC support for AXG
References: <20220426052633.3027932-1-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220426052633.3027932-1-adeep@lexina.in>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 26/04/2022 07:26, Vyacheslav Bocharov wrote:
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>   doc/board/amlogic/index.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
> index 9ef1440433..9c7fadf2c0 100644
> --- a/doc/board/amlogic/index.rst
> +++ b/doc/board/amlogic/index.rst
> @@ -55,7 +55,7 @@ This matrix concerns the actual source code version.
>   +-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+
>   | NAND                          | No        | No              | No           | No          | No         | No          | No           |
>   +-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+
> -| ADC                           | **Yes**   | **Yes**         | **Yes**      | No          | No         | No          | No           |
> +| ADC                           | **Yes**   | **Yes**         | **Yes**      | **Yes**     | No         | No          | No           |
>   +-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+
>   | CVBS Output                   | **Yes**   | **Yes**         | **Yes**      | *N/A*       | **Yes**    | **Yes**     | **Yes**      |
>   +-------------------------------+-----------+-----------------+--------------+-------------+------------+-------------+--------------+

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
