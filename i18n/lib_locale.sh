#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function lib_locale_seo () {
  local OPT_KEEP_LOCALE='+locale'
  [ "$1" == "$OPT_KEEP_LOCALE" ] && return 1

  local ORIG_LANG="${LANGUAGE:-$LANG}"
  # ^-- No need to export: Apply SEO to this wizard as well.
  #     There's opt-out, after all.

  LANGUAGE=en_US  # make error messages search engine-friendly
  LANG="$LANGUAGE".UTF-8
  export LANG{,UAGE}

  case "${ORIG_LANG,,}" in
    en_* ) ;;

  # ----- 8< ----- BEGIN translations ----- 8< -----

    de_* )
      echo "I: Gleich geht's auf English weiter, damit im Fall von" \
        "Fehlermeldungen deine Suchmaschine bessere Ergebnisse dafür findet."
      echo "H: Wenn du lieber Deutsch beibehalten möchtest, gib als" \
        "ersten Parameter '+locale' an."
      ;;

  # ----- >8 ----- ENDOF translations ----- >8 -----

    * )
      echo "I: Switching language to English (USA)" \
        "for better search engine results in case of errors."
      echo "H: If you prefer your default language '$ORIG_LANG'," \
        "give '+locale' as the first argument."
      ;;
  esac
  return 0
}


function lib_locale_trans_sed () {
  local VOC_FN="$1"; shift
  local HELP_LANG="${LANGUAGE:-$LANG}"
  HELP_LANG="${HELP_LANG:0:2}"
  HELP_LANG="${HELP_LANG,,}"
  VOC_FN="$(readlink -m "$BASH_SOURCE"/..)/$HELP_LANG/$VOC_FN.txt"
  if [ ! -f "$VOC_FN" ]; then cat; return $?; fi
  local HELP_SED='
    /^\s+t"/{
      i\  s~\\t.*$~~
      : add_tab_lines
        s~[^ -%*-Z_-z]~\\&~g
        s~t"~s|\$|\\t~
        s~$~|~
        p;n
      /^\s+t"/b add_tab_lines
    }
    p'
  HELP_SED="$(sed -nrf <(echo "$HELP_SED") -- "$VOC_FN")"
  # nl -ba <<<"$HELP_SED" >&2
  # nl -ba >&2 | \
  sed -rf <(echo "$HELP_SED")
  return $?
}














[ "$1" == --lib ] && return 0; lib_locale_"$@"; exit $?
