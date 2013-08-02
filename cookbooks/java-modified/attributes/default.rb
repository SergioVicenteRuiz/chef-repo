#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: java
# Attributes:: default
#
# Copyright 2010, Opscode, Inc.
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

default['java']['install_flavor'] = "windows"
default['java']['windows']['url'] = "http://yum.#{node['domain']}:8080/java/jdk-7u25-windows-#{node['kernel']['machine']}.exe"
if kernel.machine =~ /x86_64/
  default['java']['windows']['package_name'] = "Java SE Development Kit 7 Update 25 (64-bit)"
else
  default['java']['windows']['package_name'] = "Java SE Development Kit 7 Update 25"
end
