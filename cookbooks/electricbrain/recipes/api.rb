#
# Cookbook Name:: electricbrain
# Recipe:: api
#
# Copyright (c) 2016 Electric Brain Inc., All Rights Reserved.
#
# This recipe installs the electric brain API itself

# Create a user for electricbrain

ebuser = 'eb'
ebgroup = 'eb'

group ebgroup
user ebuser do
    home "/opt/eb"
    shell "/bin/bash"
    group ebgroup
end


directory "/opt/eb" do
    owner ebuser
    group ebgroup
end

directory "/opt/eb/.ssh" do
    owner ebuser
    group ebgroup
end


cookbook_file "/opt/eb/.ssh/id_rsa.pub" do
    source "keys/eb_demo_deployment_key.pub"
    mode "0600"
    owner ebuser
    group ebgroup
end


cookbook_file "/opt/eb/.ssh/id_rsa" do
    source "keys/eb_demo_deployment_key"
    mode "0600"
    owner ebuser
    group ebgroup
end

nodejs_npm "electricbrain"
link "/usr/local/bin/ebapi" do
    to "/usr/local/nodejs-binary-6.3.1/bin/ebapi"
end
link "/usr/local/bin/ebworker" do
    to "/usr/local/nodejs-binary-6.3.1/bin/ebworker"
end
link "/usr/local/bin/ebapplication" do
    to "/usr/local/nodejs-binary-6.3.1/bin/ebapplication"
end

template "/etc/init/ebapi.conf" do
    source "init/ebapi.conf"
end


template "/etc/init/ebworker1.conf" do
    source "init/ebworker.conf"
end


template "/etc/init/ebworker2.conf" do
    source "init/ebworker.conf"
end


template "/etc/systemd/system/ebapi.service" do
    source "systemd/system/ebapi.service"
end


template "/etc/systemd/system/ebworker1.service" do
    source "systemd/system/ebworker1.service"
end


template "/etc/systemd/system/ebworker2.service" do
    source "systemd/system/ebworker2.service"
end

execute 'activate services' do
  command "systemctl daemon-reload"
end

execute 'activate ebapi' do
  command "systemctl enable ebapi.service"
end

execute 'activate ebworker1' do
  command "systemctl enable ebworker1.service"
end

execute 'activate ebworker2' do
  command "systemctl enable ebworker2.service"
end


directory "/var/log/eb/" do
    owner ebuser
    group ebgroup
end


service "ebapi" do
    action :restart
end


service "ebworker1" do
    action :restart
end


service "ebworker2" do
    action :restart
end

# Generate basic testing data sets
execute 'generate-testing-data' do
  command "node /usr/local/nodejs-binary-6.3.1/lib/node_modules/electricbrain/scripts/generate_testing_data.js"
  cwd '/usr/local/nodejs-binary-6.3.1/lib/node_modules/electricbrain/'
  environment ({"HOME" => "/opt/eb"})
  user ebuser
  group ebgroup
end

# Download mnist
remote_file '/usr/local/nodejs-binary-6.3.1/lib/node_modules/electricbrain/scripts/datasets/mnist_png.tar.gz' do
  not_if { File.exists?("/opt/eb/electric-brain/scripts/datasets/mnist_png.tar.gz") }
  source 'https://github.com/myleott/mnist_png/raw/master/mnist_png.tar.gz'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'extract-mnist' do
  not_if { File.exists?("/usr/local/nodejs-binary-6.3.1/lib/node_modules/electricbrain/scripts/datasets/mnist_png/") }
  command 'tar xzvf mnist_png.tar.gz'
  cwd '/usr/local/nodejs-binary-6.3.1/lib/node_modules/electricbrain/scripts/datasets/'
  user 'root'
  group 'root'
end

execute 'generate-mnist-data' do
  command "node /usr/local/nodejs-binary-6.3.1/lib/node_modules/electricbrain/scripts/datasets/load_mnist.js"
  cwd '/usr/local/nodejs-binary-6.3.1/lib/node_modules/electricbrain/scripts/'
  environment ({"HOME" => "/opt/eb"})
  user 'root'
  group 'root'
end
