FROM amazonlinux:2
COPY copy/build.sh /build.sh
COPY copy/publish /root/webapi
COPY copy/nginx.conf /etc/nginx/nginx.conf
COPY copy/kestrel-mvc.service /etc/systemd/system/kestrel-mvc.service
COPY copy/nginx.service /etc/systemd/system/nginx.service

RUN yum update -y && yum install -y \
    systemd \
    procps \
    && amazon-linux-extras install -y nginx1.12
RUN rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
RUN yum install -y dotnet-runtime-3.1
RUN chmod 775 /root/webapi/*
RUN sed s/#LogLevel=info/LogLevel=warn/ /etc/systemd/system.conf




