# md-Yunzai-Bot
<big>**m**odified **d**ocker Yunzai-Bot</big>  
魔改自[SirlyDreamer/Yunzai-Bot-Docker](https://github.com/SirlyDreamer/Yunzai-Bot-Docker)的dokcer版Yunzai-Bot，感谢Yunzai-Bot项目参与者做出的卓越工作！  

## 修改要点
* 集成Redis，自动初始化所有依赖
* 精简镜像结构
* 修改Git源、npm源到大陆镜像，加快墙内加载
* 分离持久化数据目录（容器路径/app/data）
* 将Yunzai-Bot的程序目录等有状态数据分离出Docker容器，方便增删插件（容器路径/app/Yunzai-Bot）
