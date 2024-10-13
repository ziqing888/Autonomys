节点安装
wget -O node.sh https://raw.githubusercontent.com/ziqing888/Autonomys/main/node.sh
sed -i 's/\r$//' node.sh
chmod +x node.sh
./node.sh



挖矿安装
wget -O farmer.sh https://raw.githubusercontent.com/ziqing888/Autonomys/main/farmer.sh && sed -i 's/\r$//' farmer.sh && chmod +x farmer.sh && ./farmer.sh
