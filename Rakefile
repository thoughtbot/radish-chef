require 'bundler'
Bundler.require


AMI      = 'ami-17f51c7e' # (Ubuntu 10.04, 32bit, Chef 0.8.16)
FLAVOR   = 'm1.small'
KEY_NAME = 'radish'

desc "boot up an instance"
task :boot do
  compute = Fog::Compute.new(:provider => 'AWS')
  server = compute.servers.create(:image_id  => AMI,
                                  :key_name  => KEY_NAME,
                                  :groups    => ["default"],
                                  :flavor_id => FLAVOR,
                                  :user_data => File.read("boot.bash"))
  server.wait_for { ready? }
  server.reload
  puts "Booted instance: #{server.dns_name}"
end

def upload(file_name)
  fog = Fog::Storage.new(:provider => 'AWS')
  dir = fog.directories.get("radish")
  dir.files.create(:body => File.read(file_name), :key => file_name, :public => true)
end

desc "bundle up cookbooks for s3"
task :upload do
  file = "cookbooks.tar.gz"
  sh "tar cvfz #{file} cookbooks/"
  upload(file)
  upload("node.json")
  sh "rm #{file}"
end

desc "kill all instances"
task :kill do
  compute = Fog::Compute.new(:provider => 'AWS')
  compute.servers.each(&:destroy)
end

desc "ssh in"
task :ssh do
  exec "ssh -i ~/.ssh/radish.pem ubuntu@#{ENV["IP"]}"
end
