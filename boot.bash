#!/bin/bash
cd ~
wget http://rubygems.org/downloads/rubygems-update-1.8.5.gem
gem install ./rubygems-update-1.8.5.gem --local --no-ri --no-rdoc
gem install chef --no-ri --no-rdoc
chef-solo -l debug -r https://radish.s3.amazonaws.com/cookbooks.tar.gz -j https://radish.s3.amazonaws.com/node.json >> /var/log/chef.log
