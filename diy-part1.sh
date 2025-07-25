#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 取消注释 helloworld feed（如果存在被注释的）
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# 添加 helloworld feed（如果不存在）
grep -q "src-git helloworld" feeds.conf.default || echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default

# 添加 passwall feed（如果不存在）
grep -q "src-git passwall" feeds.conf.default || echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# 添加 smpackage feed（如果不存在）
grep -q "src-git smpackage" feeds.conf.default || sed -i '$a src-git smpackage https://github.com/kenzok8/small-package' feeds.conf.default

# 可选：去除 feeds.conf.default 中重复行（防止多次执行导致重复）
awk '!seen[$0]++' feeds.conf.default > feeds.conf.tmp && mv feeds.conf.tmp feeds.conf.default
