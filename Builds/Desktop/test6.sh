#!/bin/sh
echo -ne '\033c\033]0;Artillery Command\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/test6.x86_64" "$@"
