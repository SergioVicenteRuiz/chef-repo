#
# Cookbook Name:: tsm-client
# Recipe:: undo 
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

# Uninstall IBM Tivoli Storage Manager Client

execute 'tsm_service_delete' do
  command %Q(#{node['tsm']['install_dir']}/dsmcutil.exe remove /name:"#{node['tsm']['service']}")
  only_if {Win32::Service.exists?(node['tsm']['service'])}
end


execute "Uninstall TSM Client" do
  command "msiexec /qn /x #{node['tsm']['appid']} /l*v %temp%/uninstall_tsm.log"
end

directory node['tsm']['install_dir'] do
  recursive true
  action :delete
end

ruby_block "remove tsm-client::undo from run list" do
  block do
    node.run_list.remove("recipe[tsm-client::windows-undo]")
  end
end 
