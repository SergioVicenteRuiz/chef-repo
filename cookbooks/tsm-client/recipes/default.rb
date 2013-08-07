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
dms_opt_file = win_friendly_path(File.join(node['tsm']['dsm_opt_extract_path'], "dsm.opt"))

remote_file tsm_target_file do
  source node['tsm']['extract_source']
  backup false
  action :create_if_missing
  notifies :run, 'execute[tsm_unzip_target]', :immediately
end

execute 'tsm_unzip_target' do
  command %Q(#{tsm_target_file} -s -e -f #{node['tsm']['extract_path']})
  not_if {File.exists?(install_file)}
  notifies :run, 'template[dsm_opt_file]', :immediately
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


