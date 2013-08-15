#
# Cookbook Name:: osconfig
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


hostsfile_entry '192.168.122.92' do
  hostname 'oc0644314035.ibm.com'
  aliases ['yum.ibm.com','chefserver.ibm.com']
end

include_recipe "osconfig::#{node['osconfig']['install_flavor']}"
