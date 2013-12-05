# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :forwarded_port, guest: 143, host: 8143
  
  provision_script = <<-EOF
    echo ""

    echo ">> Update APT cache and install dependencies"
    sudo apt-get update
    sudo apt-get install --assume-yes git libyaml-dev 2> /dev/null
    echo ""

    echo ">> Install and configure an IMAP service on the host"
    sudo apt-get install --assume-yes dovecot-imapd 2> /dev/null
    echo ""

    echo ">> Copy the Maildir sample"
    cp --recursive /vagrant/test/Maildir /home/vagrant/
    chown --recursive vagrant:vagrant /home/vagrant/Maildir
    echo ""

    echo ">> Install ruby 2.0 stack" # Quick and dirty way
    cd /tmp
    echo "Downloading and installing ruby from rvm binaries packages..."
    wget --quiet --continue https://rvm.io/binaries/ubuntu/12.04/x86_64/ruby-2.0.0-p353.tar.bz2
    tar jxf ruby-2.0.0-p353.tar.bz2
    sudo cp -r ruby-2.0.0-p353/* /usr/local/
    echo "Done: $(/usr/local/bin/ruby -v) - gem $(/usr/local/bin/gem -v)"
    sudo gem install bundler
    echo ""

    echo ">> Install gem dependencies and binaries"
    cd /vagrant
    bundle install --path vendor/bundle --without production
  EOF
  config.vm.provision "shell", inline: provision_script
end