# Sogou-Bin-to-Fcitx5-Dict
> 在 Linux 下将搜狗拼音导出的 Bin 自定义词库转换为 Fcitx5 的 Dict 文件

## 使用步骤
1. 搜狗输入法设置->词库->导出/备份
2. 安装 .NET 3.0 运行时
    1. 在微软官网下载 [dotnet-install.sh](https://dot.net/v1/dotnet-install.sh) 脚本
    2. 赋予可执行权限，并执行安装操作
        ```bash
        chmod +x ./dotnet-install.sh
        sudo ./dotnet-install.sh --install-dir /usr/share/dotnet --channel 3.0
        ```

    3. 等待片刻，执行以下操作检查是否安装成功
        ```bash
        # 如果出现 ICU 相关的报错，请配置此环境变量，或者参考 https://github.com/dotnet/core/issues/2186#issuecomment-472559583 设置配置文件
        export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
        dotnet --version
        ```
2. 下载 [studyzy/imewlconverter: 一款开源免费的输入法词库转换程序](https://github.com/studyzy/imewlconverter)
```bash
mkdir imewlconverter
cd imewlconverter
wget https://github.com/studyzy/imewlconverter/releases/download/v2.9.0/imewlconverter_Linux_Mac.tar.gz
tar -zxvf ./imewlconverter_Linux_Mac.tar.gz
# 问号在部分 Shell 下有其他特殊含义，需要转义
./ImeWlConverterCmd -\?
```
> 以下步骤可以直接使用 `sogou-pinyin-to-fcitx5-dict.sh` 简化:
> ```bash
> ./sogou-pinyin-to-fcitx5-dict.sh ~/Downloads/sogou_backup.bin
> ```
3. 将搜狗输入法导出的 `.bin` 文件转换为 Fcitx 可以转换的 `.txt` 文件
```bash
./ImeWlConverterCmd -i:sgpybin ~/Downloads/sogou_backup.bin -o:self ~/Downloads/sogou_backup.txt "-f:213' nyyy" -r:baidu
```
4. 运行 `fcitx-txt-fix.sh` 将导出出来不兼容的拼音进行修复
```bash
./fcitx-txt-fix.sh ~/Downloads/sogou_backup.txt > ~/Downloads/sogou_backup_fixed.txt
```
5. **可选** 导出用户已有的 Fcitx 词库，以便和即将导入的词库合并
```bash
libime_pinyindict -d ~/.local/share/fcitx5/pinyin/user.dict ~/Downloads/fcitx_backup.txt
cat ~/Downloads/fcitx_backup.txt > ~/Downloads/user_dict.txt
cat ~/Downloads/sogou_backup_fixed.txt >> ~/Downloads/user_dict.txt
```
6. 将 `.txt` 词库文件转换为 `.dict` 文件
```bash
libime_pinyindict ~/Downloads/user_dict.txt ~/Downloads/user.dict
```

## License
```
           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                   Version 2, December 2004
 
Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.
 
           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 0. You just DO WHAT THE FUCK YOU WANT TO.
```
