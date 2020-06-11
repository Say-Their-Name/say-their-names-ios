#!/bin/sh

## About
## Run this script from the root of the repo
## Run this script after updating translations on localise.biz

function download_url {
  echo "https://localise.biz/api/export/locale/$1.strings?format=xcode&fallback=en&charset=utf8"
}

function destination_path {
  echo "SayTheirNames/Resources/$1.lproj/Localizable.strings"
}

# this key is read-only so can be shared.
# created by @hybridcattt
KEY="L1dFmJVo4QFj08yySbMQWMo-RIvWcnZ5"

LANGS=( "en" "ru" "pt-BR" "ar" "fr" "ko" )

echo "\nDownlading Base ...."
curl -u $KEY: $(download_url "en") > $(destination_path "Base")

for lang in "${LANGS[@]}"; do
  echo "\nDownlading $lang ...."
  curl -u $KEY: $(download_url $lang) > $(destination_path $lang)
done
