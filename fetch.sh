#!/usr/bin/env bash
mkdir -p ./queries/c3/
curl 'https://raw.githubusercontent.com/c3lang/tree-sitter-c3/refs/heads/main/queries/highlights.scm' > ./queries/c3/highlights.scm

mkdir -p ./queries/nu/
curl 'https://raw.githubusercontent.com/nushell/tree-sitter-nu/refs/heads/main/queries/nu/highlights.scm' > ./queries/nu/highlights.scm
curl 'https://raw.githubusercontent.com/nushell/tree-sitter-nu/refs/heads/main/queries/nu/indents.scm' > ./queries/nu/indents.scm
curl 'https://raw.githubusercontent.com/nushell/tree-sitter-nu/refs/heads/main/queries/nu/injections.scm' > ./queries/nu/injections.scm
