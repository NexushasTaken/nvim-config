#!/usr/bin/env bash
get() {
  local out=$1
  local url=$2
  mkdir -p $(dirname "$out")
  if [[ ! -f "$out" ]]; then
    wget --passive-ftp -c -O "$out" "$url"
  fi
}

get "./queries/c3/highlights.scm" "https://raw.githubusercontent.com/c3lang/tree-sitter-c3/refs/heads/main/queries/highlights.scm"
get "./queries/nu/highlights.scm" "https://raw.githubusercontent.com/nushell/tree-sitter-nu/refs/heads/main/queries/nu/highlights.scm"
get "./queries/nu/indents.scm" "https://raw.githubusercontent.com/nushell/tree-sitter-nu/refs/heads/main/queries/nu/indents.scm"
get "./queries/nu/injections.scm" "https://raw.githubusercontent.com/nushell/tree-sitter-nu/refs/heads/main/queries/nu/injections.scm"
get "./dictionary/words.txt" "https://raw.githubusercontent.com/dwyl/english-words/refs/heads/master/words.txt"
