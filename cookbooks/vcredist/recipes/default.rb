#
# Cookbook Name:: vcredist
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

windows_package "Microsoft Visual C++ 2010  x86 Redistributable - 10.0.40219" do
  source node['vcredist_x86']['install_source']
  options node['vcredist_x86']['install_options']
  installer_type :custom
  action :install
end

if node['kernel']['machine'] =~ /x86_64/
  windows_package "Microsoft Visual C++ 2010  x64 Redistributable - 10.0.40219" do
    source node['vcredist_x64']['install_source']
    options node['vcredist_x64']['install_options']
    installer_type :custom
    action :install
  end
end
