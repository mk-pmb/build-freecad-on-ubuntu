#!/bin/sed -nurf
# -*- coding: UTF-8, tab-width: 2 -*-

: skip
  /^\s*case \S*RUNMODE\S in$/b bash_runmodes_case
  n
b skip

: bash_runmodes_case
  n;s~\s+~ ~g
  /^ ?esac ?$/q
  /^ [a-z]\S+ \)/!b bash_runmodes_case
  s~^ (\S+) \)( #arg:|)~\1~
: bash_runmodes_explain
  N;s~\n\s*# ~\t~
  /\n/!b bash_runmodes_explain
  s~\n.*$~~
  p
b bash_runmodes_case





