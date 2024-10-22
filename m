Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00809D1CDC0
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 09:03:53 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.14163.1729587825198545097
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Oct 2024 02:03:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=QecRxMOR;
 spf=pass (domain: baylibre.com, ip: 209.85.128.53, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314c452180so42444325e9.0
        for <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 02:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729587823; x=1730192623; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vlG3pAkRStta4fQ/ZKTXAmsgjmMs7Z5JYZId/FLrQsg=;
        b=QecRxMORuHPn1kIc799nt7WxR7DqKvWi2cUsNIlPMbk5RaNMT7d9JQqz0HqwqoX3za
         Eo1itV1gTdTDmudb1uVvGwoXh/mnjLgg1ZfOwL9aEiKnQHhOVjTnN+LcBcAmsGIjQQu4
         WwjbFjMR2oaZZEhyjltxqRUlKhPO4EtsbO0hLO7W6+p3uISZVthU6q3jIjYF8OduAjbj
         bEfz79/13qQ331aqDQOjD/V1DvYQxrZP19uNXOVbT6wukXwDYa75zdluB2bzCCaeTyAI
         16+OOZkuIUVH3Xfvuv/WDRrkwfAMZ6HK0oaNeMZ9QI0IPb58einX3iG6hIG8Hq2wG5nw
         o6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729587823; x=1730192623;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlG3pAkRStta4fQ/ZKTXAmsgjmMs7Z5JYZId/FLrQsg=;
        b=AUoi3IS3gt4srbo7clUE7ZJo3HzNoU7ue9mFnW1jgsgJmrhuIbhlzY0UY50aX9+wmV
         clrn5pKqOFve1JwjTdYxQ7CCnPdnkQJFd8P3C5JpJKn6IpjPQOja6IDluqB1J1FCJ9V3
         Ev/uxEjn+4LqXssGSygdItiEwZPBxmhtyD+ZhZhIBeI1dXLhFE7eW3X5tBRd7ld4a47c
         dm0BUx3IGjoBA7APfvt6e1+E+gELqnFDYkL2fjub/n/1wqZ8EocYK/UKsoNDl3bVizGA
         Mc6G7FscDIwhQ0Y2Codr+PgSvITgfzQBKW5u8pCPGKzWDQTmHNoaWP7eDM9vq1rADooC
         bHYg==
X-Forwarded-Encrypted: i=1; AJvYcCXC68/fz3INBYeErAB7RtJyFE4EeMq6V5uPwqJuncpNWfNprXgEXhFMecGcCEJFssYCVp7mWXboWeq1bPUGLQ==@groups.io
X-Gm-Message-State: AOJu0YxSyUPajrqboPL2ydYnE0ZSDmyPVDckBdxIkB7LMvYKC7WlPPWE
	hqpVPC28oUTGwi6CtOO3LH+QavTc12VpNEYqUARaF1kScbQ1JuIP50BSddpqDJE=
X-Google-Smtp-Source: AGHT+IFk9KXxwi4EzLpavvawNEA/M5Tkhp3DCa4Qw8Ya+vg7qa5IrqdO3zIEc0iV04PZsg1lVA+sxQ==
X-Received: by 2002:adf:e00c:0:b0:37c:cc7c:761c with SMTP id ffacd0b85a97d-37ef12628famr1405816f8f.3.1729587823490;
        Tue, 22 Oct 2024 02:03:43 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0ba7dffsm6145162f8f.116.2024.10.22.02.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:03:43 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
 <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com,
 kernel@salutedevices.com, Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v5 5/6] cmd: bcb: introduce 'ab_dump' command to print
 BCB block content
In-Reply-To: <20241017-android_ab_master-v5-5-43bfcc096d95@salutedevices.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-5-43bfcc096d95@salutedevices.com>
Date: Tue, 22 Oct 2024 11:03:40 +0200
Message-ID: <87jze0wlub.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 22 Oct 2024 09:03:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2512

Hi Dmitry,

Thank you for the patch.

