#
# Cookbook Name:: rails-nginx-unicorn
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "ruby_build"

include_recipe "rbenv::system"
rbenv_ruby "2.1.1"
rbenv_global "2.1.1"

include_recipe "yum-epel"

%w{bundler rails unicorn}.each do |g|
	rbenv_gem g do
		rbenv_version "2.1.1"
		action :install
	end
end

package "nginx" do
	action :install
end

service "nginx" do
	supports status: true, restart: true, reload: true
	action [:enable, :start]
end

template "nginx.conf" do
	owner "root"
	group "root"
	mode 0644

	notifies :reload, "service[nginx]"
end


include_recipe "iptables"
iptables_rule "iptables"

package "vim" do action :install end




