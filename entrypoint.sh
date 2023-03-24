#!/usr/bin/env bash

set +e

GreenBG="\\033[42;37m"
YellowBG="\\033[43;37m"
BlueBG="\\033[44;37m"
Font="\\033[0m"

Version="${BlueBG}[版本]${Font}"
Info="${GreenBG}[信息]${Font}"
Warn="${YellowBG}[提示]${Font}"

WORK_DIR="/app/Miao-Yunzai"
REDIS_DATA_DIR="/app/redis/data"
MIAO_PLUGIN_PATH="/app/Miao-Yunzai/plugins/miao-plugin"
XIAOYAO_CVS_PATH="/app/Miao-Yunzai/plugins/xiaoyao-cvs-plugin"
PY_PLUGIN_PATH="/app/Miao-Yunzai/plugins/py-plugin"

if [[ ! -d "$HOME/.ovo" ]]; then
    mkdir ~/.ovo
fi

if [ ! -d "$WORK_DIR/.git" ]; then
    if [ -d $WORK_DIR ]; then
        rm -rf $WORK_DIR
    fi
    mkdir $WORK_DIR
    echo -e "\n ================ \n ${Info} ${GreenBG} 初始化 Miao-Yunzai ${Font} \n ================ \n"
    git clone --depth=1 --branch master https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git /app/Miao-Yunzai
fi

echo -e "\n ================ \n ${Info} ${GreenBG} 拉取 Miao-Yunzai 更新 ${Font} \n ================ \n"

cd $WORK_DIR

if [[ -z $(git status -s) ]]; then
    echo -e " ${Warn} ${YellowBG} 当前工作区有修改，尝试暂存后更新。${Font}"
    git add .
    git stash
    git pull origin master --allow-unrelated-histories --rebase
    git stash pop
else
    git pull origin master --allow-unrelated-histories
fi

if [[ ! -f "$HOME/.ovo/yunzai.ok" ]]; then
    set -e
    echo -e "\n ================ \n ${Info} ${GreenBG} 更新 Miao-Yunzai 运行依赖 ${Font} \n ================ \n"
    pnpm config set registry http://mirrors.cloud.tencent.com/npm/
    pnpm install -P
    touch ~/.ovo/yunzai.ok
    set +e
fi

echo -e "\n ================ \n ${Version} ${BlueBG} Miao-Yunzai 版本信息 ${Font} \n ================ \n"

git log -1 --pretty=format:"%h - %an, %ar (%cd) : %s"

if [ -d $MIAO_PLUGIN_PATH"/.git" ]; then

    echo -e "\n ================ \n ${Info} ${GreenBG} 拉取 喵喵插件 更新 ${Font} \n ================ \n"

else

    echo -e "\n ${Warn} ${YellowBG} 喵版云崽依赖miao-plugin，检测到目前没有安装，开始自动下载 ${Font} \n"

    if [ -d $MIAO_PLUGIN_PATH ]; then
        rm -rf $MIAO_PLUGIN_PATH
    fi
    mkdir $MIAO_PLUGIN_PATH
    git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git $MIAO_PLUGIN_PATH
fi

cd $MIAO_PLUGIN_PATH

if [[ -n $(git status -s) ]]; then
    echo -e " ${Warn} ${YellowBG} 当前工作区有修改，尝试暂存后更新。${Font}"
    git add .
    git stash
    git pull origin master --allow-unrelated-histories --rebase
    git stash pop
else
    git pull origin master --allow-unrelated-histories
fi

if [[ ! -f "$HOME/.ovo/miao.ok" ]]; then
    set -e
    echo -e "\n ================ \n ${Info} ${GreenBG} 更新 喵喵插件 运行依赖 ${Font} \n ================ \n"
    pnpm add image-size -w
    touch ~/.ovo/miao.ok
    set +e
fi

echo -e "\n ================ \n ${Version} ${BlueBG} 喵喵插件版本信息 ${Font} \n ================ \n"
git log -1 --pretty=format:"%h - %an, %ar (%cd) : %s"

