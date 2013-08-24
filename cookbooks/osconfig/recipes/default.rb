#
# Cookbook Name:: osconfig
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
hostsfile_entry '192.168.122.1' do
  hostname 'oc4151137872.ibm.com'
  aliases ['oc4151137872']
#  action :create_if_missing
end

hostsfile_entry '192.168.122.92' do
  hostname 'oc0644314035.ibm.com'
  aliases ['yum.ibm.com','oc0644314035']
#  action :create_if_missing
end

search(:node,"chef_environment:_default").each do |default_node|
  hostsfile_entry default_node['ipaddress'] do
    hostname default_node['fqdn']
    aliases [default_node['hostname']]
#    action :create_if_missing
  end
end

include_recipe "osconfig::#{node['osconfig']['install_flavor']}"
