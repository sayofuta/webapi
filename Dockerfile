FROM amazonlinux:2
#実行可能ファイルの配置
COPY copy/publish /root/webapi
#実行可能ファイルの権限変更
RUN chmod 755 /root/webapi/*
RUN yum update -y
#.NET Coreランタイムのインストール
RUN rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm && yum install -y dotnet-runtime-3.1
#supervisorのインストール
RUN yum install -y python-setuptools && easy_install pip && pip install supervisor
RUN yum install -y initscripts
#nginxのインストール
RUN amazon-linux-extras install -y nginx1.12
COPY copy/nginx.conf /etc/nginx/nginx.conf
#設定ファイルの作成
COPY copy/service-nginx.conf /etc/supervisord.d/service-nginx.conf
COPY copy/webapi.conf /etc/supervisord.d/webapi.conf
RUN echo_supervisord_conf > /etc/supervisord.conf
COPY copy/supervisord.conf /etc/supervisord.conf
#iniファイルの作成
RUN curl -o /etc/rc.d/init.d/supervisord https://raw.githubusercontent.com/Supervisor/initscripts/master/redhat-init-equeffelec
RUN chmod 755 /etc/init.d/supervisord



