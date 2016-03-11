#
# Cookbook Name:: lab_ssh_cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'hosts_file'

package "openssh-server" do
	action :install
end

template "/etc/ssh/sshd_config" do
	source "sshd_config.erb"
	owner "root"
	group "root"
	mode "0644"

	notifies :restart, "service[ssh]", :delayed
end

service "ssh" do
        action [:enable, :start]
        supports :reload => true
end


