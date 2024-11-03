<<<<<<< HEAD
#!/bin/bash
#
# Using HTML-proofer to test site.
#
# Requirement: https://github.com/gjtorikian/html-proofer
#
# Usage: bash /path/to/test.sh [indicated path]
#
# v2.0
# https://github.com/cotes2020/jekyll-theme-chirpy
# © 2020 Cotes Chung
# MIT Licensed

DEST=_site
URL_IGNORE=cdn.jsdelivr.net

_build=false

help() {
  echo "Usage:"
  echo
  echo "   bash ./tools/test.sh [options]"
  echo
  echo "Options:"
  echo "     --build                  Run Jekyll build before test."
  echo "     -d, --dir   <path>       Specify the test path."
  echo "     -h, --help               Print this information."
}

if [[ -n $1 && -d $1 ]]; then
  DEST=$1
fi
=======
#!/usr/bin/env bash
#
# Build and test the site content
#
# Requirement: html-proofer, jekyll
#
# Usage: See help information

set -eu

SITE_DIR="_site"

_config="_config.yml"

_baseurl=""

help() {
  echo "Build and test the site content"
  echo
  echo "Usage:"
  echo
  echo "   bash $0 [options]"
  echo
  echo "Options:"
  echo '     -c, --config   "<config_a[,config_b[...]]>"    Specify config file(s)'
  echo "     -h, --help               Print this information."
}

read_baseurl() {
  if [[ $_config == *","* ]]; then
    # multiple config
    IFS=","
    read -ra config_array <<<"$_config"

    # reverse loop the config files
    for ((i = ${#config_array[@]} - 1; i >= 0; i--)); do
      _tmp_baseurl="$(grep '^baseurl:' "${config_array[i]}" | sed "s/.*: *//;s/['\"]//g;s/#.*//")"

      if [[ -n $_tmp_baseurl ]]; then
        _baseurl="$_tmp_baseurl"
        break
      fi
    done

  else
    # single config
    _baseurl="$(grep '^baseurl:' "$_config" | sed "s/.*: *//;s/['\"]//g;s/#.*//")"
  fi
}

main() {
  # clean up
  if [[ -d $SITE_DIR ]]; then
    rm -rf "$SITE_DIR"
  fi

  read_baseurl

  # build
  JEKYLL_ENV=production bundle exec jekyll b \
    -d "$SITE_DIR$_baseurl" -c "$_config"

  # test
  bundle exec htmlproofer "$SITE_DIR" \
    --disable-external \
    --ignore-urls "/^http:\/\/127.0.0.1/,/^http:\/\/0.0.0.0/,/^http:\/\/localhost/"
}
>>>>>>> v7.1.1

while (($#)); do
  opt="$1"
  case $opt in
<<<<<<< HEAD
    --build)
      _build=true
      shift
      ;;
    -d | --dir)
      if [[ ! -d $2 ]]; then
        echo -e "Error: path '$2' doesn't exist\n"
        help
        exit 1
      fi
      DEST=$2
      shift
      shift
      ;;
    -h | --help)
      help
      exit 0
      ;;
    *)
      # unknown option
      help
      exit 1
      ;;
  esac
done

if $_build; then
  JEKYLL_ENV=production bundle exec jekyll b
fi

bundle exec htmlproofer "$DEST" \
  --disable-external \
  --check-html \
  --empty_alt_ignore \
  --allow_hash_href \
  --url_ignore $URL_IGNORE
=======
  -c | --config)
    _config="$2"
    shift
    shift
    ;;
  -h | --help)
    help
    exit 0
    ;;
  *)
    # unknown option
    help
    exit 1
    ;;
  esac
done

main
>>>>>>> v7.1.1
