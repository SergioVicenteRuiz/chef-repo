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

# Uninstall Symantec Endpoint Protection

execute "Uninstall Symantec Endpoint Protection" do
  command "msiexec /qn /x #{node['symantec']['appid']} /l*v %temp%/uninstall_sep.log"
  notifies :request, 'windows_reboot[60]'
end

windows_reboot 60 do
  reason 'Reboot required for Symantec Endpoint uninstall'
  action :nothing
end

ruby_block "remove symantec-modified::undo from run list" do
  block do
    node.run_list.remove("recipe[symantec-modified::undo]")
  end
end 
