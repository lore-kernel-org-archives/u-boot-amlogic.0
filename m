Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D4AD0D79F
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 14:24:40 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web10.12981.1728656676017133533
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2024 07:24:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=Sg911PBk;
 spf=pass (domain: baylibre.com, ip: 209.85.167.42, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398e53ca28so2339097e87.3
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728656674; x=1729261474; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CpC57p9l+JWhKb/HekGjjYuv8Eb4T62/JeWjLA9R/kI=;
        b=Sg911PBkkVvSd2iQwBFXJk6R2cCq0+/WFj0ovXDjAcCsZ0nYHCWIrC6FNGbhwWwZR/
         FaKo48yHdKDp0kQkEyc2v4tZyHNlEzgtLlZbhKvsI2yfu+Gj+8jr8gGwLHfiqmkMkoTg
         fkqPL55w+ivnkRfkhCcYW5IsKB+yuyBAwl9cGJYpOK+OKjZ+8wiccwpLIiR/XJPSRY0/
         f7QOsD7I+uAgyIgi429A71HH4Ox/c7evW8x0dMsM5oSyjM+Jbcm+fAt4Ov1LPunErSHL
         cwh0Qp0vmqiW94KaD0XBsTw4Lcqm7UyjG5RLvO4o7r2df4IQXvuMvJc8I2j2DNSqny0Z
         QGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728656674; x=1729261474;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpC57p9l+JWhKb/HekGjjYuv8Eb4T62/JeWjLA9R/kI=;
        b=ORBm85NoRLHslH7WFLQbHqtqh3sjUcKMbCSryhi4m/r4JRg4z+h8ECz21eF168hvwW
         Q5U4owXAVbNuSSm3qNJsfQjCb09u1Btu3eYQNRv3NDNEwWCYONKW5dUbZ3k4dy8qM7Cq
         N9KPIuvqC8xxsWaIYnLVyXNwrWVWsmUEOPtJekZWFR0dBfa4bkFjxGcd+FD0X7k6X1ZW
         gXA6p2GAx7Cqsxg8SuvB5Y8suR4VnxYOJfbDYqARzKtZ9/Mktj1EnGwLDo3wqMip+SD2
         2LgVzk3cc3ezORw3CBfOcbnEQTjMbf6DU13C04xiMDA+BiSEFahepz0zxMADrqsTI9GP
         DXhA==
X-Forwarded-Encrypted: i=1; AJvYcCX0cHj0dKyKwPpJbe4BJPyOnY+APY1TGHXy5U+MEZpdfU5oR8nN85A4D6LirZ8WVFe/8ZtK5WQzAK2+rU/hVw==@groups.io
X-Gm-Message-State: AOJu0YyRnoZJtuPKHLk3NDWej35Ogx74RUVkq7wSjnTWNj2vBV4X1zLv
	wIXqUp1O1s4TTEj0+BxbfJnmVMbWpsqYQheTTJWe1Wnmfulpk5uwsSv2dQQuz1E=
X-Google-Smtp-Source: AGHT+IFON9goHQawzpuybPTl1d/yWmgJNMg9INGWDVwJlQdnScOduyL1iDkmW1r9fvOfBeqn7kBwXw==
X-Received: by 2002:a05:6512:39d6:b0:536:550e:7804 with SMTP id 2adb3069b0e04-539da3c6a00mr1838232e87.18.1728656673918;
        Fri, 11 Oct 2024 07:24:33 -0700 (PDT)
Received: from localhost ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835d95bsm43704685e9.47.2024.10.11.07.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:24:33 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
 <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com,
 kernel@salutedevices.com, Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print
 BCB block content
In-Reply-To: <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
Date: Fri, 11 Oct 2024 16:24:30 +0200
Message-ID: <878quuhg4h.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 14:24:40 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2442

Hi Dmitry,

Thank you for the patch.

On mar., oct. 08, 2024 at 23:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

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
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  cmd/bcb.c            | 35 +++++++++++++++++++++++++++
>  include/android_ab.h | 10 ++++++++
>  3 files changed, 113 insertions(+)
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
> index 970c58e56cba0e1bdff21b7cd099f69151f0c5b8..4fd32186ae654915b5a42c26d755e5727c211c63 100644
> --- a/cmd/bcb.c
> +++ b/cmd/bcb.c
> @@ -25,6 +25,7 @@ enum bcb_cmd {
>  	BCB_CMD_FIELD_DUMP,
>  	BCB_CMD_STORE,
>  	BCB_CMD_AB_SELECT,
> +	BCB_CMD_AB_DUMP,
>  };
>  
>  static const char * const fields[] = {
> @@ -56,6 +57,8 @@ static int bcb_cmd_get(char *cmd)
>  		return BCB_CMD_FIELD_DUMP;
>  	if (!strcmp(cmd, "ab_select"))
>  		return BCB_CMD_AB_SELECT;
> +	if (!strcmp(cmd, "ab_dump"))
> +		return BCB_CMD_AB_DUMP;
>  	else
>  		return -1;
>  }
> @@ -93,6 +96,10 @@ static int bcb_is_misused(int argc, char *const argv[])
>  		if (argc != 4 && argc != 5)
>  			goto err;
>  		return 0;
> +	case BCB_CMD_AB_DUMP:
> +		if (argc != 3)
> +			goto err;
> +		return 0;
>  	default:
>  		printf("Error: 'bcb %s' not supported\n", argv[0]);
>  		return -1;
> @@ -460,6 +467,28 @@ static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
>  	return CMD_RET_SUCCESS;
>  }
>  
> +static int do_bcb_ab_dump(struct cmd_tbl *cmdtp, int flag, int argc,
> +			  char *const argv[])
> +{
> +	int ret;
> +	struct blk_desc *dev_desc;
> +	struct disk_partition part_info;
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
>  static struct cmd_tbl cmd_bcb_sub[] = {
>  	U_BOOT_CMD_MKENT(load, CONFIG_SYS_MAXARGS, 1, do_bcb_load, "", ""),
>  	U_BOOT_CMD_MKENT(set, CONFIG_SYS_MAXARGS, 1, do_bcb_set, "", ""),
> @@ -469,6 +498,8 @@ static struct cmd_tbl cmd_bcb_sub[] = {
>  	U_BOOT_CMD_MKENT(store, CONFIG_SYS_MAXARGS, 1, do_bcb_store, "", ""),
>  	U_BOOT_CMD_MKENT(ab_select, CONFIG_SYS_MAXARGS, 1,
>  			 do_bcb_ab_select, "", ""),
> +	U_BOOT_CMD_MKENT(ab_dump, CONFIG_SYS_MAXARGS, 1,
> +			 do_bcb_ab_dump, "", ""),
>  };
>  
>  static int do_bcb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> @@ -523,6 +554,10 @@ U_BOOT_CMD(
>  	"    - If '--no-dec' is set, the number of tries remaining will not\n"
>  	"      decremented for the selected boot slot\n"
>  	"\n"
> +	"bcb ab_dump -\n"
> +	"    Dump boot_control information from specific partition.\n"
> +	"    <interface> <dev[:part|#part_name]>\n"
> +	"\n"
>  	"Legend:\n"
>  	"<interface> - storage device interface (virtio, mmc, etc)\n"
>  	"<dev>       - storage device index containing the BCB partition\n"
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
>
> -- 
> 2.43.0

