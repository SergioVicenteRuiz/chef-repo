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


if kernel.machine =~ /x86_64/
  default['java']['windows']['package_name'] = "Java SE Development Kit 7 Update 25 (64-bit)"
  default['java']['windows']['url'] = "http://yum.#{node['domain']}:8080/java/jdk-7u25-windows-x64.exe"
  default['jdk']['appid'] = "{64A3A4F4-B792-11D6-A78A-00B0D0170250}"
  default['jre']['appid'] = "{26A24AE4-039D-4CA4-87B4-2F86417025FF}"
else
  default['java']['windows']['package_name'] = "Java SE Development Kit 7 Update 25"
  default['java']['windows']['url'] = "http://yum.#{node['domain']}:8080/java/jdk-7u25-windows-i586.exe"
  default['jdk']['appid'] = "{32A3A4F4-B792-11D6-A78A-00B0D0170250}"
  default['jre']['appid'] = "{26A24AE4-039D-4CA4-87B4-2F83217025FF}"
end
