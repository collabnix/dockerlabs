#!/bin/bash

printUsage() {
  echo "Usage: $0 <url or @file_path>"
}

[ $# -ne 1 ] && printUsage && exit 1

in_file="$1"

curl -H "Content-Type: text/html; charset=utf-8" --data-binary "${in_file}"  https://validator.w3.org/nu/?out=json | sed -e 's/,/\n/g'

