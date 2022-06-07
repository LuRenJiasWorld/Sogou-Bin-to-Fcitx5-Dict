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

libime_pinyindict -d ~/.local/share/fcitx5/pinyin/user.dict "${TMP_DIR}/fcitx_backup.txt"

cat "${TMP_DIR}/fcitx_backup.txt" > "${TMP_DIR}/user_dict.txt"
cat "${TMP_DIR}/sogou_backup_fixed.txt" >> "${TMP_DIR}/user_dict.txt"

mv ~/.local/share/fcitx5/pinyin/user.dict ~/.local/share/fcitx5/pinyin/user.dict.bak

libime_pinyindict "${TMP_DIR}/user_dict.txt" ~/.local/share/fcitx5/pinyin/user.dict

echo "转换成功！"

ls -lh ~/.local/share/fcitx5/pinyin/
