#!/bin/bash

# 更新系统并升级
sudo apt update && sudo apt upgrade -y

# 检查并安装screen
if ! command -v screen &> /dev/null
then
    echo "正在安装screen..."
    sudo apt install screen -y
fi

# 创建并进入自定义目录
cd $HOME
if [ ! -d "hca-autonomys" ]; then
    mkdir hca-autonomys
    echo "已创建hca-autonomys目录。"
fi

cd hca-autonomys
# 删除旧的文件和数据库
rm -rf farmer-db subspace-farmer-ubuntu-x86_64-skylake-gemini-3h-2024-sep-03

# 使用指定的wget命令下载可执行文件
wget https://github.com/autonomys/subspace/releases/download/gemini-3h-2024-sep-03/subspace-farmer-ubuntu-x86_64-skylake-gemini-3h-2024-sep-03
chmod +x subspace-farmer-ubuntu-x86_64-skylake-gemini-3h-2024-sep-03

# 获取用户输入
read -p "请输入您的钱包地址（WALLET_ADDRESS）: " WALLET_ADDRESS
read -p "请输入绘图大小（默认10GB，最小10GB，最大200TiB）: " PLOT_SIZE
PLOT_SIZE=${PLOT_SIZE:-10GB}

# 创建数据库目录
mkdir -p $HOME/hca-autonomys/farmer-db

# 运行可执行文件
./subspace-farmer-ubuntu-x86_64-skylake-gemini-3h-2024-sep-03 farm \
  --reward-address "$WALLET_ADDRESS" \
  path="$HOME/hca-autonomys/farmer-db",size="$PLOT_SIZE"
