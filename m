Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web12.3992.1611215085232449197
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Jan 2021 23:44:45 -0800
Received: by mail-pl1-f180.google.com with SMTP id g3so835602plp.2
        for <u-boot-amlogic@groups.io>; Wed, 20 Jan 2021 23:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqfDTav3dDBOAsLtJEmGPq2pDM+9FFhk5YmAvdhEmnU=;
        b=DOHJPSIsEh/6FeVXw9Jpnj7ElcjK8rjcCrLgJBziYkbx6mwGtBmxgmBD3PLcLBskjS
         XOEXCh3UTa7cdIs+HYngGopC5vmLVyn6VO/ZD0Ikf47F7NLkgVMgojxnb3qfOWrJAo8c
         UPxgiFrBmmGYKsdJX1utJBX00ZD9iZ8gugdZ7XWvWdA3jNNJjPfftRqmJe4KLXyW25Am
         7+fwVaGhXWPoWtvIN/IceWwzQkxbVq8KJ3hz6xOleglV8FF/mkvBg9oU6eRCL8pZaUwd
         OCtucYmMHJkTg9VD2j0pm4BZaPbTDNrXVhaHwgwoonevRsXAWNjpIkG3uSQTiL+dlPSu
         7cLQ==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH] cmd: pxe_utils: fix ipappend ip config empty vars
Date: Thu, 21 Jan 2021 15:44:35 +0800
Message-Id: <20210121074435.2754687-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

PROBLEM: If ipaddr, serverip, gatewayip or netmask variable undefined
we can have for example ip=192.168.2.33:<NULL>:192.168.2.1:255.255.255.0
yes its works same for linux kernel, but im think no need print <NULL>

SUGGESTED SOLUTION:
if some variable was undefined we need just print empty place like this
ip=192.168.2.33::192.168.2.1:255.255.255.0

Signed-off-by: Artem Lapkin <art@khadas.com>

---
 cmd/pxe_utils.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/pxe_utils.c b/cmd/pxe_utils.c
index 8716e782..2049c0f3 100644
--- a/cmd/pxe_utils.c
+++ b/cmd/pxe_utils.c
@@ -395,9 +395,12 @@ static int label_boot(struct cmd_tbl *cmdtp, struct pxe_label *label)
 	}
 
 	if (label->ipappend & 0x1) {
+		char *a = env_get("ipaddr");
+		char *b = env_get("serverip");
+		char *c = env_get("gatewayip");
+		char *d = env_get("netmask");
 		sprintf(ip_str, " ip=%s:%s:%s:%s",
-			env_get("ipaddr"), env_get("serverip"),
-			env_get("gatewayip"), env_get("netmask"));
+			a ? a : "", b ? b : "", c ? c : "", d ? d : "");
 	}
 
 #ifdef CONFIG_CMD_NET
-- 
2.25.1

