#
# Cookbook Name:: tivoli-scm
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
jvm_source_file = File.basename(node['tscm']['jvm'])
jvm_target_file = win_friendly_path(File.join(Chef::Config[:file_cache_path], jvm_source_file))
install_ini = win_friendly_path(File.join(Chef::Config[:file_cache_path], "scm_install.ini"))

template install_ini do
  source "scm_install.ini.erb"
end

remote_file jvm_target_file do
  source node['tscm']['jvm']
  backup false
  action :create_if_missing
end

windows_package "IBM Tivoli Security Compliance Manager Client" do
  source node['tscm']['source'] 
  options "-silent -options #{install_ini}"
  installer_type :custom
  action :install
end

#service service_name do
#  action :nothing
#end
