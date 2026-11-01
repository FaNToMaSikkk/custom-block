#!/usr/bin/env python3
"""Генератор кастомных блоков для BONE:MSD.

Читает blocks.json (список блоков — «enum») и собирает из него готовый
датапак + ресурспак. Каждому блоку выдаётся свободный слот — двойная плита
ванильного материала (`<slab>[type=double]`), которую движок BONE:MSD
никогда не оставляет в мире. Выданные слоты запоминаются в slots.lock.json,
чтобы уже поставленные в мире блоки не менялись между сборками.

Запуск:  python3 generator/build.py            (из папки Custom-Block)
Только стандартная библиотека Python 3.8+.
"""
import argparse
import json
import re
import shutil
import struct
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# Плиты, двойные состояния которых BONE:MSD превращает в полные блоки
# (bone_msd:block_engine/placing/place_slab). Порядок = порядок выдачи слотов:
# сначала плиты, которые реже встречаются двойными в генерации мира.
# Невощёная медь исключена: она окисляется и блок сменился бы сам.
SLABS = {
    "wood": [
        "pale_oak_slab", "bamboo_mosaic_slab", "bamboo_slab", "cherry_slab",
        "mangrove_slab", "crimson_slab", "warped_slab", "acacia_slab",
        "jungle_slab", "dark_oak_slab", "birch_slab", "spruce_slab", "oak_slab",
    ],
    "stone": [
        "resin_brick_slab", "tuff_brick_slab", "polished_tuff_slab", "tuff_slab",
        "mud_brick_slab", "sulfur_slab", "polished_sulfur_slab", "sulfur_brick_slab",
        "cinnabar_slab", "polished_cinnabar_slab", "cinnabar_brick_slab",
        "polished_granite_slab", "polished_diorite_slab", "polished_andesite_slab",
        "granite_slab", "diorite_slab", "andesite_slab",
        "deepslate_tile_slab", "deepslate_brick_slab", "polished_deepslate_slab",
        "cobbled_deepslate_slab", "polished_blackstone_brick_slab",
        "polished_blackstone_slab", "blackstone_slab", "dark_prismarine_slab",
        "prismarine_brick_slab", "prismarine_slab", "end_stone_brick_slab",
        "purpur_slab", "smooth_quartz_slab", "quartz_slab", "red_nether_brick_slab",
        "nether_brick_slab", "smooth_red_sandstone_slab", "cut_red_sandstone_slab",
        "red_sandstone_slab", "smooth_sandstone_slab", "cut_sandstone_slab",
        "sandstone_slab", "brick_slab", "mossy_stone_brick_slab", "stone_brick_slab",
        "mossy_cobblestone_slab", "cobblestone_slab", "stone_slab",
    ],
    "copper": [
        "waxed_oxidized_cut_copper_slab", "waxed_weathered_cut_copper_slab",
        "waxed_exposed_cut_copper_slab", "waxed_cut_copper_slab",
    ],
    "wool": [f"{c}_wool_slab" for c in (
        "white", "light_gray", "gray", "black", "brown", "red", "orange", "yellow",
        "lime", "green", "cyan", "light_blue", "blue", "purple", "magenta", "pink")],
    "concrete": [f"{c}_concrete_slab" for c in (
        "white", "light_gray", "gray", "black", "brown", "red", "orange", "yellow",
        "lime", "green", "cyan", "light_blue", "blue", "purple", "magenta", "pink")],
}
SLAB_MATERIAL = {slab: mat for mat, slabs in SLABS.items() for slab in slabs}

# Форматы паков из version.json клиента. Синтаксис loot table / предикатов
# (modifier, condition, match_block) — тоже 26.3; в 26.2 движок не работает
# (нет плит из шерсти и бетона), поэтому 26.2 не поддерживается.
VERSIONS = {
    "26.3": {"data": 121, "resource": 97, "no_materials": set()},
}

