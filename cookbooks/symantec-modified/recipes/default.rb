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
  command %Q(#{disttarget} #{node['symantec']['extract_options']} -o#{node['symantec']['extract_path']})
  not_if {::File.exists?("#installfile")}
end

windows_package "Symantec Endpoint Protection" do
  source installfile 
  options node['symantec']['install_options']
  installer_type :custom
  action :install
end
