Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web12.4369.1637296630785885120
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Nov 2021 20:37:10 -0800
Received: by mail-pf1-f171.google.com with SMTP id o4so8266630pfp.13
        for <u-boot-amlogic@groups.io>; Thu, 18 Nov 2021 20:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0zH3hY0XQAcafuLRq0CqQB4sltIDy4taFP06YKl4Z8U=;
        b=TQn416FkFvT0om2kWAw82ekrCNTCAHXh5XQHOtvD0l7hb67juedDhtseqkp1VeXrqA
         i2H2eQQsTb99qym0lh6bUKSQZDo9dvdgnL+t7mUD5K3os8DxCZHV/1Ga3DcwvgV1WLGq
         qjnQ/FWq9gsuKSQIVmQ9B1cXk2gl4W7+ZUuPXXSTlD/7M4qN/Vk8zHiQg/0+bHQKnYvq
         OhR8JibOTaaECMT/zVReEAdWLHsiW2vOPUe5NWE1CDZhhm14XsHtplLLnnbYWpjn/PD2
         FX+3ezNzV+YYkOtdgsIvQJc/05bnImg+iXte4NcBB2U6JqY4vVEYJxmRoNVqGG3+lBBY
         b34Q==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH v2 1/2] env: setenv add resolve value option
Date: Fri, 19 Nov 2021 12:36:46 +0800
Message-Id: <20211119043647.1251416-2-art@khadas.com>
In-Reply-To: <20211119043647.1251416-1-art@khadas.com>
References: <20211119043647.1251416-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: sjg@chromium.org
Cc: trini@konsulko.com, marek.behun@nic.cz, narmstrong@baylibre.com, twarren@nvidia.com, andre.przywara@arm.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, christianshewitt@gmail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Add possibility setup env variable with additional resolving vars inside
value.

Usage examples:

=> setenv a hello; setenv b world; setenv c '${a} ${b}'
=> setenv -r d '${c}! ${a}...'
=> printenv d
d=hello world! hello...

/* internal usage example */
env_resolve("d", "${c}! ${a}...");
/* d="hello world! hello..." */

Signed-off-by: Artem Lapkin <art@khadas.com>
---
V2 changes:
_ fix comments style
_ add comment include/exports.h
_ remake strcpy to strdup
_ env_resolve minimize
---
 cmd/nvedit.c       | 43 ++++++++++++++++++++++++++++++++++++++++++-
 include/_exports.h |  1 +
 include/env.h      | 11 +++++++++++
 include/exports.h  |  2 ++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 3bb6e764c0..6e1237df81 100644
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
@@ -291,6 +295,29 @@ static int _do_env_set(int flag, int argc, char *const argv[], int env_flag)
 	if (s != value)
 		*--s = '\0';
 
+	/* deep resolve value vars */
+	if (resolve) {
+		int max_loop = 32;
+		char value2[CONFIG_SYS_CBSIZE];
+		char *v = NULL;
+
+		do {
+			cli_simple_process_macros(value, value2, CONFIG_SYS_CBSIZE);
+
+			if (!strcmp(value, value2))
+				break;
+
+			v = strdup(value2);
+			if (!v) {
+				printf("## Can't allocate memory\n");
+				return 1;
+			}
+
+			free(value);
+			value = v;
+		} while (max_loop--);
+	}
+
 	e.key	= name;
 	e.data	= value;
 	hsearch_r(e, ENV_ENTER, &ep, &env_htab, env_flag);
@@ -304,6 +331,18 @@ static int _do_env_set(int flag, int argc, char *const argv[], int env_flag)
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
+	return _do_env_set(0, !varvalue || varvalue[0]  == '\0' ? 3 : 4,
+		(char * const *)argv, H_PROGRAMMATIC);
+}
+
 int env_set(const char *varname, const char *varvalue)
 {
 	const char * const argv[4] = { "setenv", varname, varvalue, NULL };
@@ -1371,7 +1410,9 @@ U_BOOT_CMD_COMPLETE(
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
index ee5e30d036..73d1aca9ac 100644
--- a/include/env.h
+++ b/include/env.h
@@ -133,6 +133,17 @@ int env_get_f(const char *name, char *buf, unsigned int len);
  */
 int env_get_yesno(const char *var);
 
+/**
+ * env_resolve() - resolve to environment variable
+ *
+ * Same as env_set but make deep resolve for value
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
index 550cafdc7a..02aac8047c 100644
--- a/include/exports.h
+++ b/include/exports.h
@@ -44,6 +44,8 @@ int vprintf(const char *, va_list);
 unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base);
 int strict_strtoul(const char *cp, unsigned int base, unsigned long *res);
 char *env_get(const char *name);
+/* deep resolve value to environment variable */
+int env_resolve(const char *varname, const char *value);
 int env_set(const char *varname, const char *value);
 long simple_strtol(const char *cp, char **endp, unsigned int base);
 int strcmp(const char *cs, const char *ct);
-- 
2.25.1

