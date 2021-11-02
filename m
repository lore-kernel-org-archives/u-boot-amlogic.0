Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web12.6093.1635837576260692638
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Nov 2021 00:19:36 -0700
Received: by mail-pl1-f182.google.com with SMTP id o14so4504765plg.5
        for <u-boot-amlogic@groups.io>; Tue, 02 Nov 2021 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y1oLocf3LQA7vYfRA+ROIdh39qncgv9jSckrQmIoaCQ=;
        b=BFjL7c2SRtaveBKeZpJXaPLvDQaMBdGxypYhnt+UQ5xZz1VBo4fEAr6X9XGQ4ofD+h
         P5eHBp04+Lvr50xL/8A6ciya0wjAWUaVkWHWgpgL+N8bs/2gCRbLJjfUkiP4YIIwIQ6U
         FwxnT94mNzF5BoHPewkAkSGMLGIWEyCHtt5XbVbA5YRnnWrTXChIgMV18tkzCoh0Ve1c
         89feq3VNxWJ8gYIKbwHZ6+YOlAVs5mqzh+oCf4CXW/Eb7tVNFQCrQuEsQqXE9pT3BslT
         ME2CtjKcxfd3pKJiULgh3RfyNa58L+hLeHTVYVQQU1r6oPaCGqLf7zIDDzrV2cY+9MPT
         ydkA==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH v1] env: setenv add resolve value option
Date: Tue,  2 Nov 2021 15:19:14 +0800
Message-Id: <20211102071914.696963-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: sjg@chromium.org
Cc: trini@konsulko.com, marek.behun@nic.cz, narmstrong@baylibre.com, twarren@nvidia.com, andre.przywara@arm.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Add possibility setup env variable with additional resolving vars inside
value.

Usage examples

=> setenv a hello
=> setenv b world
=> setenv c '${a} ${b}'
=> setenv -r d '${c}! ${a}...'
=> printenv d
d=hello world! hello...

/* internal usage example */
env_resolve("d", "${c}! ${a}...");
/* d="hello world! hello..." */

Notes

Resolving works only for ${var} "bracket" and didn't workd for
"unbracket" $var

=> setenv -r d '$c! $a...'
=> printenv d
d=$c! $a...

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 cmd/nvedit.c       | 42 +++++++++++++++++++++++++++++++++++++++++-
 include/_exports.h |  1 +
 include/env.h      | 11 +++++++++++
 include/exports.h  |  1 +
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 3bb6e764c0..6608932dc0 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -229,6 +229,7 @@ static int _do_env_set(int flag, int argc, char *const argv[], int env_flag)
 	int   i, len;
 	char  *name, *value, *s;
 	struct env_entry e, *ep;
+	bool  resolve = 0;
 
 	debug("Initial value for argc=%d\n", argc);
 
@@ -246,6 +247,9 @@ static int _do_env_set(int flag, int argc, char *const argv[], int env_flag)
 			case 'f':		/* force */
 				env_flag |= H_FORCE;
 				break;
+			case 'r':		/* resolve */
+				resolve = 1;
+				break;
 			default:
 				return CMD_RET_USAGE;
 			}
@@ -291,6 +295,26 @@ static int _do_env_set(int flag, int argc, char *const argv[], int env_flag)
 	if (s != value)
 		*--s = '\0';
 
+	/*
+	 * deep resolve value vars
+	 */
+	if (resolve) {
+		int max_loop = 32;
+		char value2[CONFIG_SYS_CBSIZE];
+
+		do {
+			cli_simple_process_macros(value, value2, CONFIG_SYS_CBSIZE);
+			if (!strcmp(value, value2))
+				break;
+			value = realloc(value, strlen(value2));
+			if (!value) {
+				printf("## Can't realloc %d bytes\n", len);
+				return 1;
+			}
+			strcpy(value, value2);
+		} while (max_loop--);
+	}
+
 	e.key	= name;
 	e.data	= value;
 	hsearch_r(e, ENV_ENTER, &ep, &env_htab, env_flag);
@@ -304,6 +328,20 @@ static int _do_env_set(int flag, int argc, char *const argv[], int env_flag)
 	return 0;
 }
 
+int env_resolve(const char *varname, const char *varvalue)
+{
+	const char * const argv[5] = { "setenv", "-r", varname, varvalue, NULL };
+
+	/* before import into hashtable */
+	if (!(gd->flags & GD_FLG_ENV_READY))
+		return 1;
+
+	if (!varvalue || varvalue[0] == '\0')
+		return _do_env_set(0, 3, (char * const *)argv, H_PROGRAMMATIC);
+	else
+		return _do_env_set(0, 4, (char * const *)argv, H_PROGRAMMATIC);
+}
+
 int env_set(const char *varname, const char *varvalue)
 {
 	const char * const argv[4] = { "setenv", varname, varvalue, NULL };
@@ -1371,7 +1409,9 @@ U_BOOT_CMD_COMPLETE(
 	"setenv [-f] name value ...\n"
 	"    - [forcibly] set environment variable 'name' to 'value ...'\n"
 	"setenv [-f] name\n"
-	"    - [forcibly] delete environment variable 'name'",
+	"    - [forcibly] delete environment variable 'name'\n"
+	"setenv [-r] name value ...\n"
+	"    - [resolve] resolve 'value ...' to environment variable\n",
 	var_complete
 );
 
diff --git a/include/_exports.h b/include/_exports.h
index 8030d70c0b..86bc07f051 100644
--- a/include/_exports.h
+++ b/include/_exports.h
@@ -32,6 +32,7 @@
 	EXPORT_FUNC(do_reset, int, do_reset, struct cmd_tbl *,
 		    int , int , char * const [])
 	EXPORT_FUNC(env_get, char  *, env_get, const char*)
+	EXPORT_FUNC(env_resolve, int, env_resolve, const char *, const char *)
 	EXPORT_FUNC(env_set, int, env_set, const char *, const char *)
 	EXPORT_FUNC(simple_strtoul, unsigned long, simple_strtoul,
 		    const char *, char **, unsigned int)
diff --git a/include/env.h b/include/env.h
index ee5e30d036..c4efc5b7e5 100644
--- a/include/env.h
+++ b/include/env.h
@@ -133,6 +133,17 @@ int env_get_f(const char *name, char *buf, unsigned int len);
  */
 int env_get_yesno(const char *var);
 
+/**
+ * env_resolve() - resolve to environment variable
+ *
+ * Same as env_set but make deep resolve for variable
+ *
+ * @varname: Variable to adjust
+ * @value: Value to resolve for the variable, or NULL or "" to delete the variable
+ * @return 0 if OK, 1 on error
+ */
+int env_resolve(const char *varname, const char *value);
+
 /**
  * env_set() - set an environment variable
  *
diff --git a/include/exports.h b/include/exports.h
index 550cafdc7a..a54b997988 100644
--- a/include/exports.h
+++ b/include/exports.h
@@ -44,6 +44,7 @@ int vprintf(const char *, va_list);
 unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base);
 int strict_strtoul(const char *cp, unsigned int base, unsigned long *res);
 char *env_get(const char *name);
+int env_resolve(const char *varname, const char *value);
 int env_set(const char *varname, const char *value);
 long simple_strtol(const char *cp, char **endp, unsigned int base);
 int strcmp(const char *cs, const char *ct);
-- 
2.25.1

