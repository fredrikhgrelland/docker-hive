Vagrant.configure("2") do |config|
  config.vm.box = "fredrikhgrelland/hashistack"
  config.vm.network "private_network", ip: "10.0.3.10"
  config.vn.box_version = "~> 0.0"
  config.vm.box_download_insecure = true

  # Hashicorp consul ui
  config.vm.network "forwarded_port", guest: 8500, host: 8500, host_ip: "127.0.0.1"

  # Hashicorp nomad ui
  config.vm.network "forwarded_port", guest: 4646, host: 4646, host_ip: "127.0.0.1"

  config.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
      vb.cpus = 2
  end
  config.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "./test/playbook.yml"

      # default mode `dev`
      ansible.extra_vars = {
        mode: 'dev'
      }

      # use to override default mode (e.g. test mode)
      ansible.raw_arguments = Shellwords.shellsplit(ENV['ANSIBLE_ARGS']) if ENV['ANSIBLE_ARGS']
  end
end
