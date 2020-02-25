Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web09.462.1582607426188408190
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Feb 2020 21:10:26 -0800
Received: by mail-wm1-f68.google.com with SMTP id p17so1699032wma.1
        for <u-boot-amlogic@groups.io>; Mon, 24 Feb 2020 21:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zvflET1mETmYbMke6Gali60cgIN4H0u6ca6uNN+2P+4=;
        b=V/ctkZShwW8Fp1HUfszK8OYvdasYxMej0lqSxuVFC6+sQN+aJ+tbPcVEA92yl517Ib
         f/LYD8MfnAlbF1Y7s33wdJdQANpEEIlzaXIzARPZKvnQ906jWM/eZAERdqukyCsAlxXf
         5WqTFb/PqJRkXHbFtLnwLg7bSUg+iotUlbkHE=
Return-Path: <michael@amarulasolutions.com>
From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 1/2] common: fdt: Add a function for reserving memory without kernel linear mapping
Date: Tue, 25 Feb 2020 06:10:20 +0100
Message-Id: <20200225051021.15311-2-michael@amarulasolutions.com>
In-Reply-To: <20200225051021.15311-1-michael@amarulasolutions.com>
References: <20200225051021.15311-1-michael@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>, Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

The intent is to reserve memory _and_ prevent it from being included
in the kernel's linear map. For thos reason it is also necessary to include the
'no-map' property for this reserved-mem node.

From Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt:

no-map (optional) - empty property
    - Indicates the operating system must not create a virtual mapping
      of the region as part of its standard mapping of system memory,
      nor permit speculative access to it under any circumstances other
      than under the control of the device driver using the region.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
Changes: RFC->v1
	- Add a better commit message
---
 common/fdt_support.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 include/fdt_support.h | 11 +++++++++++
 2 files changed, 51 insertions(+)

diff --git a/common/fdt_support.c b/common/fdt_support.c
index 02cf5c6241..a3662f4358 100644
--- a/common/fdt_support.c
+++ b/common/fdt_support.c
@@ -410,6 +410,46 @@ static int fdt_pack_reg(const void *fdt, void *buf, u64 *address, u64 *size,
 	return p - (char *)buf;
 }
 
+int fdt_fixup_reserved_memory(void *blob, const char *area, u64 start[], u64 size[])
+{
+	int offs, len;
+	const char *subpath;
+	const char *path = "/reserved-memory";
+	fdt32_t address_cells = cpu_to_fdt32(fdt_address_cells(blob, 0));
+	fdt32_t size_cells = cpu_to_fdt32(fdt_size_cells(blob, 0));
+	u8 temp[16]; /* Up to 64-bit address + 64-bit size */
+
+	offs = fdt_path_offset(blob, path);
+	if (offs < 0) {
+		debug("Node %s not found\n", path);
+		path = "/";
+		subpath = "reserved-memory";
+		offs = fdt_path_offset(blob, path);
+		offs = fdt_add_subnode(blob, offs, subpath);
+		if (offs < 0) {
+			printf("Could not create %s%s node.\n", path, subpath);
+			return -1;
+		}
+		path = "/reserved-memory";
+		offs = fdt_path_offset(blob, path);
+
+		fdt_setprop(blob, offs, "#address-cells", &address_cells, sizeof(address_cells));
+		fdt_setprop(blob, offs, "#size-cells", &size_cells, sizeof(size_cells));
+		fdt_setprop(blob, offs, "ranges", NULL, 0);
+	}
+
+	offs = fdt_add_subnode(blob, offs, area ? : "private");
+	if (offs < 0) {
+		printf("Could not create %s%s node.\n", path, subpath);
+		return -1;
+	}
+
+	fdt_setprop(blob, offs, "no-map", NULL, 0);
+	len = fdt_pack_reg(blob, temp, start, size, 1);
+	fdt_setprop(blob, offs, "reg", temp, len);
+	return 0;
+}
+
 #if CONFIG_NR_DRAM_BANKS > 4
 #define MEMORY_BANKS_MAX CONFIG_NR_DRAM_BANKS
 #else
diff --git a/include/fdt_support.h b/include/fdt_support.h
index ba14acd7f6..7c8a280f53 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -93,6 +93,17 @@ void do_fixup_by_compat_u32(void *fdt, const char *compat,
  */
 int fdt_fixup_memory(void *blob, u64 start, u64 size);
 
+/**
+ * Setup the memory reserved node in the DT. Creates one if none was existing before.
+ *
+ * @param blob		FDT blob to update
+ * @param area		Reserved area name
+ * @param start		Begin of DRAM mapping in physical memory
+ * @param size		Size of the single memory bank
+ * @return 0 if ok, or -1 or -FDT_ERR_... on error
+ */
+int fdt_fixup_reserved_memory(void *blob, const char *area, u64 start[], u64 size[]);
+
 /**
  * Fill the DT memory node with multiple memory banks.
  * Creates the node if none was existing before.
-- 
2.17.1

