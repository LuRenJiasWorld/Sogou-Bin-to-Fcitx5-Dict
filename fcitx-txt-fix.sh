#!/bin/bash

# 搜狗词库的拼音用u表示ü，但fcitx用v表示ü
cat $1 \
    | sed -e 's/lue/lve/g' \
    | sed -e 's/nue/nve/g'
