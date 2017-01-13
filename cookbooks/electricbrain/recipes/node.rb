#
# Cookbook Name:: electricbrain
# Recipe:: node
#
# Copyright (c) 2016 Electric Brain Inc., All Rights Reserved.
#



# Install NodeJS itself
node.default['nodejs']['version'] = '6.3.1'
node.default['nodejs']['install_method'] = 'binary'
node.default['nodejs']['binary']['checksum'] = 'eccc53'
include_recipe 'nodejs'

# Install a few NodeJS modules that need to be install globally
nodejs_npm "bower"
link "/usr/local/bin/bower" do
    to "/usr/local/nodejs-binary-6.3.1/bin/bower"
end

nodejs_npm "grunt-cli"
link "/usr/local/bin/grunt" do
    to "/usr/local/nodejs-binary-6.3.1/bin/grunt"
end
