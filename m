Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web12.4628.1616474182049500575
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Mar 2021 21:36:22 -0700
Received: by mail-qk1-f173.google.com with SMTP id c3so13137718qkc.5
        for <u-boot-amlogic@groups.io>; Mon, 22 Mar 2021 21:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=D67uM4K3dM2zyNyfNmY0pIYO9gYNy1uXxgJtqYytkJo=;
        b=eMlS962winhW3E6044MGcQHgMZZ4r2w44Ne+2j+P3h1wQM86G2UX9aTXnwrcQbWX/n
         QXM9Xrwtvyja+gInWx9Z7sQBwmFKcp70svEAyNwYwGL37fS+r7rirL6qjsRA1fDZgVcF
         H7SPLUzHwDWWb2f7y/oJr9TWRMTqWmZjo60Pf50JaqZlvf+tDjN1Fi5YcCzA8hwZV7vU
         XgMbdjJpRvsoPIUEU2j6LcziSxqlbg6E1eEkT1FoW57dMHynnpLRprzvH5s6vPaH8M3Q
         fLsL6VqLqo7I7yksrdAojH6Q6ZrG4fOa2BfuJTwffY6EDjBBvHsQUdRwCL8qX6kfzncr
         E1Qg==
MIME-Version: 1.0
From: Green Wan <green.wan@sifive.com>
Date: Tue, 23 Mar 2021 12:36:10 +0800
Message-ID: <CAJivOr7megRMZ+ESqRbRicuJVLC9X7F0DBeFh1bC7g0zdN21bg@mail.gmail.com>
Subject: Re: [PATCH RFT 0/4] pci: add common Designware PCIe functions and support Amlogic Meson PCIe controller
Content-Type: multipart/alternative; boundary="0000000000005b392c05be2cb94f"
To: U-Boot Mailing List <u-boot@lists.denx.de>, Neil Armstrong <narmstrong@baylibre.com>, "cc: Lokesh Vutla" <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, shawn.lin@rock-chips.com, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--0000000000005b392c05be2cb94f
Content-Type: text/plain; charset="UTF-8"

Hi Neil,

pcie_dw_common.* is a good starting point. I'd like to spend time on this.
Please add me into the loop. Thanks.

-
Green

--0000000000005b392c05be2cb94f
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Hi Neil,<br><br>

pcie_dw_common.* is a good starting point. I&#39;d like to spend time on this. Please add me into the loop. Thanks.<br><br>-<br>Green</div>

--0000000000005b392c05be2cb94f--
