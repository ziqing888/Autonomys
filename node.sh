#!/bin/bash

# 定义文本格式
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
SUCCESS_COLOR='\033[1;32m'
ERROR_COLOR='\033[1;31m'
INFO_COLOR='\033[1;36m'
MENU_COLOR='\033[1;34m'

# 自定义状态显示函数
show_message() {
    local message="$1"
    local status="$2"
    case $status in
        "error")
            echo -e "${ERROR_COLOR}${BOLD}❌ 错误: ${message}${NORMAL}"
            ;;
        "info")
            echo -e "${INFO_COLOR}${BOLD}ℹ️ 信息: ${message}${NORMAL}"
            ;;
        "success")
            echo -e "${SUCCESS_COLOR}${BOLD}✅ 成功: ${message}${NORMAL}"
            ;;
        *)
            echo -e "${message}"
            ;;
    esac
}

# 系统更新
更新系统() {
    show_message "正在更新系统..." "info"
    sudo apt update && sudo apt upgrade -y
}

# 检查并安装 screen
安装_screen() {
    if ! command -v screen &> /dev/null; then
        show_message "正在安装 screen..." "info"
        sudo apt install -y screen
        show_message "screen 安装完成。" "success"
    else
        show_message "screen 已安装，跳过此步骤。" "success"
    fi
}

# 准备目录
准备目录() {
    local 目录="$HOME/node-directory"
    if [ ! -d "$目录" ]; then
        mkdir -p "$目录"
        show_message "已创建节点目录。" "success"
    fi
    cd "$目录" || exit 1
}

# 下载并配置节点
配置节点() {
    local 节点程序="node-binary"
    rm -rf node-db "$节点程序"

    show_message "正在下载节点程序..." "info"
    wget -q "https://example.com/releases/node-binary"
    chmod +x "$节点程序"

    read -p "请输入节点名称: " 节点名称
    mkdir -p "$HOME/node-directory/node-db"

    show_message "正在启动节点..." "info"
    ./"$节点程序" run \
      --chain chain-name \
      --base-path "$HOME/node-directory/node-db" \
      --name "$节点名称" \
      --farmer

    show_message "节点启动成功。" "success"
}

# 主流程
主流程() {
    更新系统
    安装_screen
    准备目录
    配置节点
}

# 启动主流程
主流程
