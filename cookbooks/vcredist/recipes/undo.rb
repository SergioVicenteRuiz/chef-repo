#
# Cookbook Name:: vcredist
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

# Uninstall Microsoft Visual C++ 2010

execute "Uninstall vcredist_x86" do
  command "msiexec /qn /x #{node['vcredist_x86']['appid']} /l*v %temp%/uninstall_vcredist_x86.log"
end

if node['kernel']['machine'] =~ /x86_64/
  execute "Uninstall vcredist_x64" do
    command "msiexec /qn /x #{node['vcredist_x64']['appid']} /l*v %temp%/uninstall_vcredist_x64.log"
  end
end


ruby_block "remove vcredist::undo from run list" do
  block do
    node.run_list.remove("recipe[vcredist::undo]")
  end
end 
