Subject: Re: [PATCH 1/2] arm: dts: Import and update DT for Khadas VIM3
References: <20190902022851.9228-1-afaerber@suse.de>
 <20190902022851.9228-2-afaerber@suse.de>
 <865e1398-4da5-fc3c-4ce7-93e8f2d08439@baylibre.com>
 <9069bbc4-e890-0feb-3a1c-729344d00dee@suse.de>
 <c179af5e-d099-5ea3-87d9-6aaae0467ac6@baylibre.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <bdf46216-096b-53c3-d2e8-9193e9504b88@suse.de>
Date: Mon, 2 Sep 2019 14:45:04 +0200
MIME-Version: 1.0
In-Reply-To: <c179af5e-d099-5ea3-87d9-6aaae0467ac6@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Albert Aribaud <albert.u.boot@aribaud.net>, Gouwa <gouwa@khadas.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

Am 02.09.19 um 14:10 schrieb Neil Armstrong:
> On 02/09/2019 14:03, Andreas F=C3=A4rber wrote:
>> Am 02.09.19 um 12:03 schrieb Neil Armstrong:
>>> On 02/09/2019 04:28, Andreas F=C3=A4rber wrote:
>>>> In Linux meson-g12-common.dtsi was introduced as well as new g12b no=
des
>>>> and headers, as dependencies of new meson-g12b-a311d-khadas-vim3.dts=
.
>>>
>>> Can you precise the Linux commit ID you sync'ed from ?
>>
>> It was yesterday's linux-next.git (via cgit), adding tag next-20190830=
.
>=20
> Please don't use linux next, it's not a stable tree, either wait for 5.=
4-rc1
> or use kevin's amlogic-dt64-2.1 tag, since it will be kept in the final
> merge.

Well, in my view linux-next would contain whatever vX patchset Kevin
applied to his tree... let's wait for -rc1 then.

>>
>>> The best would be to sync from the v2 dt64 PR from kevin :
>>> https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic=
.git/tag/?h=3Damlogic-dt64-2.1
>>>
>>> Thanks,
>>> Neil
>>>
>>>>
>>>> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
>>>> ---
>>>>  arch/arm/dts/Makefile                              |    3 +-
>>>>  arch/arm/dts/meson-g12-common.dtsi                 | 2435 +++++++++=
+++++++++++
>>>>  arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   15 +
>>>
>>> Can you also sync the s922x version ?
>>
>> Why? No such model is being sold: https://www.khadas.com/vim3
>>
>> In any case, if you or someone has such a pre-production model you can
>> add it as follow-up. In fact you could even entirely replace this impo=
rt
>> patch if you so desired, it's intentionally separate.
>=20
> Didn't want to offend you, don't sync it if you don't want...

It was an honest question. So I take it you have such a prototype?

What I do feel offended about is that my NanoPi K2 patch got ignored and
someone else's got merged without crediting or even notifying me. I've
become rather hesitant to send U-Boot patches for new boards since, as I
don't have much time for it lately and I'd rather spend it productively.

https://patchwork.ozlabs.org/patch/762194/
https://patchwork.ozlabs.org/patch/762483/
https://patchwork.ozlabs.org/patch/934377/
https://gitlab.denx.de/u-boot/u-boot/commit/eee45b4f545902a9089f68331c925=
898da813ac0

>>>>  arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 ++
>>>>  arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  544 +++++
>>>>  arch/arm/dts/meson-g12b.dtsi                       |   39 +-
>>>>  include/dt-bindings/clock/g12a-clkc.h              |    6 +
>>>>  include/dt-bindings/power/meson-g12a-power.h       |   13 +
>>>>  .../reset/amlogic,meson-g12a-audio-reset.h         |   38 +
>>>>  9 files changed, 3238 insertions(+), 4 deletions(-)
>>>>  create mode 100644 arch/arm/dts/meson-g12-common.dtsi
>>>>  create mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts
>>>>  create mode 100644 arch/arm/dts/meson-g12b-a311d.dtsi
>>>>  create mode 100644 arch/arm/dts/meson-g12b-khadas-vim3.dtsi
>>>>  create mode 100644 include/dt-bindings/power/meson-g12a-power.h
>>>>  create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-aud=
io-reset.h
>>>>
>>>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>>>> index aac1b83d49..6de5e4c62a 100644
>>>> --- a/arch/arm/dts/Makefile
>>>> +++ b/arch/arm/dts/Makefile
>>>> @@ -141,7 +141,8 @@ dtb-$(CONFIG_ARCH_MESON) +=3D \
>>>>  	meson-axg-s400.dtb \
>>>>  	meson-g12a-u200.dtb \
>>>>  	meson-g12a-sei510.dtb \
>>>> -	meson-g12b-odroid-n2.dtb
>>>> +	meson-g12b-odroid-n2.dtb \
>>>> +	meson-g12b-a311d-khadas-vim3.dtb
>>>
>>> Same here, can you also build the s922x variant ?
>>
>> Again, I don't see why, in particular when we don't have a defconfig
>> using it. If you intend to add one, you can still add it later
>=20
> Since I maintain the whole stuff, it would have saved my time.

Sorry, no time to redo this patch the next ~3 weeks due to travels.
It was not scripted.

Thanks for your quick review.

Regards,
Andreas

--=20
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer
HRB 247165 (AG M=C3=BCnchen)
