#!/Users/gabrielfalcao/.shell.d/.venv/bin/python3

import sys
import click
import re
import shutil
import os
import json
import math
import subprocess
import urllib
import urllib.parse
import dataclasses

from pprint import pformat
from decimal import Decimal
from datetime import datetime, timedelta, UTC
from dataclasses import dataclass, field
from typing import List, Dict, Tuple, Union, Optional, Self
from pathlib import Path
from subprocess import Popen


@click.command()
@click.option('-g', '--get-text-of-pane-id', type=int)
def main(get_text_of_pane_id):
    """
    retrieves all output from one wezterm pane at a timex
    """
    if isinstance(get_text_of_pane_id, int):
        wz = wezterm(pane_id=get_text_of_pane_id)
        output = wz.get_text()
        print(output)
        raise SystemExit(0)

    sys.stderr.write("gathering output of wezterm panes...\n")
    sys.stderr.flush()
    panes = sorted(wezterm.list_panes())
    now = datetime.now(UTC)
    today = now.strftime("%Y-%m-%d")
    ts = int(now.strftime("%s"))
    target_dirs = [
        # Path("~/workbench").expanduser().absolute().joinpath(today),
        Path(f"~/workbench/{today}").expanduser().absolute().joinpath(f"wezterm-wip-{today}"),
    ]
    json_dump_output_paths_safe = dict()
    for directory in target_dirs:
        directory.mkdir(parents=True, exist_ok=True)
        if today not in str(directory):
            json_output_path = directory.joinpath(f"wezterm-panes.{today}.{ts}.json")
        else:
            json_output_path = directory.joinpath(f"wezterm-panes.{ts}.json")

        if json_output_path not in json_dump_output_paths_safe:
            json_dump_output_paths_safe[str(json_output_path)]=json_output_path

    for json_output_path in json_dump_output_paths_safe.values():
        with json_output_path.open("w") as fd:
            fd.write(json.dumps(panes, indent=4, default=dataclassy_json))

        sys.stderr.write(f"wezterm panes's date written to ")
        sys.stderr.flush()
        sys.stdout.write(f"{json_output_path}\n")
        sys.stdout.flush()


if __name__ == "__main__":
    main()


panes = sorted(wezterm.list_panes())
first_pane = panes[0]
last_pane = panes[-1]
