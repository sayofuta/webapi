FROM amazonlinux:2
COPY copy/publish /root/webapi
COPY copy/nginx.conf /etc/nginx/nginx.conf
COPY copy/service-nginx.conf /etc/supervisord.d/service-nginx.conf
COPY copy/webapi.conf /etc/supervisord.d/webapi.conf
COPY copy/supervisord.conf /etc/supervisord.conf
RUN yum update -y
#.NET Coreランタイムのインストール
RUN rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
RUN yum install -y dotnet-runtime-3.1
#supervisorのインストール
RUN yum install -y python-setuptools
RUN easy_install pip
RUN pip install supervisor
RUN yum install -y initscripts
#nginxのインストール
RUN amazon-linux-extras install -y nginx1.12
#設定ファイルの作成
RUN echo_supervisord_conf > /etc/supervisord.conf
#iniファイルの作成
RUN curl -o /etc/rc.d/init.d/supervisord https://raw.githubusercontent.com/Supervisor/initscripts/master/redhat-init-equeffelec
RUN chmod 755 /etc/init.d/supervisord



