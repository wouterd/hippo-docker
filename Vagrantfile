# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$bootstrap_script = <<SCRIPT
  # Install Oracle JDK
  apt-get -y install python-software-properties
  add-apt-repository -y ppa:webupd8team/java
  apt-get update
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
  echo oracle-jdk7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
  apt-get -y install oracle-jdk7-installer

  # Install maven
  apt-get -y install maven

  # Install Jenkins 
  wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
  sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
  apt-get update
  apt-get install -y jenkins

  # Install Docker

  # The username to add to the docker group will be passed as the first argument
  # to the script.  If nothing is passed, default to "vagrant".
  user="$1"
  if [ -z "$user" ]; then
      user=vagrant
  fi

  # Adding an apt gpg key is idempotent.
  wget -q -O - https://get.docker.io/gpg | apt-key add -

  # Creating the docker.list file is idempotent, but it may overwrite desired
  # settings if it already exists.  This could be solved with md5sum but it
  # doesn't seem worth it.
  echo 'deb http://get.docker.io/ubuntu docker main' > /etc/apt/sources.list.d/docker.list

  # Update remote package metadata. 'apt-get update' is idempotent.
  apt-get update -q

  # Install docker.  'apt-get install' is idempotent.
  apt-get install -q -y lxc-docker

  usermod -a -G docker "$user"
  usermod -a -G docker "jenkins"
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.provision :shell, :inline => $bootstrap_script

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 8080, host: 8080, auto_correct:true
  config.vm.network :forwarded_port, guest: 8081, host: 8081, auto_correct:true

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "2048", "--cpus", "4"]
  end
end
