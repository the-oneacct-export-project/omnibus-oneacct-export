# -*- mode: ruby -*-
# vi: set ft=ruby :

require "vagrant"

if Vagrant::VERSION < "1.2.1"
  raise "The Omnibus Build Lab is only compatible with Vagrant 1.2.1+"
end

host_project_path = File.expand_path("..", __FILE__)
guest_project_path = "/home/vagrant/#{File.basename(host_project_path)}"
project_name = "oneacct-export"

Vagrant.configure("2") do |config|

  config.vm.hostname = "#{project_name}-omnibus-build-lab"

  config.vm.define 'centos-5' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "opscode-bento-centos-5.10"
    c.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-5.10_chef-provisionerless.box"
  end

  config.vm.define 'centos-6' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "opscode-bento-centos-6.5"
    c.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box"
  end

  config.vm.define 'debian-6' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "opscode-bento-debian-6.0.10"
    c.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_debian-6.0.10_chef-provisionerless.box"
  end

  config.vm.define 'debian-7' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "opscode-bento-debian-7.3"
    c.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_debian-7.6_chef-provisionerless.box"
  end

  config.vm.define 'ubuntu-12.04' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "opscode-bento-ubuntu-12.04"
    c.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box"
  end

  config.vm.define 'ubuntu-14.04' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "opscode-bento-ubuntu-14.04"
    c.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize [
      "modifyvm", :id,
      "--memory", "3072",
      "--cpus", "2"
    ]
  end

  config.vm.provision :shell, inline: <<-DEB_PREP
    export PATH=/usr/local/bin:$PATH
    if which apt-get &> /dev/null; then
        apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy install libssl-dev libgecode-dev
    fi
  DEB_PREP

  config.omnibus.chef_version = :latest

  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "./Berksfile"

  config.ssh.forward_agent = true

  host_project_path = File.expand_path("..", __FILE__)
  guest_project_path = "/home/vagrant/#{File.basename(host_project_path)}"

  config.vm.synced_folder host_project_path, guest_project_path

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      "omnibus" => {
        "build_user" => "vagrant",
        "build_dir" => guest_project_path,
        "install_dir" => "/opt/#{project_name}"
      }
    }

    chef.run_list = [
      "recipe[omnibus::default]"
    ]
  end

  config.vm.provision :shell, :inline => <<-OMNIBUS_BUILD
    export PATH=/usr/local/bin:$PATH
    source /home/vagrant/.bashrc.d/*
    #chruby 2.1.2
    #cd #{guest_project_path}
    #sudo -u vagrant echo $PATH
    #su vagrant -m -c "echo $PATH"
    #su vagrant -m -c "sudo gem install bundler"
    #su vagrant -m -c "bundle install --binstubs"
    #su vagrant -m -c "bin/omnibus build #{project_name}"
    gem install bundler
    #sudo -E -u vagrant bundle install --binstubs
    #sudo -E -u vagrant bin/omnibus build #{project_name}
    #sudo -E -u vagrant echo $PATH
    su vagrant -l -c "cd #{guest_project_path} && bundle install --binstubs && bin/omnibus build #{project_name}"
  OMNIBUS_BUILD
end
