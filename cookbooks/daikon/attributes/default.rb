if Chef::VERSION =~ /^0.6/
  Chef::Log.info "work around chef 0.6 (for Engine Yard)"
  daikon(:user     => "daikon",
         :group    => "daikon",
         :home_dir => "/var/log/daikon",
         :password => "??????")
else
  # using modern chef
  default[:daikon][:user]     = "daikon"
  default[:daikon][:group]    = "daikon"
  default[:daikon][:home_dir] = "/var/log/daikon"
  default[:daikon][:password] = "??????"
end

