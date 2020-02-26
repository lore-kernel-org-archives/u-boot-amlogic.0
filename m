Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
 by mx.groups.io with SMTP id smtpd.web10.9784.1582731202731451289
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Feb 2020 07:33:22 -0800
Received: by mail-ot1-f66.google.com with SMTP id g64so3260604otb.13
        for <u-boot-amlogic@groups.io>; Wed, 26 Feb 2020 07:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCOKAmsrkJQkUi3PZKrj+vJf6Wak63l9GPR0qhpIVU0=;
        b=Si4n8D1178azcWdHrM8WdBJX/qVC4iK3LdeV+cKB1RD2x0CYWyldZUaMyCCNQo2Lrb
         jGLik3QVjjpwxkxYvekOvKhuQ1Y0hK3163neQIQyNljh2q6Lmqh1kgZsCEA1G/1dXt3N
         k/OKRwwu0+DzUeLebY8lDhvEEi3+WeC0qO8Ik=
MIME-Version: 1.0
References: <20200225051021.15311-1-michael@amarulasolutions.com> <20200225051021.15311-2-michael@amarulasolutions.com>
In-Reply-To: <20200225051021.15311-2-michael@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 26 Feb 2020 07:33:08 -0800
Message-ID: <CAPnjgZ3Ssyr+Q_SCk+11xvt-5qt2naOAH7W3GB7S6ZW_cJk_sw@mail.gmail.com>
Subject: Re: [PATCH 1/2] common: fdt: Add a function for reserving memory without kernel linear mapping
Content-Type: text/plain; charset="UTF-8"
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Anatolij Gustschin <agust@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Michael,

On Mon, 24 Feb 2020 at 22:10, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> The intent is to reserve memory _and_ prevent it from being included
> in the kernel's linear map. For thos reason it is also necessary to include the
> 'no-map' property for this reserved-mem node.
>
> From Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt:
>
> no-map (optional) - empty property
>     - Indicates the operating system must not create a virtual mapping
>       of the region as part of its standard mapping of system memory,
>       nor permit speculative access to it under any circumstances other
>       than under the control of the device driver using the region.
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> Changes: RFC->v1
>         - Add a better commit message
> ---
>  common/fdt_support.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/fdt_support.h | 11 +++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/common/fdt_support.c b/common/fdt_support.c
> index 02cf5c6241..a3662f4358 100644
> --- a/common/fdt_support.c
> +++ b/common/fdt_support.c
> @@ -410,6 +410,46 @@ static int fdt_pack_reg(const void *fdt, void *buf, u64 *address, u64 *size,
>         return p - (char *)buf;
>  }
>
> +int fdt_fixup_reserved_memory(void *blob, const char *area, u64 start[], u64 size[])
> +{
> +       int offs, len;
> +       const char *subpath;
> +       const char *path = "/reserved-memory";
> +       fdt32_t address_cells = cpu_to_fdt32(fdt_address_cells(blob, 0));
> +       fdt32_t size_cells = cpu_to_fdt32(fdt_size_cells(blob, 0));
> +       u8 temp[16]; /* Up to 64-bit address + 64-bit size */
> +
> +       offs = fdt_path_offset(blob, path);
> +       if (offs < 0) {
> +               debug("Node %s not found\n", path);
> +               path = "/";
> +               subpath = "reserved-memory";
> +               offs = fdt_path_offset(blob, path);

Error check

> +               offs = fdt_add_subnode(blob, offs, subpath);
> +               if (offs < 0) {
> +                       printf("Could not create %s%s node.\n", path, subpath);
> +                       return -1;
> +               }
> +               path = "/reserved-memory";
> +               offs = fdt_path_offset(blob, path);
> +
> +               fdt_setprop(blob, offs, "#address-cells", &address_cells, sizeof(address_cells));
> +               fdt_setprop(blob, offs, "#size-cells", &size_cells, sizeof(size_cells));
> +               fdt_setprop(blob, offs, "ranges", NULL, 0);

Need error-checking on these three

> +       }
> +
> +       offs = fdt_add_subnode(blob, offs, area ? : "private");

Is this in a binding file somewhere?

> +       if (offs < 0) {
> +               printf("Could not create %s%s node.\n", path, subpath);
> +               return -1;

return offs

> +       }
> +
> +       fdt_setprop(blob, offs, "no-map", NULL, 0);

and this?

Also needs error check

> +       len = fdt_pack_reg(blob, temp, start, size, 1);
> +       fdt_setprop(blob, offs, "reg", temp, len);

blank line before return

> +       return 0;
> +}
> +
>  #if CONFIG_NR_DRAM_BANKS > 4
>  #define MEMORY_BANKS_MAX CONFIG_NR_DRAM_BANKS
>  #else
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index ba14acd7f6..7c8a280f53 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -93,6 +93,17 @@ void do_fixup_by_compat_u32(void *fdt, const char *compat,
>   */
>  int fdt_fixup_memory(void *blob, u64 start, u64 size);
>
> +/**
> + * Setup the memory reserved node in the DT. Creates one if none was existing before.
> + *
> + * @param blob         FDT blob to update
> + * @param area         Reserved area name
> + * @param start                Begin of DRAM mapping in physical memory
> + * @param size         Size of the single memory bank
> + * @return 0 if ok, or -1 or -FDT_ERR_... on error

Really we should return an FDT_ERR always. -1 is not a good idea and
in fact is an FDT_ERR

> + */
> +int fdt_fixup_reserved_memory(void *blob, const char *area, u64 start[], u64 size[]);
> +
>  /**
>   * Fill the DT memory node with multiple memory banks.
>   * Creates the node if none was existing before.
> --
> 2.17.1
>

Regards,
Simon
