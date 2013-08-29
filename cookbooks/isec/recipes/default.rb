#
# Cookbook Name:: isec
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "isec::isec-#{node['isec']['install_flavor']}-#{node['isec']['install_version']}"

