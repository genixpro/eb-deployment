#
# Cookbook Name:: electricbrain
# Recipe:: access
#
# Copyright (c) 2016 Electric Brain Inc., All Rights Reserved.
#
# This recipe is used to install the default users for all servers, like myself

user "bradley" do

end


ssh_authorize_key 'bradley@bradley-FOX-4-0' do
  key 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCvam7uL6cOpRcwreotsX0kGsc7dlpwfQgKauTKeyvFkXBictzeOhaQmveNSmIfOf4tHHrjKp3kLUffSHqsPSjy/0rtZJWp6qiALtyxiEWt5oYJJaIJCRxHnP+YXYOBK/VehzoQx/jYHDYuuCB6vBPy/LOx2javbJgGMiMR5Aus1vvseuLxciXXg/VO0EaxCtsgln8mTanmznL0DgO4Z60HQf3hsLhjEixo5xWqlJSqVFgX6SKcJynRwMUPcin7c9gqtIiYowtAGZ3mq9Q7h8ThkM9fiifsLZK6zzWGGwQLOjgCH+DD8hooj85NySz8jm9nLvVZxbMBJ52UsuD0bPAn'
  home "/home/bradley"
  group "bradley"
  user 'bradley'
end
