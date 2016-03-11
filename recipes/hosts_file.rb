#
# allow/deny stuff 
#
# this should be moved to their own recipe
#

config = data_bag_item("lab_environment_secrets", "ssh")

template "/etc/hosts.deny" do
        source "hosts.deny.erb"
        owner "root"
        group "root"
        mode "0644"

        variables ({
                :hosts_blocked => config['hosts_blocked']
        })
end

template "/etc/hosts.allow" do
        source "hosts.allow.erb"
        owner "root"
        group "root"
        mode "0644"

        variables ({
                :hosts_allowed => config['hosts_allowed']
        })
end


