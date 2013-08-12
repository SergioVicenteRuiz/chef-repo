#
# Cookbook Name:: isec
# Attributes:: default
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

default['isec']['override'] = false

case node['platform_family']
when "rhel", "fedora"
  default['isec']['install_flavor'] = "linux"
when "freebsd"
  default['isec']['install_flavor'] = "linux"
when "arch"
  default['isec']['install_flavor'] = "linux"
when "debian"
  default['isec']['install_flavor'] = "linux"
when "smartos"
  default['isec']['install_flavor'] = "linux"
when "windows"
  default['isec']['install_flavor'] = "windows"
  case platform_version.to_f
    when 6.0, 6.1 # Windows Server 2008
      default['isec']['windows_ver'] = "2008"
    when 6.2 # Windows Server 2012
      default['isec']['windows_ver'] = "2012"
  end
else
  default['isec']['install_flavor'] = "linux"
end
