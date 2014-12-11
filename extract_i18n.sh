#!/bin/bash
find . -name '*.mo' -delete
mkdir -p unicorecmsstraighttalk/locale

pot-create -o unicorecmsstraighttalk/locale/unicorecmsstraighttalk.pot unicorecmsstraighttalk/

declare -a arr=("eng_GB")

for lang in "${arr[@]}"
do
    mkdir -p "unicorecmsstraighttalk/locale/""$lang""/LC_MESSAGES"

    if [ ! -f "unicorecmsstraighttalk/locale/""$lang""/LC_MESSAGES/unicorecmsstraighttalk.po" ]; then
        msginit -l $lang -i unicorecmsstraighttalk/locale/unicorecmsstraighttalk.pot -o unicorecmsstraighttalk/locale/$lang/LC_MESSAGES/unicorecmsstraighttalk.po
    fi

    msgmerge --update unicorecmsstraighttalk/locale/$lang/LC_MESSAGES/unicorecmsstraighttalk.po unicorecmsstraighttalk/locale/unicorecmsstraighttalk.pot
    msgfmt unicorecmsstraighttalk/locale/$lang/LC_MESSAGES/*.po -o unicorecmsstraighttalk/locale/$lang/LC_MESSAGES/unicorecmsstraighttalk.mo
done
