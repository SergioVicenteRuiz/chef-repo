#
# Cookbook Name:: symantec
# Recipe:: default
#
# Copyright 2012, Eric G. Wolfe
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

symantec_source_file = File.basename(node['symantec']['extract_source'])
symantec_target_file = win_friendly_path(File.join(Chef::Config[:file_cache_path], symantec_source_file))
install_file = win_friendly_path(File.join(node['symantec']['extract_path'], "setup.exe"))

remote_file symantec_target_file do
  source node['symantec']['extract_source']
  backup false
  action :create_if_missing
  notifies :run, 'execute[unzip_target]', :immediately
end

execute 'unzip_target' do
  command %Q(#{symantec_target_file} x -y -o#{node['symantec']['extract_path']})
  not_if {File.exists?(install_file)}
end

windows_reboot 60 do
  reason 'Reboot required for Symantec Endpoint install'
  action :nothing
end

windows_package "Symantec Endpoint Protection" do
  source install_file 
  options node['symantec']['install_options']
  installer_type :custom
  action :install
  notifies :request, 'windows_reboot[60]'
end

