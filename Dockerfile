# 使用 Node.js 官方镜像作为基础镜像
FROM node:14

# 设置环境变量
ENV NVM_DIR=/root/.nvm

# 安装 nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# 创建一个脚本来加载 nvm 并运行命令
RUN echo 'export NVM_DIR="$HOME/.nvm"' >> /root/.bashrc
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # 立即加载 NVM' >> /root/.bashrc
RUN echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # 加载自动补全' >> /root/.bashrc

# 安装 LTS 版本的 Node.js
RUN . /root/.bashrc && nvm install --lts
RUN . /root/.bashrc && nvm use --lts
RUN . /root/.bashrc && nvm alias default lts/*

# 安装 @node-red
RUN . /root/.bashrc && npm install -g --unsafe-perm node-red

# 设置工作目录
WORKDIR /app

# 暴露端口（如果需要）
EXPOSE 1880

# 启动应用
CMD ["/bin/bash", "-c", "source /root/.bashrc && node-red"]