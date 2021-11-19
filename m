Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.4306.1637296634950692261
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Nov 2021 20:37:15 -0800
Received: by mail-pj1-f54.google.com with SMTP id iq11so6964785pjb.3
        for <u-boot-amlogic@groups.io>; Thu, 18 Nov 2021 20:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oWIQAurGs5E6Bydg2I0nNQODWE3G8Lo0ZmBrnUmi2Zo=;
        b=FxEdTEV+1Tgn/qvfBkrV8AD2d6JgIX2g3m6jugmEENjywmOqVNWiHkiR0/5o4FxioS
         ftBhNWmPbSGZYhT0G1915PY17aJ5iNen+T6yenBP16aHWiohLrmOvS50cDhUaDCa/oaB
         W4UGWSWmVMDLXO+7iFtqEL3cJg2bES/MLS+SdVRnJryS8nS6a+vwAelzY3qhvBKNZO0k
         Q9bPVRSPoJ9Cd36zBspC/tZlpB9l0fzwhFIdRc0ShqGXHV78yZrffhNOjelCMYRZpMvw
         GwGdDboGMZSPk1vw5ovpELtqitPzdy9dq28IlsSkCmaYRXWhgUiSquCUu17XrDg7F0TJ
         KygA==
Return-Path: <email2tema@gmail.com>
From: Artem Lapkin <email2tema@gmail.com>
Subject: [PATCH v2 2/2] test: env: deep resolve value testing
Date: Fri, 19 Nov 2021 12:36:47 +0800
Message-Id: <20211119043647.1251416-3-art@khadas.com>
In-Reply-To: <20211119043647.1251416-1-art@khadas.com>
References: <20211119043647.1251416-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: sjg@chromium.org
Cc: trini@konsulko.com, marek.behun@nic.cz, narmstrong@baylibre.com, twarren@nvidia.com, andre.przywara@arm.com, u-boot@lists.denx.de, u-boot-amlogic@groups.io, christianshewitt@gmail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

Add new tests for `setenv -r` options (setup env variable with additional
resolving vars inside value).

test.py -k test_env

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 test/py/tests/test_env.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
index 9bed2f48d7..a2f02f6f67 100644
--- a/test/py/tests/test_env.py
+++ b/test/py/tests/test_env.py
@@ -201,6 +201,30 @@ def test_env_unset_non_existent(state_test_env):
     unset_var(state_test_env, var)
     validate_empty(state_test_env, var)
 
+def test_env_resovle(state_test_env):
+    """Test deep resolve variable."""
+    c = state_test_env.u_boot_console
+    c.run_command("setenv a hello; setenv b world; setenv c '${a} ${b}'")
+    assert c.run_command('printenv a') == 'a=hello'
+    assert c.run_command('printenv b') == 'b=world'
+    assert c.run_command('printenv c') == 'c=${a} ${b}'
+    c.run_command("setenv d '${c}'")
+    assert c.run_command('printenv d') == 'd=${c}'
+    c.run_command("setenv -r e '${a} ${b} ${c}'")
+    assert c.run_command('printenv e') == 'e=hello world hello world'
+    c.run_command("setenv not_exist; setenv -r e '${not_exist}OK'")
+    assert c.run_command('printenv e') == 'e=OK'
+    c.run_command("setenv a 'A${b}'; setenv b 'B${a}'")
+    assert c.run_command('printenv a') == 'a=A${b}'
+    c.run_command("setenv e ''")
+    assert c.run_command('printenv e') == 'e='
+    c.run_command("setenv -r e '${b}'")
+    #assert c.run_command('printenv e') == 'e=BABABABABABABABABABABABABABABABAB${a}'
+    assert c.run_command('printenv e') != 'e='
+    c.run_command("setenv -r e")
+    with c.disable_check('error_notification'):
+        assert c.run_command('printenv e') == '## Error: "e" not defined'
+
 def test_env_set_non_existent(state_test_env):
     """Test set a non-existant variable."""
 
-- 
2.25.1

