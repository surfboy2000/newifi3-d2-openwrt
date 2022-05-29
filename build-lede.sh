#!/bin/bash
export OP_BUILD_PATH=$PWD
git clone https://github.com/coolsnowwolf/lede

cd ${OP_BUILD_PATH}/lede
echo "src-git helloworld https://github.com/fw876/helloworld" >>feeds.conf.default
./scripts/feeds update -a && ./scripts/feeds install -a
rm -rf ./tmp && rm -rf .config
mv ${OP_BUILD_PATH}/lede.config ${OP_BUILD_PATH}/lede/.config
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
make defconfig
make download -j8
make V=s -j$(nproc)
echo "FILE_DATE=$(date +%Y%m%d%H%M)" >>$GITHUB_ENV
