#!/usr/bin/env python3
"""Проверка собранных датапаков на настоящем сервере Minecraft 26.3 без запуска клиента.

Берёт клиентский jar и Java из Prism Launcher, запускает встроенный GameTest-сервер
(net.minecraft.gametest.Main) с паком из build/ и тестовым паком tests/cbtest.
Тест cbtest:flow проходит путь блока: выдача предмета -> barrier -> command_block ->
установка -> дроп. Тест рассчитан на примеры из blocks.json (split_oak, engraved_copper)
и их слоты в slots.lock.json.

Запуск (из папки Custom-Block, после generator/build.py):  python3 tests/run_gametest.py
"""
import json
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PRISM = Path.home() / ".var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher"
VERSION = "26.3"
EXPECTED_OK = 10  # сколько строк «T<n> OK» печатает cbtest при успехе


def classpath():
    meta = json.loads((PRISM / "meta/net.minecraft" / f"{VERSION}.json").read_text())
    jars = []
    for lib in meta["libraries"]:
        group, name, ver = lib["name"].split(":")[:3]
        jar = PRISM / "libraries" / group.replace(".", "/") / name / ver / f"{name}-{ver}.jar"
        if jar.exists():
            jars.append(str(jar))
    jars.append(str(PRISM / f"libraries/com/mojang/minecraft/{VERSION}/minecraft-{VERSION}-client.jar"))
    return ":".join(jars)


def main():
    java = next((PRISM / "java").glob("*/bin/java"), None)
    if java is None or not (PRISM / "meta/net.minecraft" / f"{VERSION}.json").exists():
        sys.exit(f"Не найден Prism Launcher с Minecraft {VERSION} и Java в {PRISM}")
    packs = sorted(p for p in (ROOT / "build").iterdir() if (p / ".generated").exists())
    if not packs:
        sys.exit("Нет собранного пака в build/ — сначала запустите generator/build.py")

    with tempfile.TemporaryDirectory(prefix="cbtest-") as tmp:
        tmp = Path(tmp)
        for p in packs + [ROOT / "tests" / "cbtest"]:
            shutil.copytree(p, tmp / "packs" / p.name)
        result = subprocess.run(
            [str(java), "-cp", classpath(), "net.minecraft.gametest.Main",
             "--packs", str(tmp / "packs"), "--tests", "cbtest:*", "--universe", str(tmp / "universe")],
            cwd=tmp, capture_output=True, text=True, timeout=300)
    log = result.stdout + result.stderr

    benign = ("Unsafe", "Can't keep up!")  # предупреждения JVM и лаг сервера под нагрузкой
    problems = [line for line in log.splitlines()
                if re.search(r"/(ERROR|WARN)\]", line) and not any(b in line for b in benign)]
    oks = [line.split("] ", 2)[-1] for line in log.splitlines() if re.search(r"\] T\d+ OK", line)]
    for line in oks:
        print("  ok  ", line)
    for line in problems:
        print("  !!  ", line[:300])
    passed = "All 1 required tests passed" in log and len(oks) == EXPECTED_OK and not problems
    print(f"\n{'ПРОЙДЕНО' if passed else 'ПРОВАЛ'}: {len(oks)}/{EXPECTED_OK} проверок, проблем в логе: {len(problems)}")
    if not passed:
        (ROOT / "tests" / "last_gametest.log").write_text(log, encoding="utf-8")
        print("Полный лог: tests/last_gametest.log")
        sys.exit(1)


if __name__ == "__main__":
    main()
