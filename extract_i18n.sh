#!/bin/bash
find . -name '*.mo' -delete
mkdir -p unicorecmsapp/locale

pot-create -o unicorecmsapp/locale/unicorecmsapp.pot unicorecmsapp/

declare -a arr=("eng_GB")

for lang in "${arr[@]}"
do
    mkdir -p "unicorecmsapp/locale/""$lang""/LC_MESSAGES"

    if [ ! -f "unicorecmsapp/locale/""$lang""/LC_MESSAGES/unicorecmsapp.po" ]; then
        msginit -l $lang -i unicorecmsapp/locale/unicorecmsapp.pot -o unicorecmsapp/locale/$lang/LC_MESSAGES/unicorecmsapp.po
    fi

    msgmerge --update unicorecmsapp/locale/$lang/LC_MESSAGES/unicorecmsapp.po unicorecmsapp/locale/unicorecmsapp.pot
    msgfmt unicorecmsapp/locale/$lang/LC_MESSAGES/*.po -o unicorecmsapp/locale/$lang/LC_MESSAGES/unicorecmsapp.mo
done