# Ширина символов шрифта omg_font:custom (посчитана по PNG движка).
GLYPH_WIDTH = {" ": 4, "I": 4, "f": 5, "i": 2, "k": 5, "l": 3, "t": 4}
GLYPH_WIDTH.update({c: 6 for c in "ABCDEFGHJKLMNOPQRSTUVWXYZabcdeghjmnopqrsuvwxyz"})
GLYPH_WIDTH.update({c: 9 for c in "0123456789"})
TITLE_MIN_WIDTH = 91  # фон должен закрывать ванильный текст подсказки картины

MODELS = {  # тип модели -> (parent, обязательные текстуры)
    "cube_all": ("minecraft:block/cube_all", ["all"]),
    "cube_column": ("minecraft:block/cube_column", ["side", "end"]),
    "cube_bottom_top": ("minecraft:block/cube_bottom_top", ["side", "top", "bottom"]),
    "cube": ("minecraft:block/cube", ["up", "down", "north", "south", "east", "west"]),
}

ID_RE = re.compile(r"^[a-z0-9_]+$")


class BuildError(Exception):
    pass


def warn(msg):
    print(f"  ! {msg}", file=sys.stderr)


def write_json(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def write_text(path, text):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")


def png_size(path):
    head = path.read_bytes()[:24]
    if head[:8] != b"\x89PNG\r\n\x1a\n":
        raise BuildError(f"{path} — не PNG")
    return struct.unpack(">II", head[16:24])


def slab_model(slab):
    """Ванильная модель плиты: вощёная медь использует модели невощёной."""
    return slab[len("waxed_"):] if slab.startswith("waxed_") else slab


def id_to_title(block_id):
    return " ".join(part.capitalize() for part in block_id.split("_") if part)


def painting_title(text):
    """Строка названия картины: фон из omg_font + белый текст поверх него."""
    width = max(TITLE_MIN_WIDTH, sum(GLYPH_WIDTH[c] for c in text) + 4)
    forward, back = [], []
    rest = width
    for size, ch in ((50, ""), (10, ""), (5, ""), (1, "")):
        n, rest = divmod(rest, size)
        forward += [ch + ""] * n  #  (-1) гасит межбуквенный отступ
    rest = width
    for size, ch in ((50, ""), (10, ""), (5, ""), (1, "")):
        n, rest = divmod(rest, size)
        back += [ch] * n
    return "" + "".join(forward) + "" + "".join(back) + "§f" + text


# ---------------------------------------------------------------- конфиг

class Block:
    def __init__(self, raw, index):
        where = f"blocks[{index}]"
        if not isinstance(raw, dict):
            raise BuildError(f"{where}: ожидался объект")
        self.id = raw.get("id", "")
        if not ID_RE.match(self.id):
            raise BuildError(f"{where}: id '{self.id}' — только a-z, 0-9 и _")
        where = f"блок '{self.id}'"

        name = raw.get("name", {})
        self.names = {"en_us": name} if isinstance(name, str) else dict(name)
        self.names.setdefault("en_us", id_to_title(self.id))

        title = raw.get("title")
        if title is None:
            en = self.names["en_us"]
            title = en if all(c in GLYPH_WIDTH for c in en) else id_to_title(self.id)
        bad = sorted({c for c in title if c not in GLYPH_WIDTH})
        if bad:
            raise BuildError(f"{where}: в title есть символы {bad}, шрифт креатива знает только A-Z a-z 0-9 и пробел")
        self.title = title

        self.material = raw.get("material", "stone")
        self.slab = raw.get("slab")
        if self.slab is not None:
            if self.slab not in SLAB_MATERIAL:
                raise BuildError(f"{where}: неизвестная плита '{self.slab}'")
            self.material = SLAB_MATERIAL[self.slab]
        elif self.material not in SLABS:
            raise BuildError(f"{where}: material должен быть одним из {sorted(SLABS)}")
        self.waterlogged = raw.get("waterlogged")  # только вместе с явным slab

        self.drop = raw.get("drop")  # id таблицы лута вместо самого блока
        self.creative = raw.get("creative", True)

        self.model_file = raw.get("model_file")
        if "texture" in raw:
            self.model, self.textures = "cube_all", {"all": raw["texture"]}
        else:
            self.model = raw.get("model", "cube_all")
            self.textures = dict(raw.get("textures", {}))
        if self.model_file is None:
            if self.model not in MODELS:
                raise BuildError(f"{where}: model должен быть одним из {sorted(MODELS)}")
            missing = [k for k in MODELS[self.model][1] if k not in self.textures]
            if missing:
                raise BuildError(f"{where}: для модели {self.model} не хватает текстур {missing}")


def load_config(path):
    try:
        cfg = json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError:
        raise BuildError(f"нет файла {path}")
    except json.JSONDecodeError as e:
        raise BuildError(f"{path.name}: ошибка JSON — {e}")
    ns = cfg.get("namespace", "custom_blocks")
    if not ID_RE.match(ns) or ns in ("minecraft", "bone_msd"):
        raise BuildError(f"namespace '{ns}' недопустим")
    version = cfg.get("minecraft_version", "26.3")
    if version not in VERSIONS:
        raise BuildError(f"minecraft_version '{version}' не поддерживается, есть: {sorted(VERSIONS)}")
    blocks = [Block(raw, i) for i, raw in enumerate(cfg.get("blocks", []))]
    seen = set()
    for b in blocks:
        if b.id in seen:
            raise BuildError(f"блок '{b.id}' объявлен дважды")
        if b.material in VERSIONS[version]["no_materials"]:
            raise BuildError(f"блок '{b.id}': материала '{b.material}' нет в Minecraft {version}")
        seen.add(b.id)
    for slab in cfg.get("reserved_slabs", []):
        if slab not in SLAB_MATERIAL:
            raise BuildError(f"reserved_slabs: неизвестная плита '{slab}'")
    return cfg, ns, blocks


# ---------------------------------------------------------------- слоты

def assign_slots(blocks, cfg, lock_path, free_retired):
    """id блока -> (плита, waterlogged). Стабильно между сборками через lock-файл."""
    lock = {"slots": {}, "retired": []}
    if lock_path.exists():
        lock = json.loads(lock_path.read_text(encoding="utf-8"))
        lock.setdefault("slots", {})
        lock.setdefault("retired", [])
    if free_retired and lock["retired"]:
        print(f"  освобождено списанных слотов: {len(lock['retired'])}")
        lock["retired"] = []

    use_wet = cfg.get("use_waterlogged_slots", False)
    reserved = {(s, w) for s in cfg.get("reserved_slabs", []) for w in (False, True)}
    current = {b.id for b in blocks}

    def retire(block_id, slot, reason):
        lock["retired"].append({"id": block_id, "slab": slot["slab"], "waterlogged": slot["waterlogged"]})
        warn(f"слот {slot['slab']}{'[waterlogged]' if slot['waterlogged'] else ''} блока '{block_id}' списан ({reason}); "
             f"уже поставленные в мире '{block_id}' станут выглядеть как обычная двойная плита")

    for block_id in [i for i in lock["slots"] if i not in current]:
        retire(block_id, lock["slots"].pop(block_id), "блок удалён из blocks.json")

    # Явные плиты и сменившие материал блоки теряют старый слот.
    for b in blocks:
        old = lock["slots"].get(b.id)
        if old is None:
            continue
        if b.slab is not None and (old["slab"], old["waterlogged"]) != (b.slab, bool(b.waterlogged)):
            retire(b.id, lock["slots"].pop(b.id), f"вручную задана плита {b.slab}")
        elif b.slab is None and SLAB_MATERIAL.get(old["slab"]) != b.material:
            retire(b.id, lock["slots"].pop(b.id), f"material сменился на {b.material}")

    taken = {(s["slab"], s["waterlogged"]): i for i, s in lock["slots"].items()}
    taken.update({(r["slab"], r["waterlogged"]): f"{r['id']} (списан)" for r in lock["retired"]})

    for b in blocks:
        if b.id in lock["slots"] or b.slab is None:
            continue
        slot = (b.slab, bool(b.waterlogged))
        if slot in taken:
            raise BuildError(f"блок '{b.id}': плита {b.slab} уже занята блоком '{taken[slot]}'")
        if slot in reserved:
            raise BuildError(f"блок '{b.id}': плита {b.slab} в reserved_slabs")
        taken[slot] = b.id
        lock["slots"][b.id] = {"slab": slot[0], "waterlogged": slot[1]}

    for b in blocks:
        if b.id in lock["slots"]:
            continue
        candidates = [(s, False) for s in SLABS[b.material]]
        if use_wet:
            candidates += [(s, True) for s in SLABS[b.material]]
        free = [c for c in candidates if c not in taken and c not in reserved]
        if not free:
            raise BuildError(f"блок '{b.id}': кончились свободные плиты материала '{b.material}' "
                             f"(можно включить use_waterlogged_slots или сменить material)")
        taken[free[0]] = b.id
        lock["slots"][b.id] = {"slab": free[0][0], "waterlogged": free[0][1]}

    write_json(lock_path, lock)
    return {i: (s["slab"], s["waterlogged"]) for i, s in lock["slots"].items()}


# ---------------------------------------------------------------- генерация

def match_slab(slab, **state):
    return {"type": "minecraft:match_block", "blocks": f"minecraft:{slab}", "state": state}


def give_loot_table(ns, b, slab, wet):
    components = {
        "minecraft:item_model": "minecraft:painting",
        "minecraft:painting/variant": f"{ns}:blocks/{b.id}",
        "minecraft:item_name": {"translate": f"block.{ns}.{b.id}", "fallback": b.names["en_us"]},
        "minecraft:rarity": "common",
        "minecraft:custom_data": {"bone_cb": {
            "pack": ns,
            "block_name": b.id,
            "use_place_function": False,
            "place_information": {
                "base_block": f"minecraft:{slab}[type=double,waterlogged={'true' if wet else 'false'}]"},
        }},
    }
    return {"pools": [{"rolls": 1, "entries": [{
        "type": "minecraft:item", "name": "minecraft:barrier",
        "modifier": [{"type": "minecraft:set_components", "components": components}]}]}]}


def slab_loot_table(ns, slab, users):
    """Ванильный дроп плиты + дроп кастомных блоков на её двойных состояниях."""
    children = []
    for b, wet in users:
        value = b.drop or f"{ns}:blocks/{b.id}/give"
        children.append({"type": "minecraft:loot_table", "value": value,
                         "condition": match_slab(slab, type="double", waterlogged="true" if wet else "false")})
    children.append({  # ванильный дроп плиты (как в minecraft:blocks/<slab> 26.3)
        "type": "minecraft:item", "name": f"minecraft:{slab}",
        "modifier": [
            {"type": "minecraft:set_count", "condition": match_slab(slab, type="double"), "count": 2},
            {"type": "minecraft:explosion_decay"},
        ]})
    return {"type": "minecraft:block",
            "pools": [{"rolls": 1, "entries": [{"type": "minecraft:alternatives", "children": children}]}],
            "random_sequence": f"minecraft:blocks/{slab}"}


def slab_blockstate(ns, slab, users):
    by_wet = {wet: b for b, wet in users}
    variants = {"type=bottom": {"model": f"minecraft:block/{slab_model(slab)}"},
                "type=top": {"model": f"minecraft:block/{slab_model(slab)}_top"}}
    for wet in (False, True):
        # Свободное waterlogged-состояние показывает тот же блок, что и сухое: в
        # обычной игре двойная плита не бывает затопленной, а ванильное имя модели
        # полного блока у каждой плиты своё.
        b = by_wet.get(wet) or by_wet.get(not wet)
        variants[f"type=double,waterlogged={'true' if wet else 'false'}"] = {"model": f"{ns}:block/{b.id}"}
    return {"variants": variants}


def resolve_texture(ns, ref, out_assets, copied):
    if ":" in ref:
        return ref
    src = ROOT / "textures" / f"{ref}.png"
    if not src.exists():
        raise BuildError(f"нет текстуры {src.relative_to(ROOT)}")
    if ref not in copied:
        w, h = png_size(src)
        if w != 16 or h % 16:
            warn(f"текстура {ref}.png {w}x{h}: ожидается 16x16 (или 16x16*N кадров с .mcmeta)")
        dst = out_assets / ns / "textures" / "block" / f"{ref}.png"
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(src, dst)
        meta = src.with_name(src.name + ".mcmeta")
        if meta.exists():
            shutil.copyfile(meta, dst.with_name(dst.name + ".mcmeta"))
        copied.add(ref)
    return f"{ns}:block/{ref}"


def block_model(ns, b, out_assets, copied):
    textures = {k: resolve_texture(ns, v, out_assets, copied) for k, v in b.textures.items()}
    if b.model_file:
        src = ROOT / b.model_file
        if not src.exists():
            raise BuildError(f"блок '{b.id}': нет файла модели {b.model_file}")
        model = json.loads(src.read_text(encoding="utf-8"))
        model.setdefault("textures", {}).update(textures)
        return model
    parent, _ = MODELS[b.model]
    if b.model == "cube":
        textures.setdefault("particle", textures["north"])
    return {"parent": parent, "textures": textures}


def build(ns, blocks, slots, out):
    data, assets = out / "data", out / "assets"
    langs = {"en_us": {}}
    painting_cases, placeable, give_all = [], [], []
    slab_users = {}
    copied = set()

    for b in blocks:
        slab, wet = slots[b.id]
        slab_users.setdefault(slab, []).append((b, wet))

        write_json(data / ns / "loot_table" / "blocks" / b.id / "give.json", give_loot_table(ns, b, slab, wet))
        write_text(data / ns / "function" / "give" / f"{b.id}.mcfunction",
                   f"loot give @s loot {ns}:blocks/{b.id}/give\n")
        give_all.append(f"function {ns}:give/{b.id}")

        if b.creative:
            write_json(data / ns / "painting_variant" / "blocks" / f"{b.id}.json", {
                "title": {"font": "omg_font:custom", "translate": f"painting.{ns}.{b.id}",
                          "fallback": b.names["en_us"]},
                "width": 16, "height": 16, "asset_id": f"{ns}:blocks/{b.id}"})
            placeable.append(f"{ns}:blocks/{b.id}")
            langs["en_us"][f"painting.{ns}.{b.id}"] = painting_title(b.title)

        write_json(assets / ns / "models" / "block" / f"{b.id}.json", block_model(ns, b, assets, copied))
        painting_cases.append({"when": f"{ns}:blocks/{b.id}",
                               "model": {"type": "minecraft:model", "model": f"{ns}:block/{b.id}"}})
        for lang, text in b.names.items():
            langs.setdefault(lang, {})[f"block.{ns}.{b.id}"] = text

    for slab, users in sorted(slab_users.items()):
        write_json(data / "minecraft" / "loot_table" / "blocks" / f"{slab}.json", slab_loot_table(ns, slab, users))
        write_json(assets / "minecraft" / "blockstates" / f"{slab}.json", slab_blockstate(ns, slab, users))

    write_json(data / "minecraft" / "tags" / "painting_variant" / "placeable.json", {"values": placeable})
    write_text(data / ns / "function" / "give_all.mcfunction", "\n".join(give_all) + "\n")
    write_json(assets / "minecraft" / "items" / "painting.json", {"model": {
        "type": "minecraft:select", "property": "minecraft:component",
        "component": "minecraft:painting/variant", "cases": painting_cases,
        "fallback": {"type": "minecraft:model", "model": "minecraft:item/painting"}}})
    # Подсказку картины в креативе закрывает поддельная рамка из шрифта omg_font. Строки,
    # идущие после названия, рисуются поверх неё, поэтому строку размеров («16 на 16»)
    # нужно сделать пустой. Движок делает это только в en_us — дублируем во все языки.
    for lang in set(langs) | {"ru_ru"}:
        langs.setdefault(lang, {})["painting.dimensions"] = ""
    for lang, entries in langs.items():
        path = assets / "minecraft" / "lang" / f"{lang}.json"
        merged = json.loads(path.read_text(encoding="utf-8")) if path.exists() else {}  # строки движка
        merged.update(entries)
        write_json(path, merged)


def prepare_dir(path):
    """Пересоздать папку вывода, но только если её создал генератор."""
    if path.exists():
        if not (path / ".generated").exists():
            raise BuildError(f"{path} существует и создан не генератором — не трогаю")
        shutil.rmtree(path)
    path.mkdir(parents=True)
    (path / ".generated").write_text("Папка пересоздаётся generator/build.py — не редактируйте вручную.\n",
                                     encoding="utf-8")


def copy_engine(out):
    """Движок BONE:MSD, портированный на 26.3: копия extension/bone-msd-26-5 и поверх неё
    файлы из engine-patches/26.3/. Оригинал в extension/ не меняется."""
    src = ROOT / "extension" / "bone-msd-26-5"
    patches = ROOT / "engine-patches" / "26.3"
    if not src.exists():
        raise BuildError(f"нет движка {src}")
    skip = shutil.ignore_patterns("*-old*", "*-OLD*", "*-older*")  # черновики автора, ломают загрузку
    for sub in ("data", "assets"):
        shutil.copytree(src / sub, out / sub, ignore=skip, dirs_exist_ok=True)
        if (patches / sub).exists():
            shutil.copytree(patches / sub, out / sub, dirs_exist_ok=True)

    # В архиве автора больше половины текстур шрифта — старые варианты фона и тестовые
    # картинки. В пак кладём только то, на что ссылается font/custom.json.
    font = json.loads((out / "assets/omg_font/font/custom.json").read_text(encoding="utf-8"))
    used = {out / "assets/omg_font/textures" / p["file"].split(":", 1)[1] for p in font["providers"] if "file" in p}
    textures = out / "assets/omg_font/textures"
    for f in [f for f in textures.rglob("*") if f.is_file() and f not in used]:
        f.unlink()
    for d in sorted((d for d in textures.rglob("*") if d.is_dir()), key=lambda d: len(d.parts), reverse=True):
        if not any(d.iterdir()):
            d.rmdir()
    # Демо-строки автора (enchantment.omg_font.*) нигде не используются.
    lang = out / "assets/minecraft/lang/en_us.json"
    write_json(lang, {k: v for k, v in json.loads(lang.read_text(encoding="utf-8")).items()
                      if not k.startswith("enchantment.omg_font.")})

    icon = ROOT / "pack.png" if (ROOT / "pack.png").exists() else src / "pack.png"
    if icon.exists():
        shutil.copyfile(icon, out / "pack.png")


def write_pack_meta(out, description, version):
    # Один pack.mcmeta на датапак и ресурспак: у них разные номера форматов,
    # поэтому диапазон покрывает оба (26.3: ресурсы 97, данные 121).
    lo, hi = sorted((version["resource"], version["data"]))
    write_json(out / "pack.mcmeta", {"pack": {"description": description, "min_format": lo, "max_format": hi}})


def make_zip(pack_dir):
    zip_path = pack_dir.with_suffix(".zip")
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as z:
        for f in sorted(pack_dir.rglob("*")):
            if f.is_file() and f.name != ".generated":
                z.write(f, f.relative_to(pack_dir).as_posix())
    return zip_path


def remove_stale_outputs(out_root, ns):
    """Убрать результаты старых сборок, где было 4 отдельных пака."""
    for name in (f"{ns}-datapack", f"{ns}-resourcepack", "bone_msd-datapack", "bone_msd-resourcepack"):
        d = out_root / name
        if (d / ".generated").exists():
            shutil.rmtree(d)
        z = out_root / f"{name}.zip"
        if z.exists():
            z.unlink()


def install(zip_path, ns, world):
    """Положить пак в <мир>/datapacks и в resourcepacks того же инстанса, убрав старые версии."""
    world = world.expanduser().resolve()
    if not (world / "level.dat").exists():
        raise BuildError(f"{world} — не папка мира (нет level.dat)")
    resourcepacks = world.parent.parent / "resourcepacks"  # <инстанс>/saves/<мир> -> <инстанс>/resourcepacks
    old = {f"{ns}-datapack", f"{ns}-resourcepack", "bone_msd-datapack", "bone_msd-resourcepack", ns}
    for target in (world / "datapacks", resourcepacks):
        target.mkdir(exist_ok=True)
        for entry in target.iterdir():
            if entry.name.removesuffix(".zip") in old:
                shutil.rmtree(entry) if entry.is_dir() else entry.unlink()
                print(f"  удалён старый {entry}")
            elif entry.name.startswith(("bone-msd-26-5", "bone-msd-example-pack")):
                warn(f"{entry} — оригинал автора, в 26.3 он ломает мир (безопасный режим). Уберите его.")
        shutil.copyfile(zip_path, target / zip_path.name)
        print(f"  установлен {target / zip_path.name}")
    print(f"Включите ресурспак «{zip_path.stem}» в настройках, если он ещё не включён, и перезайдите в мир.")


def main():
    ap = argparse.ArgumentParser(description="Собрать кастомные блоки BONE:MSD из blocks.json")
    ap.add_argument("--config", default=ROOT / "blocks.json", type=Path)
    ap.add_argument("--out", default=ROOT / "build", type=Path)
    ap.add_argument("--free-retired", action="store_true",
                    help="снова разрешить выдавать слоты удалённых блоков (старые блоки в мире подменятся новыми!)")
    ap.add_argument("--no-zip", action="store_true")
    ap.add_argument("--install", type=Path, metavar="ПАПКА_МИРА",
                    help="сразу установить пак в мир (datapacks) и в resourcepacks его инстанса")
    args = ap.parse_args()

    try:
        cfg, ns, blocks = load_config(args.config)
        print(f"Блоков: {len(blocks)}, namespace: {ns}")
        slots = assign_slots(blocks, cfg, args.config.with_name("slots.lock.json"), args.free_retired)

        version = VERSIONS[cfg.get("minecraft_version", "26.3")]
        out = args.out / ns
        remove_stale_outputs(args.out, ns)
        prepare_dir(out)
        copy_engine(out)
        build(ns, blocks, slots, out)
        write_pack_meta(out, cfg.get("description", "Custom blocks for BONE:MSD"), version)
        for b in blocks:
            slab, wet = slots[b.id]
            print(f"  {b.id:<24} -> {slab}[type=double{',waterlogged=true' if wet else ''}]")
        print(f"Готово (Minecraft {cfg.get('minecraft_version', '26.3')}): {out}")
        if args.no_zip:
            return
        zip_path = make_zip(out)
        print(f"  {zip_path}")
        if args.install:
            install(zip_path, ns, args.install)
        else:
            print("Один и тот же zip кладётся в <мир>/datapacks и в resourcepacks (или используйте --install <мир>).")
    except BuildError as e:
        print(f"Ошибка: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
