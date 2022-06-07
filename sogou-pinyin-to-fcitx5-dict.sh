#!/bin/bash

SOGOU_DICT_FILE=$1
TMP_DIR='/tmp/sogou-pinyin-to-fcitx5-dict'

export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

mkdir -p $TMP_DIR

./imewlconverter/ImeWlConverterCmd \
    -i:sgpybin "$1" \
    -o:self "${TMP_DIR}/sogou_backup.txt" \
    "-f:213' nyyy" \
    -r:baidu

./fcitx-txt-fix.sh "${TMP_DIR}/sogou_backup.txt" > "${TMP_DIR}/sogou_backup_fixed.txt"

libime_pinyindict "${TMP_DIR}/sogou_backup_fixed.txt" ~/.local/share/fcitx5/pinyin/dictionaries/sogou.dict

echo "转换成功！"

ls -lh ~/.local/share/fcitx5/pinyin/dictionaries
