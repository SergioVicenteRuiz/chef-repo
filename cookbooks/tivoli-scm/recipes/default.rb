#
# Cookbook Name:: tivoli-scm
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
distfile = File.basename(node['symantec']['extract_source'])
disttarget = win_friendly_path(File.join(Chef::Config[:file_cache_path], distfile))
installfile = win_friendly_path(File.join(node['symantec']['extract_path'], "setup.exe"))

remote_file disttarget do
  source node['symantec']['extract_source']
  backup false
  action :create_if_missing
  notifies :run, 'execute[unzip_target]', :immediately
end

execute 'unzip_target' do
  command %Q(#{disttarget} x -y -o#{node['symantec']['extract_path']})
  not_if {File.exists?(installfile)}
end

windows_package "Symantec Endpoint Protection" do
  source installfile 
  options node['symantec']['install_options']
  installer_type :custom
  action :install
end

config_file_path = win_friendly_path(File.join(Chef::Config[:file_cache_path], "ConfigurationFile.ini"))

template config_file_path do
  source "ConfigurationFile.ini.erb"
end

windows_package node['sql_server']['server']['package_name'] do
  source node['sql_server']['server']['url']
  checksum node['sql_server']['server']['checksum']
  installer_type :custom
  options "/q /ConfigurationFile=#{config_file_path}"
  action :install
end

service service_name do
  action :nothing
end
