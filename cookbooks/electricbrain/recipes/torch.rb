# Check if torch is installed
if !::File.exist?("/usr/local/bin/th") then
    # Clone the torch repo
    git "/tmp/torch" do
        repository "https://github.com/torch/distro.git"
        action :sync
    end

    # Run their install script
    execute "torch-install" do
        command "bash install.sh -s -b"
        cwd "/tmp/torch"
        environment ({'PREFIX' => '/usr/local/', 'BATCH_INSTALL' => "1", 'SKIP_RC' => "1"})
        action :run
    end

    # Clean up the folder with the Torch repo - its no longer needed now that everything is installed
    directory "/tmp/torch" do
      recursive true
      action :delete
    end
end

# Install Lua packages
lua_packages = ["underscore", "json", "luasocket", "rnn", "image", "distlearn", "ipc"]
lua_packages.each do |pkg|
    execute "install-lua-package-#{pkg}" do
        command "luarocks install #{pkg}"
        not_if "luarocks show #{pkg}"
        cwd "/root"
        action :run
    end
end
