FROM centos:7

RUN sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-*.repo && \
  sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo

# Update the system and install common packages
RUN yum -y update && \
  yum -y install epel-release && \
  yum -y install wget curl git unzip nano vim nginx && \
  yum clean all

# Create app directory
WORKDIR /var/www/html

# Configure Nginx
RUN mkdir -p /var/log/nginx && \
  mkdir -p /etc/nginx/conf.d

# Copy Nginx configuration (will be added later)
COPY ./config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./config/nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy start script
COPY ./scripts/start.sh /start.sh
RUN chmod +x /start.sh

# Expose ports
EXPOSE 80 443

# Set the startup command
CMD ["/start.sh"]