#
# Cookbook Name:: symantec
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

# Uninstall Tivoli SCM from server

uninstall_dir = "#{node['tscm']['install_dir']}/_uninst"
uninstall_source = win_friendly_path(File.join(uninstall_dir, "uninstaller.exe"))
uninstall_file = win_friendly_path(File.join(Chef::Config[:file_cache_path], "scm_uninstall.ini"))

template uninstall_file do
  source "scm_uninstall.ini.erb"

execute "Uninstall Tivoli SCM" do
  command %Q(#{uninstall_source} -silent -options #{uninstall_file})
  only_if {File.exists?(uninstall_source)}
end

directory node['tscm']['install_dir'] do
  recursive true
  action :delete
end

ruby_block "remove tivoli-scm::undo from run list" do
  block do
    node.run_list.remove("recipe[tivoli-scm::undo]")
  end
end 
