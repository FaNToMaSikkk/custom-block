# Custom-Block — custom blocks for BONE:MSD, one line each

**English** · [Русский](README.ru.md)

> This project was built with the help of [Claude Code](https://claude.com/claude-code), Anthropic's AI coding assistant.
> That covers the generator, the port of the BONE:MSD engine to Minecraft 26.3, the tests and this documentation.

Describe your blocks as a list in `blocks.json`, like enum values. The generator
builds everything else: the block item, loot tables, the creative-menu entry, models,
translations, and the vanilla overrides. The output is a single pack
for **Minecraft 26.3** that already includes the BONE:MSD engine.

```
Custom-Block/
├── blocks.json          ← your block "enum" (edit this)
├── textures/            ← 16×16 PNG textures (put them here)
├── slots.lock.json      ← which slab each block occupies (auto-generated, do NOT delete)
├── generator/build.py   ← the generator
├── engine-patches/26.3/ ← fixes that port the BONE:MSD engine to Minecraft 26.3
├── tests/               ← build check on a real 26.3 server, no client needed
├── build/               ← output: custom_blocks.zip (recreated on every build)
└── extension/           ← original BONE:MSD engine, author's example and PDF (reference, do not edit)
```

## Quick start

1. Put a texture into `textures/`, e.g. `textures/marble.png`.
2. Add an entry to `blocks.json`:
   ```json
   { "id": "marble", "name": { "en_us": "Marble", "ru_ru": "Мрамор" }, "material": "stone", "texture": "marble" }
   ```
3. Build and install into a world:
   ```bash
   python3 generator/build.py --install "<path to the world folder>"
   ```
4. **Rejoin the world.** `/reload` is not enough: new creative-menu entries (paintings) are
   registered only when a world loads. If you only changed textures or models, F3+T is enough.

To get the blocks: `/function custom_blocks:give_all` or `/function custom_blocks:give/<id>`.
In creative they are among the paintings in the *Functional Blocks* tab.

Requires Python 3.9+ (standard library only). Generator messages are in Russian.

## Block fields

| Field | Required | Meaning |
|---|---|---|
| `id` | yes | Block name: `a-z`, `0-9`, `_`. Renaming it loses blocks already placed in worlds. |
| `name` | no | A string (en_us) or `{ "en_us": "...", "ru_ru": "..." }`. Derived from `id` by default. |
| `title` | no | Creative-menu caption. Only `A-Z a-z 0-9` and space, because the engine font has nothing else. Defaults to `name.en_us`. |
| `material` | no | `wood` · `stone` (default) · `copper` · `wool` · `concrete`. Sets sound, hardness, required tool and flammability. |
| `texture` | * | One texture on all sides (model `cube_all`). |
| `model` + `textures` | * | `cube_column` (`side`, `end`) · `cube_bottom_top` (`side`, `top`, `bottom`) · `cube` (`up`, `down`, `north`, `south`, `east`, `west`, optional `particle`). |
| `model_file` | no | Path to your own JSON model (e.g. from Blockbench), relative to `Custom-Block/`. Entries from `textures` are merged into it. The model must still be a full cube (see Limitations). |
| `drop` | no | Another loot table to drop instead, e.g. `minecraft:blocks/oak_planks`. By default the block drops itself. |
| `creative` | no | `false` hides the block from the creative menu. |
| `slab` / `waterlogged` | no | Pin the block to a specific slab, e.g. `"slab": "oak_slab"`. Rarely needed. |

\* either `texture` or `textures` is required.

A texture value without `:` is the file `textures/<name>.png`. You can put a `.png.mcmeta`
next to it for animation. A value with `:` is an existing texture, e.g. `minecraft:block/calcite`.

Global settings in `blocks.json`:
- `namespace` — namespace of the generated content (`custom_blocks`);
- `description` — pack description;
- `minecraft_version` — only `26.3` for now. It selects the pack format numbers and the
  data syntax: 26.3 changed loot tables and predicates a lot (`modifier`, `condition`, `match_block`);
- `use_waterlogged_slots` — also use the second, waterlogged state of each slab. Off by default:
  the PDF lists bugs for these states;
- `reserved_slabs` — slabs the generator must not touch because another pack uses them.

## How it works

**Slots.** Every block occupies the `<slab>[type=double]` state of one vanilla slab. The
BONE:MSD engine turns player-made double slabs into full blocks, so this state is free in the
world. The resource pack draws your model on it, and the data pack replaces its drop. The block
has no entity: it is fast, can be pushed by pistons and does not desync.

Available slots per material: wood 13, stone 45, copper 4, wool 16, concrete 16. With
`use_waterlogged_slots` there are twice as many.

**Stable slots.** A slot is assigned once and stored in `slots.lock.json`, so the order of
`blocks.json` does not matter. When a block is removed, its slot is *retired* and never given to
a new block; otherwise blocks already placed in worlds would turn into the new one. To reuse
retired slots anyway: `python3 generator/build.py --free-retired`.

**Placing.** The block item is a barrier carrying `bone_cb` data. The engine catches the barrier
being placed, puts a command block in its spot, and on the next tick that command block places the
real block.

**Engine port.** The original engine (`extension/bone-msd-26-5`) does **not load** in 26.3:
the world opens in safe mode with `Failed to parse bone_msd:block_engine/placed_block`. The
generator copies the engine and applies `engine-patches/26.3/` on top:
- the new `placed_block` advancement format;
- the new `item modify` syntax in `update_slot`;
- five redstone block tags that were missing from the author's archive.

Only files the engine actually uses go into the pack. The author's drafts (`*-old`),
unused font textures and demo strings stay out.

**One pack, both roles.** Data packs and resource packs have different format numbers in 26.3
(121 and 97), but the pack has one `pack.mcmeta`. So it declares the range
`min_format: 97`, `max_format: 121`. The game's own code reports the pack as compatible in both
roles; this was checked.

## Installation

`build/custom_blocks.zip` is the only file you need: one zip with `data/` and `assets/`.

**Automatic:** `--install` (see Quick start) copies the zip into `<world>/datapacks/` and into the
`resourcepacks/` folder of the same game instance. It also removes older versions of these packs and
warns if the author's originals are still there. Enable the resource pack once in the game settings.

**Manual:** copy `custom_blocks.zip` into `<world>/datapacks/` **and** into `resourcepacks/`.

Do **not** install the original `bone-msd-26-5` or the author's `bone-msd-example-pack` together
with this pack. The original engine breaks 26.3 worlds, and the example overrides the same
`items/painting.json`.

If something does not work, check the instance's `logs/latest.log`. Lines with `Missing data pack`,
`Failed to load function`, `Failed to parse` or `Missing block model` point to the cause.

## Creative-menu tooltip (omg_font)

`omg_font` is a font from the engine's resource pack. Its "characters" are pictures:
- `…` — 47-pixel-tall background pieces that look like a vanilla tooltip
  (dark fill, purple border);
- `…` — spaces, including negative ones;
- `A-Z a-z 0-9` — large letters.

In creative a block is a painting, and its tooltip is: *Painting* / variant title / author /
size. The variant title is written in this font. Its background reaches upward, covers the
*Painting* line and draws a fake tooltip with the block name. The background width is fitted
to the name (`painting_title` in the generator).

Lines **after** the title are drawn later, i.e. on top of the fake tooltip:
- **Painting size** ("16x16"). The engine blanked it for English only, so in other languages it
  showed through. The generator now blanks it for every language, which hides the size of
  vanilla paintings too.
- **Advanced tooltips (F3+H)**: `minecraft:painting` and the component count. A pack cannot
  remove them; turn F3+H off for a clean tooltip.

## Testing without the game client

```bash
python3 tests/run_gametest.py
```
The script takes Java and the 26.3 jar from Prism Launcher and starts Minecraft's built-in
GameTest server with the pack from `build/` plus the test pack `tests/cbtest`. In about 10 seconds
it checks:
- that the pack loads without errors or warnings;
- that the block item carries `bone_cb`;
- barrier → command block → placed block;
- drops of custom blocks and of ordinary slabs;
- painting → block item conversion.

The test targets the example blocks `split_oak` and `engraved_copper`. The resource pack
cannot be checked this way; only the game client renders it.

## Limitations

- **Full blocks only.** A block is a double slab, so its hitbox, collision and occlusion are
  always a full cube. A non-cube `model_file` only changes the picture and leaves see-through gaps
  in the world. Custom slabs and stairs need a different mechanism: the only unobtainable slab is
  `petrified_oak_slab`, and there are no unobtainable stairs. They are not implemented yet.
- Textures must be opaque: slabs render as solid blocks.
- Middle-click in creative picks the vanilla slab, not your block.
- When a player builds a double slab of the same type, the custom block flashes for 1 tick
  (a known engine issue).
- Double slabs that already exist in a world, or that world generation creates, become custom
  blocks. That is why rare slabs (pale_oak, bamboo_mosaic, resin_brick…) are used first.
- The engine places blocks through command blocks: a server needs `enable-command-block=true`.
- The engine keeps the block being placed in one shared storage. If two players place custom
  blocks in the very same tick, both get the second one.

## Credits

BONE:MSD ("Bhex's Over-Named Extension for Mod-Sized Datapacks") is by Bhex. The original
engine, its example pack and documentation are in `extension/`, unmodified; the textures in
`textures/` come from that example pack. They are third-party work and are not covered by
this project; all rights belong to their author. They will be removed on the author's request.
