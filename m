Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F8C4829F
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 08:45:54 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.22163.1706879211796799058
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Feb 2024 05:06:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=WeHGRTs6;
 spf=pass (domain: linaro.org, ip: 209.85.214.169, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d746856d85so15893145ad.0
        for <u-boot-amlogic@groups.io>; Fri, 02 Feb 2024 05:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706879211; x=1707484011; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIWKFZ/4450JPhylLYbfBEMghCwNKQs4YCs3cXu+m2M=;
        b=WeHGRTs6NeXO40+OJpGsNlw+oXR3VUIGhtsW1u0IJEDut7ocOrUPWzPDNyBtpkAhjI
         cXEB4z6iBHZb8l+AUOi4vTPhLJQKJKWVoeUpLY0iuOKqGA5exQLm/JoLPyv0hXJo2DLg
         xp54yyDSDSFNwtdlBObjw8mGCIBwR4emWlmpQin23PjtxzS28SsQxKIcF1Q5f0R/s0kZ
         uvSWZqZ97tAgDV1HOC2aAo1Fi9ogvus29HG4Lsvqgeq8AEw9JblIjlZ0rSGJs/e3esea
         6GHqX3bBe1Fy31WkDlHYPNE/ohOjQyYzWnAc7V1cVUA5FQEKbKQoLeTItm3S0hC/HJ6I
         hQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879211; x=1707484011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIWKFZ/4450JPhylLYbfBEMghCwNKQs4YCs3cXu+m2M=;
        b=loJpLoegSUSAN09DgtiVaI7OsjCwpaUS1MY6X7YqSzZ3rKHP2rrMjzTFD/ePs/Kc/p
         DRVEO8DIQhGlaN5Obl9mMorq2MvhCaLfFms/t3Qcm0npwAW9GeY59ah/mL7ubdrf3UOQ
         nUqT6DHjE5PRR6JzG0Up0UDq6aGciXOog8bE3vryDAfyi7eIOxLb+aoayT5cjtH/xyui
         Dcw/Is6L/3GLvlvjLB3tv86Grc3gY72pEzjRV3sUnaH7hATD/j0GRIHbx/Bi4nUcpXF7
         Q9m7MXYcS69OC8K+ktudn7xcYKpGn4wxiC9Wm9Vf6+NXVhtGiWpZxuyAUiig/4g7G9dQ
         KLAw==
X-Gm-Message-State: AOJu0Yw0LSriQzMV21qrnR5jrlw6vDa+889fZazMl9SOryR01lXGBUMa
	gwtBNLuGvG/ncQKszKq91CMztkM2xeP2euqtKPy1UbY+9TyKtJLkgTMPIpSUjWU=
X-Google-Smtp-Source: AGHT+IGS0pAicd2J0oWEZp6v7ZcLvBNiCpG2DOy8xHbZNXm2UbLixUV+PFGDvz7rJP0KiaYOzoi6mg==
X-Received: by 2002:a17:902:f545:b0:1d9:232d:4c1c with SMTP id h5-20020a170902f54500b001d9232d4c1cmr2418373plf.52.1706879211266;
        Fri, 02 Feb 2024 05:06:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX2EqLG43e+RV1Y5OIBc35XBwDkabQurHUKrnQjDF1MN7G9Y6RgjBzZDm6LaNc9+ZGSTaLI4iF4jM7DYbP/2jzmD1bAeTvqT664ApSxqcx/Ddt6GT22+RlNMHv0IWcDPq4/C2ycLlf6Q1Qh30TEOdBo5bHpy6RolRGzBtphFsVPXZBtzBov1+96SWV/hXQUIKusU8TQxtDLcNj98jRykOyPfrkYeYxrjUy9XZKC4dTss3NtbEr/IcouomhI99Z2M+tBvQbzpG/KnC49m64pKaz3mhe8eVLCJUa1b4iAssgSHEWItl22xSRszT1loac0p+TIksiyN4M0LY0NtjMJ1KQ4pBp5vQlwW0p7ILiG76nHuo9uFXrz3F2dvEjThAMHGdz1JCS95Hv5Z1ouLhX2XDnam5QD0IhGMnEcZIUp8zkm4PvcK1Rz3W1nMjwxrlyzNHgYjsTGjw2Ckc6T7E+4+CA1NNqAP+B24FJA5LvW7m1/YpKAyMJkPJb0zBM6nqQWfX3ZUdXYfrciyPyGFo8qAf9xeuIJ7PGPmSTtjQnEh40pxvNN5+RRatd4sIFIAgAAMVIrx8ZMr2D2LHMeCkWT5QK1ZJlF9+phbbnfW8F7mqk0ncmdh+jo+pRTPuWb/k4GiPMAgjAVbgw8u5gq9wgZw4/kbigPJvBGDGYq+AnWd8TaX3dYEiCFJFX43Z13iOnTD1bs60p43UzZ3TecGzMSaLrHvWpZRQkbVFk23OCWg+9f+taFzKbb92wRzvHMqPlqRZjdM39nIWmlzSbhno5TIRT576tint9FwpTb5cGWvwz/0hhDeVHb18P/XLPTo5X+nGbM1R8qtWUBFrwuWyrZHDYqltW/dzY3hr9xfpsvfBtpaSCRaL9X2mfaIFqsJBqAeSI7nLs8WhW5QrKMr5i//3V5QcuYXzDHsphn
Received: from sumit-X1.. ([223.178.213.44])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:06:50 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com,
	sjg@chromium.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	neil.armstrong@linaro.org,
	caleb.connolly@linaro.org,
	ff@shokubai.tech,
	daniel.thompson@linaro.org,
	dgilmore@fedoraproject.org,
	pbrobinson@gmail.com,
	ilias.apalodimas@linaro.org,
	b.galvani@gmail.com,
	xypron.glpk@gmx.de,
	michal.simek@amd.com,
	seanga2@gmail.com,
	rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com,
	jh80.chung@samsung.com,
	rfried.dev@gmail.com,
	marex@denx.de,
	mibodhi@gmail.com,
	bb@ti.com,
	mark.kettenis@xs4all.nl,
	festevam@gmail.com,
	nm@ti.com,
	andre.przywara@arm.com,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 06/11] dts: Add script to uprev dts/upstream subtree
