#
# Cookbook Name:: lab_ssh_cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "openssh-server" do
	action :install
end

config = data_bag_item("lab_environment_secrets", "ssh")

template "/etc/ssh/sshd_config" do
	source "sshd_config.erb"
	owner "root"
	group "root"
	mode "0644"

	notifies :restart, "service[ssh]", :delayed
end

template "/etc/hosts.deny" do
	source "hosts.deny.erb"
	owner "root"
	group "root"
	mode "0644"

        variables ({
                :hosts_blocked => config['hosts_blocked']
#               :hosts_blocked => ["chefd.local","suspicious_one.local"]
        })

end



#If user does not exist create it and add the key
if !node['etc']['passwd']['vagrant']

	vagrant_user_key = search("lab_environment_secrets", "users:vagrant")

	user 'vagrant' do
		action :create
	    home '/home/vagrant'
	end

	execute "adds pub key" do
	  command "echo #{vagrant_user_key} >> /home/vagrant/.ssh/authorized_keys"
	  not_if "grep #{vagrant_user_key} /home/vagrant/.ssh/authorized_keys"
	end
end

#Create group
group 'ssh-users' do
  action :create
  members 'vagrant'
  append true
end

service "ssh" do
	action [:enable, :start]
	supports :reload => true
end