On jeu., oct. 17, 2024 at 17:12, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> It's really helpful to have the ability to dump BCB block for debugging
> A/B logic on the board supported this partition schema.
>
> Command 'bcb ab_dump' prints all fields of bootloader_control struct
> including slot_metadata for all presented slots.
>
> Output example:
> =====
>> board# bcb ab_dump ubi 0#misc
>> Read 512 bytes from volume misc to 000000000bf07580
>> Read 512 bytes from volume misc to 000000000bf42f40
>> Bootloader Control:       [misc]
>> Active Slot:              _a
>> Magic Number:             0x42414342
>> Version:                  1
>> Number of Slots:          2
>> Recovery Tries Remaining: 0
>> CRC:                      0x2c8b50bc (Valid)
>>
>> Slot[0] Metadata:
>> 	- Priority:         15
>> 	- Tries Remaining:  0
>> 	- Successful Boot:  1
>> 	- Verity Corrupted: 0
>>
>> Slot[1] Metadata:
>> 	- Priority:         14
>> 	- Tries Remaining:  7
>> 	- Successful Boot:  0
>> 	- Verity Corrupted: 0
> ====
>
> The ab_dump command allows you to display ABC data directly on the
> U-Boot console. During an A/B test execution, this test verifies the
> accuracy of each field within the ABC data.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/android_ab.c                     | 68 +++++++++++++++++++++++++++++++++++
>  cmd/bcb.c                             | 31 ++++++++++++++++
>  include/android_ab.h                  | 10 ++++++
>  test/py/tests/test_android/test_ab.py | 23 ++++++++++++
>  4 files changed, 132 insertions(+)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 0045c8133a8e164f1fdd4c0f9b683de0f13f26e0..c93e51541019d0fe793303c4b3d5286df061906f 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -372,3 +372,71 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>  
>  	return slot;
>  }
> +
> +int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info)
> +{
> +	struct bootloader_control *abc;
> +	u32 crc32_le;
> +	int i, ret;
> +	struct slot_metadata *slot;
> +
> +	if (!dev_desc || !part_info) {
> +		log_err("ANDROID: Empty device descriptor or partition info\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = ab_control_create_from_disk(dev_desc, part_info, &abc, 0);
> +	if (ret < 0) {
> +		log_err("ANDROID: Cannot create bcb from disk %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (abc->magic != BOOT_CTRL_MAGIC) {
> +		log_err("ANDROID: Unknown A/B metadata: %.8x\n", abc->magic);
> +		ret = -ENODATA;
> +		goto error;
> +	}
> +
> +	if (abc->version > BOOT_CTRL_VERSION) {
> +		log_err("ANDROID: Unsupported A/B metadata version: %.8x\n",
> +			abc->version);
> +		ret = -ENODATA;
> +		goto error;
> +	}
> +
> +	if (abc->nb_slot > ARRAY_SIZE(abc->slot_info)) {
> +		log_err("ANDROID: Wrong number of slots %u, expected %zu\n",
> +			abc->nb_slot, ARRAY_SIZE(abc->slot_info));
> +		ret = -ENODATA;
> +		goto error;
> +	}
> +
> +	printf("Bootloader Control:       [%s]\n", part_info->name);
> +	printf("Active Slot:              %s\n", abc->slot_suffix);
> +	printf("Magic Number:             0x%x\n", abc->magic);
> +	printf("Version:                  %u\n", abc->version);
> +	printf("Number of Slots:          %u\n", abc->nb_slot);
> +	printf("Recovery Tries Remaining: %u\n", abc->recovery_tries_remaining);
> +
> +	printf("CRC:                      0x%.8x", abc->crc32_le);
> +
> +	crc32_le = ab_control_compute_crc(abc);
> +	if (abc->crc32_le != crc32_le)
> +		printf(" (Invalid, Expected: 0x%.8x)\n", crc32_le);
> +	else
> +		printf(" (Valid)\n");
> +
> +	for (i = 0; i < abc->nb_slot; ++i) {
> +		slot = &abc->slot_info[i];
> +		printf("\nSlot[%d] Metadata:\n", i);
> +		printf("\t- Priority:         %u\n", slot->priority);
> +		printf("\t- Tries Remaining:  %u\n", slot->tries_remaining);
> +		printf("\t- Successful Boot:  %u\n", slot->successful_boot);
> +		printf("\t- Verity Corrupted: %u\n", slot->verity_corrupted);
> +	}
> +
> +error:
> +	free(abc);
> +
> +	return ret;
> +}
> diff --git a/cmd/bcb.c b/cmd/bcb.c
> index b33c046af0385a112fd40634ab7f48e05542ca48..16eabfe00f5a443f710e5084d187e374f89f6d3a 100644
> --- a/cmd/bcb.c
> +++ b/cmd/bcb.c
> @@ -419,6 +419,32 @@ __maybe_unused static int do_bcb_ab_select(struct cmd_tbl *cmdtp,
>  	return CMD_RET_SUCCESS;
>  }
>  
> +__maybe_unused static int do_bcb_ab_dump(struct cmd_tbl *cmdtp,
> +					 int flag, int argc,
> +					 char *const argv[])
> +{
> +	int ret;
> +	struct blk_desc *dev_desc;
> +	struct disk_partition part_info;
> +
> +	if (argc < 3)
> +		return CMD_RET_USAGE;
> +
> +	if (part_get_info_by_dev_and_name_or_num(argv[1], argv[2],
> +						 &dev_desc, &part_info,
> +						 false) < 0) {
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	ret = ab_dump_abc(dev_desc, &part_info);
> +	if (ret < 0) {
> +		printf("Cannot dump ABC data, error %d.\n", ret);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
>  U_BOOT_LONGHELP(bcb,
>  	"load <interface> <dev> <part>  - load  BCB from <interface> <dev>:<part>\n"
>  	"load <dev> <part>              - load  BCB from mmc <dev>:<part>\n"
> @@ -444,6 +470,10 @@ U_BOOT_LONGHELP(bcb,
>  	"    - If '--no-dec' is set, the number of tries remaining will not\n"
>  	"      decremented for the selected boot slot\n"
>  	"\n"
> +	"bcb ab_dump -\n"
> +	"    Dump boot_control information from specific partition.\n"
> +	"    <interface> <dev[:part|#part_name]>\n"
> +	"\n"
>  #endif
>  	"Legend:\n"
>  	"<interface> - storage device interface (virtio, mmc, etc)\n"
> @@ -468,5 +498,6 @@ U_BOOT_CMD_WITH_SUBCMDS(bcb,
>  	U_BOOT_SUBCMD_MKENT(store, 1, 1, do_bcb_store),
>  #if IS_ENABLED(CONFIG_ANDROID_AB)
>  	U_BOOT_SUBCMD_MKENT(ab_select, 5, 1, do_bcb_ab_select),
> +	U_BOOT_SUBCMD_MKENT(ab_dump, 3, 1, do_bcb_ab_dump),
>  #endif
>  );
> diff --git a/include/android_ab.h b/include/android_ab.h
> index 1e53879a25f145a9d18ac0a6553d8c217123aa6f..838230e06f8cbf7a5d79d9d84d9ebe9f96aca10d 100644
> --- a/include/android_ab.h
> +++ b/include/android_ab.h
> @@ -36,4 +36,14 @@ struct disk_partition;
>  int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>                     bool dec_tries);
>  
> +/**
> + * ab_dump_abc() - Dump ABC information for specific partition.
> + *
> + * @dev_desc: Device description pointer
> + * @part_info: Partition information
> + *
> + * Return: 0 on success, or a negative on error
> + */
> +int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info);
> +
>  #endif /* __ANDROID_AB_H */
> diff --git a/test/py/tests/test_android/test_ab.py b/test/py/tests/test_android/test_ab.py
> index 0d7b7995a9fab6e3daad748721818b9e4cfac452..9bf1a0eb00a6ae1edebf62f07fd162b9c8c02e49 100644
> --- a/test/py/tests/test_android/test_ab.py
> +++ b/test/py/tests/test_android/test_ab.py
> @@ -54,6 +54,27 @@ def ab_disk_image(u_boot_console):
>          di = ABTestDiskImage(u_boot_console)
>      return di
>  
> +def ab_dump(u_boot_console, slot_num, crc):
> +    output = u_boot_console.run_command('bcb ab_dump host 0#misc')
> +    header, slot0, slot1 = output.split('\r\r\n\r\r\n')
> +    slots = [slot0, slot1]
> +    slot_suffixes = ['_a', '_b']
> +
> +    header = dict(map(lambda x: map(str.strip, x.split(':')), header.split('\r\r\n')))
> +    assert header['Bootloader Control'] == '[misc]'
> +    assert header['Active Slot'] == slot_suffixes[slot_num]
> +    assert header['Magic Number'] == '0x42414342'
> +    assert header['Version'] == '1'
> +    assert header['Number of Slots'] == '2'
> +    assert header['Recovery Tries Remaining'] == '0'
> +    assert header['CRC'] == '{} (Valid)'.format(crc)
> +
> +    slot = dict(map(lambda x: map(str.strip, x.split(':')), slots[slot_num].split('\r\r\n\t- ')[1:]))
> +    assert slot['Priority'] == '15'
> +    assert slot['Tries Remaining'] == '6'
> +    assert slot['Successful Boot'] == '0'
> +    assert slot['Verity Corrupted'] == '0'
> +
>  @pytest.mark.boardspec('sandbox')
>  @pytest.mark.buildconfigspec('android_ab')
>  @pytest.mark.buildconfigspec('cmd_bcb')
> @@ -68,8 +89,10 @@ def test_ab(ab_disk_image, u_boot_console):
>      assert 'Attempting slot a, tries remaining 7' in output
>      output = u_boot_console.run_command('printenv slot_name')
>      assert 'slot_name=a' in output
> +    ab_dump(u_boot_console, 0, '0xd438d1b9')
>  
>      output = u_boot_console.run_command('bcb ab_select slot_name host 0:1')
>      assert 'Attempting slot b, tries remaining 7' in output
>      output = u_boot_console.run_command('printenv slot_name')
>      assert 'slot_name=b' in output
> +    ab_dump(u_boot_console, 1, '0x011ec016')
>
> -- 
> 2.43.0

