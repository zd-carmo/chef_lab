default[:ssh][:X11Forwarding] = "no"
default[:ssh][:listening_port] = 22
default[:ssh][:allow_groups] = ["ssh-users"]
default[:ssh][:permit_empty_password] = "no"
default[:ssh][:allow_root_with_key] = true
default[:ssh][:server_key_bits] = "1024"
