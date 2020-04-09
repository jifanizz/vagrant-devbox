Vagrant.configure(2) do |config|


   config.vm.provider "virtualbox" do |vb|
     vb.memory = 4096
     vb.cpus = 2
   end

  config.vm.box = "ubuntu/xenial64"
  config.vm.network "forwarded_port", guest: 80, host: 8089
  config.vm.network "forwarded_port", guest: 443, host: 8449
  config.vm.network "forwarded_port", guest: 8080, host: 8009
  config.vm.network "private_network", ip: "192.168.56.200", :adapter => 2

  config.vm.define :devbox do |devbox|
    devbox.vm.hostname = "devbox"
    devbox.vm.provision "file", source: "./git-prompt", destination: "git-prompt"
    devbox.vm.provision "file", source: "./nso-5.3.1.linux.x86_64.installer.bin", destination: "nso-5.3.1.linux.x86_64.installer.bin"
    devbox.vm.provision :shell, path: "install.sh"
  end
end
