# Chef recipe for Daikon

gem_package "daikon" do
end

user "daikon" do
  comment "Daikon User"
  system true
  shell "/bin/sh"
  home "/home/daikon"
end

group "daikon" do
  members ['daikon']
end

directory "/home/daikon" do
  mode 0775
  owner "daikon"
  group "daikon"
  action :create
end

cookbook_file "/etc/init/daikon.conf" do
  owner "root"
  group "root"
  mode 0644
  action :create
  backup false
  source "daikon"
end

service "daikon" do
  provider Chef::Provider::Service::Upstart
  action :start
  enabled true
  running true
  supports :restart => true, :reload => true, :status => true
end
