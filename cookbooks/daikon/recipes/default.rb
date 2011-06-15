# Chef recipe for Daikon

gem_package "daikon" do
end

user node[:daikon][:user] do
  comment "Daikon User"
  system true unless Chef::VERSION =~ /^0.6/
  shell "/bin/false"
  home node[:daikon][:home_dir]
end

group node[:daikon][:group] do
  members [node[:daikon][:user]]
end

[
  node[:daikon][:home_dir],
  "/var/run/daikon",
].each do |d|
  directory d do
    mode 0775
    owner node[:daikon][:user]
    group node[:daikon][:group]
    action :create
  end
end

# HACK: to make chef 0.6 happy
service "daikon"

case node[:platform]
when "ubuntu", "debian"
  template "/etc/init/daikon.conf" do
    owner "root"
    group "root"
    mode 0644
    action :create
    backup false
    source "daikon.upstart.erb"
    notifies :restart, resources(:service => "daikon")
  end
else
  template "/etc/init.d/daikon" do
    owner "root"
    group "root"
    mode 0755
    action :create
    source "daikon.initd.erb"
    variables :node => node # HACK: to support chef 0.6
    notifies :restart, resources(:service => "daikon")
  end
end

service "daikon" do
  case node[:platform]
  when "ubuntu", "debian"
    provider Chef::Provider::Service::Upstart
  end
  supports :restart => true, :reload => true, :status => true
  action [:enable, :start]
end