if [ -d $PY_PLUGIN_PATH"/.git" ]; then

    echo -e "\n ================ \n ${Info} ${GreenBG} 拉取 py-plugin 插件更新 ${Font} \n ================ \n"

    cd $PY_PLUGIN_PATH

    if [[ -n $(git status -s) ]]; then
        echo -e " ${Warn} ${YellowBG} 当前工作区有修改，尝试暂存后更新。${Font}"
        git add .
        git stash
        git pull origin main --allow-unrelated-histories --rebase
        git stash pop
    else
        git pull origin main --allow-unrelated-histories
    fi

    if [[ ! -f "$HOME/.ovo/py.ok" ]]; then
        set -e
        echo -e "\n ================ \n ${Info} ${GreenBG} 更新 py-plugin 运行依赖 ${Font} \n ================ \n"
        pnpm install iconv-lite @grpc/grpc-js @grpc/proto-loader -w
        poetry config virtualenvs.in-project true
        poetry install
        touch ~/.ovo/py.ok
        set +e
    fi

    echo -e "\n ================ \n ${Version} ${BlueBG} py-plugin 插件版本信息 ${Font} \n ================ \n"

    git log -1 --pretty=format:"%h - %an, %ar (%cd) : %s"

fi

if [ -d $XIAOYAO_CVS_PATH"/.git" ]; then

    echo -e "\n ================ \n ${Info} ${GreenBG} 拉取 xiaoyao-cvs 插件更新 ${Font} \n ================ \n"

    cd $XIAOYAO_CVS_PATH

    if [[ -n $(git status -s) ]]; then
        echo -e " ${Warn} ${YellowBG} 当前工作区有修改，尝试暂存后更新。${Font}"
        git add .
        git stash
        git pull origin master --allow-unrelated-histories --rebase
        git stash pop
    else
        git pull origin master --allow-unrelated-histories
    fi

    if [[ ! -f "$HOME/.ovo/xiaoyao.ok" ]]; then
        set -e
        echo -e "\n ================ \n ${Info} ${GreenBG} 更新 xiaoyao-cvs 插件运行依赖 ${Font} \n ================ \n"
        pnpm add promise-retry superagent -w
        touch ~/.ovo/xiaoyao.ok
        set +e
    fi

    echo -e "\n ================ \n ${Version} ${BlueBG} xiaoyao-cvs 插件版本信息 ${Font} \n ================ \n"

    git log -1 --pretty=format:"%h - %an, %ar (%cd) : %s"
fi

if [ -d $GUOBA_PLUGIN_PATH"/.git" ]; then

    echo -e "\n ================ \n ${Info} ${GreenBG} 拉取 Guoba-Plugin 插件更新 ${Font} \n ================ \n"

    cd $GUOBA_PLUGIN_PATH

    if [[ -n $(git status -s) ]]; then
        echo -e " ${Warn} ${YellowBG} 当前工作区有修改，尝试暂存后更新。${Font}"
        git add .
        git stash
        git pull origin master --allow-unrelated-histories --rebase
        git stash pop
    else
        git pull origin master --allow-unrelated-histories
    fi

    if [[ ! -f "$HOME/.ovo/guoba.ok" ]]; then
        set -e
        echo -e "\n ================ \n ${Info} ${GreenBG} 更新 Guoba-Plugin 插件运行依赖 ${Font} \n ================ \n"
        pnpm add multer body-parser jsonwebtoken -w
        touch ~/.ovo/guoba.ok
        set +e
    fi

    echo -e "\n ================ \n ${Version} ${BlueBG} Guoba-Plugin 插件版本信息 ${Font} \n ================ \n"

    git log -1 --pretty=format:"%h - %an, %ar (%cd) : %s"
fi

if [ ! -d $REDIS_DATA_DIR ]; then
    mkdir -p $REDIS_DATA_DIR
    echo -e "\n ================ \n ${Info} ${GreenBG} 创建 Redis 持久化目录 ${Font} \n ================ \n"
fi

echo -e "\n ================ \n ${Info} ${GreenBG} 启动 Redis ${Font} \n ================ \n"

redis-server /etc/redis/redis.conf

set -e

cd $WORK_DIR

echo -e "\n ================ \n ${Info} ${GreenBG} 启动 Yunzai-Bot ${Font} \n ================ \n"

node app
