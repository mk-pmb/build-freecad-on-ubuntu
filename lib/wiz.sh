#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-
SELFFILE="$(readlink -m "$BASH_SOURCE")"
SELFPATH="$(dirname "$SELFFILE")"

source "$SELFPATH"/../i18n/lib_locale.sh --lib || exit $?


function wiz_main () {
  cd "$SELFPATH" || return $?
  local RESTART=( "$SELFFILE" "$@" )

  lib_locale_seo "$1" || shift

  local RUNMODE="${1:-help}"; shift
  case "$RUNMODE" in
    '' | --help | \
    help )
      # Show how to use this wizard.
      wiz_help; return 0;;
    deps ) #arg: <edition>
      # Install the selected edition ("stable" or "daily") of FreeCAD
      # from the PPA, and the dependencies required to build and run it.
      inst_dep_pkgs "$@"; return $?;;
  esac

  echo 'E: Unsupported runmode, try: --help'
  return 2
}


function wiz_help () {
  ( echo "Invocation: ./$(basename "$SELFFILE") [+locale] runmode [args…]"
    echo "Available runmodes:"
    sed -nrf "$SELFPATH"/help.runmodes.sed -- "$SELFFILE"
  ) | lib_locale_trans_sed wiz.runmodes | sed -re '
    s~\s*\t~\n                                   \t~g
    s~\n~~
    s~(^|\n)([^\t\n]{20}) *\t~\1   \2~g
    s~(^|\n)( ?)~\1H: \2\2~g
    '
}


function inst_dep_pkgs () {
  local EDITION="$1"; shift
  local EDI_SUFX=
  case "$EDITION" in
    stable ) ;;
    daily )
      EDI_SUFX="-$EDITION";;
    * )
      echo 'E: expected CLI argument: edition: must either' \
        '"stable" or "daily".' >&2
      return 2;;
  esac

  local DEV_PKGS=(
    freecad"$EDI_SUFX"
    )

  cd /    # avoid getcwd problems with sudo on FUSE
  [ "$(whoami)" == root ] || exec sudo -E "${RESTART[@]}" || return $?

  local PPA_URL="ppa:freecad-maintainers/freecad-$EDITION"
  add-apt-repository --enable-source "$PPA_URL" || return $?
  apt-get update || return $?

  apt-get build-dep "$PKG_NAME" || return $?

  can_has_cmd cmake-gui || DEV_PKGS+=( cmake-qt-gui )
  DEV_PKGS+=(
    python-dev
    )
  apt-get install "${DEV_PKGS[@]}" || return $?

  echo 'Done! Now configure.sh and make.sh should work.'
  return 0
}


function can_has_cmd () {
  which "$@" 2>/dev/null | grep -qPe '^/'; return $?
}










[ "$1" == --lib ] && return 0; wiz_main "$@"; exit $?
