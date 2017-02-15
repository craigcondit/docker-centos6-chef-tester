FROM insideo/centos6-java8-build
MAINTAINER ccondit@randomcoder.com

RUN \
	yum -y install openssl-devel && \
	yum clean all && \
	mkdir -p /ruby-build && \
	cd /ruby-build && \
	curl -O http://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.0.tar.xz && \
	tar xf ruby-2.4.0.tar.xz && \
	cd ruby-2.4.0 && \
	./configure --prefix=/usr --enable-shared && \
	make -j4 && \
	make install && \
	cd / && \
	rm -rf /ruby-build

RUN \
	mkdir -p /chef-rpms && \
	cd /chef-rpms && \
	curl -O https://packages.chef.io/files/stable/chef/12.12.15/el/6/chef-12.12.15-1.el6.x86_64.rpm && \
	yum -y localinstall chef-12.12.15-1.el6.x86_64.rpm && \
	yum clean all && \
	cd / && \
	rm -rf /chef-rpms

RUN \
	gem install --no-ri --no-rdoc berkshelf -v 5.6.2
