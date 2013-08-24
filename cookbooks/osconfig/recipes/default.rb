#
# Cookbook Name:: osconfig
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
hostsfile_entry '192.168.122.1' do
  hostname 'oc4151137872'
  aliases ['oc4151137872.ibm.com']
end

hostsfile_entry '192.168.122.92' do
  hostname 'oc0644314035'
  aliases ['yum.ibm.com','oc0644314035.ibm.com']
end

search(:node,"chef_environment:_default").each do |default_node|
  hostsfile_entry default_node['ipaddress'] do
    hostname default_node['fqdn']
    aliases [default_node['hostname']]
  end
end

include_recipe "osconfig::#{node['osconfig']['install_flavor']}"