Date: Fri,  2 Feb 2024 18:35:29 +0530
Message-Id: <20240202130534.1051438-7-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 05 Feb 2024 08:45:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2105

dts/update-dts-subtree.sh is just a wrapper around git subtree commands.
Usage from the top level U-Boot source tree, run:

$ ./dts/update-dts-subtree.sh pull <release-tag>
$ ./dts/update-dts-subtree.sh pick <commit-id>

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v5:
- Added support to cherry-pick fixes in subtree update script. Also, used
  https:// instead of git://.

Changes in v4:
- New patch to add script dts/update-dts-subtree.sh as per Rob's comments.

 dts/update-dts-subtree.sh | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 dts/update-dts-subtree.sh

diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
new file mode 100755
index 000000000000..b781bf710025
--- /dev/null
+++ b/dts/update-dts-subtree.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2024 Linaro Ltd.
+#
+# Usage: from the top level U-Boot source tree, run:
+# $ ./dts/update-dts-subtree.sh pull <release-tag>
+# $ ./dts/update-dts-subtree.sh pick <commit-id>
+#
+# The script will pull changes from devicetree-rebasing repo into U-Boot
+# as a subtree located as <U-Boot>/dts/upstream sub-directory. It will
+# automatically create a squash/merge commit listing the commits imported.
+
+set -e
+
+merge_commit_msg=$(cat << EOF
+Subtree merge tag '$2' of devicetree-rebasing repo [1] into dts/upstream
+
+[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
+EOF
+)
+
+remote_add() {
+    if ! git remote | grep -w devicetree-rebasing
+    then
+        git remote add devicetree-rebasing \
+            https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
+    fi
+    git fetch devicetree-rebasing master
+}
+
+if [ ! -z $1 ] && [ $1 = "pull" ]
+then
+    remote_add
+    git subtree pull --prefix dts/upstream devicetree-rebasing \
+        $2 --squash -m "${merge_commit_msg}"
+elif [ ! -z $1 ] && [ $1 = "pick" ]
+then
+    remote_add
+    git cherry-pick -x --strategy=subtree -Xsubtree=dts/upstream/ $2
+else
+    echo "usage: $0 param1 param2"
+    echo "  param1    pull or pick"
+    echo "  param2    release tag [pull] or commit id [pick]"
+fi
-- 
2.34.1


