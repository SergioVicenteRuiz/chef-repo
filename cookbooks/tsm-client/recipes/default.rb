#
# Cookbook Name:: tsm-client
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java-modified"
include_recipe "vcredist"

tsm_source_file = File.basename(node['tsm']['extract_source'])
tsm_target_file = win_friendly_path(File.join(Chef::Config[:file_cache_path], tsm_source_file))
install_file = win_friendly_path(File.join(node['tsm']['extract_path'], "IBM Tivoli Storage Manager Client.msi"))
dsm_opt_file = win_friendly_path(File.join(node['tsm']['dsm_opt_extract_path'], "dsm.opt"))

remote_file tsm_target_file do
  source node['tsm']['extract_source']
  backup false
  action :create_if_missing
  notifies :run, 'execute[tsm_unzip_target]', :immediately
end

execute 'tsm_unzip_target' do
  command %Q(#{tsm_target_file} -s -f #{node['tsm']['extract_path']} -e)
  not_if {File.exists?(install_file)}
end

template dsm_opt_file do
  source "dsm.opt.erb"
end

windows_package "IBM Tivoli Storage Manager Client" do
  source install_file 
  options node['tsm']['install_options']
  installer_type :msi
  action :install
end

execute 'tsm_service_create' do
  command %Q(#{node['tsm']['install_dir']}\\dsmcutil.exe install scheduler /name:#{node['tsm']['service']} /node:#{node['hostname']} /password:#{node['tsm']['password']} /validate:yes /clientdir:#{node['tsm']['install_dir']} /optfile:#{node['tsm']['install_dir']}\\dsm.opt /autostart:yes)
  not_if {Win32::Service.exists?(node['tsm']['service'])}
  notifies :start, "service[node['tsm']['service']]", :immediately
end


