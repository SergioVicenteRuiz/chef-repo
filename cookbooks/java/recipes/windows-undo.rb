#
# Cookbook Name:: java-modified
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

# Uninstall JRE 7 y JDK 1.7

execute "Uninstall JRE" do
  command "msiexec /qn /x #{node['java']['jre']['appid']} /l*v %temp%/uninstall_jre.log"
end

execute "Uninstall JDK" do
  command "msiexec /qn /x #{node['java']['jdk']['appid']} /l*v %temp%/uninstall_jdk.log"
end

ruby_block "remove java::windows-undo from run list" do
  block do
    node.run_list.remove("recipe[java::windows-undo]")
  end
end 
