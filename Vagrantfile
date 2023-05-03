Vagrant.configure("2") do |config|

  # Creating database VM 

  config.vm.define "db" do |db|

    # Define the OS
    db.vm.box = "ubuntu/bionic64"

    # Define the Network
    db.vm.network "private_network", ip: "192.168.10.150"

    # Provisioning MongoDB 
    db.vm.provision "shell", path: "environment/provision-mongodb.sh"

  end

  # Creating application VM
   
  config.vm.define "app" do |app|
    
    app.vm.box = "ubuntu/bionic64"

    # adding a provision file
    app.vm.provision "shell", path: "provision.sh", env:{"DB_HOST" => "mongodb://192.168.10.150:27017/posts"}

    # syncing the app folder
    app.vm.synced_folder "app", "/home/vagrant/app"

    # Setting the private IP
    app.vm.network "private_network", ip: "192.168.10.100"

    
    
  end

end